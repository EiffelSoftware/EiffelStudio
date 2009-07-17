note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XERROR_UNDEFINED_NAMESPACE
inherit
	ERROR_WARNING_INFO
		rename
			make as make_error
		end

create
	make

feature {NONE} -- Initialization

	make (a_namespace: READABLE_STRING_8)
		do
			make_error ([a_namespace]);
		end

feature {NONE} -- Access

	dollar_description: STRING
			-- <Precursor>
		do
			Result := "Undefined tag {1}."
		end
end
