indexing
	description: "Formats structured text."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEXT_FORMATTER

feature -- Output

	process_text (text: STRUCTURED_TEXT) is
			-- Process structured text `text' to be
			-- generated as output.
		do
			if text /= Void then
				from
					text.start
				until
					text.after
				loop
					(text.item).append_to (Current)
					text.forth
				end;
			end
		end;

feature {TEXT_ITEM} -- Implementation

	process_basic_text (text: BASIC_TEXT) is
			-- Process default basic text `t'.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_character_text (text: CHARACTER_TEXT) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_generic_text (text: GENERIC_TEXT) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_indexing_tag_text (text: INDEXING_TAG_TEXT) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_local_text (text: LOCAL_TEXT) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_number_text (text: NUMBER_TEXT) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_quoted_text (text: QUOTED_TEXT) is
			-- Process the quoted `text' within a comment.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_assertion_tag_text (text: ASSERTION_TAG_TEXT) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_string_text (text: STRING_TEXT) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_reserved_word_text (text: RESERVED_WORD_TEXT) is
			-- Process string text `t'.
		require
			text_not_void: text /= Void
		do
			process_basic_text (text)
		end

	process_comment_text (text: COMMENT_TEXT) is
			-- Process comment text. 
		require
			text_not_void: text /= Void
		deferred
		end;

	process_difference_text_item (text: DIFFERENCE_TEXT_ITEM) is
				-- Process difference text text.
		require
			text_not_void: text /= Void
		do
		end;

	process_class_name_text (text: CLASS_NAME_TEXT) is
			-- Process class name text `text'.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_cluster_name_text (text: CLUSTER_NAME_TEXT) is
			-- Process cluster name text `text'.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_feature_name_text (text: FEATURE_NAME_TEXT) is
			-- Process feature name text `text'.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_exported_feature_name_text (text: EXPORTED_FEATURE_NAME_TEXT) is
			-- Process exported feature name text `text'.
		require
			text_not_void: text /= Void
		deferred
		end

	process_feature_error (text: FEATURE_ERROR_TEXT) is
	            -- Process error feature text.
        	do
        		process_feature_text (text)
		end

	process_feature_text (text: FEATURE_TEXT) is
			-- Process feature text `text'.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_breakpoint_index (text: BREAKPOINT_TEXT) is
			-- Process feature text `text'.
		require
			text_not_void: text /= Void
		deferred
		end

	process_breakpoint (a_bp: BREAKPOINT_ITEM) is
			-- Process breakpoint.
		deferred
		end;

	process_padded is
			-- Process padded item at start of non breakpoint line.
		deferred
		end;

	process_new_line (text: NEW_LINE_ITEM) is
			-- Process new line text `t'.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_indentation (text: INDENT_TEXT) is
			-- Process indentation `t'.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_after_class (text: AFTER_CLASS) is
			-- Process after class text `t'.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_before_class (text: BEFORE_CLASS) is
			-- Process before class `t'.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_filter_item (text: FILTER_ITEM) is
			-- Process filter text `t'.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_symbol_text (text: SYMBOL_TEXT) is
			-- Process symbol text.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_keyword_text (text: KEYWORD_TEXT) is
			-- Process keyword text.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_operator_text (text: OPERATOR_TEXT) is
			-- Process operator text.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_address_text (text: ADDRESS_TEXT) is
			-- Process address text.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_error_text (text: ERROR_TEXT) is
			-- Process error text.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_cl_syntax (text: CL_SYNTAX_ITEM) is
			-- Process class syntax text.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_ace_syntax (text: ACE_SYNTAX_ITEM) is
			-- Process Ace syntax text.
		require
			text_not_void: text /= Void
		deferred
		end;

	process_column_text (text: COLUMN_TEXT) is
			-- Process `text'.
		do
		end;

	process_call_stack_item (text: CALL_STACK_ITEM) is
			-- Process the current callstack text.
		do
		end;

	process_menu_text (text: MENU_TEXT) is
			-- Process menu item. This is only useful for generation to
			-- formats that support hyperlinking.
		do
		end

	process_class_menu_text (text: CLASS_MENU_TEXT) is
			-- Process class menu item. This is only useful for generation to
			-- formats that support hyperlinking.
		do
			process_menu_text (text)
		end

end -- class TEXT_FORMATTER
