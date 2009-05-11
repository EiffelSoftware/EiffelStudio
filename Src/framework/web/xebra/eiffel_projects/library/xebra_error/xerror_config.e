note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XERROR_CONFIG

inherit
	ERROR_ERROR_INFO
	redefine
		make
		end

create
	make

feature {NONE} -- Access

	make (a_context: like context)
			-- Initializes an error.
			--
			-- `a_context': Any optional contextual information.
		do
			context := a_context
		end


	dollar_description: STRING
			-- Dollar encoded description. ${n} are replaced by array indicies.
			-- See {STRING_FORMATTER}
		do
			Result := "There is an error in the server configuration file. Could not find configuration for {1}"
		end


end

