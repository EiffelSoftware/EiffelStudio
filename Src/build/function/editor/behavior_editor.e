indexing
	description: "Behavior editor window."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class BEHAVIOR_EDITOR

inherit
	FUNC_EDITOR
		rename
			initialize as make
		redefine
			input_hole, output_hole,
			edited_function,
			edit_hole,
			clear
		end

creation
	make

feature -- Input/output

	input_hole: EVENT_HOLE
	output_hole: COMMAND_HOLE

--	input_stone: FUNC_EV_STONE
--	output_stone: FUNC_COM_STONE

feature -- Editing features

	edited_function: BEHAVIOR

	current_state: BUILD_STATE

	associated_context_editor: CONTEXT_EDITOR

	edited_context: CONTEXT is
			-- Context currently edited.
		require
			valid_editor: associated_context_editor /= Void
		do
			Result := associated_context_editor.edited_context
		ensure
			valid_result: Result /= Void
		end

	set_current_state (s: BUILD_STATE) is
			-- Set current_state to `s'. Also update
			-- the label in the menu_bar.
		do
			current_state := s
			state_label.set_text (s.label)
		end

	set_context_editor (ed: CONTEXT_EDITOR) is
			-- Set associated_context_editor to `c'.
		do
			associated_context_editor := ed
		end

	clear is
		do
			{FUNC_EDITOR} Precursor
			current_state := Void
		end

	update_behavior (s: BUILD_STATE) is
			-- Update Current with state `s'.
		local
			prev_s: BUILD_STATE
			prev_b, b: BEHAVIOR
			c: CONTEXT
		do
			c := edited_context
			s.find_input (c)
			if not s.after then
				b := s.output.data
			else	
				create b.make
				b.set_internal_name ("")
				b.set_context (c)
				s.add (c, b)
			end
			set_edited_function (b)
			set_current_state (s)
		end

feature {NONE} -- Interface

	edit_hole: B_EDIT_HOLE

	state_label: EV_LABEL

	create_menu (par: EV_BOX) is
		local
			hbox: EV_HORIZONTAL_BOX
			tbar: EV_TOOL_BAR
			state_h: STATE_HOLE
		do
			create hbox.make (par)
			par.set_child_expandable (hbox, False)
			create tbar.make (hbox)
			create edit_hole.make_with_editor (tbar, Current)
			create state_label.make_with_text (hbox, Widget_names.behaviour_state_label)
			create tbar.make (hbox)
			create state_h.make (tbar)
			state_h.set_update_procedure (~update_behavior)
			create state_label.make (hbox)
		end

	clear_menu is
		do
			edit_hole.set_empty_symbol
			state_label.set_text ("")
		end

end -- class BEHAVIOR_EDITOR

