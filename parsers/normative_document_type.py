__author__ = 'mark'
from .base import Parser
class NormativeDocumentType(Parser):
    file_mask = 'ndoctype'

    @staticmethod
    def table_prototype():
        return {
            'NDTYPEID': None,
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
                INSERT INTO normative_document_types (id, name)
                VALUES (
                  %(NDTYPEID)s,
                  %(NAME)s
                )
            """, attributes)
            self.records_counter += 1
