
deferred class CMD_CUT 

inherit

	CMD_COMMAND
	
feature {NONE}

	index: INTEGER;
			-- Index of the removed element

	element: STONE; 

	list: LINKED_LIST [STONE] is
		deferred
		end;
	
feature 

	set_index (i: INTEGER) is
		do
			index := i
		end;

	undo is
		do
			edited_command.save_old_template;
			if
				index = 1 and list.empty
			then
				list.extend (element)
			else
				list.go_i_th (index - 1);
				list.add_right (element);
			end;
			edited_command.update_text
		end; -- undo

	
feature {NONE}

	command_work is
		do
			edited_command.save_old_template;
			list.go_i_th (index);
			element := list.item;
			list.remove;
			edited_command.update_text
		end; 

	worked_on: STRING is
		do
		end; -- worked_on

end
