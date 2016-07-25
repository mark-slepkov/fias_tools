__author__ = 'mark'
from .base import Parser
class OperationStatus(Parser):
    file_mask = 'operstat'

    @staticmethod
    def table_prototype():
        return {
            'OPERSTATID': None,
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
                INSERT INTO operation_statuses (id, name)
                VALUES (
                  %(OPERSTATID)s,
                  %(NAME)s
                )
            """, attributes)
            self.records_counter += 1
