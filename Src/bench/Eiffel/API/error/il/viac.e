indexing
	description	: "[
		Error when incremental compilation cannot be done because instances of MD_STRONG_NAME
		cannot be created properly, i.e. `exists' query returns True.
		]"
	definition: "VIAC = Aborted incremental Compilation"
	date: "$Date$"
	revision: "$Revision$"

class
	VIAC

inherit
	WARNING

feature -- Properties

	code: STRING is "VIAC"
		-- Error code
	
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- No need for an error message.
		do
		end

end -- class VIAC
