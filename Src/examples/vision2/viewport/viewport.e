indexing
	description: "Viewport example."
	date: "$Date$"
	revision: "$Revision$"

class
	VIEWPORT

inherit
	EV_APPLICATION

create
	make_and_launch

feature {NONE}-- Initialization

	make_and_launch is
			-- Create `Current' and launch.
		do
			default_create
			prepare
			launch
		end
		
feature {NONE} -- Implementation

	prepare is
			-- Pack `first_window'.
		local
			range: INTEGER_INTERVAL
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			pixmap: EV_PIXMAP
			button: EV_BUTTON
		do
			create range.make (-150, 150)
			create spin_button_x.make_with_value_range (range)
			create range.make (-150, 150)
			create spin_button_y.make_with_value_range (range)
			spin_button_x.change_actions.extend (~on_spin_button_x_changed (?))
			spin_button_y.change_actions.extend (~on_spin_button_y_changed (?))
			spin_button_x.set_step (5)
			spin_button_y.set_step (5)
			create vertical_box
			first_window.extend (vertical_box)
			create viewport
			create pixmap
			pixmap.set_with_named_file ("..\..\bm_About.png")
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

	on_spin_button_x_changed (new_value: INTEGER) is
			-- Horizontal value changed.
		do
			viewport.set_x_offset (new_value)
		end

	on_spin_button_y_changed (new_value: INTEGER) is
			-- Vertical value changed.
		do
			viewport.set_y_offset (new_value)
		end

	first_window: EV_TITLED_WINDOW is
			-- Window containing viewport and scrollable area.
		once
			create Result.make_with_title ("Viewport example")
		end
		
	spin_button_x, spin_button_y: EV_SPIN_BUTTON
			-- Gauges that control offset of `viewport'.

	viewport: EV_VIEWPORT
			-- EV_VIEWPORT to be demonstrated in test.

end -- class VIEWPORT

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

