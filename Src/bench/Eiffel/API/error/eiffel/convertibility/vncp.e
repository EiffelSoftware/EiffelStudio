indexing
	description: "Error for invalid conversion type: %
		%1. Has an anchor%
		%2. NONE cannot be a valid type to convert from or to."
	date: "$Date$"
	revision: "$Revision$"

class
	VNCP

obsolete
	"NOT DEFINED IN THE BOOK"

inherit
	EIFFEL_ERROR
		redefine
			build_explain
		end

create
	make

feature -- Initialization

	make (s: STRING) is
			-- Initializes current error with `s'.
		require
			s_not_void: s /= Void
		do
			message := s
		ensure
			message_set: message = s
		end
		
feature -- Access

	code: STRING is "VNCP"
			-- Name of error.
			
	message: STRING
			-- Display errror message.

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `error_window'.
		do
			st.add_string (message)
			st.add_new_line
		end

end -- class VNCP
