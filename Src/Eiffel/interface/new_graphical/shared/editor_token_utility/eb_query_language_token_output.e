indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_QUERY_LANGUAGE_TOKEN_OUTPUT

inherit
	EB_QUERY_LANGUAGE_PRINTER_OUTPUT

	EB_SHARED_WRITER

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize Current.
		do
			create_default_style
			create_default_class_style
			create_default_feature_style
			create {LINKED_LIST [EDITOR_TOKEN]} text_internal.make
		end

feature -- Access

	last_output: LIST [EDITOR_TOKEN] is
			-- Last output
		do
			Result := text_internal.twin
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_output_empty: BOOLEAN is
			-- Is output empty?
		do
			Result := text_internal.is_empty
		ensure then
			good_result: Result = text_internal.is_empty
		end

feature -- Basic operations

	initialize_last_output is
			-- Initialize `last_output' for new output process.
		do
			text_internal.wipe_out
		ensure then
			text_internal_reset: text_internal.is_empty
		end

feature -- Access/Style

	class_style: like default_class_style is
			-- Style to print class item
		do
			if class_style_internal = Void then
				Result := default_class_style
			else
				Result := class_style_internal
			end
		ensure
			result_attached: Result /= Void
		end

	feature_style: like default_feature_style is
			-- Style to print feature item
		do
			if feature_style_internal = Void then
				Result := default_feature_style
			else
				Result := feature_style_internal
			end
		ensure
			result_attached: Result /= Void
		end

	target_style: like default_style is
			-- Style to print target item
		do
			Result := default_style
		ensure
			result_attached: Result /= Void
		end

	group_style: like default_style is
			-- Style to print group item
		do
			Result := default_style
		ensure
			result_attached: Result /= Void
		end

	quantity_style: like default_style is
			-- Style to print quantity item
		do
			Result := default_style
		ensure
			result_attached: Result /= Void
		end

	line_style: like default_style is
			-- Style to print line item
		do
			Result := default_style
		ensure
			result_attached: Result /= Void
		end

	generic_style: like default_style is
			-- Style to print generic item
		do
			Result := default_style
		ensure
			result_attached: Result /= Void
		end

	local_style: like default_style is
			-- Style to print local item
		do
			Result := default_style
		ensure
			result_attached: Result /= Void
		end

	argument_style: like default_style is
			-- Style to print argument item
		do
			Result := default_style
		ensure
			result_attached: Result /= Void
		end

	assertion_style: like default_style is
			-- Style to print assertion item
		do
			Result := default_style
		ensure
			result_attached: Result /= Void
		end

	folder_style: EB_TEXT_EDITOR_TOKEN_STYLE
			-- Folder style
		do
			Result := default_folder_style
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	set_class_style (a_class_style: like class_style) is
			-- Set `class_style' with `a_class_style'.
			-- If `a_class_style' is Void, `default_class_style' will be returned when `class_style' is quired.
		do
			class_style_internal := a_class_style
		ensure
			class_style_set: (a_class_style /= Void implies (class_style = a_class_style)) and then
							 (a_class_style = Void) implies (class_style = default_class_style)
		end

	set_feature_style (a_feature_style: like feature_style) is
			-- Set `feature_style' with `a_feature_style'.
			-- If `a_feature_style' is Void, `default_feature_style' will be returned when `feature_style' is quired.
		do
			feature_style_internal := a_feature_style
		ensure
			feature_style_set: (a_feature_style /= Void implies (feature_style = a_feature_style)) and then
							 (a_feature_style = Void) implies (feature_style = default_feature_style)
		end


