
class APP_SET_INIT_STATE 

inherit

	APP_COMMAND; 
	SHARED_APPLICATION;
	APP_CMD_NAMES
		rename
			App_set_initial_state_cmd_name as c_name
		end

feature 

	undo is 
		do 
			application_editor.set_initial_state (old_init_state);
			perform_update_display;
		end; -- undo

feature {NONE}

	old_init_state: STATE;

	init_state: STATE;

	work (a_state: STATE) is
		do
			init_state := a_state;
			old_init_state := application_editor.initial_state_circle.original_stone;
			if not (init_state = old_init_state) then
				do_specific_work;
				update_history
			end
		end; 

	do_specific_work is
			-- Set the initial_circle.
		do
			application_editor.set_initial_state (init_state);
			perform_update_display
		end;

	update_display is
		do
			application_editor.draw_figures
		end;

	worked_on: STRING is
		do
			!!Result.make (0);
			Result.append (init_state.label);
		end;

end
