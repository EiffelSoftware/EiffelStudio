deferred class PROJECT_WINDOW

inherit

	FILE_SEL_D
		rename
			make as file_sel_d_create
		end;
	COMMAND
		export
			{NONE} all
		end;
	COMMAND_ARGS
		export
			{NONE} all
		end;

feature
	
	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			file_sel_d_create (a_name, a_parent);
			hide_help_button;
			add_ok_action (Current, First);
			add_cancel_action (Current, Second);
			set_exclusive_grab;
			set_directory_selection;
			hide_file_selection_list;
			hide_file_selection_label;
		end;

feature {NONE}

	execute (argument: ANY) is
		do
			if (argument = First) then
				if (not selected_file.empty or not directory.empty) then
					popdown;
					ok_pressed;
				end;
			elseif (argument = Second) then
				popdown;
			end;
		end;

	ok_pressed is
			--Perform actions when ok is pressed.
		deferred
		end

end

