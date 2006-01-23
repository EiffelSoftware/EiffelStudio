indexing
	description: "Objects that represent a checkbox in a grid."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_GRID_CHECK_BOX_ITEM

inherit
	EV_GRID_DRAWABLE_ITEM

create
	make,
	make_with_boolean

feature {NONE} -- Initialization
	
	make is
			-- Creation method.
		do
			default_create
			expose_actions.extend (agent draw_overlay_pixmap)
			pointer_button_press_actions.force_extend (agent handle_pointer_pressed)
			create selected_changed_actions
		end
	
	make_with_boolean (a_bool: BOOLEAN)	is
			-- Create the object with value to a_bool
		do
			make
			internal_selected := a_bool
		ensure
			a_bool_set: a_bool = internal_selected
		end

feature -- Access
	
	selected: BOOLEAN assign set_selected is
			-- If current check box selected?
		do
			Result := internal_selected
		end
		
	set_selected (a_bool: BOOLEAN) is
			-- Set True/False to current grid item, and changed the text.
		do
			internal_selected := a_bool
		end
		
feature -- Events
	
	selected_changed_actions: ACTION_SEQUENCE [TUPLE [MA_GRID_CHECK_BOX_ITEM]]
			-- Actions when user clicked the check box.
	
feature {NONE} -- Implementation

	handle_pointer_pressed is
			-- Handle user press event.
		do
			internal_selected := not internal_selected
			from 
				selected_changed_actions.start
			until
				selected_changed_actions.after
			loop
				selected_changed_actions.item.call ([Current])
				selected_changed_actions.forth
			end
		end
		
	draw_overlay_pixmap (a_drawable: EV_DRAWABLE) is
			-- Draw the pixmap which represent whether current is selected.
		require
			a_drawable_not_void: a_drawable /= Void
		do
			a_drawable.clear
			if internal_selected then
				draw_selected (a_drawable)
			else
				draw_unselected (a_drawable)
			end
		end
	
	draw_selected (a_drawable: EV_DRAWABLE) is
			-- Draw the pixmap which is represent current is seleted.
		do
			draw_unselected (a_drawable)
			a_drawable.set_line_width (check_figure_line_width)
			a_drawable.draw_segment (figure_start_x + 1, figure_start_y + 2, figure_start_x + check_figure_size // 2, figure_start_y + check_figure_size)
			a_drawable.draw_segment (figure_start_x + check_figure_size // 2, figure_start_y + check_figure_size, figure_start_x + check_figure_size, figure_start_y - 1 )
		end
	
	draw_unselected (a_drawable: EV_DRAWABLE) is
			-- Draw the pixmap which is represent current is unseleted.
		do
			a_drawable.set_line_width (1)
			a_drawable.draw_rectangle (figure_start_x, figure_start_y, check_figure_size, check_figure_size)
		end
	
	figure_start_x: INTEGER is
			-- The start x position of the figure.
		do
			Result := (width - check_figure_size) // 2
		end
	
	figure_start_y: INTEGER is
			-- The start y position of the figure.
		do
			Result := (height - check_figure_size) // 2
		end
		
	check_figure_size: INTEGER is 10
			-- The width/height of the check box.
			
	check_figure_line_width: INTEGER is 2
			-- The line width on the sign figure.
	
	internal_selected: BOOLEAN
			-- Whether current check box is internal_selected?
			
invariant
	selected_changed_actions_not_void: selected_changed_actions /= Void
	
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




end
