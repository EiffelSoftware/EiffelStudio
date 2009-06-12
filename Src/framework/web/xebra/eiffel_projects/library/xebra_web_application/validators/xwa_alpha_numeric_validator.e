note
	description: "[
		Requires the input to be alpha numeric: ^\w+$
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_ALPHA_NUMERIC_VALIDATOR

inherit
	XWA_REGEXP_VALIDATOR

create
	make

feature -- Implementation

	message: STRING
			-- <Precursor>
		do
			Result := "Value is not alphanumeric!"
		end

	regular_expression: STRING
			-- <Precursor>
		do
			Result := "^\w+$"
		end


end
