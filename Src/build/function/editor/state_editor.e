
class STATE_EDITOR 

inherit

	TOP_SHELL
		rename
			realize as shell_realize,
			make as top_shell_make,
			destroy as shell_destroy
		export
			{NONE} all;
			{ANY} raise, set_x_y, x, y, width, height, set_size
		end;
	TOP_SHELL
		redefine
			realize, make,
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
	WINDOWS;
	CLOSEABLE

creation

	make

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
	
feature 

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
		local
			void_state: STATE
		do
			old_clear;
			set_title (Widget_names.state_editor);
			set_icon_name (Widget_names.state_editor);
			menu_bar.set_function (void_state);
		end;

	set_edited_function (f: like edited_function) is
		do
			old_set_edited_function (f);
			update_title
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

-- ***************
-- Anchor features
-- ***************

	
feature {NONE}

	input_hole: CONTEXT_HOLE; 
	input_stone: FUNC_CON_STONE; 

	output_hole: BEHAVIOR_HOLE;
	output_stone: FUNC_BEH_STONE;

	
feature 

	input_list: CON_BOX;
	output_list: B_BOX;
	
	
feature {NONE}

	menu_bar: STATE_BAR;
	
	
feature 

	edited_function: STATE;

-- ********************
-- EiffelVision Section
-- ********************

	make (a_name: STRING; a_screen: SCREEN) is
		local
			del_com: DELETE_WINDOW
		do
			top_shell_make (a_name, a_screen);
			set_title (a_name);
			set_icon_name (a_name);
			set_icon_pixmap (Pixmaps.state_pixmap);
			initialize (Widget_names.form, Current);
			!! del_com.make (Current);
			set_delete_command (del_com);
		end;

	
feature {NONE}

	focus_label: FOCUS_LABEL is
		do
			Result := menu_bar.focus_label
		end;

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

	
feature 

	realize is
		do
			shell_realize;
			hide_stones;
			if (edited_function = Void) then
				menu_bar.hide_edit_stone
			end
		end;

	update_name is
		do
			menu_bar.update_name
		end;

end
