indexing
	description: "Preprocessor of Resource Analyzer"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	PREPROCESSOR

inherit
	EXECUTION_ENVIRONMENT

	INTERFACE_MANAGER

creation
	make

feature	-- Initialization

	make (a_output_file: PLAIN_TEXT_FILE) is
		require
			a_output_file_not_void: a_output_file /= Void
			a_output_file_exists: a_output_file.exists
			a_output_file_is_open: a_output_file.is_open_write		
		do
			set_output_file (a_output_file)
			!! define_table.make (20)
			
			!! condition_stack.make
			condition_stack.extend (true)

			!! actual_path.make
			actual_path.extend (".")

			interface.display_text (std_out, "Preprocessing the resource file...")
		end

feature -- Access

	define_table: HASH_TABLE [COUPLE, STRING]
			-- Contain the define name and the define value

feature -- Element change

	set_output_file (a_output_file: PLAIN_TEXT_FILE) is
			-- Set `output_file' to `a_output_file'.
		require
			a_output_file_not_void: a_output_file /= Void
			a_output_file_exists: a_output_file.exists
			a_output_file_is_open: a_output_file.is_open_write		
		do
			output_file := a_output_file
		ensure
			output_file_set: output_file = a_output_file
		end

feature -- Basic operations

	convert (input_file: STRING) is
			-- Scans input_file for "#define id integer" and puts them in output_file
		require
			input_file_not_Void: input_file /= Void
			input_file_not_empty: not input_file.empty
			input_file_exists: file_exists (input_file)
			condition_stack_not_empty: condition_stack /= void
		local
			file: PLAIN_TEXT_FILE
			output: BOOLEAN
			char: CHARACTER
		do
			!! file.make_open_read (input_file)

			from
				file.start
			until 
				file.after

			loop
				output := condition_stack.item

				file.read_character
				char := file.last_character

				if char = '/' then
					file.read_character
					if file.last_character = '/' then
						file.next_line
					elseif file.last_character = '*' then
						read_comment (file)
					else
						display_error	
					end
				elseif char = '#' then
					scan_directives (file)
				elseif (not file.after) then
					if output then
						if char /= '%N' then
							output_file.put_character (char)
							file.read_line
							output_file.putstring (file.last_string)
							output_file.new_line
						end
					else
						if char /= '%N' then
							file.next_line	
						end
					end
				end
			end

			check
				end_of_input_reached: file.end_of_file
			end

			file.close
			actual_path.remove
		end

feature -- Status report

	file_exists (filename: STRING): BOOLEAN is
			-- Check if a file with filename exists
		require
			filename_not_void: filename /= Void
		local
			a_file: PLAIN_TEXT_FILE
		do
			!! a_file.make (filename)
			Result := a_file.exists
		end

feature -- Implementation

	scan_directives (a_file: PLAIN_TEXT_FILE) is
			-- Scan a precompile directive in `a_file' if any to come
		require
			a_file_not_void: a_file /= Void
			a_file_exists: a_file.exists
			a_file_is_open: a_file.is_open_read
			a_file_valid_pos: a_file.last_character = '#'
		local
			expression: STRING
			name: STRING
			couple: COUPLE
			old_level: BOOLEAN
			new_level: BOOLEAN
			else_level: BOOLEAN
			error_message: STRING
		do
			old_level := condition_stack.item
			a_file.read_word

			if a_file.last_string.is_equal ("define") then
				a_file.read_word
				name := clone (a_file.last_string)
				a_file.read_line
				expression := clone (a_file.last_string)
				
				if old_level then
					!! couple.make (name, expression)
					define_table.put (couple, name)
				end

			elseif a_file.last_string.is_equal ("if") then
				a_file.read_line
				expression := clone (a_file.last_string)

				condition_stack.extend (old_level)

			elseif a_file.last_string.is_equal ("ifdef") then
				a_file.read_word
				name := clone (a_file.last_string)
				a_file.next_line

				if define_table.has (name) then
					new_level := old_level
				else
					new_level := false
				end
				
				condition_stack.extend (new_level)
                                                                                                
			elseif a_file.last_string.is_equal ("ifndef") then
				a_file.read_word
				name := clone (a_file.last_string)
				a_file.next_line

				if define_table.has (name) then
					new_level := false
				else
					new_level := old_level
				end
				
				condition_stack.extend (new_level)

			elseif a_file.last_string.is_equal ("else") then
				a_file.next_line
				else_level := old_level

				condition_stack.remove
				old_level := condition_stack.item

				if old_level then
					else_level := not else_level
				end

				condition_stack.extend (else_level)

			elseif a_file.last_string.is_equal ("elif") then
				a_file.read_line
				expression := clone (a_file.last_string)

				new_level := old_level
				condition_stack.extend (new_level)

			elseif a_file.last_string.is_equal ("endif") then
				a_file.next_line
				condition_stack.remove
		
			elseif a_file.last_string.is_equal ("include") then
				if old_level then	
					a_file.read_word
					name := clone (a_file.last_string)
	
					if name.item (1) = '%"' then
						if file_exists (make_path (name)) then
							actual_path.extend (actual_path.item)
							convert (make_path (name))
							l_of_include_file.extend (name)
						else
							!! error_message.make (50)
							error_message.append ("%NCan't include the file ")
							error_message.append (name)
							error_message.append ("%NPreprocessing will continue.")
							interface.display_text (std_error, error_message)
						end

				-- Doesn't include absolute header.
				--	else
				--		actual_path.extend (include_path)
				--		convert (make_path (name))
					end

				end
				a_file.next_line

			elseif a_file.last_string.is_equal ("undef") then
				a_file.read_word
				name:= clone (a_file.last_string)
				a_file.next_line

				if old_level then
					define_table.remove (name)
				end
			end
		end

	extract_name (a_name: STRING): STRING is
			-- Extract the contained name of `a_name'.
		require
			a_name_exists: a_name /= Void and then a_name.count > 0 
		do
			Result := clone (a_name)
			Result.head (a_name.count -1)
			Result.tail (a_name.count - 2)
		ensure
			Result_exists: Result /= Void and then Result.count = a_name.count - 2
		end

	make_path (a_name: STRING): STRING is
			-- Create a path to the file `a_name'.
		require
			a_name_exists: a_name /= Void and then a_name.count > 0 
			actual_path_not_void: actual_path.item /= Void
		do
			!! Result.make (64)
			Result.append (actual_path.item)
			Result.append ("\")
			Result.append (clone (extract_name (a_name)))
		ensure
			Result_exists: Result /= Void and then Result.count > 0
		end

	display_error is
		do
		end


	read_comment (a_file: PLAIN_TEXT_FILE) is
			-- Read comment.
		require
			a_file_not_void: a_file /= Void
			a_file_exists: a_file.exists
			a_file_is_open: a_file.is_open_read
			a_file_valid_pos: a_file.last_character = '*'
		local
			finish: BOOLEAN
		do
			from
			until 
				finish or a_file.after
			loop
				a_file.read_character
				if a_file.last_character = '*' then
					a_file.read_character
					if a_file.last_character = '/' then
						finish := true
					else
						a_file.back
					end
				end
			end
		end


	condition_stack: LINKED_STACK [BOOLEAN]
			-- Stack.

	output_file: PLAIN_TEXT_FILE
			-- File which contains the new resource file without precompile directives.

	actual_path: LINKED_STACK [STRING]
			-- Stack.

	include_path: STRING is
		local
			env: EXECUTION_ENVIRONMENT
		once
			!! env
			Result := clone (env.get ("INCLUDE"))
		end

end -- class PREPROCESSOR

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
