#! /usr/bin/env python
__author__ = 'mark'
import wget
import requests

def update_download(force=False):
    r = requests.get('http://fias.nalog.ru/Public/Downloads/Actual/VerDate.txt')
    actual_date = r.content.decode()
    last_download = open('last_download.txt', 'r+')
    if actual_date != last_download.read():
        print('do something')
        last_download.write(actual_date)

def actual_base_download():
    r = requests.get('http://fias.nalog.ru/Public/Downloads/Actual/VerDate.txt')
    actual_date = r.content.decode()
    print('do something')
    wget.download('http://fias.nalog.ru/Public/Downloads/Actual/VerDate.txt')


if __name__ == '__main__':
    from optparse import OptionParser


