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
			-- No need for an error message.
		do
		end

end -- class VISM
