note
	description: "[
		{XTAG_F_INPUT_TAG}.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XTAG_F_INPUT_TAG

inherit
	XTAG_TAG_SERIALIZER
		redefine
			make_base
		end

feature -- Initialization

	make_base
		do
			Precursor
			value := ""
			name := ""
		end

feature -- Access

	value: STRING
			-- Text of the input field

	name: STRING
			-- Identification of the input field for the data object mapping

feature -- Implementation

	internal_put_attribute (id: STRING; a_attribute: STRING)
			-- <Precusor>
		do
			if id.is_equal ("value") then
				value := a_attribute
			end
			if id.is_equal ("name") then
				name := a_attribute
			end
		end

end
