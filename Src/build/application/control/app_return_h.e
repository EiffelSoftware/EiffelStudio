
class APP_RETURN_H 

inherit

	ICON_HOLE
		redefine
			stone, compatible
		end;
	PIXMAPS
		export
			{NONE} all
		end;
	LABELS
		export
			{NONE} all
		end

creation

	make
	
feature 

	make (editor: APP_EDITOR) is
			-- Create a return hole.
		do
			set_symbol (Return_pixmap);
			set_label (Return_label);
		end;
	
feature {NONE}

	stone: LABEL_SCR_L;
			-- Stone that Current will accept.

	compatible (s: LABEL_SCR_L): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	process_stone is
			-- Set the return transition to the dropped stone. 
		local
			set_return_command: APP_SET_RETURN;
		do
			!!set_return_command;
			set_return_command.execute (stone.label);
		end;

end 
