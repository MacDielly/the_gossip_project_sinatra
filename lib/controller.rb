# Ces lignes appellent le bundler et permettent de lire le Gemfile. Pas besoin de mettre partout des "require 'gem'".
# require 'bundler'
# Bundler.require On retire ces lignes qui font maintenant doublon avec le fichier config.ru
require 'gossip' # Pour le lier à "gossip.rb" et en recevoir la méthode "save" de la classe "Gossip".
class ApplicationController < Sinatra::Base # La classe "ApplicationController" hérite (<) de la classe "Sinatra::Base" (= toutes les fonctionnalités de base de Sinatra).
    # get '/' do # Cela dit à l'appli Sinatra "si quelqu'un va sur l'URL '/', exécute le code qui suit !"
    #     "<html><head><title>The Gossip Project</title></head><body><h1>Mon super site de gossip !</h1></body></html>"
    # end # On retire ces lignes (get avec du html) qui font maintenant doublon avec le fichier index.erb

    # run! if app_file == $0 # Cette ligne permet d’exécuter le code de la classe sans avoir à écrire un ApplicationController.new.perform en bas du fichier.
                             # exécuter un fichier qui définit une classe (et c'est tout), eh bien ça ne donne rien... Il faut forcément l'exécution d'une méthode en bas de la classe pour lancer la machine !
                             # On retire cette ligne qui fait maintenant doublon avec le fichier config.ru
    
    get '/' do # Paramétrage de la route GET pour que le serveur pointe vers la view index.erb quand on va sur http://localhost:4567.
        # erb :index # Sinatra comprend tout seul qu'il doit aller chercher le fichier "index.erb" rangé dans le dossier "/views".
        erb :index, locals: {gossips: Gossip.all} # Passer une variable à une view (via les routes), Pour ceci, il suffit d'utiliser une méthode locals, qui permet d'envoyer à notre fichier ERB des variables que l'on utilisera. Ici on veut lui envoyer l'array obtenu par Gossip.all
    end

    get '/gossips/new/' do # Paramétrage de la route GET pour que le serveur pointe vers une nouvelle view new_gossip.erb quand on va sur http://localhost:4567/gossips/new/.
                           # '/gossips/new/' est une url!!! Pas un chemin de sous dossiers.
        erb :new_gossip
    end 

    post '/gossips/new/' do
        # Gossip.new("super_auteur", "super gossip").save # Avec "Gossip.new" on crée un nouvel objet Gossip et avec ".save" on lui applique la méthode save
        Gossip.new(params["gossip_author"], params["gossip_content"]).save # Ajout de la méthode "params" qui stoque les informations du formulaire dans un hash temporaire (entre chaque renouvellement html).
        redirect "/" # dit à Sinatra "maintenant, redirige le user vers cette route". Ainsi, pour rediriger vers la route '/', il faudra écrire redirect '/'
    end

    # get '/gossips/:id/' do
        # Gossip.find(id)
    # end


    # post '/gossips/new/' do         TEST
    #     puts "Salut, je suis dans le serveur"
    #     puts "Ceci est le contenu du hash params : #{params}"
    #     puts "Trop bien ! Et ceci est ce que l'utilisateur a passé dans le champ gossip_author : #{params["gossip_author"]}"
    #     puts "De la bombe, et du coup ça, ça doit être ce que l'utilisateur a passé dans le champ gossip_content : #{params["gossip_content"]}"
    #     puts "Ça déchire sa mémé, bon allez je m'en vais du serveur, ciao les BGs !"
    #   end

end

# En GET, tu vas dire à Sinatra : "hey, si quelqu'un va sur /gossips/new/ envoie-lui les view new_gossip",
# cependant en POST, ce sera plutôt un truc du genre "hey bro, récupère les informations du formulaire et convertis-les en une création de gossip dans ma base".