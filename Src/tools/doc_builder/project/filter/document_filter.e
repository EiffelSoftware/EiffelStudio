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
