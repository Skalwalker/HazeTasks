import model

class View(object):

    def __init__(self, control, ):
        self.control = control


    def signUpLogIn(self):
        print("----------Bem vindo ao HazeTasks!----------")
        print("1. Cadastrar");
        print("2. Login");
        opc = raw_input('>>> ')
        return opc

    def login(self):
        user = raw_input('Usuario: ')
        password = raw_input('Senha: ')
        isValid = self.control.checkUser(user=user, password=password)

    def register(self):
        roles = ["CW", "CA", "CI", "A", "I", "W"]
        user = raw_input('Informe o usuario: ')
        password = raw_input('Informe a senha: ')
        print("Possiveis Cargos:\nCW. Chefe de desenvolvimento de Windows Phone\nCI. Chefe de desenvolvimento de iOS")
        print("CA. Chefe do departamento artistico\nA. Desenvolvedor de arte\nI. Desenvolvedor de iOS\nW. Desenvolvedor de Windows Phone")
        role = raw_input('Informe o cargo: ')
        role = role.upper()
        while (role != "CW") and (role != "CA") and (role != "CI") and (role != "A") and (role != "I") and (role != "W"):
            print("Cargo invalido!")
            role = raw_input('Informe o cargo: ')
            role = role.upper()
        addUser = self.control.addUser(user, password, role)
        print("Usuario adicionado com sucesso!")
