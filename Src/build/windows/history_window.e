
class HISTORY_WND 

inherit

	HISTORY;
	FORM_D
		rename
			make as form_d_make
		export
			{NONE} all;
			{ANY} is_popped_up, popup, popdown
		undefine
			init_toolkit
		end;
	WIDGET_NAMES;
	COMMAND;
	CONSTANTS;
	COMMAND_ARGS
	WINDOWS;

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

	set_unsaved_application is
		do
			saved_application := False;
			last_command_saved := Void;
		end;

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

	history_count: INTEGER is 5;

	record (cmd: like item) is
			-- Put `cmd' in history list
			-- and highlight the corresponding
			-- item. Remove all commands bellow.
		local
			cut_cmd: CONTEXT_CUT_CMD;
			grp_cmd: GROUP_CMD
		do
			remove_tail;
			if history_list.count = history_count then
				history_list.start;
					-- Special case (destroy widgets)
				cut_cmd ?= history_list.item;
				grp_cmd ?= history_list.item;
				if cut_cmd /= Void then
					cut_cmd.destroy_widgets
				elseif grp_cmd /= Void then
					grp_cmd.destroy_widgets
				end;
				list.start;
				list.remove;
				list.finish;
				history_list.remove;
				history_list.finish
			end;
			history_list.put_right (cmd);
			history_list.forth;
			if cmd.n_ame /= Void then
				list.put_right (cmd.n_ame);
			else
				list.put_right ("Unknown command");
			end;
			list.forth;
			saved_application := False;
			select_item
		end;

	
feature {NONE}

	remove_tail is
		local
			create_cont: CONTEXT_CREATE_CMD
		do
			if (not history_list.islast) and then
				(not history_list.empty)
			then
				from
					list.forth
					history_list.forth
				until
					history_list.after
				loop
					create_cont ?= history_list.item;
					if create_cont /= Void then
						create_cont.destroy_widgets
					end;
					list.remove;
					history_list.remove
				end;
				history_list.back;
				list.back;
			end
		end;
	
feature 

	wipe_out is
			-- Empty the history list
		do
			if not history_list.empty then
				if history_list.last = last_command_saved then
					last_command_saved := Void;
				end;
				list.wipe_out;
				history_list.wipe_out;
			end
		end;

	history_list: TWO_WAY_LIST [like item];

	select_item is
			-- Select current element in the list
		do
			list.select_item;
			list.scroll_to_current
		end;

--************
-- EGL section
--************

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create history window.
		do
				-----------------
				-- Create widgets
				-----------------
			form_d_make (a_name, a_parent);
			!!list.make (L_ist, Current);
			!!row_column.make (R_ow_column, Current);
			!!undo_button.make ("Undo", row_column);
			!!redo_button.make ("Redo", row_column);

				----------------------
				-- Perform attachments
				----------------------
			attach_top (list, 0);
			attach_left (list, 0);
			attach_right (list, 0);
			attach_bottom (row_column, 0);
			attach_left (row_column, 0);
			attach_right (row_column, 0);
			attach_bottom_widget (row_column, list, 0);

				-----------------
				-- Set properties
				-----------------
			list.set_single_selection;
			row_column.set_row_layout;

			undo_button.add_activate_action (Current, First);
			redo_button.add_activate_action (Current, Second);
			list.add_single_action (Current, Fourth);
			!!history_list.make;
			saved_application := True;

			list.set_visible_item_count (10);
			set_title (a_name);
		end;

	
feature {NONE}

	list: SCROLL_LIST;
	row_column: ROW_COLUMN;
	undo_button: PUSH_B;
	redo_button: PUSH_B;

	execute (argument: ANY) is
		do
			if argument = First then
				back
			elseif argument = Second then
				forth
			elseif argument = Fourth then
				play
			end
		end;

end
