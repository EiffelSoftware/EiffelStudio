note
	description	: "[
		Given a directory, call the make utility on all subdirectories if a `Makefile' exists
		and without a `finished' file (which shows that compilation has already been done),
		and if make is successful, then call make on the directory if a Makefile exists.

		Since it is applied to Eiffel generated F_code/W_code and that the compilation in E1
		directory takes a long time, we will always process E1 first.

		We also try to guess the number of CPU on a system, but this can be overridden by the -cpu option.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_MAKE

inherit
	ARGUMENTS_32

	THREAD_CONTROL

	EXCEPTIONS

	LOCALIZED_PRINTER

create
	make

feature {NONE} -- Initialization

	make
			-- Creation procedure.
		do
				-- By default initialize number of CPU to 1.
			create actions.make
			create failed_actions.make
			create {ARRAYED_LIST [IMMUTABLE_STRING_32]} make_flags.make (0)

			parse_arguments
			process
		end

feature {NONE} -- Status report

	target: PATH
			-- Directory were processing will be done.

	number_of_cpu: INTEGER
			-- Number of CPU available.

	make_utility: STRING_32
			-- Name/path of `make' utility.

	make_flags: LIST [READABLE_STRING_32]
			-- Flags for `make_utility'.

	actions, failed_actions: MT_ACTION_QUEUE
			-- List of actions being executed.

