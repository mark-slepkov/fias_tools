#! /usr/bin/env python
__author__ = 'mark'

import rarfile

with rarfile.RarFile('fias_xml.rar') as rf:
    rf.extractall('./base_2_xml/')
