note
	description: "[
		Requires the input to be alpha numeric: ^\w+$
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_ALPHA_NUMERIC_VALIDATOR

inherit
	XWA_VALIDATOR

create
	make

feature -- Initialization

	make
			-- Initializer...
		do
		end

feature -- Implementation

	message: STRING
			-- <Precursor>
		do
			Result := "Value is not alphanumeric!"
		end

	validate (a_argument: STRING): BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

end
