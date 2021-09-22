
require 'zip'
leitura = Zip::ZipFile.open("zip")
puts leitura.find_entry 'teste/testeRuby.txt'
