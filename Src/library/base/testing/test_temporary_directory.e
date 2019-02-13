note
	description: "Summary description for {TEST_TEMPORARY_DIRECTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_TEMPORARY_DIRECTORY

inherit

	EQA_TEST_SET


feature -- Test

	test
		local
			l_temp: STRING
		do
			if {PLATFORM}.is_windows then
				l_temp := {OPERATING_ENVIRONMENT}.temporary_directory_path
				assert ("Ends with Temp", l_temp.ends_with_general ("Temp\"))
			end
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
