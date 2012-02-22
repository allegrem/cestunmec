xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "C'est un mec"
    xml.description "C'est un mec, il s'appelle On et il a un phare, c'est le Pharaon !!"
    xml.link vannes_url

    for vanne in @vannes
      xml.item do
        xml.title vanne.contenu
        xml.pubDate vanne.created_at.to_s(:rfc822)
	if vanne.membre_id
	  xml.author vanne.membre.pseudo
	else
	  xml.author 'Anonyme'
	end
        xml.link vanne_url(vanne)
	xml.guid vanne_url(vanne)
      end
    end
  end
end