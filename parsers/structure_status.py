__author__ = 'mark'
from .base import Parser
class StructureStatus(Parser):
    file_mask = 'strstat'

    @staticmethod
    def table_prototype():
        return {
            'STRSTATID': None,
            'SHORTNAME': None,
            'NAME': None
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
                INSERT INTO structure_statuses (id, shortname, name)
                VALUES (
                  %(STRSTATID)s,
                  %(SHORTNAME)s,
                  %(NAME)s
                )
            """, attributes)
            self.records_counter += 1