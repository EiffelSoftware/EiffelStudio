indexing
	description	: "Warning generated when private key cannot be read."
	date: "$Date$"
	revision: "$Revision$"

class
	VIIK

inherit
	WARNING

feature -- Properties

	code: STRING is "VIIK"
		-- Error code

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- No need for an error message.
		do
		end

end -- class VIIK
