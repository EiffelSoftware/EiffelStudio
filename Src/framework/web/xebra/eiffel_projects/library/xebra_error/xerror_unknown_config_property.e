note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XERROR_UNKNOWN_CONFIG_PROPERTY

inherit
	ERROR_ERROR_INFO
		rename
			make as make_error
		end

create
	make

feature {NONE} -- Initialization

	make (a_property_name: READABLE_STRING_8)
		do
			create property_name.make_from_string (a_property_name)
			make_error ([a_property_name]);
		end

feature -- Access

	property_name: IMMUTABLE_STRING_8
			-- Property name on which the error occurred

feature {NONE} -- Access

	dollar_description: STRING
			-- <Precursor>
		do
			Result := "Unknown property in config file: '{1}'"
		end

end

