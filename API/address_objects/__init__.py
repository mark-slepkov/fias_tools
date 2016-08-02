__author__ = 'mark'
from tornado.web import RequestHandler
from .collections import AddressObjects
import json
from helpers import date_serializer_handler


class ViewAddressObjects(RequestHandler):

    def initialize(self, db_connection=None):
        self.db_connection = db_connection

    def get(self, *args, **kwargs):
        # self.write('asdfas')
        try:
            # self.write(str(self.request))
            # self.write(str(args))
            # self.write(str(kwargs))
            parentguid = self.get_query_argument('parentguid', default=None)
            level = self.get_query_argument('level', default=None)
            address_objects = AddressObjects(self.db_connection)
            items = address_objects.fetch(parentguid, level).data
            result = json.dumps(
                {'items': items},
                default=date_serializer_handler,
                indent=4
            )
            self.set_header('content-type', 'application/json')
            self.write(result)
        except Exception as e:
            self.write('Exception: ' + str(e))


class ViewAddressObject(RequestHandler):

    def get(self, *args, **kwargs):
        self.write({})