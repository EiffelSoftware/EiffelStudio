note
	description: "[
					Microsoft Ribbon makrup XML callbacks when loading XML

				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_XML_CALLBACKS

inherit
	XML_CALLBACKS

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create last_node.make (50)
			create shared_singleton
			create constants
			create name_space.make_default
		end

feature {NONE}	-- Implementation

	last_node: ARRAYED_LIST [ER_XML_TREE_ELEMENT]
			-- Last node stack

	shared_singleton: ER_SHARED_TOOLS
			-- Shared singleton

	name_space: XML_NAMESPACE
			-- Default name space

feature -- Query

	xml_root: detachable ER_XML_TREE_ELEMENT
			-- XML root element

feature -- Document

	on_start
			-- <Precursor>
		do
			debug ("Ribbon-xml")
				print ("%N on_start")
			end
		end

	on_finish
			-- <Precursor>
		do
			debug ("Ribbon-xml")
				print ("%N on_finish")
			end
		end

	on_xml_declaration (a_version: READABLE_STRING_32; an_encoding: detachable READABLE_STRING_32; a_standalone: BOOLEAN)
			-- <Precursor>
		do
			debug ("Ribbon-xml")
				print ("%N on_xml_declaration")
			end
		end

feature -- Errors

	on_error (a_message: READABLE_STRING_32)
			-- <Precursor>
		do
			debug ("Ribbon-xml")
				print ("%N on_error")
			end
		end

feature -- Meta

	on_processing_instruction (a_name: READABLE_STRING_32; a_content: READABLE_STRING_32)
			-- <Precursor>
		do
			debug ("Ribbon-xml")
				print ("%N on_processing_instruction")
			end
		end

	on_comment (a_content: READABLE_STRING_32)
			-- <Precursor>
		do
			debug ("Ribbon-xml")
				print ("%N on_comment")
			end
		end

feature -- Tag

	on_start_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- <Precursor>
		local
			l_parent_node: detachable ER_XML_TREE_ELEMENT
			l_new_node: ER_XML_TREE_ELEMENT
		do
			debug ("Ribbon-xml")
				print ("%N on_start_tag " + a_local_part)
			end
			if last_node.count >= 1 then
				l_parent_node := last_node.last

				create l_new_node.make (l_parent_node, a_local_part, name_space)
				l_parent_node.put_last (l_new_node)

			else
				create l_new_node.make (void, a_local_part, name_space)
				xml_root := l_new_node
			end

			last_node.extend (l_new_node)
		end

	on_attribute (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32; a_value: READABLE_STRING_32)
			-- <Precursor>
		local
			l_tree_node: ER_XML_TREE_ELEMENT
		do
			debug ("Ribbon-xml")
				print ("%N on_attribute")
			end

			l_tree_node := last_node.last
			l_tree_node.add_attribute (a_local_part, name_space, a_value)

		end

	on_start_tag_finish
			-- <Precursor>
		do
			debug ("Ribbon-xml")
				print ("%N on_start_tag_finish")
			end
		end

	on_end_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- <Precursor>
		do
			debug ("Ribbon-xml")
				print ("%N on_end_tag")
			end
			remove_last_node

		end

feature -- Content

	on_content (a_content: READABLE_STRING_32)
			-- <Precursor>
		local
			l_tree_node: ER_XML_TREE_ELEMENT
		do
			debug ("Ribbon-xml")
				print ("%N on_content")
			end

			l_tree_node := last_node.last
			l_tree_node.set_content (a_content)
		end

feature {NONE} -- Implementation

	remove_last_node
			-- Remove last XML node
		do
			if last_node.count >= 1 then
				last_node.finish
				last_node.remove
			else
				check False end
			end
		end

	constants: ER_XML_CONSTANTS
			-- XML constants
;note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
