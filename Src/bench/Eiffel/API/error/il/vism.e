indexing
	description	: "IL Full-name Conflict when two classes of system have same full-name."
	date: "$Date$"
	revision: "$Revision$"

class
	VISM

inherit
	WARNING

feature -- Properties

	code: STRING is "VISM"
		-- Error code
	
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Display error message
		do
			st.add_string ("Assembly could not be signed because `mscorsn.dll' was not found.")
			st.add_new_line
		end

end -- class VISM
