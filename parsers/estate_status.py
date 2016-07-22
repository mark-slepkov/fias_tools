__author__ = 'mark'
from .base import Parser
class EstateStatus(Parser):
    file_mask = 'eststat'

    @staticmethod
    def table_prototype():
        return {
            'ESTSTATID': None,
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
                INSERT INTO estate_statuses (id, name)
                VALUES (
                  %(ESTSTATID)s,
                  %(NAME)s
                )
            """, attributes)