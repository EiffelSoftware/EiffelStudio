indexing
	description: "Word count argument parser"
	external_name: "ISE.Examples.WordCount.WordCountArgParser"
	
class
	WORD_COUNT_ARG_PARSER

inherit
	ARG_PARSER
		redefine
			non_switch_value,
			switch_value,
			process_post_parsing
		end

create
	build

feature {NONE} -- Initialization

	build is
		indexing
			description: "Set valid command-line switches."
			external_name: "Build"
		do
			make_case_insensitive_default_switch (<<"?", "a", "o", "f">>)
			create pathnames.make
		ensure
			non_void_pathnames: pathnames /= Void
		end
		
feature -- Access

	output_filename: STRING
		indexing
			description: "User specified ouput file"
			external_name: "OutputFilename"
		end

	aphabetical_usage_showed: BOOLEAN
		indexing
			description: "Should alphabetical word usage be displayed?"
			external_name: "AlphabeticalUsageShowed"
		end

	occurence_usage_showed: BOOLEAN
		indexing
			description: "Should occurence word usage be displayed?"
			external_name: "OccurrenceUsageShowed"
		end

feature -- Basic Operations

	usage (error_info: STRING) is
		indexing
			description: "Show application's usage info and also report command-line argument errors."
			external_name: "Usage"
		do
			if error_info /= Void then
				-- An command-line argument error occurred, report it to user
				-- `error_info' identifies the argument that is in error.
				console.write_line_string_object ("Command-line switch error: {0}\n", error_info)
        		end
			console.write_line_string ("Usage: WordCount [-a] [-o] [-f<output-pathname>] input-pathname...")
			console.write_line_string ("   -?  Show this usage information")
			console.write_line_string ("   -a  Word usage sorted alphabetically")
			console.write_line_string ("   -o  Word usage sorted by occurrence")
			console.write_line_string ("   -f  Send output to specified pathname instead of the console")
		end


	non_switch_value (value: STRING): INTEGER is
		indexing
			description: "Called for each non-value command-line argument (filespecs)"
			external_name: "NonSwitchValue"
		local
			d: STRING
			file_info: SYSTEM_IO_FILEINFO
			dir_info: SYSTEM_IO_DIRECTORYINFO
			retried: BOOLEAN
			files: ARRAY [SYSTEM_IO_FILEINFO]
			i, an_integer: INTEGER
		do
			if not retried then
				Result := No_error
				-- Add command-line argument to array of pathnames.
				create file_info.make_fileinfo (value)
				d := file_info.get_directory_name 
				if d.get_length = 0 then
					create dir_info.make_directoryinfo (".")
				else
					create dir_info.make_directoryinfo (d)
				end
				-- Convert `value' to set of pathnames, add each pathname to the pathnames ArrayList.
				from
					files := dir_info.get_files_string (file_info.get_name)
					i := 0
				until
					i = files.count
				loop
					an_integer := pathnames.add (files.item (i).get_full_name)
					i := i + 1
				end
			end
		rescue
			if not retried then
				retried := True
				Result := Error
				retry
			end
		end

	switch_value (symbol, value: STRING): INTEGER is
		-- Called for each switch command-line argument
		-- NOTE: For case-insensitive switches, 
		-- `symbol' will contain all lower-case characters
		do
			Result := No_error
			if symbol.equals_string ("?") then
				-- User wants to see Usage
				Result := Show_usage
			elseif symbol.equals_string ("a") then
				-- User wants to see all words sorted alphabetically
				aphabetical_usage_showed := True
			elseif symbol.equals_string ("o") then
				-- User wants to see all words sorted by occurrence
				occurence_usage_showed := True
			elseif symbol.equals_string ("f") then
				-- User wants output redirected to a specified file
				if value.get_length < 1 then
					console.write_line_string ("No output file specified.")
					Result := Error
				else
					output_filename := value
				end
			else
				console.write_string ("Invalid switch: %"")
				console.write_string (symbol)
				console.write_line_string ("%".%N")
				Result := Error
			end
		end

	process_post_parsing: INTEGER is
			-- Called when all command-line arguments have been parsed
		do
			Result := No_error
			-- Sort all the pathnames in the list
			if pathnames.get_count = 0 then
				console.write_line_string ("No pathnames specified.")
				Result := Error
			else
				pathnames.sort_int32 (0, pathnames.get_count, Void)
			end
		end

	pathname_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
			-- Returns enumerator that includes all the user-desired files.
		do
			Result := pathnames.get_enumerator_int32 (0, pathnames.get_count)
		ensure
			non_void_enumerator: Result /= Void
		end
        
feature {NONE} -- Implementation

	pathnames: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Pathnames

end -- class WORD_COUNT_ARG_PARSER



