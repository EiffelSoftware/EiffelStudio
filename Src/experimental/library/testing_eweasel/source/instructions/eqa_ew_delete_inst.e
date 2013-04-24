note
	description: "[
					Delete the file named <dest-file> from the directory
					<dest-directory>.  The destination directory should not
					normally be the source directory $SOURCE.
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class EQA_EW_DELETE_INST

inherit
	EQA_EW_TEST_INSTRUCTION

create
	make

feature {NONE} -- Initialization

	make (a_del_directory, a_del_file: STRING)
			-- Creation method
		require
			not_void: attached a_del_directory
			not_void: attached a_del_file
		do
			inst_initialize (a_del_directory, a_del_file)
		end

	inst_initialize (a_del_directory, a_del_file: STRING)
			-- Initialize instruction
		require
			not_void: attached a_del_directory
			not_void: attached a_del_file
		do
			del_directory := a_del_directory
			del_file := a_del_file
		end

feature -- Command

	execute (test: EQA_EW_SYSTEM_TEST_SET)
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			del_name: STRING_32
			dir, file: RAW_FILE
		do
			execute_ok := False

			del_directory := test.environment.substitute (del_directory)

			del_name := test.file_system.build_path (del_directory, << del_file >>)
			create dir.make_with_name (del_directory)
			create file.make_with_name (del_name)
			if (dir.exists and then dir.is_directory) and
			   (file.exists and then file.is_plain) then
				from
				until
					not test.copy_wait_required
				loop
--					os.sleep_milliseconds (100) -- FIXME: to be implemented
				end
				test.unset_copy_wait
				file.delete
				execute_ok := True
			elseif not dir.exists then
				failure_explanation := "delete directory not found"
			elseif not dir.is_directory then
				failure_explanation := "delete directory not a directory"
			elseif not file.exists then
				failure_explanation := "delete file not found"
			elseif not file.is_plain then
				failure_explanation := "delete file not a plain file"
			end

		end

feature -- Query

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature {NONE} -- Implementation

	del_file: STRING
			-- Name of file to be deleted

	del_directory: STRING_32
			-- Name of directory in which file to be deleted
			-- resides

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"







end
