indexing
	description: "XML formatter which deals with escaping."
	date: "$Date$"
	revision: "$Revision$"

class
	XM_ESCAPED_FORMATTER

inherit
	XM_FORMATTER
		redefine
			process_character_data
		end

	XML_ROUTINES

create
	make

feature -- Access
		
	process_character_data (c: XM_CHARACTER_DATA) is
			-- Process character data `c'
		local
			l_content: STRING
		do	
			l_content := output_escaped (c.content)	
			append (l_content)
		end	

end -- class XM_ESCAPED_FORMATTER
