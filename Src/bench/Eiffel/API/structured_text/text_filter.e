-- Allow generation of specific formats (troff, mif, TEX, PostScript)
-- for output of clickable, short, flat and flat-short.

class TEXT_FILTER

inherit

	TEXT_FORMATTER
		redefine
			process_filter_item, process_after_class,
			process_text
		end;

	EIFFEL_ENV;
	SHARED_TEXT_ITEMS

creation

	make, make_from_filename

feature -- Initialization

	make (filtername: STRING) is
			-- Make a new text filter with information read from `filtername'.
		require
			filtername_not_void: filtername /= Void
		local
			full_pathname: STRING
		do
			!!format_table.make (50);
			full_pathname := clone (filter_path);
			full_pathname.append (filtername);
			full_pathname.append (".fil");
			read_formats (full_pathname);
			!!image.make (2000)
		end;

	make_from_filename (filename: STRING) is
			-- Make a new text filter with information read from `filename'.
		require
			filename_not_void: filename /= Void;
			not_filename_empty: not filename.empty
		do
			!!format_table.make (50);
			read_formats (filename);
			!!image.make (2000)
		end;

	image: STRING;

feature -- Text processing

	process_text (text: STRUCTURED_TEXT) is
		do
			structured_text := text;
			indentation := Void;
			from text.start until text.after loop
				process_item (text.item);
				if not text.after then text.forth end
			end
		end;

feature {NONE} -- Text processing

	structured_text: STRUCTURED_TEXT;
			-- Text being processed

	indentation: NEW_LINE_TEXT;
			-- Indentation to be added at the beginning of the line

	process_basic_text (text: BASIC_TEXT) is
			-- Check first if a format has been specified for `text'.
		local
			format: CELL2 [STRING, STRING];
			text_image: STRING
		do
			if indentation /= Void then
				process_indentation (indentation);
				indentation := Void
			end;
			if text.is_keyword or text.is_special then
				text_image := text.image;
				text_image.to_lower;
				if format_table.has (text_image) then
					format := format_table.item (text.image)
				elseif text.is_keyword and format_table.has (f_Keyword) then
					format := format_table.item (f_Keyword)
				elseif text.is_special and format_table.has (f_Symbol) then
					format := format_table.item (f_Symbol)
				end
			elseif text.is_comment and format_table.has (f_Comment) then
				format := format_table.item (f_Comment)
			end;
			if format /= Void then
				image.append (format.item1);
				if format.item2 /= Void then
					image.append (text.image);
					image.append (format.item2)
				end
			else
				image.append (text.image)
			end
		end;

	process_new_line_text (text: NEW_LINE_TEXT) is
		local
			format: CELL2 [STRING, STRING]
		do
			if format_table.has (f_New_line) then
				format := format_table.item (f_New_line);
				image.append (format.item1);
				if format.item2 /= Void then
					image.append ("%N");
					image.append (format.item2)
				end
			else
				image.append ("%N")
			end;
			indentation := text
		end;

	process_indentation (text: NEW_LINE_TEXT) is
		local
			format: CELL2 [STRING, STRING];
			i: INTEGER
		do
			if format_table.has (f_Tab) then
				format := format_table.item (f_Tab);
				from 
					i := 1
				until
					i > text.indent_depth
				loop
					image.append (format.item1);
					if format.item2 /= Void then
						image.append ("%T");
						image.append (format.item2)
					end;
					i := i + 1
				end
			else
				image.append (text.indent_text)
			end
		end;

	process_filter_item (text: FILTER_ITEM) is
			-- Mark appearing before or after major syntactic constructs.
		local
			construct: STRING;
			format: CELL2 [STRING, STRING];
			filter_item: FILTER_ITEM;
			found: BOOLEAN
		do
			if indentation /= Void then
				process_indentation (indentation);
				indentation := Void
			end;
			construct := text.construct;
			if format_table.has (construct) then
				format := format_table.item (construct);
				if text.is_before then
					image.append (format.item1)
					if format.item2 = Void then
							-- The user wants to hide this construct.
							-- Get rid of the text items until
							-- the end mark of that construct.
						from 
						until 	
							structured_text.after or found 
						loop
							structured_text.forth;
							filter_item ?= structured_text.item;
							found := filter_item /= Void and then
										construct = filter_item.construct
						end
					end
				elseif format.item2 /= Void then
					image.append (format.item2)
				end
			end
		end;

	process_after_class (text: AFTER_CLASS) is
		local
			item: BASIC_TEXT
		do
			if indentation /= Void then
				process_indentation (indentation);
				indentation := Void
			end;
			image.extend (' ');
			process_basic_text (ti_Dashdash);
			image.extend (' ');
			!!item.make ("class ");
			item.set_is_comment;
			process_basic_text (item);
			image.append (text.class_name)
		end;

feature {NONE} -- Formats

	format_table: HASH_TABLE [CELL2 [STRING, STRING], STRING];
			-- User-specified formats

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
debug ("FILTERS")
	io.error.putstring (construct);
	io.error.putstring (" -> ");
	io.error.putstring (before);
	if after /= Void then
		io.error.putstring (" @ ");
		io.error.putstring (after)
	end;
	io.error.new_line
end
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
				end;
				filter_file.close
			else
				io.error.putstring ("Warning: Cannot read filter ");
				io.error.putstring (filename);
				io.error.new_line
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

	image_not_void: image /= Void;
	format_table_not_void: format_table /= Void

end -- class TEXT_FILTER
