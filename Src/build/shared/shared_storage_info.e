indexing
	description: "Storage information."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class SHARED_STORAGE_INFO

inherit
	SHARED_EVENTS

	SHARED_PREDEF_COMS

feature {NONE}

	for_import: BOOLEAN_REF is
		once
			create Result
		end

-- ***********
-- Regenerated
-- ***********

	command_table: INT_H_TABLE [USER_CMD] is
		once
			create Result.make (50)
		end

	command_instance_table: INT_H_TABLE [CMD_INSTANCE] is
		once
			create Result.make (50)
		end

	behavior_table: INT_H_TABLE [BEHAVIOR] is
		once
			create Result.make (50)
		end

	context_table: INT_H_TABLE [CONTEXT] is
		once
			create Result.make (50)
		end

	state_table: INT_H_TABLE [BUILD_STATE] is
		once
			create Result.make (50)
		end

	circle_table: INT_H_TABLE [STATE_CIRCLE] is
		once
			create Result.make (50)
		end

--	translation_table: INT_H_TABLE [TRANSLATION] is
--		once
--			create Result.make (50)
--		end

	clear_shared_storage_info is
		do
			command_instance_table.clear_all
			behavior_table.clear_all
			command_table.clear_all
			context_table.clear_all
			state_table.clear_all
			circle_table.clear_all
--			translation_table.clear_all
		end

-- ********
-- Immuable
-- ********

	predefined_command_table: INT_H_TABLE [PREDEF_CMD] is
		once
			create Result.make (100)
			insert_commands
		end

	context_type_table: INT_H_TABLE [CONTEXT_TYPE [CONTEXT]] is
		once
			create Result.make (100)
		end

	event_table: INT_H_TABLE [EVENT] is
		once
			create Result.make (30)
			insert_events
		end

	insert_events is
		do
			if change_ev = Void then end
			if click_ev = Void then end
			if close_ev = Void then end
			if column_click_ev = Void then end
			if destroy_ev = Void then end
			if double_click_ev = Void then end
			if enter_notify_ev = Void then end
			if get_focus_ev = Void then end
			if key_press_ev = Void then end
			if key_release_ev = Void then end
			if leave_notify_ev = Void then end
			if lose_focus_ev = Void then end
			if motion_notify_ev = Void then end
			if mouse1_dbl_click_ev = Void then end
			if mouse1_motion_ev = Void then end
			if mouse1_press_ev = Void then end
			if mouse1_release_ev = Void then end
			if mouse2_dbl_click_ev = Void then end
			if mouse2_motion_ev = Void then end
			if mouse2_press_ev = Void then end
			if mouse2_release_ev = Void then end
			if mouse3_dbl_click_ev = Void then end
			if mouse3_motion_ev = Void then end
			if mouse3_press_ev = Void then end
			if mouse3_release_ev = Void then end
			if move_ev = Void then end
			if paint_ev = Void then end
			if resize_ev = Void then end
			if return_ev = Void then end
			if select_ev = Void then end
			if selection_ev = Void then end
			if subtree_ev = Void then end
			if switch_ev = Void then end
			if toggle_ev = Void then end
			if unselect_ev = Void then end
--			if insert_ev = Void then end
--			if delete_ev = Void then end
		end

	insert_commands is
		do
			if command_cmd = Void then end
			if open_cmd = Void then end
			if popdown_cmd = Void then end
			if popup_cmd = Void then end
			if save_cmd = Void then end
			if new_cmd = Void then end
			if undoable_cmd = Void then end
			if open_window_cmd = Void then end
			if close_window_cmd = Void then end
			if minimize_window_cmd = Void then end
			if maximize_window_cmd = Void then end
			if restore_window_cmd = Void then end
			if reset_to_empty_cmd = Void then end
--			if reset_to_zero_cmd = Void then end
			if clear_cmd = Void then end
		end

end -- class SHARED_STORAGE_INFO

