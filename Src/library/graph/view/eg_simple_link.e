indexing
	description: "A very simple implementation for a EG_LINK_FIGURE"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_SIMPLE_LINK

inherit
	EG_LINK_FIGURE
		redefine
			default_create,
			xml_node_name
		end
	
create
	make_with_model
	
feature {NONE} -- Initialization

	default_create is
			-- Create an EG_SIMPLE_LINK.
		do
			Precursor {EG_LINK_FIGURE}
			create line
			extend (line)
			create reflexive.make_with_positions (0, 0, 10, 10)
		end

	make_with_model (a_model: EG_LINK) is
			-- Make a link using `a_model'.
		require
			a_model_not_void: a_model /= Void
		do
			default_create
			model := a_model
			initialize

			if model.is_directed then
				line.enable_end_arrow
			end
			if model.is_reflexive then
				prune_all (line)
				extend (reflexive)
			end
			
			disable_moving
			disable_scaling
			disable_rotating

			update
		end
		
feature -- Access

	xml_node_name: STRING is
			-- Name of `xml_element'.
		do
			Result := "EG_SIMPLE_LINK"
		end
		
	arrow_size: INTEGER is
			-- Size of the arrow.
		do
			Result := line.arrow_size
		end
	
feature -- Element change

	set_arrow_size (i: INTEGER) is
			-- Set `arrow_size' to `i'.
		require
			i_positive: i > 0
		do
			line.set_arrow_size (i)
		ensure
			set: arrow_size = i
		end

feature {EG_FIGURE, EG_FIGURE_WORLD} -- Update

	update is
			-- Some properties may have changed.
		local
			p1, p2: EV_COORDINATE
			an_angle: DOUBLE
			source_size: EV_RECTANGLE
		do
			if not model.is_reflexive then
				if source /= Void and then target /= Void then
					p1 := line.point_array.item (0)
					p2 := line.point_array.item (1)
					
					p1.set (source.port_x, source.port_y)
					p2.set (target.port_x, target.port_y)
					
					an_angle := line_angle (p1.x_precise, p1.y_precise, p2.x_precise, p2.y_precise)
					source.update_edge_point (p1, an_angle)
					an_angle := pi + an_angle
					target.update_edge_point (p2, an_angle)
				elseif source /= Void then
					p1 := line.point_array.item (0)
					p1.set (source.port_x, source.port_y)
					source.update_edge_point (p1, 0)
				elseif target /= Void then
					p2 := line.point_array.item (1)
					p2.set (target.port_x, target.port_y)
					target.update_edge_point (p2, 0)
				end
				
				line.invalidate
				line.center_invalidate
				if is_label_shown then
					name_label.set_point_position (line.x, line.y)
				end
			else
				if source /= Void then
					source_size := source.size
					reflexive.set_x_y (source_size.right + reflexive.radius1, source_size.top + source_size.height // 2)
				end
				if is_label_shown then
					name_label.set_point_position (reflexive.x + reflexive.radius1, reflexive.y)
				end
			end
			is_update_required := False
		end
	
feature {NONE} -- Implementation

	set_is_selected (an_is_selected: like is_selected) is
			-- Set `is_selected' to `an_is_selected'.
		do
			is_selected := an_is_selected
		end
			
	line: EV_MODEL_LINE
			-- The line representing the link.
			
	reflexive: EV_MODEL_ELLIPSE
			-- The ellipse used when link `is_reflexive'.
			
	on_is_directed_change is
			-- `model'.`is_directed' changed.
		do
			if model.is_directed then
				line.enable_end_arrow
			else
				line.disable_end_arrow
			end
			line.invalidate
			line.center_invalidate
		end
		
invariant
	line_not_void: line /= Void
			
end -- class EG_SIMPLE_LINK

--|----------------------------------------------------------------
--| EiffelGraph: library of graph components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

