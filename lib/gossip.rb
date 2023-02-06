# require 'bundler'
# Bundler.require
class Gossip

    attr_accessor :author, :content

    def initialize (writer, gossip)
        @author = writer
        @content = gossip
    end

    def save
        CSV.open("./db/gossip.csv", "ab") do |csv| # Nous ouvrons le CSV en mode écriture (ab) (le CSV a le path db/gossip.csv). Pour "ab", voir: https://ruby-doc.org/core-2.0.0/IO.html#method-c-new-label-IO+Open+Mode
            csv << [@author, @content] # Nous insérons dedans une ligne avec deux colonnes. La première colonne a pour entrée la variable d'instance "author" et la seconde colonne a la variable d'instance content.
        end
    end

    def self.all
        all_gossips = [] # on initialise un array vide
        CSV.read("./db/gossip.csv").each do |csv_line| # va chercher chacune des lignes du csv do et créer un gossip avec les infos de la ligne
            all_gossips << Gossip.new(csv_line[0], csv_line[1]) # all_gossips << gossip qui vient d'être créé
        end
        return all_gossips # on retourne un array rempli d'objets Gossip
    end

    def find
        
    end

end
# binding.pry