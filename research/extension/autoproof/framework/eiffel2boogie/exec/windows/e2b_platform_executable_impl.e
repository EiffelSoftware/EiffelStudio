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
			model_file_name := default_model_file_name
			create input.make
		end

feature {NONE} -- Implementation

	boogie_file_name: attached STRING
			-- <Precursor>

	boogie_output_file_name: attached STRING
			-- <Precursor>

	model_file_name: attached STRING
			-- <Precursor>

	boogie_executable: attached STRING
			-- <Precursor>
		local
			l_ee: EXECUTION_ENVIRONMENT
--			l_registry: WEL_REGISTRY
--			l_registry_value: WEL_REGISTRY_KEY_VALUE
			l_possible_paths: LINKED_LIST [PATH]
			l_ise_eiffel, l_eiffel_src: STRING
			l_file: RAW_FILE
			l_path: PATH
		once
			create Result.make_empty
			create l_possible_paths.make
			create l_ee

				-- 1. Delivery of installation
			l_ise_eiffel := l_ee.get ("ISE_EIFFEL")
			if l_ise_eiffel /= Void then
				create l_path.make_from_string (l_ise_eiffel)
				l_possible_paths.extend (l_path.extended ("studio").extended ("tools").extended ("boogie").extended ("Boogie.exe"))
			end

				-- 2. Delivery of development version
			l_eiffel_src := l_ee.get ("EIFFEL_SRC")
			if l_eiffel_src /= Void then
				create l_path.make_from_string (l_eiffel_src)
				l_possible_paths.extend (l_path.extended ("Delivery").extended ("studio").extended ("tools").extended ("boogie").extended ("Boogie.exe"))
				l_possible_paths.extend (l_path.extended ("..").extended ("Delivery").extended ("studio").extended ("tools").extended ("boogie").extended ("Boogie.exe"))
			end

			from
				l_possible_paths.start
			until
				l_possible_paths.after or else not Result.is_empty
			loop
				create l_file.make_with_path (l_possible_paths.item)
				if l_file.exists then
					Result := l_possible_paths.item.out
				end
				l_possible_paths.forth
			end

			if Result.is_empty then
					-- 4. Assume it's in the PATH
				Result := "Boogie.exe"
			end
		end

	default_boogie_code_file_name: FILE_NAME
			-- File name for Boogie code file
		local
			l_time: TIME
			l_filename: STRING
		do
			create Result.make_from_string (system.eiffel_project.project_directory.target_path.out)
			Result.extend ("Proofs")
			Result.extend ("autoproof" + unique_number.out + ".bpl")
		end

	default_boogie_output_file_name: FILE_NAME
			-- File name for Boogie output file
		local
			l_time: TIME
			l_filename: STRING
		do
			create Result.make_from_string (system.eiffel_project.project_directory.target_path.out)
			Result.extend ("Proofs")
			Result.extend ("output" + unique_number.out + ".txt")
		end

	default_model_file_name: FILE_NAME
			-- File name for Boogie code file
		local
			l_time: TIME
			l_filename: STRING
		do
			create Result.make_from_string ("C:\temp\output.model")
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
