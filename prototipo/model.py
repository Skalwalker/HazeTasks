import couchdb
from couchdb.mapping import Document, TextField, IntegerField, DateTimeField

class Model(object):

    def __init__(self, couch):
        self.couch = couch

class User(Document):
    name = TextField()
    password = TextField()
    role = TextField()
