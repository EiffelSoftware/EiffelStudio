
class BEHAVIOR_EDITOR 

inherit

	FUNC_EDITOR
		export
			{ANY} all
		redefine
			input_list, output_list,
			input_hole, output_hole,
			input_stone, output_stone,
			menu_bar, edited_function
		end

creation

	make
	
feature {NONE}

	reset_Stones is
		do
			input_stone.reset;
			output_stone.reset
		end;

-- ***************
-- Anchor features 
-- ***************

	input_hole: EVENT_HOLE;
	input_stone: FUNC_EV_STONE;

	output_hole: COMMAND_HOLE;
	output_stone: FUNC_COM_STONE;

	
feature 

	input_list: EV_BOX;
	
	output_list: COM_BOX;

	
feature {NONE}

	menu_bar: BEHAVIOR_BAR;

	
feature 

	edited_function: BEHAVIOR;

-- ****************
-- Editing features
-- ****************

	current_state: STATE;

	edited_context: CONTEXT;
			-- Context currently edited.

	set_current_state (s: STATE) is
			-- Set current_state to `s'. Also update
			-- the label in the menu_bar.
		do
			current_state := s;
			if not (s.visual_name = Void) then
				menu_bar.label1.set_text (s.visual_name)
			else
				menu_bar.label1.set_text (s.internal_name)
			end;
		end;

	set_edited_context (c: CONTEXT) is
			-- Set edited_context to `c'.
		do
			edited_context := c
		end;

-- ********************
-- EiffelVision Section
-- ********************

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			initialize (a_name, a_parent);
			form.detach_top (button_form);
			button_form.detach_left (arrow_b1);
			button_form.detach_left (arrow_b);
			button_form.set_fraction_base(2);
			button_form.attach_right_position (page_label, 1);
			button_form.attach_left_position (row_label, 1);
			button_form.detach_right (row_label);
			--button_form.attach_left_widget (page_label, row_label, 1);
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

end
