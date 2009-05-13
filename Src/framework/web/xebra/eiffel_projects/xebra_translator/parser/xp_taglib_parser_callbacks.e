note
	description: "[
		Retrieves meta data from a tag library file (XML)
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_TAGLIB_PARSER_CALLBACKS

inherit
	XM_CALLBACKS
	ERROR_SHARED_MULTI_ERROR_MANAGER

create
	make

feature {NONE} -- Initialization

	make
			--
		do
			create tag_stack.make (10)
		ensure
			tag_stack_attached: attached tag_stack
		end

feature -- Access

	taglib: XTL_TAG_LIBRARY
			-- Taglib which is generated after parsing

feature {NONE} -- Access

	tag_stack: ARRAYED_STACK [XTL_TAG_LIB_ITEM]
			-- Stack to generate the parse tree

feature -- Document

	on_start
			-- <Precursor>
		do
		end

	on_finish
			-- <Precursor>
		do
		ensure then
			tag_stack_is_empty: tag_stack.is_empty
		end

	on_xml_declaration (a_version: STRING; an_encoding: STRING; a_standalone: BOOLEAN)
			-- <Precursor>
		do
		end

feature -- Errors

	on_error (a_message: STRING)
			-- <Precursor>
		do
			error_manager.add_error (create {XERROR_PARSE}.make ([a_message]), false)
		end

feature -- Meta

	on_processing_instruction (a_name: STRING; a_content: STRING)
			-- <Precursor>
		do
			error_manager.add_error (create {XERROR_PARSE}.make (["INSTRUCTIONS not yet implemented"]), False)
		end

	on_comment (a_content: STRING)
			-- <Precursor>
		do
		end

feature -- Tag

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- <Precursor>
		local
			l_tag: XTL_TAG_DESCRIPTION
			l_attr: XTL_TAG_DESCRIPTION_ATTRIBUTE
		do
			if a_local_part.is_equal (Tag_lib_tag_name) then
				create taglib.make
				tag_stack.put (taglib)
			elseif a_local_part.is_equal (Tag_tag_name)	then
				create l_tag.make
				--tag_stack.item.put (l_tag)
				tag_stack.put (l_tag)
			elseif a_local_part.is_equal (Tag_attribute_name) then
				create l_attr.make
				--tag_stack.item.put (l_attr)
				tag_stack.put (l_attr)
			end
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
			-- <Precursor>
		do
			tag_stack.item.set_attribute (a_local_part, a_value)
		end

	on_start_tag_finish
			-- <Precursor>
		do
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- <Precursor>
		local
			top_item: XTL_TAG_LIB_ITEM
		do
			top_item := tag_stack.item
			tag_stack.remove
			if tag_stack.count > 0 then
				tag_stack.item.put (top_item)
			end
		end

feature -- Content

	on_content (a_content: STRING)
			-- <Precursor>
		do
		end

feature -- Constants

	Tag_lib_tag_name: STRING = "taglib"
	Tag_tag_name: STRING = "tag"
	Tag_attribute_name: STRING = "attribute"

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
