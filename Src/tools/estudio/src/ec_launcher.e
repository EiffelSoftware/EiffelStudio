indexing
	description: "Ec launcher's ."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EC_LAUNCHER

inherit
	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	PLATFORM

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
			is_splashing := True

				--| Now get the estudio environment and arguments for `ec'
			get_parameters
			get_environment
			check_environment
			if is_environment_valid then
				if is_splashing then
					display_splasher
				end
				do_ec_launching
			end
		end

	do_ec_launching is
		require
			is_environment_valid: is_environment_valid
		do
			launch_ec
		end

feature -- Launching

	display_usage (is_exiting: BOOLEAN) is
			-- Display usage and exit if `is_exiting' is True
		do
			io.error.put_string ("Usage: estudio {estudio's parameters} {ec's parameters} %N")
			io.error.put_string ("%N  If no parameter is provided, simply start EiffelStudio (aka ec)%N%N")
			io.error.put_string ("  * estudio's parameters %N")
			io.error.put_string ("  * estudio's parameters %N")
			io.error.put_string ("     /? or /h   : display this help %N")
			io.error.put_string ("     /v         : verbose %N")
			io.error.put_string ("     /w         : wait until launched process exits %N")
			io.error.put_string ("     /nosplash  : no splash screen %N")
			io.error.put_string ("     /ec_name   : overwrite EC_NAME value %N")
			io.error.put_string ("     /ec_folder : overwrite EC_FOLDER value %N")
			io.error.put_string ("  * ec's parameters %N")
			io.error.put_string ("     any ec's command line parameters (-config, -target, -project_path ...)%N")
			io.error.put_string ("     if there is only one parameter, this is the eiffel configuration file (file.ecf)%N")
			io.error.put_string ("%NOptional environment variables:%N")
			io.error.put_string ("  * EC_NAME     : name of the compiler (default: ec)%N")
			io.error.put_string ("  * EC_FOLDER   : folder which contains the compiler%N")
			io.error.put_string ("  * MELTED_PATH : for workbench version %N")

			io.error.put_string ("%NPress ENTER to continue ...%N")
			io.read_line
			if is_exiting then
				(create {EXCEPTIONS}).die (0)
			end
		end

	launch_ec is
			-- Launch ec process
		require
			is_environment_valid: is_environment_valid
		local
			s: STRING
			retried: BOOLEAN
		do
			if not retried then
				get_ec_arguments
				if is_verbose then
					create s.make_empty

					s.append_string ("*** estudio is using the following data : %N")
					s.append_string (" ISE_EIFFEL: " + eiffel_layout.eiffel_installation_dir_name + "%N")
					s.append_string (" ISE_PLATFORM: " + eiffel_layout.eiffel_platform + "%N")
					s.append_string (" Path to ec: " + ec_path + "%N")
					s.append_string (" Working directory: " + working_directory + "%N")
					s.append_string (" Arguments: ")
					from
						ec_arguments.start
					until
						ec_arguments.after
					loop
						s.append_string (ec_arguments.item + " ")
						ec_arguments.forth
					end
					s.append_string ("%N")
					if splasher /= Void then
						splasher.set_verbose_text (s)
					else
						io.output.put_string (s)
						io.output.put_new_line
					end
				end
				start_process (ec_path, ec_arguments, working_directory)
			else
				do_exit_launcher
			end
		rescue
			retried := True
			retry
		end

	start_process (cmd: STRING; args: LIST [STRING]; dir: STRING) is
			-- Start process using command `cmd' and arguments `args'
			-- in the working directory `dir'
		require
			is_environment_valid: is_environment_valid
		local
			process: PROCESS
			has_exited_timeout: EV_TIMEOUT
			keep_estudio_terminal: BOOLEAN
		do
				--| To keep terminal stdin , stderr, stdout
				--| estudio must stay alive ...
			keep_estudio_terminal := not is_windows or is_waiting

			process := process_factory.process_launcher (ec_path, args, dir)
			process.set_hidden (False)

			if is_windows then
					--| Windows specific
				process.set_separate_console (False)
				process.set_detached_console (True)
			else
					--| Unix specific
				process.disable_launch_in_new_process_group
			end

			if keep_estudio_terminal then
				if is_windows then
					process.redirect_input_to_stream --| useful ?
					process.redirect_output_to_agent (agent on_output)
					process.redirect_error_to_agent (agent on_output)
				end
			else
				process.set_on_successful_launch_handler (agent do_exit_launcher)
			end

			process.set_on_terminate_handler (agent do_exit_launcher)
			process.set_on_exit_handler (agent do_exit_launcher)
			process.set_on_fail_launch_handler (agent do_exit_launcher)

			debug ("LAUNCHER")
				print (generator + " : launching process ... %N")
			end
			process.launch

			if process.launched and keep_estudio_terminal then
				if not is_waiting then
					close_splasher (splash_delay)
				end
				create has_exited_timeout
				has_exited_timeout.actions.extend (agent exit_if_process_has_exited (process))
				has_exited_timeout.set_interval (5 * 1000)
			else
				is_waiting := False
				do_exit_launcher
			end
		end

	exit_if_process_has_exited (p: PROCESS) is
		do
			if not p.is_running or else p.has_exited then
				is_waiting := False
				exit_launcher
			end
		end

feature {NONE} -- Application exit

	do_exit_launcher is
		do
			is_waiting := False
			exit_launcher
		end

	exit_launcher is
		require
			is_not_waiting: not is_waiting
		do
			close_splasher (0)
		end

feature -- Splash

	splash_delay: INTEGER_32 is 3_000
			-- 2 seconds seems ok

	splasher: SPLASH_DISPLAYER_I

	new_splasher (t: STRING_GENERAL): like splasher is
		do
			create {NATIVE_SPLASH_DISPLAYER} Result.make_with_text (t)
		end

	display_splasher is
			-- Display splash window (if available)
		require
			is_environment_valid: is_environment_valid
		local
			s: STRING_32
			fn: FILE_NAME
			retried: BOOLEAN
		do
			debug ("LAUNCHER")
				print (generator + ".display_splasher %N")
			end

			if not retried then
				create s.make_empty
				s.append_code (169)
				s.append_string_general (" 2006  Eiffel Software ")

				splasher := new_splasher (s)

				create fn.make_from_string (eiffel_layout.bitmaps_path)
				fn.extend ("png")
				fn.set_file_name ("splash.png")
				if file_exists (fn) then
					splasher.set_splash_pixmap_filename (fn)
				end

				debug ("launcher")
					splasher.set_verbose_text ("This is an experimental version")
				end
				splasher.show
			else
				if splasher /= Void then
					close_splasher (0)
				end
			end
		rescue
			retried := True
			retry
		end

	close_splasher (delay: INTEGER_32) is
			-- 'delay' has no sense in none graphical context
		do
			debug ("LAUNCHER")
				print (generator + ".close_splasher (delay: " + delay.out + ") %N")
			end
			if splasher /= Void then
				splasher.close
				splasher := Void
			end
		end

feature -- Properties

	is_waiting: BOOLEAN
			-- Stay alive until `ec' exits ?

	is_splashing: BOOLEAN
			-- Display splash screen ?

	is_verbose: BOOLEAN
			-- Display details ?

	argument_variables: HASH_TABLE [STRING, STRING]

