indexing
	description: "XML String"
	author: "Kolli Reda"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_STRING

inherit
	XML_COMPOSITE

creation 
	make

feature -- Creation

	make (s: STRING) is 
	do
		value := s
	end

feature -- Properties

	value :	STRING


end -- class XML_STRING
