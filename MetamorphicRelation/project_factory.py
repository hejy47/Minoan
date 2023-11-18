from MetamorphicRelation import des, des3, aes, rsa, sha3

def get_project(project):
    if project == "des":
        return des.DES()
    elif project == "des3":
        return des3.DES3()
    elif project == "aes":
        return aes.AES()
    elif project == "rsa":
        return rsa.RSA()
    elif project == "sha3":
        return sha3.SHA3()