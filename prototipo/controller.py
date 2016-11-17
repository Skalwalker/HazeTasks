import model
import couchdb

class Controller(object):

    def __init__(self, server, db):
        self.server = server
        self.db = db

    def checkUser(self, user, password):
        for person in model.User.load(self.db, person.id):
            if person.name == user and person.password == password:
                print('Logado')
                break


    def addUser(self, user, password, role):
        user = model.User(name=user, password= password, role=role)
        user.store(self.db)
