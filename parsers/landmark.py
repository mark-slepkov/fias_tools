__author__ = 'mark'
from .base import Parser
import sys
class Landmark(Parser):
    file_mask = 'landmark'

    @staticmethod
    def table_prototype():
        return {
            'LANDID': None,
            'LOCATION': None,
            'REGIONCODE': None,
            'CADNUM': None,
            'OKATO': None,
            'OKTMO': None,
            'ENDDATE': None,
            'IFNSFL': None,
            'UPDATEDATE': None,
            'POSTALCODE': None,
            'TERRIFNSUL': None,
            'IFNSUL': None,
            'TERRIFNSFL': None,
            'LANDGUID': None,
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
                INSERT INTO landmarks (id, location, regioncode, cadnum,
                                       okato, oktmo, enddate, ifnsfl, updatedate,
                                       postalcode, terrifnsul, ifnsul, terrifnsfl,
                                       landguid, startdate, aoguid, normdoc)
                VALUES (
                  %(LANDID)s,
                  %(LOCATION)s,
                  %(REGIONCODE)s,
                  %(CADNUM)s,
                  %(OKATO)s,
                  %(OKTMO)s,
                  %(ENDDATE)s,
                  %(IFNSFL)s,
                  %(UPDATEDATE)s,
                  %(POSTALCODE)s,
                  %(TERRIFNSUL)s,
                  %(IFNSUL)s,
                  %(TERRIFNSFL)s,
                  %(LANDGUID)s,
                  %(STARTDATE)s,
                  %(AOGUID)s,
                  %(NORMDOC)s
                )
            """, attributes)
            if self.cache_counter % 100 == 0:
                self.db_connection.commit()
                sys.stdout.write('  ' + str(self.cache_counter) + ' records complete \r')
            self.cache_counter += 1
            self.records_counter += 1