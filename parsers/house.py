__author__ = 'mark'
from .base import Parser
import sys
class House(Parser):
    file_mask = 'house_'
    @staticmethod
    def table_prototype():
        return {
            'HOUSEID': None,
            'HOUSEGUID': None,
            'ESTSTATUS': None,
            'OKTMO': None,
            'STATESTATUS': None,
            'IFNSUL': None,
            'OKATO': None,
            'POSTALCODE': None,
            'REGIONCODE': None,
            'HOUSENUM': None,
            'IFNSFL': None,
            'UPDATEDATE': None,
            'TERRIFNSUL': None,
            'COUNTER': None,
            'BUILDNUM': None,
            'STRUCNUM': None,
            'TERRIFNSFL': None,
            'STARTDATE': None,
            'ENDDATE': None,
            'STRSTATUS': None,
            'AOGUID': None,
            'NORMDOC': None,
            'CADNUM': None,
            'DIVTYPE': None
        }

    def handle_start_element(self, name, attrs, *args, **kwargs):
        # print('#########################################')
        print('Handle start element: '+ str(name))
        print(str(attrs))
        if attrs == {}:
            return
        attributes = self.table_prototype()
        attributes.update(attrs)

        with self.db_connection.cursor() as cursor:
            cursor.execute("""
                INSERT INTO houses (
                  id,
                  houseguid,
                  eststatus,
                  oktmo,
                  statestatus,
                  ifnsul,
                  okato,
                  postalcode,
                  regioncode,
                  housenum,
                  ifnsfl,
                  updatedate,
                  terrifnsul,
                  counter,
                  buildnum,
                  strucnum,
                  terrifnsfl,
                  startdate,
                  enddate,
                  strstatus,
                  aoguid,
                  normdoc,
                  cadnum,
                  divtype)
                VALUES (
                  %(HOUSEID)s,
                  %(HOUSEGUID)s,
                  %(ESTSTATUS)s,
                  %(OKTMO)s,
                  %(STATESTATUS)s,
                  %(IFNSUL)s,
                  %(OKATO)s,
                  %(POSTALCODE)s,
                  %(REGIONCODE)s,
                  %(HOUSENUM)s,
                  %(IFNSFL)s,
                  %(UPDATEDATE)s,
                  %(TERRIFNSUL)s,
                  %(COUNTER)s,
                  %(BUILDNUM)s,
                  %(STRUCNUM)s,
                  %(TERRIFNSFL)s,
                  %(STARTDATE)s,
                  %(ENDDATE)s,
                  %(STRSTATUS)s,
                  %(AOGUID)s,
                  %(NORMDOC)s,
                  %(CADNUM)s,
                  %(DIVTYPE)s
                )
            """, attributes)
            if self.cache_counter % 100 == 0:
                self.db_connection.commit()
                sys.stdout.write('  ' + str(self.cache_counter) + ' records complete \r')
            self.cache_counter += 1
            self.records_counter += 1