indexing
	description: "Controls used to modify objects of type EV_GAUGE"
	date: "$Date$"
	revision: "$Revision$"

class
	GAUGE_CONTROL
	
inherit
	EV_FRAME

create
	make

feature {NONE} -- Initialization

	make (box: EV_BOX; gauge: EV_GAUGE; output: EV_TEXT) is
			-- Create controls to manipulate `gauge', parented in `box' and
			-- displaying output in `output'.
		do
			default_create
			set_text ("Gauge")
			create vertical_box
			extend (vertical_box)
			create button.make_with_text ("Step_forward")
			button.select_actions.extend (agent gauge.step_forward)
			vertical_box.extend (button)
			create button.make_with_text ("Step_backward")
			button.select_actions.extend (agent gauge.step_backward)
			vertical_box.extend (button)
			create button.make_with_text ("Leap_forward")
			button.select_actions.extend (agent gauge.leap_forward)
			vertical_box.extend (button)
			create button.make_with_text ("Leap_backward")
			button.select_actions.extend (agent gauge.leap_backward)
			vertical_box.extend (button)
			
			box.extend (Current)
		end

feature {NONE} -- Implementation

		-- Widgets used to create controls.
	vertical_box: EV_VERTICAL_BOX
	button: EV_BUTTON
	
end -- class GAUGE_CONTROL

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

