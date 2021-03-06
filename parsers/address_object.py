__author__ = 'mark'
from .base import Parser
import sys
class AddressObject(Parser):
    file_mask = 'addrobj'
    @staticmethod
    def table_prototype():
        return {
            'PLACECODE': None,
            'POSTALCODE': None,
            'EXTRCODE': None,
            'AOGUID': None,
            'SEXTCODE': None,
            'TERRIFNSFL': None,
            'PREVID': None,
            'AOID': None,
            'CTARCODE': None,
            'PLAINCODE': None,
            'OKTMO': None,
            'SHORTNAME': None,
            'FORMALNAME': None,
            'CURRSTATUS': None,
            'NEXTID': None,
            'ENDDATE': None,
            'STREETCODE': None,
            'IFNSUL': None,
            'REGIONCODE': None,
            'CENTSTATUS': None,
            'UPDATEDATE': None,
            'AUTOCODE': None,
            'STARTDATE': None,
            'AOLEVEL': None,
            'OPERSTATUS': None,
            'CITYCODE': None,
            'NORMDOC': None,
            'ACTSTATUS': None,
            'IFNSFL': None,
            'LIVESTATUS': None,
            'AREACODE': None,
            'PARENTGUID': None,
            'CODE': None,
            'OFFNAME': None,
            'OKATO': None,
            'TERRIFNSUL': None
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
                INSERT INTO address_objects (
                    id,
                    placecode,
                    postalcode,
                    extrcode,
                    aoguid,
                    sextcode,
                    terrifnsfl,
                    previd,
                    ctarcode,
                    plaincode,
                    oktmo,
                    shortname,
                    formalname,
                    currstatus,
                    nextid,
                    enddate,
                    streetcode,
                    ifnsul,
                    regioncode,
                    centstatus,
                    updatedate,
                    autocode,
                    startdate,
                    aolevel,
                    operstatus,
                    citycode,
                    normdoc,
                    actstatus,
                    ifnsfl,
                    livestatus,
                    areacode,
                    parentguid,
                    code,
                    offname,
                    okato,
                    terrifnsul
                    )
                VALUES (
                    %(AOID)s,
                    %(PLACECODE)s,
                    %(POSTALCODE)s,
                    %(EXTRCODE)s,
                    %(AOGUID)s,
                    %(SEXTCODE)s,
                    %(TERRIFNSFL)s,
                    %(PREVID)s,
                    %(CTARCODE)s,
                    %(PLAINCODE)s,
                    %(OKTMO)s,
                    %(SHORTNAME)s,
                    %(FORMALNAME)s,
                    %(CURRSTATUS)s,
                    %(NEXTID)s,
                    %(ENDDATE)s,
                    %(STREETCODE)s,
                    %(IFNSUL)s,
                    %(REGIONCODE)s,
                    %(CENTSTATUS)s,
                    %(UPDATEDATE)s,
                    %(AUTOCODE)s,
                    %(STARTDATE)s,
                    %(AOLEVEL)s,
                    %(OPERSTATUS)s,
                    %(CITYCODE)s,
                    %(NORMDOC)s,
                    %(ACTSTATUS)s,
                    %(IFNSFL)s,
                    %(LIVESTATUS)s,
                    %(AREACODE)s,
                    %(PARENTGUID)s,
                    %(CODE)s,
                    %(OFFNAME)s,
                    %(OKATO)s,
                    %(TERRIFNSUL)s
                )
            """, attributes)


