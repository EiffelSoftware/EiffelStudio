indexing
	description: "Filterer of DOCUMENTs"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DOCUMENT_FILTER
	
inherit
	XM_CALLBACKS_FILTER

feature
	
	make is
			-- Create
		do
			create output_string.make_empty
			clear
		end		

feature -- Access

	output_string: STRING
			-- Output string after filter processing
			
	description: STRING
			-- Textual description of this filter

feature -- Status Setting

	clear is
			-- Clear Current
		do
			output_string.clear_all
		end		

end -- class DOCUMENT_FILTER
