indexing
	description: "Context representing a window in general."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

deferred class WINDOW_C 

inherit
	CONTAINER_C
		rename
			position_modified as default_position,
			link_to_parent as add_to_window_list
		redefine
			gui_object, cut, undo_cut, position_initialization,
			is_in_a_group, set_position,
			intermediate_name, --is_selectionable,
			full_name, deleted, group_name,
			set_x_y, set_size, set_visual_name,
			reset_modified_flags,
			is_window,
			add_to_window_list, --retrieve_set_visual_name, 
			shown, is_able_to_be_grouped, title_label,
			show, hide,
			add_gui_callbacks
		end

	SHARED_CONTEXT

	CLOSEABLE

	EV_COMMAND

-- feature -- Context creation
-- 
-- 	remove_yourself is
-- 		local
-- 			command: CONTEXT_CUT_CMD
-- 		do
-- 			create command
-- 			command.execute (Current)
-- --			tree.display (Current)
-- 		end

feature -- Basic operations

	cut is
		require else
			no_parent: True
		do
			hide
			Shared_window_list.start
			Shared_window_list.prune (Current)
			tree_element.destroy
--			context_catalog.clear_editors (Current)
		ensure then
			not_in_window_list: not Shared_window_list.has (Current)
		end

	undo_cut is
		do
			Precursor
			show
		ensure then
			in_window_list: Shared_window_list.has (Current)
		end

	shown: BOOLEAN is
		do
			Result := gui_object.shown
		end

	show is
		do
			Precursor
			update_label (True)
		end

	hide is
		do
			Precursor
			update_label (False)
		end

-- 	raise is
-- 		do
-- 			if not shown then
-- 				show
-- 			end
-- 			widget.raise
-- 		end

	update_label (is_shown: BOOLEAN) is
			-- Update label for window visibility.
		local
			cur: CURSOR
		do
			is_really_shown := is_shown
			cur := Shared_window_list.cursor
			update_tree_element
			Shared_window_list.go_to (cur)
		end

	add_to_window_list is
		require else
			always_true: True
		do
			Shared_window_list.extend (Current)
		end

	deleted: BOOLEAN is
		do
			Result := not Shared_window_list.has (Current)
		end

feature -- Status report

	is_really_shown: BOOLEAN
			-- Setting show/hide does not set `shown' instantly (always
			-- false if calling show/hide until the next event loop).
			-- I needed this info immediately after a hide/show hence
			-- the need for this boolean. This boolean is used
			-- for the hide/show facility on the Context Tree

--	is_movable: BOOLEAN is False

	group_name: STRING is do end

	title_label: STRING is
		do
			Result := {CONTAINER_C} Precursor
				-- Only concerned after Current is retrieved
--			if retrieved_node = Void and then not is_really_shown then
--				Result.extend ('*')
--			end
		end

	title: STRING is
		do
			Result := gui_object.title
		end

	title_modified: BOOLEAN

	resize_policy_modified: BOOLEAN

	resize_policy_disabled: BOOLEAN

	start_hidden: BOOLEAN

	start_hidden_modified: BOOLEAN

	is_selectionable: BOOLEAN is
		do
			Result := False
		end

	is_window: BOOLEAN is
			-- Is `gui_object' a window ?
		do
			Result := True
		end

	is_perm_window: BOOLEAN is
			-- Is Current context a permanent window ?
		do
			Result := True
		end

	is_perm_window: BOOLEAN is
			-- Is `gui_object' a permanent window ?
		do
		end

	is_in_a_group: BOOLEAN is
			-- Is Current in a group ?
		do
		end

	is_able_to_be_grouped: BOOLEAN is
			-- Is Current able to be grouped ?
		do
		end

feature -- Status setting

	set_position (x_pos, y_pos: INTEGER) is
		require else
			no_parent_restrictions: True
		do
			set_x_y (x_pos, y_pos)
		end

	set_x_y (new_x, new_y: INTEGER) is
			-- Set new position of widget
		require else
			no_parent_restrictions: True
		do
			gui_object.set_x_y (new_x, new_y)
			old_x := new_x
			old_y := new_y
		end

	set_size (new_w, new_h: INTEGER) is
			-- Set new size of widget
		require else
			no_parent_restrictions: True
		do
			size_modified := True
			gui_object.set_size (new_w, new_h)
			old_width := new_w
			old_height := new_h
		end

	set_start_hidden (flag: BOOLEAN) is
		do
			start_hidden := flag
		end

	retrieve_set_visual_name (s: STRING) is
		do
			visual_name := clone (s)
			title_modified := True
			gui_object.set_title (label)
		end

	set_visual_name (s: STRING) is
		do
			if (s = Void) then
				visual_name := Void
				title_modified := False
			else
				visual_name := clone (s)
				title_modified := True
			end
			gui_object.set_title (label)
			update_tree_element
		end

	set_default_position (b: BOOLEAN) is
		do
			default_position := b
		end

	set_title (new_title: STRING) is
			-- Set`title' to `new_title'
		do
			title_modified := True
			gui_object.set_title (new_title)
			visual_name := clone (new_title)
			update_tree_element
			if namer_window.namable = Current then
				namer_window.update_name
			end
		end

	disable_resize_policy (flag: BOOLEAN) is
		do
			resize_policy_modified := True
			resize_policy_disabled := flag
			if flag then
					-- The current size must be saved
				size_modified := True
			end
		end

	reset_modified_flags is
		do
			{CONTAINER_C} Precursor
			start_hidden := False
			title_modified := False
			resize_policy_modified := False
		end

