# Reconstrcution d'une image PostGreSQL appropriée à mon usage

## Principe

Il s'agit d'un bac à sable de tests pour monter une image PostGreSQL appropriée à mes besoins de provisions Cartographqiues.

## Utilisation

Je veux pouvoir lancer, sur le même hôte Docker, mes tests PostGreSQL, indépendamment de mes tests de cartographie.

Voici donc le script idemtpotent, à exécuter pour : 

```bash
export URI_REPO_GIT=https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original
export PROVISIONING_HOME=$HOME/tests-postgres
cd $PROVISIONING_HOME
if [ -d $PROVISIONING_HOME ]; then sudo rm -rf $PROVISIONING_HOME; fi;
mkdir -p $PROVISIONING_HOME
cd $PROVISIONING_HOME
git clone $URI_REPO_GIT .
cd jbl-postgres
docker-compose down && docker-compose up -d
# ensuite, il faut excuter chaque série de tests
# puis collecter les résultats de tests
chmod +x ./run-tests.sh
./run-tests.sh
```
En une ligne :

```bash
export URI_REPO_GIT=https://github.com/Jean-Baptiste-Lasselle/jbl-osm-original && export PROVISIONING_HOME=$HOME/tests-postgres && cd $PROVISIONING_HOME && if [ -d $PROVISIONING_HOME ]; then sudo rm -rf $PROVISIONING_HOME; fi; mkdir -p $PROVISIONING_HOME && cd $PROVISIONING_HOME && git clone $URI_REPO_GIT . && cd jbl-postgres && docker-compose down && docker-compose up -d && chmod +x ./run-tests.sh && ./run-tests.sh
```
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


# Analyse

## Image ubuntu sous-jacente, dans le conteneur

Enfin, j'ai une réponse :  le user linux `postgres` est créé par le procesus d'installation de PostGreSQL, pendant le build de l'image. Pour le vérifier, il suffit d'insérer deux directives `USER` dans le dockerfile : 
```yaml
FROM ubuntu
...
# - 
# This one BEFORE the RUN dockerfile commands that install postgres from linux packages
# This one will trigger a Docker error, prompting "linux spec user: unable to find user biloute: no matching entries in passwd file" 
# - 
USER postgres
...
# Here the postgres commands that install postgresql db server
# Ici, les commandes linux qui installent PostGreSQL

# This one AFTER the RUN dockerfile commands that install postgres from linux packages
# This one will NOT trigger any Docker error, cause use now exists
USER postgres

```
Indeed, you will then, at docker build time, get an error looking like  
```bash
 ---> Running in 2302110ac00e
linux spec user: unable to find user biloute: no matching entries in passwd file
```
    ccc

```bash
ccc
```
