indexing
	description: "Interface for the Eiffel compiler"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPILER

inherit
	CEIFFEL_COMPILER_COCLASS_IMP
		redefine
			make,
			compile,
			compile_to_pipe,
			freezing_occurred,
			compiler_version,
			generate_msil_key_file_name,
			Freeze_command_name,
			freeze_command_arguments,
			remove_file_locks,
			has_signable_generation,
			expand_path,
			can_run,
			set_display_warnings,
			set_discard_assertions,
			was_compilation_successful
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

	EXCEPTIONS
		export
			{NONE} all
		end

	SHARED_PROJECT_PROPERTIES
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize structure.
		do
			was_compilation_successful := False
			create last_error_message.make_from_string ("System has not been compiled")
			display_warnings := True
			discard_assertions := False
			set_compiler (Current)
		end

feature -- Access

	was_compilation_successful: BOOLEAN
			-- Was last compilation successful?

	last_error_message: STRING
			-- Last error message.

	compiler_version: STRING is
			-- Compiler version.
		do
			Result := Version_number
		end
		
	is_output_piped: BOOLEAN
		-- is compiler output piped?
		
	output_pipe_name: STRING
		-- name of pipe for output

	expand_path (a_path: STRING): STRING is
			-- Epxand all env vars in 'a_path'
		require else
			non_void_path: a_path /= Void
		local
			var: STRING
			formatted_var: STRING
			dollar_pos: INTEGER
			slash_pos: INTEGER
			parth_pos: INTEGER
			next_dollar_pos: INTEGER
			env_var: STRING
			env: EXECUTION_ENVIRONMENT
		do
			create env
			Result := clone(a_path)
			
			if not Result.is_empty then
				Result.replace_substring_all ("/", "\")
				
				dollar_pos := Result.index_of ('$', 1)
				if dollar_pos > 0 then
					from 
					until
						dollar_pos = 0
					loop
						-- look for '\'
						slash_pos := Result.index_of ('\', dollar_pos + 1)
						
						-- now look for ) and return the first
						-- allows for $(ENV)Ext\...
						parth_pos := Result.index_of (')', dollar_pos + 1)
						
						-- look or $ as path could be $var1$var2
						next_dollar_pos := Result.index_of ('$', dollar_pos + 1)
	
						if slash_pos > 0 then
							if parth_pos > 0 then
								slash_pos := slash_pos.min (parth_pos + 1)
							end
							if next_dollar_pos > 0 then
								slash_pos := slash_pos.min (next_dollar_pos)
							end
						elseif parth_pos > 0 then
							if next_dollar_pos > 0 then
								slash_pos := parth_pos.min (next_dollar_pos)
							else
								slash_pos := parth_pos + 1
							end
						else
							if next_dollar_pos > 0 then
								slash_pos := next_dollar_pos
							else
								slash_pos := Result.count + 1
							end
						end
						
						var := Result.substring (dollar_pos, slash_pos - 1)
						
						-- remove the () and $
						formatted_var := clone(var);
						formatted_var.prune_all('(')
						formatted_var.prune_all(')')
						formatted_var.prune_all_leading('$')
						
						env_var := env.get (formatted_var)
						if env_var /= Void and then env_var.count > 0 then
							Result.replace_substring_all (var, env_var)
						end
						if dollar_pos + 1 <= Result.count then
							dollar_pos := Result.index_of ('$', dollar_pos + 1)
						else
							dollar_pos := 0
						end
					end
				end
			end
		end
		
	shrink_path (a_path: STRING): STRING is
			-- Shrink the given path to use the common know Eiffel env vars
		do
			Result := clone (a_path)
		end
	
	has_signable_generation: BOOLEAN is
			-- Does the compiler allow for assemblies to be signed
		do
			Result := feature {EIFFEL_ENV}.has_signable_generation
		end

feature -- Basic Operations

	can_run: BOOLEAN is
			-- Can product be run.
		local
			checker: ACTIVATION_CHECKER
		do
			create checker
			checker.check_activation
			Result := checker.can_run or checker.is_licensed
		end
		
	compile (mode: INTEGER) is
			-- Compile.
		local
			rescued: BOOLEAN
		do
			was_compilation_successful := False
			if not rescued then
				if not Eiffel_project.is_compiling then
					if is_output_piped then
						-- compile to named pipe
						set_piped_output (output_pipe_name)
						event_begin_compile
					else
						-- Compile to standard output
						set_default_output
						event_begin_compile
					end
					
					-- perform compilation defined by `mode'
					inspect mode
					when feature {ECOM_EIF_COMPILATION_MODE_ENUM}.eif_compilation_mode_workbench then
						Eiffel_project.melt
					when feature {ECOM_EIF_COMPILATION_MODE_ENUM}.eif_compilation_mode_finalize then
						Eiffel_project.finalize (discard_assertions)
					when feature {ECOM_EIF_COMPILATION_MODE_ENUM}.eif_compilation_mode_precompile then
						Eiffel_project.precompile (True)
					end
					
					-- close output pipe for piped output
					if is_output_piped then
						close_output_pipe
					end
					
					if Eiffel_project.successful then
						was_compilation_successful := True
					end
					event_end_compile (was_compilation_successful)
				end
			else
				output_error
				event_end_compile (False)
			end
		rescue
			last_exception := exception_trace
			close_output_pipe
			rescued := True
			retry
		end
		
	compile_to_pipe (mode: INTEGER; pipe_name: STRING) is
			-- compile to pipe - returns pipe name
		require else
			non_void_output_pipe_name: pipe_name /= Void
			valid_output_pipe_name: not pipe_name.is_empty
		do
			output_pipe_name := Eiffel_ace.file_name
			is_output_piped := True
			main_window.process_compile (mode)
		ensure then
			output_is_piped: is_output_piped
		end
		
	generate_msil_key_file_name (filename: STRING) is
			-- Generate an MSIL cryptographic key file
		require else
			filename_exists: filename /= Void
			valid_filename: not filename.is_empty
		local
			l_result, key_size: INTEGER
			public_key: POINTER
			file: RAW_FILE
		do
			l_result := feature {MD_STRONG_NAME}.strong_name_key_gen (default_pointer, 0, $public_key, $key_size)
			if l_result = 1 then
				create file.make (filename)
				if not file.exists then
					file.open_write ()
					file.put_data (public_key, key_size)
					file.close
				end
				feature {MD_STRONG_NAME}.strong_name_free_buffer (public_key)	
			end

		end
		
	freezing_occurred: BOOLEAN is
			-- Did last compile warrant a call to finish_freezing?
		do
			if Eiffel_project.Workbench.successful then
				Result := Eiffel_project.freezing_occurred
			end
		end
		
	Freeze_command_name: STRING is
			-- Retrieve environment variable `a_env'.
		once
			Result := "%"" + (create {EIFFEL_ENV}).Eiffel_installation_dir_name + Freeze_command_relative_path + Com_freeze_command_prefix + (create {PLATFORM_CONSTANTS}).Finish_freezing_script + "%""
		end
	
	Com_freeze_command_prefix: STRING is "c"
			-- Prefix of com compiler's finish_freezing utility

	Freeze_command_arguments: STRING is
			-- Retrieve command-line arguments needed by Freeze command.
		once
			Result := Freeze_command_name + " -vs -silent"
		end

	Freeze_command_relative_path: STRING is "\Studio\spec\windows\bin\"
			-- Path to `finish_freezing.exe' in installation

	remove_file_locks is
			-- Close the open EIFGEN files so that they may be removed by another compiler instance.
		do
			if Workbench.system_defined then
				System.server_controler.wipe_out
			end
		end

feature -- Element Change

	set_output_pipe_name (a_name: STRING) is
			-- set 'output_pipe_name' to 'a_name'
		require else
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			output_pipe_name := clone (a_name)
		ensure then
			output_pipe_name_set: output_pipe_name.is_equal (a_name)
		end
		
	set_display_warnings (display: BOOLEAN) is
			-- set `display_warnings' to `display'
		do
			display_warnings := display
		ensure then
			display_warnings_set: display_warnings = display
		end
		
	set_discard_assertions (discard: BOOLEAN) is
			-- set `discard_assertions' to `discard'
		do
			discard_assertions := discard
		ensure then
			discard_assertions_set: discard_assertions = discard
		end		
		
feature {PROJECT_MANAGER, COMPILER_TESTER} -- Element Change

	set_output_to_console is
			-- set compiler output to output to console
		do
			--create compiler_degree_output
		end
		
feature {NONE} -- Implementation

	set_piped_output (a_pipe_name: STRING) is
			-- set correct output object for output type (piped or not piped)
		require
			non_void_pipe_name: a_pipe_name /= Void
			valid_pipe_name: not a_pipe_name.is_empty
			pipe_already_open: output_pipe /= Void implies output_pipe.input_closed
		local
			l_degree_output: COM_PIPED_DEGREE_OUTPUT
			l_err_displayer: DEFAULT_ERROR_DISPLAYER
			l_output_win: COM_PIPED_OUTPUT_WINDOW
		do
			if not Eiffel_project.is_compiling then
				create output_pipe.make_named (a_pipe_name, feature {WEL_PIPE}.outbound)
				create l_degree_output.make (output_pipe)
				create l_output_win.make (output_pipe)
				create l_err_displayer.make (l_output_win)
				Eiffel_project.set_degree_output (l_degree_output)
				Eiffel_project.set_error_displayer (l_err_displayer)
			end
		end
		
	close_output_pipe is
			-- close output pipe
		do
			if output_pipe /= Void then
				output_pipe.close
			end
		end
		
	set_default_output is
			-- set output to default
		local
			l_degree_output: COM_DEGREE_OUTPUT
			l_err_displayer: VS_ERROR_DISPLAYER
			l_output_win: COM_ERROR_WINDOW
		do
			if not Eiffel_project.is_compiling then
				create l_degree_output.make (Current)
				create l_output_win.make (Current)
				create l_err_displayer.make_with_coclass (l_output_win, Current)
				l_err_displayer.set_display_warnings (display_warnings)
				Eiffel_project.set_degree_output (l_degree_output)
				Eiffel_project.set_error_displayer (l_err_displayer)
			end
		end
		
	output_error is
			-- Report error back to VS.
		require
			failed: not was_compilation_successful
		do
			if last_exception /= Void then
				event_output_string (last_exception)
			end
			event_output_string ("%NCompilation stopped%N")
		end

	last_exception: STRING
			-- Last exception trace
			
	output_pipe: WEL_PIPE
			-- pipe to send output to
			
	display_warnings: BOOLEAN
			-- should warnings be displayed?
	
	discard_assertions: BOOLEAN
			-- should assertions be discard when finalize?
				
end -- class COMPILER
