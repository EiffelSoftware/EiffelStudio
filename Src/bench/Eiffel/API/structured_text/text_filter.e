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
			full_pathname: STRING
		do
			!!format_table.make (50);
			!!escape_characters.make (5);
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
			!!escape_characters.make (5);
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
					print_escaped_text (text.image);
					image.append (format.item2)
				end
			else
				print_escaped_text (text.image)
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
			print_escaped_text (" ");
			process_basic_text (ti_Dashdash);
			print_escaped_text (" ");
			!!item.make ("class ");
			item.set_is_comment;
			process_basic_text (item);
			print_escaped_text (text.class_name)
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
