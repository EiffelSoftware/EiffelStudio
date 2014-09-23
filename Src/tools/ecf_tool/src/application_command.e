note
	description: "Summary description for {APPLICATION_COMMAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	APPLICATION_COMMAND

inherit
	LOCALIZED_PRINTER

	SHARED_EXECUTION_ENVIRONMENT

feature -- Access

	name: IMMUTABLE_STRING_8

	synopsis: READABLE_STRING_32
		deferred
		end

feature -- Execution

	process (args_src: ARGUMENT_SOURCE)
		deferred
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
