

class BEHAVIOR_BAR 

inherit

	FUNCTION_BAR
		export
			{NONE} all
		redefine
			edit_hole,
			set_function,
			make
		end

creation

	make

	
feature {NONE}

	edit_hole: B_EDIT_HOLE;

	
feature 

	label1: LABEL_G;

	make (a_name: STRING; a_parent: COMPOSITE; ed: BEHAVIOR_EDITOR) is
		local
			state_hole: B_STATE_H;
			label: LABEL_G;
		do
			form_create (a_name, a_parent);
			!!edit_hole.make (ed);
			edit_hole.make_visible (Current);
			!!state_hole.make (ed);
			state_hole.make_visible (Current);
			!!label.make (L_abel, Current);
			!!label1.make (L_abel1, Current);

			attach_top (edit_hole, 0);
			attach_top (label, 0);
			attach_top (state_hole, 0);
			attach_top (label1, 0);
			attach_bottom (edit_hole, 0);
			attach_bottom (label, 0);
			attach_bottom (state_hole, 0);
			attach_bottom (label1, 0);

			attach_left (edit_hole, 0);
			attach_left_widget (edit_hole, label, 0);
			attach_left_widget (label, state_hole, 0);
			attach_left_widget (state_hole, label1, 0);
			attach_right (label1, 0);
			label.set_text (Behaviour_state_label);
		end;

	set_function (b: BEHAVIOR) is
		do
			edit_hole.set_original_stone (b)
		end;

end
