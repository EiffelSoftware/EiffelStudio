
class SHARED_STORAGE_INFO

inherit

	SHARED_EVENTS;
	SHARED_PREDEF_COMS;

feature {NONE}

	for_import: BOOLEAN_REF is
		once
			!! Result
		end;

-- ***********
-- Regenerated
-- ***********

	command_table: INT_H_TABLE [USER_CMD] is
		once
			!!Result.make (50)
		end;

	command_instance_table: INT_H_TABLE [CMD_INSTANCE] is
		once
			!!Result.make (50)
		end;

	behavior_table: INT_H_TABLE [BEHAVIOR] is
		once
			!!Result.make (50)
		end;

	context_table: INT_H_TABLE [CONTEXT] is
		once
			!!Result.make (50)
		end;

	state_table: INT_H_TABLE [BUILD_STATE] is
		once
			!!Result.make (50);
		end;

	circle_table: INT_H_TABLE [STATE_CIRCLE] is
		once
			!!Result.make (50);
		end;

	translation_table: INT_H_TABLE [TRANSLATION] is
		once
			!!Result.make (50);
		end;

	clear_shared_storage_info is
		do
			command_instance_table.clear_all;
			behavior_table.clear_all;
			command_table.clear_all;
			context_table.clear_all;
			state_table.clear_all;
			circle_table.clear_all;
			translation_table.clear_all;
		end;

-- ********
-- Immuable
-- ********

	predefined_command_table: INT_H_TABLE [PREDEF_CMD] is
		once
			!!Result.make (100);
			insert_commands;
		end;

	context_type_table: INT_H_TABLE [CONTEXT_TYPE] is
		once
			!!Result.make (100)
		end;

	event_table: INT_H_TABLE [EVENT] is
		once
			!!Result.make (30);
			insert_events;
		end;

	insert_events is
		do
			if but_act_ev = Void then end;
			if but_arm_ev = Void then end;
			if but_rel_ev = Void then end;
			if expose_ev = Void then end;
			if input_ev = Void then end;
			if key_press_ev = Void then end;
			if key_release_ev = Void then end;
			if mouse1d_ev = Void then end;
			if mouse1u_ev = Void then end;
			if mouse2d_ev = Void then end;
			if mouse2u_ev = Void then end;
			if mouse3d_ev = Void then end;
			if mouse3u_ev = Void then end;
			if mouse_enter_ev = Void then end;
			if mouse_leave_ev = Void then end;
			if mouse_motion1_ev = Void then end;
			if mouse_motion2_ev = Void then end;
			if mouse_motion3_ev = Void then end;
			if move_ev = Void then end;
			if pointer_motion_ev = Void then end;
			if resize_ev = Void then end;
			if selection_ev = Void then end;
			if text_modify_ev = Void then end;
			if text_motion_ev = Void then end;
			if value_changed_ev = Void then end;
			if widget_destroy_ev = Void then end;
			if key_return_ev = Void then end;
		end;

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
			if close_window_cmd = Void then	end
			if minimize_window_cmd = Void then end
			if maximize_window_cmd = Void then end
			if restore_window_cmd = Void then end
			if reset_to_empty_cmd = Void then end
			if reset_to_zero_cmd = Void then end
			if clear_cmd = Void then end
		end;

end

