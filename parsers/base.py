__author__ = 'mark'
import xml.parsers.expat
import sys
from helpers import get_filename_by_basename
import os
import rarfile
import fnmatch
class Parser(object):
    file_mask = None

    def __init__(self, db_connection=None, archive=None):
        file_mask = self.file_mask
        if not archive:
            self.xml_file = open(get_filename_by_basename(os.getcwd() +'/base_xml/', file_mask, fullpath=True), 'rb')
        else:
            rf = rarfile.RarFile(archive)
            for file in rf.infolist():
                if fnmatch.fnmatch(file.filename.lower(), ('as_'+file_mask+'*.xml').lower()):
                    filename = file.filename
                    self.xml_file = rf.open(filename)
        self.db_connection = db_connection
        self.table_columns = {}
        self.cache_counter = 0
        self.parser = xml.parsers.expat.ParserCreate()
        self.parser.CharacterDataHandler = self.handle_char_data
        self.parser.StartElementHandler = self.handle_start_element
        self.parser.EndElementHandler = self.handle_end_element

    def handle_char_data(self, data):
        pass

    def handle_start_element(self, name, attrs):
        pass

    def handle_end_element(self, name):
        pass

    def parse(self):
        self.parser.StartElementHandler = self.handle_start_element
        try:
            self.parser.ParseFile(self.xml_file)
        except Exception as e:
            print("ERROR: Can't open XML file!")
            print(str(e))
            sys.exit(0)


    def count_attributes(self, name, attrs):

        for key, value in attrs.items():
            # print(str(key)+': '+str(value))
            try:
                self.table_columns[key] += 1
            except Exception as e:
                self.table_columns[key] = 1

    def parse_columns(self):
        """
            Подсчитываем количество каждого из аттрибутов в объекте
            (Нужно для построения схемы таблицы)
        """
        self.parser.StartElementHandler = self.count_attributes
        try:
            self.parser.ParseFile(self.xml_file)
        except Exception as e:
            print("ERROR: Can't open XML file!")
            print(str(e))
            sys.exit(0)