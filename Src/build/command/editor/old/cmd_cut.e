
deferred class CMD_CUT 

inherit

	CMD_COMMAND
		redefine
			current_command
		end

 
	
	
feature {NONE}

	current_command: USER_CMD;

	position: INTEGER;
			-- Position of the removed element

	element: STONE; 

	icon_box: ICON_BOX [STONE] is
		deferred
		end;

	
feature 

	redo is
		do
			icon_box.go_i_th (position);
			if
				icon_box.item = element
			then
				icon_box.remove;
				command_editor.update_text
			end;
		end; -- redo

	undo is
		do
			if
				position = 1 and icon_box.empty
			then
				icon_box.add (element)
			else
				icon_box.go_i_th (position - 1);
				icon_box.add_right (element);
			end;
			command_editor.update_text
		end; -- undo

	
feature {NONE}

	command_work is
		do
			position := icon_box.index;
			element := icon_box.item;
			update_history
		end; 

	worked_on: STRING is
		do
		end; -- worked_on

end
