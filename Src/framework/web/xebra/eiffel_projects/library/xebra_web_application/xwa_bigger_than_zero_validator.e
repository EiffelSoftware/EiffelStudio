note
	description: "[
		{XWA_BIGGER_THAN_ZERO_VALIDATOR}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_BIGGER_THAN_ZERO_VALIDATOR

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
			Result := "Value is not bigger than zero!"
		end

	validate (a_argument: STRING): BOOLEAN
			-- <Precursor>
		do
			if a_argument.is_integer then
				Result := a_argument.to_integer > 0
			else
				Result := False
			end
		end

end
