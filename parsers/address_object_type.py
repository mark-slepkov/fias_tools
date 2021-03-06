__author__ = 'mark'

from .base import Parser


class AddressObjectType(Parser):
    file_mask = 'socrbase'

    @staticmethod
    def table_prototype():
        return {
            'KOD_T_ST': None,
            'SCNAME': None,
            'LEVEL': None,
            'SOCRNAME': None
        }

    def handle_start_element(self, name, attrs, *args, **kwargs):
        if attrs == {}:
            return
        attributes = self.table_prototype()
        attributes.update(attrs)
        with self.db_connection.cursor() as cursor:
            cursor.execute("""
                INSERT INTO address_object_types (
                  id, scname, level, socrname
                )
                VALUES (
                  %(KOD_T_ST)s,
                  %(SCNAME)s,
                  %(LEVEL)s,
                  %(SOCRNAME)s
                )
            """, attributes)

