__author__ = 'mark'

from .base import Parser

class CurrentStatus(Parser):
    file_mask = 'curentst'

    @staticmethod
    def table_prototype():
        pass