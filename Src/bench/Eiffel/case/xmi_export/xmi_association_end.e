indexing
	description: "An object represent one end of an association between classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_ASSOCIATION_END
	
inherit
	XMI_FEATURE
		rename 
			make as make_parent
		end

create
	make

feature -- Initialization
	
	make (id: INTEGER; n: STRING; a_type: XMI_TYPE; a_ordered, a_multiple: BOOLEAN) is
			-- Initialization of `Current'.
		require
			type_not_void: a_type /= void
		do
			make_parent (id, n, a_type)
			is_ordered := a_ordered
			is_multiple := a_multiple
		end

feature -- Access

	is_ordered: BOOLEAN
			-- Is Current part of an ordered association?
			
	is_multiple: BOOLEAN
			-- Is Current singular or multiple association?

feature -- Actions

	code: STRING is
			-- XMI representation of the attribute.
		local
			xmi_class: XMI_CLASS
		do		
			Result := "<Foundation.Core.AssociationEnd xmi.id = 'G."
			Result.append (xmi_id.out)
			Result.append ("'>%N%
				%                  <Foundation.Core.ModelElement.name>")
			if name /= Void then
				Result.append (name)
			end
			Result.append ("</Foundation.Core.ModelElement.name>%N%
				%                  <Foundation.Core.ModelElement.visibility xmi.value = '")
			if is_public then
				Result.append ("public")
			elseif is_protected then
				Result.append ("protected")
			else 
				Result.append ("private")
			end
			Result.append ("'/>%N%
				%				   <Foundation.Core.AssociationEnd.isNavigable xmi.value = 'true'/>%N")
				if is_ordered then
					Result.append ("<Foundation.Core.AssociationEnd.isOrdered xmi.value = 'true'/>%N")
				else
					Result.append ("<Foundation.Core.AssociationEnd.isOrdered xmi.value = 'false'/>%N")
				end
			Result.append ("<Foundation.Core.AssociationEnd.aggregation xmi.value = 'none'/>%N")
				if is_multiple then
					Result.append ("<Foundation.Core.AssociationEnd.multiplicity>0..*</Foundation.Core.AssociationEnd.multiplicity>%N")
				else
					Result.append ("<Foundation.Core.AssociationEnd.multiplicity>1</Foundation.Core.AssociationEnd.multiplicity>%N")
				end
				Result.append ("<Foundation.Core.AssociationEnd.changeable xmi.value = 'none'/>%N%
				%				   <Foundation.Core.AssociationEnd.targetScope xmi.value = 'instance'/>%N%
				%				   <Foundation.Core.AssociationEnd.type>%N")
			xmi_class ?= type
			if xmi_class /= Void then
				Result.append ("<Foundation.Core.Class xmi.idref = 'S.")
			else
				Result.append ("<Foundation.Core.Class xmi.idref = 'G.")
			end
			Result.append (type.xmi_id.out)
			Result.append ("'/>%N%
				%				   </Foundation.Core.AssociationEnd.type>%N%
				%				   </Foundation.Core.AssociationEnd>%N")
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

end -- class XMI_ASSOCIATION_END
