
class BEHAVIOR_EDITOR 

inherit

	FUNC_EDITOR
		rename
			clear as func_clear
		redefine
			input_list, output_list,
			input_hole, output_hole,
			input_stone, output_stone,
			menu_bar, edited_function
		end
	FUNC_EDITOR
		redefine
			input_list, output_list,
			input_hole, output_hole,
			input_stone, output_stone,
			menu_bar, edited_function,
			clear
		select
			clear
		end

creation

	make
	
feature -- Input/output

	input_hole: EVENT_HOLE;
	input_stone: FUNC_EV_STONE;

	output_hole: COMMAND_HOLE;
	output_stone: FUNC_COM_STONE;
	
	input_list: EV_BOX;
	output_list: COM_BOX;
	
feature -- Editing features

	edited_function: BEHAVIOR;

	current_state: BUILD_STATE;

	associated_context_editor: CONTEXT_EDITOR;

	edited_context: CONTEXT is
			-- Context currently edited.
		require
			valid_editor: associated_context_editor /= Void
		do
			Result := associated_context_editor.edited_context
		ensure
			valid_result: Result /= Void
		end;

	reset_stones is
		do
			input_stone.reset;
			output_stone.reset
		end;

	set_current_state (s: BUILD_STATE) is
			-- Set current_state to `s'. Also update
			-- the label in the menu_bar.
		do
			current_state := s;
			menu_bar.label1.set_text (s.label)
		end;

	set_context_editor (ed: CONTEXT_EDITOR) is
			-- Set associated_context_editor to `c'.
		do
			associated_context_editor := ed
		end;

	clear is
		do
			func_clear;
			current_state := Void
		end;

feature {NONE} -- Interface

	menu_bar: BEHAVIOR_BAR;

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			initialize (a_name, a_parent);
			form.detach_top (button_form);
				-- For some reason, motif attaches the left arrow
				-- to the left side of the button form when Current
				-- is placed in the context editor (the state editor
				-- does not have this problem) - dinov.
			button_form.detach_left (right_arrow);
			button_form.detach_left (left_arrow);
			button_form.detach_right (row_label);
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
