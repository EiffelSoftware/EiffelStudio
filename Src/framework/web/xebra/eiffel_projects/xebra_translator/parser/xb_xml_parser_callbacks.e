note
	description: "[
		Generates a tree of XB_TAGs
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XB_XML_PARSER_CALLBACKS

inherit
	XM_CALLBACKS
	ERROR_SHARED_ERROR_MANAGER

create
	make

feature {NONE} -- Initialization

	make
			-- Create XB_XML_PARSER_CALLBACKS.
		do
			create root_tag.make ("html", HTML_TAG_NAME)
			create tag_stack.make (10)
			create html_buf.make_empty
			create {ARRAYED_LIST [STRING]} controller_calls.make (2)
			create {ARRAYED_LIST [STRING]} controller_calls_with_result.make (2)
		end

feature -- Constants

	Tag_keyword: STRING = "xeb"
		-- temp

	HTML_TAG_NAME: STRING = "XEB_HTML_TAG"

	READING_HTML: INTEGER = 0
	READING_TAG: INTEGER = 1

feature -- Access

	state: INTEGER
		-- 0 READING_HTML
		-- 1 READING_TAG

	html_buf: STRING
		-- Stores html text until a tag is created from it

	root_tag: TAG_ELEMENT
		-- Represents the root of the XB_TAG tree

	tag_stack: ARRAYED_STACK [TAG_ELEMENT]
		-- The stack is used to generate the tree

	taglib: TAG_LIBRARY
			-- Tag library which should be used

	controller_calls: LIST [STRING]
			-- All the calls on procedures which should be available for a servlet to be called

	controller_calls_with_result: LIST [STRING]
			-- All the calls on functions which should be available for a servlet to be called

	put_taglib (a_taglib: TAG_LIBRARY)
			-- Adds a taglib to the parser
		do
			taglib := a_taglib
		end

feature -- Document

	on_start
			-- Called when parsing starts.
		do
			tag_stack.wipe_out
			tag_stack.put (root_tag)
		ensure then
			only_root_on_stack: tag_stack.count = 1
		end

	on_finish
			-- Called when parsing finished.
		do
			if not html_buf.is_empty then
				create_html_tag_put
			end
		ensure then
			only_root_on_stack: tag_stack.count = 1
			buffer_is_empty: html_buf.is_empty
		end

	on_xml_declaration (a_version: STRING; an_encoding: STRING; a_standalone: BOOLEAN)
			-- XML declaration.		
		do
		--	error_manager.set_last_error (create {ERROR_PARSE}.make (["Xml declarations not yet supported"]), false)
		end

feature -- Errors

	on_error (a_message: STRING)
			-- Event producer detected an error.
		do
			error_manager.set_last_error (create {ERROR_PARSE}.make ([a_message]), false)
		end

feature -- Meta

	on_processing_instruction (a_name: STRING; a_content: STRING)
			-- Processing instruction.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
			error_manager.set_last_error (create {ERROR_PARSE}.make (["INSTRUCTIONS not yet implemented"]), False)
			--	html_buf.append ("<instruction " + a_name + "++" + a_content + "instruction>")
		end

	on_comment (a_content: STRING)
			-- Processing a comment.
			-- Atomic: single comment produces single event
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
				-- We don't need to output comments
			html_buf.append ("<!--" + a_content + "-->")
		end