feature{EB_QUERY_LANGUAGE_PRINTER_VISITOR} -- Implementation

	process_separator (a_separator: STRING_32) is
			-- Put `a_separator' into the output.
		do
		end

	process_folder (a_name: STRING_32; a_path: STRING_32; a_group: CONF_GROUP) is
			-- Process folder.
			-- `a_name' is name of that folder, `a_path' is related path of that folder, such as "/abc/def".
			-- `a_group' is the group where that folder is located.
		local
			l_folder_style: like folder_style
		do
			l_folder_style := folder_style
			l_folder_style.set_folder_text (a_name, a_path, a_group)
			text_internal.append (l_folder_style.text)
		end

feature -- Process

	process_domain (a_item: QL_DOMAIN) is
			-- Process `a_item'.
		do
			-- Do nothing.
		end

	process_target (a_item: QL_TARGET) is
			-- Process `a_item'.
		local
			l_target_style: like target_style
		do
			l_target_style := target_style
			l_target_style.set_item (a_item)
			text_internal.append (l_target_style.text)
		end

	process_group (a_item: QL_GROUP) is
			-- Process `a_item'.
		local
			l_group_style: like group_style
		do
			l_group_style := group_style
			l_group_style.set_item (a_item)
			text_internal.append (l_group_style.text)
		end

	process_class (a_item: QL_CLASS) is
			-- Process `a_item'.
		local
			l_class_style: like class_style
		do
			l_class_style := class_style
			l_class_style.set_ql_class (a_item)
			text_internal.append (l_class_style.text)
		end

	process_feature (a_item: QL_FEATURE) is
			-- Process `a_item'.
		local
			l_feature_style: like feature_style
		do
			l_feature_style := feature_style
			l_feature_style.set_ql_feature (a_item)
			text_internal.append (l_feature_style.text)
		end

	process_real_feature (a_item: QL_REAL_FEATURE) is
			-- Process `a_item'.
		do
			process_feature (a_item)
		end

	process_invariant (a_item: QL_INVARIANT) is
			-- Process `a_item'.
		do
			process_feature (a_item)
		end

	process_quantity (a_item: QL_QUANTITY) is
			-- Process `a_item'.
		local
			l_quantity_style: like quantity_style
		do
			l_quantity_style := quantity_style
			l_quantity_style.set_item (a_item)
			text_internal.append (l_quantity_style.text)
		end

	process_line (a_item: QL_LINE) is
			-- Process `a_item'.
		local
			l_line_style: like line_style
		do
			l_line_style := line_style
			l_line_style.set_item (a_item)
			text_internal.append (l_line_style.text)
		end

	process_generic (a_item: QL_GENERIC) is
			-- Process `a_item'.
		local
			l_generic_style: like generic_style
		do
			l_generic_style := generic_style
			l_generic_style.set_item (a_item)
			text_internal.append (l_generic_style.text)
		end

	process_local (a_item: QL_LOCAL) is
			-- Process `a_item'.
		local
			l_local_style: like local_style
		do
			l_local_style := local_style
			l_local_style.set_item (a_item)
			text_internal.append (l_local_style.text)
		end

	process_argument (a_item: QL_ARGUMENT) is
			-- Process `a_item'.
		local
			l_argument_style: like argument_style
		do
			l_argument_style := argument_style
			l_argument_style.set_item (a_item)
			text_internal.append (l_argument_style.text)
		end

	process_assertion (a_item: QL_ASSERTION) is
			-- Process `a_item'.
		local
			l_assertion_style: like assertion_style
		do
			l_assertion_style := assertion_style
			l_assertion_style.set_item (a_item)
			text_internal.append (l_assertion_style.text)
		end

	process_dot_separator is
			-- Process dot separator, i.e, put a dot in output.
		do
			text_internal.extend (editor_token_for_dot)
		end

feature{NONE} -- Implementation

	class_style_internal: like class_style
			-- Internal storage for `class_style'

	feature_style_internal: like feature_style;
			-- Internal storage for `feature_style'

	default_class_style: EB_CLASS_EDITOR_TOKEN_STYLE
			-- Default `class_style'

	default_feature_style: EB_FEATURE_EDITOR_TOKEN_STYLE
			-- Default `feature_style'

	default_style: EB_SIMPLE_QL_NAME_STYLE
			-- Default style for query language items other than class and feature

	create_default_class_style is
			-- Create `default_class_style'.
		do
			create default_class_style
			default_class_style.enable_complete_generic_form
			default_class_style.disable_curly
		ensure
			default_class_style_attached: default_class_style /= Void
		end

	create_default_feature_style is
			-- Create `default_feature_style'
		do
			create default_feature_style
			default_feature_style.disable_class
			default_feature_style.disable_return_type
			default_feature_style.disable_argument
			default_feature_style.disable_comment
			default_feature_style.disable_value_for_constant
		ensure
			default_feature_style_attached: default_feature_style /= Void
		end

	create_default_style is
			-- Create `default_style'.
		do
			create default_style
			create default_folder_style
		ensure
			result_attached: default_style /= Void
		end

	editor_token_for_dot: EDITOR_TOKEN is
			-- Editor token reprensentation for dot "."
		local
			l_writer: like token_writer
		do
			l_writer := token_writer
			l_writer.new_line
			l_writer.process_symbol_text (ti_dot)
			Result := l_writer.last_line.content.first
		ensure
			reslt_attached: Result /= Void
		end

	text_internal: LIST [EDITOR_TOKEN]
		-- Text generated

	default_folder_style: like folder_style
			-- Default `folder_style'

invariant
	text_internal_attached: text_internal /= Void
	default_class_style_attached: default_class_style /= Void
	default_feature_style_attached: default_feature_style /= Void
	default_style_attached: default_style /= Void

end
