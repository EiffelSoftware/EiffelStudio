indexing
	description	: "System's root class"
	note		: "Initial version automatically generated"

class
	ROOT_CLASS

creation
	make

feature {NONE} -- Initialization

	make (args: ARRAY [STRING]) is
			-- Creation procedure.
		require
			valid_count: args.count >= 5
			--valid_separators: merged_string (args).occurrences (separator) = 6
		do
			create exec_env
			parse_arguments (args)
			initialize_borland
			create_project_directory
			shell_name := exec_env.get ("COMSPEC")
			exec_env.change_working_directory (install_dir)
			precompile_libraries
			exec_env.change_working_directory (install_dir)
			install_dotnet
		ensure
			initialized: initialized
		end

	parse_arguments (args: ARRAY [STRING]) is
			-- Parse the arguments of the command line.
		do
			create precompilation_params.make (10)
			precompilation_params.append (args @ 1)
			precompilation_params.append_character (' ')
			precompilation_params.append (args @ 2)
			install_dir := args @ 3
			project_directory := args @ 4
			dotnet_cmd_line := args @ 5
			c_compiler := args @ 6
		ensure
			initialized: initialized
		end

feature -- Actions

	initialize_borland is
			-- Create the bcc32.cfg and ilink32.cfg files needed by the Borland compiler, if needed.
		local
			f: PLAIN_TEXT_FILE
			fn1, fn2: FILE_NAME
			txt: STRING
			retried: BOOLEAN
		do
			if not retried and then c_compiler.is_equal ("UseBorland") then
				io.put_string ("Configuring the Borland compiler%N")
				create fn1.make_from_string (install_dir)
				fn1.extend ("BCC55")
				fn1.extend ("Bin")
				if (create {DIRECTORY}.make (fn1)).exists then
						-- bcc32.cfg file.
					fn2 := clone (fn1)
					fn2.set_file_name ("bcc32.cfg")
					txt := "-DWINVER=0x400 -I$(ISE_EIFFEL)BCC55\include -L$(ISE_EIFFEL)BCC55\lib %
							%-L$(ISE_EIFFEL)BCC55\lib\PSDK"
					txt.replace_substring_all ("$(ISE_EIFFEL)", install_dir)
					create f.make_open_write (fn2)
					f.put_string (txt)
					f.close

						-- ilink32.cfg file.
					fn2 := clone (fn1)
					fn2.set_file_name ("ilink32.cfg")
					txt := "-L$(ISE_EIFFEL)BCC55\lib -L$(ISE_EIFFEL)BCC55\lib\PSDK"
					txt.replace_substring_all ("$(ISE_EIFFEL)", install_dir)
					create f.make_open_write (fn2)
					f.put_string (txt)
					f.close
				end
			end
		rescue
			retried := True
			retry
		end

	create_project_directory is
			-- Create the new project directory.
		require
			valid_project_dir: initialized
		local
			retried: BOOLEAN
		do
				--| FIXME XR: allow recursive creation.
			if not retried then
				io.putstring ("Creating the project directory%N")
				(create {DIRECTORY}.make (project_directory)).create_dir
			end
		rescue
			retried := True
			retry
		end

	install_dotnet is
			-- Invoke the batch file that configures .NET.
		require
			initialized: initialized
		do
			if dotnet_cmd_line.is_equal ("InstallDotNet") then
				io.putstring ("Registering the .NET components%N")
				exec_env.launch (shell_name + " /c call " + install_dir + "\install_dotnet.bat")
			end
		end

	precompile_libraries is
			-- Invoke the batch file that precompiles the selected libraries.
		require
			initialized: initialized
		local
			lib: STRING
		do
			lib := clone (precompilation_params)
			lib.tail (4)
			if not lib.is_equal ("none") then
				io.putstring ("Precompiling the libraries%N")
				exec_env.launch (shell_name + " /c call " + install_dir + "\precompile_install.bat " + precompilation_params)
			end
		end

feature -- Status report

	initialized: BOOLEAN is
			-- Has the command line been parsed successfully?
		do
			Result := install_dir /= Void and
						project_directory /= Void and
						dotnet_cmd_line /= Void and
						precompilation_params /= Void and
						c_compiler /= Void
		end

feature {NONE} -- Implementation

	exec_env: EXECUTION_ENVIRONMENT
			-- Environment used to perform calls and get/set environment variables.

	install_dir: STRING
			-- Installation directory.
	
	shell_name: STRING
			-- Name of the command that must be invoked to launch batch files.
	
	project_directory: STRING
			-- Name of the directory that should receive the new projects.
	
	dotnet_cmd_line: STRING
			-- Command line that should be called to initialize .NET.

	precompilation_params: STRING
			-- Parameters linked to the precompilations.

	c_compiler: STRING
			-- C compiler used by Eiffel (UseMicrosoft or UseBorland).

	separator: CHARACTER is '"'
			-- Character used to separate command line arguments.

	merged_string (args: ARRAY [STRING]): STRING is
			-- Concatenates all strings in `args'.
		require
			valid_params: args /= Void
		local
			i: INTEGER
		do
			create Result.make (200)
			from
				i := 1
			until
				i > args.count
			loop
				Result.append (args @ i)
				Result.append_character (' ')
			end
		end

end -- class ROOT_CLASS
