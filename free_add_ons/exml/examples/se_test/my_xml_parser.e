class
	MY_XML_PARSER

inherit
	XML_PARSER
		redefine
			on_start_tag,
			on_content,
			on_end_tag,
			on_default
		end


creation
	make

feature -- Initialization

feature

	on_start_tag (start_tag: XML_START_TAG) is
			-- called whenever the parser findes a start element
		do
			print (start_tag.out)
		end

	on_content (content: XML_CONTENT) is
			-- called whenever the parser findes character data
		do
			print (content.out)
		end

	on_end_tag (end_tag: XML_END_TAG) is
			-- called whenever the parser findes an end element
		do
			print (end_tag.out)
		end

	on_default (data: CHARACTER_ARRAY) is
		-- this feature is called for any character in the XML
		-- document for which there is no applicable handler
		do
			print ("default (")
			print (data.out)	
			print (")")		
		end

end -- class MY_XML_PARSER
