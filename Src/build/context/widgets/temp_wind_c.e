indexing
	description: "Context representing a temporary window TEMP_WIND."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class TEMP_WIND_C 

inherit

	WINDOW_C
		redefine
			stored_node, widget, 
			copy_attributes, context_initialization, 
			create_context, position_initialization,
			shown, hide, show, update_visual_name_in_editor,
			description_text
		end

feature 

	symbol: PIXMAP is
	   do
		  Result := Pixmaps.dialog_shell_pixmap
	   end

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.temp_wind_type
		end

	create_oui_widget (a_parent: COMPOSITE) is
		local
			x1, y1: INTEGER
		do
			!!widget.make (entity_name, a_parent)
			title := entity_name
			widget.set_default_position (False)
			widget.allow_resize
			widget.realize
			if retrieved_node = Void then
				widget_set_title (entity_name)
				set_size (300, 300)
				default_position := True
				x1 := a_parent.real_x + a_parent.width // 2 
							- widget.width //2
				y1 := a_parent.real_y + a_parent.height // 2 
							- widget.height //2
				set_x_y (x1, y1)
				if toolkit.name.is_equal ("MS_WINDOWS") then
					configure_count := 0
					-- Setting x, y under MS Windows does not cause
					-- a configure event before realization.
				end
				set_start_hidden (True)
			end
			add_window_geometry_action
			add_undo_redo_accelerator (widget)
			add_to_window_list
		end

	widget: TEMP_WIND

	popup is
		do
			update_label (True)
			widget.popup
		end

	popdown is
		do
			update_label (False)
			widget.popdown
		end

	add_window_geometry_action is
		do
			widget.set_parent_action ("<Configure>", Current, Void)
		end

	remove_window_geometry_action is
		do
			widget.remove_parent_action ("<Configure>")
		end

	create_context (a_parent: COMPOSITE_C): like Current is
			-- Create a context of the same type
		local
			void_parent: COMPOSITE
			create_command: CONTEXT_CREATE_CMD
		do
			Result := New
			Result.set_parent (a_parent)
			Result.generate_internal_name
			Result.oui_create (a_parent.widget)
				-- Void widget if context created for context catalog
			if widget /= Void then
				Result.set_size (width, height)
				copy_attributes (Result)
			end
			!!create_command
			create_command.execute (Result)
		end

feature -- File name

	base_file_name_without_dot_e: FILE_NAME is
		local
			tmp: STRING
		do
			tmp := clone (entity_name)
			tmp.to_lower
			tmp.replace_substring_all (Window_seed_to_lower,
						Resources.temp_window_file_name)
			!! Result.make_from_string (tmp)
		end

feature {NONE}

	find_parent (parent_name: STRING): COMPOSITE_C is
		local
			cursor: CURSOR
			found_parent: CONTEXT
			e_name: STRING
		do
			cursor := Shared_window_list.cursor
			from
				Shared_window_list.start
			until
				Shared_window_list.after or
				Result /= Void
			loop
				e_name := Shared_window_list.item.entity_name
				if e_name.is_equal (parent_name) then
					Result := Shared_window_list.item
				end
				Shared_window_list.forth
			end
			Shared_window_list.go_to (cursor)
		end

	Window_seed: STRING is "Temp_wind"

	Window_seed_to_lower: STRING is "temp_wind"

	namer: NAMER is
		once
			!!Result.make (Window_seed)
		end

	widget_set_title (new_title: STRING) is
			-- Set`title' to `new_title'
		do
			title := new_title
			widget.set_title (new_title)
		end

	widget_forbid_resize is
		do
			widget.forbid_resize
		end

	widget_allow_resize is
		do
			widget.allow_resize
		end 

	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
						Context_const.Geometry_format_nbr)
			opt_list.put (Context_const.temp_wind_att_form_nbr,
						Context_const.attribute_format_nbr)
		end

	update_visual_name_in_editor is
		local
			editor: CONTEXT_EDITOR
		do
			editor := context_catalog.editor (Current, 
					Context_const.temp_wind_att_form_nbr)
			if editor /= Void then
				editor.reset_current_form
			end
		end

feature 

	eiffel_type: STRING is "TEMP_WIND"

	full_type_name: STRING is "Temporary window"

	hide is
		do
			popdown
		end

	show is
		do
			popup
		end

	shown: BOOLEAN is
		do
			Result := widget.is_popped_up
		end

feature {NONE}

	copy_attributes (other_context: like Current) is
		do
			if title_modified then
				other_context.set_title (title)
			end
			if resize_policy_modified then
				other_context.disable_resize_policy (resize_policy_disabled)
			end
			Precursor (other_context)
			other_context.set_start_hidden (start_hidden)
		end

	description_text: STRING is
			-- Description text in indexing clause.
		do
			!! Result.make (50)
			Result.append ("Temporary window")
			if visual_name /= Void then
				Result.append (": ")
				Result.append (visual_name)
			end
			Result.append (".")
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
		end

feature {NONE}

	position_initialization (context_name: STRING): STRING is
			-- Eiffel code for the position of current context
			-- depending on the type of its parent
		do
			!!Result.make (0)
			if not default_position then
				function_bool_to_string (Result, "", 
					"set_default_position", False)
				function_int_int_to_string (Result, "", "set_x_y", x, y)
			end
			if size_modified then
				function_int_int_to_string (Result, "", "set_size", width, height)
			end
		end

-- ****************
-- Storage features
-- ****************

	
feature 

	stored_node: S_TEMP_WIND_R1 is
		do
			!!Result.make (Current)
		end

end
