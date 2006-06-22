indexing
	description: "Ec launcher's ."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EC_LAUNCHER

inherit

	PLATFORM

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
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
			io.error.put_string ("     /? or /h : display this help %N")
			io.error.put_string ("     /v       : verbose %N")
			io.error.put_string ("     /w       : wait until launched process exits %N")
			io.error.put_string ("  * ec's parameters %N")
			io.error.put_string ("     any ec's command line parameters (-config, -target, -project_path ...)%N")
			io.error.put_string ("     if there is only one parameter, this is the eiffel configuration file (file.ecf)%N")
			io.error.put_string ("%NPress ENTER to continue ...%N")
			io.read_line
			if is_exiting then
				(create {EXCEPTIONS}).die (0)
			end
		end

	launch_ec is
			-- Launch ec process
		local
			command_line: ARGUMENTS
			cwd: STRING
			args_ec_offset: INTEGER
			args: LIST [STRING]
			i: INTEGER
			s: STRING
			fn: FILE_NAME
			file: RAW_FILE
		do
				--| First we check if there is no specific `estudio' parameters
			command_line := Execution_environment.command_line
			if
				command_line.argument_count - args_ec_offset > 0
				and then (command_line.argument (1 + args_ec_offset).is_equal ("/?")
				or else	command_line.argument (1 + args_ec_offset).is_equal ("/h"))
			then
				display_usage (True)
			end
			if
				command_line.argument_count - args_ec_offset > 0
				and then command_line.argument (1 + args_ec_offset).is_equal ("/v")
			then
				is_verbose := True
				is_waiting := True
				args_ec_offset := args_ec_offset + 1
			end
			if
				command_line.argument_count - args_ec_offset > 0
				and then command_line.argument (1 + args_ec_offset).is_equal ("/w")
			then
				is_waiting := True
				args_ec_offset := args_ec_offset + 1
			end


				--| Now get the estudio environment and arguments for `ec'
			get_environment
			check_environment
			if is_environment_valid then
				display_splasher

					--| Compute command line, args, and working directory
				create {ARRAYED_LIST [STRING]} args.make (command_line.argument_count + 1)
				args.extend ("-from_bench")

				if command_line.argument_count - args_ec_offset > 0 then
						--| And now we get the parameters for EiffelStudio

					if command_line.argument_count - args_ec_offset = 1 then
							--| use the -config argument
						args.extend ("-config")
						s := command_line.argument (1 + args_ec_offset).twin

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
						args.extend (s)
					elseif command_line.argument_count - args_ec_offset >= 1  then
						args.fill (command_line.argument_array.subarray (1 + args_ec_offset,
										command_line.argument_count))
						from
							args.start
						until
							args.after
						loop
							s := args.item
							if
								s.is_equal ("-config")
								or s.is_equal ("-project_path")
								or s.is_equal ("-target")
							then
								if not args.after then
									args.forth
									s := args.item
									if s.has (' ') and then not s.has ('"') then
										s.left_adjust
										s.right_adjust
										s.prepend_character ('"')
										s.append_character ('"')
									end
								end
							end
							args.forth
						end
					end
				end
				if is_verbose then
					io.output.put_string ("*** estudio is using the following data : %N")
					io.output.put_string (" ISE_EIFFEL   = " + ise_eiffel + "%N")
					io.output.put_string (" ISE_PLATFORM = " + ise_platform + "%N")
					io.output.put_string (" Path to ec   = " + ec_path + "%N")
					io.output.put_string (" Arguments    = ")
					from
						args.start
					until
						args.after
					loop
						io.output.put_string (args.item + " ")
						args.forth
					end
					io.output.put_new_line
					io.output.put_new_line
				end
				start_process (ec_path, args, working_directory)
			end
		end

	start_process (cmd: STRING; args: LIST [STRING]; dir: STRING) is
			-- Start process using command `cmd' and arguments `args'
			-- in the working directory `dir'
		require
			is_environment_valid: is_environment_valid
		local
			process: PROCESS
		do
			process := process_factory.process_launcher (ec_path, args, dir)
			process.set_hidden (False)
			process.set_separate_console (False)
			process.set_detached_console (True)

			debug ("launcher")
				process.redirect_output_to_agent (agent on_output)
				process.set_on_fail_launch_handler (agent on_event ("Failed"))
				process.set_on_successful_launch_handler (agent on_event ("Succeed"))
				process.set_on_start_handler (agent on_event ("Started"))
				process.set_on_exit_handler (agent on_event ("Exited"))
				process.set_on_terminate_handler (agent on_event ("Terminated"))
			end
			if is_waiting then
				process.set_on_exit_handler (agent exit_launcher)
			end

			process.launch
			if not process.launched or not is_waiting then
				exit_launcher
			end
		end

	exit_launcher is
		do
			-- Bye bye
		end

feature -- Splash

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
			if not retried then
				create s.make_empty
				s.append_code (169)
				s.append_string_general (" 2006  Eiffel Software ")

				splasher := new_splasher (s)

				create fn.make_from_string (ise_eiffel)
				fn.extend_from_array (<<"studio", "bitmaps", "png">>)
				fn.set_file_name ("splash.png")
				if file_exists (fn) then
					splasher.set_splash_pixmap_filename (fn)
				end

				debug ("launcher")
					splasher.set_debug_text ("This is an experimental version")
				end
				splasher.show
			else
				if splasher /= Void then
					close_splasher
				end
			end
		rescue
			retried := True
			retry
		end

	close_splasher is
		do
			if splasher /= Void then
				splasher.close
				splasher := Void
			end
		end

feature -- Properties

	is_waiting: BOOLEAN
			-- Stay alive until `ec' exits ?

	is_verbose: BOOLEAN
			-- Display details ?

