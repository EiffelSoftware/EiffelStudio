
class STATE_EDITOR 

inherit

	EB_TOP_SHELL
		rename
			realize as shell_realize,
			make as eb_top_shell_make,
			destroy as shell_destroy
		redefine
			set_geometry
		end;
	EB_TOP_SHELL
		redefine
			realize, make, set_geometry,
			destroy
		select
			realize, make, destroy
		end;
	FUNC_EDITOR
		rename
			clear as old_clear,
			set_edited_function as old_set_edited_function
		redefine
			edited_function, menu_bar, output_stone, 
			input_stone, output_hole, input_hole, output_list, input_list
		end;
	FUNC_EDITOR
		redefine
			clear, edited_function, menu_bar, output_stone, 
			input_stone, output_hole, input_hole, output_list, input_list,
			set_edited_function
		select
			clear,
			set_edited_function
		end;
	WINDOWS
		select
			init_toolkit
		end
	CLOSEABLE

creation

	make

feature -- Geometry

	set_geometry is
		do
			set_size (Resources.state_ed_width,
					Resources.state_ed_height)
		end;

feature -- Input/output

	input_hole: CONTEXT_HOLE; 
	input_stone: FUNC_CON_STONE; 

	output_hole: BEHAVIOR_HOLE;
	output_stone: FUNC_BEH_STONE;

	input_list: CON_BOX;
	output_list: B_BOX;

feature -- Edited features

	edited_function: BUILD_STATE;

	set_edited_function (f: like edited_function) is
		do
			old_set_edited_function (f);
			update_title
		end;

feature 

	empty: BOOLEAN is
		do
			Result := (edited_function = Void)
		end;

	destroy is
		do
			unregister_holes;
			shell_destroy
		end;
	
	reset_stones is
		do
			input_stone.reset;
			output_stone.reset
		end;

	close is
		do
			clear;
			window_mgr.close (Current)
		end;

	clear is
		do
			old_clear;
			set_title (Widget_names.state_editor);
			set_icon_name (Widget_names.state_editor);
		end;


	realize is
		do
			shell_realize;
			hide_stones;
		end;

	update_title is
		 local
			tmp: STRING
		do
			!! tmp.make (0);
			tmp.append (Widget_names.state_name);
			tmp.append (": ");
			tmp.append (edited_function.label);
			set_title (tmp);
			set_icon_name (tmp)
		end;

	update_context_name (c: CONTEXT) is
			-- Update context name in Current editor for 
			-- context `c'.
		local
			finished: BOOLEAN;
			old_cur: CURSOR;
			icons: LINKED_LIST [FUNC_CON_IS]
		do
			icons := input_list.icons;
			old_cur := icons.cursor;
			from
				icons.start
			until
				icons.after or else finished
			loop
				if icons.item.data = c then
					finished := True;
					icons.item.update_label_text
				end;
				icons.forth
			end;
			icons.go_to (old_cur);
		end;

feature {NONE}

	create_output_stone (a_parent: COMPOSITE) is
		do
			!!output_stone.make (Current);
			output_stone.make_visible (a_parent);
			button_form.attach_left_widget (page_label, row_label, 5);
		end;

	create_input_stone (a_parent: COMPOSITE) is
		do
			!!input_stone.make (Current);
			input_stone.make_visible (a_parent);
		end;

feature {NONE} -- Interface

	menu_bar: STATE_BAR;
	
	make (a_name: STRING; a_screen: SCREEN) is
		local
			del_com: DELETE_WINDOW
		do
			eb_top_shell_make (a_name, a_screen);
			set_title (a_name);
			set_icon_name (a_name);
			set_icon_pixmap (Pixmaps.state_pixmap);
			initialize (Widget_names.form, Current);
			!! del_com.make (Current);
			set_delete_command (del_com);
			initialize_window_attributes;
		end;

end
