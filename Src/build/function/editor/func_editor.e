
deferred class FUNC_EDITOR 

inherit

	COMMAND;
	COMMAND_ARGS;
	CONSTANTS

feature {NONE} -- Anchors

	input_stone, output_stone: ICON_STONE;
			-- Input and output stones
			-- associated with the function
			-- editor

	input_hole, output_hole: ELMT_HOLE;
			-- Input and output holes
			-- associated with the function
			-- editor
	
feature -- Anchors

	input_list: FUNCTION_BOX [STONE];
	output_list: FUNCTION_BOX [STONE];
			-- Icons representing the edited
			-- function visually

feature -- Focus_label

	focus_label: FOCUS_LABEL is
		deferred
		end;

feature -- Edited function

	edited_function: FUNCTION;
			-- Currently edited function

	save_previous_function is
			-- Save values of currently 
			-- edited function.
		do
			if (edited_function /= Void) then
				reset_stones;
				edited_function.save_lists;
				edited_function.reset
			end
		end;

	set_edited_function (f: like edited_function) is
			-- Set `f' to be the currently edited
			-- function.
		require
			valid_f: f /= Void	
		do
			save_previous_function;
			edited_function := f;
			input_list.set (f.input_list);
			output_list.set (f.output_list);
			edited_function.set_lists (input_list, output_list);
			edited_function.set_editor (Current);
			if
				not input_list.empty
			then
				edited_function.go_i_th (1);
			end;
			display_page_number;
			menu_bar.set_function (edited_function)
		end;

	hide_stones is
			-- Hides input and output stones if they
			-- are not set
		do
			if (input_stone.original_stone = Void) then
				input_stone.hide
			end;
			if (output_stone.original_stone = Void) then
				output_stone.hide
			end;
		end;

	reset_stone (s: ICON_STONE) is
			-- Reset eith input and output stones 
			-- according to `s'.
		do
			if (s = input_stone) then
				edited_function.reset_input_stone;
			elseif (s = output_stone) then
				edited_function.reset_output_stone;
			end;		
		end;
	
	clear is
			-- Clear Current function editor.
		do
			save_previous_function;
			input_list.wipe_out;
			output_list.wipe_out;
			edited_function := Void;
		end; 

	reset_stones is
			-- Reset the both input and output stones.
		deferred
		end;

feature -- Display the page number details

	display_page_number is
			-- Display the page number and update the item
			-- count.
		local
			temp: STRING;
			changed: BOOLEAN;
			nbr_of_rows: INTEGER
		do
			!!temp.make (0);
			nbr_of_rows := input_list.number_of_rows_in_page;
			temp.extend ('(')
			temp.append (Widget_names.rows_label);
			temp.extend (' ');
			temp.append_integer (nbr_of_rows);
			temp.extend (')');
			row_label.set_text (temp);
			if
				page_number /= input_list.page_number
			then 
				page_number := input_list.page_number;
				changed := True
			end;
			if
				number_of_pages /= input_list.number_of_pages
			then 
				number_of_pages := input_list.number_of_pages;
				changed := True
			end;
			if
				changed
			then
				!!temp.make (0);
				temp.append (Widget_names.page_label);
				temp.extend (' ');
				temp.append_integer (page_number);
				temp.extend ('/');
				temp.append_integer (number_of_pages);
				page_label.set_text (temp)
			end
		end;

	unregister_holes is
		do
			input_hole.unregister;
			output_hole.unregister;
			menu_bar.unregister_holes;
			input_list.unregister_holes;
			output_list.unregister_holes;
		end;

