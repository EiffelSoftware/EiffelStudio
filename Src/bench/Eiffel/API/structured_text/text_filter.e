-- Allow generation of specific formats (troff, mif, TEX, PostScript)
-- for output of clickable, short, flat and flat-short.

class TEXT_FILTER

inherit

	TEXT_FORMATTER
		redefine
			process_filter_item
		end;

	EIFFEL_ENV;
	SHARED_FILTER

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
			full_pathname := clone (Eiffel3_dir_name);
			full_pathname.extend (Directory_separator);
			full_pathname.append ("bench");
			full_pathname.extend (Directory_separator);
			full_pathname.append ("help");
			full_pathname.extend (Directory_separator);
			full_pathname.append ("filters");
			full_pathname.extend (Directory_separator);
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

feature {NONE} -- Text processing

	process_basic_text (text: BASIC_TEXT) is
			-- Check first if a format has been specified for `text'.
		local
			format: CELL2 [STRING, STRING];
			text_image: STRING
		do
			if text.is_keyword or text.is_special then
				text_image := text.image;
				text_image.to_lower;
				if format_table.has (text_image) then
					format := format_table.item (text.image);
					image.append (format.item1);
					if format.item2 /= Void then
						image.append (text.image);
						image.append (format.item2)
					end
				elseif text.is_keyword and format_table.has (f_Keyword) then
					format := format_table.item (f_Keyword);
					image.append (format.item1);
					image.append (text.image);
					if format.item2 /= Void then
						image.append (format.item2)
					end
				elseif text.is_special and format_table.has (f_Symbol) then
					format := format_table.item (f_Symbol);
					image.append (format.item1);
					image.append (text.image);
					if format.item2 /= Void then
						image.append (format.item2)
					end
				else
					image.append (text.image)
				end
			elseif text.is_comment then
				image.append (text.image)
			else
				image.append (text.image)
			end
		end;

	process_new_line_text (text: NEW_LINE_TEXT) is
		local
			format: CELL2 [STRING, STRING];
			i: INTEGER
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
			format: CELL2 [STRING, STRING]
		do
			construct := text.construct;
			if format_table.has (construct) then
				format := format_table.item (construct);
				if text.is_before then
					image.append (format.item1)
				elseif format.item2 /= Void then
					image.append (format.item2)
				end
			end
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
					end_of_file
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
-- Warning: unexpected meta char `last_char_read'
								read_error := true
							end
						elseif in_before then
							if not is_last_meta then
								before.extend (last_char_read)
 							elseif last_char_read = '*' then
								in_before := false;
								!!after.make (5)
							else
-- Warning: unexpected meta char `last_char_read'
								read_error := true
							end
						else
							if not is_last_meta then
								after.extend (last_char_read)
							else
-- Warning: unexpected meta char `last_char_read'
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
						elseif construct.empty then
-- Warning: construct not specified
						elseif before = Void then
-- Warning: appearance not specified
						end
					elseif not filter_file.end_of_file then
							-- Go to the beginning of the next line
						read_error := false;
						char_in_buffer := false;
						filter_file.readline;
						line_nb := line_nb + 1
					end
				end;
				filter_file.close
			else
-- Warning : cannot read file
			end
		end;

	get_next_character is
			-- Go forth one position in the filter file.
			-- Interprete special characters. Put the 
			-- read character in last_char_read.
		do
			is_last_meta := false;
			if not end_of_file then
				if not char_in_buffer then
					filter_file.readchar
				else
					char_in_buffer := false
				end;
				inspect filter_file.lastchar
				when '%%' then
					if filter_file.end_of_file then
-- Warning: new_line expected
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
							until
								filter_file.end_of_file or else
								(filter_file.lastchar /= ' ' and
								filter_file.lastchar /= '%T')
							loop
								filter_file.readchar
							end;
							if 
								filter_file.end_of_file or else
								filter_file.lastchar /= '%'
							then
-- Warning: '%' expected
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
					if not filter_file.end_of_file then
						filter_file.readchar;
						if filter_file.lastchar = '-' then
								-- This is a comment. Skip the end of the line.
							if not filter_file.end_of_file then
								filter_file.readline;
								line_nb := line_nb + 1
							end;
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

	end_of_file: BOOLEAN is
			-- Has the end of the filter file been reached?
		do
			Result := not char_in_buffer and filter_file.end_of_file
		end;

	is_last_meta: BOOLEAN;
			-- Is last character read a meta character?

	line_nb: INTEGER;
			-- Number of the line currently parsed

invariant

	image_not_void: image /= Void;
	format_table_not_void: format_table /= Void

end -- class TEXT_FILTER
