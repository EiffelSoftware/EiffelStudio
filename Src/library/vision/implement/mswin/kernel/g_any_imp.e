indexing
	description: "This class represents a MS_WINDOWS application shared data. Once functions for connecting handlers are here"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	G_ANY_IMP

inherit
	G_ANY_I

feature {NONE} -- Status Setting

	init_common_controls_dll is
			-- Load common controls dll (once)
		local
			common_controls_dll: WEL_COMMON_CONTROLS_DLL
		once
			create common_controls_dll.make
			common_controls_dll.set_shared
		end

feature {NONE} -- Implementation

	activate_actions: ACTIONS_MANAGER is
			-- Event handler for activate push button events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	apply_actions: ACTIONS_MANAGER is
			-- Event handler for apply events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	arm_actions: ACTIONS_MANAGER is
			-- Event handler for arm events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	browse_actions: ACTIONS_MANAGER is
			-- Event handler for browse events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	character_actions: ACTIONS_MANAGER is
			-- Event handler for activate actions on Text
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	left_button_motion_actions: ACTIONS_MANAGER is
			-- Event handler for left button motion events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	right_button_motion_actions: ACTIONS_MANAGER is
			-- Event handler for right button motion events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	middle_button_motion_actions: ACTIONS_MANAGER is
			-- Event handler for middle button motion events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	left_button_press_actions: ACTIONS_MANAGER is
			-- Event handler for left button press events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	right_button_press_actions: ACTIONS_MANAGER is
			-- Event handler for right button press events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	middle_button_press_actions: ACTIONS_MANAGER is
			-- Event handler for middle button press events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	left_button_release_actions: ACTIONS_MANAGER is
			-- Event handler for left button release events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	right_button_release_actions: ACTIONS_MANAGER is
			-- Event handler for right button release events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	middle_button_release_actions: ACTIONS_MANAGER is
			-- Event handler for middle button release events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	click_actions: ACTIONS_MANAGER is
			-- Event handler for click events (on a list)
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	combo_box_selection_end_actions: ACTIONS_MANAGER is
			-- Event handler for combo box selection end
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	destroy_actions: ACTIONS_MANAGER is
			-- Event handler for destroy actions 
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	draw_item_actions: ACTIONS_MANAGER is
			-- Event handler for draw item events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	enter_actions: ACTIONS_MANAGER is
			-- Event handler for enter events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	expose_actions: ACTIONS_MANAGER is
			-- Event handler for expose events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	extended_actions: ACTIONS_MANAGER is
			-- Event handler for extended events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end;

	filter_actions: ACTIONS_MANAGER is
			-- Event handler for filter events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	focus_out_actions: ACTIONS_MANAGER is
			-- Event handler for focus out events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	focus_in_actions: ACTIONS_MANAGER is
			-- Event handler for focus in events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	help_actions: ACTIONS_MANAGER is
			-- Event handler for help events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	init_d_actions: ACTIONS_MANAGER is
			-- Event handler for initialise dialog events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	key_press_actions: ACTIONS_MANAGER is
			-- Event handler for key press events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	key_release_actions: ACTIONS_MANAGER is
			-- Event handler for key release events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	leave_actions: ACTIONS_MANAGER is
			-- Event handler for leave events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	menu_select_actions: ACTIONS_MANAGER is
			-- Event handler for menu selection events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	multiple_actions: ACTIONS_MANAGER is
			-- Event handler for multiple selection events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	ok_actions: ACTIONS_MANAGER is
			-- Event handler for ok events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	pointer_motion_actions: ACTIONS_MANAGER is
			-- Event handler for pointer events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	resize_actions: ACTIONS_MANAGER is
			-- Event handler for resize events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	selection_change_actions: ACTIONS_MANAGER is
			-- Event handler for list events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	default_actions: ACTIONS_MANAGER is
			-- Event handler for scrollable list default events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	single_actions: ACTIONS_MANAGER is
			-- Event handler for single events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	timer_actions: ACTIONS_MANAGER is
			-- Event handler for timer events
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	toggle_value_changed_actions: ACTIONS_MANAGER is
			-- Event handler for value changed events on toggle buttons
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	value_changed_actions: ACTIONS_MANAGER is
			-- Event handler for value changed events on scrollbars
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	move_actions: ACTIONS_MANAGER is
			-- Event handler for move events (scrollbars)
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	vertical_move_actions: ACTIONS_MANAGER is
			-- Event handler for vertical move
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	horizontal_move_actions: ACTIONS_MANAGER is
			-- Event handler for horizontal move
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	modify_actions: ACTIONS_MANAGER is
			-- Event handler for modifying text
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	motion_actions: ACTIONS_MANAGER is
			-- Event handler for a motion in a text
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	release_actions: ACTIONS_MANAGER is
			-- Event handler for a button release
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	visible_actions: ACTIONS_MANAGER is
			-- Event handler for a visible event
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	map_actions: ACTIONS_MANAGER is
			-- Event handler for a mapping event.
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	unmap_actions: ACTIONS_MANAGER is
			-- Event handler for an unmapping event.
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	replace_actions: ACTIONS_MANAGER is
			-- Event handler for a replace event on
			-- a serach replace dialog.
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	find_actions: ACTIONS_MANAGER is
			-- Event handler for a find event on
			-- a search replace dialog.
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	cancel_actions: ACTIONS_MANAGER is
			-- Event handler for a cancel event on
			-- a search replace dialog
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	replace_all_actions: ACTIONS_MANAGER is
			-- Event handler for a replace all event on
			-- a search replace dialog
		once
			create Result.make
		ensure
			result_exists: Result /= Void
		end

	system_metrics: WEL_SYSTEM_METRICS is
			-- All the system metrics
		once
			create Result
		ensure
			result_exists: Result /= Void
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




end -- class G_ANY_IMP

