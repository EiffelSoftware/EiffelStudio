note
	description: "Acts as a callback for xml parser events to parse xebra scriptlets."
	date: "$Date$"
	revision: "$Revision$"

class
	XB_XML_PARSER_CALLBACKS

inherit
	XM_CALLBACKS

create
	make

feature {NONE} -- Initialization

	make
			-- Run.
		do
		end

feature -- Constants

	Eiffel_tag_keyword: STRING = "eiffel"

feature -- Access


	root: ROOT_SERVLET_ELEMENT

	cursor_buf: UC_STRING

feature -- Document

	on_start
			-- Called when parsing starts.
		do
			create root.make ("HELLO_WORLD","HELLO_WORLD_CONTROLLER")
			create cursor_buf.make_empty
		end

	on_finish
			-- Called when parsing finished.
		do
			cursor_buf.append ("%N%N -->DONE: " + cursor_buf)

		end

	on_xml_declaration (a_version: STRING; an_encoding: STRING; a_standalone: BOOLEAN)
			-- XML declaration.		
		do
		end

feature -- Errors

	on_error (a_message: STRING)
			-- Event producer detected an error.
		do
			cursor_buf.append (a_message)
		end

feature -- Meta

	on_processing_instruction (a_name: STRING; a_content: STRING)
			-- Processing instruction.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
				cursor_buf.append ("<?eiffel: " + a_name + "++" + a_content + "?>")
		end

	on_comment (a_content: STRING)
			-- Processing a comment.
			-- Atomic: single comment produces single event
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
				cursor_buf.append ("<!-- " + a_content + "-->")
		end

feature -- Tag

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- Start of start tag.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
			--	if a_local_part.starts_with (Eiffel_tag_keyword) then
			--		tag_handler.start_handling (a_local_part)
			--	end

				cursor_buf.append ("<" + a_local_part)
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
			-- Start of attribute.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
					cursor_buf.append (" " + a_local_part + "=%"" + a_value + "%"")
		end

	on_start_tag_finish
			-- End of start tag.
		do
				cursor_buf.append (">")

		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- End tag.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
			cursor_buf.append ("</" + a_local_part + ">")
		end


feature -- Content

	on_content (a_content: STRING)
			-- Text content.
			-- NOT atomic: two on_content events may follow each other
			-- without a markup event in between.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
			cursor_buf.append (a_content)
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
