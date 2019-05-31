note
	description: "Boogie executable for Windows."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_PLATFORM_EXECUTABLE_IMPL

inherit

	E2B_PLATFORM_EXECUTABLE
		redefine
			default_create
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		redefine
			default_create
		end

feature {NONE} -- Implementation

	default_create
			-- Initialize Windows executable.
		do
			boogie_file_name := default_boogie_code_file_name
			boogie_output_file_name := default_boogie_output_file_name
			create input.make
		end

feature {NONE} -- Implementation

	boogie_file_name: PATH
			-- <Precursor>

	boogie_output_file_name: PATH
			-- <Precursor>

	boogie_executable: READABLE_STRING_32
			-- <Precursor>
		local
			p: PATH
		once
				-- 0. Assume it's in the PATH.
			Result := {STRING_32} "boogie" + {EIFFEL_LAYOUT}.eiffel_layout.executable_suffix
			if {EIFFEL_LAYOUT}.is_eiffel_layout_defined then
					-- 1. Look in the installation directory.
				p := {EIFFEL_LAYOUT}.eiffel_layout.tools_path.extended ("boogie").extended (Result)
				if (create {RAW_FILE}.make_with_path (p)).exists then
					Result := p.name
				end
			end
		end

	default_boogie_code_file_name: PATH
			-- File name for Boogie code file.
		do
			Result := system.eiffel_project.project_directory.target_path.extended ("Proofs").extended ("autoproof" + unique_number.out + ".bpl")
		end

	default_boogie_output_file_name: PATH
			-- File name for Boogie output file.
		do
			Result := system.eiffel_project.project_directory.target_path.extended ("Proofs").extended ("output" + unique_number.out + ".txt")
		end

	global_counter: CELL [INTEGER]
		once
			create Result.put (0)
		end

	unique_number: INTEGER
		do
			Result := global_counter.item
			global_counter.put (Result + 1)
		end

end
