indexing
	description: "Objects that provide facilities for modifying all drop actions for a transported%
		%object when shift is pressed."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_PICK_AND_DROP_SHIFT_MODIFIER
	
inherit
	
	GB_ACCESSIBLE_OBJECT_HANDLER
	
feature {NONE} -- Basic operation
	
	create_shift_timer is
			-- Create `shift_timer' and connect the shift querying
			-- facility.
		do
			create shift_timer.make_with_interval (10)
			shift_timer.actions.extend (agent check_shift_status)
		end
		
	check_shift_status is
			--
		local
			env: EV_ENVIRONMENT
		do
			create env
			if env.application.shift_pressed then
				if shift_pressed_at_last_check = False then
					io.putstring ("Shift pressed")
					object_handler.for_all_objects_build_shift_drop_actions_for_new_object
				end
				shift_pressed_at_last_check := True
			else
				if shift_pressed_at_last_check = True then
					io.putstring ("Shift released")
					object_handler.for_all_objects_build_drop_actions_for_new_object
				end
				shift_pressed_at_last_check := False
			end
		end
		
		
	destroy_shift_timer is
			-- Destroy `shift_timer'.
		do
			shift_timer.destroy
		end
		
	shift_timer: EV_TIMEOUT
		-- A timer used to check the current state of the shift key
		-- during pick and drop.
	
	shift_pressed_at_last_check: BOOLEAN
		-- Was shift pressed the last time we called check shift_status?


end -- class GB_PICK_AND_DROP_SHIFT_MODIFIER
