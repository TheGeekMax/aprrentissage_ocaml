#lit les mots de mots.txt, les sépare par rapport a un retour a la ligne et les stocke dans une liste

def lire_mots():
    """lit le fichier mots.txt et renvoie une liste de mots"""
    mots = []
    with open("mots.txt", "r") as fichier:
        for ligne in fichier:
            mots.append(ligne.strip())
    return mots

#lit chaque mot ,et enleve tout les accents
def enlever_accents(mot):
    """enleve tout les accents d'un mot"""
    mot = mot.lower()
    mot = mot.replace("é", "e")
    mot = mot.replace("è", "e")
    mot = mot.replace("ê", "e")
    mot = mot.replace("à", "a")
    mot = mot.replace("â", "a")
    mot = mot.replace("ç", "c")
    mot = mot.replace("ù", "u")
    mot = mot.replace("û", "u")
    mot = mot.replace("î", "i")
    mot = mot.replace("ï", "i")
    mot = mot.replace("ô", "o")
    mot = mot.replace("ö", "o")
    mot = mot.replace("ÿ", "y")
    return mot

#utilise enlever_accent pour les enregistrer dans mots.txt
def enregistrer_mots(mots):
    """enregistre les mots dans mots.txt"""
    with open("mots.txt", "w") as fichier:
        for mot in mots:
            fichier.write(enlever_accents(mot) + "\n")

enregistrer_mots(lire_mots())