feature -- Tag

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- Start of start tag.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		local
		--	l_namespace: STRING
			l_prefix: STRING
			l_local_part: STRING
			l_tmp_tag: TAG_ELEMENT
		do
			if attached a_prefix then
				if a_prefix.is_equal (Tag_keyword) then
					if state = READING_HTML then
						create_html_tag_put
					end
					state := READING_TAG
				else
					state := READING_HTML
				end

				l_prefix := a_prefix + ":"
			else
				l_prefix := ""
				state := READING_HTML
			end

			if attached a_local_part then
				l_local_part := a_local_part
			else
				l_local_part := ""
			end

			if state = READING_TAG then
				create l_tmp_tag.make (a_local_part, taglib.get_class_for_name (l_local_part.as_upper))
					-- TODO: Read tag class name from taglib file!
				tag_stack.item.put_subtag (l_tmp_tag)
				tag_stack.put (l_tmp_tag)

			elseif state = READING_HTML then
				html_buf.append ("<" + l_prefix +  l_local_part)
			end
		ensure then
			stack_bigger_or_html_tag: (tag_stack.count = old tag_stack.count) implies state = READING_HTML
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
			-- Start of attribute.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		local
			l_namespace: STRING
			l_prefix: STRING
			l_local_part: STRING
			l_value: STRING
		do
			if attached a_namespace then
				l_namespace := a_namespace
			else
				l_namespace := ""
			end
			if attached a_prefix then
				l_prefix := a_prefix
			else
				l_prefix := ""
			end
			if attached a_local_part then
				l_local_part := a_local_part
			else
				l_local_part := ""
			end
			if attached a_value then
				l_value := a_value
			else
				l_value := ""
			end

				-- all variables initialized

			if state = READING_TAG then
				if l_value.starts_with ("%%=") and l_value.ends_with ("%%") then
					process_dynamic_tag_attribute (l_local_part, l_value)
				elseif taglib.is_call_feature (tag_stack.item.id, l_local_part) then
					controller_calls.extend (l_value)
					tag_stack.item.put_attribute (l_local_part, l_value)
				elseif taglib.is_call_with_result_feature (tag_stack.item.id, l_local_part) then
					controller_calls_with_result.extend (l_value)
					tag_stack.item.put_attribute (l_local_part, l_value)
				else
					tag_stack.item.put_attribute (l_local_part, l_value)
				end
			elseif state = READING_HTML then
				if not l_prefix.is_empty then
					l_prefix := l_prefix + ":"
				end
				if l_value.starts_with ("%%=") and l_value.ends_with ("%%") then
					process_dynamic_html_attribute (l_local_part, l_value)
				else
					html_buf.append ( " " + l_prefix  + l_local_part + "=%"" +  l_value + "%"")
				end
			end
		ensure then
			stack_does_not_change: tag_stack.count = old tag_stack.count
		end

	on_start_tag_finish
			-- End of start tag.
		do
			if state = READING_HTML then
				html_buf.append (">")
			end
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- End tag.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		local
		--	l_namespace: STRING
			l_prefix: STRING
			l_local_part: STRING
		do
			if attached a_prefix then
				l_prefix := a_prefix
			else
				l_prefix := ""
			end

			if attached a_local_part then
				l_local_part := a_local_part
			else
				l_local_part := ""
			end

				-- All variables initialized

			if not l_prefix.is_equal (Tag_keyword) then
				if not l_prefix.is_empty then
					l_prefix := l_prefix + ":"
				end
				html_buf.append ("</" + l_prefix  + l_local_part + ">")
			else
				create_html_tag_put
				tag_stack.remove
			end
		end

feature -- Content

	on_content (a_content: STRING)
			-- Text content.
			-- NOT atomic: two on_content events may follow each other
			-- without a markup event in between.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
			--create_html_tag_with_text (a_content)
			html_buf.append (a_content)
		end

feature {NONE} -- Implementation

	create_html_tag_with_text (s: STRING)
			-- Creates a XB_TAG from s and adds it to top element on stack.
		local
			l_tag: TAG_ELEMENT
		do
			if not s.is_empty then
				create l_tag.make ("html", HTML_TAG_NAME)
				tag_stack.item.put_subtag (l_tag)
			end
		end

	create_html_tag_with_text_put (s: STRING)
			-- Creates a XB_TAG from s and adds it to top element on stack and then pushes it onto the stack.
		local
			l_tag: TAG_ELEMENT
		do
			if not s.is_empty then
				create l_tag.make ("html", HTML_TAG_NAME)
				l_tag.put_attribute ("text", s)
				l_tag.multiline_argument := True
				tag_stack.item.put_subtag (l_tag)
			end
		end

	create_html_tag_put
			-- Creates a XB_TAG from html_buf and adds it to top element on stack then pushes it onto the stack.
		do
			create_html_tag_with_text_put (html_buf.out)
				-- Don't use html_buf (instead of html_buf.out), since it will be wiped_out in the html_tag as well
			html_buf.wipe_out
		end

	process_dynamic_html_attribute (local_part, value: STRING)
			-- Extracts the name of the feature from the value
			-- Generates an html tag element and an output call
		local
			l_tag: TAG_ELEMENT
			feature_name: STRING
		do
			html_buf.append (" " + local_part + "=%"")
			create_html_tag_put
			create l_tag.make ("output", "XEB_OUTPUT_CALL_TAG")
			feature_name := value.substring (3, value.count-1)
			l_tag.put_dynamic_attribute ("value", feature_name)
			tag_stack.item.put_subtag (l_tag)
			controller_calls_with_result.extend (feature_name)
				-- Don't put it on the stack
			html_buf.append ("%"")
		end

	process_dynamic_tag_attribute (local_part, value: STRING)
		local
			feature_name: STRING
		do
			feature_name := value.substring (3, value.count - 1)
			controller_calls_with_result.extend (feature_name)
			tag_stack.item.put_dynamic_attribute (local_part, feature_name)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
