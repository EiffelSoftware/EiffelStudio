

class BEHAVIOR_BAR 

inherit

	FUNCTION_BAR
		redefine
			edit_hole,
			make,
			unregister_holes
		end

creation

	make

feature {NONE}

	edit_hole: B_EDIT_HOLE;

	state_hole: B_STATE_H;

	unregister_holes is
		do
			edit_hole.unregister;
			state_hole.unregister
		end;

feature 

	label1: LABEL;

	make (a_name: STRING; a_parent: COMPOSITE; ed: BEHAVIOR_EDITOR) is
		local
			label: LABEL;
		do
			form_create (a_name, a_parent);
			!!edit_hole.make (ed, Current);
			!!state_hole.make (ed, Current);
			!!label.make (Widget_names.behaviour_state_label, Current);
			!!label1.make (Widget_names.label, Current);

			set_fraction_base (2);
			attach_top (label, 1);
			attach_top (label1, 1);
			attach_top (edit_hole, 1);
			attach_top (state_hole, 1);
			attach_bottom (label, 1);
			attach_bottom (label1, 1);
			attach_bottom (edit_hole, 1);
			attach_bottom (state_hole, 1);

			attach_left (edit_hole, 1);
			attach_left_widget (edit_hole, label, 1);
			attach_left_position (state_hole, 1);
			attach_left_widget (state_hole, label1, 1);
		end;

end
