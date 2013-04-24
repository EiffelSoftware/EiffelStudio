note
	description: "[
		Objects that launch the system under test in a separate process and provide in- and output
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

	make (a_test_set: like test_set)
			-- Initialize `Current'.
			--
			-- `a_test_set': Test set for which `Current' will be used.
		require
			a_test_set_attached: a_test_set /= Void
		do
			make_execution (a_test_set, a_test_set.environment.item_attached (system_executable_key, a_test_set.asserter))
		end

feature -- Constants

	system_executable_key: STRING = "EQA_SYSTEM_EXECUTABLE"
			-- Key for system executable setting

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
