indexing
	description: 
		"Allow generation of specific formats (troff, mif, TEX,%
		%PostScript) for output of clickable, short, flat and flat-short";
	date: "$Date$";
	revision: "$Revision $"

class
	TEXT_FILTER

inherit
	TEXT_FORMATTER
		redefine
			process_text,
			process_character_text,
			process_generic_text,
			process_indexing_tag_text,
			process_local_text,
			process_number_text,
			process_assertion_tag_text,
			process_string_text,
			process_reserved_word_text,
			process_menu_text
		end

	EIFFEL_ENV

	SHARED_TEXT_ITEMS

	SHARED_WORKBENCH

	FILTER_PARSER

create
	make,
	make_from_filename

feature {NONE} -- Initialization

	make (filtername: STRING) is
			-- Make a new text filter with information read from `filtername'.
		require
			filtername_not_void: filtername /= Void
		local
			full_pathname: FILE_NAME
		do
			if not filtername.is_empty then
				create full_pathname.make_from_string (filter_path)
				full_pathname.extend (filtername)
				full_pathname.add_extension ("fil")
				make_from_filename (full_pathname)
			else
				make_from_filename (create {FILE_NAME}.make_from_string (filtername))
			end
		end

	make_from_filename (filename: STRING) is
			-- Make a new text filter with information read from `filename'.
		require
			filename_not_void: filename /= Void;
		do
			create format_table.make (50)
			create escape_characters.make (5)
			if not filename.is_empty then
				read_formats (filename)
			end
			create image.make (2000)
			init_file_separator
			init_file_suffix
			prepend_to_file_suffix ("")
			create keyword_table.make (4)
			set_keyword ("generator", "ISE " + Workbench_name + " version " + Version_number)
			set_base_path ("")
		end

	init_file_separator is
			-- Get preferred file separator from `format_table'.
		do
			if format_table.has (f_File_separator) then
				file_separator := format_table.found_item.item1 @ 1
				if file_separator /= '/' and file_separator /= '\' then
					file_separator := '%U'
				end
			end
		end

	init_file_suffix is
			-- Get file suffix from `format_table'.
		do
			if format_table.has (f_Suffix) then
				file_suffix := format_table.found_item.item1
			end
			if file_suffix = Void then
				file_suffix := "txt"
			end
		end

feature -- Optional initialization

	prepend_to_file_suffix (a_suffix: STRING) is
			-- Set `a_suffix' to be the suffix of every class link in
			-- the output file.
			-- Examples: "_flat" "_output"
		require
			a_suffix_not_void: a_suffix /= Void
		do
			class_suffix := clone (a_suffix)
			class_suffix.append (".")
			class_suffix.append (file_suffix)
		end

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

	base_path: STRING
			-- For relative path names: zero or more "../".

	file_suffix: STRING
			-- Suffix of the file name where the filtered output text is stored;
			-- Void if it has not been specified in the filter specification

	file_separator: CHARACTER
			-- Preferred file separator.

	class_suffix: STRING
			-- Appended to all class paths. Ends with `file_suffix'.

	feature_redirect: STRING
			-- When not `Void', prepend to file suffix to have features
			-- redirected to format where a feature bookmark can exist.

	doc_universe: DOCUMENTATION_UNIVERSE
			-- Classes and clusters for which documentation is generated.

feature -- Status setting

	set_universe (a_universe: DOCUMENTATION_UNIVERSE) is
			-- Change `doc_universe' to `a_universe'.
		require
			a_universe_not_void: a_universe /= Void
		do
			doc_universe := a_universe
		end

	set_feature_redirect (a_suffix: STRING) is
			-- Let feature links be redirected to a different class format.
			-- Reason: in "_chart" format there is no feature bookmark.
		do
			feature_redirect := a_suffix
		end

	set_file_name (f: like file_name) is
			-- Set `file_name' to `f'. 
		do
			file_name := f
		ensure
			set: file_name = f
		end

	set_keyword (a_keyword, a_substitute: STRING) is
			-- Add/change a keyword replacement. This means that
			-- in the .FIL file, every instance of "$`a_keyword'$"
			-- will be replaced with `a_substitute'.
			-- if `a_substitute' is `Void', remove `a_keyword'.
		require
			a_keyword_not_void: a_keyword /= Void
		do
			if keyword_table.has (a_keyword) then
				keyword_table.remove (a_keyword)
			end
			if a_substitute /= Void then
				keyword_table.put (a_substitute, a_keyword)
			end
		end

	set_base_path (s: STRING) is
			-- Set `base_path' to `s'.
		require
			s_not_void: s /= Void
		local
			sep: CHARACTER
			p: STRING
		do
			base_path := s
			sep := file_separator
			if sep = '%U' then
				sep := (create {OPERATING_ENVIRONMENT}).Directory_separator
			end
			if not base_path.is_empty then
				p := base_path + sep.out
			else
				p := base_path
			end
			set_keyword (kw_Root, p)
		end

