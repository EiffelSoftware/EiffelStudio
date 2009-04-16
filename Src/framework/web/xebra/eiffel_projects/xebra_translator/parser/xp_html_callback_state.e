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

create
	make

feature -- Initialization

feature -- Access

	on_start_tag (a_namespace, a_prefix, a_local_part: STRING)
		local
			l_prefix: STRING
		do
			if parser_callback.taglibs.has_key (a_prefix) then
				parser_callback.create_html_tag_put
				parser_callback.set_state_tag
				parser_callback.state.on_start_tag (a_namespace, a_prefix, a_local_part)
			else
				l_prefix := a_prefix
				if not l_prefix.is_empty then
					l_prefix := a_prefix + ":"
				end
				parser_callback.html_buf.append ("<" + l_prefix + a_local_part)
			end
		end

	on_content (a_content: STRING)
		do
			parser_callback.html_buf.append (a_content)
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
		local
			l_prefix: STRING
		do
			if parser_callback.taglibs.has_key (a_prefix) then
				parser_callback.create_html_tag_put
				parser_callback.set_state_tag
				parser_callback.state.on_end_tag (a_namespace, a_prefix, a_local_part)
			else
				l_prefix := a_prefix
				if not l_prefix.is_empty then
					l_prefix := l_prefix + ":"
				end
				parser_callback.html_buf.append ("</" + l_prefix  + a_local_part + ">")
			end
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
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
				parser_callback.process_dynamic_html_attribute (l_local_part, l_value)
			else
				parser_callback.html_buf.append ( " " + l_prefix  + l_local_part + "=%"" +  l_value + "%"")
			end
		end

	on_start_tag_finish
		do
			parser_callback.html_buf.append (">")
		end

end
