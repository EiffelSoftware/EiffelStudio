indexing
	description: "Document footer."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_FOOTER

inherit
	DOCUMENT_XML	

	TEMPLATE_CONSTANTS
		undefine
			copy,
			is_equal
		end

create
	make_from_file,
	make_from_text

end -- class DOCUMENT_FOOTER
