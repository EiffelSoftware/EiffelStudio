indexing
	description: "This class represents a MS_WINDOWS application shared data. Once functions for connecting handlers are here"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	G_ANY_WINDOWS

inherit
	G_ANY_I


feature {NONE} -- Implementation

	activate_actions: ACTIONS_MANAGER is
			-- Event handler for activate push button events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	apply_actions: ACTIONS_MANAGER is
			-- Event handler for apply events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	arm_actions: ACTIONS_MANAGER is
			-- Event handler for arm events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	browse_actions: ACTIONS_MANAGER is
			-- Event handler for browse events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	character_actions: ACTIONS_MANAGER is
			-- Event handler for activate actions on Text
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	left_button_click_actions: ACTIONS_MANAGER is
			-- Event handler for left button click events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	right_button_click_actions: ACTIONS_MANAGER is
			-- Event handler for right button click events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	middle_button_click_actions: ACTIONS_MANAGER is
			-- Event handler for middle button click events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	left_button_motion_actions: ACTIONS_MANAGER is
			-- Event handler for left button motion events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	right_button_motion_actions: ACTIONS_MANAGER is
			-- Event handler for right button motion events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	middle_button_motion_actions: ACTIONS_MANAGER is
			-- Event handler for middle button motion events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	left_button_press_actions: ACTIONS_MANAGER is
			-- Event handler for left button press events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	right_button_press_actions: ACTIONS_MANAGER is
			-- Event handler for right button press events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	middle_button_press_actions: ACTIONS_MANAGER is
			-- Event handler for middle button press events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	left_button_release_actions: ACTIONS_MANAGER is
			-- Event handler for left button release events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	right_button_release_actions: ACTIONS_MANAGER is
			-- Event handler for right button release events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	middle_button_release_actions: ACTIONS_MANAGER is
			-- Event handler for middle button release events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	cancel_actions: ACTIONS_MANAGER is
			-- Event handler for cancel events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	click_actions: ACTIONS_MANAGER is
			-- Event handler for click events (on a list)
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	combo_box_selection_end_actions: ACTIONS_MANAGER is
			-- Event handler for combo box selection end
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	destroy_actions: ACTIONS_MANAGER is
			-- Event handler for destroy actions 
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	draw_item_actions: ACTIONS_MANAGER is
			-- Event handler for draw item events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	enter_actions: ACTIONS_MANAGER is
			-- Event handler for enter events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	expose_actions: ACTIONS_MANAGER is
			-- Event handler for expose events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	extended_actions: ACTIONS_MANAGER is
			-- Event handler for extended events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end;

	filter_actions: ACTIONS_MANAGER is
			-- Event handler for filter events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	focus_out_actions: ACTIONS_MANAGER is
			-- Event handler for focus out events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	focus_in_actions: ACTIONS_MANAGER is
			-- Event handler for focus in events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	help_actions: ACTIONS_MANAGER is
			-- Event handler for help events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	init_d_actions: ACTIONS_MANAGER is
			-- Event handler for initialise dialog events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	key_press_actions: ACTIONS_MANAGER is
			-- Event handler for key press events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	key_release_actions: ACTIONS_MANAGER is
			-- Event handler for key release events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	leave_actions: ACTIONS_MANAGER is
			-- Event handler for leave events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	menu_select_actions: ACTIONS_MANAGER is
			-- Event handler for menu selection events
		once
			!! Result.make
		end

	multiple_actions: ACTIONS_MANAGER is
			-- Event handler for multiple selection events
		once
			!! Result.make
		end

	ok_actions: ACTIONS_MANAGER is
			-- Event handler for ok events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	pointer_motion_actions: ACTIONS_MANAGER is
			-- Event handler for pointer events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	resize_actions: ACTIONS_MANAGER is
			-- Event handler for resize events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	selection_change_actions: ACTIONS_MANAGER is
			-- Event handler for list events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	single_actions: ACTIONS_MANAGER is
			-- Event handler for single events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	timer_actions: ACTIONS_MANAGER is
			-- Event handler for timer events
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	toggle_value_changed_actions: ACTIONS_MANAGER is
			-- Event handler for value changed events on toggle buttons
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	value_changed_actions: ACTIONS_MANAGER is
			-- Event handler for value changed events on scrollbars
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	move_actions: ACTIONS_MANAGER is
			-- Event handler for move events (scrollbars)
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	vertical_move_actions: ACTIONS_MANAGER is
			-- Event handler for vertical move
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	horizontal_move_actions: ACTIONS_MANAGER is
			-- Event handler for horizontal move
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	modify_actions: ACTIONS_MANAGER is
			-- Event handler for modifying text
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	motion_actions: ACTIONS_MANAGER is
			-- Event handler for a motion in a text
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	release_actions: ACTIONS_MANAGER is
			-- Event handler for a button release
		once
			!! Result.make
		ensure
			result_exists: Result /= Void
		end

	visible_actions: ACTIONS_MANAGER is
			-- Event handler for a visible event
		once
			!! Result.make
		end

	map_actions: ACTIONS_MANAGER is
			-- Event handler for a mapping event.
		once
			!! Result.make
		end

	unmap_actions: ACTIONS_MANAGER is
			-- Event handler for a unmapping event.
		once
			!! Result.make
		end

	system_metrics: WEL_SYSTEM_METRICS is
			-- All the system metrics
		once
			!! Result
		ensure
			result_exists: Result /= Void
		end

end -- class G_ANY_WINDOWS

--|---------------------------------------------------------------- 
--| EiffelVision: library of reusable components for ISE Eiffel 3. 
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software 
--|   Engineering Inc. 
--| All rights reserved. Duplication and distribution prohibited. 
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA 
--| Telephone 805-685-1006 
--| Fax 805-685-6869 
--| Electronic mail <info@eiffel.com> 
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------
