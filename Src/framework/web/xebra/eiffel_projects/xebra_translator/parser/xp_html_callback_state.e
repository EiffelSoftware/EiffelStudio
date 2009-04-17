note
	description: "[
		{XP_HTML_CALLBACK_STATE}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_HTML_CALLBACK_STATE
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
			buf := ""
		end

feature -- Access

	Output_tag_name: STRING = "XTAG_XEB_OUTPUT_CALL_TAG"
	Html_tag_name: STRING = "XTAG_XEB_HTML_TAG"

	buf: STRING

	on_start_tag (a_namespace, a_prefix, a_local_part: STRING)
			-- <Precursor>
		local
			l_prefix: STRING
		do
			if parser_callback.taglibs.has_key (a_prefix) then
				create_html_tag_put
				parser_callback.set_state_tag
				parser_callback.state.on_start_tag (a_namespace, a_prefix, a_local_part)
			else
				l_prefix := a_prefix
				if not l_prefix.is_empty then
					l_prefix := a_prefix + ":"
				end
				buf.append ("<" + l_prefix + a_local_part)
			end
		end

	on_content (a_content: STRING)
			-- <Precursor>
		do
			buf.append (a_content)
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- <Precursor>
		local
			l_prefix: STRING
		do
			if parser_callback.taglibs.has_key (a_prefix) then
				create_html_tag_put
				parser_callback.set_state_tag
				parser_callback.state.on_end_tag (a_namespace, a_prefix, a_local_part)
			else
				l_prefix := a_prefix
				if not l_prefix.is_empty then
					l_prefix := l_prefix + ":"
				end
				buf.append ("</" + l_prefix  + a_local_part + ">")
			end
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
			-- <Precursor>
		local
			l_prefix, l_value, l_local_part: STRING
		do
			l_prefix := a_prefix
			l_value := a_value
			l_local_part := a_local_part
			if not l_prefix.is_empty then
				l_prefix := l_prefix + ":"
			end
			if l_value.starts_with ("%%=") and l_value.ends_with ("%%") then
				process_dynamic_html_attribute (l_local_part, l_value)
			else
				buf.append ( " " + l_prefix  + l_local_part + "=%"" +  l_value + "%"")
			end
		end

	on_start_tag_finish
			-- <Precursor>
		do
			buf.append (">")
		end

	on_finish
			-- <Precursor>
		do
			if not buf.is_empty then
				create_html_tag_put
			end
		ensure then
			buffer_is_empty: buf.is_empty
		end

	process_dynamic_html_attribute (local_part, value: STRING)
			-- Extracts the name of the feature from the value
			-- Generates an html tag element and an output call
		require
			local_part_is_valid: not local_part.is_empty
		local
			l_tag: XP_TAG_ELEMENT
			feature_name: STRING
		do
			buf.append (" " + local_part + "=%"")
			create_html_tag_put
			create l_tag.make ("xeb", "output", Output_tag_name, parser_callback.current_debug_information)
			feature_name := strip_off_dynamic_tags (value)
			l_tag.put_attribute ("value", feature_name)
			parser_callback.tag_stack.item.put_subtag (l_tag)
				-- Don't put it on the stack
			buf.append ("%"")
		ensure
			tag_stack_didnt_change: parser_callback.tag_stack.count = old parser_callback.tag_stack.count
		end

	create_html_tag_put
			-- Creates a XB_TAG from html_buf and adds it to top element on stack then pushes it onto the stack.
		do
			create_html_tag_with_text_put (buf.out)
				-- Don't use buf (instead of buf.out), since it will be wiped_out in the html_tag as well
			buf.wipe_out
		ensure
			buf_is_empty: buf.is_empty
			tag_stack_didnt_change: parser_callback.tag_stack.count = old parser_callback.tag_stack.count
		end

	create_html_tag_with_text (s: STRING)
			-- Creates a XB_TAG from `s' and adds it to top element on stack.
		require
			s_is_valid: not s.is_empty
		local
			l_tag: XP_TAG_ELEMENT
		do
			if not s.is_empty then
				create l_tag.make ("xeb", "html", Html_tag_name, parser_callback.current_debug_information)
				parser_callback.tag_stack.item.put_subtag (l_tag)
			end
		end

	create_html_tag_with_text_put (s: STRING)
			-- Creates a XB_TAG from s and adds it to top element on stack and then pushes it onto the stack.
		local
			l_tag: XP_TAG_ELEMENT
		do
			if not s.is_empty then
				create l_tag.make ("xeb", "html", Html_tag_name, parser_callback.current_debug_information)
				l_tag.put_attribute ("text", s)
				l_tag.multiline_argument := True
				parser_callback.tag_stack.item.put_subtag (l_tag)
			end
		end

end
