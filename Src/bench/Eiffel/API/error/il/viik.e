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

	file_name: STRING is
			-- No associated file name
		do
		end
	
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- No need for an error message.
		do
		end

end -- class VIIK
