Membre.all.each do |m|
m.lols_count = 0
m.vannes.each do |l|
m.lols_count += l.lols.count
end
m.vannes_count = m.vannes.count
m.save(:validate => false)
end