indexing
	description	: "Warning generated when assembly cannot be signed."
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
