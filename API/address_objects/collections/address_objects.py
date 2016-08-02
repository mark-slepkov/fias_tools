__author__ = 'mark'
from psycopg2.extensions import connection


class AddressObjects(object):

    def __init__(self, db_connection: connection):
        self.db_connection = db_connection
        self.data = []

    def fetch(self, parentguid: str=None, level=1):
        with self.db_connection.cursor() as cursor:
            cursor.execute("""
                SELECT id, aoguid, aolevel, formalname, shortname, postalcode FROM address_objects
                WHERE
                  (actstatus = 1)
                  AND
                    CASE
                      WHEN (%(level)s IS NOT NULL)
                      THEN aolevel=%(level)s
                      ELSE TRUE
                    END
                  AND
                    CASE
                      WHEN (%(parentguid)s IS NULL)
                      THEN (parentguid is NULL)
                      WHEN (%(parentguid)s = '')
                      THEN (parentguid is NULL)
                      ELSE (parentguid = %(parentguid)s)
                    END
                  ;
                """,
                {
                    'parentguid': parentguid,
                    'level': level
                })
            result = cursor.fetchall()
            for item in result:
                dict_item = dict(item)
                dict_item['type'] = 'location'
                self.data.append(dict_item)
        if len(result) == 0:
            return self.fetch_houses(parentguid)
        return self

    def fetch_houses(self, aoguid):
        with self.db_connection.cursor() as cursor:
            cursor.execute("""
                SELECT id, houseguid as aoguid, housenum
                FROM houses
                WHERE (aoguid = %(aoguid)s)
            """, {
                'aoguid': aoguid
            })
            result = cursor.fetchall()
            for item in result:
                dict_item = dict(item)
                dict_item['type'] = 'house'
                self.data.append(dict_item)
        return self

    def fetch_flats(self, houseguid):
        with self.db_connection.cursor() as cursor:
            cursor.execute("""
                SELECT id, houseguid, flatnumber, flattype
                FROM rooms
                WHERE (houseguid = %(houseguid)s)
            """, {
                'houseguid': houseguid
            })
            result = cursor.fetchall()
            for item in result:
                dict_item = dict(item)
                dict_item['type'] = 'flat'
                self.data.append(dict_item)
        return self