indexing
	description: "Graphical representation of an XMI class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_GENERALIZATION_PRESENTATION

inherit
	XMI_PRESENTATION
		redefine
			item
		end

create
	make

feature -- Initialization

	make (id: INTEGER; c: XMI_GENERALIZATION) is
			-- Initialize `Current'.
		do	
			xmi_id := id
			item := c
		end

feature -- Access

	item: XMI_GENERALIZATION
		-- XMI generalization of which `Current' is the graphical representation.

feature -- Action

	code: STRING is
			-- XMI representation of the presentation.
		do
			Result := "<Foundation.Auxiliary_Elements.Presentation xmi.id='G."
			Result.append (xmi_id.out)
			Result.append ("'>%N%
  				%            <Foundation.Auxiliary_Elements.Presentation.geometry>%N%
				%               <Foundation.Data_Types.Geometry>%N%
				%	           <Foundation.Data_Types.Geometry.body>%N%
				%                     100, 100, 100, 100,%N%
				%                  </Foundation.Data_Types.Geometry.body>%N%
				%                </Foundation.Data_Types.Geometry>%N%
				%              </Foundation.Auxiliary_Elements.Presentation.geometry>%N%
				%              <Foundation.Auxiliary_Elements.Presentation.style>%N%
				%                <Foundation.Data_Types.GraphicMarker>%N%
				%                  <Foundation.Data_Types.GraphicMarker.body>%N%
				%                    Inheritance%N%
				%                  </Foundation.Data_Types.GraphicMarker.body>%N%
				%                </Foundation.Data_Types.GraphicMarker>%N%
				%              </Foundation.Auxiliary_Elements.Presentation.style>%N%
				%              <Foundation.Auxiliary_Elements.Presentation.model>%N%
				%                <Foundation.Core.Generalization xmi.idref = 'G.")
			Result.append (item.xmi_id.out)
			Result.append ("'/> <!-- {")
			Result.append (item.subtype.compiled_class.name_in_upper)
			Result.append ("->")
			Result.append (item.supertype.compiled_class.name_in_upper)
			Result.append ("} -->%N%
				%              </Foundation.Auxiliary_Elements.Presentation.model>%N%
				%            </Foundation.Auxiliary_Elements.Presentation>%N")
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

end -- class XMI_GENERALIZATION_PRESENTATION
