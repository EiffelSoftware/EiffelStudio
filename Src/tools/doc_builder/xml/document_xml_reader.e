indexing
	description: "Reader of document xml."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_XML_READER

inherit
	XM_CONTENT_CONCATENATOR
		redefine
			on_content
		end

	XML_ROUTINES

create
	make_null,
	set_next

feature -- Tag
		
	on_content (a_content: STRING) is
			-- Content
		local
			l_content: STRING
		do		
			l_content := output_escaped (a_content)
			Precursor (l_content)
		end
	
end -- class DOCUMENT_XML_READER
