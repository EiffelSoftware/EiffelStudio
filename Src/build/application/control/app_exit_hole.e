
class APP_EXIT_HOLE 

inherit

	ICON_HOLE
		redefine
			stone, compatible
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

	make is
			-- Create a self_hole.
		do
			set_label (Exit_label);
			set_symbol (Exit_pixmap);
		end; -- Create

feature {NONE}

	stone: LABEL_SCR_L;
			-- Transition list
	compatible (s: LABEL_SCR_L): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;
	
	process_stone is
			-- Set exit label.
		local
			set_exit_command: APP_SET_EXIT;
		do
			!!set_exit_command;
			set_exit_command.execute (stone.label)
		end; 

end 
