__author__ = 'mark'

from .base import Parser

class CurrentStatus(Parser):
    file_mask = 'curentst'

    @staticmethod
    def table_prototype():
        return {
            'CURENTSTID': None,
            'NAME': None
        }

    def handle_start_element(self, name, attrs, *args, **kwargs):
        if attrs == {}:
            return
        attributes = self.table_prototype()
        attributes.update(attrs)

        with self.db_connection.cursor() as cursor:
            cursor.execute("""
                INSERT INTO current_statuses (id, name)
                VALUES (
                  %(CURENTSTID)s,
                  %(NAME)s
                )
            """, attributes)
