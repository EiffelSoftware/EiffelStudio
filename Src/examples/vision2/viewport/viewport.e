note
	description: "Viewport example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VIEWPORT

inherit
	EV_APPLICATION

create
	make_and_launch

feature {NONE}-- Initialization

	make_and_launch
			-- Create `Current' and launch.
		do
			default_create
			prepare
			launch
		end
		
feature {NONE} -- Implementation

	prepare
			-- Pack `first_window'.
		local
			range: INTEGER_INTERVAL
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			pixmap: EV_PIXMAP
			button: EV_BUTTON
		do
			create range.make (0, 220)
			create spin_button_x.make_with_value_range (range)
			create range.make (0, 440)
			create spin_button_y.make_with_value_range (range)
			spin_button_x.change_actions.extend (agent on_spin_button_x_changed (?))
			spin_button_y.change_actions.extend (agent on_spin_button_y_changed (?))
			spin_button_x.set_step (10)
			spin_button_y.set_step (10)
			create vertical_box
			first_window.extend (vertical_box)
			create viewport
			create pixmap
			pixmap.set_with_named_file ("bm_About.png")
			vertical_box.extend (viewport)
			create button
			button.set_pixmap (pixmap)
			viewport.extend (button)
			viewport.set_offset (0, 0)
			
			
			viewport.set_minimum_size (200, 200)
			create horizontal_box
			vertical_box.extend (horizontal_box)
			horizontal_box.extend (spin_button_x)
			horizontal_box.extend (spin_button_y)
			vertical_box.disable_item_expand (horizontal_box)
			
			first_window.close_request_actions.extend (agent destroy)
			first_window.show
		end

	on_spin_button_x_changed (new_value: INTEGER)
			-- Horizontal value changed.
		do
			viewport.set_x_offset (new_value)
		end

	on_spin_button_y_changed (new_value: INTEGER)
			-- Vertical value changed.
		do
			viewport.set_y_offset (new_value)
		end

	first_window: EV_TITLED_WINDOW
			-- Window containing viewport and scrollable area.
		once
			create Result.make_with_title ("Viewport example")
		end
		
	spin_button_x, spin_button_y: EV_SPIN_BUTTON
			-- Gauges that control offset of `viewport'.

	viewport: EV_VIEWPORT;
			-- EV_VIEWPORT to be demonstrated in test.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class VIEWPORT

