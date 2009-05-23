note
	description: "[
		{XWA_NOT_EMPTY_VALIDATOR}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_NOT_EMPTY_VALIDATOR

inherit
	XWA_VALIDATOR
create
	make

feature -- Initialization

	make
			-- Initializes 'Current'
		do
		end

feature -- Implementation

	validate (a_argument: STRING): BOOLEAN
		-- Validates if `a_argument' is valid
		do
			Result := not a_argument.is_empty
		end

	message: STRING
			-- <Precursor>
		do
			Result := "Value cannot be empty!"
		end

end
