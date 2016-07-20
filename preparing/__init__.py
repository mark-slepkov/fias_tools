__author__ = 'mark'
import subprocess

def download(uri):

    pass

def unrar(file_path):
    bash_command = "unrar x %s base_xml/" % (file_path,)
    process = subprocess.Popen(bash_command.split(), stdout=subprocess.PIPE)
    output = process.communicate()[0]
    return output


def create_tables(db_connection):
    pass