#! /usr/bin/env python
__author__ = 'mark'
from optparse import OptionParser
from daemon import runner
from config import Config
import os
from server import ServerApp

if __name__ == '__main__':
    parser = OptionParser()
    config = Config()
    config.load_config()
    parser.add_option("-p", "--port", dest="port",
                      help="connection port", metavar="PORT", default=config['port'])
    parser.add_option("-d", "--download", dest="download",
                      help="automatic downloading FIAS base after launching the server", action="store_true", default=False)
    parser.add_option("-i", "--install", dest="install",
                      help="automatic installing downloaded FIAS base after launching the server", action="store_true", default=False)
    (options, args) = parser.parse_args()
    port = options.port
    print(options)
    current_folder = os.getcwd()
    app = ServerApp(port, {
        'download': options.download,
        'install': options.install,
        'current_folder': current_folder
    })
    daemon_runner = runner.DaemonRunner(app)
    daemon_runner.do_action()