deferred class WINDOW_C 

inherit

	COMMAND;
	SHARED_CONTEXT;
	COMPOSITE_C
		rename
			reset_modified_flags as composite_reset_modified_flags,
			position_modified as default_position,
			undo_cut as old_undo_cut,
			link_to_parent as add_to_window_list
		redefine
			create_context, cut, position_initialization,
			is_in_a_group, root, set_position,
			intermediate_name, is_bulletin, full_name,
			deleted, remove_yourself, group_name,
			set_x_y, set_size, set_visual_name,
			raise, x, y, set_real_x_y, is_window,
			add_to_window_list, retrieve_set_visual_name, 
			shown, is_able_to_be_grouped
		end;
	COMPOSITE_C
		rename
			position_modified as default_position,
			link_to_parent as add_to_window_list
		redefine
			create_context, cut, undo_cut, position_initialization,
			is_in_a_group, root, set_position,
			intermediate_name, is_bulletin, full_name,
			deleted, remove_yourself, group_name,
			set_x_y, set_size, set_visual_name,
			reset_modified_flags,
			raise, x, y, set_real_x_y, is_window,
			add_to_window_list, retrieve_set_visual_name, 
			shown, is_able_to_be_grouped
		select
			reset_modified_flags, undo_cut
		end
	
feature -- Specification

	group_name: STRING is do end

	title: STRING

	title_modified: BOOLEAN

	resize_policy_modified: BOOLEAN

	resize_policy_disabled: BOOLEAN

	start_hidden: BOOLEAN

	start_hidden_modified: BOOLEAN

feature -- Setting values

	set_default_position (b: BOOLEAN) is
		do
			default_position := b
		end;

	set_title (new_title: STRING) is
			-- Set`title' to `new_title'
		do
			title_modified := True
			widget_set_title (new_title)
			visual_name := clone (new_title);
			update_tree_element
		end;

	disable_resize_policy (flag: BOOLEAN) is
		do
			resize_policy_modified := True
			resize_policy_disabled := flag
			if flag then
				widget_forbid_resize
					-- The current size must be saved
				size_modified := True
			else
				widget_allow_resize
			end
		end

	reset_modified_flags is
		do
			composite_reset_modified_flags
			start_hidden := False;
			title_modified := False
			resize_policy_modified := False
		end

feature -- File names

	base_file_name_without_dot_e: FILE_NAME is
		deferred
		end;

feature {NONE}

	widget_set_title (s: STRING) is
		deferred
		end

	widget_forbid_resize is
		deferred
		end

	widget_allow_resize is
		deferred
		end

feature 

	set_start_hidden (flag: BOOLEAN) is
		do
			start_hidden := flag
		end

	retrieve_set_visual_name (s: STRING) is
		do
			visual_name := clone (s);
			title_modified := True
			widget_set_title (label)
		end

	set_visual_name (s: STRING) is
		do
			if (s = Void) then
				visual_name := Void;
				title_modified := False
			else
				visual_name := clone (s);
				title_modified := True
			end;
			widget_set_title (label)
			update_tree_element
		end

	is_bulletin: BOOLEAN is
		do
			Result := True
		end

	is_perm_window: BOOLEAN is
		do
		end

	is_window: BOOLEAN is
			-- Is Current a window? (True)
		do
			Result := True
		end;

	is_in_a_group: BOOLEAN is
			-- Is Current in a group? (False)
		do
		end;

	is_able_to_be_grouped: BOOLEAN is
			-- Is Current able to be grouped? (False)
		do
		end;

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
		end;

	set_position (x_pos, y_pos: INTEGER) is
		require else
			no_parent_restrictions: True
		do
			set_x_y (x_pos, y_pos)
		end;

	set_real_x_y (new_x, new_y: INTEGER) is
			-- Set new position of widget
		require else
			no_parent_restrictions: True
		do
			set_x_y (new_x - x_offset, new_y - y_offset);
		end;

	set_x_y (new_x, new_y: INTEGER) is
			-- Set new position of widget
		require else
			no_parent_restrictions: True
		do
			widget.set_x_y (new_x, new_y);
			old_x := new_x;
			old_y := new_y;
			x := old_x;
			y := old_y
		end

	set_size (new_w, new_h: INTEGER) is
			-- Set new size of widget
		require else
			no_parent_restrictions: True
		do
			size_modified := True;
			widget.set_size (new_w, new_h);
			old_width := new_w;
			old_height := new_h;
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
			!!create_command
			create_command.execute (Result)
		ensure then
			in_window_list: Shared_window_list.has (Current)
		end

	deleted: BOOLEAN is
		do
			Result := not Shared_window_list.has (Current)
		end

	remove_yourself is
		local
			command: CONTEXT_CUT_CMD
		do
			!!command
			command.execute (Current)
			tree.display (Current)
		end

	cut is
		require else
			no_parent: True
		do
			hide;
			Shared_window_list.start;
			Shared_window_list.prune (Current);
			tree.cut (tree_element);
			context_catalog.clear_editors (Current)
		ensure then
			not_in_window_list: not Shared_window_list.has (Current)
		end

	undo_cut is
		do
			show;
			old_undo_cut
		ensure then
			in_window_list: Shared_window_list.has (Current)
		end;

	add_window_geometry_action is 
		require 
			widget_not_void: widget /= Void
		deferred
		end;

	remove_window_geometry_action is 
		require 
			widget_not_void: widget /= Void
		deferred
		end;

	remove_popup_action is
		deferred
		end;

	shown: BOOLEAN is
		do
			Result := widget.realized and then widget.shown
		end;

	raise is
		do
			if not shown then
				show
			end;
			widget.raise
		end;

	execute (argument: ANY) is
		local
			win_cmd: WIN_CONFIG_CMD
			top: PERM_WIND_C
		do
			if argument = Current then
				-- This is a hack because there is a bug
				-- under motif for x and y positions
				-- (see x_offset and y_offset) but will
				-- be compatible with other toolkits. If 
				-- there is not a bug then x_offset and 
				-- y_offset will be zero.
				-- This is executed the first time Current
				-- is popped up.
					-- Initalize x and y offset
				if x_offset = Void then end;
				if y_offset = Void then end;
				remove_popup_action;
				add_window_geometry_action;	
			elseif not widget.destroyed and then not deleted then
					-- This is just in case that the event
					-- is still called just after a destruction
				x := widget.x - x_offset;
				y := widget.y - y_offset;
					-- Configure event
				if old_x /= x or else old_y /= y or else
					old_height /= height or else old_width /= width
				then
					!! win_cmd.make (Current);
					old_x := x;
					old_y := y;
					old_width := width;
					old_height := height;
					win_cmd.execute (argument)
				end
			end;
		end

	old_x, old_y, old_width, old_height: INTEGER
			-- Previously saved geometry values for configure event

feature -- Hack for motif

	x: INTEGER;
			-- (See comments for x_offset)

	y: INTEGER;
			-- (See comments for y_offset)

	x_offset: INTEGER is	
			-- Setting x for Current correctly sets the value
			-- for the shell. However, it does not correctly 
			-- return the x value. Eg. set_x (100) will
			-- return 111 for x. Apparently set_x is used for
			-- the top shell and the returned value is inner
			-- coordinate.
		once
			Result := widget.x - old_x
		end;

	y_offset: INTEGER is	
			-- See above comments
		once
			Result := widget.y - old_y
		end;

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

end
