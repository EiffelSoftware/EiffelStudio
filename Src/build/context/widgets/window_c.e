indexing
	description: "Context representing a window in general."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

deferred class WINDOW_C 

inherit
	CONTAINER_C
		rename
			position_modified as default_position
		redefine
			create_context,
			gui_object, position_initialization,
			copy_attributes, 
			is_in_a_group, set_position,
			intermediate_name, --is_selectionable,
			full_name, group_name,
			set_x_y, set_size, set_visual_name,
			reset_modified_flags,
			is_window,
			--retrieve_set_visual_name, 
			update_visual_name_in_editor,
			is_able_to_be_grouped, title_label,
			add_gui_callbacks,
			option_list
		end

	CLOSEABLE

	EV_COMMAND

feature -- Context creation

	create_context (a_parent: WINDOW_C): like Current is
			-- Create a context of the same type
		local
			create_cmd: CONTEXT_CREATE_CMD
		do
			Result := New
			Result.set_parent (a_parent)
			Result.generate_internal_name
			if a_parent /= Void then
				Result.oui_create (a_parent.gui_object)
			else
				Result.oui_create (Void)
			end
				-- Void if context created for catalog
			if gui_object /= Void then
				Result.set_size (width, height)
				copy_attributes (Result)
			end
			create create_cmd.make (Result)
			create_cmd.work
			create_cmd.update_history
		end

--	remove_yourself is
--		local
--			command: CONTEXT_CUT_CMD
--		do
--			create command
--			command.execute (Current)
----			tree.display (Current)
--		end

feature -- Basic operations

	raise is
		do
--			if not shown then
				show
--			end
--			gui_object.raise
		end

feature -- Access

	option_list: ARRAY [INTEGER] is
		do
			Result := Precursor
			Result.put (Context_const.window_att_form_nbr,
						Context_const.attribute_format_nbr)
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
--			if retrieved_node = Void and then
			if not is_really_shown then
				Result.extend ('*')
			end
		end

	title: STRING is
		do
			Result := gui_object.title
		end

	title_modified: BOOLEAN

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

	is_in_a_group: BOOLEAN is
			-- Is Current in a group ?
		do
		end

	is_able_to_be_grouped: BOOLEAN is
			-- Is Current able to be grouped ?
		do
		end

	icon_name_modified: BOOLEAN

	icon_name: STRING

	icon_pixmap_name: STRING

	icon_pixmap: EV_PIXMAP is
		do
			Result := gui_object.icon_pixmap
		end

	icon_pixmap_modified: BOOLEAN

	iconic_state_modified: BOOLEAN

	is_iconic_state: BOOLEAN

	is_maximize_state: BOOLEAN

	maximize_state_modified: BOOLEAN

	is_modal: BOOLEAN

	modal_modified: BOOLEAN

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
				gui_object.forbid_resize
			else
				gui_object.allow_resize
			end
		end

	set_icon_name (a_name: STRING) is
		do
			icon_name := a_name
			icon_name_modified := True
			gui_object.set_icon_name (a_name)
		end

	set_icon_pixmap (a_name: STRING) is
		local
			a_pixmap: EV_PIXMAP
		do
			icon_pixmap_name := a_name
			icon_pixmap_modified := False
			if icon_pixmap_name /= Void
			and then not icon_pixmap_name.empty
			then
				icon_pixmap_modified := True
				create a_pixmap.make_from_file (a_name)
				gui_object.set_icon_pixmap (a_pixmap)
			end
		end

	set_iconic_state (flag: BOOLEAN) is
			-- Set iconic state to `flag'.
			-- Do not call actual function for window
		do
			iconic_state_modified := True
			is_iconic_state := flag
		end

	set_maximize_state (flag: BOOLEAN) is
			-- Set maximize state to `flag'.
			-- Do not call actual function for window
		do
			maximize_state_modified := True
			is_maximize_state := flag
		end

	set_modal (flag: BOOLEAN) is
			-- Change the window to be modal.
		do
			is_modal := flag
			modal_modified := True
			if flag then
				gui_object.set_modal
			else
				--XX set_normal
			end
		end

	reset_modified_flags is
		do
			{CONTAINER_C} Precursor
			start_hidden := False
			title_modified := False
			resize_policy_modified := False
			icon_name_modified := False
			iconic_state_modified := False
			maximize_state_modified := False
			modal_modified := False
		end

	update_visual_name_in_editor is
		local
			editor: CONTEXT_EDITOR
		do
			editor := context_catalog.editor (Current)
			if editor /= Void then
				editor.reset_form (Context_const.window_att_form_nbr)
			end
		end

feature -- Default event

--	default_event: MOUSE_ENTER_EV is
--		do
--			Result := mouse_enter_ev
--		end	

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

	copy_attributes (other_context: like Current) is
		do
			if title_modified then
				other_context.set_title (title)
			end
			if resize_policy_modified then
				other_context.disable_resize_policy (resize_policy_disabled)
			end
			if icon_name_modified then
				other_context.set_icon_name (icon_name)
			end
			if iconic_state_modified then
				other_context.set_iconic_state (is_iconic_state)
			end
			if icon_pixmap_modified then
				other_context.set_icon_pixmap (icon_pixmap_name)
			end
			other_context.set_start_hidden (start_hidden)
			Precursor (other_context)
		end

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

