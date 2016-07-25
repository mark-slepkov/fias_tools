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
        # print('#########################################')
        # print('Handle start element: '+ str(name))
        if attrs == {}:
            return
        attributes = self.table_prototype()
        attributes.update(attrs)
        try:
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
                self.records_counter += 1
        except Exception as e:
            print('fucking exception')
            print(e)
