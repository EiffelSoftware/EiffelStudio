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
			freezing_occurred,
			compiler_version,
			Freeze_command_name,
			freeze_command_arguments,
			remove_file_locks
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SYSTEM_CONSTANTS
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

feature -- Basic Operations

	compile is
			-- Compile.
		local
			rescued: BOOLEAN
		do
			is_successful := False
			if not rescued then
				if not Eiffel_project.is_compiling then
					Eiffel_project.melt

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
		
	finalize is
			-- Finalize
		local
			rescued: BOOLEAN
		do
			is_successful := False
			if not rescued then
				if not Eiffel_project.is_compiling then
					Eiffel_project.finalize (False)
				end
			else
				event_output_string ("Compilation stopped%N")
			end
		rescue
			rescued := True
			retry
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
		local
			freeze_command: STRING
		once
			freeze_command := Eiffel_project.Freeze_command_name
			Result := freeze_command + ".exe"
		end
		
	Freeze_command_arguments: STRING is
			-- Retrieve command-line arguments needed by Freeze command.
		do
			Result := clone (freeze_command_name + " -silent -vs")
		end
		
	remove_file_locks is
			-- Close the open EIFGEN files so that they may be removed by another compiler instance.
		do
			Eiffel_system.System.server_controler.wipe_out
		end
		
end -- class COMPILER