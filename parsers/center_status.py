__author__ = 'mark'

from .base import Parser

class CenterStatus(Parser):
    file_mask = 'centerst'

    @staticmethod
    def table_prototype():
        return {
            'CENTERSTID': None,
            'NAME': None
        }

    def handle_start_element(self, name, attrs, *args, **kwargs):
        # print('#########################################')
        print('Handle start element: '+ str(name))
        print(attrs)
        if attrs == {}:
            return
        attributes = self.table_prototype()
        attributes.update(attrs)

        with self.db_connection.cursor() as cursor:
            cursor.execute("""
                INSERT INTO center_statuses (id, name)
                VALUES (
                  %(CENTERSTID)s,
                  %(NAME)s
                )
            """, attributes)
