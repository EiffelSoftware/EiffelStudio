
class HISTORY_WND 

inherit

	HISTORY
		export
			{NONE} all
		end;

	TOP_SHELL
		rename
			make as top_shell_create
		export
			{NONE} all;
			{ANY} hide, show, shown, realize, realized
		undefine
			init_toolkit
		end;

	WIDGET_NAMES
		export
			{NONE} all
		end;

	COMMAND
		export
			{NONE} all
		end;

	COMMAND_ARGS
		export
			{NONE} all
		end;

	WINDOWS
		export
			{NONE} all
		end;

	WARN_POPUPER
		export
			{NONE} all
		undefine
			continue_after_popdown
		end


creation

	make

	
feature 

	item: UNDOABLE is
			-- Current command in the history window
		require
			not_off: not history_list.off
		do
			Result := history_list.item
		end;

	before: BOOLEAN is
			-- Is history list offleft?
		do
			Result := history_list.before
		end;

	
feature {NONE}

	play_stopped: BOOLEAN;
			-- Has play been stopped because of an undo 
			-- or redo not allowed in the current context?

	last_command_saved: UNDOABLE;
			-- Last command saved

feature 

	saved_application: BOOLEAN;
			-- Has the application been saved?

	set_saved_application is
			-- Set saved_application to True.
		do
			saved_application := True;
			if list.selected_item /= Void then
				last_command_saved := history_list.last;
			else
				last_command_saved := Void
			end;
		end;

	forth is
			-- Move forward in history list
			-- and select new current item.
		do
			if not (list.after or list.islast) then
				history_list.forth;
				list.forth;
				select_item;
				if history_list.item = last_command_saved then
					saved_application := True
				else
					saved_application := False
				end;
				item.redo;
			end
		end;

	back is
			-- Move back in history list
			-- and select current item.
		do
			if not list.off then
				item.undo;
				history_list.back;
				list.back;
				if 
					(history_list.before and last_command_saved = Void) 
					or ((not history_list.before) 
						and (history_list.item = last_command_saved))
				then
					saved_application := True
				else
					saved_application := False
				end;
				if list.before then
					list.deselect_item
				else
					select_item;
				end
			end
		end;

	
feature {NONE}

	play is
			-- Redo or undo a sequence of commands.
		local
			offset, i: INTEGER
		do
			offset := list.selected_position - list.index;
			if list.selected_position = 0 then
				select_item;
			elseif offset > 0 then
				from
					i := offset 
				until
					i <= 0 or play_stopped
				loop
					forth;
					i := i - 1
				end
			else
				from
					i := offset
				until
					i >= 0 or play_stopped
				loop
					back;
					i := i + 1
				end
			end
		end;

	
feature 

	record (cmd: like item) is
			-- Put `cmd' in history list
			-- and highlight the corresponding
			-- item. Remove all commands bellow.
		do
			history_list.add_right (cmd);
			history_list.forth;
			if cmd.n_ame /= Void then
				list.add_right (cmd.n_ame);
			else
				list.add_right ("Unknown command");
			end;
			list.forth;
			saved_application := False;
			remove_tail;
			select_item
		end;

	
feature {NONE}

	remove_tail is
		local
			pos: INTEGER
		do
			pos := history_list.index;
			if (history_list.count - pos) /= 0 then
				from
					history_list.forth;
					if not list.after then
						list.remove_right (history_list.count - pos);
					end;
				until
					history_list.after
				loop
					history_list.remove
				end;
				history_list.go_i_th (pos);
				list.go_i_th (pos);
			end;
		end;

	
feature 

	wipe_out is
			-- Empty the history list
		do
			if history_list.last = last_command_saved then
				last_command_saved := Void;
			end;
			list.wipe_out;
			history_list.wipe_out
		end;

	history_list: TWO_WAY_LIST [like item];

	set_history_list (hl: like history_list) is
		local
			pos: INTEGER;
			temp_list: LINKED_LIST [STRING]
		do
			history_list := hl;
			list.wipe_out;
			from
				pos := history_list.index;
				history_list.start;
				!!temp_list.make;
			until
				history_list.after
			loop
				temp_list.add_right (history_list.item.n_ame);
				temp_list.forth;
				history_list.forth
			end;
			history_list.go_i_th (pos);
			list.merge_right (temp_list);
			list.go_i_th (pos);
			if not list.off then
				select_item;
			end
		end;

	select_item is
			-- Select current element in the list
		do
			list.select_item;
			list.scroll_to_current
		end;

--************
-- EGL section
--************

	make (a_name: STRING; a_screen: SCREEN) is
			-- Create history window.
		local
			contin_command: ITER_COMMAND;
		do
				-----------------
				-- Create widgets
				-----------------
			top_shell_Create (a_name, a_screen);
			!!form.make (F_orm, Current);
			!!list.make (L_ist, form);
			!!row_column.make (R_ow_column, form);
			!!undo_button.make ("Undo", row_column);
			!!redo_button.make ("Redo", row_column);
			!!forget_button.make ("Forget", row_column);

				----------------------
				-- Perform attachments
				----------------------
			form.attach_top (list, 0);
			form.attach_left (list, 0);
			form.attach_right (list, 0);
			form.attach_bottom (row_column, 0);
			form.attach_left (row_column, 0);
			form.attach_right (row_column, 0);
			form.attach_bottom_widget (row_column, list, 0);

				-----------------
				-- Set properties
				-----------------
            list.set_single_selection;
			row_column.set_row_layout;

			undo_button.add_activate_action (Current, First);
			redo_button.add_activate_action (Current, Second);
			forget_button.add_activate_action (Current, Third);
			list.add_single_action (Current, Fourth);
			!!history_list.make;
			saved_application := True;

			!!contin_command;
			set_delete_command (contin_command);
		end;

	
feature {NONE}

	form: FORM;
	list: SCROLL_LIST;
	row_column: ROW_COLUMN;
	undo_button: PUSH_B;
	redo_button: PUSH_B;
	forget_button: PUSH_B;

	execute (argument: ANY) is
		do
			if argument = First then
				back
			elseif argument = Second then
				forth
			elseif argument = Third then
				if not list.empty then
					warning_box.popup (Current, "Do you really want to%N%
												% erase the history?");
				end
			elseif argument = Fourth then
				play
			end
		end;

	continue_after_popdown (box: ERROR_BOX; ok: BOOLEAN) is
		do
			if ok then
				wipe_out
			end;
		end;

end
