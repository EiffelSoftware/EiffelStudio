indexing
	description: "Context representing a window in general."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

deferred class WINDOW_C 

inherit

	COMMAND

	SHARED_CONTEXT

	COMPOSITE_C
		rename
			position_modified as default_position,
			link_to_parent as add_to_window_list
		redefine
			create_context, cut, undo_cut, position_initialization,
			is_in_a_group, root, set_position,
			intermediate_name, is_bulletin, is_selectionable,
			full_name, deleted, remove_yourself, group_name,
			set_x_y, set_size, set_visual_name,
			reset_modified_flags,
			raise, x, y, set_real_x_y, is_window,
			add_to_window_list, retrieve_set_visual_name, 
			shown, is_able_to_be_grouped, title_label,
			show, hide, realize, is_movable,
			add_common_callbacks
		end

	UNDO_REDO_ACCELERATOR
	
feature -- Specification

	is_movable: BOOLEAN is False

	group_name: STRING is do end

	title: STRING

	title_modified: BOOLEAN

	resize_policy_modified: BOOLEAN

	resize_policy_disabled: BOOLEAN

	start_hidden: BOOLEAN

	start_hidden_modified: BOOLEAN

	is_really_shown: BOOLEAN
			-- Setting show/hide does not set `shown' instantly (always
			-- false if calling show/hide until the next event loop).
			-- I needed this info immediately after a hide/show hence
			-- the need for this boolean. This boolean is used
			-- for the hide/show facility on the Context Tree

	configure_count: INTEGER
			-- Number of configure counts for set_x_y while
			-- window is realized. 
			--| This is for motif only. Setting x&y while
			--| the window is realized causes configure event
			--| and this becomes a problem when there is
			--| a sequence of geometry requests (eg undoing/redoing window 
			--| geometry in the history list in succession) will cause
			--| configure events to be queued at the end of the sequence
			--| recording geometry commands out of sequence.
		
feature -- Default event
	default_event: MOUSE_ENTER_EV is
		do
			Result := mouse_enter_ev
		end	

feature -- Setting values

	set_default_position (b: BOOLEAN) is
		do
			default_position := b
		end

	set_title (new_title: STRING) is
			-- Set`title' to `new_title'
		do
			title_modified := True
			widget_set_title (new_title)
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
	--| Since the execution mecanism is changed, it's no more interesting
	--| to bloc the resize
--				widget_forbid_resize
--			else
--				widget_allow_resize
			end
		end

	reset_modified_flags is
		do
			Precursor
			start_hidden := False
			title_modified := False
			resize_policy_modified := False
		end

feature -- File names

	base_file_name_without_dot_e: FILE_NAME is
		deferred
		end

feature {NONE} -- Widget access

	widget_set_title (s: STRING) is
		deferred
		end

-- 	widget_forbid_resize is
-- 		deferred
-- 		end
-- 
-- 	widget_allow_resize is
-- 		deferred
-- 		end
feature 

	title_label: STRING is
		do
			Result := Precursor
				-- Only concerned after Current is retrieved
			if retrieved_node = Void and then 
				not is_really_shown 
			then
				Result.extend ('*')
			end
		end

	set_start_hidden (flag: BOOLEAN) is
		do
			start_hidden := flag
		end

	retrieve_set_visual_name (s: STRING) is
		do
			visual_name := clone (s)
			title_modified := True
			widget_set_title (label)
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
			widget_set_title (label)
			update_tree_element
		end

	is_bulletin: BOOLEAN is
		do
			Result := True
		end

	is_selectionable: BOOLEAN is
		do
			Result := False
		end

	is_perm_window: BOOLEAN is
		do
		end

	is_window: BOOLEAN is
			-- Is Current a window? (True)
		do
			Result := True
		end

	is_in_a_group: BOOLEAN is
			-- Is Current in a group? (False)
		do
		end

	is_able_to_be_grouped: BOOLEAN is
			-- Is Current able to be grouped? (False)
		do
		end

	add_to_window_list is
		require else
			always_true: True
		do
			Shared_window_list.extend (Current)
		end

	root: CONTEXT is
		require else
			valid_parent: True
		do
			Result := Current
		end

	set_position (x_pos, y_pos: INTEGER) is
		require else
			no_parent_restrictions: True
		do
			set_x_y (x_pos, y_pos)
		end

	set_real_x_y (new_x, new_y: INTEGER) is
			-- Set new position of widget
		require else
			no_parent_restrictions: True
		do
			set_x_y (new_x - x_offset, new_y - y_offset)
		end

	set_x_y (new_x, new_y: INTEGER) is
			-- Set new position of widget
		require else
			no_parent_restrictions: True
		do
			widget.set_x_y (new_x, new_y)
			old_x := new_x
			old_y := new_y
			x := old_x
			y := old_y
			configure_count := configure_count + 1
		end

	set_size (new_w, new_h: INTEGER) is
			-- Set new size of widget
		require else
			no_parent_restrictions: True
		do
			size_modified := True
			widget.set_size (new_w, new_h)
			old_width := new_w
			old_height := new_h
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

