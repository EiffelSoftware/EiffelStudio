indexing
	description: "Context representing a permanent window PERM_WIND."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class PERM_WIND_C 

inherit

	WINDOW_C
		redefine
			stored_node, 
			reset_modified_flags, copy_attributes, 
			context_initialization, 
			widget, remove_yourself, is_perm_window, 
			update_visual_name_in_editor, description_text
		end

feature -- Widget type

	widget: PERM_WIND;

	symbol: PIXMAP is
		do
			Result := Pixmaps.top_shell_pixmap
		end;

feature -- File name

	base_file_name_without_dot_e: FILE_NAME is
		local
			tmp: STRING;
		do
			tmp := clone (entity_name);
			tmp.to_lower;
			tmp.replace_substring_all (Window_seed_to_lower, 
						Resources.perm_window_file_name)
			!! Result.make_from_string (tmp);
		end;

feature

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.perm_wind_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		local
			contin_command: WINDOW_ITERATOR_COMMAND;
		do
			!!widget.make (entity_name, eb_screen);
			title := entity_name;
			set_default_bg_pixmap;
			!!contin_command.make (Current);
			widget.top_shell.set_delete_command (contin_command);
				-- For x_offset and y_offset initialization
			if retrieved_node = Void then
					-- Not retrieving widget from project
				add_window_geometry_action;
				widget_set_title (entity_name);
				set_size (400, 500);
				old_x := eb_screen.x + 10;
				old_y := eb_screen.y + 10;
				set_x_y (old_x, old_y);
				if toolkit.name.is_equal ("MS_WINDOWS") then
					configure_count := 0
					-- Setting x, y under MS Windows does not cause
					-- a configure event before realization.
				end
			end;
			widget.top_shell.set_action ("<Prop>,<Map>", Current, Current)
			add_to_window_list;
		end;

feature -- Adding/removing callbacks

	add_window_geometry_action is
		do
			widget.top_shell.set_action ("<Configure>", Current, Void)
		end;

	remove_window_geometry_action is
		do
			widget.top_shell.remove_action ("<Configure>");
		end;

feature 

	full_type_name: STRING is "Permanent window"

feature {NONE}

	Window_seed: STRING is "Perm_wind";

	Window_seed_to_lower: STRING is "perm_wind";

	namer: NAMER is
		once
			!!Result.make (Window_seed);
		end;

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

feature 

	eiffel_type: STRING is "PERM_WIND";

	remove_yourself is
		local
			window_c: WINDOW_C;
		do
			from 
				Shared_window_list.start
			until
				Shared_window_list.after
			loop
				window_c := Shared_window_list.item;
				if window_c.parent = Current then
						-- Remove all children popups
					window_c.remove_yourself;
					if not Shared_window_list.before then
						Shared_window_list.start;
					end;
				end;	
				Shared_window_list.forth;
			end;
			Precursor
		end;

	is_perm_window: BOOLEAN is
		do
			Result := True
		end;

	-- ***********************
	-- * specific attributes *
	-- ***********************

feature {NONE}

	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
					Context_const.geometry_format_nbr);
			opt_list.put (Context_const.perm_wind_att_form_nbr,
					Context_const.attribute_format_nbr);
		end;

	widget_set_title (new_title: STRING) is
			-- Set`title' to `new_title'
		do
			title := new_title;
			widget.set_title (new_title);
		end;

	widget_forbid_resize is
		do
			widget.forbid_resize
		end

	widget_allow_resize is
		do
			widget.allow_resize
		end

feature

	update_visual_name_in_editor is
		local
			editor: CONTEXT_EDITOR
		do
			editor := context_catalog.editor (Current, 
					Context_const.perm_wind_att_form_nbr);
			if editor /= Void then
				editor.reset_current_form
			end;
		end;

	set_icon_name (a_name: STRING) is
		do
			icon_name := a_name;
			icon_name_modified := True;
			widget.set_icon_name (a_name);
		end;


	set_icon_pixmap (a_name: STRING) is
		local
			a_pixmap: PIXMAP;
		do
			icon_pixmap_name := a_name;
			icon_pixmap_modified := False;
			if icon_pixmap_name /= Void and then 
				not icon_pixmap_name.empty
			then
				icon_pixmap_modified := True;
				!!a_pixmap.make;
				a_pixmap.read_from_file (a_name);
				if a_pixmap.is_valid then
					widget.set_icon_pixmap (a_pixmap);
				end;
			end
		end;


	icon_name_modified: BOOLEAN;

	icon_name: STRING;

	icon_pixmap_name: STRING;

	icon_pixmap_modified: BOOLEAN;

	set_iconic_state (flag: BOOLEAN) is
			-- Set iconic state to `flag'.
			-- Do not call actual function for top_shell
		do
			iconic_state_modified := True;
			is_iconic_state := flag;
		end;

	iconic_state_modified: BOOLEAN;

	is_iconic_state: BOOLEAN;

	reset_modified_flags is
		do
			Precursor 
			icon_name_modified := False;
			iconic_state_modified := False;
		end;
	
feature {NONE}

	copy_attributes (other_context: like Current) is
		do
			if title_modified then
				other_context.set_title (title);
			end;
			if resize_policy_modified then
				other_context.disable_resize_policy (resize_policy_disabled)
			end;
			if icon_name_modified then
				other_context.set_icon_name (icon_name);
			end;
			if iconic_state_modified then
				other_context.set_iconic_state (is_iconic_state)
			end;
			if icon_pixmap_modified then
				other_context.set_icon_pixmap (icon_pixmap_name);
			end;
			other_context.set_start_hidden (start_hidden)
			Precursor (other_context);
		end;

	
feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		do
			!!Result.make (0);
			if title_modified then
				function_string_to_string (Result, context_name, "set_title", title)
			end;
			if resize_policy_modified then
				cond_f_to_string (Result, resize_policy_disabled, context_name, "forbid_resize", "allow_resize")
			end;
			if icon_name_modified then
				function_string_to_string (Result, context_name, "set_icon_name", icon_name)
			end;
			if icon_pixmap_modified then
				function_string_to_string (Result, context_name, "set_icon_pixmap_by_name", icon_pixmap_name)
			end;
			if iconic_state_modified then
				function_bool_to_string (Result, context_name, "set_iconic_state", is_iconic_state)
			end;
		end;

	
feature {NONE}

-- 	creation_procedure_text: STRING is
-- 		local
-- 			creation_procedure: STRING;
-- 		do
-- 			creation_procedure := clone (eiffel_type);
-- 			creation_procedure.to_lower;
-- 			creation_procedure.append ("_make");
-- 
-- 			!!Result.make (100);
-- 			Result.append ("%N%Tmake (a_name: STRING; a_screen: SCREEN) is%N%T%Tdo%N%T%T%T");
-- 			Result.append (creation_procedure);
-- 			Result.append (" (a_name, a_screen);%N");
-- 		end;

-- ****************
-- Storage features
-- ****************

	
feature 

	stored_node: S_PERM_WIND_R1 is
		do
			!!Result.make (Current);
		end;

end
