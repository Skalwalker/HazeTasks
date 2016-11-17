from model import Model as db
from controller import Controller as Control
import couchdb
from view import View

if __name__ == '__main__':
    couch = couchdb.Server()
    try:
        db = couch.create('hazetasks')
    except:
        db = couch['hazetasks']

    control = Control(couch, db)
    view = View(control)

    opc = view.signUpLogIn()
    opc = int(opc)
    while ((opc != 1) and (opc != 2)):
        print("Opcao invalida")
        opc = view.signUpLogIn()
        try:
            opc = int(opc)
        except:
            print "Valor nao numerico"

    if(opc == 1):
        view.register()
        view.login()
    elif opc == 2:
        view.login()
