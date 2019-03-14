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

	test_temporary_path
		do
			if {PLATFORM}.is_windows then
				if attached  {PATH} {EXECUTION_ENVIRONMENT}.temporary_directory_path as l_temp then
					assert ("Ends with Temp", l_temp.name.out.ends_with_general ("\Temp"))
				end
			elseif {PLATFORM}.is_unix then
				if attached {PATH} {EXECUTION_ENVIRONMENT}.temporary_directory_path as l_temp then
					assert ("Ends with /tmp", l_temp.out.ends_with_general ("/tmp"))
				end
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
