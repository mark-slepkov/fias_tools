__author__ = 'mark'
from .base import Parser
import sys
class NormativeDocument(Parser):
    file_mask = 'normdoc'

    @staticmethod
    def table_prototype():
        return {
            'NORMDOCID': None,
            'DOCDATE': None,
            'DOCNUM': None,
            'DOCTYPE': None,
            'DOCNAME': None,
            'DOCIMGID': None,
        }

    def handle_start_element(self, name, attrs, *args, **kwargs):
        # print('#########################################')
        # print('Handle start element: '+ str(name))
        if attrs == {}:
            return
        attributes = self.table_prototype()
        attributes.update(attrs)

        with self.db_connection.cursor() as cursor:
            cursor.execute("""
                INSERT INTO normative_documents (id, docdate, docnum, doctype, docname, docimgid)
                VALUES (
                  %(NORMDOCID)s,
                  %(DOCDATE)s,
                  %(DOCNUM)s,
                  %(DOCTYPE)s,
                  %(DOCNAME)s,
                  %(DOCIMGID)s
                )
            """, attributes)
        if self.cache_counter % 100 == 0:
            self.db_connection.commit()
            sys.stdout.write(str(self.cache_counter) + ' records complete \r')
        self.cache_counter += 1