indexing
	description: "Objects that shows node name within an ellipse."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	ELLIPSE_NODE

inherit
	EG_SIMPLE_NODE
		redefine
			color,
			update,
			default_create,
			figure_size,
			xml_node_name
		end
	
create
	make_with_model
	
feature {NONE} -- Initialization

	default_create is
			-- Create an EG_SIMPLE_NODE.
		do
			Precursor {EG_SIMPLE_NODE}
			bring_to_front (name_label)
			node_figure.set_radius1 (figure_size)
			node_figure.set_radius2 (figure_size // 2)
			disable_scaling
			disable_rotating
			set_center
		end
		
feature -- Access

	xml_node_name: STRING is
			-- Name of `xml_element'.
		do
			Result := "ELLIPSE_NODE"
		end
	
feature -- Element change

	update is
			-- Some properties may have changed.
		do
			if is_label_shown then
				name_label.set_x_y (point_x, point_y)
			end
			is_update_required := False
		end
	
feature {NONE} -- Implementation

	color: EV_COLOR is
			-- color of figure.
		once
			create Result.make_with_rgb (0,0,1)
		end
		
	figure_size: INTEGER is
			-- Size of figure in pixel.
		do
			Result := 30
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class ELLIPSE_NODE
