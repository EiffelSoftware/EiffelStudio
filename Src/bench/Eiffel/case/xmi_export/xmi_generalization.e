indexing
	description: "Information on a relation of inheritance for XMI export"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_GENERALIZATION

inherit
	XMI_ITEM

create 
	make

feature --Initialization

	make (id: INTEGER; sub, super: XMI_CLASS) is
			-- Initialization of `Current'
			-- assign `id' to `xmi_id'
			-- adds `Current' in `generalizations` field of the two classes involved.
		do
			subtype := sub
			supertype := super
			xmi_id := id
			subtype.add_generalization (Current)
			supertype.add_generalization (Current)
		end

feature -- Access

	subtype: XMI_CLASS
			-- Class which inherits from `supertype'.	

	supertype: XMI_CLASS
			-- Class from which inherits `subtype'.

	enclosing_cluster: CLUSTER_I is
			-- If exists, common cluster of `subtype' and `supertype'
			-- Void otherwise.
		local
			c: CLUSTER_I
		do
			c := subtype.compiled_class.cluster
			if c = supertype.compiled_class.cluster then
				Result := c
			else
				Result := Void
			end
		end

feature -- Action

	code: STRING is
			-- XMI representation of the generalization.
		do
			Result := "<Foundation.Core.Generalization xmi.id = 'G."
			Result.append (xmi_id.out)
			Result.append ("'>%N%
				 %        <Foundation.Core.ModelElement.name></Foundation.Core.ModelElement.name>%N%
				 %        <Foundation.Core.ModelElement.visibility xmi.value = 'public'/>%N%
				 %       <Foundation.Core.Generalization.discriminator></Foundation.Core.Generalization.discriminator>%N%
				 %       <Foundation.Core.Generalization.subtype>%N%
				 %         <Foundation.Core.Class xmi.idref = 'S.")
			Result.append (subtype.xmi_id.out)
			Result.append ("'/> <!-- ")
			Result.append (subtype.name)
			Result.append (" -->%N%
				%</Foundation.Core.Generalization.subtype>%N%
				%<Foundation.Core.Generalization.supertype>%N%
				%<Foundation.Core.Class xmi.idref = 'S.")
			Result.append (supertype.xmi_id.out)
			Result.append ("'/> <!-- ")
			Result.append (supertype.name)
			Result.append (" -->%N% 
				%</Foundation.Core.Generalization.supertype>%N%
				%</Foundation.Core.Generalization>%N")

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

end -- class XMI_GENERALIZATION
