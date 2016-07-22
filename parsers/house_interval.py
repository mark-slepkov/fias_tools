__author__ = 'mark'
from .base import Parser
import sys
class HouseInterval(Parser):
    file_mask = 'houseint'

    @staticmethod
    def table_prototype():
        return {
            'HOUSEINTID': None,
            'INTGUID': None,
            'OKTMO': None,
            'IFNSUL': None,
            'OKATO': None,
            'INTSTART': None,
            'INTEND': None,
            'POSTALCODE': None,
            'ENDDATE': None,
            'IFNSFL': None,
            'UPDATEDATE': None,
            'TERRIFNSUL': None,
            'TERRIFNSFL': None,
            'INTSTATUS': None,
            'COUNTER': None,
            'STARTDATE': None,
            'AOGUID': None,
            'NORMDOC': None
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
                INSERT INTO house_intervals (
                  id,
                  intguid,
                  oktmo,
                  ifnsul,
                  okato,
                  intstart,
                  intend,
                  postalcode,
                  enddate,
                  ifnsfl,
                  updatedate,
                  terrifnsul,
                  terrifnsfl,
                  intstatus,
                  counter,
                  startdate,
                  aoguid,
                  normdoc)
                VALUES (
                  %(HOUSEINTID)s,
                  %(INTGUID)s,
                  %(OKTMO)s,
                  %(IFNSUL)s,
                  %(OKATO)s,
                  %(INTSTART)s,
                  %(INTEND)s,
                  %(POSTALCODE)s,
                  %(ENDDATE)s,
                  %(IFNSFL)s,
                  %(UPDATEDATE)s,
                  %(TERRIFNSUL)s,
                  %(TERRIFNSFL)s,
                  %(INTSTATUS)s,
                  %(COUNTER)s,
                  %(STARTDATE)s,
                  %(AOGUID)s,
                  %(NORMDOC)s
                )
            """, attributes)
            if self.cache_counter % 100 == 0:
                self.db_connection.commit()
                sys.stdout.write('  ' + str(self.cache_counter) + ' records complete \r')
            self.cache_counter += 1