feature 

	create_context (a_parent: COMPOSITE_C): like Current is
			-- Create a context of the same type
		local
			create_command: CONTEXT_CREATE_CMD
		do
			Result := New
			Result.generate_internal_name
			Result.oui_create (Void)
				-- Void if context created for catalog
			if widget /= Void then
				Result.set_size (width, height)
				copy_attributes (Result)
			end
			!! create_command
			create_command.execute (Result)
		ensure then
			in_window_list: Shared_window_list.has (Result)
		end

	deleted: BOOLEAN is
		do
			Result := not Shared_window_list.has (Current)
		end

	remove_yourself is
		local
			command: CONTEXT_CUT_CMD
		do
			!! command
			command.execute (Current)
			tree.display (Current)
		end

	cut is
		require else
			no_parent: True
		do
			hide
			Shared_window_list.start
			Shared_window_list.prune (Current)
			tree.cut (tree_element)
			context_catalog.clear_editors (Current)
			--added by samik
			widget.set_managed(False)		
		ensure then
			not_in_window_list: not Shared_window_list.has (Current)
		end

	undo_cut is
		do
			show
			Precursor
		ensure then
			in_window_list: Shared_window_list.has (Current)
		end

	add_window_geometry_action is 
		require 
			widget_not_void: widget /= Void
		deferred
		end

	remove_window_geometry_action is 
		require 
			widget_not_void: widget /= Void
		deferred
		end

	shown: BOOLEAN is
		do
			Result := widget.realized and then widget.shown
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

	raise is
		do
			if not shown then
				show
			end
			widget.raise
		end

	realize is
		do
			widget.realize
			update_label (True)
		end

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

feature

	execute (argument: ANY) is
		local
			win_cmd: WIN_CONFIG_CMD
		do
			if configure_count = 0 and then 
					-- This is just in case that the event
					-- is still called just after a destruction
				not widget.destroyed and then 
				not deleted and then
					-- Only concerned if the window is shown
				shown
			then
				x := widget.x - x_offset
				y := widget.y - y_offset
					-- Configure event
				if old_x /= x or else old_y /= y or else
					old_height /= height or else old_width /= width
				then
					!! win_cmd.make (Current)
					old_x := x
					old_y := y
					old_width := width
					old_height := height
					win_cmd.execute (argument)
				end
			end
			if configure_count > 0 then
				configure_count := configure_count - 1
			end
		end

	old_x, old_y, old_width, old_height: INTEGER
			-- Previously saved geometry values for configure event

feature -- Hack for motif

	x: INTEGER
			-- (See comments for x_offset)

	y: INTEGER
			-- (See comments for y_offset)

	x_offset: INTEGER is	
			-- Setting x for Current correctly sets the value
			-- for the shell. However, it does not correctly 
			-- return the x value. Eg. set_x (100) will
			-- return 111 for x. Apparently set_x is used for
			-- the top shell and the returned value is inner
			-- coordinate.
		once
			!! Result
			Result := 0
			if toolkit.name.is_equal ("MOTIF") then
				Result := widget.real_x - old_x
			end
		end

	y_offset: INTEGER is	
			-- See above comments
		once
			!! Result
			Result := 0
			if toolkit.name.is_equal ("MOTIF") then
				Result := widget.real_y - old_y
			end
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

feature {NONE} -- Callbacks

	add_common_callbacks (a_widget: WIDGET) is
			-- We need to set the cursor to the `arrow_cursor' when leaving
			-- the window.
		local
			set_shape_cmd: SET_DEFAULT_CURSOR_SHAPE_CMD
		do
			{COMPOSITE_C} Precursor (a_widget)
			!! set_shape_cmd
			a_widget.add_leave_action (set_shape_cmd, Current)
		end

end
