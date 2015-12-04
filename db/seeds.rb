# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#require_relative '../lib/parser.rb'

EXAMPLE_SENTENCES = 149865
SKIP_FACTOR = 10

count = 0
sentences = 0

# read in examples.utf tanaka corpus file and store in db
file = "examples.utf"
examples = File.open(file, "r")
while !examples.eof?
  line = examples.readline
  # if line contains info we wnt to parse
  if line.match("A: ")
    #used to skip items in examples
    if (count % SKIP_FACTOR == 0)
      # parse japanese and english
      jpn = line[3..line.index("\t")-1]
      eng = line[(line.index("\t")+1)..line.index("#ID")-1]
      # create new sentence
      sentence = Sentence.create!(jpn: jpn, eng: eng)
      # parses sentence with ve
      Parser.parse_sentence(sentence)
      sentences = sentences + 1
      if (count % 1000 == 0)
        puts "#{count*100 / EXAMPLE_SENTENCES}% of examples loaded"
      end
    end
    count = count + 1
  end
end
examples.close
puts "100% of examples loaded, total count: #{sentences}"
