indexing
	description:
		"Allow generation of specific formats (troff, mif, TEX,%
		%PostScript) for output of clickable, short, flat and flat-short"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	TEXT_FILTER

inherit
	TEXT_FORMATTER
		redefine
			process_character_text,
			process_generic_text,
			process_indexing_tag_text,
			process_local_text,
			process_number_text,
			process_assertion_tag_text,
			process_string_text,
			process_reserved_word_text,
			process_menu_text,
			process_tooltip_item,
			process_feature_dec_item,
			process_class_menu_text
		end

	EIFFEL_ENV

	SHARED_TEXT_ITEMS

	SHARED_WORKBENCH

	FILTER_PARSER

	DOCUMENT_HELPER

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
			create escape_characters.make (0, {CHARACTER}.max_value + 1)
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
				-- We make DOCUMENTATION_UNIVERSE include all by default.
			create doc_universe.make
			doc_universe.include_all
		end

	init_file_separator is
			-- Get preferred file separator from `format_table'.
		do
			if format_table.has (f_File_separator) then
				file_separator := format_table.found_item.item1 @ 1
				if file_separator /= '/' and file_separator /= '\' then
					file_separator := operating_environment.directory_separator
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
			class_suffix := a_suffix.twin
			class_suffix.append (".")
			class_suffix.append (file_suffix)
		end

feature -- Removal

	wipe_out_image is
			-- Wipe out the image.
		do
			image.clear_all
		end

feature -- Access

	count : INTEGER is
			-- Count
		do
			Result := image.count
		end

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

	last_skipped_key: STRING

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

	start_skipping is
			do
				skipping := true
			end

	stop_skipping is
			do
				skipping := false
			end

feature -- Status report

	is_html: BOOLEAN is
		local
			s: STRING
		do
			s := file_suffix.as_lower
			Result := file_suffix.is_equal ("html")
		end

	skipping: BOOLEAN
			-- Is skiping processing?
			-- Some stucture might be hidden by users.

feature -- Text processing

	escaped_text (str: STRING): STRING is
			-- New string where characters of `str' are escaped.
		require
			str_not_void: str /= Void
		do
			create Result.make (str.count)
			escaped_text_in_buffer (str, Result)
		ensure
			escaped_text_not_void: Result /= Void
		end

	escaped_text_in_buffer (str, buffer: STRING) is
			-- Escape characters in `str'.
		require
			str_not_void: str /= Void
			buffer_not_void: buffer /= Void
		local
			i, str_count: INTEGER;
			char: CHARACTER
		do
			if escape_characters.is_empty then
				buffer.append (str)
			else
				str_count := str.count
				from
					i := 1
				until
					i > str_count
				loop
					char := str.item (i)
					if escape_characters.item (char.code) /= Void then
						buffer.append (escape_characters.item (char.code))
					else
						buffer.extend (char)
					end
					i := i + 1
				end
			end
		end

feature -- Text processing

	process_symbol_text (text: STRING) is
			-- Process symbol text.
		local
			format: CELL2 [STRING, STRING];
			text_image: STRING
		do
			if not skipping then
				text_image := text.as_lower
				if format_table.has (text_image) then
					format := format_table.found_item
				elseif format_table.has (f_Symbol) then
					format := format_table.found_item
				end
				if format /= Void then
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (text);
						image_append (format.item2)
					end
				else
					print_escaped_text (text)
				end
			end
		end;

	process_keyword_text (text: STRING; a_feature: E_FEATURE) is
			-- Process keyword text.
		local
			format: CELL2 [STRING, STRING];
			text_image: STRING
			l_feature_generated: BOOLEAN
		do
			if not skipping then
				text_image := text.as_lower
				if format_table.has (text_image) then
					format := format_table.found_item
				elseif a_feature /= Void and then format_table.has (f_Keyword_features) then
					format := format_table.found_item
				elseif format_table.has (f_Keyword) then
					format := format_table.found_item
				end

				if format /= Void then
					if a_feature /= Void then
						l_feature_generated := doc_universe.is_feature_generated (a_feature)
						if l_feature_generated then
							set_keywords_for_feature (a_feature, doc_universe.found_group)
						end
					end
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (text)
						image_append (format.item2)
					end
					if l_feature_generated then
						set_keyword (kw_File, Void)
						set_keyword (kw_Feature, Void)
					end
				else
					if a_feature /= Void then
						process_feature_text (text, a_feature, false)
					else
						print_escaped_text (text)
					end
				end
			end
		end

	process_operator_text (text: STRING; a_feature: E_FEATURE) is
			-- Process operator text.
		local
			format: CELL2 [STRING, STRING]
			text_image: STRING
			operator_generated: BOOLEAN
			l_group: CONF_GROUP
		do
			if not skipping then
				operator_generated := doc_universe.is_feature_generated (a_feature)
				l_group := doc_universe.found_group
				text_image := text.as_lower
				if format_table.has (text_image) then
					format := format_table.found_item
				elseif is_keyword (text) then
					if operator_generated and then format_table.has (f_Keyword_features) then
						format := format_table.found_item
					elseif format_table.has (f_Keyword) then
						format := format_table.found_item
					end
				elseif is_symbol (text) then
					if operator_generated and then format_table.has (f_Symbol_features) then
						format := format_table.found_item
					elseif format_table.has (f_Symbol) then
						format := format_table.found_item
					end
				end
				if format /= Void then
					if operator_generated then
						set_keywords_for_feature (a_feature, l_group)
					end
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (text)
						image_append (format.item2)
					end
					if operator_generated then
						set_keyword (kw_File, Void)
						set_keyword (kw_Feature, Void)
					end
				else
					print_escaped_text (text)
				end
			end
		end

	process_basic_text (text: STRING) is
			-- Check first if a format has been specified for `text'.
		local
			format: CELL2 [STRING, STRING]
		do
			if not skipping then
				if format_table.has (f_Basic) then
					format := format_table.found_item
				end
				if format /= Void then
					image_append (format.item1)
					if format.item2 /= Void then
						escaped_text_in_buffer (text, image)
						image_append (format.item2)
					end
				else
					escaped_text_in_buffer (text, image)
				end
			end
		end;

	process_comment_text (text: STRING; url: STRING) is
			-- Process the quoted text within a comment.
		local
			format: CELL2 [STRING, STRING]
			s: STRING
		do
			if not skipping then
				s := escaped_text (text)
				process_multiple_spaces (s)
				if url /= Void and then format_table.has (f_Comment_url) then
					format := format_table.found_item
					set_keyword (kw_File, url)
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
		end

	process_quoted_text (text: STRING) is
			-- Process the quoted `text' within a comment.
		local
			format: CELL2 [STRING, STRING];
		do
			if not skipping then
				if format_table.has (f_Quoted) then
					format := format_table.found_item
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (text)
						image_append (format.item2)
					end
				else
					print_escaped_text (text_quoted (text))
				end
			end
		end

	process_cluster_name_text (text: STRING; a_cluster: CONF_GROUP; a_quote: BOOLEAN) is
		local
			format: CELL2 [STRING, STRING]
			cluster_generated: BOOLEAN
			path_pre: STRING
		do
			if not skipping then
				cluster_generated := doc_universe.is_group_generated (a_cluster)
				if cluster_generated then
					if format_table.has (f_Cluster_name) then
						format := format_table.found_item
						path_pre := path_representation (file_separator.out, a_cluster.name, a_cluster, False)
						set_keyword (kw_File, relative_to_base (path_pre + file_separator.out + a_cluster.name) + "." + file_suffix)
					end
				else
					if format_table.has (f_Non_generated_Cluster) then
						format := format_table.found_item
					end
				end
				if format /= Void then
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (text)
						image_append (format.item2)
					end
					if cluster_generated then
						set_keyword (kw_File, Void)
					end
				else
					print_escaped_text (text_quoted (text))
				end
			end
		end

	process_class_name_text (text: STRING; a_class: CLASS_I; a_quote: BOOLEAN) is
		local
			format: CELL2 [STRING, STRING]
			class_generated: BOOLEAN
			l_group: CONF_GROUP
			path_pre: STRING
		do
			if not skipping then
				class_generated := doc_universe.is_class_generated (a_class)
				if class_generated then
					if format_table.has (f_Class_name) then
						l_group := doc_universe.found_group
						format := format_table.found_item
						path_pre := path_representation (file_separator.out, l_group.name, l_group, False)
						set_keyword (kw_File,
							relative_to_base (path_pre + file_separator.out + a_class.name.as_lower +
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
						print_escaped_text (text)
						image_append (format.item2)
					end
					if class_generated then
						set_keyword (kw_File, Void)
					end
				else
					print_escaped_text (text_quoted (text))
				end
			end
		end

	process_new_line is
		local
			format: CELL2 [STRING, STRING]
		do
			if not skipping then
				if format_table.has (f_New_line) then
					format := format_table.found_item
					image_append (format.item1);
					if format.item2 /= Void then
						image.append ("%N")
						image_append (format.item2)
					end
				else
					image.append ("%N")
				end
			end
		end;

	process_indentation (a_indent_depth: INTEGER) is
		local
			format: CELL2 [STRING, STRING];
			i: INTEGER
			str: STRING
		do
			if not skipping then
				if format_table.has (f_Tab) then
					format := format_table.found_item
					from
						i := 1
					until
						i > a_indent_depth
					loop
						image_append (format.item1);
						if format.item2 /= Void then
							image.append ("%T");
							image_append (format.item2)
						end;
						i := i + 1
					end
				else
					str := indentation (a_indent_depth)
					image.append (str)
				end
			end
		end;

	process_filter_item (text: STRING; is_before: BOOLEAN) is
			-- Mark appearing before or after major syntactic constructs.
		local
			construct: STRING
			format: CELL2 [STRING, STRING]
		do
			construct := text
			if skipping then
				if last_skipped_key /= Void and then last_skipped_key.is_equal (construct) then
					stop_skipping
					if format_table.has (construct) then
						format := format_table.found_item
						if is_before then
							image_append (format.item1)
							if format.item2 = Void then
									-- The user wants to hide this construct.
									-- Get rid of the text items until
									-- the end mark of that construct.
								start_skipping
								last_skipped_key := construct
							end
						elseif format.item2 /= Void then
							image_append (format.item2)
						end
					end
				end
			else
				if format_table.has (construct) then
					format := format_table.found_item
					if is_before then
						image_append (format.item1)
						if format.item2 = Void then
								-- The user wants to hide this construct.
								-- Get rid of the text items until
								-- the end mark of that construct.
							start_skipping
							last_skipped_key := construct
						end
					elseif format.item2 /= Void then
						image_append (format.item2)
					end
				end
			end
		end;

	process_feature_dec_item (a_feature_name: STRING; is_before: BOOLEAN) is
			-- Process a feature start or after.
		local
			construct: STRING
			format: CELL2 [STRING, STRING]
		do
			construct := f_Feature_declaration
			if skipping then
				if last_skipped_key /= Void and then last_skipped_key.is_equal (construct) then
					stop_skipping
					if format_table.has (construct) then
						set_keyword (kw_Feature, escaped_text (a_feature_name))
						format := format_table.found_item
						if is_before then
							image_append (format.item1)
							if format.item2 = Void then
									-- The user wants to hide this construct.
									-- Get rid of the text items until
									-- the end mark of that construct.
								start_skipping
								last_skipped_key := construct
							end
						elseif format.item2 /= Void then
							image_append (format.item2)
						end
						set_keyword (kw_Feature, Void)
					end
				end
			else
				if format_table.has (construct) then
					set_keyword (kw_Feature, escaped_text (a_feature_name))
					format := format_table.found_item
					if is_before then
						image_append (format.item1)
						if format.item2 = Void then
								-- The user wants to hide this construct.
								-- Get rid of the text items until
								-- the end mark of that construct.
							start_skipping
							last_skipped_key := construct
						end
					elseif format.item2 /= Void then
						image_append (format.item2)
					end
					set_keyword (kw_Feature, Void)
				end
			end
		end;

	process_tooltip_item (a_tooltip: STRING; is_before: BOOLEAN) is
			-- Process a tooltip start or after.
		local
			construct: STRING
			format: CELL2 [STRING, STRING]
		do
			construct := f_Tooltip
			if skipping then
				if last_skipped_key /= Void and then last_skipped_key.is_equal (construct) then
					stop_skipping
				end
			else
				if format_table.has (construct) then
					set_keyword (kw_Tooltip, escaped_text (a_tooltip))
					format := format_table.found_item
					if is_before then
						image_append (format.item1)
						if format.item2 = Void then
								-- The user wants to hide this construct.
								-- Get rid of the text items until
								-- the end mark of that construct.
							last_skipped_key := construct
						end
					elseif format.item2 /= Void then
						image_append (format.item2)
					end
					set_keyword (kw_Tooltip, Void)
				end
			end
		end;

	process_after_class (a_class: CLASS_C) is
		do
			if not skipping then
				print_escaped_text (" ");
				process_comment_text (ti_dashdash, Void)
				print_escaped_text (" ");
				process_comment_text ("class ", Void);
				print_escaped_text (a_class.name_in_upper)
			end
		end;

	print_escaped_text (str: STRING) is
			-- Append `str' to `image' with escape characters
			-- substitutions if required.
		require
			str_not_void: str /= Void
		do
			escaped_text_in_buffer (str, image)
		end

	process_cl_syntax (text: STRING; a_syntax_message: SYNTAX_MESSAGE; a_class: CLASS_C) is
			-- Process class syntax text.
		do
			process_basic_text (text)
		end;

	process_ace_syntax (text: STRING; a_error: ERROR) is
			-- Process Ace syntax text.
		do
			process_basic_text (text)
		end;

	process_address_text (a_address, a_name: STRING; a_class: CLASS_C) is
			-- Process address text.
		do
			process_basic_text (a_address)
		end;

	process_padded is
			-- Process padded item at start of non breakpoint line.
		do
		end;

	process_feature_name_text (text: STRING; a_class: CLASS_C) is
			-- Process feature name text `t'.
		do
			process_basic_text (text)
		end

	set_keywords_for_feature (f: E_FEATURE; a_group: CONF_GROUP) is
			-- Set keywords "$file$" and "$feature$" to the correct
			-- values for `f'.
		require
			f_not_void: f /= Void
			a_group_not_void: a_group /= Void
		local
			real_feature: E_FEATURE
			written_class: CLASS_C
			feat_suffix: STRING
			l_class_i : CLASS_I
			path_pre: STRING
		do
			written_class := f.written_class

				-- Reading from feature table is time consuming,
				-- If we find a better way, 10% we will gain.
			real_feature := f.written_feature

			if feature_redirect /= Void then
				feat_suffix := feature_redirect + "." + file_suffix
			else
				feat_suffix := class_suffix
			end

			feat_suffix := escaped_text (feat_suffix)
			l_class_i := f.written_class.lace_class
			path_pre := path_representation (file_separator.out, a_group.name, a_group, False)
			set_keyword (kw_File, relative_to_base (path_pre + file_separator.out + l_class_i.name.as_lower + feat_suffix))
			set_keyword (kw_Feature, escaped_text (real_feature.name))
		end

	process_feature_text (text: STRING; a_feature: E_FEATURE; a_quote: BOOLEAN) is
			-- Process feature text `text'.
		local
			format: CELL2 [STRING, STRING]
			feature_generated: BOOLEAN
		do
			if not skipping then
				feature_generated := doc_universe.is_feature_generated (a_feature)
				if feature_generated then
					if format_table.has (f_Features) then
						format := format_table.found_item
						set_keywords_for_feature (a_feature, doc_universe.found_group)
					end
				else
					if format_table.has (f_Non_generated_feature) then
						format := format_table.found_item
					end
				end
				if format /= Void then
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (text)
						image_append (format.item2)
					end
					if feature_generated then
						set_keyword (kw_File, Void)
						set_keyword (kw_Feature, Void)
					end
				else
					print_escaped_text (text_quoted (text))
				end
			end
		end

	process_breakpoint_index (a_feature: E_FEATURE; a_index: INTEGER; a_cond: BOOLEAN) is
			-- Process breakpoint index `text'.
		local
			str: STRING
		do
			str := a_index.out
			if a_cond then
				str := str + "*"
			end
			process_basic_text (str)
		end;


	process_breakpoint (a_feature: E_FEATURE; a_index: INTEGER) is
			-- Process breakpoint.
		do
		end;

	process_error_text (text: STRING; a_error: ERROR) is
			-- Process error text.
		do
			process_basic_text (text)
		end;

	process_before_class (a_class: CLASS_C) is
			-- Process before class `t'.
		do
		end;

	process_character_text (text: STRING) is
			-- Process the character `text'.
		local
			format: CELL2 [STRING, STRING];
		do
			if not skipping then
				if format_table.has (f_Character) then
					format := format_table.found_item
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (text)
						image_append (format.item2)
					end
				else
					print_escaped_text (text)
				end
			end
		end

	process_generic_text (text: STRING) is
			-- Process a dot.
		local
			format: CELL2 [STRING, STRING];
		do
			if not skipping then
				if format_table.has (f_Generic) then
					format := format_table.found_item
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (text)
						image_append (format.item2)
					end
				else
					print_escaped_text (text)
				end
			end
		end

	process_indexing_tag_text (text: STRING) is
			-- Process tag in indexing clause.
		local
			format: CELL2 [STRING, STRING];
		do
			if not skipping then
				if format_table.has (f_Indexing_tag) then
					format := format_table.found_item
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (text)
						image_append (format.item2)
					end
				else
					print_escaped_text (text)
				end
			end
		end

	process_local_text (text: STRING) is
			-- Process local symbol `text'.
		local
			format: CELL2 [STRING, STRING];
		do
			if not skipping then
				if format_table.has (f_Local_symbol) then
					format := format_table.found_item
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (text)
						image_append (format.item2)
					end
				else
					print_escaped_text (text)
				end
			end
		end

	process_number_text (text: STRING) is
			-- Process manifest number constant `text'.
		local
			format: CELL2 [STRING, STRING];
		do
			if not skipping then
				if format_table.has (f_Number) then
					format := format_table.found_item
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (text)
						image_append (format.item2)
					end
				else
					print_escaped_text (text)
				end
			end
		end

	process_assertion_tag_text (text: STRING) is
			-- Process assertion tag `text'.
		local
			format: CELL2 [STRING, STRING]
		do
			if not skipping then
				if format_table.has (f_Assertion_tag) then
					format := format_table.found_item
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (text)
						image_append (format.item2)
					end
				else
					print_escaped_text (text)
				end
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
			if not skipping then
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
		end

	process_string_text (text: STRING; link: STRING) is
			-- Process literal string `text'.
		local
			format: CELL2 [STRING, STRING]
			s: STRING
		do
			if not skipping then
				s := escaped_text (text)
				process_multiple_spaces (s)
				if link /= Void and then format_table.has (f_String_url) then
					format := format_table.found_item
					set_keyword (kw_File, link)
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
					if link /= Void then
						set_keyword (kw_File, Void)
					end
				else
					image.append (s)
				end
			end
		end

	process_reserved_word_text (text: STRING) is
			-- Process literal string `text'.
		local
			format: CELL2 [STRING, STRING];
		do
			if not skipping then
				if format_table.has (f_Reserved_word) then
					format := format_table.found_item
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (text)
						image_append (format.item2)
					end
				else
					print_escaped_text (text)
				end
			end
		end

	process_menu_text (text, link: STRING) is
			-- Process literal string `text'.
		local
			format: CELL2 [STRING, STRING]
			format_item: STRING
		do
			if not skipping then
				format_item := f_Menu_item.twin
				if link = Void then
					format_item.append ("_disabled")
				else
					set_keyword (kw_File, link + "." + file_suffix)
				end

				if format_table.has (format_item) then
					format := format_table.found_item
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (text)
						image_append (format.item2)
					end
				end
			end
		end

	process_class_menu_text (text, link: STRING) is
			-- Process literal string `text'.
		local
			format: CELL2 [STRING, STRING]
			format_item: STRING
		do
			if not skipping then
				format_item := f_Menu_item.twin
				format_item.prepend ("class_")
				if link = Void then
					format_item.append ("_disabled")
				else
					set_keyword (kw_File, link + "." + file_suffix)
				end

				if format_table.has (format_item) then
					format := format_table.found_item
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (text)
						image_append (format.item2)
					end
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
			i: INTEGER
			kw: STRING
			l_c: CHARACTER
			l_state: INTEGER
		do
			from
				i := 1
				create kw.make (20)
			until
				i > s.count
			loop
				l_c := s.item (i)
				if l_state = 0 and l_c.code /= dollar_code then
					image.append_character (l_c)
				elseif l_state = 0 and l_c.code = dollar_code then
					l_state := 1
				elseif l_state = 1 and l_c.code /= dollar_code then
					kw.append_character (l_c)
				elseif l_state = 1 and l_c.code = dollar_code then
					if keyword_table.has (kw) then
						image.append (keyword_table.found_item)
					else
						image.append (kw)
					end
					kw.clear_all
					l_state := 0
				end
				i := i + 1
			end
			if l_state /= 0 and not kw.is_empty then
				image.append (kw)
			end
		end

	dollar_code: INTEGER is
			-- Charactor code for '$'
		once
			Result := ('$').code
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class TEXT_FILTER
