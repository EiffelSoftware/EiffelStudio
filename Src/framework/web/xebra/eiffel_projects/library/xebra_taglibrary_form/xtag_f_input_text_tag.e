note
	description: "[
		Renders an html input field.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_INPUT_TEXT_TAG

inherit
	XTAG_F_INPUT_TAG

create
	make

feature -- Implementation

	input_type: STRING
			-- <Precursor>
		do
			Result := "input"
		end

end
