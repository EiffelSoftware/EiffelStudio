

class STATE_BAR 

inherit

	FUNCTION_BAR
		redefine
			edit_hole,
			set_function,
			make, unregister_holes
		end

creation

	make
	
feature {NONE}

	edit_hole: S_EDIT_HOLE;

	merge_hole: S_MERGE_HOLE;

	unregister_holes is
		do
			edit_hole.unregister;
			merge_hole.unregister;
		end;
	
	make (a_name: STRING; a_parent: COMPOSITE; ed: STATE_EDITOR) is
		local
			close_button: CLOSE_WINDOW_BUTTON;
		do
			form_create (a_name, a_parent);
			!! focus_label.make (Current);
			!! edit_hole.make (ed, Current);
			!! merge_hole.make (ed, Current);
			!! close_button.make (ed, Current, focus_label);
			attach_top (edit_hole, 0);
			attach_top (close_button, 0);
			attach_top (merge_hole, 0);
			attach_top (focus_label, 0);
			attach_left (edit_hole, 0);
			attach_right (close_button, 0);
			attach_left_widget (edit_hole, merge_hole, 0);
			attach_left_widget (merge_hole, focus_label, 60);
			attach_right_widget (close_button, focus_label, 60);
			attach_bottom (focus_label, 0);
			attach_bottom (edit_hole, 0);
			attach_bottom (close_button, 0);
			attach_bottom (merge_hole, 0);
		end;

feature

	focus_label: FOCUS_LABEL;

	hide_edit_stone is
		do
			if edit_hole.original_stone /= Void then
				edit_hole.reset;
			end;
		end;

	set_function (stone: STATE) is
		do
			if (stone = Void) then
				edit_hole.reset;
			else
				edit_hole.set_state_stone (stone);
			end
		end;

	update_name is
		do
			edit_hole.update_name;
		end;

end
