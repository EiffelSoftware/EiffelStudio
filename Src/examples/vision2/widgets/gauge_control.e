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
