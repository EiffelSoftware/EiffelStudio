class 
	CONVERTER

creation                                   
	make

feature -- Initialization

	make (class_name: STRING; output_file: STRING) is
			-- Creates output_file and puts classheader in outputfile
		require 
                	class_name_not_Void: class_name /= Void
			class_name_not_empty: not class_name.empty
			output_file_not_Void: output_file /= Void
			output_file_not_empty: not output_file.empty
              do
              		class_name.to_upper
                	classname := class_name
			!! classfile.make_create_read_write (output_file)
			classfile.putstring ("class%N%T")
			classfile.putstring (classname)
			classfile.putstring ("%N%Nfeature -- Access %N%N")
		end

feature -- Basic operations

	convert (input_file: STRING) is
			-- Scans input_file for "#define id integer" and puts them in output_file
		require
		       	input_file_not_Void: input_file /= Void
			input_file_not_empty: not input_file.empty
                     	input_file_exists: file_exists (input_file)
		local
			id: STRING
			eiffel_id: STRING
                	a_file: PLAIN_TEXT_FILE
		do
			!! a_file.make_open_read (input_file)
			from
			until
				a_file.after
			loop
				a_file.read_character
				if a_file.last_character.is_equal ('#') then
                          		a_file.read_word
					if a_file.last_string.is_equal ("define") then
                                        	a_file.read_word
						id := clone (a_file.last_string)
						a_file.read_word
                                        	if a_file.last_string.is_integer then
							classfile.putstring ("%T")
							id.to_lower
							eiffel_id := clone (id)
							eiffel_id.put (eiffel_id.item(1).upper, 1)
							classfile.putstring (eiffel_id)
							classfile.putstring (": INTEGER is ")
							classfile.putstring (a_file.last_string)
							classfile.new_line
						else
							from
								a_file.back
							until
								a_file.item = '%N' or
								a_file.item = '%T' or
								a_file.item = ' '
							loop
								a_file.back
							end
						end
					end
				else
                                	if a_file.last_character /= '%T'	and 
					   a_file.last_character /= '%N'	and
					   a_file.last_character /= ' ' 	and not
                                	   a_file.end_of_file            	then
                                           a_file.next_line
					end
				end
			end
			check
                     	end_of_input_reached: a_file.end_of_file
			end
		end 

	close_file is
        		-- Puts class-statement end in ouput_file and closes it.
		require
                	classfile_is_open: classfile.is_open_write
		do
			classfile.putstring ("%Nend -- class ")
			classfile.putstring (classname)
			classfile.close
              ensure
              	classfile_is_closed: classfile.is_closed
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

	classfile: PLAIN_TEXT_FILE
	classname: STRING

end -- class CONVERTER

--|---------------------------------------------------------------- 
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
