__author__ = 'mark'

from .base import Parser

class ActualStatus(Parser):
    file_mask = 'actstat'
    @staticmethod
    def table_prototype():
        pass


