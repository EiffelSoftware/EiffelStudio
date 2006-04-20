indexing
	description: "Interface for the Eiffel compiler"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			can_run,
			set_display_warnings,
			set_discard_assertions,
			was_compilation_successful,
			set_quick_finalization
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
					when feature {ECOM_EIF_COMPILATION_MODE_ENUM}.eif_compilation_mode_freeze then
						Eiffel_project.freeze
					when feature {ECOM_EIF_COMPILATION_MODE_ENUM}.eif_compilation_mode_finalize then
						Eiffel_project.finalize (not discard_assertions)
					when feature {ECOM_EIF_COMPILATION_MODE_ENUM}.eif_compilation_mode_precompile then
						Eiffel_project.precompile (True)
					when feature {ECOM_EIF_COMPILATION_MODE_ENUM}.eif_compilation_mode_finalized_precompile then
						Eiffel_project.finalize_precompile (True, not discard_assertions)
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
			l_gen: IL_KEY_GENERATOR
		do
			create l_gen
			l_gen.generate_key (filename)
			if not l_gen.successful then
				raise (l_gen.error_message)
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
			Result := Freeze_command_name + " -vs -silent"
		end

	Freeze_command_relative_path: STRING is "\envision\spec\windows\bin\"
			-- Path to `finish_freezing.exe' in installation

	remove_file_locks is
			-- Close the open EIFGEN files so that they may be removed by another compiler instance.
		do
			if Workbench.system_defined then
				System.server_controler.wipe_out
			end
		end

	set_quick_finalization is
			-- Skip generation of single class modules
		do
			Eiffel_project.comp_system.set_il_quick_finalization
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
	
	discard_assertions: BOOLEAN;
			-- should assertions be discard when finalize?
				
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
end -- class COMPILER
