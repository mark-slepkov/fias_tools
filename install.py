#! /usr/bin/env python3
__author__ = 'mark'
import sys
import os
from parsers import AddressObject
from preparing import *
from config import Config
import psycopg2
from psycopg2.extras import DictCursor
config = Config()
from datetime import datetime
config.load_config()
pg_conf = config['pg_database']
# print(unrar('fias_xml.rar'))




if __name__ == '__main__':
    from optparse import OptionParser


    parser = OptionParser(usage="Usage: %prog [options] db_name")
    parser.add_option("-s", "--host", dest="host",
                      help="Connection host", metavar="HOST", default=pg_conf['host'])
    parser.add_option("-o", "--port", dest="port",
                      help="Connection port", metavar="PORT", type='int', default=pg_conf['port'])
    parser.add_option("-l", "--login", dest="login",
                      help="Login", metavar="LOGIN", default=pg_conf['login'])
    parser.add_option("-p", "--password", dest="password",
                      help="Password", metavar="PASSWORD", default=pg_conf['password'])

    (options, args) = parser.parse_args()
    print(options, args)
    try:
        db_name = args[0]
    except IndexError:
        db_name = pg_conf['db_name']
    print('running...')
    db_conn = psycopg2.connect(
        host=options.host,
        port=options.port,
        user=options.login,
        password=options.password,
        database=db_name,
        cursor_factory=DictCursor
    )
    addr_parser = AddressObject(os.getcwd() + '/base_xml/AS_ADDROBJ_20160717_3ce5c848-04ab-4e6a-a3fc-a748674e5583.XML', db_connection=db_conn)
    print(datetime.now())
    # addr_parser.parse()
    db_conn.commit()
    print(datetime.now())
    print('========== AddrObj was successfully loaded to database ==========')


