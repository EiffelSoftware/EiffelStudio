
class APP_INIT_ST_H 	

inherit

	APP_EDITOR_HOLE
		redefine
			process_state
		end

creation

	make
	
feature {NONE}

	symbol: PIXMAP is
		do
			Result := Pixmaps.initial_state_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.initial_state_label
		end;
	
feature {NONE}

	stone_type: INTEGER is
		do
			Result := Stone_types.state_type
		end;

	process_state (dropped: STATE_STONE) is
			-- Update the initial state of the application editor
			-- with stone droppped. 
		local
			set_initial_state_command: APP_SET_INIT_STATE;
		do
			!!set_initial_state_command;
			set_initial_state_command.execute (dropped.data);
		end; -- process_stone

end
