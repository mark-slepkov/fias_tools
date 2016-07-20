__author__ = 'mark'

from .base import Parser

class CenterStatus(Parser):
    file_mask = 'centerst'
    @staticmethod
    def table_prototype():
        pass