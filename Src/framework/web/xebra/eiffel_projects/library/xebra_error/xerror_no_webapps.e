note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XERROR_NO_WEBAPPS

inherit
	ERROR_ERROR_INFO

create
	make

feature {NONE} -- Access

	dollar_description: STRING
			-- Dollar encoded description. ${n} are replaced by array indicies.
			-- See {STRING_FORMATTER}
		do
			Result := "There are no webapps configured on this server."
		end

end

