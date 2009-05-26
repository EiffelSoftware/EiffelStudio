note
	description: "[
		Callback state for in the state of a xebra tag. @see {XP_HTML_CALLBACK_STATE}
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_TAG_CALLBACK_STATE

inherit
	XP_CALLBACK_STATE
		redefine
			make
		end

create
	make

feature -- Initialization

	make (a_parser_callback: XP_XML_PARSER_CALLBACKS)
		do
			Precursor (a_parser_callback)
		end

feature -- Access

	on_start_tag (a_namespace, a_prefix, a_local_part : STRING)
			-- <Precursor>
		local
			l_taglib: XTL_TAG_LIBRARY
			l_class_name: STRING
			l_tmp_tag: XP_TAG_ELEMENT
		do
			if not parser_callback.registry.contains_tag_lib (a_prefix) then
				parser_callback.set_state_html
				parser_callback.state.on_start_tag (a_namespace, a_prefix, a_local_part)
			else
				l_taglib := parser_callback.get_tag_lib (a_prefix)
				l_class_name := l_taglib.get_class_for_name (a_local_part)
				if l_class_name.is_empty then
					l_class_name := {XP_HTML_CALLBACK_STATE}.Html_tag_name
				end
				l_tmp_tag := l_taglib.create_tag (a_prefix, a_local_part, l_class_name, parser_callback.current_debug_information)
				parser_callback.tag_stack.item.put_subtag (l_tmp_tag)
				parser_callback.tag_stack.put (l_tmp_tag)
				if not l_taglib.contains (a_local_part) then
						parser_callback.error_manager.add_warning (create {XERROR_UNDEFINED_TAG}.make ([a_local_part]))
				end
			end
		end

	on_content (a_content: STRING)
			-- <Precursor>
		do
			parser_callback.set_state_html
			parser_callback.state.on_content (a_content)
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- <Precursor>
		do
			if a_local_part.is_equal (parser_callback.tag_stack.item.id) and a_prefix.is_equal (parser_callback.tag_stack.item.namespace) then
				parser_callback.tag_stack.remove
				parser_callback.set_state_html
			else
				parser_callback.error_manager.add_error (create {XERROR_PARSE}.make (["Unmatched: " + a_prefix + ":" + a_local_part]), False)
			end
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
			-- <Precursor>
		local
			taglib: XTL_TAG_LIBRARY
			l_value, l_local_part: STRING
		do
			l_value := a_value
			l_local_part := a_local_part
			taglib := parser_callback.get_tag_lib (parser_callback.tag_stack.item.namespace)
			if not taglib.contains (parser_callback.tag_stack.item.id) then
				l_value := "undefined tag: '" + parser_callback.tag_stack.item.id + "'"
				l_local_part := "text"
			elseif  taglib.argument_belongs_to_tag (l_local_part, parser_callback.tag_stack.item.id) then
				if
				l_value.starts_with ("%%=") and l_value.ends_with ("%%") then
					process_dynamic_tag_attribute (l_local_part, l_value)
				else
					if parser_callback.tag_stack.item.has_attribute (l_local_part) then
						parser_callback.error_manager.add_warning (create {XERROR_UNEXPECTED_ATTRIBUTE}.make (["<"+parser_callback.tag_stack.item.id + " " + l_local_part + "=%"" + l_value + "%">"]))
					else
						parser_callback.tag_stack.item.put_attribute (l_local_part, l_value)
					end
				end
			else
				parser_callback.error_manager.add_warning (create {XERROR_UNEXPECTED_ATTRIBUTE}.make (["<"+parser_callback.tag_stack.item.id + " " + l_local_part + "=%"" + l_value + "%">"  ]))
			end
		end

	on_start_tag_finish
			-- <Precursor>
		do
		end

	on_finish
			-- <Precursor>
		do
			parser_callback.set_state_html
			parser_callback.state.on_finish
		end

	process_dynamic_tag_attribute (local_part, value: STRING)
			-- Adds an attribute
		require
			local_part_is_valid: attached local_part and not local_part.is_empty
			value_attached: attached value
		local
			feature_name: STRING
		do
			feature_name := strip_off_dynamic_tags (value)
			parser_callback.tag_stack.item.put_attribute (local_part, "controller." + feature_name)
		end

end
