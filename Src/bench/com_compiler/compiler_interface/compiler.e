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
			compiler_version
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
			e_displayer: DEFAULT_ERROR_DISPLAYER
			err_win: COM_ERROR_WINDOW
		do
			create output.make (Current)
			create err_win.make (Current)
			create e_displayer.make (err_win)
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
					end
				end
			else
				event_output_string ("Compilation stopped%N")
			end
		rescue
			rescued := True
			retry
		end
		
end -- class COMPILER
