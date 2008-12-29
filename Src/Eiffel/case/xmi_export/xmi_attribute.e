note
	description: "Information on an attribute of the system for XMI export"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_ATTRIBUTE

inherit
	XMI_FEATURE

create
	make

feature -- Actions

	code: STRING
			-- XMI representation of the attribute.
		local
			xmi_class: XMI_CLASS
		do
			Result := "<Foundation.Core.Attribute xmi.id = 'S."
			Result.append (xmi_id.out)
			Result.append ("'>%N%
				%                  <Foundation.Core.ModelElement.name>")
			Result.append (name)
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
				%                  <Foundation.Core.Feature.ownerScope xmi.value = 'instance'/>%N%
				%                  <Foundation.Core.StructuralFeature.multiplicity>1..1</Foundation.Core.StructuralFeature.multiplicity>%N%
				%                  <Foundation.Core.StructuralFeature.changeable xmi.value = 'none'/>%N%
				%                  <Foundation.Core.StructuralFeature.targetScope xmi.value = 'instance'/>%N%
				%                  <Foundation.Core.Attribute.initialValue>%N%
				%                     <Foundation.Data_Types.Expression>%N%
				%	                      <Foundation.Data_Types.Expression.language></Foundation.Data_Types.Expression.language>%N%
				%                      <Foundation.Data_Types.Expression.body></Foundation.Data_Types.Expression.body>%N%
				%                     </Foundation.Data_Types.Expression>%N%
				%                  </Foundation.Core.Attribute.initialValue>%N%
				%                  <Foundation.Core.StructuralFeature.type>%N")
			xmi_class ?= type
			if xmi_class /= Void then
				Result.append ("                        <Foundation.Core.Class xmi.idref = 'S.")
				Result.append (xmi_class.xmi_id.out)
				Result.append ("'/> <!-- ")
				Result.append (xmi_class.name)
				Result.append (" -->%N")
			else
				Result.append ("                        <Foundation.Core.DataType xmi.idref = 'G.")
				Result.append (type.xmi_id.out)
				Result.append ("'/> <!-- ")
				Result.append (type.name)
				Result.append (" -->%N")
			end
--			Result.append ("                        <Foundation.Core.Class xmi.idref = 'S.")
--			Result.append (type.xmi_id.out)
--			Result.append ("'/> <!-- ")
--			Result.append (type.name)
--			Result.append (" -->%N")
			Result.append ("                  </Foundation.Core.StructuralFeature.type>%N%
				%                </Foundation.Core.Attribute>%N")
		end

note
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

end -- class XMI_ATTRIBUTE
