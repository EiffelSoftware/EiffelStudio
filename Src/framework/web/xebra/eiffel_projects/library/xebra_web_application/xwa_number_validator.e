note
	description: "[
		{XWA_NUMBER_VALIDATOR}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_NUMBER_VALIDATOR

inherit
	XWA_REGEXP_VALIDATOR

create
	make

feature -- Implementation

	message: STRING
			-- <Precursor>
		do
			Result := "Value is not a number!"
		end

	regular_expression: STRING
			-- <Precursor>
		do
			Result := "^-?\d+$"
		end
end
