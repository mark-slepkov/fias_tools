__author__ = 'mark'
from .base import Parser
class IntervalStatus(Parser):
    file_mask = 'intvstat'

    @staticmethod
    def table_prototype():
        return {
            'INTVSTATID': None,
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
                INSERT INTO interval_statuses (id, name)
                VALUES (
                  %(INTVSTATID)s,
                  %(NAME)s
                )
            """, attributes)
