
class APP_INIT_ST_H 	

inherit

	APP_EDITOR_HOLE
        rename
            make as parent_make
		redefine
			process_state
		end

creation

	make
	
feature {NONE}

    make (a_parent: COMPOSITE) is
        do
            parent_make (a_parent)
            set_focus_string (Focus_labels.initial_state_label)
        end

	symbol: PIXMAP is
		do
			Result := Pixmaps.initial_state_pixmap
		end;

-- samik	focus_string: STRING is
-- samik		do
-- samik			Result := Focus_labels.initial_state_label
-- samik		end;
	
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
