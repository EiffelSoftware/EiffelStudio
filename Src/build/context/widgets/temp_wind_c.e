indexing
	description: "Context representing a temporary window.%
				% Window created with a parent window."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class TEMP_WIND_C 

inherit
	WINDOW_C
		redefine
			copy_attributes, context_initialization, 
			position_initialization,
			update_visual_name_in_editor,
			description_text, creation_procedure_text
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.container_page.temp_wind_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: like gui_object) is
		local
			x1, y1: INTEGER
		do
			create gui_object.make (a_parent)
			gui_object.set_title (entity_name)
--			if retrieved_node = Void then
					-- Not retrieving widget from project
				set_size (300, 300)
				default_position := True
				x1 := a_parent.x + a_parent.width // 2 - gui_object.width // 2
				y1 := a_parent.y + a_parent.height // 2 - gui_object.height //2
				set_x_y (x1, y1)
--				set_start_hidden (True)
--			end
			add_to_window_list
			gui_object.show
		end

feature {NONE} -- Internal namer

-- 	find_parent (parent_name: STRING): COMPOSITE_C is
-- 		local
-- 			cursor: CURSOR
-- 			found_parent: CONTEXT
-- 			e_name: STRING
-- 		do
-- 			cursor := Shared_window_list.cursor
-- 			from
-- 				Shared_window_list.start
-- 			until
-- 				Shared_window_list.after or
-- 				Result /= Void
-- 			loop
-- 				e_name := Shared_window_list.item.entity_name
-- 				if e_name.is_equal (parent_name) then
-- 					Result := Shared_window_list.item
-- 				end
-- 				Shared_window_list.forth
-- 			end
-- 			Shared_window_list.go_to (cursor)
-- 		end

	Window_seed: STRING is "Temp_wind"

	Window_seed_to_lower: STRING is "temp_wind"

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
-- 						Context_const.Geometry_format_nbr)
-- 			opt_list.put (Context_const.temp_wind_att_form_nbr,
-- 						Context_const.attribute_format_nbr)
-- 		end

	update_visual_name_in_editor is
		local
--			editor: CONTEXT_EDITOR
		do
-- 			editor := context_catalog.editor (Current, 
-- 					Context_const.temp_wind_att_form_nbr)
-- 			if editor /= Void then
-- 				editor.reset_current_form
-- 			end
		end

feature -- Code generation

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

	eiffel_type: STRING is "TEMP_WIND"

	full_type_name: STRING is "Temporary window"

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

feature {NONE} -- Code generation

	copy_attributes (other_context: like Current) is
		do
			if title_modified then
				other_context.set_title (title)
			end
			if resize_policy_modified then
				other_context.disable_resize_policy (resize_policy_disabled)
			end
			Precursor (other_context)
--			other_context.set_start_hidden (start_hidden)
			other_context.set_size (width, height)
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

	creation_procedure_text: STRING is
		do
			!! Result.make (100)
			Result.append ("%N%Tmake (a_name: STRING; a_parent: COMPOSITE) is%N%T%Tdo%N")
			Result.append ("%T%T%TPrecursor (a_name, a_parent)%N")
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

-- 	stored_node: S_TEMP_WIND_R1 is
-- 		do
-- 			!!Result.make (Current)
-- 		end

end -- class TEMP_WIND_C

