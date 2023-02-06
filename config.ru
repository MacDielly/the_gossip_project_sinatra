# Un fichier .ru est juste un fichier rack up, qui est un fichier Ruby servant à lancer un serveur local sur le standard Rack.
require 'bundler'
Bundler.require

$:.unshift File.expand_path('lib') # Sert à prendre en compte tous les fichiers contenus dans le dossier "lib".
# require './lib/controller'
require 'controller' # Le "unshift" servant à aller chercher automatiquement tout ce qu'il y a dans lib, on modifie le require.

run ApplicationController # On demande simplement au serveur d'exécuter le contenu de la classe "ApplicationController" du fichier "controller.rb"
# Rackup se met par défaut sur le port 9292 (http://localhost:9292/), contrairement au port 4567 de Sinatra.
# Pour se brancher (par convention sur Sinatra) sur le port 4567, exécuter sur la console la commande: "rackup -p 4567".
