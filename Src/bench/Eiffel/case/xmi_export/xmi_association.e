indexing
	description: "Information on an association of the system for XMI export"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class
	XMI_ASSOCIATION
	
inherit
	XMI_FEATURE
		rename
			make as make_parent
		end

create
	make

feature -- Initialization

	make (id: INTEGER; n: STRING; supplier, client: XMI_TYPE; a_ordered, a_multiple: BOOLEAN) is
			-- Initialization of `Current'.
		require
			supplier_not_void: supplier /= Void
			client_not_void: client /= Void
		do
			make_parent (id, n, supplier)
			create supplier_end.make (id + 1, n, supplier, a_ordered, a_multiple)
			create client_end.make (id + 2, "", client, a_ordered, a_multiple)
			supplier_role := supplier.xmi_id
			client_role := client.xmi_id
		ensure
			has_supplier_end: supplier_end /= Void
			has_client_end: client_end /= Void
		end	

feature -- Access

	client_end: XMI_ASSOCIATION_END
			-- Identification of the client role end
		
	supplier_end: XMI_ASSOCIATION_END
			-- Identification of the supplier role end

	client_role: INTEGER
			-- The class id representing the client end of the association
			
	supplier_role: INTEGER
			-- The class id representing the supplier end of the association

feature -- Query

	has_type (a_xmi_type_id: INTEGER): BOOLEAN is
			-- Does this association contain 'a_xmi_type_id'?
		do
			Result := (a_xmi_type_id = client_role) or (a_xmi_type_id = supplier_role)
		end

	end_id_from_xmi_type (a_xmi_type_id: INTEGER): INTEGER is
			-- Get the association end identifier of the type identified by 'a_xmi_type_id'
		require
			contains_type: has_type (a_xmi_type_id)
		do
			if client_role = a_xmi_type_id then
				Result := client_end.xmi_id
			elseif supplier_role = a_xmi_type_id then
				Result := supplier_end.xmi_id
			end
		ensure
			Result = client_end.xmi_id or Result = supplier_end.xmi_id
		end

feature -- Actions

	code: STRING is
			-- XMI representation of the attribute.
		do
			Result := "<Foundation.Core.Association xmi.id = 'G."
			Result.append (xmi_id.out)
			Result.append ("'>%N%
				%          	<Foundation.Core.ModelElement.name>")
			Result.append ("</Foundation.Core.ModelElement.name>%N%
				%          	<Foundation.Core.ModelElement.visibility xmi.value = '")
			if is_public then
				Result.append ("public")
			elseif is_protected then
				Result.append ("protected")
			else 
				Result.append ("private")
			end
			Result.append ("'/>%N%
				%          <Foundation.Core.GeneralizableElement.isRoot xmi.value = 'false'/>%N%
				%          <Foundation.Core.GeneralizableElement.isLeaf xmi.value = 'false'/>%N%
				%          <Foundation.Core.GeneralizableElement.isAbstract xmi.value = 'false'/>%N%
				%          <Foundation.Core.Association.connection>%N")
			Result.append (supplier_end.code)
			Result.append (client_end.code)
			Result.append ("</Foundation.Core.Association.connection>%N%
				%			</Foundation.Core.Association>")
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class XMI_ASSOCIATION
