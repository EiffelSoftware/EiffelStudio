indexing
	description: "Graphical representation of an XMI class"
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

	width: INTEGER
			-- Width of the class in Rose.

end -- class XMI_CLASS_PRESENTATION
