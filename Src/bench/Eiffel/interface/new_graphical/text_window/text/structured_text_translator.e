indexing
	description: "Translators of STRUCTURED_TEXTs."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	STRUCTURED_TEXT_TRANSLATOR

inherit
	TEXT_FORMATTER
		redefine
			process_text, process_string_text,
			process_assertion_tag_text, process_indexing_tag_text,
			process_generic_text, process_character_text, process_local_text,
			process_number_text, process_reserved_word_text,
			process_feature_error
		end

feature {NONE} -- Initialization

	make is
		do
			after := True
--			create kept_objects.make
		end

feature -- Access

	last_line: VIEWER_LINE

--	kept_objects: LINKED_SET [STRING]
--			-- Address of objects viewed in this text.

feature -- Status report

	has_breakable_slots: BOOLEAN
			-- Is there any breakable slots displayed ?
			-- (and thus a left margin visible)

feature -- Status setting

	enable_has_breakable_slots is
			-- Set `has_breakable_slots' to `True'.
		do
			has_breakable_slots := True
		end	

	disable_has_breakable_slots is
			-- Set `has_breakable_slots' to `False'.
		do
			has_breakable_slots := False
		end	

feature -- End of file

	after: BOOLEAN

feature -- Basic Operations

	start  is
		do
			current_text.start
			after := current_text.after
		end

	process_line is
		local
			text_item: TEXT_ITEM
		do
			from
				eol_reached := False
				create last_line.make_empty_line
			until
				eol_reached or else after
			loop
				text_item := current_text.item
				text_item.append_to (Current)
				current_text.forth
				after := current_text.after
			end
			last_line.set_width (last_line.eol_token.position)
		end

