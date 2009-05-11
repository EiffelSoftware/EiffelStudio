note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_CONFIG_I

feature -- Access

	name: STRING
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_emmpty
		end

	port: NATURAL
		deferred
		ensure
			result_positive: Result > 0
		end

	is_interactive: BOOLEAN
		deferred
		end

feature -- Basic operation

	merge (a_config: XWA_CONFIG_I)
		deferred
		end

end

