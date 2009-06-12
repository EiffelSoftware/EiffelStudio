note
	description: "[
		{XWA_DATE_VALIDATOR}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_DATE_VALIDATOR

inherit
	XWA_REGEXP_VALIDATOR

create
	make

feature -- Implementation

	message: STRING
			-- <Precursor>
		do
			Result := "Value is not a date!"
		end

	regular_expression: STRING
			-- <Precursor>
		do
			Result := "^\d\d\d\d\-\d\d\-\d\d$"
		end
end