feature {ELMT_HOLE}

	update (hole: ELMT_HOLE) is
			-- Update the function with the
			-- information contained in the
			-- entry hole `hole'.
		do
			if not (edited_function = Void) then
				if (hole = input_hole) then
					set_input_stone (input_hole.stone.original_stone);
					edited_function.set_input_stone (input_hole.stone.original_stone);
				elseif (hole = output_hole) then
					set_output_stone (output_hole.stone.original_stone);
					edited_function.set_output_stone (output_hole.stone.original_stone)
				end;
				edited_function.drop_pair;
			end
		end;

feature {NONE}

	set_input_stone (st: STONE) is
			-- Set original_stone of input_stone to `st'.
		do
			input_stone.set_original_stone (st);
		end;

	set_output_stone (st: STONE) is
			-- Set original_stone of output_stone to `st'.
		do
			output_stone.set_original_stone (st);
		end;

feature

	form, input_form, output_form, button_form: FORM;

feature {NONE}

	input_frame, output_frame: FRAME;
	menu_bar: FUNCTION_BAR;
	arrow_b, arrow_b1: ARROW_B;
	page_label, row_label: LABEL_G;
	page_number, number_of_pages: INTEGER;

	create_input_stone (a_parent: COMPOSITE) is
			-- Create the input_stone.
		deferred
		end;

	create_output_stone (a_parent: COMPOSITE) is
			-- Create the output_stone.
		deferred
		end;

	initialize (a_name: STRING; a_parent: COMPOSITE) is
		local
			tmp: STRING
		do
				-- ***************
				-- Widget Creation
				-- ***************

			!!form.make (a_name, a_parent);
			!!menu_bar.make (Widget_names.bar, form, Current);
			!!input_form.make (Widget_names.form1, form);
			!!output_form.make (Widget_names.form2, form);
			!!button_form.make (Widget_names.form3, form);
			!!arrow_b.make (Widget_names.button, button_form);
			!!arrow_b1.make (Widget_names.button1, button_form);
			!!page_label.make (Widget_names.label, button_form);
			!!row_label.make (Widget_names.label1, button_form);
			create_input_stone (input_form);
			create_output_stone (output_form);
			!!input_hole.make (input_form, Current);
			!!output_hole.make (output_form, Current);
			!!input_frame.make (Widget_names.frame, input_form);
			!!output_frame.make (Widget_names.frame1, output_form);
			!!input_list.make (Widget_names.row_column, input_frame, Current);
			!!output_list.make (Widget_names.row_column1, output_frame, Current);
			!! tmp.make (0);
			tmp.extend ('(');
			tmp.append (Widget_names.rows_label);
			tmp.append (")  ");
			row_label.set_text (tmp);
			!! tmp.make (0);
			tmp.append (Widget_names.page_label);
			tmp.append (" 1 of 1");
			page_label.set_text ("Page 1 of 1");

				-- ******
				-- Values
				-- ******

			arrow_b.set_left;
			arrow_b1.set_right;

				-- ***********
				-- Attachments
				-- ***********

			form.set_fraction_base (2);
			form.attach_top (menu_bar, 1);
			form.attach_left (menu_bar, 1);
			form.attach_right (menu_bar, 1);
			form.attach_top_widget (menu_bar, input_form, 3);
			form.attach_top_widget (menu_bar, output_form, 3);
			form.attach_bottom_widget (button_form,input_form, 5);
			form.attach_bottom_widget (button_form,output_form,  5);
			form.attach_left (input_form, 1);
			form.attach_right (output_form, 1);
			form.attach_right_position (input_form, 1);
			form.attach_left_position (output_form, 1);
			form.attach_left (button_form, 1);
			form.attach_right (button_form, 1);
			form.attach_bottom (button_form, 1);

			input_form.attach_top (input_hole, 1);
			input_form.attach_top (input_stone, 1);
			input_form.attach_bottom (input_frame, 3);
			input_form.attach_top_widget (input_stone, input_frame, 3);
			input_form.attach_top_widget (input_hole, input_frame, 3);
			input_form.attach_left_widget (input_hole, input_stone, 3);
			input_form.attach_right (input_frame, 3);
			input_form.attach_left (input_frame, 3);
			input_form.attach_left (input_hole, 3);

			output_form.attach_top (output_hole, 1);
			output_form.attach_top (output_stone, 1);
			output_form.attach_bottom (output_frame, 3);
			output_form.attach_top_widget (output_stone, output_frame, 3);
			output_form.attach_top_widget (output_hole, output_frame, 3);
			output_form.attach_left_widget (output_hole, output_stone, 3);
			output_form.attach_right (output_frame, 3);
			output_form.attach_left (output_frame, 3);
			output_form.attach_left (output_hole, 3);


			button_form.attach_right (arrow_b1, 2);
			button_form.attach_bottom (arrow_b, 5);
			button_form.attach_bottom (arrow_b, 5);
			button_form.attach_right_widget (arrow_b1, arrow_b, 4);
			button_form.attach_left (page_label, 1);
			button_form.attach_top (page_label, 5);
			button_form.attach_top (row_label, 5);
			button_form.attach_bottom (page_label, 5);
			button_form.attach_bottom (row_label, 5);

				-- *********
				-- Callbacks
				-- *********

			arrow_b.add_activate_action (Current, First);
			arrow_b1.add_activate_action (Current, Second);
			display_page_number;
		end;


	execute (argument: ICON) is
		do
			if (argument = First) then
				input_list.go_previous_page;
				if
					input_list.page_changed
				then
					output_list.go_previous_page;
					display_page_number
				end
			elseif (argument = Second) then
				input_list.go_next_page;
				if
					input_list.page_changed
				then
					output_list.go_next_page;
					display_page_number
				end
			end
		end;

end
