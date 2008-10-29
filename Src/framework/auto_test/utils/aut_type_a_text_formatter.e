indexing
	description: "Text formatter for {TYPE_A} objects"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_TYPE_A_TEXT_FORMATTER

inherit
	TEXT_FORMATTER

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize.
		do
			create type_name.make (64)
		end

feature -- Access

	type_name: STRING
			-- Result of printing			

feature -- Basic operation

	wipe_type_name is
			-- Wipe out `type_name'.
		do
			type_name.wipe_out
		ensure
			type_name_is_empty: type_name.is_empty
		end

feature -- Process

	process_comment_text (text: STRING_GENERAL; url: STRING_GENERAL) is
			-- Process comment text.
			-- `url' is possible url, which can be void if none.
		do
		end

	process_class_name_text (text: STRING_GENERAL; a_class: CLASS_I; a_quote: BOOLEAN) is
			-- Process class name of `a_class'.
		do
			type_name.append (text.as_string_8)
		end

	process_cluster_name_text (text: STRING_GENERAL; a_cluster: CONF_GROUP; a_quote: BOOLEAN) is
			-- Process cluster name of `a_cluster'.
		do
		end

	process_target_name_text (text: STRING_GENERAL; a_target: CONF_TARGET) is
			-- Process target name text `text'.
		do
		end

	process_feature_name_text (text: STRING_GENERAL; a_class: CLASS_C) is
			-- Process feature name text `text'.
		do
		end

	process_feature_text (text: STRING_GENERAL; a_feature: E_FEATURE; a_quote: BOOLEAN) is
			-- Process feature text `text'.
		do
		end

	process_breakpoint_index (a_feature: E_FEATURE; a_index: INTEGER; a_cond: BOOLEAN) is
			-- Process breakpoint index `a_index'.
		do
		end

	process_breakpoint (a_feature: E_FEATURE; a_index: INTEGER) is
			-- Process breakpoint.
		do
		end

	process_padded is
			-- Process padded item at start of non breakpoint line.
		do
		end

	process_new_line is
			-- Process new line.
		do
		end

	process_indentation (a_indent_depth: INTEGER) is
			-- Process indentation `t'.
		do
		end

	process_after_class (a_class: CLASS_C) is
			-- Process after class `a_class'.
		do
		end

	process_before_class (a_class: CLASS_C) is
			-- Process before class `a_class'.
		do
		end

	process_filter_item (text: STRING_GENERAL; is_before: BOOLEAN) is
			-- Process filter text `text'.
		do
		end

	process_symbol_text (text: STRING_GENERAL) is
			-- Process symbol text.
		do
			type_name.append (text.as_string_8)
		end

	process_keyword_text (text: STRING_GENERAL; a_feature: E_FEATURE) is
			-- Process keyword text.
			-- `a_feature' is possible feature.
		do
		end

	process_operator_text (text: STRING_GENERAL; a_feature: E_FEATURE) is
			-- Process operator text.
			-- `a_feature' can be void.
		do
		end

	process_address_text (a_address, a_name: STRING_GENERAL; a_class: CLASS_C) is
			-- Process address text.
		do
		end

	process_error_text (text: STRING_GENERAL; a_error: ERROR) is
			-- Process error text.
		do
		end

	process_cl_syntax (text: STRING_GENERAL; a_syntax_message: ERROR; a_class: CLASS_C) is
			-- Process class syntax text.
		do
		end

	process_basic_text (text: STRING_GENERAL) is
			-- Process default basic text `t'.
		do
		end

	process_quoted_text (text: STRING_GENERAL) is
			-- Process the quoted `text' within a comment.
		do
		end

invariant
	type_name_attached: type_name /= Void

end
