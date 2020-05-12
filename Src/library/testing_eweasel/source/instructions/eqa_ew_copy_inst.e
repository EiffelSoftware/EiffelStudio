note
	description:
		"[
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
			l_src_name: STRING_32
			l_dest_name: STRING_32
			l_src, l_dir, l_dest: like new_file
			l_before_date, l_after_date: INTEGER
			l_orig_date, l_final_date: INTEGER
		do
			dest_directory := test_set.environment.substitute_recursive (dest_directory)
			source_file := test_set.environment.substitute_recursive (source_file)

			execute_ok := False

			if use_source_environment_variable then
				l_src_name := test_set.file_system.build_source_path (<< source_file >>)
			else
				l_src_name := source_file
			end
			l_dest_name := test_set.file_system.build_path (dest_directory, << dest_file >>)
			l_src := new_file (l_src_name)
			ensure_dir_exists (dest_directory)
			l_dir := new_file (dest_directory)

			if (l_src.exists and then l_src.is_plain) and
			   (l_dir.exists and then l_dir.is_directory) then

				l_dest := new_file (l_dest_name)
				if l_dest.exists then
					l_orig_date := l_dest.date
				else
					l_orig_date := 0
				end
				if is_fast then
					copy_file (l_src, l_dest)
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

					copy_file (l_src, l_dest)

					l_final_date := l_dest.date

					if l_final_date <= l_orig_date then
						-- Work around possible Linux bug
						if l_after_date <= l_orig_date then
							failure_explanation := "ERROR: After date " + l_after_date.out + " not greater than original date " + l_orig_date.out
							print (failure_explanation)
							a_test.assert (exception_tag, False)
						else
							l_dest.set_date (l_after_date)
							l_final_date := l_dest.date
							if l_final_date /= l_after_date then
								failure_explanation := "ERROR: failed to set dest modification date to " + l_after_date.out
								print (failure_explanation)
								a_test.assert (exception_tag, False)
							end
						end
					end

					check_dates (test_set, test_set.e_compile_start_time, l_orig_date, l_final_date, l_before_date, l_after_date, l_dest_name)

					test_set.unset_copy_wait
				end
				execute_ok := True
			elseif not l_src.exists then
				failure_explanation := "source file not found"
			elseif not l_src.is_plain then
				failure_explanation := "source file not a plain file"
			elseif not l_dir.exists then
				failure_explanation := "destination directory not found"
			elseif not l_dir.is_directory then
				failure_explanation := "destination directory not a directory"
			end

			if not execute_ok then
				print (failure_explanation)
				a_test.assert (exception_tag, False)
			end
		end

feature {NONE} -- Implementation

	new_file (a_file_name: READABLE_STRING_GENERAL): FILE
			-- Create an instance of FILE
		require
			a_file_name_not_void: a_file_name /= Void
		deferred
		ensure
			new_file_not_void: Result /= Void
		end

	ensure_dir_exists (a_dir_name: READABLE_STRING_32)
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

	copy_file (src: like new_file; dest: like new_file)
			-- Append lines of file `src', with environment
			-- variables substituted according to `env' (but
			-- only if `substitute' is true) to
			-- file `dest'.
		require
			source_not_void: src /= Void
			destination_not_void: dest /= Void
			source_is_closed: src.is_closed
			destination_is_closed: dest.is_closed
		local
			line: STRING
			l_env: EQA_ENVIRONMENT
		do
			from
				l_env := test_set.environment
				src.open_read
				dest.open_write
			until
					-- src.readable is required or else src.read_line will throw an exception
				src.end_of_file or not src.readable
			loop
				src.read_line
				line :=
					if substitute then
						{UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_env.substitute (src.last_string))
					else
						src.last_string
					end
				if not src.end_of_file then
					dest.put_string (line)
					dest.new_line
				elseif not line.is_empty then
					dest.put_string (line)
				end
			end
			src.close
			dest.flush
			dest.close
		end

	is_fast: BOOLEAN
			-- Should "speed" mode be used?
		do
			Result := test_set.environment.item ({EQA_EW_PREDEFINED_VARIABLES}.Eweasel_fast_name) /= Void
		end

	check_dates (a_test: EQA_EW_SYSTEM_TEST_SET; a_start_date, a_orig_date, a_final_date, a_before_date, a_after_date: INTEGER a_fname: READABLE_STRING_GENERAL)
			-- Check if date correct
		local
			l_error: STRING_32
		do
			if a_final_date <= a_orig_date then
				l_error := {STRING_32} "ERROR: final date " + a_final_date.out + " not greater than original date " + a_orig_date.out + " for file " + a_fname
				l_error.append ("Compile start = " + a_start_date.out + " Before = " + a_before_date.out + " After = " + a_after_date.out)
				print (l_error)
				a_test.assert (exception_tag, False)
			end
		end

	dest_directory: STRING_32
			-- Name of destination directory

	dest_file: STRING_32
			-- Name of destination file

	source_file: STRING_32
			-- Name of source file (always in source directory)

	use_source_environment_variable: BOOLEAN
			-- Do we use `source_dir_name' for copy?
		do
			Result := True
		end

feature {NONE} -- Constants

	exception_tag: STRING = "Invalid file copy"
			-- Tag for an exception thrown in `Current'

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
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
