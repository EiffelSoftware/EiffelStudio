note
	description: "[
		{XTAG_TAG_DYNAMIC_ARGUMENT}.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_TAG_DYNAMIC_ARGUMENT

inherit
	XTAG_TAG_ARGUMENT

create
	make, make_default

feature -- Implementation

	is_dynamic: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

	is_variable: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	value (a_controller_id: STRING): STRING
			-- <Precursor>
		do
			Result := "%"+" + a_controller_id + "." + internal_value + "+%""
		end

	plain_value (a_controller_id: STRING): STRING
			-- <Precursor>
		do
			Result := a_controller_id + "." + internal_value
		end

	value_without_escape (a_controller_id: STRING): STRING
			-- <Precursor>
		do
			Result := "%"+" + a_controller_id + "." + internal_value + "+%""
		end

end
