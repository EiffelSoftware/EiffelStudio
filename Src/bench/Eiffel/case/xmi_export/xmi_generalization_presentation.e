indexing
	description: "Graphical representation of an XMI class"
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

end -- class XMI_GENERALIZATION_PRESENTATION
