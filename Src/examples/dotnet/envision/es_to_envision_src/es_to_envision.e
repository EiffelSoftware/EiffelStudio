indexing
	description	: "Adapt EiffelStudio samples Ace files to ENViSioN!"

class
	ES_TO_ENVISION

inherit
	EXCEPTIONS
		export
			{NONE} all
		end

creation
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
			if Command_line.Argument_count < 2 then
				show_usage
			else
				if not Command_line.argument (1).substring (1, Ise_src_key.count).is_equal (Ise_src_key) then
					io.put_string ("Ace file path must start with " + Ise_src_key)
					io.read_line
					die (1)
				end
				read_ace_file
				if ace_file_content /= Void and then not ace_file_content.is_empty then
					modify_ace_file_content
					save_ace_file
				else
					io.put_string ("Ace file not found!")
					io.read_line
					die (1)
				end
			end
		end

feature -- File management

	ace_file_content: STRING
			-- Ace file content to be modified

	read_ace_file is
			-- Set `ace_file_content' with content of Ace file
			-- whose path was given as argument to the system.
		require
			not_already_read: ace_file_content = Void
		local
			path: STRING
			ace_file: PLAIN_TEXT_FILE
		do
			path := command_line.argument_array.item (1)
			check
				valid_path: path.substring (1, Ise_src_key.count).is_equal (Ise_src_key)
			end
			create ace_file.make (resolved_path (path))
			if ace_file.exists then
				ace_file.open_read
				ace_file.read_stream (ace_file.count)
				ace_file_content := ace_file.last_string
				ace_file.close
			end
		ensure
			read: (create {RAW_FILE}.make (resolved_path (Command_line.argument (1)))).exists implies ace_file_content /= Void
		end

	resolved_path (relative_path: STRING): STRING is
			-- Evaluate EIFFEL_SRC and replace with value.
		require
			non_void_path: relative_path /= Void
		do
			Result := clone (relative_path)
			Result.replace_substring_all (Ise_src_key, Src_path)
			Result.replace_substring_all ("\\", "\")
		ensure
			non_void_resolved_path: Result /= Void
			valid_resolved_path: Result.substring_index (Ise_src_key, 1) = 0 and Result.substring_index ("\\", 1) = 0
		end

	command_line: ARGUMENTS is
			-- Command line that was used to start current execution
		once
			create Result
		end
		
	save_ace_file is
			-- Save ace file.
		require
			non_void_content: ace_file_content /= Void
			valid_content: not ace_file_content.is_empty
		local
			ace_file: PLAIN_TEXT_FILE
			path: STRING
		do
			path := src_path + "examples\dotnet\envision\samples"
			if (create {DIRECTORY}.make (path)).exists then
				create ace_file.make_open_write (path + "\envision.ace")
				ace_file.put_string (ace_file_content)
				ace_file.close				
			else
				io.put_string ("Cannot open folder " + path + "%N")
			end
		end

	Relative_ace_file_path: STRING is "examples\dotnet\envision\samples\envision.ace"
			-- Path to ace file from sanmples delivery root

	Ise_src_key: STRING is "EIFFEL_SRC"
			-- Environment variable $EIFFEL_SRC.

	src_path: STRING is
			-- Path to Eiffel installation.
		local   
			retried: BOOLEAN
		once
			if not retried then   
				Result := (create {EXECUTION_ENVIRONMENT}).get (Ise_src_key)
				check
					variable_defined: Result /= Void
				end
				if Result.item (Result.count) /= (create {OPERATING_ENVIRONMENT}).Directory_separator then
					Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
				end
			else   
				io.error.put_string (Ise_src_key + " environment variable is not defined!%N")   
			end 
		ensure
			exist: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator 
		rescue   
			retried := True   
			retry   
		end

feature -- Basic Operations

	show_usage is
			-- Display usage information
		do
			io.put_string ("EiffelStudio to ENViSioN! Ace Files Converter Utility 1.0%NCopyright (C) Eiffel Software 2002. All right reserved.%N")
			io.put_string ("%NSyntax: es_to_envision ace_file_path envision_cluster_path")
		end
		
feature {NONE} -- Implementation

	modify_ace_file_content is
			-- Replace `eiffel_studio_samples_path' with system's second argument.
		require
			non_void_ace_file_content: ace_file_content /= Void
			valid_argument_count: Command_line.Argument_count >= 2
		local
			index, index_2: INTEGER
			s: STRING
		do
			s := Command_line.argument (2)
			index := ace_file_content.substring_index (eiffel_studio_samples_path, 1)
			if index > 0 then
				index_2 := ace_file_content.substring_index ("%"", index)
				ace_file_content.replace_substring (s, index, index_2 - 1)
			end
		end

	eiffel_studio_samples_path: STRING is "$ISE_EIFFEL\examples\"
			-- Path to EiffelStudio samples as set in Ace file

invariant
	valid_arguments_count: Command_line.Argument_count > 1
	
end -- class ES_TO_ENVISION
