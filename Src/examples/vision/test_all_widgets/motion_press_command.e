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
