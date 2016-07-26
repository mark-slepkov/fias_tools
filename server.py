__author__ = 'mark'
import tornado.web
import tornado.ioloop
import signal
from config import Config
from API.address_objects import AddressObjects
import threading
import json
import download
import psycopg2
from datetime import datetime
from psycopg2.extras import DictCursor
from parsers import (
    AddressObject,
    CenterStatus,
    CurrentStatus,
    OperationStatus,
    ActualStatus,
    AddressObjectType,
    IntervalStatus,
    StructureStatus,
    HouseStateStatus,
    EstateStatus,
    NormativeDocumentType,
    NormativeDocument,
    Room,
    Stead,
    Landmark,
    HouseInterval,
    House
)
state = {'download': None, 'install': {}}
current_parser = None
config = Config()
pg_conf = config['pg_database']
from scheme import create_scheme


class State(tornado.web.RequestHandler):

    def get(self, *args, **kwargs):
        try:
            # print(state)
            self.write('<pre>')
            self.write(json.dumps(state, indent=4, sort_keys=True))
            self.write('<pre>')
        except Exception as e:
            pass


class ServerApp(object):

    def __init__(self, port, options):
        self.port = port
        self.options = options
        self.stdin_path = '/dev/null'
        self.stdout_path = './log.txt'
        self.stderr_path = './errors.txt'
        self.pidfile_path = '/tmp/fias_tools.pid'
        self.pidfile_timeout = 5
        self.io_loop = None
        self.db_conn = psycopg2.connect(
            host=pg_conf['host'],
            port=pg_conf['port'],
            user=pg_conf['login'],
            password=pg_conf['password'],
            database=pg_conf['db_name'],
            cursor_factory=DictCursor
        )
        self.coroutine = None

    def run(self):
        handlers = (
                        (r'/REST/_address_objects', AddressObjects),
                        (r'/REST/_state', State),
                    )
        self.coroutine = AdditionTasks(options=self.options.copy())
        self.coroutine.start()
        application = tornado.web.Application(handlers)
        application.listen(self.port, '0.0.0.0')
        signal.signal(signal.SIGTERM, self.stop)
        self.io_loop = tornado.ioloop.IOLoop.instance()
        self.io_loop.start()

    def stop(self, signum, frame):
        self.coroutine.stop()
        self.io_loop.stop()


class AdditionTasks(threading.Thread):

    def __init__(self, options=None, **kwargs):
        super().__init__(**kwargs)
        self.options = options

    def run(self):

        if self.options['download']:
            self.download_base()
        if self.options['install']:
            self.install_base()

    @staticmethod
    def download_base():
        state['download'] = 'started'
        download.actual_base_download()
        state['download'] = 'complete'

    def install_base(self):
        db_conn = psycopg2.connect(
            host=pg_conf['host'],
            port=pg_conf['port'],
            user=pg_conf['login'],
            password=pg_conf['password'],
            database=pg_conf['db_name'],
            cursor_factory=DictCursor
        )
        create_scheme(db_conn, self.options['current_folder']+'/scheme/scheme.sql')
        parsers = [
            # AddressObjectType,
            # CenterStatus,
            # CurrentStatus,
            # OperationStatus,
            # ActualStatus,
            # IntervalStatus,
            # StructureStatus,
            # HouseStateStatus,
            # EstateStatus,
            # NormativeDocumentType,
            # NormativeDocument,
            AddressObject,
            Room,
            Stead,
            Landmark,
            HouseInterval,
            House
        ]

        for parser in parsers:
            obj_parser = parser(db_connection=db_conn, archive=self.options['current_folder']+'/fias_xml.rar')
            obj_parser.on('start_element:handled', change_state)
            state['install'][parser.__name__] = {
                'status': 'started',
                'started_at': str(datetime.now()),
                'stopped_at': None,
                'records_added': obj_parser.records_counter
            }
            try:
                obj_parser.parse()
            except Exception as e:
                state['install'][parser.__name__].update({
                        'status': 'failed',
                        'reason': str(e),
                        'stopped_at': str(datetime.now()),
                        'records_added': obj_parser.records_counter
                    })
            db_conn.commit()
            state['install'][parser.__name__].update({
                'status': 'complete',
                'stopped_at': str(datetime.now()),
                'records_added': obj_parser.records_counter
            })


def change_state(parser):
    state['install'][parser.__class__.__name__].update({
        'records_added': parser.records_counter
    })
