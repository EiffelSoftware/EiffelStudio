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
			-- Set valid command-line switches
		do
			make_case_insensitive_default_switch (<<"?", "a", "o", "f">>)
			create pathnames.make
		end
		
feature -- Access

	output_filename: STRING
			-- User specified ouput file

	aphabetical_usage_showed: BOOLEAN
			-- Should alphabetical word usage be displayed?

	occurence_usage_showed: BOOLEAN
			-- Should occurence word usage be displayed?

feature -- Basic Operations

	usage (error_info: STRING) is
			-- Show application's usage info and also report command-line argument errors.
		do
			if error_info /= Void then
				-- An command-line argument error occurred, report it to user
				-- `error_info' identifies the argument that is in error.
				Console.WriteLine_system_string_system_object ("Command-line switch error: {0}\n", error_info)
        	end
			Console.WriteLine_system_string ("Usage: WordCount [-a] [-o] [-f<output-pathname>] input-pathname...")
			Console.WriteLine_system_string ("   -?  Show this usage information")
			Console.WriteLine_system_string ("   -a  Word usage sorted alphabetically")
			Console.WriteLine_system_string ("   -o  Word usage sorted by occurrence")
			Console.WriteLine_system_string ("   -f  Send output to specified pathname instead of the console")
		end


	non_switch_value (value: STRING): INTEGER is
			-- Called for each non-value command-line argument (filespecs)
		local
			d: STRING
			dir: SYSTEM_IO_DIRECTORY
			retried: BOOLEAN
			files: ARRAY [SYSTEM_IO_FILE]
			i, an_integer: INTEGER
		do
			if not retried then
				Result := No_error
				-- Add command-line argument to array of pathnames.
				d := File.GetDirectoryNameFromPath (value)
				if d.count = 0 then
					create dir.make_directory (".")
				else
					create dir.make_directory (d)
				end
				-- Convert `value' to set of pathnames, add each pathname to the pathnames ArrayList.
				from
					files := dir.GetFiles_System_String (File.GetFileNameFromPath (value))
					i := 0
				until
					i = files.count
				loop
					an_integer := pathnames.Add (files.item (i).FullName)
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
			if symbol.equals_System_String ("?") then
				-- User wants to see Usage
				Result := Show_usage
			elseif symbol.equals_System_String ("a") then
				-- User wants to see all words sorted alphabetically
				aphabetical_usage_showed := True
			elseif symbol.equals_System_String ("o") then
				-- User wants to see all words sorted by occurrence
				occurence_usage_showed := True
			elseif symbol.equals_System_String ("f") then
				-- User wants output redirected to a specified file
				if value.count < 1 then
					Console.WriteLine_system_string ("No output file specified.")
					Result := Error
				else
					output_filename := value
				end
			else
				Console.Write_system_string ("Invalid switch: %"")
				Console.Write_system_string (symbol)
				Console.WriteLine_system_string ("%".%N")
				Result := Error
			end
		end

	process_post_parsing: INTEGER is
			-- Called when all command-line arguments have been parsed
		do
			Result := No_error
			-- Sort all the pathnames in the list
			if pathnames.count = 0 then
				Console.WriteLine_system_string ("No pathnames specified.")
				Result := Error
			else
				pathnames.Sort_System_Int32 (0, pathnames.count, Void)
			end
		end

	pathname_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
			-- Returns enumerator that includes all the user-desired files.
		do
			Result := pathnames.GetEnumerator_System_Int32 (0, pathnames.count)
		ensure
			non_void_enumerator: Result /= Void
		end
        
feature {NONE} -- Implementation

	pathnames: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Pathnames

end -- class WORD_COUNT_ARG_PARSER