feature -- Environment

	cmdline_arguments: ARGUMENTS

	cmdline_arguments_offset: INTEGER

	cmdline_arguments_count: INTEGER

	cmdline_remove_head (n: INTEGER) is
		do
			cmdline_arguments_offset := cmdline_arguments_offset + n
			cmdline_arguments_count := cmdline_arguments_count - n
		end

	get_cmdline_arguments is
		do
			cmdline_arguments := Execution_environment.command_line
			cmdline_arguments_count := cmdline_arguments.argument_count
		end

	cmdline_argument (i: INTEGER): STRING is
		require
			cmdline_arguments /= Void
		do
			Result := cmdline_arguments.argument (i + cmdline_arguments_offset)
		end

	ec_arguments: LIST [STRING]

	get_parameters is
		local
			s: STRING
		do
			get_cmdline_arguments
			create argument_variables.make (3)
			argument_variables.compare_objects

				--| First we check if there is no specific `estudio' parameters
			from
				s := "/?"
			until
				s @ 1 /= '/' or else cmdline_arguments_count = 0
			loop
				s := cmdline_argument (1)
				if s @ 1 = '/' then
					s.to_lower
					if s.is_equal ("/h") or s.is_equal ("/?") then
						display_usage (True)
					elseif s.is_equal ("/v") then
						is_verbose := True
					elseif s.is_equal ("/w") then
						is_waiting := True
					elseif s.is_equal ("/nosplash") then
						is_splashing := True
					elseif s.is_equal ("/ec_name") then
						cmdline_remove_head (1)
						if cmdline_arguments_count > 0 then
							argument_variables.put (cmdline_argument (1), eiffel_layout.Ec_name_env)
						end
					elseif s.is_equal ("/ec_folder") then
						cmdline_remove_head (1)
						if cmdline_arguments_count > 0 then
							argument_variables.put (cmdline_argument (1), eiffel_layout.ec_folder_env)
						end
					elseif s.is_equal ("/melted_path") then
						cmdline_remove_head (1)
						if cmdline_arguments_count > 0 then
							argument_variables.put (cmdline_argument (1), Melted_path_varname)
						end
					else
						io.error.put_string (" * Ignoring flag [" + s + "]%N")
					end
					cmdline_remove_head (1)
				end
			end
		end

	get_ec_arguments is
		require
			is_environment_valid: is_environment_valid
		local
			s: STRING
			cwd: STRING
			fn: FILE_NAME
			file: RAW_FILE
			i: INTEGER
		do
				--| Compute command line, args, and working directory
			create {ARRAYED_LIST [STRING]} ec_arguments.make (cmdline_arguments_count + 1)
			ec_arguments.extend ("-from_bench")

			if cmdline_arguments_count > 0 then
					--| And now we get the parameters for EiffelStudio

				if cmdline_arguments_count = 1 then
						--| use the -config argument
					ec_arguments.extend ("-config")
					s := cmdline_argument (1).twin

						--| Try to be smart and guess if the path is relative or not
					cwd := Execution_environment.current_working_directory
					Execution_environment.change_working_directory (working_directory)
					create fn.make
					if fn.is_file_name_valid (s) then
						create file.make (s)
					end
					if file = Void or else not file.exists then
						fn.set_directory (cwd)
						fn.set_file_name (s)
						if fn.is_valid then
							create file.make (fn)
							if file.exists then
								s := fn
							end
						end
						fn := Void
						file := Void
					end
					Execution_environment.change_working_directory (cwd)

						--| `s' is the path to the config file
					if s.has (' ') and then not s.has ('"') then
						s.left_adjust
						s.right_adjust
						s.prepend_character ('"')
						s.append_character ('"')
					end
					ec_arguments.extend (s)
				elseif cmdline_arguments_count >= 1  then
					ec_arguments.fill (	cmdline_arguments.argument_array.subarray (1 + cmdline_arguments_offset,
										cmdline_arguments_count))
					from
						i := 1
					until
						i > cmdline_arguments_count
					loop
						s := cmdline_argument (i)
						if
							s.is_equal ("-config")
							or s.is_equal ("-project_path")
							or s.is_equal ("-target")
						then
							if i < cmdline_arguments_count then
								ec_arguments.extend (s)
								i := i + 1
								s := cmdline_argument (i)
								if s.has (' ') and then not s.has ('"') then
									s.left_adjust
									s.right_adjust
									s.prepend_character ('"')
									s.append_character ('"')
								end
							end
						end
						ec_arguments.extend (s)
						i := i + 1
					end
				end
			end
		end

	get_environment_value (v: STRING; dft: STRING): STRING is
		do
			if argument_variables.has (v) then
				Result := argument_variables.item (v)
			else
				Result := Execution_environment.get (v)
			end
			if Result = Void then
				Result := dft
			end
		end

	get_environment is
			-- Get environment variables
		require
			cmdline_arguments_not_void: cmdline_arguments /= Void
		local
			s: STRING
		do
			eiffel_layout.check_environment_variable
			create ec_path.make_from_string (eiffel_layout.bin_path)

				--| Melted path if workbench ec
			s := get_environment_value (Melted_path_varname, ec_path)
			create working_directory.make_from_string (s)

			ec_path.set_file_name (eiffel_layout.ec_name)

			if not working_directory.is_valid then
				working_directory := Void
			end
		end

	check_environment is
			-- Check if the retrieved environment data are valid
			-- If successful, is_environment_valid is set to True
			-- else it is set to False
		local
			m: STRING
		do
			is_environment_valid := True
			create m.make_empty

			if
				ec_path /= Void
				and then (
					not ec_path.is_valid or not file_exists (ec_path)
					)
			then
				is_environment_valid := False
				m.append_string ("%N")
				m.append_string ("The path to ec [")
				m.append_string (ec_path)
				m.append ("] is not valid")
			end

			if not is_environment_valid then
				m.prepend_string ("Error, the environment is not valid :")
				implementation.error (m)
				exit_launcher
			end
		end

	is_environment_valid: BOOLEAN
			-- Is current environment valid ?

	ec_path: FILE_NAME
	melted_path: DIRECTORY_NAME
	working_directory: DIRECTORY_NAME

feature {NONE} -- Constants

	Melted_path_varname: STRING is "MELTED_PATH"

feature {NONE} -- Events

	on_output (s: STRING) is
		do
			if splasher /= Void and s /= Void then
				splasher.output_text (s)
			end
		end

feature {NONE} -- Implementations

	process_factory: PROCESS_FACTORY is
		once
			create Result
		end

	implementation: EC_LAUNCHER_I is
		once
			create {EC_LAUNCHER_IMP} Result
		end

	Execution_environment: EXECUTION_ENVIRONMENT is
		once
			create Result
		end

feature {NONE} -- File system helpers

	file_exists (fn: STRING): BOOLEAN is
		local
			f: RAW_FILE
		do
			create f.make (fn)
			Result := f.exists
		end

	directory_exists (dn: STRING): BOOLEAN is
		local
			d: DIRECTORY
		do
			create d.make (dn)
			Result := d.exists
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EC_LAUNCHER
