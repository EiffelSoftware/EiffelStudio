indexing

	description: 
		"Formats structured text.";
	date: "$Date$";
	revision: "$Revision $"

class TEXT_FORMATTER

feature -- Output

	process_text (text: STRUCTURED_TEXT) is
			-- Process structured text `text' to be
			-- generated as output.
		local
			linkable: LINKABLE [TEXT_ITEM]	
		do
			if text /= Void then
				from
					structured_text := text;
					linkable := text.first_element
				until
					linkable = Void
				loop
					linkable.item.append_to (Current)
					linkable := linkable.right;
				end;
			end
		end;

feature -- Properties

	structured_text: STRUCTURED_TEXT
			-- Text as displayed in Current.

feature {TEXT_ITEM} -- Implementation

	process_basic_text (t: BASIC_TEXT) is
			-- Process basic text `t'.
		do
		end;

	process_comment_text (text: COMMENT_TEXT) is
			-- Process comment text. 
		do
			process_basic_text (text)
		end;

	process_quoted_text (text: QUOTED_TEXT) is
			-- Process the quoted `text' within a comment.
		do
		end;

	process_class_name_text (t: CLASS_NAME_TEXT) is
			-- Process class name text `t'.
		do
			process_basic_text (t)
		end;

	process_feature_name_text (t: FEATURE_NAME_TEXT) is
			-- Process feature name text `t'.
		do
			process_basic_text (t)
		end;

	process_breakpoint (bp_item: BREAKPOINT_ITEM) is
			-- Process breakpoint.
		do
		end;

	process_padded is
			-- Process padded item at start of non breakpoint line.
		do
		end;

	process_new_line (t: NEW_LINE_ITEM) is
			-- Process new line text `t'.
		do
		end;

	process_indentation (t: INDENT_TEXT) is
			-- Process indentation `t'.
		do
		end;

	process_after_class (t: AFTER_CLASS) is
			-- Process after class text `t'.
		do
		end;

	process_before_class (t: BEFORE_CLASS) is
			-- Process before class `t'.
		do
		end;

	process_filter_item (t: FILTER_ITEM) is
			-- Process filter text `t'.
		do
		end;

	process_symbol_text (t: SYMBOL_TEXT) is
			-- Process symbol text.
		do
			process_basic_text (t)
		end;

	process_keyword_text (t: KEYWORD_TEXT) is
			-- Process keyword text.
		do
			process_basic_text (t)
		end;

	process_operator_text (t: OPERATOR_TEXT) is
			-- Process operator text.
		do
			process_basic_text (t)
		end;

	process_address_text (t: ADDRESS_TEXT) is
			-- Process address text.
		do
			process_basic_text (t)
		end;

	process_error_text (t: ERROR_TEXT) is
			-- Process error text.
		do
			process_basic_text (t)
		end;

	process_cl_syntax (t: CL_SYNTAX_ITEM) is
			-- Process class syntax text.
		do
			process_basic_text (t)
		end;

	process_ace_syntax (t: ACE_SYNTAX_ITEM) is
			-- Process Ace syntax text.
		do
			process_basic_text (t)
		end;

end -- class TEXT_FORMATTER
