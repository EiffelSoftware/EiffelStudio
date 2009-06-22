note
	description: "[
		{XTAG_TAG_VARIABLE_ARGUMENT}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_TAG_VARIABLE_ARGUMENT

inherit
	XTAG_TAG_ARGUMENT

create
	make, make_default

feature -- Implementation

	value (a_controller_id: STRING): STRING
			-- <Precursor>
		do
			Result := "%"+" + internal_value + "+%""
		end

	plain_value (a_controller_id: STRING): STRING
			-- <Precursor>
		do
			Result := internal_value
		end

	value_without_escape (a_controller_id: STRING): STRING
			-- <Precursor>
		do
			Result := "%"+" + internal_value + "+%""
		end

	is_plain_text: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

end
