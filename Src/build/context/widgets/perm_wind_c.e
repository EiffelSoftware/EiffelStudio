indexing
	description: "Context representing a permanent window PERM_WIND."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class PERM_WIND_C 

inherit
	WINDOW_C
		rename
			link_to_parent as add_to_window_list
		redefine
			add_to_window_list,
			root,
			context_initialization,
			cut, undo_cut, deleted,
			is_perm_window,
			show, hide,
			description_text,
			data_type
		end

	SHARED_CONTEXT

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE [like Current] is
		do
			Result := context_catalog.container_page.perm_wind_type
		end

	data_type: EV_PND_TYPE is
		do
			Result := Pnd_types.perm_wind_type
		end

feature -- Context creation

	root: CONTEXT is
		require else
			valid_parent: True
		do
			Result := Current
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_ANY) is
		do
			create gui_object.make_top_level
			gui_object.set_title (entity_name)
--			set_default_bg_pixmap
--			if retrieved_node = Void then
					-- Not retrieving widget from project
				set_size (400, 500)
--				old_x := eb_screen.x + 10
--				old_y := eb_screen.y + 10
--				set_x_y (old_x, old_y)
--			end
			add_to_window_list
			gui_object.show
		end

feature -- Basic operations

	add_to_window_list is
		require else
			always_true: True
		do
			Shared_window_list.extend (Current)
		ensure then
			in_window_list: Shared_window_list.has (Current)
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

	cut is
		require else
			no_parent: True
		do
			hide
			Shared_window_list.start
			Shared_window_list.prune (Current)
			if not tree_element.destroyed then
				tree_element.destroy
			end
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

	deleted: BOOLEAN is
		do
			Result := not Shared_window_list.has (Current)
		end

feature {NONE}  -- Internal namer

	Window_seed: STRING is "Perm_wind"

	Window_seed_to_lower: STRING is "perm_wind"

	namer: NAMER is
		once
			create Result.make (Window_seed)
		end

feature -- Code generation

	base_file_name_without_dot_e: FILE_NAME is
		local
			tmp: STRING
		do
			tmp := clone (entity_name)
			tmp.to_lower
			tmp.replace_substring_all (Window_seed_to_lower,
										Resources.perm_window_file_name)
			create Result.make_from_string (tmp)
		end

	full_type_name: STRING is "Permanent window"

	eiffel_type: STRING is "PERM_WIND"

	is_perm_window: BOOLEAN is
		do
			Result := True
		end

feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		do
			!!Result.make (0)
			if title_modified then
				function_string_to_string (Result, context_name, "set_title", title)
			end
			if resize_policy_modified then
				cond_f_to_string (Result, resize_policy_disabled, context_name, "forbid_resize", "allow_resize")
			end
			if icon_name_modified then
				function_string_to_string (Result, context_name, "set_icon_name", icon_name)
			end
			if icon_pixmap_modified then
				function_string_to_string (Result, context_name, "set_icon_pixmap_by_name", icon_pixmap_name)
			end
			if iconic_state_modified then
				function_bool_to_string (Result, context_name, "set_iconic_state", is_iconic_state)
			end
		end

feature {NONE} -- Code generation

	description_text: STRING is
			-- Description text in indexing clause.
		do
			!! Result.make (50)
			Result.append ("Permanent window")
			if visual_name /= Void then
				Result.append (": ")
				Result.append (visual_name)
			end
			Result.append (".")
		end

-- ****************
-- Storage features
-- ****************
	
feature 

-- 	stored_node: S_PERM_WIND_R1 is
-- 		do
-- 			create Result.make (Current)
-- 		end

end -- class PERM_WIND_C

