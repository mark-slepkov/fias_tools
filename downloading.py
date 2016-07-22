#! /usr/bin/env python
__author__ = 'mark'
import wget
import requests

def update_download(force=False):
    r = requests.get('http://fias.nalog.ru/Public/Downloads/Actual/VerDate.txt')
    actual_date = r.content.decode()
    last_download = open('last_download.txt', 'r+')
    if (actual_date != last_download.read()) or force:
        print('do something')
        last_download.write(actual_date)

def actual_base_download(url):
    r = requests.get('http://fias.nalog.ru/Public/Downloads/Actual/VerDate.txt')
    actual_date = r.content.decode()
    wget.download(url)
    last_download = open('last_download.txt', 'r+')
    last_download.write(actual_date)

if __name__ == '__main__':
    from optparse import OptionParser
    parser = OptionParser(usage="Usage: %prog http_link_to_xml_rar_archive")
    (options, args) = parser.parse_args()
    try:
        base_url = args[0]
    except Exception as e:
        base_url = 'http://fias.nalog.ru/Public/Downloads/Actual/fias_xml.rar'
    actual_base_download(base_url)

