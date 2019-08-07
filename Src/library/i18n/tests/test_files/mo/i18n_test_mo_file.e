note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_TEST_MO_FILE

inherit
	EQA_SYSTEM_TEST_SET

	I18N_TEST_UTILITIES
		undefine
			default_create
		end

feature -- Test

	test_mo_file
		local
			m: I18N_MO_FILE
		do
			create m.make (mo_file_name ("ar.mo"))
    		m.open
    		valid_index_test (1, m)
    		m.close

			create m.make (mo_file_name ("zh_CN.mo"))
    		m.open
    		valid_index_test (2, m)
    		m.close
		end

feature	{NONE} -- Implementation

	mo_file_name (a_direct_file_name: STRING): STRING_32
			-- Full name.
			-- This is a hack, since no such facility found in the testing framework, for a file name located in the source class directory.
		do
			if attached env.item ("ISE_LIBRARY") as l_env then
				create Result.make_from_string (l_env)
				Result.append_character (Operating_environment.directory_separator)
				Result.append ("library")
				Result.append_character (Operating_environment.directory_separator)
				Result.append ("i18n")
				Result.append_character (Operating_environment.directory_separator)
				Result.append ("tests")
				Result.append_character (Operating_environment.directory_separator)
				Result.append ("test_files")
				Result.append_character (Operating_environment.directory_separator)
				Result.append ("mo")
				Result.append_character (Operating_environment.directory_separator)
				Result.append (a_direct_file_name)
			else
				assert ("ISE_LIBRARY not defined", False)
				create Result.make_empty
			end
		end

	valid_index_test (a_file_number: INTEGER; a_file: I18N_MO_FILE)
			-- test valid_index feature in class `I18N_MO_FILE'
		local
			i:INTEGER
		do
			if a_file.opened then
				from
					i:=1
				until
					i>100
				loop
					if a_file_number = 1 then -- File "ar.mo"
						if i >= 13 then
							assert ("Index should not be valid.", not a_file.valid_index (i))
						else
							assert ("Index should be valid.", a_file.valid_index (i))
						end
					elseif a_file_number = 2 then
						if i >= 24 then
							assert ("Index should not be valid.", not a_file.valid_index (i))
						else
							assert ("Index should be valid.", a_file.valid_index (i))
						end
					else
						assert ("No file is testing.", False)
					end
					i := i + 1
				end
			else
				print_line ("NOT OPENED!!")
			end
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
