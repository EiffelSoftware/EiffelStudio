indexing
	description: "Graphical representation of an XMI cluster"
	date: "$Date$"
	revision: "$Revision$"

class
	XMI_CLUSTER_PRESENTATION

inherit
	XMI_PRESENTATION
		redefine
			item
		end

create
	make

feature -- Initialization

	make (id: INTEGER; c: XMI_CLUSTER) is
			-- Initialize `Current'.
		do	
			xmi_id := id
			item := c
		end

feature -- Access

	item: XMI_CLUSTER
		-- XMI cluster of which `Current' is the graphical representation.

feature -- Action

	code: STRING is
			-- XMI representation of the presentation.
		do
			Result := "<Foundation.Auxiliary_Elements.Presentation xmi.id='G."
			Result.append (xmi_id.out)
			Result.append ("'>%N%
				%              <Foundation.Auxiliary_Elements.Presentation.geometry>%N%
				%                <Foundation.Data_Types.Geometry>%N%
				%                  <Foundation.Data_Types.Geometry.body>%N%
				%                     100, 100, 100, 100,%N%
				%                  </Foundation.Data_Types.Geometry.body>%N%
				%                </Foundation.Data_Types.Geometry>%N%
				%              </Foundation.Auxiliary_Elements.Presentation.geometry>%N%
				%              <Foundation.Auxiliary_Elements.Presentation.style>%N%
				%               <Foundation.Data_Types.GraphicMarker>%N%
				%                  <Foundation.Data_Types.GraphicMarker.body>%N%
				%                    Category%N%
				%                  </Foundation.Data_Types.GraphicMarker.body>%N%
				%                </Foundation.Data_Types.GraphicMarker>%N%
				%              </Foundation.Auxiliary_Elements.Presentation.style>%N%
				%             <Foundation.Auxiliary_Elements.Presentation.model>%N%
				%                <Model_Management.Package xmi.idref = 'S.")
			Result.append (item.xmi_id.out)
			Result.append ("'/> <!-- ")
			Result.append (item.lace_cluster.name_in_upper)
			Result.append (" -->%N%
				%             </Foundation.Auxiliary_Elements.Presentation.model>%N%
				%            </Foundation.Auxiliary_Elements.Presentation>%N")
		end

end -- class XMI_CLUSTER_PRESENTATION
