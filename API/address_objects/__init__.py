__author__ = 'mark'
from tornado.web import RequestHandler


class AddressObjects(RequestHandler):

    def get(self, *args, **kwargs):
        self.write({})

class AddressObject(RequestHandler):

    def get(self, *args, **kwargs):
        self.write({})