indexing
	description: "Context representing a permanent window PERM_WIND."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class PERM_WIND_C 

inherit
	WINDOW_C
		redefine
			create_context, root,
			reset_modified_flags, copy_attributes, 
			context_initialization, 
			remove_yourself, is_perm_window, 
			update_visual_name_in_editor, description_text
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.container_page.perm_wind_type
		end

feature -- Context creation

	create_context (a_parent: like Current): like Current is
			-- Create a context of the same type
		local
			create_cmd: CONTEXT_CREATE_CMD
		do
			Result := New
			Result.generate_internal_name
			Result.oui_create (Void)
				-- Void if context created for catalog
			if gui_object /= Void then
				Result.set_size (width, height)
				copy_attributes (Result)
			end
			create create_cmd.make (Result)
			create_cmd.work
			create_cmd.update_history
		ensure then
			in_window_list: Shared_window_list.has (Result)
		end

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
				old_x := eb_screen.x + 10
				old_y := eb_screen.y + 10
				set_x_y (old_x, old_y)
--			end
			add_to_window_list
			gui_object.show
		end

feature -- Status setting

	update_visual_name_in_editor is
		local
--			editor: CONTEXT_EDITOR
		do
-- 			editor := context_catalog.editor (Current, 
-- 					Context_const.perm_wind_att_form_nbr)
-- 			if editor /= Void then
-- 				editor.reset_current_form
-- 			end
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
--			if icon_pixmap_name /= Void and then 
--				not icon_pixmap_name.empty
--			then
--				icon_pixmap_modified := True
--				!!a_pixmap.make
--				a_pixmap.read_from_file (a_name)
--				if a_pixmap.is_valid then
--					gui_object.set_icon_pixmap (a_pixmap)
--				end
--			end
		end

	icon_name_modified: BOOLEAN

	icon_name: STRING

	icon_pixmap_name: STRING

	icon_pixmap_modified: BOOLEAN

	set_iconic_state (flag: BOOLEAN) is
			-- Set iconic state to `flag'.
			-- Do not call actual function for top_shell
		do
			iconic_state_modified := True
			is_iconic_state := flag
		end

	iconic_state_modified: BOOLEAN

	is_iconic_state: BOOLEAN

	reset_modified_flags is
		do
			Precursor 
			icon_name_modified := False
			iconic_state_modified := False
		end

feature {NONE}  -- Internal namer

	Window_seed: STRING is "Perm_wind"

	Window_seed_to_lower: STRING is "perm_wind"

	namer: NAMER is
		once
			create Result.make (Window_seed)
		end

	-- ***********************
	-- * specific attributes *
	-- ***********************

-- 	add_to_option_list (opt_list: ARRAY [INTEGER]) is
-- 		do
-- 			opt_list.put (Context_const.geometry_form_nbr,
-- 					Context_const.geometry_format_nbr)
-- 			opt_list.put (Context_const.perm_wind_att_form_nbr,
-- 					Context_const.attribute_format_nbr)
-- 		end

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

	remove_yourself is
		local
			window_c: WINDOW_C
		do
			from 
				Shared_window_list.start
			until
				Shared_window_list.after
			loop
				window_c := Shared_window_list.item
				if window_c.parent = Current then
						-- Remove all children popups
					window_c.remove_yourself
					if not Shared_window_list.before then
						Shared_window_list.start
					end
				end	
				Shared_window_list.forth
			end
			Precursor
		end

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

