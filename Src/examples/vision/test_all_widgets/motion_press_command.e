class MOTION_PRESS_COMMAND

inherit
	
	COMMAND
	ENUMS
	WINDOWS

feature

	execute (arg: INTEGER_REF) is
	do
		inspect arg.item
		when b_button_press then
			if not md.is_popped_up then
				md.set_message("Button press")
				md.add_ok_action (Current, b_ok)
				md.popup
			end
		when b_button_motion then
			if not md.is_popped_up then
				md.set_message("Button motion")
				md.add_ok_action (Current, b_ok)
				md.popup
			end
		when b_pointer_motion then
			if not md.is_popped_up then
				md.set_message("Pointer motion")
				md.add_ok_action (Current, b_ok)
				md.popup
			end
		when b_ok then
			md.remove_ok_action (Current, b_ok)
			md.popdown
		else
		end
	end

end

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

