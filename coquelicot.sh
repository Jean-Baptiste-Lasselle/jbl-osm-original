#!/bin/bash
git init
git config user.name Jean-Baptiste-Lasselle
git config user.email jean.baptiste.lasselle.it@gmail.com
git add --all
git add **/* 
git commit -m "Coquelicot!"
git remote add origin git@github.com:Jean-Baptiste-Lasselle/jbl-osm-original.git
git push -u origin master

