indexing
	description: "Class which encapsulates the information for one resource."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_UNIT_RESOURCE

creation
	make

feature -- Initialization
	
	make(root_resource: XML_NODE; r: XML_STRUCTURE[XML_UNIT_RESOURCE]) is
			-- initialization
		require
			not_void: root_resource /= Void and r /= Void
		local
			cursor: DS_BILINKED_LIST_CURSOR[XML_NODE]
			node: XML_ELEMENT
			txt: XML_TEXT
		do
			!! name.make(20)
			structure ?= r
			cursor := root_resource.new_cursor
			from
				cursor.start
			until
				cursor.after
			loop
				txt ?= cursor.item
				if txt /= Void then
					name.append(txt.string)
				else
					node ?= cursor.item
					if node /= Void then
						process_unit_specific(node)
					end
				end
				cursor.forth
			end
		end

	process_unit_specific(node: XML_ELEMENT) is
			-- Process the content of the node.
			-- Should be redefine in heirs.
		require
			node_exists: node /= Void
		do
		ensure
			value_exists: value /= Void
		end

feature -- Implementation

	structure: XML_STRUCTURE[XML_UNIT_RESOURCE]
		-- Structure of the resources.

	name: STRING
		-- Name of the variable.

	value: RESOURCE
		-- Value of the variable.

invariant
	XML_UNIT_RESOURCE_not_void: structure /= Void and name/=Void and value/=Void
	XML_UNIT_RESOURCE_consistency: not name.empty
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
end -- class XML_UNIT_RESOURCE
