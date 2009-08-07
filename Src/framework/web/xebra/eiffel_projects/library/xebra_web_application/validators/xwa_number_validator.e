note
	description: "[
		{XWA_NUMBER_VALIDATOR}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_NUMBER_VALIDATOR

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
			-- <Precursor>
		do
			Result := a_argument.is_integer
		end

	message: STRING
			-- <Precursor>
		do
			Result := "Value is not a number!"
		end

end
