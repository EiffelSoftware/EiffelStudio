note
	description: "[
		{XP_TAG_CALLBACK_STATE}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_TAG_CALLBACK_STATE

inherit
	XP_CALLBACK_STATE

create
	make

feature -- Initialization

feature -- Access

	on_start_tag (a_namespace, a_prefix, l_local_part : STRING)
		local
			l_taglib: XTL_TAG_LIBRARY
			l_class_name: STRING
			l_tmp_tag: XP_TAG_ELEMENT
		do
			if not parser_callback.taglibs.has_key (a_prefix) then
				parser_callback.set_state_html
				parser_callback.state.on_start_tag (a_namespace, a_prefix, l_local_part)
			else
				l_taglib := parser_callback.get_tag_lib (a_prefix)
				l_class_name := l_taglib.get_class_for_name (l_local_part)
				if l_class_name.is_empty then
					l_class_name := parser_callback.Html_tag_name
				end
				create l_tmp_tag.make (a_prefix, l_local_part, l_class_name, parser_callback.current_debug_information)
				parser_callback.tag_stack.item.put_subtag (l_tmp_tag)
				parser_callback.tag_stack.put (l_tmp_tag)
				if not l_taglib.contains (l_local_part) then
						parser_callback.error_manager.add_warning (create {XERROR_UNDEFINED_TAG}.make ([l_local_part]))
				end
			end
		end

	on_content (a_content: STRING)
		do
			parser_callback.set_state_html
			parser_callback.state.on_content (a_content)
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
		do
--			if a_prefix.is_empty or not taglibs.has_key (a_prefix) then
--				if not l_prefix.is_empty then
--					l_prefix := l_prefix + ":"
--				end
--				html_buf.append ("</" + l_prefix  + l_local_part + ">")
--				create_html_tag_put
--			else
--				tag_stack.remove
--			end
			parser_callback.tag_stack.remove
			parser_callback.set_state_html
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
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
					parser_callback.process_dynamic_tag_attribute (l_local_part, l_value)
				else
					if parser_callback.tag_stack.item.has_attribute (l_local_part) then
						parser_callback.error_manager.add_warning (create {XERROR_UNEXPECTED_ATTRIBUTE}.make (["<"+parser_callback.tag_stack.item.id + " " + l_local_part + "=%"" + l_value + "%">"  ]))
					else
						parser_callback.tag_stack.item.put_attribute (l_local_part, l_value)
					end
				end
			else
				parser_callback.error_manager.add_warning (create {XERROR_UNEXPECTED_ATTRIBUTE}.make (["<"+parser_callback.tag_stack.item.id + " " + l_local_part + "=%"" + l_value + "%">"  ]))
			end
		end

	on_start_tag_finish
		do
		end

end
