
class SHARED_STORAGE_INFO

feature {NONE}

	for_import: BOOLEAN_REF is
		once
			!! Result
		end;

	for_save: BOOLEAN_REF is
		once
			!! Result
		end;

-- ***********
-- Regenerated
-- ***********
	name_changed_table: HASH_TABLE [STRING, STRING] is
		once
			!!Result.make (100);
		end;

	identifier_changed_table: HASH_TABLE [INTEGER, STRING] is
		once
			!!Result.make (100);
		end;

	command_table: INT_H_TABLE [USER_CMD] is
		once
			!!Result.make (100)
		end;

	context_table: INT_H_TABLE [CONTEXT] is
		once
			!!Result.make (100)
		end;

	state_table: INT_H_TABLE [STATE] is
		once
			!!Result.make (100);
		end;

	circle_table: INT_H_TABLE [STATE_CIRCLE] is
		once
			!!Result.make (100);
		end;

	translation_table: INT_H_TABLE [TRANSLATION] is
		once
			!!Result.make (100);
		end;

	clear_all is
		do
			command_table.clear_all;
			context_table.clear_all;
			state_table.clear_all;
			circle_table.clear_all;
			translation_table.clear_all;
			name_changed_table.clear_all;
			identifier_changed_table.clear_all;
		end;

	clear_uneeded is
		do
			command_table.clear_all;
			state_table.clear_all;
			circle_table.clear_all;
			translation_table.clear_all;
			name_changed_table.clear_all;
			identifier_changed_table.clear_all;
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
		local
			but_act_ev: BUT_ACT_EV;
			but_arm_ev: BUT_ARM_EV;
			but_rel_ev: BUT_REL_EV;
			expose_ev: EXPOSE_EV;
			input_ev: INPUT_EV;
			key_press_ev: KEY_PRESS_EV;
			key_release_ev: KEY_RELEASE_EV;
			mouse1d_ev: MOUSE1D_EV;
			mouse1u_ev: MOUSE1U_EV;
			mouse2d_ev: MOUSE2D_EV;
			mouse2u_ev: MOUSE2U_EV;
			mouse3d_ev: MOUSE3D_EV;
			mouse3u_ev: MOUSE3U_EV;
			mouse_enter_ev: MOUSE_ENTER_EV;
			mouse_leave_ev: MOUSE_LEAVE_EV;
			mouse_mot1_ev: MOUSE_MOT1_EV;
			mouse_mot2_ev: MOUSE_MOT2_EV;
			mouse_mot3_ev: MOUSE_MOT3_EV;
			move_ev: MOVE_EV;
			pointer_motion_ev: POINTER_MOTION_EV;
			resize_ev: RESIZE_EV;
			selection_ev: SELECTION_EV;
			text_modified_ev: TEXT_MODIFIED_EV;
			text_motion_ev: TEXT_MOTION_EV;
			value_changed_ev: VALUE_CHANGED_EV;
			widget_dest_ev: WIDGET_DEST_EV;
			key_ret_ev: KEY_RET_EV;
		do
			!!but_act_ev.make;
			!!but_arm_ev.make;
			!!but_rel_ev.make;
			!!expose_ev.make;
			!!input_ev.make;
			!!key_press_ev.make;
			!!key_release_ev.make;
			!!mouse1d_ev.make;
			!!mouse1u_ev.make;
			!!mouse2d_ev.make;
			!!mouse2u_ev.make;
			!!mouse3d_ev.make;
			!!mouse3u_ev.make;
			!!mouse_enter_ev.make;
			!!mouse_leave_ev.make;
			!!mouse_mot1_ev.make;
			!!mouse_mot2_ev.make;
			!!mouse_mot3_ev.make;
			!!move_ev.make;
			!!pointer_motion_ev.make;
			!!resize_ev.make;
			!!selection_ev.make;
			!!text_modified_ev.make;
			!!text_motion_ev.make;
			!!value_changed_ev.make;
			!!widget_dest_ev.make;
			!!key_ret_ev.make;
		end;

	insert_commands is
		local
			command_cmd: COMMAND_CMD;
			open_cmd: OPEN_CMD;
			popdown_cmd: POPDOWN_CMD;
			popup_cmd: POPUP_CMD;
			save_cmd: SAVE_CMD;
			undoable_cmd: UNDOABLE_CMD;
		do
			!!command_cmd.make;
			!!open_cmd.make;
			!!popdown_cmd.make;
			!!popup_cmd.make;
			!!save_cmd.make;
			!!undoable_cmd.make;
		end;

end

