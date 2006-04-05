indexing
	description: "Information on a type of the system for XMI export"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_TYPE

inherit
	XMI_ITEM
		redefine 
			is_equal
		end

create 
	make_type

feature --Initialization

	make_type (id: INTEGER; n: STRING) is
			-- Initialization of `Current'.
		do
			create associations.make
			xmi_id := id
			name := n
		end

feature -- Access

	name: STRING
			-- Name of the type represented by `Current'.

	associations: LINKED_LIST [XMI_ASSOCIATION]
			-- List of associations to which Current belongs

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does `other' have the same name as `Current'?
		do
			Result := name.is_equal (other.name)
		end

feature -- Status Setting

	add_association (a_association: XMI_ASSOCIATION) is
			-- Add 'a_association' to associations
		require
			a_association /= Void
		do
			if not associations.has (a_association) then
				associations.extend (a_association)
			end
		end

feature -- Action 

	code: STRING is
			-- XMI representation of the code.
		do
			Result := "<Foundation.Core.DataType xmi.id = 'G."
			Result.append (xmi_id.out)
			Result.append ("'> %N%
				%          <Foundation.Core.ModelElement.name>")
			Result.append (name)
			Result.append ("</Foundation.Core.ModelElement.name>%N%
				%          <Foundation.Core.ModelElement.visibility xmi.value = 'private'/>%N%
				%          <Foundation.Core.GeneralizableElement.isRoot xmi.value = 'false'/>%N%
				%          <Foundation.Core.GeneralizableElement.isLeaf xmi.value = 'false'/>%N%
				%          <Foundation.Core.GeneralizableElement.isAbstract xmi.value = 'false'/>%N%
				%        </Foundation.Core.DataType>%N")
		end

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

end -- class XMI_TYPE
