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
                self.data.append(dict(item))
        return self