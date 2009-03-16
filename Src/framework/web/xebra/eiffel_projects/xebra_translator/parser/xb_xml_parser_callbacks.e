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
		--	create {LINKED_LIST [OUTPUT_ELEMENT]}elements.make
			create root_tag.make
			root_tag.set_name ("ROOT_TAG")
			create tag_stack.make (1)
		--	create tag_buf.make
			create html_buf.make_empty
		end

feature -- Constants

	Tag_keyword: STRING = "xeb"
		-- temp

feature -- Access

	state: INTEGER
		-- 0 reading html
		-- 1 reading a tag

	html_buf: STRING
		-- Stores html text until a tag is created from it

	root_tag : XB_TAG
		-- Represents the root of the XB_TAG tree

	tag_stack: ARRAYED_STACK [XB_TAG]
		-- The stack is used to generate the tree



feature -- Document

	on_start
			-- Called when parsing starts.
		do
			tag_stack.put (root_tag)
		ensure then
			only_root_on_stack: tag_stack.count = 1
		end

	on_finish
			-- Called when parsing finished.
		do

		ensure then
		--	only_root_on_stack: tag_stack.count = 1
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
		--	if state = 0 then
		--		html_buf.append ("<!-- " + a_content + "-->")
		--	end
		end

feature -- Tag

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- Start of start tag.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		local
		--	l_namespace: STRING
			l_prefix: STRING
			l_local_part: STRING
			l_tmp_tag: XB_TAG
		do
			if attached a_prefix then
				if a_prefix.is_equal (Tag_keyword) then
					state := 1
				else
					state := 0
				end

				l_prefix := a_prefix + ":"
			else
				l_prefix := ""
				state := 0
			end

			if attached a_local_part then
				l_local_part := a_local_part
			else
				l_local_part := ""
			end

			if state = 1 then
				create l_tmp_tag.make
				tag_stack.item.put_subtag (l_tmp_tag)
				tag_stack.put (l_tmp_tag)
				tag_stack.item.set_name (l_prefix  + l_local_part)
			elseif state = 0 then
				html_buf := ""
				html_buf.append ("<" + l_prefix +  l_local_part)
			end
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

			if state = 1 then
				tag_stack.item.put_attribute (l_namespace, l_prefix, l_local_part, l_value)

			elseif state = 0 then
				if not l_prefix.is_empty then
					l_prefix := l_prefix + ":"
				end
				html_buf.append ( " " + l_prefix  + l_local_part + "=%"" +  l_value + "%"")
			end
		end

	on_start_tag_finish
			-- End of start tag.
		do
			if state = 1 then
			elseif state = 0 then
				html_buf.append (">")
				create_html_tag_put
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


			tag_stack.remove


			if not l_prefix.is_equal (Tag_keyword) then
				if not l_prefix.is_empty then
					l_prefix := l_prefix + ":"
				end
				create_html_tag_with_text ("</" + l_prefix  + l_local_part + ">")
			end
		end

feature -- Content

	on_content (a_content: STRING)
			-- Text content.
			-- NOT atomic: two on_content events may follow each other
			-- without a markup event in between.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
			create_html_tag_with_text (a_content)
		end

feature {NONE} -- Implementation

	create_html_tag_with_text (s: STRING)
			-- Creates a XB_TAG from s and adds it to top element on stack.
		local
			l_tag: XB_TAG
		do
			if not s.is_empty then
				create l_tag.make
				l_tag.set_name ("HTML")
				l_tag.put_attribute ("", "","code", s.twin)
				tag_stack.item.put_subtag (l_tag)
			end
		end

	create_html_tag_with_text_put (s: STRING)
			-- Creates a XB_TAG from s and adds it to top element on stack.
		local
			l_tag: XB_TAG
		do
			if not s.is_empty then
				create l_tag.make
				l_tag.set_name ("HTML")
				l_tag.put_attribute ("", "","code", s.twin)
				tag_stack.item.put_subtag (l_tag)
				tag_stack.put (l_tag)
			end
		end

	create_html_tag_put
			-- Creates a XB_TAG from html_buf and adds it to top element on stack.
		do
			create_html_tag_with_text_put (html_buf)
			html_buf.wipe_out
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
