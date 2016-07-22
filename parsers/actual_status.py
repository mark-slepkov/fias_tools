__author__ = 'mark'

from .base import Parser

class ActualStatus(Parser):
    file_mask = 'actstat'
    @staticmethod
    def table_prototype():
        return {
            'ACTSTATID': None,
            'NAME': None
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
                INSERT INTO actual_statuses (id, name)
                VALUES (
                  %(ACTSTATID)s,
                  %(NAME)s
                )
            """, attributes)



