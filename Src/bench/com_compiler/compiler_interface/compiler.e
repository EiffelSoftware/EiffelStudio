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
			is_successful,
			compile,
			finalize,
			precompile,
			compile_to_pipe,
			finalize_to_pipe,
			precompile_to_pipe,
			freezing_occurred,
			compiler_version,
			generate_msil_keyfile,
			Freeze_command_name,
			freeze_command_arguments,
			remove_file_locks,
			has_signable_generation,
			expand_path,
			is_output_piped,
			output_pipe_name,
			set_output_pipe_name,
			compile_to_pipe_user_precondition,
			finalize_to_pipe_user_precondition,
			precompile_to_pipe_user_precondition,
			generate_msil_keyfile_user_precondition,
			expand_path_user_precondition,
			set_output_pipe_name_user_precondition,
			can_run
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

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize structure.
		do
			is_successful := False
			create last_error_message.make_from_string ("System has not been compiled")
			
			set_compiler (Current)
		end

feature -- Access

	is_successful: BOOLEAN
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
			Result := a_path.clone(a_path)
			
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
						formatted_var := var.clone(var);
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
			Result := checker.can_run
		end
		
	compile is
			-- Compile.
		local
			rescued: BOOLEAN
			l_pipe: WEL_PIPE
		do
			is_successful := False
			if not rescued then
				if not Eiffel_project.is_compiling then
					if is_output_piped then
						create l_pipe.make_named (output_pipe_name, feature {WEL_PIPE}.outbound)
						set_piped_output (l_pipe)
						Eiffel_project.melt
						l_pipe.close
					else
						set_default_output
						Eiffel_project.melt
					end
					if Eiffel_project.successful then
						is_successful := True
					end
				end
			else
				output_error
			end
		rescue
			last_exception := exception_trace
			rescued := True
			retry
		end
		
	compile_to_pipe is
			-- compile to pipe - returns pipe name
		require
			non_void_output_pipe_name: output_pipe_name /= Void
			valid_output_pipe_name: not output_pipe_name.is_empty
		do
			output_pipe_name := Eiffel_ace.file_name
			is_output_piped := True
			main_window.process_compile
		ensure
			output_is_piped: is_output_piped
		end
		
	finalize is
			-- Finalize
		local
			rescued: BOOLEAN
			l_pipe: WEL_PIPE
		do
			is_successful := False
			if not rescued then
				if not Eiffel_project.is_compiling then
					if is_output_piped then
						create l_pipe.make_named (output_pipe_name, feature {WEL_PIPE}.outbound)
						set_piped_output (l_pipe)
						Eiffel_project.finalize (False)
						l_pipe.close
					else
						set_default_output
						Eiffel_project.finalize (False)
					end
					if Eiffel_project.successful then
						is_successful := True
					end
				end
			else
				output_error
			end
		rescue
			last_exception := exception_trace
			rescued := True
			retry
		end
		
	finalize_to_pipe is
			-- finalize to pipe - returns pipe name
		require
			non_void_output_pipe_name: output_pipe_name /= Void
			valid_output_pipe_name: not output_pipe_name.is_empty
		do
			is_output_piped := True
			main_window.process_finalize
		ensure
			output_is_piped: is_output_piped
		end
	
	precompile is
			-- Precompile
		local
			rescued: BOOLEAN
			l_pipe: WEL_PIPE
		do
			is_successful := False
			if not rescued then
				if not Eiffel_project.is_compiling then
					if is_output_piped then
						create l_pipe.make_named (output_pipe_name, feature {WEL_PIPE}.outbound)
						set_piped_output (l_pipe)
						Eiffel_project.precompile (True)
						l_pipe.close
					else
						set_default_output
						Eiffel_project.precompile (True)
					end
					if Eiffel_project.successful then
						is_successful := True
					end
				end
			else
				output_error
			end
		rescue
			last_exception := exception_trace
			rescued := True
			retry
		end
		
	precompile_to_pipe is
			-- precompile to pipe - returns pipe name
		require else
			non_void_output_pipe_name: output_pipe_name /= Void
			valid_output_pipe_name: not output_pipe_name.is_empty
		do
			is_output_piped := True
			main_window.process_precompile
		ensure
			output_is_piped: is_output_piped
		end
		
	generate_msil_keyfile (filename: STRING) is
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
			Result := Freeze_command_name + " -silent -vs"
		end

	Freeze_command_relative_path: STRING is "\Studio\spec\windows\bin\"
			-- Path to `finish_freezing.exe' in installation

	remove_file_locks is
			-- Close the open EIFGEN files so that they may be removed by another compiler instance.
		do
			if Eiffel_system.System.server_controler /= Void then
				Eiffel_system.System.server_controler.wipe_out
			end
		end

feature -- Element Change

	set_output_pipe_name (a_name: STRING) is
			-- set 'output_pipe_name' to 'a_name'
		require else
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			output_pipe_name := a_name.clone (a_name)
		ensure
			output_pipe_name_set: output_pipe_name.is_equal (a_name)
		end
		
feature {PROJECT_MANAGER, COMPILER_TESTER} -- Element Change

	set_output_to_console is
			-- set compiler output to output to console
		do
			--create compiler_degree_output
		end
		
feature -- User Preconditions

	expand_path_user_precondition (a_path: STRING): BOOLEAN is
			-- expand_path precondition
		do
			Result := False
		end
		
	generate_msil_keyfile_user_precondition (filename: STRING): BOOLEAN is
			-- generate_msil_keyfile precondition
		do
			Result := False
		end
		
	set_output_pipe_name_user_precondition (return_value: STRING): BOOLEAN is
			-- set_output_pipe_name precondition
		do
			Result := False
		end
		
	compile_to_pipe_user_precondition: BOOLEAN is
			-- compile_to_pipe precondition
		do
			Result := False
		end
		
	finalize_to_pipe_user_precondition: BOOLEAN is
			-- finalize_to_pipe precondition
		do
			Result := False
		end
	
	precompile_to_pipe_user_precondition: BOOLEAN is
			-- precompile_to_pipe precondition
		do
			Result := False
		end
		
feature {NONE} -- Implementation

	set_piped_output (a_pipe: WEL_PIPE) is
			-- set correct output object for output type (piped or not piped)
		require
			non_void_pipe: a_pipe /= Void
			input_pipe_open: not a_pipe.input_closed
		local
			l_degree_output: COM_PIPED_DEGREE_OUTPUT
			l_err_displayer: DEFAULT_ERROR_DISPLAYER
			l_output_win: COM_PIPED_OUTPUT_WINDOW
		do
			if not Eiffel_project.is_compiling then
				create l_degree_output.make (a_pipe)
				create l_output_win.make (a_pipe)
				create l_err_displayer.make (l_output_win)
				Eiffel_project.set_degree_output (l_degree_output)
				Eiffel_project.set_error_displayer (l_err_displayer)
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
				Eiffel_project.set_degree_output (l_degree_output)
				Eiffel_project.set_error_displayer (l_err_displayer)
			end
		end
		
	output_error is
			-- Report error back to VS.
		require
			failed: not is_successful
		do
			if last_exception /= Void then
				event_output_string (last_exception)
			end
			event_output_string ("%NCompilation stopped%N")
		end

	last_exception: STRING
			-- Last exception trace
				
end -- class COMPILER