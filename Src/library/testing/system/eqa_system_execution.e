note
	description: "[
		Objets that launch the system under test in a separate process and provide in- and output
		support routines.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_SYSTEM_EXECUTION

inherit
	EQA_EXECUTION
		rename
			make as make_execution
		end

create
	make

feature {NONE} -- Initialization

	make (an_environment: like environment)
			-- Initialize `Current'.
			--
			-- `an_environment': Environment for current system test.
		require
			an_environment_attached: an_environment /= Void
		local
			l_cmd: like command
		do
			l_cmd := an_environment.executable_name
			make_execution (an_environment, l_cmd)
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
