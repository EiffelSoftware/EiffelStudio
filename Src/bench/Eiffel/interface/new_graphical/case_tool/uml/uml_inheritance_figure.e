indexing
	description: "Objects that is an UML view for an inheritance link."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	UML_INHERITANCE_FIGURE
inherit
	EIFFEL_INHERITANCE_FIGURE
		redefine
			recursive_transform,
			set_line_width,
			xml_element,
			xml_node_name,
			set_with_xml_element
		end
		
	UML_CONSTANTS
		undefine
			default_create
		end
		
	OBSERVER
		rename
			update as retrieve_preferences
		undefine
			default_create
		end
		
	EB_SHARED_PREFERENCES
		undefine
			default_create
		end

create
	make_with_model,
	default_create
	
feature {NONE} -- Initialization

	make_with_model (a_model: ES_INHERITANCE_LINK) is
			-- Create a UML_INHERITANCE_FIGURE showing `a_model'.
		do
			default_create
			model := a_model
			initialize
			preferences.diagram_tool_data.add_observer (Current)
			retrieve_preferences
			real_arrow_head_size := 20
			line.set_arrow_size (20)
			request_update
		end
	
feature -- Access

	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml node representing `Current's state.
		do
			Result := Precursor {EIFFEL_INHERITANCE_FIGURE} (node)
			Result.add_attribute ("SOURCE_CLUSTER", xml_namespace, model.descendant.class_i.cluster.cluster_name)
			Result.add_attribute ("TARGET_CLUSTER", xml_namespace, model.ancestor.class_i.cluster.cluster_name)
			Result.put_last (Xml_routines.xml_node (Result, "IS_NEEDED_ON_DIAGRAM", model.is_needed_on_diagram.out))
			Result.put_last (xml_routines.xml_node (Result, "REAL_LINE_WIDTH", (real_line_width * 100).rounded.out))
		end
		
	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		do
			node.forth
			node.forth
			Precursor {EIFFEL_INHERITANCE_FIGURE} (node)
			if xml_routines.xml_boolean (node, "IS_NEEDED_ON_DIAGRAM") then
				model.enable_needed_on_diagram
			else
				model.disable_needed_on_diagram
			end
			real_line_width := xml_routines.xml_integer (node, "REAL_LINE_WIDTH") / 100
			if real_line_width.rounded.max (1) /= line_width then
				line.set_line_width (real_line_width.rounded.max (1))
			end
		end
		
	xml_node_name: STRING is
			-- Name of the node returned by `xml_element'.
		do
			Result := "UML_INHERITANCE_FIGURE"
		end
		
feature -- Element change

	set_line_width (a_line_width: like line_width) is
			-- Set `line_width' to `a_line_widht'.
		do
			Precursor {EIFFEL_INHERITANCE_FIGURE} (a_line_width)
			real_line_width := a_line_width
		end
		
feature {EV_MODEL_GROUP} -- Transformation

	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION) is
			-- Same as transform but without precondition
			-- is_transformable and without invalidating
			-- groups center
		do
			Precursor {EIFFEL_INHERITANCE_FIGURE} (a_transformation)
			real_line_width := real_line_width * a_transformation.item (1, 1)
			if real_line_width.rounded.max (1) /= line_width then
				line.set_line_width (real_line_width.rounded.max (1))
				request_update
			end
			real_arrow_head_size := real_arrow_head_size * a_transformation.item (1, 1)
			if real_arrow_head_size.rounded.max (1) /= line.arrow_size then
				line.set_arrow_size (real_arrow_head_size.rounded.max (1))
				request_update
			end
		end
	
feature {NONE} -- Implementation

	real_line_width: REAL
			-- Real line width.
			
	real_arrow_head_size: REAL
			-- Real size of arrow head.
			
	retrieve_preferences is
			-- Retrieve preferences.
		do
			set_line_width (uml_inheritance_line_width)
			set_foreground_color (uml_inheritance_color)
		end

end -- class UML_INHERITANCE_FIGURE
