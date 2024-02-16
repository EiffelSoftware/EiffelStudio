note
	description: "Summary description for {DBG_DOCUMENT_WRITER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DBG_DOCUMENT_WRITER

feature {DBG_WRITER} -- Access

	is_successful: BOOLEAN
			-- Was last call to Current successful?
		deferred
		end

feature -- Definition

	define_sequence_points (count: INTEGER; offsets, start_lines,
			start_columns, end_lines, end_columns: ARRAY [INTEGER])
			-- Set sequence points for `document'
		deferred
		end


end
