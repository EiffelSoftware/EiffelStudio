
deferred class CMD_ADD 

inherit

	CMD_COMMAND

feature {NONE}

	element: STONE;

	list: LINKED_LIST [STONE] is
		deferred
		end; 

feature 

	set_element (s: STONE) is
		do
			element := s
		end;

	undo is
		do
			edited_command.save_old_template;
			list.finish;
			list.remove;
			edited_command.update_text;
		end; -- undo

feature {NONE}

	command_work is
		do
			edited_command.save_old_template;
			list.extend (element);
			edited_command.update_text;
		end; 

	worked_on: STRING is
		do
			!!Result.make (0);
			Result.append (element.label);
		end;

end
