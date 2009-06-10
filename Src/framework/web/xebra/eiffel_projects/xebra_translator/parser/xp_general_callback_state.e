note
	description: "[
		{XP_GENERAL_CALLBACK_STATE}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_GENERAL_CALLBACK_STATE

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

feature -- Implementation

	on_start_tag (a_namespace, a_prefix, a_local_part : STRING)
			-- <Precursor>
		local
			l_taglib: XTL_TAG_LIBRARY
			l_class_name: STRING
			l_tmp_tag: XP_TAG_ELEMENT
		do
			if not parser_callback.registry.contains_tag_lib (a_prefix) then
				create l_tmp_tag.make (a_prefix, a_local_part, "XTAG_XEB_HTML_TAG", parser_callback.current_debug_information)
				parser_callback.tag_stack.item.put_subtag (l_tmp_tag)
				parser_callback.tag_stack.put (l_tmp_tag)
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
		local
			l_tmp_tag: XP_TAG_ELEMENT
		do
				create l_tmp_tag.make ("", "content", "XTAG_XEB_CONTENT_TAG", parser_callback.current_debug_information)
				l_tmp_tag.put_attribute ("text", create {XP_TAG_ARGUMENT}.make (a_content))
				parser_callback.tag_stack.item.put_subtag (l_tmp_tag)
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- <Precursor>
		do
			if a_local_part.is_equal (parser_callback.tag_stack.item.id) and a_prefix.is_equal (parser_callback.tag_stack.item.namespace) then
				parser_callback.tag_stack.remove
			else
				parser_callback.error_manager.add_error (create {XERROR_PARSE}.make (["Unmatched: " + a_prefix + ":" + a_local_part]), False)
				parser_callback.fail
			end
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
			-- <Precursor>
		local
			taglib: XTL_TAG_LIBRARY
			l_value: XP_TAG_ARGUMENT
			l_local_part: STRING
		do
			create l_value.make (a_value)
			l_local_part := a_local_part
			if not parser_callback.tag_stack.item.namespace.is_empty then
				if parser_callback.registry.contains_tag_lib (parser_callback.tag_stack.item.namespace) then
					taglib := parser_callback.get_tag_lib (parser_callback.tag_stack.item.namespace)
					if not taglib.contains (parser_callback.tag_stack.item.id) then
						parser_callback.tag_stack.item.put_attribute (l_local_part, l_value)
					elseif taglib.argument_belongs_to_tag (l_local_part, parser_callback.tag_stack.item.id) then
						if parser_callback.tag_stack.item.has_attribute (l_local_part) then
							parser_callback.error_manager.add_warning (create {XERROR_UNEXPECTED_ATTRIBUTE}.make (["<"+parser_callback.tag_stack.item.id + " " + l_local_part + "=%"" + l_value.value ("") + "%">"]))
							parser_callback.fail
						else
							parser_callback.tag_stack.item.put_attribute (l_local_part, l_value)
						end
					else
						parser_callback.error_manager.add_warning (create {XERROR_UNEXPECTED_ATTRIBUTE}.make (["<"+parser_callback.tag_stack.item.id + " " + l_local_part + "=%"" + l_value.value ("") + "%">"  ]))
						parser_callback.fail
					end
				else
					parser_callback.error_manager.add_warning (create {XERROR_UNDEFINED_NAMESPACE}.make (parser_callback.tag_stack.item.namespace))
					parser_callback.fail
				end

			else
				parser_callback.tag_stack.item.put_attribute (l_local_part, l_value)
			end

		end

	on_start_tag_finish
			-- <Precursor>
		do
		end

	on_finish
			-- <Precursor>
		do
		end

end
