note
	description: "Allow generation of specific formats (troff, mif, TEX, PostScript) for output of clickable, short, flat and flat-short."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

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

	SYSTEM_CONSTANTS

	SHARED_TEXT_ITEMS

	SHARED_WORKBENCH

	FILTER_PARSER

	EIFFEL_PROJECT_FACILITIES

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	SHARED_LOCALE

create
	make,
	make_from_path

feature {NONE} -- Initialization

	make (filtername: STRING_32)
			-- Make a new text filter with information read from `filtername'.
		require
			filtername_not_void: filtername /= Void
		do
			if not filtername.is_empty then
				make_from_path (eiffel_layout.filter_path.extended (filtername + ".fil"))
			else
				make_from_path (create {PATH}.make_from_string (filtername))
			end
		end

	make_from_path (filename: PATH)
			-- Make a new text filter with information read from `filename'.
		require
			filename_not_void: filename /= Void;
		do
			create format_table.make (50)
			create escape_characters.make_filled (Void, 0, {CHARACTER}.max_value + 1)
			if not filename.is_empty then
				read_formats (filename)
			end
			create image.make (2000)
			init_file_separator
			init_file_suffix
			prepend_to_file_suffix ("")
			create keyword_table.make (4)
			set_keyword ("generator", {STRING_32} "ISE " + Workbench_name + " version " + Version_number)
			set_base_path ("")
				-- We make DOCUMENTATION_UNIVERSE include all by default.
			create doc_universe.make
			doc_universe.include_all
		end

	init_file_separator
			-- Get preferred file separator from `format_table'.
		do
			if format_table.has_key (f_File_separator) then
				file_separator := format_table.found_item.item1
				if not file_separator.same_string_general ("/") and then not file_separator.same_string_general ("\") then
					file_separator := os_separator
				end
			else
				file_separator := os_separator
			end
		end

	init_file_suffix
			-- Get file suffix from `format_table'.
		do
			if format_table.has_key (f_Suffix) then
				file_suffix := format_table.found_item.item1
			end
			if file_suffix = Void then
				file_suffix := "txt"
			end
		end

feature -- Optional initialization

	prepend_to_file_suffix (a_suffix: STRING_32)
			-- Set `a_suffix' to be the suffix of every class link in
			-- the output file.
			-- Examples: "_flat" "_output"
		require
			a_suffix_not_void: a_suffix /= Void
		do
			class_suffix := a_suffix.twin
			class_suffix.append_string_general (".")
			class_suffix.append (file_suffix)
		end

feature -- Removal

	wipe_out_image
			-- Wipe out the image.
		do
			image.wipe_out
		end

feature -- Access

	count : INTEGER
			-- Count
		do
			Result := image.count
		end

	image: STRING_32;
			-- Filtered output text

	base_path: STRING_32
			-- For relative path names: zero or more "../".

	file_suffix: STRING_32
			-- Suffix of the file name where the filtered output text is stored;
			-- Void if it has not been specified in the filter specification

	file_separator: STRING_32
			-- Preferred file separator.

	class_suffix: STRING_32
			-- Appended to all class paths. Ends with `file_suffix'.

	feature_redirect: STRING_32
			-- When not `Void', prepend to file suffix to have features
			-- redirected to format where a feature bookmark can exist.

	doc_universe: DOCUMENTATION_UNIVERSE
			-- Classes and clusters for which documentation is generated.

	last_skipped_key: STRING_32

feature -- Status setting

	set_universe (a_universe: DOCUMENTATION_UNIVERSE)
			-- Change `doc_universe' to `a_universe'.
		require
			a_universe_not_void: a_universe /= Void
		do
			doc_universe := a_universe
		end

	set_feature_redirect (a_suffix: like feature_redirect)
			-- Let feature links be redirected to a different class format.
			-- Reason: in "_chart" format there is no feature bookmark.
		do
			feature_redirect := a_suffix
		end

	set_keyword (a_keyword, a_substitute: STRING_32)
			-- Add/change a keyword replacement. This means that
			-- in the .FIL file, every instance of "$`a_keyword'$"
			-- will be replaced with `a_substitute'.
			-- if `a_substitute' is `Void', remove `a_keyword'.
		require
			a_keyword_not_void: a_keyword /= Void
		do
			keyword_table.remove (a_keyword)
			if a_substitute /= Void then
				keyword_table.put (a_substitute, a_keyword)
			end
		end

	set_base_path (s: STRING_32)
			-- Set `base_path' to `s'.
		require
			s_not_void: s /= Void
		local
			sep: STRING_32
			p: STRING_32
		do
			base_path := s
			sep := file_separator
			if sep /= Void and then sep.same_string_general ("%U") then
				sep := os_separator
			end
			if not base_path.is_empty then
				p := base_path + sep
			else
				p := base_path
			end
			set_keyword (kw_Root, p)
		end

	start_skipping
			do
				skipping := True
			end

	stop_skipping
			do
				skipping := False
			end

