indexing

	description: "Parser of file descriptions which allow generation of%
				 %specific formats (troff, mif, TEX, PostScript) for%
	 			 %output of clickable, short, flat and flat-short.";
	date: "$Date$";
	revision: "$Revision $"

class FILTER_PARSER

	inherit
			Onces

creation

	make

feature -- Initialization

	make (filtername, filter_directory: STRING) is
			-- Make a new text filter with information read 
			-- from `filtername' located in `filter_directory'.
		require
			filtername_not_void: filtername /= Void
			filter_directory_not_void: filtername /= Void
		local
			full_pathname: FILE_NAME;
		do
			if filtername /= Void then
				!! format_table.make (50);
				!! full_pathname.make_from_string (filter_directory);
				full_pathname.set_file_name (filtername);
				full_pathname.add_extension ("fil");
				read_formats (full_pathname);
			end
		end;

feature -- Properties

	format_table: HASH_TABLE [CELL2 [STRING, STRING], STRING];
			-- User-specified formats

feature {NONE} -- Implementation properties

	filter_file: PLAIN_TEXT_FILE;
			-- File containing the filter specifications

	last_char_read: CHARACTER;
			-- Last character read

	read_error: BOOLEAN;
			-- Did an error occurred during the line parsing?

	char_in_buffer: BOOLEAN;
			-- Has `filter_file.lastchar' been used yet?

	is_last_meta: BOOLEAN;
			-- Is last character read a meta character?

	line_nb: INTEGER;
			-- Number of the line currently parsed

feature 

	extension : STRING 
			-- Extension corresponding to the chosen format

feature {NONE} -- Implementation

	read_formats (filename: STRING) is
			-- Parse `filename' and fill `format_table' with
			-- the user-specified format.
		require
			filename_not_void: filename /= Void;
			not_filename_empty: not filename.empty
		local
			construct, before, after: STRING;
			in_construct, in_before: BOOLEAN;
			new_format: CELL2 [STRING, STRING]
		do
			!!filter_file.make (filename);
			if filter_file.exists and then filter_file.is_readable then
				filter_file.open_read;
				if filter_file.readable then
					from
						line_nb := 1
					until
						filter_file.end_of_file
					loop
						from
							in_construct := true;
							in_before := false;
							!!construct.make (10);
							before := Void;
							after := Void;
							get_next_character
						until
							read_error or else
							(is_last_meta and then last_char_read = '%N')
						loop
							if in_construct then
								if not is_last_meta then
									construct.extend (last_char_read)
								elseif last_char_read = '|' then
									construct.left_adjust;
									construct.right_adjust;
									construct.to_lower;
									in_construct := false;
									in_before := true;
									!!before.make (5)
								else
									syntax_error ("%"|%" expected");
									read_error := true
								end
							elseif in_before then
								if not is_last_meta then
									before.extend (last_char_read)
								elseif last_char_read = '*' then
									in_before := false;
									!!after.make (5)
								else
									syntax_error ("%"*%" expected");
									read_error := true
								end
							else
								if not is_last_meta then
									after.extend (last_char_read)
								else
									syntax_error ("End of line expected");
									read_error := true
								end
							end;
							if not read_error then
								get_next_character
							end
						end;
						if not read_error then
							if not construct.empty and then before /= Void then
								!!new_format.make (before, after);
								format_table.force (new_format, construct)
							elseif construct.empty and before /= Void then
								syntax_error ("Construct expected")
							elseif not construct.empty and before = Void then
								syntax_error ("Appearance expected")
							end
						else
								-- Go to the beginning of the next line
							read_error := false;
							char_in_buffer := false;
							filter_file.readline;
							line_nb := line_nb + 1
						end
						if construct.is_equal("suffix") and then
								new_format/= Void and then
								new_format.item1/= Void then
								extension := clone ( new_format.item1)
						end
					end;
					filter_file.close
				end
			else
				Windows_manager.popup_message("Mw", Void, Windows_manager.first_window )
			end
		end;

	get_next_character is
			-- Go forth one position in the filter file.
			-- Interprete special characters. Put the 
			-- read character in last_char_read.
		do
			is_last_meta := false;
			if not char_in_buffer then
				filter_file.readchar
			else
				char_in_buffer := false
			end;
			if not filter_file.end_of_file then
				inspect filter_file.lastchar
				when '%%' then
					filter_file.readchar;
					if filter_file.end_of_file then
						syntax_error ("End of line expected");
						read_error := true
					else
						inspect filter_file.lastchar
						when 'n', 'N' then
							last_char_read := '%N'
						when 't', 'T' then
							last_char_read := '%T'
						when '%N' then
							line_nb := line_nb + 1;
							from
								filter_file.readchar
							until
								filter_file.end_of_file or else
								(filter_file.lastchar /= ' ' and
								filter_file.lastchar /= '%T')
							loop
								filter_file.readchar
							end;
							if 
								filter_file.end_of_file or else
								filter_file.lastchar /= '%%'
							then
								syntax_error ("%"%%%" expected");
								read_error := true;
								if
									not filter_file.end_of_file and then
									filter_file.lastchar = '%N'
								then
									line_nb := line_nb + 1
								end
							else
								get_next_character
							end
						else
							last_char_read := filter_file.lastchar
						end
					end
				when '|', '*' then
					last_char_read := filter_file.lastchar;
					is_last_meta := true
				when '%N' then
					last_char_read := filter_file.lastchar;
					is_last_meta := true;
					line_nb := line_nb + 1
				when '-' then
					filter_file.readchar;
					if not filter_file.end_of_file then
						if filter_file.lastchar = '-' then
								-- This is a comment. Skip the end of the line.
							filter_file.readline;
							line_nb := line_nb + 1;
							last_char_read := '%N';
							is_last_meta := true
						else
							char_in_buffer := true;
							last_char_read := '-'
						end
					else
						last_char_read := '-'
					end
				else
					last_char_read := filter_file.lastchar
				end
			else
				last_char_read := '%N';
				is_last_meta := true
			end
		end;

	syntax_error (message: STRING) is
			-- Display a warning message.
		require
			message_not_void: message /= Void
		do
			io.error.putstring ("Warning: filter ");
			io.error.putstring (filter_file.name);
			io.error.putstring ("%N%TSyntax error, line ");
			if last_char_read = '%N' then
				io.error.putint (line_nb - 1);
				io.error.putstring (" near ");
				io.error.putstring ("End of line")
			else
				io.error.putint (line_nb);
				io.error.putstring (" near ");
				io.error.putchar ('%"');
				io.error.putchar (last_char_read);
				io.error.putchar ('%"')
			end;
			io.error.putstring (": ");
			io.error.putstring (message);
			io.error.new_line
		end;

invariant

	format_table_not_void: format_table /= Void

end -- class FILTER_PARSER
