__author__ = 'mark'
from .base import Parser
class HouseStateStatus(Parser):
    file_mask = 'hststat'

    @staticmethod
    def table_prototype():
        return {
            'HOUSESTID': None,
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
                INSERT INTO house_state_statuses (id, name)
                VALUES (
                  %(HOUSESTID)s,
                  %(NAME)s
                )
            """, attributes)