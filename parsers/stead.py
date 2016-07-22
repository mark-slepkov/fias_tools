__author__ = 'mark'
from .base import Parser
import sys
class Stead(Parser):
    file_mask = 'stead'

    @staticmethod
    def table_prototype():
        return {
            'STEADID': None,
            'REGIONCODE': None,
            'OKTMO': None,
            'IFNSUL': None,
            'UPDATEDATE': None,
            'IFNSFL': None,
            'NUMBER': None,
            'NEXTID': None,
            'LIVESTATUS': None,
            'DIVTYPE': None,
            'PARENTGUID': None,
            'TERRIFNSFL': None,
            'ENDDATE': None,
            'CADNUM': None,
            'NORMDOC': None,
            'OKATO': None,
            'OPERSTATUS': None,
            'POSTALCODE': None,
            'TERRIFNSUL': None,
            'STEADGUID': None,
            'PREVID': None,
            'STARTDATE': None
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
                INSERT INTO stead (
                    id,
                    regioncode,
                    oktmo,
                    ifnsul,
                    updatedate,
                    ifnsfl,
                    number,
                    nextid,
                    livestatus,
                    divtype,
                    parentguid,
                    terrifnsfl,
                    enddate,
                    cadnum,
                    normdoc,
                    okato,
                    operstatus,
                    postalcode,
                    terrifnsul,
                    steadguid,
                    previd,
                    startdate)
                VALUES (
                    %(STEADID)s,
                    %(REGIONCODE)s,
                    %(OKTMO)s,
                    %(IFNSUL)s,
                    %(UPDATEDATE)s,
                    %(IFNSFL)s,
                    %(NUMBER)s,
                    %(NEXTID)s,
                    %(LIVESTATUS)s,
                    %(DIVTYPE)s,
                    %(PARENTGUID)s,
                    %(TERRIFNSFL)s,
                    %(ENDDATE)s,
                    %(CADNUM)s,
                    %(NORMDOC)s,
                    %(OKATO)s,
                    %(OPERSTATUS)s,
                    %(POSTALCODE)s,
                    %(TERRIFNSUL)s,
                    %(STEADGUID)s,
                    %(PREVID)s,
                    %(STARTDATE)s
                )
            """, attributes)
            if self.cache_counter % 100 == 0:
                self.db_connection.commit()
                sys.stdout.write('  ' + str(self.cache_counter) + ' records complete \r')
            self.cache_counter += 1