indexing
	description: "Objects that is a view for an EIFFEL_INHERITANCE_LINK"
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	BON_INHERITANCE_FIGURE

inherit
	EIFFEL_INHERITANCE_FIGURE
		redefine
			update,
			recursive_transform,
			set_line_width,
			xml_element,
			xml_node_name,
			set_with_xml_element,
			recycle
		end
		
	BON_FIGURE
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
			-- Create a BON_INHERITANCE_FIGURE showing `a_model'.
		do
			default_create
			model := a_model
			is_high_quality := True
			initialize

			preferences.diagram_tool_data.add_observer (Current)
			
			retrieve_preferences
			
			real_arrow_head_size := 10
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
			Result := "BON_INHERITANCE_FIGURE"
		end
		
feature -- Element change

	set_line_width (a_line_width: like line_width) is
			-- Set `line_width' to `a_line_widht'.
		do
			Precursor {EIFFEL_INHERITANCE_FIGURE} (a_line_width)
			real_line_width := a_line_width
		end
		
	recycle is
			-- Free `Current's resources.
		do
			Precursor {EIFFEL_INHERITANCE_FIGURE}
			preferences.diagram_tool_data.remove_observer (Current)
		end
		
feature {EG_FIGURE, EG_FIGURE_WORLD} -- Update
		
	update is
			-- Some properties of `Current' may have changed.
		local
			an_angle: DOUBLE
			l_point_array: SPECIAL [EV_COORDINATE]
			p0, p1: EV_COORDINATE
		do
			if is_high_quality then
				Precursor {EIFFEL_INHERITANCE_FIGURE}
			else
				l_point_array := low_quality_line.point_array
				p0 := l_point_array.item (0)
				p1 := l_point_array.item (1)
				
				if descendant /= Void then
					p0.set_position (descendant.port_x, descendant.port_y)
				end
				if ancestor /= Void then
					p1.set_position (ancestor.port_x, ancestor.port_y)
				end
				an_angle := line_angle (p0.x_precise, p0.y_precise, p1.x_precise, p1.y_precise)
				if descendant /= Void then
					descendant.update_edge_point (p0, an_angle)
				end
				if ancestor /= Void then
					ancestor.update_edge_point (p1, an_angle + pi)
				end
				low_quality_line.invalidate
				low_quality_line.center_invalidate
			end
			is_update_required := False
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
				if is_high_quality then
					line.set_arrow_size (real_arrow_head_size.rounded.max (1))
				else
					low_quality_line.set_arrow_size (real_arrow_head_size.rounded.max (1))
				end
				request_update
			end
		end
	
feature {NONE} -- Implementation

	real_line_width: REAL
			-- Real line width.
			
	real_arrow_head_size: REAL
			-- Real size of arrow head.

	low_quality_line: EV_MODEL_LINE
			-- line used if `is_low_quality' is True.
			
	set_is_high_quality (a_high_quality: like is_high_quality) is
			-- Set `is_high_quality' to `a_high_quality'.
		do
			if is_high_quality /= a_high_quality then
				is_high_quality := a_high_quality
				if is_high_quality then
					prune_all (low_quality_line)
					extend (line)
					line.enable_sensitive
					line.set_arrow_size (real_arrow_head_size.rounded.max (1))
					from
						edge_move_handlers.start
					until
						edge_move_handlers.after
					loop
						extend (edge_move_handlers.item)
						edge_move_handlers.item.enable_sensitive
						edge_move_handlers.forth
					end
				else
					create low_quality_line
					prune_all (line)
					line.disable_sensitive
					from
						edge_move_handlers.start
					until
						edge_move_handlers.after
					loop
						prune_all (edge_move_handlers.item)
						edge_move_handlers.item.disable_sensitive
						edge_move_handlers.forth
					end
					extend (low_quality_line)
					low_quality_line.set_foreground_color (foreground_color)
					low_quality_line.enable_end_arrow
					low_quality_line.set_arrow_size (real_arrow_head_size.rounded.max (1))
				end
			end
		end
		
	retrieve_preferences is
			-- Retrive preferences from shared resources.
		do
			set_line_width (bon_inheritance_line_width)
			set_foreground_color (bon_inheritance_color)
		end

end -- class BON_INHERITANCE_FIGURE
