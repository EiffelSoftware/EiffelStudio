indexing
	description: "Controls used to modify objects of type EV_COLORIZABLE."
	date: "$Date$"
	revision: "$Revision$"

class
	COLORIZABLE_CONTROL

inherit

	EV_FRAME

create
	make

feature {NONE} -- Initialization

	make (box: EV_BOX; colorizable: EV_COLORIZABLE; output: EV_TEXT) is
			-- Create controls to manipulate `colorizable', parented in `box' and
			-- displaying output in `output'.
		do
			create interval.make (0, 255)
			back_color := colorizable.background_color
			fore_color := colorizable.foreground_color
			initial_fore_color := clone (fore_color)
			initial_back_color := clone (back_color)
			default_create
			set_text ("EV_COLORIZABLE")
			create vertical_box
			extend (vertical_box)
			create horizontal_box
			create bspinr.make_with_value_range (interval)
			horizontal_box.extend (bspinr)
			bspinr.set_value (back_color.red_8_bit)
			bspinr.change_actions.force_extend (agent colorizable_set_background (colorizable))
			create bsping.make_with_value_range (interval)
			horizontal_box.extend (bsping)
			bsping.set_value (back_color.green_8_bit)
			bsping.change_actions.force_extend (agent colorizable_set_background (colorizable))
			create bspinb.make_with_value_range (interval)
			horizontal_box.extend (bspinb)
			bspinb.set_value (back_color.blue_8_bit)
			bspinb.change_actions.force_extend (agent colorizable_set_background (colorizable))
			vertical_box.extend (horizontal_box)
			create horizontal_box
			create fspinr.make_with_value_range (interval)
			horizontal_box.extend (fspinr)
			fspinr.change_actions.force_extend (agent colorizable_set_foreground (colorizable))
			create fsping.make_with_value_range (interval)
			horizontal_box.extend (fsping)
			fsping.change_actions.force_extend (agent colorizable_set_foreground (colorizable))
			create fspinb.make_with_value_range (interval)
			horizontal_box.extend (fspinb)
			fspinb.change_actions.force_extend (agent colorizable_set_foreground (colorizable))
			vertical_box.extend (horizontal_box)
			create button.make_with_text ("Reset")
			button.select_actions.extend (agent reset_colors (colorizable))
			vertical_box.extend (button)
			box.extend (Current)
		end
		
feature {NONE} -- Implementation
		
	reset_colors (colorizable: EV_COLORIZABLE) is
			-- Rest colors and spin buttons.
		do
			colorizable.set_foreground_color (initial_fore_color)
			colorizable.set_background_color (initial_back_color)
			bspinr.set_value (initial_back_color.red_8_bit)
			bsping.set_value (initial_back_color.green_8_bit)
			bspinb.set_value (initial_back_color.blue_8_bit)
			fspinr.set_value (initial_fore_color.red_8_bit)
			fsping.set_value (initial_fore_color.green_8_bit)
			fspinb.set_value (initial_fore_color.blue_8_bit)
		end
		
	colorizable_set_background (colorizable: EV_COLORIZABLE) is
			-- Set the background color of `colorizable'.
		local
			color: EV_COLOR
		do
			create color.make_with_8_bit_rgb (bspinr.value, bsping.value, bspinb.value)
			colorizable.set_background_color (color)
		end
		
	colorizable_set_foreground (colorizable: EV_COLORIZABLE) is
			-- Set the foreground color of `colorizable'.
		local
			color: EV_COLOR
		do
			create color.make_with_8_bit_rgb (fspinr.value, fsping.value, fspinb.value)
			colorizable.set_foreground_color (color)
		end

		-- Widgets used to create controls.
	interval: INTEGER_INTERVAL
	back_color, fore_color: EV_COLOR
	initial_back_color, initial_fore_color: EV_COLOR
	horizontal_box: EV_HORIZONTAL_BOX
	vertical_box: EV_VERTICAL_BOX
	button: EV_BUTTON
	fspinr, fsping, fspinb, bspinr, bspinb, bsping: EV_SPIN_BUTTON

end -- class COLORIZABLE_CONTROL
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