feature -- Status report

	is_html: BOOLEAN
		do
			Result := file_suffix.as_lower.same_string_general ("html")
		end

	skipping: BOOLEAN
			-- Is skiping processing?
			-- Some stucture might be hidden by users.

feature -- Text processing: escaping

	escaped_text (str: READABLE_STRING_GENERAL): STRING_32
			-- New string where characters of `str' are escaped.
		require
			str_not_void: str /= Void
		do
			create Result.make (str.count)
			escaped_text_in_buffer (str, Result)
		ensure
			escaped_text_not_void: Result /= Void
		end

	escaped_text_in_buffer (str: READABLE_STRING_GENERAL; buffer: STRING_32)
			-- Escape characters in `str'.
		require
			str_not_void: str /= Void
			buffer_not_void: buffer /= Void
		local
			i, str_count: INTEGER;
			char: NATURAL_32
		do
			if escape_characters.is_empty then
				buffer.append_string_general (str)
			else
				str_count := str.count
				from
					i := 1
				until
					i > str_count
				loop
					char := str.code (i)
					if char.is_valid_character_8_code and then attached escape_characters.item (char.as_integer_32) as l_esc then
						buffer.append_string (l_esc)
					else
						buffer.extend (char.to_character_32)
					end
					i := i + 1
				end
			end
		end