feature -- Text processing

	process_text (a_text: STRUCTURED_TEXT) is
			-- Process structured text `text' to be
			-- generated as output.
		do
			{TEXT_FORMATTER} Precursor (a_text)
			disable_has_breakable_slots
		end

	process_basic_text (t: BASIC_TEXT) is
			-- Process default basic text `t'.
		local
			tok: EDITOR_TOKEN_TEXT
		do
			create tok.make (t.image, tab_size_cell)
			last_line.append_token (tok)
		end

	process_string_text (t: STRING_TEXT) is
			-- Process default basic text `t'.
		local
			tok: EDITOR_TOKEN_STRING
			url: URL_STRING_TEXT
--			stone: URL_STONE
		do
			create tok.make (t.image, tab_size_cell)
			url ?= t
			if url /= Void then
--				create stone.make (url.link)
--				tok.set_pebble (stone)
			end
			last_line.append_token (tok)
		end

	process_comment_text (t: COMMENT_TEXT) is
			-- Process comment text. 
		local
			tok: EDITOR_TOKEN_COMMENT
			url: URL_STRING_TEXT
--			stone: URL_STONE
		do
			create tok.make (t.image, tab_size_cell)
			url ?= t
			if url /= Void then
--				create stone.make (url.link)
--				tok.set_pebble (stone)
			end
			last_line.append_token (tok)
		end

	process_quoted_text (t: QUOTED_TEXT) is
			-- Process the quoted `t' within a comment.
		local
			tok: EDITOR_TOKEN_COMMENT
		do			
			create tok.make (t.image, tab_size_cell)
			last_line.append_token (tok)
		end

	process_new_line (t: NEW_LINE_ITEM) is
			-- Process new line text `t'.
		do
			eol_reached := True
		end

	process_indentation (t: INDENT_TEXT) is
			-- Process indentation `t'.
		local
			tok: EDITOR_TOKEN_TABULATION
		do
			create tok.make (t.indent_depth, tab_size_cell)
			last_line.append_token (tok)
		end

	process_symbol_text (t: SYMBOL_TEXT) is
			-- Process symbol text.
		local
			tok: EDITOR_TOKEN_OPERATOR
		do
			create tok.make (t.image, tab_size_cell)
			last_line.append_token (tok)
		end

	process_keyword_text (t: KEYWORD_TEXT) is
			-- Process keyword text.
		local
			tok: EDITOR_TOKEN_KEYWORD
			pc: PRECURSOR_KEYWORD_TEXT
			stone: FEATURE_STONE
		do
			create tok.make (t.image, tab_size_cell)
			pc ?= t
			if pc /= Void then
				create stone.make (pc.e_feature)
				tok.set_pebble (stone)
			end
			last_line.append_token (tok)
		end

	process_cluster_name_text (t: CLUSTER_NAME_TEXT) is
			-- Process class name text `t'.
		local
			tok: EDITOR_TOKEN_CLUSTER
			stone: CLUSTER_STONE
		do
			create tok.make (t.image, tab_size_cell)
			create stone.make (t.cluster_i)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end;

	process_class_name_text (t: CLASS_NAME_TEXT) is
			-- Process class name text `t'.
		local
			tok: EDITOR_TOKEN_CLASS
			stone: CLASSI_STONE
			e_class: CLASS_C
			class_i: CLASS_I
		do
			create tok.make (t.image, tab_size_cell)
			class_i := t.class_i
			e_class := class_i.compiled_class
			if e_class /= Void then
				create {CLASSC_STONE} stone.make (e_class)
			else
				create {CLASSI_STONE} stone.make (class_i)
			end
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_feature_text (t: FEATURE_TEXT) is
		local
			tok: EDITOR_TOKEN_FEATURE
			stone: FEATURE_STONE
		do
			create tok.make (t.image, tab_size_cell)
			create stone.make (t.e_feature)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_breakpoint_index (t: BREAKPOINT_TEXT) is
		local
			tok: EDITOR_TOKEN_TEXT
			stone: BREAKABLE_STONE
		do
			create tok.make (t.image, tab_size_cell)
			create stone.make (t.e_feature, t.index)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_feature_name_text (t: FEATURE_NAME_TEXT) is
		local
			tok: EDITOR_TOKEN_FEATURE
			stone: FEATURE_NAME_STONE
		do
			create tok.make (t.image, tab_size_cell)
			create stone.make (t.image, t.e_class)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_exported_feature_name_text (t: EXPORTED_FEATURE_NAME_TEXT) is
		local
			tok: EDITOR_TOKEN_FEATURE
			stone: EXPORTED_FEATURE_NAME_STONE
		do
			create tok.make (t.image, tab_size_cell)
			create stone.make (t.image, t.e_class, t.exported_name)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_breakpoint (a_bp: BREAKPOINT_ITEM) is
			-- Process breakpoint.
		local
			tok: EDITOR_TOKEN_BREAKPOINT
			stone: BREAKABLE_STONE
		do
			create tok.make
			create stone.make (a_bp.e_feature, a_bp.index)
			tok.set_pebble (stone)
			last_line.breakpoint_token.set_pebble (stone)

			if not has_breakable_slots then
				enable_has_breakable_slots
			end
		end

	process_padded is
			-- Process padded item at start of non breakpoint line.
		do
			-- Do nothing... The text is now padded by default.
		end

	process_after_class (t: AFTER_CLASS) is
			-- Process after class text `t'.
		local
			comment_item: COMMENT_TEXT
			class_item: CLASS_NAME_TEXT
		do
			create comment_item.make (" -- class ")
			process_comment_text (comment_item)
			create class_item.make (t.e_class.name_in_upper, t.e_class.lace_class)
			process_class_name_text (class_item)
			process_new_line (create {NEW_LINE_ITEM}.make)
		end

	process_operator_text (t: OPERATOR_TEXT) is
			-- Process operator text.
		local
			tok: EDITOR_TOKEN_OPERATOR
			stone: FEATURE_STONE
		do
			create tok.make (t.image, tab_size_cell)
			create stone.make (t.e_feature)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_address_text (t: ADDRESS_TEXT) is
			-- Process address text.
		local
			tok: EDITOR_TOKEN_OBJECT
			stone: OBJECT_STONE
		do
			create tok.make (t.address, tab_size_cell)
			create stone.make (t.address, t.name, t.e_class)
			tok.set_pebble (stone)
			last_line.append_token (tok)

--				-- Add the address to the kept objects.
--			kept_objects.extend (t.address)
		end

	process_error_text (t: ERROR_TEXT) is
			-- Process error text.
		local
			tok: EDITOR_TOKEN_ERROR_CODE
			stone: ERROR_STONE
		do
			create tok.make (t.error_text, tab_size_cell)
			create stone.make (t.error)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_feature_error (t: FEATURE_ERROR_TEXT) is
			-- Process error text.
		local
			tok: EDITOR_TOKEN_FEATURE
			stone: FEATURE_ERROR_STONE
		do
			create tok.make (t.image, tab_size_cell)
			create stone.make (t.e_feature, t.position)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_cl_syntax (t: CL_SYNTAX_ITEM) is
			-- Process class syntax text.
		local
			tok: EDITOR_TOKEN_CLASS
			stone: CL_SYNTAX_STONE
		do
			create tok.make (t.error_text, tab_size_cell)
			create stone.make (t.syntax_error, t.e_class)
			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_ace_syntax (t: ACE_SYNTAX_ITEM) is
			-- Process Ace syntax text.
		local
			tok: EDITOR_TOKEN_STRING
			stone: ACE_SYNTAX_STONE
		do
			create tok.make (t.error_text, tab_size_cell)
			create stone.make (t.syntax_error)
--			tok.set_pebble (stone)
			last_line.append_token (tok)
		end

	process_assertion_tag_text (t: ASSERTION_TAG_TEXT) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_TAG
		do
			create tok.make (t.image, tab_size_cell)
			tok.set_indexing (False)
			last_line.append_token (tok)
		end

	process_indexing_tag_text (t: INDEXING_TAG_TEXT) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_TAG
		do
			create tok.make (t.image, tab_size_cell)
			tok.set_indexing (True)
			last_line.append_token (tok)
		end

	process_generic_text (t: GENERIC_TEXT) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_GENERIC
		do
			create tok.make (t.image, tab_size_cell)
			last_line.append_token (tok)
		end

	process_character_text (t: CHARACTER_TEXT) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_CHARACTER
		do
			create tok.make (t.image, tab_size_cell)
			last_line.append_token (tok)
		end

	process_local_text (t: LOCAL_TEXT) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_LOCAL
		do
			create tok.make (t.image, tab_size_cell)
			last_line.append_token (tok)
		end

	process_number_text (t: NUMBER_TEXT) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_NUMBER
		do
			create tok.make (t.image, tab_size_cell)
			last_line.append_token (tok)
		end

	process_reserved_word_text (t: RESERVED_WORD_TEXT) is
			-- Process string text `t'.
		local
			tok: EDITOR_TOKEN_RESERVED
		do
			create tok.make (t.image, tab_size_cell)
			last_line.append_token (tok)
		end

	process_filter_item (text: FILTER_ITEM) is
			-- Process information on syntax `text'.
		do
		end

	process_before_class (text: BEFORE_CLASS) is
			-- Process before class `t'.
		do
		end


feature -- Obsolete

	new_line is do end

	put_char (c: CHARACTER) is do end

	put_string (s: STRING) is
		local
			tok: EDITOR_TOKEN_TEXT
		do
			create tok.make (s, tab_size_cell)
			last_line.append_token (tok)
		end

feature -- Properties

	current_text: STRUCTURED_TEXT
			-- Current edited text. Void if no structured text is displayed.

feature {NONE} -- Initialisations and File status

	eol_reached: BOOLEAN

feature {NONE} -- Implementation

	tab_size_cell: CELL [INTEGER] is
		deferred
		end

end -- class STRUCTURED_TEXT_TRANSLATER

