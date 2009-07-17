note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"


class
	XERROR_CONFIG_ERROR

inherit
	ERROR_ERROR_INFO
		rename
			make as make_error
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_error ([""])
		end

feature -- Access


feature {NONE} -- Access

	dollar_description: STRING
			-- <Precursor>
		do
			Result := "Config file cannot be parsed correctly."
		end

end
