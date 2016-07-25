#!/usr/bin/env python
__author__ = 'mark'
"""
    FIAS is a Federal Information Address System of Russian Federation
"""


import os
here = os.path.abspath(os.path.dirname(__file__))
with open(os.path.join(here, 'README.txt')) as f:
    README = f.read()


from setuptools import setup, find_packages
requires = [
    'psycopg2',
    'wget',
    'requests',
    'rarfile',
    'tornado',
    'observer',
    'python-daemon-3K',

]
dependency_links = [
    'git+https://github.com/mark-slepkov/python-observer.git#egg=observer',
    'git+https://github.com/mark-slepkov/python-daemon.git#egg=python-daemon-3K',

]
setup(name='fias_tools',
      version='0.1',
      description='The tools for automatic conversion and updating FIAS base from XML to SQL',
      long_description=README + '\n\n',
      classifiers=[
        "Programming Language :: Python",
        "Framework :: Tornado",
        "Topic :: Internet :: FIAS",
        ],
      author='Mark Slepkov',
      author_email='self@mark-slepkov.ru',
      url='',
      keywords='fias sql',
      packages=find_packages(),
      include_package_data=True,
      zip_safe=False,
      install_requires=requires,
      dependency_links=dependency_links,
      )