feature {NONE} -- Implementation

	parse_arguments
			-- Parse arguments.
			-- If any error is detected, report it and exit application.
		local
			l_make_flags: IMMUTABLE_STRING_32
			l_dir: DIRECTORY
			l_index: INTEGER
		do
			if attached separate_word_option_value ("help") as h and then h.is_empty then
				print_usage
					-- Exit now.
				die (0)
			end
			if attached separate_word_option_value ("target") as l_target then
				if l_target.is_empty then
					report_error ("Error: Missing target directory.%N")
				end
				create target.make_from_string (l_target)
				create l_dir.make_with_path (target)
				if not l_dir.exists then
					report_error ("Error: '" + l_target + "' directory does not exist.%N")
				elseif not l_dir.is_readable or not l_dir.is_writable then
					report_error ("Error: '" + l_target + "' directory is not readable nor writable.%N")
				end
			else
				target := (create {EXECUTION_ENVIRONMENT}).current_working_path
			end

			l_index := index_of_word_option ("make_flags")
			if l_index > 0 then
				if l_index < argument_count then
						-- We take the argument following `make_flags' as flags for `make_utility'.
					l_make_flags := argument (l_index + 1)
				end
				if not attached l_make_flags or else l_make_flags.is_empty then
						-- Error, we expected make flags.
					report_error ("Error: Missing make flags.%N")
				else
					make_flags := l_make_flags.split (' ')
				end
			end

			if attached separate_word_option_value ("make") as l_make then
				if l_make.is_empty then
					report_error ("Error: Missing make utility command.%N")
				end
				make_utility := {STRING_32} "%"" + l_make + {STRING_32} "%""
			elseif (create {PLATFORM}).is_windows then
				make_utility := "nmake.exe"
				if not attached l_make_flags then
					make_flags.extend ("-s")
					make_flags.extend ("-nologo")
				end
			else
				make_utility := "make"
			end

			if attached separate_word_option_value ("cpu") as l_nb_cpu then
				if l_nb_cpu.is_empty or not l_nb_cpu.is_integer then
						-- Error, we expected a number of CPU.
					report_error ("Error: Missing number of CPU.%N")
				else
					number_of_cpu := l_nb_cpu.to_integer
				end
			else
					-- No CPU number was specified, get the information from the OS.
				compute_number_of_cpu ($number_of_cpu)
			end
		end

	report_error (message: READABLE_STRING_GENERAL)
			-- Report error `message` and exit.
		do
			io.error.put_string_32 (message.to_string_32)
			print_usage
			die (1)
		ensure
			can_return: False
		end

	print_usage
			-- Print usage.
		local
			i: INTEGER
		do
			debug
					-- Print arguments as we get them.
				from
					i := 1
				until
					i > argument_count
				loop
					print (argument (i))
					print ("%N")
					i := i + 1
				end
			end
			io.error.put_string ("Command line was: %N")
			localized_print (command_line)
			io.error.put_string ("%N%NExpected: eiffel_make [-target DIR] [-make MAKE] [-make_flags FLAGS] [-cpu N]%N%N%
				%Default option for make is  : `nmake'. %N%
				%Default option for make_flags is: `-s -nologo'.%N%
				%Default option for target is: `.'.%N%
				%Default option for cpu is   : number of CPU on this machine,%N")
		end

	process
			-- Call make.
		require
			target_not_void: target /= Void
			target_not_empty: not target.is_empty
			make_utility_not_void: make_utility /= Void
			make_utility_not_empty: not make_utility.is_empty
		local
			l_dir_name: PATH
			l_name: like target
			l_dir: DIRECTORY
			i, l_min: INTEGER
			l_file: RAW_FILE
			l_sorted_list: ARRAYED_LIST [PATH]
			l_has_e1: BOOLEAN
		do
			create l_dir.make_with_path (target)
			across
				l_dir.entries as entry
			from
				create l_sorted_list.make (10)
			loop
				l_dir_name := entry.item
				if not l_dir_name.is_current_symbol and not l_dir_name.is_parent_symbol then
					if l_dir_name.name.same_string_general ("E1") then
						l_has_e1 := True
					else
						l_name := target.extended_path (l_dir_name)
						create l_dir.make_with_path (l_name)
							-- Strange way of checking if we are handling a directory, but
							-- this is necessary on Windows where depending on wether or not
							-- you had a final directory separator the results are bogus.
						if l_dir.exists then
							l_sorted_list.extend (l_dir_name)
						else
							create l_file.make_with_path (l_name)
							if l_file.exists and then l_file.is_directory then
								l_sorted_list.extend (l_dir_name)
							end
						end
					end
				end
			end

			(create {QUICK_SORTER [PATH]}.make (create {DIRECTORY_SORTER})).sort (l_sorted_list)

				-- Process additions of found directories.
			across
				l_sorted_list as directory
			loop
				insert_directory (directory.item)
			end

			if l_has_e1 then
					-- We excluded E1 from `l_sorted_list' to ensure it would be last in the list.
				insert_directory (create {PATH}.make_from_string ("E1"))
			end

			l_min := number_of_cpu.min (actions.count)
			if l_min = 1 then
				process_compilation
			else
					-- Perform a distributed build.
				from
					i := 1
				until
					i > l_min
				loop
					(create {WORKER_THREAD}.make (agent process_compilation)).launch
					i := i + 1
				end
				join_all
			end

			if failed_actions.count /= 0 then
					-- An error occurred, signal it.
				die (1)
			elseif
					-- No need to twin here since we are single threaded again.
				not compile_directory (target, make_flags)
			then
				die (1)
			end
		end

	process_compilation
			-- Process all actions in `actions' until it is empty.
		local
			l_action: FUNCTION [BOOLEAN]
			l_failure: BOOLEAN
		do
			from
				l_action := actions.removed_element
			until
				not attached l_action or l_failure
			loop
				l_failure := not l_action.item
				if l_failure then
					failed_actions.extend (l_action)
				else
					l_action := actions.removed_element
				end
			end
		end

	compile_directory (a_dir: PATH; l_flags: LIST [READABLE_STRING_32]): BOOLEAN
			-- Compile in `a_dir'.
		require
			target_not_void: target /= Void
			target_not_empty: not target.is_empty
			a_dir_not_void: a_dir /= Void
			a_dir_not_empty: not a_dir.is_empty
			make_utility_not_void: make_utility /= Void
			make_utility_not_empty: not make_utility.is_empty
		local
			l_process: BASE_PROCESS
		do
			l_process := process_factory.process_launcher (make_utility, l_flags, a_dir.name)
			l_process.launch
			if l_process.launched then
				l_process.wait_for_exit
				Result := l_process.exit_code = 0
			end
		end

	process_factory: BASE_PROCESS_FACTORY
			-- A factory to create processes.
		once
			create Result
		end

	insert_directory (a_dir: PATH)
			-- Insert processing of `a_dir' subdirectory of `target' into `actions'
			-- if it has a `Makefile' and no `finished' file showing that it has not yet
			-- been processed.
		require
			a_dir_not_void: a_dir /= Void
			a_dir_not_empty: not a_dir.is_empty
			make_utility_not_void: make_utility /= Void
			make_utility_not_empty: not make_utility.is_empty
		local
			l_name: like target
			l_file: RAW_FILE
		do
			l_name := target.extended_path (a_dir)
			create l_file.make_with_path (l_name.extended (makefile_name))
			if l_file.exists then
					-- Only process directories which have a Makefile.
				create l_file.make_with_path (l_name.extended (finished_name))
				if not l_file.exists then
						-- Only process directories which do not have a `finished' file, which shows
						-- that the directory needs to be processed.
						-- It is important to twin `make_flags' as otherwise multiple threads
						-- could access it at the same time.
					actions.extend (agent compile_directory (l_name, make_flags.twin))
				end
			end
		end

	compute_number_of_cpu (a_result: TYPED_POINTER [INTEGER])
			-- Number of CPUs.
		external
			"C inline use <windows.h>"
		alias
			"[
				{
					SYSTEM_INFO SysInfo;
					ZeroMemory (&SysInfo, sizeof (SYSTEM_INFO));
					GetSystemInfo (&SysInfo);
					*(EIF_INTEGER *) $a_result = SysInfo.dwNumberOfProcessors;
				}
			]"
		end

feature {NONE} -- Constants

	makefile_name: STRING = "Makefile"
	finished_name: STRING = "finished"
			-- Constants for file names.

invariant
	actions_not_void: actions /= Void
	failed_actions_not_void: failed_actions /= Void
	make_flags_not_void: make_flags /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
