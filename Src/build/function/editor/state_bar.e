

class STATE_BAR 

inherit

	FUNCTION_BAR
		redefine
			edit_hole,
			make, unregister_holes
		end

creation

	make
	
feature {NONE}

	edit_hole: S_EDIT_HOLE;

	merge_hole: S_MERGE_HOLE;

	trash_hole: CUT_HOLE;

	unregister_holes is
		do
			trash_hole.unregister;
			edit_hole.unregister;
			merge_hole.unregister;
		end;
	
	make (a_name: STRING; a_parent: COMPOSITE; ed: STATE_EDITOR) is
		local
			close_button: CLOSE_WINDOW_BUTTON;
		do
			form_create (a_name, a_parent);
			!! trash_hole.make (Current);
			!! edit_hole.make (ed, Current);
			!! merge_hole.make (ed, Current);
			!! close_button.make (ed, Current);
			attach_top (edit_hole, 0);
			attach_top (close_button, 0);
			attach_top (merge_hole, 0);
			attach_top (trash_hole, 0);
			attach_left (edit_hole, 0);
			attach_right (close_button, 0);
			attach_left_widget (edit_hole, merge_hole, 0);
			attach_left_widget (merge_hole, trash_hole, 0);
			attach_bottom (edit_hole, 0);
			attach_bottom (close_button, 0);
			attach_bottom (merge_hole, 0);
			attach_bottom (trash_hole, 0);
		end;

end
