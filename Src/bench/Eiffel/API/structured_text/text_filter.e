indexing

	description: 
		"Allow generation of specific formats (troff, mif, TEX,%
		%PostScript) for output of clickable, short, flat and flat-short";
	date: "$Date$";
	revision: "$Revision $"

class TEXT_FILTER

inherit

	TEXT_FORMATTER
		redefine
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

feature -- Removal

	wipe_out_image is
			-- Wipe out the image.
		do
			!! image.make (2000)
		end

feature -- Access

	image: STRING;
			-- Filtered output text

	file_name: FILE_NAME;
			-- File name for output of Current filter

	Default_unknown_name: FILE_NAME is
			-- *** FIXME to be added to eiffel_env
		once
			!! Result.make_from_string (Eiffel_installation_dir_name);
			Result.extend_from_array (<<"bench", "help", "defaults">>);
			Result.set_file_name ("unknown");
		end;

	file_suffix: STRING is
			-- Suffix of the file name where the filtered output text is stored;
			-- Void if it has not been specified in the filter specification
		do
			if format_table.has (f_Suffix) then
				Result := format_table.found_item.item1
			end
		end;

feature -- Status setting

	set_file_name (f: like file_name) is
			-- Set `file_name' to `f'. 
		do
			file_name := f
		ensure
			set: file_name = f
		end

feature -- Text processing

	process_text (text: STRUCTURED_TEXT) is
		do
			if text /= Void then
				structured_text := text;
				from
					text.start
				until
					text.after
				loop
					text.item.append_to (Current);
					text.forth
				end
			end
		end;

feature {NONE} -- Text processing

	structured_text: STRUCTURED_TEXT;

	process_symbol_text (text: SYMBOL_TEXT) is
			-- Process symbol text.
		local
			format: CELL2 [STRING, STRING];
			text_image: STRING
		do
			text_image := text.image;
			text_image.to_lower;
			if format_table.has (text_image) then
				format := format_table.found_item
			elseif format_table.has (f_Symbol) then
				format := format_table.found_item
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
				format := format_table.found_item
			elseif format_table.has (f_Keyword) then
				format := format_table.found_item
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
					format := format_table.found_item
				elseif text.is_keyword and format_table.has (f_Keyword) then
					format := format_table.found_item
				elseif text.is_symbol and format_table.has (f_Symbol) then
					format := format_table.found_item
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
				format := format_table.found_item
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

	process_cluster_name_text (text: CLUSTER_NAME_TEXT) is
		local
			format: CELL2 [STRING, STRING];
			last_character, current_character: CHARACTER;
			format_item: STRING;
			d_name: FILE_NAME;
			i, format_item_count: INTEGER
		do
			if format_table.has (f_Cluster_name) then
				format := format_table.found_item
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
							d_name := text.cluster_i.document_file_name;
							if d_name = Void then
								image.append (Default_unknown_name)
							else
								image.append (relative_file_name (d_name))
							end
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
								if d_name = Void then
									d_name := text.cluster_i.document_file_name;
								end;
								if d_name = Void then	
									image.append (Default_unknown_name)
								else
									image.append (relative_file_name (d_name))
								end
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

	process_class_name_text (text: CLASS_NAME_TEXT) is
		local
			format: CELL2 [STRING, STRING];
			last_character, current_character: CHARACTER;
			format_item: STRING;
			d_name: FILE_NAME;
			i, format_item_count: INTEGER
		do
			if format_table.has (f_Class_name) then
				format := format_table.found_item
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
							d_name := text.class_i.document_file_name;
							if d_name = Void then
								image.append (Default_unknown_name)
							else
								image.append (relative_file_name (d_name))
							end
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
								if d_name = Void then
									d_name := text.class_i.document_file_name;
								end;
								if d_name = Void then	
									image.append (Default_unknown_name)
								else
									image.append (relative_file_name (d_name))
								end
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
				format := format_table.found_item
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
				format := format_table.found_item
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
				format := format_table.found_item
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


	process_cl_syntax (text: CL_SYNTAX_ITEM) is
			-- Process class syntax text.
		do
			process_basic_text (text)
		end;

	process_ace_syntax (text: ACE_SYNTAX_ITEM) is
			-- Process Ace syntax text.
		do
			process_basic_text (text)
		end;

	process_address_text (text: ADDRESS_TEXT) is
			-- Process address text.
		do
			process_basic_text (text)
		end;

	process_padded is
			-- Process padded item at start of non breakpoint line.
		do
		end;

	process_feature_name_text (text: FEATURE_NAME_TEXT) is
			-- Process feature name text `t'.
		do
			process_basic_text (text)
		end;

	process_exported_feature_name_text (text: EXPORTED_FEATURE_NAME_TEXT) is
			-- Process feature name text `t'.
		do
			process_basic_text (text)
		end;

	process_feature_text (text: FEATURE_TEXT) is
			-- Process feature text `text'.
		do
			process_basic_text (text)
		end;

	process_breakpoint (a_bp: BREAKPOINT_ITEM) is
			-- Process breakpoint.
		do
		end;

	process_error_text (text: ERROR_TEXT) is
			-- Process error text.
		do
			process_basic_text (text)
		end;

	process_before_class (text: BEFORE_CLASS) is
			-- Process before class `t'.
		do
		end;

feature {NONE} -- Implementation

	relative_file_name (f_name: FILE_NAME): FILE_NAME is
			-- Relative file name to `f_name' in relation to `file_name'
			-- FIXME ***** At the moment returns `f_name'
		require
			valid_f_name: f_name /= Void
		do
			Result := f_name
		end;

invariant

	image_not_void: image /= Void

end -- class TEXT_FILTER