feature -- Environment

	get_environment is
			-- Get environment variables
		local
			s: STRING
		do
			ise_eiffel := implementation.ise_eiffel_value
			ise_platform := implementation.ise_platform_value
			ec_name := Execution_environment.get ("EC_NAME")
			s := Execution_environment.get ("EC_FOLDER")
			if s /= Void then
				create ec_directory.make_from_string (s)
			end

			if ec_directory /= Void and then ec_name /= Void then
				create ec_path.make_from_string (ec_directory)
			end

			if ec_name /= Void then
				s := Execution_environment.get ("MELTED_PATH")
				if s /= Void then
					create melted_path.make_from_string (s)
				end
			else
				ec_name := "ec"
				if is_windows then
					ec_name.append_string (".exe")
				end
			end

			if
				ec_path = Void
				and then ise_eiffel /= Void and then ise_platform /= Void
			then
				create ec_path.make_from_string (ise_eiffel)
				ec_path.extend_from_array (<<"studio", "spec", ise_platform, "bin">>)
			end

			if melted_path = Void then
				create working_directory.make_from_string (ec_path)
			else
				create working_directory.make_from_string (melted_path)
			end

			ec_path.set_file_name (ec_name)

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
			if ise_eiffel = Void then
				is_environment_valid := False
				m.append_string ("%N")
				m.append_string ("Variable ISE_EIFFEL is not defined")
			end

			if not directory_exists (ise_eiffel) then
				is_environment_valid := False
				m.append_string ("%N")
				m.append_string ("Variable ISE_EIFFEL does not point to a valid directory")
			end

			if ise_platform = Void then
				is_environment_valid := False
				m.append_string ("%N")
				m.append_string ("Variable ISE_PLATFORM is not defined")
			end

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
			end
		end

	is_environment_valid: BOOLEAN
			-- Is current environment valid ?

	ise_eiffel,
	ise_platform,
	ec_name: STRING
	melted_path,
	ec_directory: DIRECTORY_NAME
	ec_path: FILE_NAME
	working_directory: DIRECTORY_NAME

feature {NONE} -- Events

	on_output (s: STRING) is
		do
			debug ("launcher")
				io.put_string ("Output["+ s +"]%N")
			end
		end

	on_event (t: STRING) is
		do
			debug ("launcher")
				io.put_string (t + "%N")
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
