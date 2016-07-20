__author__ = 'mark'
from helpers import singleton
import json


@singleton
class Config(dict):

    # def __init__(self, *args, **kwargs):
    #     super().__init__(*args, **kwargs)
    #     config_file = open('config.json')
    #     config = json.load(config_file)
    #     self.update(config)

    def load_config(self, filename='config.json'):
        config_file = open(filename)
        config = json.load(config_file)
        self.update(config)
