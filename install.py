#! /usr/bin/env python3
__author__ = 'mark'
import sys
import os
from parsers import (
    AddressObject,
    CenterStatus,
    CurrentStatus,
    OperationStatus,
    ActualStatus,
    AddressObjectType,
    IntervalStatus,
    StructureStatus,
    HouseStateStatus,
    EstateStatus,
    NormativeDocumentType,
    NormativeDocument,
    Room,
    Stead,
    Landmark,
    HouseInterval,
    House
)
from preparing import *
from config import Config
import psycopg2
from psycopg2.extras import DictCursor
config = Config()
from datetime import datetime
config.load_config()
pg_conf = config['pg_database']
# print(unrar('fias_xml.rar'))




if __name__ == '__main__':
    from optparse import OptionParser


    parser = OptionParser(usage="Usage: %prog [options] db_name")
    parser.add_option("-s", "--host", dest="host",
                      help="Connection host", metavar="HOST", default=pg_conf['host'])
    parser.add_option("-o", "--port", dest="port",
                      help="Connection port", metavar="PORT", type='int', default=pg_conf['port'])
    parser.add_option("-l", "--login", dest="login",
                      help="Login", metavar="LOGIN", default=pg_conf['login'])
    parser.add_option("-p", "--password", dest="password",
                      help="Password", metavar="PASSWORD", default=pg_conf['password'])

    (options, args) = parser.parse_args()
    print(options, args)
    try:
        db_name = args[0]
    except IndexError:
        db_name = pg_conf['db_name']
    print('running...')
    db_conn = psycopg2.connect(
        host=options.host,
        port=options.port,
        user=options.login,
        password=options.password,
        database=db_name,
        cursor_factory=DictCursor
    )
    parsers = [
        AddressObjectType,
        CenterStatus,
        CurrentStatus,
        OperationStatus,
        ActualStatus,
        IntervalStatus,
        StructureStatus,
        HouseStateStatus,
        EstateStatus,
        NormativeDocumentType,
        NormativeDocument,
        AddressObject,
        Room,
        Stead,
        Landmark,
        HouseInterval,
        House
    ]
    db_conn.commit()
    for parser in parsers:
        obj_parser = parser(db_connection=db_conn, archive='fias_xml.rar')
        print('========== '+parser.__name__+' loading to database ==========')
        print(datetime.now())
        obj_parser.parse()
        db_conn.commit()
        print(datetime.now())
        print('========== '+parser.__name__+' was successfully loaded to database ==========')


