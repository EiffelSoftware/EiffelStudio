indexing
	description: "Tool to clean any strings when retrieving data from a client"
	author: "David s"
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_CLEANER

create
	make

feature -- Initialization

	make is
			-- initialization
		do
			input:= ""
		end

feature -- Access

	test_mode: BOOLEAN
		-- Test mode

	output: STRING
		-- Current output

	output_error: BOOLEAN
		-- A error has been detected during the convertion

feature -- Setting

	set_input (input_string: STRING) is
			-- Set the current input
		require
			not_void: input_string /= Void
		do
			input:= input_string
		end

feature -- Tools

	convert_filename is
			-- Convert the input such that the input can be a filename
		require
			input_is_set: input/= Void and then input /= ""
		do
			remove_file_char
		ensure
			new_output: output /= Void
		end

	convert_database is
			-- Convert the input such that all complicated character are remove by basic ones.
			-- For example, all the accent will be remove
		require
			input_is_set: input/= Void and then input /= ""
		do
			change_illegal_characters
		ensure
			new_output: output /= Void
		end

	convert_eiffel_lace is
			-- Convert the input such that the input can be the name of an Eiffel system in the Lace file
		require
			input_is_set: input/= Void and then input /= ""
		do

		ensure
			new_output: output /= Void
		end

	is_filename_compatible: BOOLEAN is
			-- Can the input be a filename
		require
			input_is_set: input/= Void and then input /= ""
		local
			l_input: like input
		do
			l_input:= input
			Result:= l_input.has ('/') or l_input.has ('\') or l_input.has (':') or l_input.has ('*') or
					l_input.has ('?') or l_input.has ('%"') or l_input.has ('<') or l_input.has ('>') or
					l_input.has ('|')
		end

	is_database_compatible: BOOLEAN is
			-- Can the input be inserted in a database
		require
			input_is_set: input/= Void and then input /= ""
		local
			l_input: like input
			i: INTEGER
			stop: BOOLEAN
			current_char: CHARACTER
		do
			l_input:= input
			from
				i:= 1
			until
				i = l_input.count + 1 or stop
			loop
				current_char:= l_input.item (i)
				if is_valid_char_for_database (current_char) then
					i:= i + 1
				else
					stop:= True
				end
			end		
		end

	is_eiffel_lace_compatible: BOOLEAN is
			-- Can the input be the name of an Eiffel Project
		require
			input_is_set: input/= Void and then input /= ""
		local
			l_input: like input
			i: INTEGER
			stop: BOOLEAN
			current_char: CHARACTER
		do
			l_input:= input
			from
				i:= 1
			until
				i = l_input.count + 1 or stop
			loop
				current_char:= l_input.item (i)
				if is_valid_char_for_database (current_char) then
					i:= i + 1
				else
					stop:= True
				end
			end
			if not stop then
				Result:= True
			end
		end


	set_test_mode is
		do
			test_mode:= True
		end
		

feature -- Implementation

	input: STRING

feature {NONE} -- Process

	remove_file_char is
		do
			if not output_error then
				output:= input
				output.replace_substring_all ("/", "")
				output.replace_substring_all ("\", "")
				output.replace_substring_all (":", "")
				output.replace_substring_all ("*", "")
				output.replace_substring_all ("?", "")
				output.replace_substring_all ("%"", "")
				output.replace_substring_all ("<", "")
				output.replace_substring_all (">", "")
				output.replace_substring_all ("|", "")
			end
			if output.count = 0 then
				output_error:= True
			end
		rescue
			output_error:= True
		end

	 change_illegal_characters is
		do
			if not output_error then
				output:= input
				output.replace_substring_all ("à", "a")
				output.replace_substring_all ("á", "a")
				output.replace_substring_all ("à", "a")
				output.replace_substring_all ("æ", "a")
				output.replace_substring_all ("ñ", "n")
				output.replace_substring_all ("%%", "")
				output.replace_substring_all ("'", "")
				output.replace_substring_all ("\", "")
				output.replace_substring_all ("/", "")
				output.replace_substring_all (":", "")
				output.replace_substring_all ("í", "i")
				output.replace_substring_all ("ì", "i")
				output.replace_substring_all ("î", "i")
				output.replace_substring_all ("ï", "i")
				output.replace_substring_all ("ó", "o")
				output.replace_substring_all ("õ", "o")
				output.replace_substring_all ("ô", "o")
				output.replace_substring_all ("ö", "o")
				output.replace_substring_all ("ù", "u")
				output.replace_substring_all ("û", "u")
				output.replace_substring_all ("ú", "u")
				output.replace_substring_all ("ü", "u")
				output.replace_substring_all ("|", "")
				output.replace_substring_all ("é", "e")
				output.replace_substring_all ("ë", "e")
				output.replace_substring_all ("ê", "e")
				output.replace_substring_all ("è", "e")
				output.replace_substring_all ("È", "E")
				output.replace_substring_all ("Ê", "E")
				output.replace_substring_all ("É", "E")
				output.replace_substring_all ("Ë", "E")
				output.replace_substring_all ("À", "A")
				output.replace_substring_all ("Á", "A")
				output.replace_substring_all ("Â", "A")
				output.replace_substring_all ("Ã", "A")
				output.replace_substring_all ("Ä", "A")
			end
		end

	is_valid_char_for_database (c: CHARACTER): BOOLEAN is
		do
			Result:=  (c >= 'A' and c <= 'Z') or (c >= 'a' and c <= 'z') or (c >= '0' and c <= '9')
					 or c = '_' 
		end

	test_filename is
		do

		end

	remove_database_char is
		do
			if not output_error then
			end
			if output.count = 0 then
				output_error:= True
			end
		end

end -- class STRING_CLEANER
