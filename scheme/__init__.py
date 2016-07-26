#! /usr/bin/env python3
__author__ = 'mark'


def create_scheme(db_connection, sql_file='scheme.sql'):
    file = open(sql_file, 'r')
    sql = file.read()

    with db_connection.cursor() as cursor:
        cursor.execute(sql)
    db_connection.commit()


if __name__ == '__main__':
    from optparse import OptionParser
    import psycopg2

    parser = OptionParser(usage="Usage: %prog [options] db_name")
    parser.add_option("-s", "--host", dest="host",
                      help="Connection host", metavar="HOST", default="localhost")
    parser.add_option("-o", "--port", dest="port",
                      help="Connection port", metavar="PORT", type='int', default=5432)
    parser.add_option("-l", "--login", dest="login",
                      help="Login", metavar="LOGIN", default=None)
    parser.add_option("-p", "--password", dest="password",
                      help="Password", metavar="PASSWORD", default=None)

    (options, args) = parser.parse_args()
    print(options, args)
    try:
        db_name = args[0]
    except IndexError:
        print('db_name is required parameter')
        exit()
    print('running...')
    db_conn = psycopg2.connect(
        host=options.host,
        port=options.port,
        user=options.login,
        password=options.password,
        database=db_name
    )
    create_scheme(db_connection=db_conn)