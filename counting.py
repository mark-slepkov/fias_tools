#! /usr/bin/env python
__author__ = 'mark'
from parsers import (
    AddressObject,
    AddressObjectType,
    CenterStatus,
    ActualStatus,
    CurrentStatus,
    EstateStatus,
    House,
    HouseInterval,
    HouseStateStatus,
    IntervalStatus,
    Landmark,
    NormativeDocument,
    NormativeDocumentType,
    OperationStatus,
    Room,
    Stead,
    StructureStatus
)
"""
    Этот скрипт я использую для получения информации о структуре таблиц,
    чтобы на ее основе создать SQL запросы для создания таблиц.
"""

if __name__ == '__main__':

    parsers = [
            AddressObject,
            AddressObjectType,
            CenterStatus,
            ActualStatus,
            CurrentStatus,
            EstateStatus,
            House,
            HouseInterval,
            HouseStateStatus,
            IntervalStatus,
            Landmark,
            NormativeDocument,
            NormativeDocumentType,
            OperationStatus,
            Room,
            Stead,
            StructureStatus
    ]

    for parser in parsers:
        print('---------- '+parser.__name__+' scheme ----------')
        print(parser.file_mask)
        parser_obj = parser()
        parser_obj.parse_columns()
        for column, number in parser_obj.table_columns.items():
            print(str(column) + ': '+ str(number))
        print('-------------------------------------')