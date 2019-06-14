note
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_FILE_NAME

inherit
	EQA_TEST_SET

feature

	test_file_name
		obsolete "The feature tests an obsolete class FILE_NAME. [2019-11-30]"
		local
			l_file_name: FILE_NAME
		do
			create l_file_name.make_temporary_name
			assert ("Not Empty", l_file_name.is_valid)
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
