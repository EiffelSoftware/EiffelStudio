
class APP_INIT_ST_H 	

inherit

	APP_EDITOR_HOLE
		redefine
			stone, compatible
		end;
	LABELS

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

	stone: STATE_STONE;

	compatible (s: STATE_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	process_stone is
			-- Update the initial state of the application editor
			-- with stone droppped. 
		local
			set_initial_state_command: APP_SET_INIT_STATE;
		do
			!!set_initial_state_command;
			set_initial_state_command.execute (stone.original_stone);
		end; -- process_stone

end
