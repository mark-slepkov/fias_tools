__author__ = 'mark'
import xml.parsers.expat
import sys
from helpers import get_filename_by_basename
import os
import rarfile
import fnmatch

from observer import observer


@observer
class Parser(object):
    file_mask = None

    def __init__(self, db_connection=None, archive=None):
        file_mask = self.file_mask
        if not archive:
            self.xml_file = open(get_filename_by_basename(os.getcwd() +'/base_xml/', file_mask, fullpath=True), 'rb')
        else:
            rf = rarfile.RarFile(archive)
            # print(rf)
            for file in rf.infolist():
                if fnmatch.fnmatch(file.filename.lower(), ('as_'+file_mask+'*.xml').lower()):
                    # print(file.filename)
                    filename = file.filename
                    self.xml_file = rf.open(filename)
        self.db_connection = db_connection
        self.table_columns = {}
        self.cache_counter = 0
        self.records_counter = 0
        self.parser = xml.parsers.expat.ParserCreate()
        self.parser.CharacterDataHandler = self.wrapper_char_data
        self.parser.StartElementHandler = self.wrapper_start_element
        self.parser.EndElementHandler = self.wrapper_end_element

    def wrapper_char_data(self, data):
        response = self.handle_char_data(data)
        self.trigger('char_data:handled', self)
        return response

    def handle_char_data(self, data):
        pass

    def wrapper_start_element(self, name, attrs):
        print('start_element')
        response = self.handle_start_element(name, attrs)

        self.trigger('start_element:handled', self)

        return response

    def handle_start_element(self, name, attrs):
        pass

    def wrapper_end_element(self, name):
        response = self.handle_end_element(name)
        self.trigger('end_element:handled', self)
        return response

    def handle_end_element(self, name):
        pass

    def parse(self):
        self.parser.StartElementHandler = self.wrapper_start_element
        try:
            print(self.xml_file)
            self.parser.ParseFile(self.xml_file)
        except Exception as e:
            print("ERROR: Can't open XML file!")
            print(str(e))

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