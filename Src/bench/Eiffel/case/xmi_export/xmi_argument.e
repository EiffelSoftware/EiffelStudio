indexing
	description: "Information on an argument of a feature in the system for XMI export"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_ARGUMENT

inherit
	XMI_FEATURE

create
	make

feature -- Actions

	code: STRING is
			-- XMI representation of the argument.
		local
			xmi_class: XMI_CLASS
		do
			Result := "<Foundation.Core.Parameter xmi.id = 'G."
			Result.append (xmi_id.out)
			Result.append ("'>%N%
				%                      <Foundation.Core.ModelElement.name>")
			Result.append (name)
			Result.append ("</Foundation.Core.ModelElement.name>%N%
				%                      <Foundation.Core.ModelElement.visibility xmi.value = 'private'/>%N%
				%                      <Foundation.Core.Parameter.defaultValue>%N%
				%                         <Foundation.Data_Types.Expression>%N%
				%                          <Foundation.Data_Types.Expression.language></Foundation.Data_Types.Expression.language>%N%
				%                          <Foundation.Data_Types.Expression.body></Foundation.Data_Types.Expression.body>%N%
				%                         </Foundation.Data_Types.Expression>%N%
				%                      </Foundation.Core.Parameter.defaultValue>%N%
				%                      <Foundation.Core.Parameter.kind xmi.value = 'inout'/>%N%
				%                      <Foundation.Core.Parameter.type>%N")
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

			Result.append ("                      </Foundation.Core.Parameter.type>%N%
				%                    </Foundation.Core.Parameter>%N")
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

end -- class XMI_ARGUMENT
