
deferred class CMD_ADD 

inherit

	CMD_COMMAND
		redefine
			current_command
		end
	
feature {NONE}

	current_command: USER_CMD;

	element: STONE;

	icon_box: ICON_BOX [STONE] is
		deferred
		end;
	
feature 

	redo is
		do
			icon_box.add (element);
			command_editor.update_text
		end; -- redo

	undo is
		do
			icon_box.finish;
			icon_box.remove;
			command_editor.update_text;
		end; -- undo

	
feature {NONE}

	command_work is
		do
			icon_box.finish;
			element := icon_box.item;
			update_history
		end; 

	worked_on: STRING is
		do
			!!Result.make (0);
			Result.append (element.label);
		end;

end
