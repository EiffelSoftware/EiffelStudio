indexing
	description: "Filterer of DOCUMENTs"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DOCUMENT_FILTER
	
inherit
	XM_CALLBACKS_FILTER

feature
	
	make (a_id: INTEGER) is
			-- Create with `a_id'
		require
			valid_id: a_id > 0
		do
			identifier := a_id
			create output_string.make_empty
		end		

feature -- Access

	identifier: INTEGER
			-- Unique identifier

	description: STRING is
			-- Description of this filter
		deferred
		end

	output_string: STRING
			-- Output string after filter processing

feature -- Status Setting

	clear is
			-- Clear Current
		do
			output_string := ""
		end		

invariant
	has_valid_id: identifier > 0

end -- class DOCUMENT_FILTER
