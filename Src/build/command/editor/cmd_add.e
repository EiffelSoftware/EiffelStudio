
deferred class CMD_ADD 

inherit

	CMD_COMMAND

feature {NONE}

	element: DATA;

	list: LINKED_LIST [DATA] is
		deferred
		end; 

feature 

	set_element (s: DATA) is
		do
			element := s
		end;

	undo is
		do
			edited_command.save_old_template;
			list.finish;
			list.remove;
			update_information
		end; -- undo

	update_information is
		do
			edited_command.update_text;
		end;

feature {NONE}

	command_work is
		do
			edited_command.save_old_template;
			list.extend (element);
			update_information
		end; 

	worked_on: STRING is
		do
			!!Result.make (0);
			if element /= Void then
					Result.append (element.label);
			end
		end;

end
