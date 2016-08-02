__author__ = 'mark'
from .base import Parser
import sys
from helpers import log
class Room(Parser):
    file_mask = 'room'

    @staticmethod
    def table_prototype():
        return {
            'ROOMID': None,
            'HOUSEGUID': None,
            'REGIONCODE': None,
            'CADNUM': None,
            'ROOMGUID': None,
            'OPERSTATUS': None,
            'ROOMTYPE': None,
            'POSTALCODE': None,
            'FLATNUMBER': None,
            'UPDATEDATE': None,
            'ROOMCADNUM': None,
            'NEXTID': None,
            'LIVESTATUS': None,
            'PREVID': None,
            'ROOMNUMBER': None,
            'ENDDATE': None,
            'STARTDATE': None,
            'NORMDOC': None,
            'FLATTYPE': None
        }

    def handle_start_element(self, name, attrs, *args, **kwargs):
        if attrs == {}:
            return
        attributes = self.table_prototype()
        attributes.update(attrs)

        with self.db_connection.cursor() as cursor:
            # log(str(attributes))
            cursor.execute("""
                INSERT INTO rooms (
                    id,
                    houseguid,
                    regioncode,
                    cadnum,
                    roomguid,
                    operstatus,
                    roomtype,
                    postalcode,
                    flatnumber,
                    updatedate,
                    roomcadnum,
                    nextid,
                    livestatus,
                    previd,
                    roomnumber,
                    enddate,
                    startdate,
                    normdoc,
                    flattype)
                VALUES (
                    %(ROOMID)s,
                    %(HOUSEGUID)s,
                    %(REGIONCODE)s,
                    %(CADNUM)s,
                    %(ROOMGUID)s,
                    %(OPERSTATUS)s,
                    %(ROOMTYPE)s,
                    %(POSTALCODE)s,
                    %(FLATNUMBER)s,
                    %(UPDATEDATE)s,
                    %(ROOMCADNUM)s,
                    %(NEXTID)s,
                    %(LIVESTATUS)s,
                    %(PREVID)s,
                    %(ROOMNUMBER)s,
                    %(ENDDATE)s,
                    %(STARTDATE)s,
                    %(NORMDOC)s,
                    %(FLATTYPE)s
                )
            """, attributes)
