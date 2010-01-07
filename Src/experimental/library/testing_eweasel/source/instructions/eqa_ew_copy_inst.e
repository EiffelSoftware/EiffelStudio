note
	description: "[
					Ancestor class for all copy instructions
					
					For old version, please check {EW_COPY_INST}
																						]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQA_EW_COPY_INST

inherit
	EQA_EW_OS_ACCESS
		export
			{NONE} all
		end

	EQA_EW_TEST_INSTRUCTION
		export
			{NONE} all
			{ANY} deep_copy, deep_twin, is_deep_equal, standard_is_equal
		end

feature {NONE} -- Initialization

	make (a_source_file, a_dest_directory, a_dest_file: STRING; a_test: EQA_EW_SYSTEM_TEST_SET)
			-- Initialize with arguments
		require
			not_void: a_source_file /= Void
			not_void: a_dest_directory /= Void
			not_void: a_dest_file /= Void
			not_void: attached a_test
		do
			source_file := a_source_file
			dest_directory := a_dest_directory
			dest_file := a_dest_file

			test_set := a_test
		ensure
			set: test_set = a_test
		end

feature -- Query

	substitute: BOOLEAN
			-- Should each line of copied file have
			-- environment variable substitution applied to it?
		deferred
		end

	test_set: EQA_EW_SYSTEM_TEST_SET
			-- The test set current managed

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature -- Commannd

	execute (a_test: EQA_EW_SYSTEM_TEST_SET)
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			l_dest_name: STRING
			l_src, l_dir, l_dest: like new_file
			l_before_date, l_after_date: INTEGER
			l_orig_date, l_final_date: INTEGER
			l_file_system: EQA_FILE_SYSTEM
			l_error: STRING
			l_source_dir: detachable STRING
		do
			dest_directory := test_set.environment.substitute_recursive (dest_directory)
			source_file := test_set.environment.substitute_recursive (source_file)

			execute_ok := False

			l_source_dir := test_set.environment.source_directory
			check attached l_source_dir end -- Implied by environment values have been set before executing test cases
			l_dest_name := string_util.file_path (<<l_source_dir,source_file>>)

			create l_file_system.make (test_set.environment)

			l_src := new_file (l_dest_name)
			ensure_dir_exists (dest_directory)
			l_dir := new_file (dest_directory)

			if (l_src.exists and then l_src.is_plain) and
			   (l_dir.exists and then l_dir.is_directory) then

				l_dest := new_file (string_util.file_path (<<dest_directory, dest_file>>))
				if l_dest.exists then
					l_orig_date := l_dest.date
				else
					l_orig_date := 0
				end
				if is_fast then
					l_file_system.copy_file (l_src, test_set.environment, l_dest, substitute)
					if l_orig_date /= 0 then
						l_dest.set_date (l_orig_date + 1)
					end
				else
					l_before_date := os.current_time_in_seconds
					from
					until
						not test_set.copy_wait_required
					loop
						os.sleep_milliseconds (100)
					end

					l_after_date := os.current_time_in_seconds

					l_file_system.copy_file (l_src, test_set.environment, l_dest, substitute)

					l_final_date := l_dest.date

					if l_final_date <= l_orig_date then
						-- Work around possible Linux bug
						if l_after_date <= l_orig_date then
							l_error := "ERROR: After date " + l_after_date.out + " not greater than original date " + l_orig_date.out
							assert.assert (l_error, False)
						else
							l_dest.set_date (l_after_date)
							l_final_date := l_dest.date
							if l_final_date /= l_after_date then
								l_error := "ERROR: failed to set dest modification date to " + l_after_date.out
								assert.assert (l_error, False)
							end
						end
					end

					check_dates (test_set.e_compile_start_time, l_orig_date, l_final_date, l_before_date, l_after_date, l_dest_name)

					test_set.unset_copy_wait
				end
				execute_ok := True
			elseif not l_src.exists then
				l_error := "source file not found"
				failure_explanation := l_error
				assert.assert (l_error, False)
			elseif not l_src.is_plain then
				l_error := "source file not a plain file"
				failure_explanation := l_error
				assert.assert (l_error, False)
			elseif not l_dir.exists then
				l_error := "destination directory not found"
				failure_explanation := l_error
				assert.assert (l_error, False)
			elseif not l_dir.is_directory then
				l_error := "destination directory not a directory"
				failure_explanation := l_error
				assert.assert (l_error, False)
			end

		end

feature {NONE} -- Implementation

	new_file (a_file_name: STRING): FILE
			-- Create an instance of FILE
		require
			a_file_name_not_void: a_file_name /= Void
		deferred
		ensure
			new_file_not_void: Result /= Void
		end

	ensure_dir_exists (a_dir_name: STRING)
			-- Try to ensure that directory `dir_name' exists
			-- (it is not guaranteed to exist at exit).
		require
			name_not_void: a_dir_name /= Void
		local
			l_dir: DIRECTORY
			l_tried: BOOLEAN
		do
			if not l_tried then
				create l_dir.make (a_dir_name)
				if not l_dir.exists then
					l_dir.create_dir
				end
			end
		rescue
			l_tried := True
			retry
		end

	is_fast: BOOLEAN
			-- Should "speed" mode be used?
		do
			Result := test_set.environment.get ({EQA_EW_PREDEFINED_VARIABLES}.Eweasel_fast_name) /= Void
		end

	check_dates (a_start_date, a_orig_date, a_final_date, a_before_date, a_after_date: INTEGER a_fname: STRING)
			-- Check if date correct
		local
			l_error: STRING
		do
			if a_final_date <= a_orig_date then
				l_error := "ERROR: final date " + a_final_date.out + " not greater than original date " + a_orig_date.out + " for file " + a_fname
				l_error.append ("Compile start = " + a_start_date.out + " Before = " + a_before_date.out + " After = " + a_after_date.out)
				assert.assert (l_error, False)
			end
		end

	dest_directory: STRING
			-- Name of destination directory

	dest_file: STRING
			-- Name of destination file

	source_file: STRING
			-- Name of source file (always in source directory)

;note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