feature -- Status report

	is_html: BOOLEAN is
		local
			s: STRING
		do
			s := clone (file_suffix)
			s.to_lower
			Result := file_suffix.is_equal ("html")
		end

feature -- Text processing

	process_text (text: STRUCTURED_TEXT) is
		do
			if doc_universe = Void then
				create doc_universe.make
				doc_universe.include_all
			end
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

	structured_text: STRUCTURED_TEXT

	process_symbol_text (text: SYMBOL_TEXT) is
			-- Process symbol text.
		local
			format: CELL2 [STRING, STRING];
			text_image: STRING
		do
			text_image := clone (text.image)
			text_image.to_lower;
			if format_table.has (text_image) then
				format := format_table.found_item
			elseif format_table.has (f_Symbol) then
				format := format_table.found_item
			end
			if format /= Void then
				image_append (format.item1)
				if format.item2 /= Void then
					print_escaped_text (text.image);
					image_append (format.item2)
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
			prec: PRECURSOR_KEYWORD_TEXT
		do
			text_image := clone (text.image)
			text_image.to_lower
			prec ?= text
			if format_table.has (text_image) then
				format := format_table.found_item
			elseif prec /= Void and then format_table.has (f_Keyword_features) then
				format := format_table.found_item
			elseif format_table.has (f_Keyword) then
				format := format_table.found_item
			end

			if format /= Void then
				if prec /= Void then
					set_keywords_for_feature (prec.e_feature)
				end
				image_append (format.item1)
				if format.item2 /= Void then
					print_escaped_text (text.image)
					image_append (format.item2)
				end
				if prec /= Void then
					set_keyword (kw_File, Void)
					set_keyword (kw_Feature, Void)
				end
			else
				if prec /= Void then
					process_feature_text (prec)
				else
					print_escaped_text (text.image)
				end
			end
		end

	process_operator_text (text: OPERATOR_TEXT) is
			-- Process operator text.
		local
			format: CELL2 [STRING, STRING]
			text_image: STRING
			operator_generated: BOOLEAN
		do
			operator_generated := doc_universe.is_feature_generated (text.e_feature)
			text_image := clone (text.image)
			text_image.to_lower
			if format_table.has (text_image) then
				format := format_table.found_item
			elseif text.is_keyword then
				if operator_generated and then format_table.has (f_Keyword_features) then
					format := format_table.found_item
				elseif format_table.has (f_Keyword) then
					format := format_table.found_item
				end
			elseif text.is_symbol then
				if operator_generated and then format_table.has (f_Symbol_features) then
					format := format_table.found_item
				elseif format_table.has (f_Symbol) then
					format := format_table.found_item
				end
			end
			if format /= Void then
				set_keywords_for_feature (text.e_feature)
				image_append (format.item1)
				if format.item2 /= Void then
					print_escaped_text (text.image)
					image_append (format.item2)
				end
				set_keyword (kw_File, Void)
				set_keyword (kw_Feature, Void)
			else
				print_escaped_text (text.image)
			end
		end

	process_basic_text (text: BASIC_TEXT) is
			-- Check first if a format has been specified for `text'.
		local
			format: CELL2 [STRING, STRING]
			s: STRING
		do
			s := escaped_text (text.image)
			if format_table.has (f_Basic) then
				format := format_table.found_item
			end
			if format /= Void then
				image_append (format.item1)
				if format.item2 /= Void then
					image.append (s)
					image_append (format.item2)
				end
			else
					image.append (s)
			end
		end;

	process_comment_text (text: COMMENT_TEXT) is
			-- Process the quoted text within a comment.
		local
			format: CELL2 [STRING, STRING]
			s: STRING
			url: URL_COMMENT_TEXT
		do
			s := escaped_text (text.image)
			process_multiple_spaces (s)
			url ?= text
			if url /= Void and then format_table.has (f_Comment_url) then
				format := format_table.found_item
				set_keyword (kw_File, url.link)
			elseif format_table.has (f_Comment) then
				format := format_table.found_item
			end
			if format /= Void then
				image_append (format.item1)
				if format.item2 /= Void then
					image.append (s)
					image_append (format.item2)
				end
				if url /= Void then
					set_keyword (kw_File, Void)
				end
			else
					image.append (s)
			end
		end

	process_quoted_text (text: QUOTED_TEXT) is
			-- Process the quoted `text' within a comment.
		local
			format: CELL2 [STRING, STRING];
		do
			if format_table.has (f_Quoted) then
				format := format_table.found_item
				image_append (format.item1)
				if format.item2 /= Void then
					print_escaped_text (text.image_without_quotes)
					image_append (format.item2)
				end
			else
				print_escaped_text (text.image)
			end
		end

	process_cluster_name_text (text: CLUSTER_NAME_TEXT) is
		local
			format: CELL2 [STRING, STRING]
			cluster_generated: BOOLEAN
			q: QUOTED_TEXT
		do
			cluster_generated := doc_universe.is_cluster_generated (text.cluster_i)
			if cluster_generated then
				if format_table.has (f_Cluster_name) then
					format := format_table.found_item

					set_keyword (kw_File,
						relative_to_base ("" +
							text.cluster_i.relative_file_name (file_separator) +
							"." + file_suffix
						)
					)
				end
			else
				if format_table.has (f_Non_generated_Cluster) then
					format := format_table.found_item
				end
			end
			if format /= Void then
				image_append (format.item1)
				if format.item2 /= Void then
					q ?= text
					if q /= Void then
						print_escaped_text (q.image_without_quotes)
					else
						print_escaped_text (text.image)
					end
					image_append (format.item2)
				end
				if cluster_generated then
					set_keyword (kw_File, Void)
				end
			else
				print_escaped_text (text.image)
			end
		end

	process_class_name_text (text: CLASS_NAME_TEXT) is
		local
			format: CELL2 [STRING, STRING]
			class_generated: BOOLEAN
			q: QUOTED_TEXT
		do
			class_generated := doc_universe.is_class_generated (text.class_i)
			if class_generated then
				if format_table.has (f_Class_name) then
					format := format_table.found_item
					set_keyword (kw_File,
						relative_to_base ("" +
							text.class_i.document_file_relative_path (file_separator) +
							class_suffix
						)
					)
				end
			else
				if format_table.has (f_Non_generated_class) then
					format := format_table.found_item
				end
			end

			if format /= Void then
				image_append (format.item1)
				if format.item2 /= Void then
					q ?= text
					if q /= Void then
						print_escaped_text (q.image_without_quotes)
					else
						print_escaped_text (text.image)
					end
					image_append (format.item2)
				end
				if class_generated then
					set_keyword (kw_File, Void)
				end
			else
				print_escaped_text (text.image)
			end
		end

	process_new_line (text: NEW_LINE_ITEM) is
		local
			format: CELL2 [STRING, STRING]
		do
			if format_table.has (f_New_line) then
				format := format_table.found_item
				image_append (format.item1);
				if format.item2 /= Void then
					image.append ("%N")
					image_append (format.item2)
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
					image_append (format.item1);
					if format.item2 /= Void then
						image.append ("%T");
						image_append (format.item2)
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
			construct: STRING
			format: CELL2 [STRING, STRING]
			filter_item: FILTER_ITEM
			found: BOOLEAN
		do
			construct := text.construct
			if format_table.has (construct) then
				text.on_before_processing (Current)
				format := format_table.found_item
				if text.is_before then
					image_append (format.item1)
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
					image_append (format.item2)
				end
				text.on_after_processing (Current)
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

	escaped_text (str: STRING): STRING is
			-- Escape characters in `str'.
		require
			str_not_void: str /= Void
		local
			i, str_count: INTEGER;
			char: CHARACTER
		do
			if escape_characters.is_empty then
				Result := str
			else
				str_count := str.count
				create Result.make (str_count)
				from
					i := 1
				until
					i > str_count
				loop
					char := str.item (i)
					if escape_characters.has (char) then
						Result.append (escape_characters.item (char))
					else
						Result.extend (char)
					end
					i := i + 1
				end
			end
		end

	print_escaped_text (str: STRING) is
			-- Append `str' to `image' with escape characters
			-- substitutions if required.
		require
			str_not_void: str /= Void
		do
			image.append (escaped_text (str))
		end

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
		end

	process_exported_feature_name_text (text: EXPORTED_FEATURE_NAME_TEXT) is
			-- Process feature name text `t'.
		do
			process_basic_text (text)
		end;

	set_keywords_for_feature (f: E_FEATURE) is
			-- Set keywords "$file$" and "$feature$" to the correct
			-- values for `f'.
		local
			real_feature: E_FEATURE
			written_class: CLASS_C
			feat_suffix: STRING
		do
			written_class := f.written_class
			real_feature := written_class.feature_with_body_index (f.body_index)
			if feature_redirect /= Void then
				feat_suffix := feature_redirect + "." + file_suffix
			else
				feat_suffix := class_suffix
			end

			set_keyword (kw_File, relative_to_base ("" +
				written_class.lace_class.document_file_relative_path (file_separator) +
				feat_suffix
			))
			set_keyword (kw_Feature, real_feature.name)
		end

	process_feature_text (text: FEATURE_TEXT) is
			-- Process feature text `text'.
		local
			format: CELL2 [STRING, STRING]
			feature_generated: BOOLEAN
			q: QUOTED_TEXT
		do
			feature_generated := doc_universe.is_feature_generated (text.e_feature)
			if feature_generated then
				if format_table.has (f_Features) then
					format := format_table.found_item
					set_keywords_for_feature (text.e_feature)
				end
			else
				if format_table.has (f_Non_generated_feature) then
					format := format_table.found_item
				end
			end				
			if format /= Void then
				image_append (format.item1)
				if format.item2 /= Void then
					q ?= text
					if q /= Void then
						print_escaped_text (q.image_without_quotes)
					else
						print_escaped_text (text.image)
					end
					image_append (format.item2)
				end
				if feature_generated then
					set_keyword (kw_File, Void)
					set_keyword (kw_Feature, Void)
				end
			else
				print_escaped_text (text.image)
			end
		end

	process_breakpoint_index (text: BREAKPOINT_TEXT) is
			-- Process breakpoint index `text'.
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

	process_character_text (text: CHARACTER_TEXT) is
			-- Process the character `text'.
		local
			format: CELL2 [STRING, STRING];
		do
			if format_table.has (f_Character) then
				format := format_table.found_item
				image_append (format.item1)
				if format.item2 /= Void then
					print_escaped_text (text.image)
					image_append (format.item2)
				end
			else
				print_escaped_text (text.image)
			end
		end

	process_generic_text (text: GENERIC_TEXT) is
			-- Process a dot.
		local
			format: CELL2 [STRING, STRING];
		do
			if format_table.has (f_Generic) then
				format := format_table.found_item
				image_append (format.item1)
				if format.item2 /= Void then
					print_escaped_text (text.image)
					image_append (format.item2)
				end
			else
				print_escaped_text (text.image)
			end
		end

	process_indexing_tag_text (text: INDEXING_TAG_TEXT) is
			-- Process tag in indexing clause.
		local
			format: CELL2 [STRING, STRING];
		do
			if format_table.has (f_Indexing_tag) then
				format := format_table.found_item
				image_append (format.item1)
				if format.item2 /= Void then
					print_escaped_text (text.image)
					image_append (format.item2)
				end
			else
				print_escaped_text (text.image)
			end
		end

	process_local_text (text: LOCAL_TEXT) is
			-- Process local symbol `text'.
		local
			format: CELL2 [STRING, STRING];
		do
			if format_table.has (f_Local_symbol) then
				format := format_table.found_item
				image_append (format.item1)
				if format.item2 /= Void then
					print_escaped_text (text.image)
					image_append (format.item2)
				end
			else
				print_escaped_text (text.image)
			end
		end

	process_number_text (text: NUMBER_TEXT) is
			-- Process manifest number constant `text'.
		local
			format: CELL2 [STRING, STRING];
		do
			if format_table.has (f_Number) then
				format := format_table.found_item
				image_append (format.item1)
				if format.item2 /= Void then
					print_escaped_text (text.image)
					image_append (format.item2)
				end
			else
				print_escaped_text (text.image)
			end
		end

	process_assertion_tag_text (text: ASSERTION_TAG_TEXT) is
			-- Process assertion tag `text'.
		local
			format: CELL2 [STRING, STRING]
		do
			if format_table.has (f_Assertion_tag) then
				format := format_table.found_item
				image_append (format.item1)
				if format.item2 /= Void then
					print_escaped_text (text.image)
					image_append (format.item2)
				end
			else
				print_escaped_text (text.image)
			end
		end

	process_multiple_spaces (s: STRING) is
			-- Process sequences of 2 or more spaces.
		local
			format: CELL2 [STRING, STRING]
			rep: STRING
			i: INTEGER
			replacing: BOOLEAN
		do
			if format_table.has (f_Multiple_spaces) then
				format := format_table.found_item
				rep := format.item1
				if format.item2 /= Void then
					rep.extend (' ')
					rep.append (format.item2)
				end
				from
					i := 1
				until
					i > s.count
				loop
					if s @ i = ' ' then
						if replacing then
							s.remove (i)
							if i > s.count then
								s.append (rep)
							else
								s.insert_string (rep, i)
							end
							i := i + rep.count
						else
							replacing := True
							i := i + 1
						end
					else
						replacing := False
						i := i + 1
					end
				end
			end
		end

	process_string_text (text: STRING_TEXT) is
			-- Process literal string `text'.
		local
			format: CELL2 [STRING, STRING]
			s: STRING
			url: URL_STRING_TEXT
		do
			s := escaped_text (text.image)
			process_multiple_spaces (s)
			url ?= text
			if url /= Void and then format_table.has (f_String_url) then
				format := format_table.found_item
				set_keyword (kw_File, url.link)
			elseif format_table.has (f_String) then
				format := format_table.found_item
			end
			if format /= Void then
				format := format_table.found_item
				image_append (format.item1)
				if format.item2 /= Void then
					image.append (s)
					image_append (format.item2)
				end
				if url /= Void then
					set_keyword (kw_File, Void)
				end
			else
				image.append (s)
			end
		end

	process_reserved_word_text (text: RESERVED_WORD_TEXT) is
			-- Process literal string `text'.
		local
			format: CELL2 [STRING, STRING];
		do
			if format_table.has (f_Reserved_word) then
				format := format_table.found_item
				image_append (format.item1)
				if format.item2 /= Void then
					print_escaped_text (text.image)
					image_append (format.item2)
				end
			else
				print_escaped_text (text.image)
			end
		end

	process_menu_text (text: MENU_TEXT) is
			-- Process literal string `text'.
		local
			format: CELL2 [STRING, STRING]
			cmi: CLASS_MENU_TEXT
			format_item: STRING
		do
			cmi ?= text
			format_item := clone (f_Menu_item)
			if cmi /= Void then
				format_item.prepend ("class_")
			end
			if text.link = Void then
				format_item.append ("_disabled")
			else
				set_keyword (kw_File, text.link + "." + file_suffix)
			end

			if format_table.has (format_item) then
				format := format_table.found_item
				image_append (format.item1)
				if format.item2 /= Void then
					print_escaped_text (text.image)
					image_append (format.item2)
				end
			end
		end

feature {NONE} -- Implementation

	keyword_table: HASH_TABLE [STRING, STRING]
			-- Pairs of [substitute, keyword].

	image_append (s: STRING) is
			-- Append `s' to `image' after replacing keywords
			-- from `keyword_table'. The default keyword ("$") is not recognized anymore.
		local
			i, j: INTEGER
			kw: STRING
		do
			from
				i := 1
				j := 1
			until
				i > s.count
			loop
				i := s.index_of ('$', j)
				if i > 0 then
					image.append (s.substring (j, i - 1))
					j := s.index_of ('$', i + 1)
					if j > 0 then
						kw := s.substring (i + 1, j - 1)
						if keyword_table.has (kw) then
							image.append (keyword_table.found_item)
						else
							image.append (s.substring (i, j))
						end
						j := j + 1
					else
						j := i + 1
					end
				else
					i := s.count
					image.append (s.substring (j, i))
					i := i + 1
				end
			end
		end

	relative_to_base (rel_filename: STRING): STRING is
		local
			fn: EB_FILE_NAME
		do
			create fn.make_from_string (base_path)
			if file_separator /= '%U' then
				fn.set_separator (file_separator)
			end
			fn.extend (rel_filename)
			Result := fn
		end

invariant
	image_not_void: image /= Void

end -- class TEXT_FILTER
