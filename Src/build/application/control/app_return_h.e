
class APP_RETURN_H 

inherit

	APP_EDITOR_HOLE
		redefine
			process_label
		end

creation

	make
	
feature {NONE}

	symbol: PIXMAP is
		do
			Result := Pixmaps.return_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.return_label
		end;
	
feature {NONE}

	stone_type: INTEGER is
		do
			Result := Stone_types.label_type
		end;

	process_label (dropped: LABEL_STONE) is
			-- Set the return transition to the dropped stone. 
		local
			set_return_command: APP_SET_RETURN;
		do
			!!set_return_command;
			set_return_command.execute (dropped.data.label);
		end;

end 
