indexing
	description: "Class which encapsulates the information relative to a resource category."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCE_CATEGORY
 
creation
	make 

feature -- Initialization

	make(doc: XML_ELEMENT;struc: RESOURCE_STRUCTURE) is 
			-- Initialization
		local
			l1,l2: LINKED_LIST [XML_COMPOSITE]
			f1: XML_FIELD
			s1: XML_STRING
			resource: XML_RESOURCE
			category: RESOURCE_CATEGORY
			cursor,des_cursor: DS_BILINKED_LIST_CURSOR[XML_NODE]
			node,category_node: XML_ELEMENT
			s: STRING
			txt: XML_TEXT
		do
			!! Resources.make
			!! Categories.make
			!! description.make(20)
			cursor := doc.new_cursor
			from
				cursor.start
			until
				cursor.after
			loop
				node ?= cursor.item
				if node/=Void then
						if node.name.is_equal("HEAD") then
							des_cursor := node.new_cursor
							from
								des_cursor.start
							until
								des_cursor.after
							loop
								txt ?= des_cursor.item
								if txt /= Void then
									description.append(txt.string)
								end
								des_cursor.forth
							end		
						elseif node.name.is_equal("TEXT") then
							!! resource.make(node,struc)
							resources.extend(resource)
						elseif node.name.is_equal("TOPIC") then
							!! category.make(node,struc)
							categories.extend(category)
						end
				end
				cursor.forth
			end
		end

feature -- Implementation

	Description: STRING
		-- Description of Current.

	resources: LINKED_LIST [ XML_RESOURCE ]
		-- List of resources.

	categories: LINKED_LIST [ RESOURCE_CATEGORY ]
		-- List of Categories.

invariant
	not_void: resources /= Void and categories /= Void
	consistent: (not resources.empty implies categories.empty) and
				(not categories.empty implies resources.empty)  
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
end -- class RESOURCE_CATEGORY
