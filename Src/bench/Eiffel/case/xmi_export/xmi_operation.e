indexing
	description: "Information on an operation of the system for XMI export"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_OPERATION

inherit
	XMI_FEATURE

create
	make_op

feature -- Initialization

	make_op (id: INTEGER; id_r: INTEGER; n: STRING; t: XMI_TYPE) is
			-- Initialization of `Current'.
		do
			xmi_id := id
			id_return := id_r
			type := t
			name := n
			create arguments.make
		end

feature -- Access
	
	arguments: LINKED_LIST [XMI_ARGUMENT]
			-- Formal arguments of `Current'.

	id_return: INTEGER
			-- XMI Id of `Current' Result.

feature -- Element change

	add_argument (a: XMI_ARGUMENT) is
			-- Adds `a' to `arguments'.
		require
			new_argument_not_void: a /= Void
		do
			arguments.extend (a)
		ensure
			new_argument_added: arguments.has (a)
	end

feature -- Actions

	code: STRING is
			-- XMI representation of the attribute.
		local
			xmi_class: XMI_CLASS
		do
			Result := "<Foundation.Core.Operation xmi.id = 'S."
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
				%                  <Foundation.Core.BehavioralFeature.isQuery xmi.value = 'false'/>%N%
				%                  <Foundation.Core.Operation.specification></Foundation.Core.Operation.specification>%N%
				%                  <Foundation.Core.Operation.isPolymorphic xmi.value = 'false'/>%N%
				%                  <Foundation.Core.Operation.concurrency xmi.value = 'sequential'/>%N%
				%                  <Foundation.Core.BehavioralFeature.parameter>%N")
			from
				arguments.start
			until
				arguments.after
			loop
				Result.append (arguments.item.code)
				arguments.forth
			end
			if type.xmi_id /= 0 then
				Result.append ("<Foundation.Core.Parameter xmi.id = 'G.")
				Result.append (id_return.out)
				Result.append ("'>%N%
					%                      <Foundation.Core.ModelElement.name>")
				Result.append (name)
				Result.append (".Return</Foundation.Core.ModelElement.name>%N%
					%                      <Foundation.Core.ModelElement.visibility xmi.value = 'private'/>%N%
					%                      <Foundation.Core.Parameter.defaultValue>%N%
					%                         <Foundation.Data_Types.Expression>%N%
					%                          <Foundation.Data_Types.Expression.language></Foundation.Data_Types.Expression.language>%N%
					%                          <Foundation.Data_Types.Expression.body></Foundation.Data_Types.Expression.body>%N%
					%                         </Foundation.Data_Types.Expression>%N%
					%                      </Foundation.Core.Parameter.defaultValue>%N%
					%                      <Foundation.Core.Parameter.kind xmi.value = 'return'/>%N%
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
			Result.append ("</Foundation.Core.BehavioralFeature.parameter>%N%
				%            </Foundation.Core.Operation>%N")
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

end -- class XMI_OPERATION
