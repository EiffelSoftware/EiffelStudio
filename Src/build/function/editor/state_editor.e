
class STATE_EDITOR 

inherit

	TOP_SHELL
		rename
			realize as shell_realize,
			make as top_shell_make
		export
			{NONE} all;
			{ANY} raise, set_x_y, x, y, width, height, set_size
		undefine
			init_toolkit
		end;
	TOP_SHELL
		undefine
			init_toolkit
		redefine
			realize, make
		select
			realize, make
		end;
	FUNC_EDITOR
		rename
			clear as old_clear
		redefine
			edited_function, menu_bar, output_stone, 
			input_stone, output_hole, input_hole, output_list, input_list
		end;
	FUNC_EDITOR
		redefine
			clear, edited_function, menu_bar, output_stone, 
			input_stone, output_hole, input_hole, output_list, input_list
		select
			clear
		end;
	WINDOWS

creation

	make

	
feature 

	empty: BOOLEAN is
		do
			Result := (edited_function = Void)
		end;

	
feature {NONE}

	reset_Stones is
		do
			input_stone.reset;
			output_stone.reset
		end;

	
feature 

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
			menu_bar.set_function (void_state);
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
		do
			top_shell_make (a_name, a_screen);
			initialize ("Editor Form", Current);
		end;

	
feature {NONE}

	create_output_stone (a_parent: COMPOSITE) is
		do
			!!output_stone.make (Current);
			output_stone.make_visible (a_parent);
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
