indexing
	description: "Reads XML file to table of contents."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_TABLE_OF_CONTENTS_CONVERTER

inherit
	XM_FORMATTER
		rename
			make as make_formatter
		redefine
			process_element
		end
		
	TABLE_OF_CONTENTS_CONSTANTS

create
	make

feature -- Creation

	make is
			-- Create
		do
			create toc.make_empty
			create parent_stack.make (10)
			parent_stack.compare_objects
			parent_stack.extend (toc, 0)
			make_formatter
		end		

feature -- Access

	process_element (e: XM_ELEMENT) is
			-- Process `e'
		local
			l_node, l_parent: TABLE_OF_CONTENTS_NODE
			l_id: INTEGER
			l_url, 
			l_title,
			l_icon: STRING
		do			
			if not e.name.is_equal (root_string) then
				if e.parent_element /= Void then
					if e.parent_element.name.is_equal (root_string) then
						l_id := 0
					else
						l_id := e.parent_element.attribute_by_name (Id_string).value.to_integer
					end
					l_parent := parent_stack.item (l_id)
				end
				if e.has_attribute_by_name (Id_string) then
					l_id := e.attribute_by_name (Id_string).value.to_integer
				end			
				if e.has_attribute_by_name (Url_string) then
					l_url := e.attribute_by_name (Url_string).value
				end				
				if e.has_attribute_by_name (Title_string) then
					l_title := e.attribute_by_name (Title_string).value
				end				
				create l_node.make (l_id, l_parent, l_url, l_title)
				if e.has_attribute_by_name (Icon_string) then
					l_icon := e.attribute_by_name (Icon_string).value
					l_node.set_icon (l_icon)
				end
				l_parent.add_node (l_node)
				if not e.elements.is_empty then
						-- This is parent node so add it to stack for children to access
					parent_stack.extend (l_node, l_id)
				end	
			end			
			Precursor (e)
--			if parent_stack.has (l_node) then
--				parent_stack.remove
--			end
		end

	toc: TABLE_OF_CONTENTS
			-- Tree widget
			
	parent_stack: HASH_TABLE [TABLE_OF_CONTENTS_NODE, INTEGER];
			-- Parent stack

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class TABLE_OF_CONTENTS_CONVERTER
