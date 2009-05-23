note
	description: "[
		{XTAG_F_INPUT_SECRET_TAG}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_INPUT_SECRET_TAG

inherit
	XTAG_F_INPUT_TAG

create
	make

feature -- Initialization

	make
		do
			make_base
		end

feature -- Implementation

	input_type: STRING
			-- <Precursor>
		do
			Result := "secret"
		end
end
