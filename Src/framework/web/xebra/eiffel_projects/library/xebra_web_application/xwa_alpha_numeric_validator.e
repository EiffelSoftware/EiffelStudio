note
	description: "[
		{XWA_ALPHA_NUMERIC_VALIDATOR}.
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
			-- Initializes 'Current'
		do

		end

feature -- Implementation

	validate (a_argument: STRING): BOOLEAN
			-- <Precursor>
		do
				-- TODO FIXME
			Result := True
		end

	message: STRING
			-- <Precursor>
		do
			Result := "Value is not alphanumeric!"
		end
end
