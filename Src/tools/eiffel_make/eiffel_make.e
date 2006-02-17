indexing
	description	: "[
		Given a directory, call the make utility on all subdirectories if a `Makefile' exists
		and without a `finished' file (which shows that compilation has already been done),
		and if make is successful, then call make on the directory if a Makefile exists.

		Since it is applied to Eiffel generated F_code/W_code and that the compilation in E1
		directory takes a long time, we will always process E1 first.

		We also try to guess the number of CPU on a system, but this can be overridden by the -cpu option.
		]"
	note: "Initial version automatically generated"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_MAKE

inherit
	ARGUMENTS

	THREAD_CONTROL

	EXCEPTIONS

	PROCESS_FACTORY

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
				-- By default initialize number of CPU to 1.
			create actions.make
			create failed_actions.make

			parse_arguments
			if not has_error then
				process
			else
					-- Exit with error code.
				die (1)
			end
		end

feature -- Status report

	has_error: BOOLEAN
			-- Did we encountered an error?

	target: DIRECTORY_NAME
			-- Directory were processing will be done.

	number_of_cpu: INTEGER
			-- Number of CPU available.

	make_utility: STRING
			-- Name/path of `make' utility.

	actions, failed_actions: MT_ACTION_QUEUE
			-- List of actions being executed.

feature {NONE} -- Implementation

	parse_arguments is
			-- Parse arguments and report errors, if any.
		local
			l_nb_cpu, l_make, l_target: STRING
			l_has_error: BOOLEAN
			l_dir: DIRECTORY
			l_help: STRING
		do
			l_help := separate_word_option_value ("help")
			if l_help /= Void and then l_help.is_empty then
				print_usage
					-- Exit now
				die (0)
			else
				l_target := separate_word_option_value ("target")
				if l_target /= Void then
					if l_target.is_empty then
						io.error.put_string ("Error: Missing target directory.%N")
						print_usage
						l_has_error := True
					else
						create target.make_from_string (l_target)
						create l_dir.make (target)
						if not l_dir.exists then
							io.error.put_string ("Error: '" + l_target + "' directory does not exist.%N")
							print_usage
							l_has_error := True
						elseif not l_dir.is_readable or not l_dir.is_writable then
							io.error.put_string ("Error: '" + l_target + "' directory is not readable nor writable.%N")
							print_usage
							l_has_error := True
						end
					end
				end

				if not l_has_error then
					l_make := separate_word_option_value ("make")
					if l_make /= Void then
						if l_make.is_empty then
							io.error.put_string ("Error: Missing make utility command.%N")
							print_usage
							l_has_error := True
						else
							make_utility := l_make
						end
					end

					if not l_has_error then
						l_nb_cpu := separate_word_option_value ("cpu")
						if l_nb_cpu /= Void then
							if l_nb_cpu.is_empty or not l_nb_cpu.is_integer then
									-- Error, we expected a number of CPU
								io.error.put_string ("Error: Missing number of CPU.%N")
								print_usage
								l_has_error := True
							else
								number_of_cpu := l_nb_cpu.to_integer
							end
						end
					end
				end
				has_error := l_has_error

				if not l_has_error then
					if l_target = Void then
						create target.make_from_string ((create {EXECUTION_ENVIRONMENT}).current_working_directory)
					end
					if l_make = Void then
						if (create {PLATFORM}).is_windows then
							make_utility := "nmake.exe -s -nologo"
						else
							make_utility := "make"
						end
					end
					if l_nb_cpu = Void then
							-- No CPU number was specified, get the information from the OS.
						compute_number_of_cpu ($number_of_cpu)
					end
				end
			end
		end

	print_usage is
			-- Print usage.
		do
			io.error.put_string ("%NUsage: eiffel_make [-target DIR] [-make MAKE] [-cpu N]%N%N%
				%Default option for make is  : `nmake -s -nologo'.%N%
				%Default option for target is: `.'.%N%
				%Default option for cpu is   : number of CPU on this machine,%N")
		end

	process is
			-- Call make
		require
			target_not_void: target /= Void
			target_not_empty: not target.is_empty
			make_utility_not_void: make_utility /= Void
			make_utility_not_empty: not make_utility.is_empty
		local
			l_dirs: ARRAYED_LIST [STRING]
			l_dir_name: STRING
			l_name: DIRECTORY_NAME
			l_dir: DIRECTORY
			l_worker_thread: WORKER_THREAD
			i, l_min: INTEGER
			l_file: RAW_FILE
			l_sorted_list: DS_ARRAYED_LIST [STRING]
			l_sorter: DS_QUICK_SORTER [STRING]
			l_has_e1: BOOLEAN
		do
			create l_dir.make (target)
			l_dirs := l_dir.linear_representation
			from
				l_dirs.start
				create l_sorted_list.make (10)
			until
				l_dirs.after
			loop
				l_dir_name := l_dirs.item
				if l_dir_name /= Void and then (not l_dir_name.is_equal (".") and not l_dir_name.is_equal ("..")) then
					if l_dir_name.is_equal ("E1") then
						l_has_e1 := True
					else
						l_name := target.twin
						l_name.extend (l_dir_name)
						create l_dir.make (l_name)
							-- Strange way of checking if we are handling a directory, but
							-- this is necessary on Windows where depending on wether or not
							-- you had a final directory separator the results are bogus.
						if l_dir.exists then
								l_sorted_list.force_last (l_dir_name)
						else
							create l_file.make (l_name)
							if l_file.exists and then l_file.is_directory then
								l_sorted_list.force_last (l_dir_name)
							end
						end
					end
				end
				l_dirs.forth
			end

			create l_sorter.make (create {DIRECTORY_SORTER})
			l_sorted_list.sort (l_sorter)

				-- Process additions of found directories.
			from
				l_sorted_list.start
			until
				l_sorted_list.after
			loop
				insert_directory (l_sorted_list.item_for_iteration)
				l_sorted_list.forth
			end

			if l_has_e1 then
					-- We excluded E1 from `l_sorted_list' to ensure it would be last in the list.
				insert_directory ("E1")
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
					create l_worker_thread.make (agent process_compilation)
					l_worker_thread.launch
					i := i + 1
				end
				join_all
			end

			if failed_actions.count /= 0 then
					-- An error occurred, signal it.
				die (1)
			else
				if not compile_directory (target) then
					die (1)
				end
			end
		end

	process_compilation is
			-- Process all actions in `actions' until it is empty.
		local
			l_action: FUNCTION [ANY, TUPLE, BOOLEAN]
			l_failure: BOOLEAN
		do
			from
				l_action ?= actions.removed_element
			until
				l_action = Void or l_failure
			loop
				l_failure := not l_action.item (Void)
				if l_failure then
					failed_actions.extend (l_action)
				else
					l_action ?= actions.removed_element
				end
			end
		end

	compile_directory (a_dir: DIRECTORY_NAME): BOOLEAN is
			-- Compile in `a_dir'.
		require
			target_not_void: target /= Void
			target_not_empty: not target.is_empty
			a_dir_not_void: a_dir /= Void
			a_dir_not_empty: not a_dir.is_empty
			make_utility_not_void: make_utility /= Void
			make_utility_not_empty: not make_utility.is_empty
		local
			l_process: PROCESS
		do
			l_process := process_launcher (make_utility, Void, a_dir)
			l_process.launch
			Result := l_process.launched
			if Result then
				l_process.wait_for_exit
				Result := l_process.exit_code = 0
			end
		end

	insert_directory (a_dir: STRING) is
			-- Insert processing of `a_dir' subdirectory of `target' into `actions'
			-- if it has a `Makefile' and no `finished' file showing that it has not yet
			-- been processed.
		require
			a_dir_not_void: a_dir /= Void
			a_dir_not_empty: not a_dir.is_empty
			make_utility_not_void: make_utility /= Void
			make_utility_not_empty: not make_utility.is_empty
		local
			l_name: DIRECTORY_NAME
			l_makefile, l_finished: FILE_NAME
			l_file: RAW_FILE
		do
			l_name := target.twin
			l_name.extend (a_dir)
			create l_makefile.make_from_string (l_name)
			l_makefile.set_file_name (makefile_name)
			create l_file.make (l_makefile)
			if l_file.exists then
					-- Only process directories which have a Makefile.
				l_name := target.twin
				l_name.extend (a_dir)
				create l_finished.make_from_string (l_name)
				l_finished.set_file_name (finished_name)
				create l_file.make (l_finished)
				if not l_file.exists then
						-- Only process directories which do not have a `finished' file, which shows
						-- that the directory needs to be processed.
					actions.extend (agent compile_directory (l_name))
				end
			end

		end

	compute_number_of_cpu (a_result: TYPED_POINTER [INTEGER]) is
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

	makefile_name: STRING is "Makefile"
	finished_name: STRING is "finished"
			-- Constants for file names.

invariant
	actions_not_void: actions /= Void
	failed_actions_not_void: failed_actions /= Void

end -- class EIFFEL_MAKE
