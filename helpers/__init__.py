__author__ = 'mark'
import fnmatch
import os
from datetime import datetime

def singleton(cls):
    instances = {}

    def get_instance():
        if cls not in instances:
            instances[cls] = cls()
        return instances[cls]

    return get_instance


def get_filename_by_basename(directory: str, basename: str, fullpath: bool=False)->str:
    for file in os.listdir(directory):
        if fnmatch.fnmatch(file.lower(), ('as_'+basename+'*.xml').lower()):
            if fullpath:
                return directory + file
            else:
                return file


def date_serializer_handler(obj):
    return obj.isoformat() if hasattr(obj, 'isoformat') else obj


def log(s: str):
    print(str(datetime.now()) + ': ' + s)
