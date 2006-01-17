indexing
	description: "Graphical representation of an XMI class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_CLASS_PRESENTATION

inherit
	XMI_PRESENTATION
		redefine
			item
		end

create
	make

feature -- Initialization

	make (id: INTEGER; c: XMI_CLASS; x, y: INTEGER) is
			-- Initialize `Current'.
		do	
			xmi_id := id
			item := c
			length := 200
			width := 100
			upper_left_x := x
			upper_left_y := y
		end

feature -- Access

	item: XMI_CLASS
		-- XMI class of which `Current' is the graphical representation.

feature -- Action

	code: STRING is
			-- XMI representation of the presentation.
		do
			Result := "<Foundation.Auxiliary_Elements.Presentation xmi.id='G."
			Result.append (xmi_id.out)
			Result.append ("'>%N%
				%              <Foundation.Auxiliary_Elements.Presentation.geometry>%N%
				%                <Foundation.Data_Types.Geometry>%N%
				%                  <Foundation.Data_Types.Geometry.body>%N")
			Result.append (upper_left_x.out)
			Result.append (", ")
			Result.append (upper_left_y.out)
			Result.append (", ")
			Result.append (length.out)
			Result.append (", ")
			Result.append (width.out)
			Result.append (", ")
			Result.append ("</Foundation.Data_Types.Geometry.body>%N%
				%                </Foundation.Data_Types.Geometry>%N%
				%              </Foundation.Auxiliary_Elements.Presentation.geometry>%N%
				%              <Foundation.Auxiliary_Elements.Presentation.style>%N%
				%               <Foundation.Data_Types.GraphicMarker>%N%
				%                  <Foundation.Data_Types.GraphicMarker.body>%N%
				%                    Font.Blue= 0,Font.Green= 0,Font.Red= 0,Font.FaceName=Arial,Font.Size= 10,Font.Bold=0,Font.Italic=0,Font.Strikethrough=0,Font.Underline=0,LineColor.Blue= 51,LineColor.Green= 0,LineColor.Red= 153,FillColor.Blue= 204,FillColor.Green= 255,FillColor.Red= 255,FillColor.Transparent=1,AutomaticResize=1,ShowAllAttributes=1,ShowAllOperations=1,ShowOperationSignature=0,SuppressAttributes=0,SuppressOperations=0,%N%
				%                  </Foundation.Data_Types.GraphicMarker.body>%N%
				%                </Foundation.Data_Types.GraphicMarker>%N%
				%              </Foundation.Auxiliary_Elements.Presentation.style>%N%
				%             <Foundation.Auxiliary_Elements.Presentation.model>%N%
				%                <Foundation.Core.Class xmi.idref = 'S.")
			Result.append (item.xmi_id.out)
			Result.append ("'/> <!-- ")
			Result.append (item.compiled_class.name_in_upper)
			Result.append (" -->%N%
				%             </Foundation.Auxiliary_Elements.Presentation.model>%N%
				%            </Foundation.Auxiliary_Elements.Presentation>%N")
		end

feature {NONE} -- Implementation

	upper_left_x: INTEGER 
			-- Coordinate of the class upper-left corner in Rose.

	upper_left_y: INTEGER 
 			-- Coordinate of the class upper-left corner in Rose.

	length: INTEGER 
			-- Length of the class in Rose.

	width: INTEGER;
			-- Width of the class in Rose.

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

end -- class XMI_CLASS_PRESENTATION
