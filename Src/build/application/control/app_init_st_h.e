
class APP_INIT_ST_H 	

inherit

	ICON_HOLE
		redefine
			stone
		end;
	LABELS
		export
			{NONE} all
		end;
	PIXMAPS
		export
			{NONE} all
		end

creation

	make
	
feature -- Creation

	make (editor: APP_EDITOR) is
			-- Create a init_state_h.
		do
			set_symbol (Initial_state_pixmap);
			set_label (Initial_state_label);
		end; -- Create
	
feature {NONE}

	stone: STATE_STONE;

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
