# Reconstrcution d'une image PostGreSQL appropriée à mon usage

Hypothèse en cours de vérification :+1: 


Dans l'état de configuration initiale : 
* L'utilisateur initial créé est de nom d'utilisateur `postgres`, (et cela ne peut être changé / configuré? question remise à des tests ultérieurs)
* Il n'est possible de se connecter avec l'utilisateur `postgres`, que depuis localhost, donc il faut pouvoir atteindre, par le réseau, l'hôte réseau dans lequel s'exécute le serveur.
* Si l'on a utilisé la variable d'environnement `POSTGRES_PASSWORD`, pendant l'exécution du processus d'installation de postgresql, alors on devra utiliser le mot de passe, pour s'authentifier en tant que `postgres`. Par défaut, l'utilisateur `postgres` pourra s'authentifier sans que postgres n'exige de saisie de mot de passe.


# Utilisation 
Supposons que vous avez cloné ce repo, et que vous vous trouviez dans le répertoire racine du repo git.
Alors, vous devrez vous rendre dans le présent répertoire, puis 
```bash
cd jbl-postgres/
chmod +x ./build-mon-image.sh
./build-mon-image.sh
```