feature -- Default event

-- 	default_event: MOUSE_ENTER_EV is
-- 		do
-- 			Result := mouse_enter_ev
-- 		end	

feature -- File names

	base_file_name_without_dot_e: FILE_NAME is
		deferred
		end

feature {CONTEXT}

	full_name: STRING is
		do
			!!Result.make (0)
			Result.append (entity_name)
		end

	intermediate_name: STRING is
		do
			Result := full_name
		end

feature {NONE} -- Code generation

	position_initialization (context_name: STRING): STRING is
			-- Eiffel code for the position of current context
			-- depending on the type of its parent
		do
			!!Result.make (0)
			if not default_position then
				function_int_int_to_string (Result, "", "set_x_y", x, y)
			end
			if size_modified then
				function_int_int_to_string (Result,"","set_size",width, height)
			end
		end

feature -- Geometry management

	execute (argument: EV_ARGUMENT; event_data: EV_EVENT_DATA) is
			--XX Separate move and resize (routine commands)...
		local
--			win_cmd: WIN_CONFIG_CMD
		do
			if not gui_object.destroyed and then not deleted and then shown then
					-- Configure event
				if old_x /= x or else old_y /= y
				or else old_height /= height or else old_width /= width
				then
--					create win_cmd.make (Current)
					old_x := x
					old_y := y
					old_width := width
					old_height := height
--					win_cmd.execute (argument)
				end
			end
		end

	old_x, old_y, old_width, old_height: INTEGER
			-- Previously saved geometry values for configure event

feature {NONE} -- Callbacks

	add_gui_callbacks is
			-- Define the general behavior of the GUI object.
-- 		local
-- 			set_shape_cmd: SET_DEFAULT_CURSOR_SHAPE_CMD
		do
-- 			-- We need to set the cursor to the `arrow_cursor' when leaving
-- 			-- the window.
-- 			!! set_shape_cmd
-- 			a_widget.add_leave_action (set_shape_cmd, Current)
			gui_object.add_move_command (Current, Void)
			gui_object.add_resize_command (Current, Void)
			set_close_callback (Void)
			{CONTAINER_C} Precursor
		end

feature -- Closeable

	add_close_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		do
			gui_object.add_close_command (cmd, arg)
		end

	close (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Close the GUI window.
		do
			hide
		end

feature -- Implementation

	gui_object: EV_WINDOW

end -- class WINDOW_C

