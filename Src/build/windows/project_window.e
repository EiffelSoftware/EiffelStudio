deferred class PROJECT_WINDOW

inherit

	FILE_SEL_D
		rename
			make as file_sel_d_create,
			popup as file_sel_d_popup,
			init_toolkit as file_sel_d_init_toolkit
		end;
	COMMAND;
	COMMAND_ARGS;
	CLOSEABLE;
	CONSTANTS

feature {NONE}

	last_cwd: STRING is
		once
			!! Result.make (0);
		end

	close is
		do
			last_cwd.wipe_out;
			last_cwd.append (clone (directory));
			destroy;
		end;

	title_name: STRING is
		deferred
		end;

	make (a_parent: COMPOSITE) is
		local
			del_window: DELETE_WINDOW;
			mp: MOUSE_PTR;
			set_dialog_att: SET_DIALOG_ATTRIBUTES_COM
		do
			!! mp;
			mp.set_watch_shape;
			file_sel_d_create (title_name, a_parent);
			set_title (title_name);
			hide_help_button;
			add_ok_action (Current, First);
			add_cancel_action (Current, Second);
			set_exclusive_grab;
			set_directory_selection;
			hide_file_selection_list;
			hide_file_selection_label;
			dialog_command_target;
			!! set_dialog_att;
			set_dialog_att.execute (Current);
			!! del_window.make (Current);
			set_action ("<Unmap>", del_window, Void);
			widget_command_target;
			mp.restore;
		end;

	execute (argument: ANY) is
		do
			if (argument = First) then
				if (not selected_file.empty or not directory.empty) then
					popdown;
					ok_pressed;
					close
				end;
			elseif (argument = Second) then
				popdown;
				close;
			end;
		end;

	ok_pressed is
			--Perform actions when ok is pressed.
		deferred
		end

feature

	popup is
		do
			if not last_cwd.empty then
				set_directory (last_cwd);
			end;
			file_sel_d_popup
		end;
	
end

