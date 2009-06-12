note
	description: "[
		Requires an inputer matching: ^-?\d+$
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_NUMERIC_VALIDATOR

inherit
	XWA_REGEXP_VALIDATOR

create
	make

feature -- Implementation

	regular_expression: STRING
			-- <Precursor>
		do
			Result := "^-?\d+$"
		end

	message: STRING
			-- <Precursor>
		do
			Result := "Not a valid number!"
		end

end
