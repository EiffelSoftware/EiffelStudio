indexing
	description: "Box to display a XML help document.  Uses eXML parser to parse document, and EiffelVision rich text box for presentation"
	author: "Parker Abercrombie"
	date: "$Date$"

class
	HELP_DOCUMENT_DISPLAY

inherit
	EV_RICH_TEXT
		rename
			make as make_text
		end
	EXPAT_ERROR_CODES
	KL_INPUT_STREAM_ROUTINES

create
	make

feature  -- Initialization

	make (par: EV_CONTAINER) is
			-- Create an empty display with `par' as the parent.
		do
			make_text (par)
			create parser.make
		end;

feature -- Access

	parser: HELP_DOCUMENT_PARSER
			-- The XML parser.

	document: HELP_DOCUMENT
			-- The document.

feature -- Basic operations

	load_file (file_name: STRING) is
			-- Parse `file_name' with eXML and return output.
		require
			file_name_not_void: file_name /= Void
		do
			document := parser.parse_file (file_name)
			document.display (Current)
		end;

end -- class HELP_DOCUMENT_DISPLAY
