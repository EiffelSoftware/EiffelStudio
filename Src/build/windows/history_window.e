indexing
	description: "History window: list all the actions in order to %
				%undo or redo them."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class HISTORY_WINDOW 

inherit
	EV_HISTORY

	EB_WINDOW
		redefine
			make, show, set_geometry
		end

	EV_COMMAND

	WINDOWS

	CLOSEABLE

creation
	make

feature {NONE} -- Initialization

	make (par: EV_WINDOW) is
			-- Create history window.
		local
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			fix: EV_FIXED
		do
			{EB_WINDOW} Precursor (par)
			create vbox.make (Current)

			create list.make_with_size (vbox, 2)
			create hbox.make (vbox)
			hbox.set_expand (False)

			create fix.make (hbox)
			create undo_button.make (hbox)
			create redo_button.make (hbox)
			set_values
			set_callbacks
			set_properties
		end


	set_values is
			-- Set values for GUI elements.
		do
 			set_title (Widget_names.history_window)
 			set_initial_position
			list.set_single_selection
			list.set_column_title ("Action", 1)
			list.set_column_title ("Entity", 2)
			undo_button.set_text (Widget_names.undo_label)
			undo_button.set_expand (False)
			redo_button.set_text (Widget_names.redo_label)
			redo_button.set_expand (False)
		end

	set_callbacks is
			-- Set the GUI elements callbacks.
		local
			arg: EV_ARGUMENT1 [INTEGER]
		do
			set_close_callback (Void)

			create arg.make (1)
 			undo_button.add_click_command (Current, arg)
			create arg.make (2)
 			redo_button.add_click_command (Current, arg)
		end

	set_properties is
			-- Set the history list properties.
		do
 			create history_list.make
 			set_saved
		end

	set_geometry is
		do
			set_minimum_width (Resources.history_wnd_width)
			set_minimum_height (Resources.history_wnd_height)
		end

feature -- Access

	record (cmd: like item) is
			-- Put `cmd' in history list
			-- and highlight the corresponding
			-- item. Remove all commands bellow.
		local
			cut_cmd: CONTEXT_CUT_CMD
			a_row: EV_MULTI_COLUMN_LIST_ROW
			arg: EV_ARGUMENT1 [INTEGER]
		do
			remove_tail
			if history_list.count = History_count then
				history_list.start
					-- Special case (destroy widgets)
				cut_cmd ?= history_list.item
				if cut_cmd /= Void then
					cut_cmd.destroy_widgets
				end
				list.get_item (1).destroy
				history_list.remove
				history_list.finish
			end
			history_list.put_right (cmd)
			history_list.forth
			create a_row.make_with_text (list, <<cmd.name, cmd.comment>>)
			create arg.make (3)
			a_row.add_activate_command (Current, arg)
			set_unsaved
			select_item (list.rows)
		end

feature -- Status report

	item: EB_UNDOABLE_COMMAND is
			-- Current command in the history window
		require
			not_off: not history_list.off
		do
			Result := history_list.item
		end

	before: BOOLEAN is
			-- Is history list offleft?
		do
			Result := history_list.before
		end

	history_count: INTEGER is 
		do
			Result := Resources.history_size
		end

feature -- Status setting

	saved_application: BOOLEAN
			-- Has the application been saved?

	set_unsaved_application is
		do
			set_unsaved
			last_command_saved := Void
		end

	set_saved_application is
			-- Set saved_application to True.
		do
			set_saved
			if list.shown and then list.selected_item /= Void then
				last_command_saved := history_list.last
			else
				last_command_saved := Void
			end
		end

feature -- Basic operations

	wipe_out is
			-- Empty the history list
		do
			if not history_list.empty then
				if history_list.last = last_command_saved then
					last_command_saved := Void
				end
				list.clear_items
				history_list.wipe_out
			end
		end

	history_list: TWO_WAY_LIST [like item]

	select_item (id: INTEGER)is
			-- Select the `id' element in the list
		do
			list.get_item (id).set_selected (True)
		end

feature {NONE} -- Command

	execute (argument: EV_ARGUMENT1 [INTEGER]; data: EV_EVENT_DATA) is
		do
			if argument.first = 1 then
				back
			elseif argument.first = 2 then
				forth
			elseif argument.first = 3 then
				play
			end
		end

	forth is
			-- Move forward in history list.
		do
			if not history_list.empty and then not history_list.islast then
				history_list.forth
				if history_list.item = last_command_saved then
					set_saved
				else
					set_unsaved
				end
				item.redo
				select_item (history_list.index)
			end
		end

	back is
			-- Move back in history list
			-- and select current item.
		do
			if not history_list.empty and then history_list.index /= 0 then
				item.undo
				history_list.back
				if (history_list.before and last_command_saved = Void) 
				or (not history_list.before and then history_list.item = last_command_saved)
				then
					set_saved
				else
					set_unsaved
				end
				if history_list.before then
					list.get_item (1).set_selected (False)
				else
					select_item (history_list.index)
				end
			end
		end

	play is
			-- Redo or undo a sequence of commands.
		local
			offset, i: INTEGER
			play_stopped: BOOLEAN
		do
			offset := list.selected_item.index - history_list.index
			if offset > 0 then
				from
					i := offset 
				until
					i <= 0
				loop
						forth
						i := i - 1
				end
			else
				from
					i := offset
				until
					i >= 0
				loop
						back
						i := i + 1
				end
			end
		end

feature {NONE} -- Implementation

	remove_tail is
		local
			create_cont: CONTEXT_CREATE_CMD
--			grp_cmd: GROUP_CMD
		do
			if not history_list.empty
			and then not history_list.islast then
				from
					history_list.forth
				until
					history_list.after
				loop
					create_cont ?= history_list.item
--					grp_cmd ?= history_list.item
					if create_cont /= Void then
						create_cont.destroy_widgets
--					elseif grp_cmd /= Void then
--						grp_cmd.destroy_widgets
					end
					list.get_item (history_list.index).destroy
					history_list.remove
				end
				history_list.back
				if not history_list.off then
					select_item (history_list.index)
				end
			end
		end

	last_command_saved: EV_UNDOABLE_COMMAND
			-- Last command saved

	set_saved is
		do
			saved_application := True
			main_window.set_saved_symbol
		end

	set_unsaved is
		do
			saved_application := False
			main_window.set_unsaved_symbol
		end

feature -- Interface

	close (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			main_window.menu_bar.history_window_entry.set_state (False)
			hide
		end

	show is
		do
			set_initial_position
 			{EB_WINDOW} Precursor
		end

	set_initial_position is	
		do
			set_x_y (main_window.x + main_window.width // 2 - width // 2,
					main_window.y)
		end

feature {NONE} -- GUI elements

	list: EV_MULTI_COLUMN_LIST

	undo_button: EV_BUTTON

	redo_button: EV_BUTTON

end -- class HISTORY_WINDOW

