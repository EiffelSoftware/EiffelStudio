
class HISTORY_WND 

inherit

	HISTORY;
	TOP_SHELL
		rename
			make as shell_make,
			show as shell_show,
			hide as shell_hide
		end;
	COMMAND;
	CONSTANTS;
	COMMAND_ARGS
	WINDOWS;
	CLOSEABLE

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

	History_count: INTEGER is 10;

	record (cmd: like item) is
			-- Put `cmd' in history list
			-- and highlight the corresponding
			-- item. Remove all commands bellow.
		local
			cut_cmd: CONTEXT_CUT_CMD;
			grp_cmd: GROUP_CMD
		do
			remove_tail;
			if history_list.count = History_count then
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
			list.put_right (cmd.n_ame);
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

feature -- Interface

	close is
		do
			main_panel.history_t.set_toggle_off
			unrealize;
		end;

	hide is
		do
			close
		end;

	show is
		do
			set_initial_position
			realize
		end;

	make (a_screen: SCREEN) is
			-- Create history window.
		local
			close_b: CLOSE_WINDOW_BUTTON;
			del_com: DELETE_WINDOW;
			focus_label: FOCUS_LABEL;
			form: FORM
		do
				-----------------
				-- Create widgets
				-----------------
			shell_make (Widget_names.history_window, a_screen);
			!! form.make (Widget_names.form, Current);
			!! focus_label.make (form);
			!! list.make (Widget_names.list, form);
			!! row_column.make (Widget_names.row_column, form);
			!! undo_button.make (Widget_names.undo_label, row_column);
			!! redo_button.make (Widget_names.redo_label, row_column);
			!! close_b.make (Current, form, focus_label);

				----------------------
				-- Perform attachments
				----------------------
			form.attach_top (focus_label, 5);
			form.attach_left (focus_label, 0);
			form.attach_right_widget (close_b, focus_label, 0);
			form.attach_right (close_b, 0);
			form.attach_top_widget (focus_label, list, 2);
			form.attach_top_widget (close_b, list, 2);
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
			list.add_single_action (Current, Fourth);
			!!history_list.make;
			saved_application := True;

			list.set_visible_item_count (10);
			set_title (Widget_names.history_window);
			!! del_com.make (Current);
			set_delete_command (del_com);
			set_initial_position;
		end;

	set_initial_position is	
		do
			set_x_y (main_panel.base.x + main_panel.base.width // 2
				- width // 2,
				main_panel.base.y)
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
