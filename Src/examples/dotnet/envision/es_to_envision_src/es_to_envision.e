indexing
	description	: "System's root class"
	note		: "Initial version automatically generated"

class
	ES_TO_ENVISION

creation
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			ace_file_content: STRING
		do
			ace_file_content := open_ace_file
			if ace_file_content /= Void and then not ace_file_content.is_empty then
				ace_file_content := add_data_ace_file (ace_file_content)
				save_ace_file (ace_file_content)
			else
				--file_not found!
			end
		end

feature -- File management

	ace_file: PLAIN_TEXT_FILE
			-- machine.config file.

	ace_file_path: STRING
			-- Ace file path.

	root_path: STRING
			-- Root path of project.

	open_ace_file: STRING is
			-- machine.config file.
--		local
--			l_ace_file_path: STRING
		do
--			if command_line.argument_array.count /= 1 then
--				print ("Wrong number of parameter")
--			else
				ace_file_path := command_line.argument_array.item (1)
				ace_file_path.replace_substring_all (Ise_src_key, Src_path)
				ace_file_path.replace_substring_all ("\\", "\")
				create ace_file.make_open_read_write (ace_file_path)
				if ace_file.access_exists then
					ace_file.read_stream (ace_file.count)
					Result := ace_file.last_string
				end
--			end
		ensure
		end

	command_line: ARGUMENTS is
			-- Command line that was used to start current execution
		once
			create Result
		end
		
	save_ace_file (a_string: STRING) is
			-- save `a_string' in `Machine_config'.
		require
			non_void_a_string: a_string /= Void
			not_empty_a_string: not a_string.is_empty
			ace_file_writable: ace_file.is_writable
		do
			create ace_file.make_open_write (src_path + "examples\dotnet\envision\samples\" + "envision.ace")--"e:\titi.ace")
			ace_file.put_string (a_string)
		end

	Ise_src_key: STRING is "EIFFEL_SRC"
			-- Environment variable $ISE_EIFFEL.

	src_path: STRING is
			-- Path to Eiffel installation.
		local   
			retried: BOOLEAN
		once
			if not retried then   
				Result := (create {EXECUTION_ENVIRONMENT}).get (Ise_src_key)
				check
					Ise_eiffel_defined: Result /= Void
				end
				if Result.item (Result.count) /= (create {OPERATING_ENVIRONMENT}).Directory_separator then
					Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
				end
			else   
				-- FIXME: Manu 05/14/2002: we should raise an error here.   
				io.error.put_string ("ISE_EIFFEL environment variable is not defined!%N")   
			end 
		ensure
			exist: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator 
		rescue   
			retried := True   
			retry   
		end

feature 

	add_data_ace_file (a_string: STRING): STRING is
			-- Add a line in `a_sting'.
		require
			non_void_a_string: a_string /= Void
			not_empty_a_string: not a_string.is_empty
		local
			index, index_2: INTEGER
			l_root_sample_path: STRING
		do
--			index := a_string.substring_index (eiffel_studio_samples_path, 1)
--			if index /= 0 then
--				l_root_sample_path := Command_line.argument (2)
--				a_string.replace_substring_all (eiffel_studio_samples_path, envision_samples_path)
--			end
			l_root_sample_path := Command_line.argument (2)
			index := a_string.substring_index (eiffel_studio_samples_path, 1)
			if index /= 0 then
				index_2 := a_string.substring_index ("%"", index)
				a_string.replace_substring (l_root_sample_path, index, index_2 - 1)
			end
			Result := a_string				
		ensure
			non_void_result: Result /= Void
			not_empty_result: not Result.is_empty
		end

	envision_samples_path: STRING is "$ISE_EIFFEL\..\samples\"

	eiffel_studio_samples_path: STRING is "$ISE_EIFFEL\examples\"

		
end -- class EIFFEL_STUD_TO_ENVISION
