indexing

	description: 
		"Allow generation of specific formats (troff, mif, TEX,%
		%PostScript) for output of clickable, short, flat and flat-short";
	date: "$Date$";
	revision: "$Revision $"

class TEXT_FILTER

inherit

	TEXT_FORMATTER
		rename
			process_text as old_process_text
		redefine
			process_filter_item, process_after_class,
			process_class_name_text, process_comment_text,
			process_operator_text, process_keyword_text,
			process_symbol_text
		end;
	TEXT_FORMATTER
		redefine
			process_filter_item, process_after_class,
			process_class_name_text, process_text,
			process_comment_text, process_operator_text, 
			process_keyword_text, process_symbol_text
		select
			process_text
		end;
	EIFFEL_ENV;
	SHARED_TEXT_ITEMS;
	FILTER_PARSER

creation

	make, make_from_filename

feature -- Initialization

	make (filtername: STRING) is
			-- Make a new text filter with information read from `filtername'.
		require
			filtername_not_void: filtername /= Void
		local
			full_pathname: FILE_NAME
		do
			!!format_table.make (50);
			!!escape_characters.make (5);
			!!full_pathname.make_from_string (filter_path);
			full_pathname.extend (filtername);
			full_pathname.add_extension ("fil");
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
			!!escape_characters.make (5);
			read_formats (filename);
			!!image.make (2000)
		end;

feature -- Access

	image: STRING;
			-- Filtered output text

	file_suffix: STRING is
			-- Suffix of the file name where the filtered output text is stored;
			-- Void if it has not been specified in the filter specification
		do
			if format_table.has (f_Suffix) then
				Result := format_table.item (f_Suffix).item1
			end
		end;

feature -- Text processing

	process_text (text: STRUCTURED_TEXT) is
		do
			structured_text := text;
			old_process_text (text);
		end;

feature {NONE} -- Text processing

	structured_text: STRUCTURED_TEXT;
			-- Text being processed

	process_symbol_text (text: SYMBOL_TEXT) is
			-- Process symbol text.
		local
			format: CELL2 [STRING, STRING];
			text_image: STRING
		do
			text_image := text.image;
			text_image.to_lower;
			if format_table.has (text_image) then
				format := format_table.item (text.image)
			elseif format_table.has (f_Symbol) then
				format := format_table.item (f_Symbol)
			end
			if format /= Void then
				image.append (format.item1);
				if format.item2 /= Void then
					print_escaped_text (text.image);
					image.append (format.item2)
				end
			else
				print_escaped_text (text.image)
			end
		end;

	process_keyword_text (text: KEYWORD_TEXT) is
			-- Process keyword text.
		local
			format: CELL2 [STRING, STRING];
			text_image: STRING
		do
			text_image := text.image;
			text_image.to_lower;
			if format_table.has (text_image) then
				format := format_table.item (text.image)
			elseif format_table.has (f_Keyword) then
				format := format_table.item (f_Keyword)
			end
			if format /= Void then
				image.append (format.item1);
				if format.item2 /= Void then
					print_escaped_text (text.image);
					image.append (format.item2)
				end
			else
				print_escaped_text (text.image)
			end
		end;

	process_operator_text (text: OPERATOR_TEXT) is
			-- Process operator text.
		local
			format: CELL2 [STRING, STRING];
			text_image: STRING
		do
			if text.is_keyword or text.is_symbol then
				text_image := text.image;
				text_image.to_lower;
				if format_table.has (text_image) then
					format := format_table.item (text.image)
				elseif text.is_keyword and format_table.has (f_Keyword) then
					format := format_table.item (f_Keyword)
				elseif text.is_symbol and format_table.has (f_Symbol) then
					format := format_table.item (f_Symbol)
				end
			end;
			if format /= Void then
				image.append (format.item1);
				if format.item2 /= Void then
					print_escaped_text (text.image);
					image.append (format.item2)
				end
			else
				print_escaped_text (text.image)
			end
		end;

	process_basic_text (text: BASIC_TEXT) is
			-- Check first if a format has been specified for `text'.
		do
			print_escaped_text (text.image)
		end;

	process_comment_text (text: COMMENT_TEXT) is
			-- Process the quoted text within a comment.
		local
			format: CELL2 [STRING, STRING];
		do
			if format_table.has (f_Comment) then
				format := format_table.item (f_Comment)
				image.append (format.item1);
				if format.item2 /= Void then
					print_escaped_text (text.image);
					image.append (format.item2)
				end
			else
				print_escaped_text (text.image);
			end
		end;

	process_quoted_text (text: QUOTED_TEXT) is
			-- Process the quoted `text' within a comment.
		do
			print_escaped_text (text.image_without_quotes);
		end;

	process_class_name_text (text: CLASS_NAME_TEXT) is
		local
			format: CELL2 [STRING, STRING];
			last_character, current_character: CHARACTER;
			format_item: STRING;
			i, format_item_count: INTEGER
		do
			if format_table.has (f_Class_name) then
				format := format_table.item (f_Class_name);
				from
					format_item := format.item1;
					format_item_count := format_item.count;
					i := 1
				until
					i > format_item_count
				loop
					current_character := format_item.item (i);
					if current_character = '$' then
						if last_character = '%%' then
							image.extend ('$')
						else
							image.append (text.file_name)
						end
					else
						if last_character = '%%' then
							image.extend ('%%')
						end;
						image.extend (current_character)
					end;
					last_character := current_character;
					i := i + 1
				end;
				if format.item2 /= Void then
					print_escaped_text (text.image);
					from
						format_item := format.item2;
						format_item_count := format_item.count;
						last_character := '%U';
						i := 1
					until
						i > format_item_count
					loop
						current_character := format_item.item (i);
						if current_character = '$' then
							if last_character = '%%' then
								image.extend ('$')
							else
								image.append (text.file_name)
							end
						else
							if last_character = '%%' then
								image.extend ('%%')
							end;
							image.extend (current_character)
						end;
						last_character := current_character;
						i := i + 1
					end
				end
			else
				print_escaped_text (text.image)
			end
		end;

	process_new_line (text: NEW_LINE_ITEM) is
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
		end;

	process_indentation (text: INDENT_TEXT) is
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
				image.append (text.image)
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
			item: COMMENT_TEXT
		do
			print_escaped_text (" ");
			process_basic_text (ti_Dashdash);
			print_escaped_text (" ");
			!! item.make ("class ");
			process_comment_text (item);
			print_escaped_text (text.e_class.name_in_upper)
		end;

	print_escaped_text (str: STRING) is
			-- Append `str' to `image' with escape characters
			-- substitutions if required.
		require
			str_not_void: str /= Void
		local
			i, str_count: INTEGER;
			char: CHARACTER
		do
			if escape_characters.empty then
				image.append (str)
			else
				from
					str_count := str.count
					i := 1
				until
					i > str_count
				loop
					char := str.item (i);
					if escape_characters.has (char) then
						image.append (escape_characters.item (char))
					else
						image.extend (char)
					end;
					i := i + 1
				end
			end
		end;

invariant

	image_not_void: image /= Void

end -- class TEXT_FILTER