feature -- Text processing

	process_symbol_text (text: READABLE_STRING_GENERAL)
			-- Process symbol text.
		local
			format: CELL2 [STRING_32, STRING_32];
			text_image: STRING_32
		do
			if not skipping then
				text_image := text.as_lower.as_string_32
				if format_table.has_key (text_image) then
					format := format_table.found_item
				elseif format_table.has_key (f_Symbol) then
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

	process_keyword_text (text: READABLE_STRING_GENERAL; a_feature: E_FEATURE)
			-- Process keyword text.
		local
			format: CELL2 [STRING_32, STRING_32];
			text_image: STRING_32
			l_feature_generated: BOOLEAN
		do
			if not skipping then
				text_image := text.as_lower.as_string_32
				if format_table.has_key (text_image) then
					format := format_table.found_item
				elseif a_feature /= Void and then format_table.has_key (f_Keyword_features) then
					format := format_table.found_item
				elseif format_table.has_key (f_Keyword) then
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
						process_feature_text (text, a_feature, False)
					else
						print_escaped_text (text)
					end
				end
			end
		end

	process_operator_text (text: READABLE_STRING_GENERAL; a_feature: E_FEATURE)
			-- Process operator text.
		local
			format: CELL2 [STRING_32, STRING_32]
			text_image: STRING_32
			operator_generated: BOOLEAN
			l_group: CONF_GROUP
		do
			if not skipping then
				operator_generated := doc_universe.is_feature_generated (a_feature)
				l_group := doc_universe.found_group
				text_image := text.as_lower.as_string_32
				if format_table.has_key (text_image) then
					format := format_table.found_item
				elseif is_keyword (text) then
					if operator_generated and then format_table.has_key (f_Keyword_features) then
						format := format_table.found_item
					elseif format_table.has_key (f_Keyword) then
						format := format_table.found_item
					end
				elseif is_symbol (text) then
					if operator_generated and then format_table.has_key (f_Symbol_features) then
						format := format_table.found_item
					elseif format_table.has_key (f_Symbol) then
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

	process_basic_text (text: READABLE_STRING_GENERAL)
			-- Check first if a format has been specified for `text'.
		local
			format: CELL2 [STRING_32, STRING_32]
		do
			if not skipping then
				if format_table.has_key (f_Basic) then
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

	process_comment_text (text: READABLE_STRING_GENERAL; url: READABLE_STRING_GENERAL)
			-- Process the quoted text within a comment.
		local
			format: CELL2 [STRING_32, STRING_32]
			s: STRING_32
		do
			if not skipping then
				s := escaped_text (text)
				process_multiple_spaces (s)
				if url /= Void and then format_table.has_key (f_Comment_url) then
					format := format_table.found_item
					set_keyword (kw_File, url.to_string_32)
				elseif format_table.has_key (f_Comment) then
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

	process_quoted_text (text: READABLE_STRING_GENERAL)
			-- Process the quoted `text' within a comment.
		do
			if not skipping then
				if attached format_table.item (f_Quoted) as format then
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

	process_cluster_name_text (text: READABLE_STRING_GENERAL; a_group: CONF_GROUP; a_quote: BOOLEAN)
		local
			format: CELL2 [STRING_32, STRING_32]
			cluster_generated: BOOLEAN
			path_pre: STRING_32
			l_string: STRING_32
		do
			if a_quote then
				l_string := text_quoted (text)
			else
				l_string := text.to_string_32
			end
			if not skipping then
				cluster_generated := doc_universe.is_group_generated (a_group)
				if cluster_generated then
					if format_table.has_key (f_Cluster_name) then
						format := format_table.found_item
						path_pre := path_representation (file_separator, a_group.name, a_group, False)
						set_keyword (kw_File, relative_to_base (path_pre + file_separator + "index") + "." + file_suffix)
					end
				else
					if format_table.has_key (f_Non_generated_Cluster) then
						format := format_table.found_item
					end
				end
				if format /= Void then
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (l_string)
						image_append (format.item2)
					end
					if cluster_generated then
						set_keyword (kw_File, Void)
					end
				else
					print_escaped_text (l_string)
				end
			end
		end

	process_class_name_text (text: READABLE_STRING_GENERAL; a_class: CLASS_I; a_quote: BOOLEAN)
		local
			format: CELL2 [STRING_32, STRING_32]
			class_generated: BOOLEAN
			l_group: CONF_GROUP
			path_pre: STRING_32
			l_string: STRING_32
		do
			if a_quote then
				l_string := text_quoted (text)
			else
				l_string := text.to_string_32
			end
			if not skipping then
				class_generated := doc_universe.is_class_generated (a_class)
				if class_generated then
					if format_table.has_key (f_Class_name) then
						l_group := doc_universe.found_group
						format := format_table.found_item
						path_pre := path_representation (file_separator, l_group.name, l_group, False)
						set_keyword (kw_File,
							relative_to_base (path_pre + file_separator + a_class.name.as_lower +
								class_suffix
							)
						)
					end
				else
					if format_table.has_key (f_Non_generated_class) then
						format := format_table.found_item
					end
				end

				if format /= Void then
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (l_string)
						image_append (format.item2)
					end
					if class_generated then
						set_keyword (kw_File, Void)
					end
				else
					print_escaped_text (l_string)
				end
			end
		end

	process_target_name_text (text: READABLE_STRING_GENERAL; a_target: CONF_TARGET)
			-- Process target name text `text'.
		do
			process_basic_text (text)
		end

	process_new_line
		local
			format: CELL2 [STRING_32, STRING_32]
		do
			if not skipping then
				if format_table.has_key (f_New_line) then
					format := format_table.found_item
					image_append (format.item1);
					if format.item2 /= Void then
						image.append_string_general ("%N")
						image_append (format.item2)
					end
				else
					image.append_string_general ("%N")
				end
			end
		end;

	process_indentation (a_indent_depth: INTEGER)
		local
			format: CELL2 [STRING_32, STRING_32];
			i: INTEGER
		do
			if not skipping then
				if format_table.has_key (f_Tab) then
					format := format_table.found_item
					from
						i := 1
					until
						i > a_indent_depth
					loop
						image_append (format.item1)
						if format.item2 /= Void then
							image.append_string_general ("%T")
							image_append (format.item2)
						end
						i := i + 1
					end
				else
					image.append (indentation (a_indent_depth))
				end
			end
		end

	process_filter_item (text: READABLE_STRING_GENERAL; is_before: BOOLEAN)
			-- Mark appearing before or after major syntactic constructs.
		local
			construct: STRING_32
			format: CELL2 [STRING_32, STRING_32]
		do
			construct := text.to_string_32
			if skipping then
				if last_skipped_key /= Void and then last_skipped_key.same_string_general (construct) then
					stop_skipping
					if format_table.has_key (construct) then
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
				if format_table.has_key (construct) then
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

	process_feature_dec_item (a_feature_name: READABLE_STRING_GENERAL; is_before: BOOLEAN)
			-- Process a feature start or after.
		local
			construct: STRING_32
			format: CELL2 [STRING_32, STRING_32]
		do
			construct := f_Feature_declaration
			if skipping then
				if last_skipped_key /= Void and then last_skipped_key.same_string_general (construct) then
					stop_skipping
					if format_table.has_key (construct) then
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
				if format_table.has_key (construct) then
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

	process_tooltip_item (a_tooltip: READABLE_STRING_GENERAL; is_before: BOOLEAN)
			-- Process a tooltip start or after.
		local
			construct: STRING_32
			format: CELL2 [STRING_32, STRING_32]
		do
			construct := f_Tooltip
			if skipping then
				if last_skipped_key /= Void and then last_skipped_key.same_string_general (construct) then
					stop_skipping
				end
			else
				if format_table.has_key (construct) then
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

	process_after_class (a_class: CLASS_C)
		do
			if not skipping then
				print_escaped_text (" ");
				process_comment_text (ti_dashdash, Void)
				print_escaped_text (" ");
				process_comment_text ("class ", Void);
				add_class (a_class.lace_class)
			end
		end;

	print_escaped_text (str: READABLE_STRING_GENERAL)
			-- Append `str' to `image' with escape characters
			-- substitutions if required.
		require
			str_not_void: str /= Void
		do
			escaped_text_in_buffer (str, image)
		end

	process_cl_syntax (text: READABLE_STRING_GENERAL; a_syntax_message: ERROR; a_class: CLASS_C)
			-- Process class syntax text.
		do
			process_basic_text (text)
		end;

	process_ace_syntax (text: READABLE_STRING_GENERAL; a_error: ERROR)
			-- Process Ace syntax text.
		do
			process_basic_text (text)
		end;

	process_address_text (a_address, a_name: READABLE_STRING_GENERAL; a_class: CLASS_C)
			-- Process address text.
		do
			process_basic_text (a_address)
		end;

	process_padded
			-- Process padded item at start of non breakpoint line.
		do
		end;

	process_feature_name_text (text: READABLE_STRING_GENERAL; a_class: CLASS_C)
			-- Process feature name text `t'.
		do
			process_basic_text (text)
		end

	set_keywords_for_feature (f: E_FEATURE; a_group: CONF_GROUP)
			-- Set keywords "$file$" and "$feature$" to the correct
			-- values for `f'.
		require
			f_not_void: f /= Void
			a_group_not_void: a_group /= Void
		local
			real_feature: E_FEATURE
			feat_suffix: STRING_32
			l_class_i : CLASS_I
			path_pre: STRING_32
			l_name: STRING_32
		do
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
			path_pre := path_representation (file_separator, a_group.name, a_group, False)
			set_keyword (kw_File, relative_to_base (path_pre + file_separator + l_class_i.name.as_lower + feat_suffix))
			if real_feature = Void then
				l_name := f.name_32
			else
				l_name := real_feature.name_32
			end
			set_keyword (kw_Feature, escaped_text (l_name))
		end

	process_feature_text (text: READABLE_STRING_GENERAL; a_feature: E_FEATURE; a_quote: BOOLEAN)
			-- Process feature text `text'.
		local
			format: CELL2 [STRING_32, STRING_32]
			feature_generated: BOOLEAN
			l_string: STRING_32
		do
			if a_quote then
				l_string := text_quoted (text)
			else
				l_string := text.to_string_32
			end
			if not skipping then
				feature_generated := doc_universe.is_feature_generated (a_feature)
				if feature_generated then
					if format_table.has_key (f_Features) then
						format := format_table.found_item
						set_keywords_for_feature (a_feature, doc_universe.found_group)
					end
				else
					if format_table.has_key (f_Non_generated_feature) then
						format := format_table.found_item
					end
				end
				if format /= Void then
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (l_string)
						image_append (format.item2)
					end
					if feature_generated then
						set_keyword (kw_File, Void)
						set_keyword (kw_Feature, Void)
					end
				else
					print_escaped_text (l_string)
				end
			end
		end

	process_breakpoint_index (a_feature: E_FEATURE; a_index: INTEGER; a_cond: BOOLEAN)
			-- Process breakpoint index `text'.
		local
			str: STRING_32
		do
			str := a_index.out
			if a_cond then
				str := str + "*"
			end
			process_basic_text (str)
		end;

	process_breakpoint (a_feature: E_FEATURE; a_index: INTEGER)
			-- Process breakpoint.
		do
		end;

	process_error_text (text: READABLE_STRING_GENERAL; a_error: ERROR)
			-- Process error text.
		do
			process_basic_text (text)
		end;

	process_before_class (a_class: CLASS_C)
			-- Process before class `t'.
		do
		end;

	process_character_text (text: READABLE_STRING_GENERAL)
			-- Process the character `text'.
		local
			format: CELL2 [STRING_32, STRING_32];
		do
			if not skipping then
				if format_table.has_key (f_Character) then
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

	process_generic_text (text: READABLE_STRING_GENERAL)
			-- Process a dot.
		local
			format: CELL2 [STRING_32, STRING_32];
		do
			if not skipping then
				if format_table.has_key (f_Generic) then
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

	process_indexing_tag_text (text: READABLE_STRING_GENERAL)
			-- Process tag in indexing clause.
		local
			format: CELL2 [STRING_32, STRING_32];
		do
			if not skipping then
				if format_table.has_key (f_Indexing_tag) then
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

	process_local_text (a_ast: AST_EIFFEL; text: READABLE_STRING_GENERAL)
			-- Process local symbol `text'.
		local
			format: CELL2 [STRING_32, STRING_32];
		do
			if not skipping then
				if format_table.has_key (f_Local_symbol) then
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

	process_number_text (text: READABLE_STRING_GENERAL)
			-- Process manifest number constant `text'.
		local
			format: CELL2 [STRING_32, STRING_32];
		do
			if not skipping then
				if format_table.has_key (f_Number) then
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

	process_assertion_tag_text (text: READABLE_STRING_GENERAL)
			-- Process assertion tag `text'.
		local
			format: CELL2 [STRING_32, STRING_32]
		do
			if not skipping then
				if format_table.has_key (f_Assertion_tag) then
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

	process_multiple_spaces (s: STRING_32)
			-- Process sequences of 2 or more spaces.
		local
			format: CELL2 [STRING_32, STRING_32]
			rep: STRING_32
			i: INTEGER
			replacing: BOOLEAN
		do
			if
				not skipping and then
				format_table.has_key (f_Multiple_spaces)
			then
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
					if s [i] = ' ' then
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

	process_string_text (text: READABLE_STRING_GENERAL; link: READABLE_STRING_GENERAL)
			-- Process literal string `text'.
		local
			format: CELL2 [STRING_32, STRING_32]
			s: STRING_32
		do
			if not skipping then
				s := escaped_text (text)
				process_multiple_spaces (s)
				if link /= Void and then format_table.has_key (f_String_url) then
					format := format_table.found_item
					set_keyword (kw_File, link.to_string_32)
				elseif format_table.has_key (f_String) then
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

	process_reserved_word_text (text: READABLE_STRING_GENERAL)
			-- Process literal string `text'.
		local
			format: CELL2 [STRING_32, STRING_32];
		do
			if not skipping then
				if format_table.has_key (f_Reserved_word) then
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

	process_menu_text (text, link: READABLE_STRING_GENERAL)
			-- Process literal string `text'.
		local
			format: CELL2 [STRING_32, STRING_32]
			format_item: STRING_32
		do
			if not skipping then
				format_item := f_Menu_item.twin
				if link = Void then
					format_item.append_string_general ("_disabled")
				else
					set_keyword (kw_File, link.as_string_32 + "." + file_suffix)
				end

				if format_table.has_key (format_item) then
					format := format_table.found_item
					image_append (format.item1)
					if format.item2 /= Void then
						print_escaped_text (text)
						image_append (format.item2)
					end
				end
			end
		end

	process_class_menu_text (text, link: READABLE_STRING_GENERAL)
			-- Process literal string `text'.
		local
			format: CELL2 [STRING_32, STRING_32]
			format_item: STRING_32
		do
			if not skipping then
				format_item := f_Menu_item.twin
				format_item.prepend_string_general ("class_")
				if link = Void then
					format_item.append_string_general ("_disabled")
				else
					set_keyword (kw_File, link.as_string_32 + "." + file_suffix)
				end

				if format_table.has_key (format_item) then
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

	keyword_table: HASH_TABLE [STRING_32, STRING_32]
			-- Pairs of [substitute, keyword].

	image_append (s: STRING_32)
			-- Append `s' to `image' after replacing keywords
			-- from `keyword_table'. The default keyword ("$") is not recognized anymore.
		local
			i: INTEGER
			kw: STRING_32
			l_c: CHARACTER_32
			l_state: INTEGER
			l_image: like image
			l_keyword_table: like keyword_table
			l_dollar: like dollar_code
		do
			l_image := image
			l_keyword_table := keyword_table
			l_dollar := dollar_code
			from
				i := 1
				create kw.make (20)
			until
				i > s.count
			loop
				l_c := s.item (i)
				if l_state = 0 and l_c.code /= l_dollar then
					l_image.append_character (l_c)
				elseif l_state = 0 and l_c.code = l_dollar then
					l_state := 1
				elseif l_state = 1 and l_c.code /= l_dollar then
					kw.append_character (l_c)
				elseif l_state = 1 and l_c.code = l_dollar then
					if l_keyword_table.has_key (kw) then
						l_image.append (l_keyword_table.found_item)
					else
						l_image.append (kw)
					end
					kw.wipe_out
					l_state := 0
				end
				i := i + 1
			end
			if l_state /= 0 and not kw.is_empty then
				l_image.append (kw)
			end
		end

	dollar_code: INTEGER
			-- Charactor code for '$'
		once
			Result := ('$').code
		end

	os_separator: STRING_32
		once
			create Result.make (1)
			Result.append_character (operating_environment.directory_separator)
		end

	relative_to_base (rel_filename: STRING_32): STRING_32
		require
			rel_filename_not_void: rel_filename /= Void
		local
			l_base_path: like base_path
		do
			l_base_path := base_path
			create Result.make (l_base_path.count + 100)
			Result.append (l_base_path)
			if not Result.is_empty then
				Result.append (os_separator)
			end
			Result.append (rel_filename)
			if not file_separator.same_string_general ("%U") then
				Result.replace_substring_all (os_separator, file_separator)
			end
		ensure
			Result_not_void: Result /= Void
		end

invariant
	image_not_void: image /= Void

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
