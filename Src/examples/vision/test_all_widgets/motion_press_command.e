indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

