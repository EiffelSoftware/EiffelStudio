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
			set_output_pipe_name
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SYSTEM_CONSTANTS
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
		local
			output: COM_DEGREE_OUTPUT
			e_displayer: VS_ERROR_DISPLAYER
			err_win: COM_ERROR_WINDOW
		do
			create output.make (Current)
			create err_win.make (Current)
			create e_displayer.make_with_coclass (err_win, Current)
			Eiffel_project.set_degree_output (output)
			Eiffel_project.set_error_displayer (e_displayer)
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
			-- Epxand all env vars in the given path
		local
			var: STRING
			formatted_var: STRING
			dollar_pos: INTEGER
			slash_pos: INTEGER
			parth_pos: INTEGER
			env_var: STRING
			env: EXECUTION_ENVIRONMENT
		do
			create env
			Result := a_path.clone(a_path)
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
					
					if parth_pos > 0 then
						-- if ) has been found
						if slash_pos > 0 then
							-- if the ) comes before \
							if parth_pos < slash_pos then
								slash_pos := parth_pos + 1
							end
						else
							slash_pos := parth_pos + 1
						end
					else
						-- if there is no () then use the \
						if slash_pos = 0 then
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
					dollar_pos := Result.index_of ('$', 1)
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
						Eiffel_project.set_degree_output (create {COM_PIPED_DEGREE_OUTPUT}.make (l_pipe))
						Eiffel_project.melt
						l_pipe.close
					else
						Eiffel_project.set_degree_output (create {COM_DEGREE_OUTPUT}.make (current))
						Eiffel_project.melt
					end
				if Eiffel_project.Workbench.successful then
						is_successful := True					
					else
					end
				end
			else
				event_output_string ("Compilation stopped%N")
			end
		rescue
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
						Eiffel_project.set_degree_output (create {COM_PIPED_DEGREE_OUTPUT}.make (l_pipe))
						Eiffel_project.finalize (False)
						l_pipe.close
					else
						Eiffel_project.set_degree_output (create {COM_DEGREE_OUTPUT}.make (current))
						Eiffel_project.finalize (False)
					end
				end
			else
				event_output_string ("Compilation stopped%N")
			end
		rescue
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
						Eiffel_project.set_degree_output (create {COM_PIPED_DEGREE_OUTPUT}.make (l_pipe))
						Eiffel_project.precompile (True)
						l_pipe.close
					else
						Eiffel_project.set_degree_output (create {COM_DEGREE_OUTPUT}.make (current))
						Eiffel_project.precompile (True)
					end
				end
			else
				event_output_string ("Compilation stopped%N")
			end
		rescue
			rescued := True
			retry
		end
		
	precompile_to_pipe is
			-- precompile to pipe - returns pipe name
		require
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
			Result := "%"" + (create {EIFFEL_ENV}).Eiffel_installation_dir_name + Freeze_command_relative_path + (create {PLATFORM_CONSTANTS}).Finish_freezing_script + "%""
		end
		
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
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			output_pipe_name := a_name.clone (a_name)
		ensure
			output_pipe_name_set: output_pipe_name.is_equal (a_name)
		end
		
		
end -- class COMPILER