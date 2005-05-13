indexing
	description: "Filterer of DOCUMENTs"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DOCUMENT_FILTER
	
inherit
	XM_PRETTY_PRINT_FILTER

	XML_ROUTINES
		rename
			output_escaped as rt_output_escaped,
			is_escaped as rt_is_escaped,
			escaped_char as rt_escaped_char
		end

feature

	make is
			-- Create
		do
			clear
		end

feature -- Access

	output_string: STRING is
			-- Output string after filter processing
		once
			create Result.make (100000)
		end

	description: STRING
			-- Textual description of this filter

feature -- Status Setting

	clear is
			-- Clear Current
		do
			output_string.clear_all
		end

end -- class DOCUMENT_FILTER
