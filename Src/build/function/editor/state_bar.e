

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

	edit_hole: S_EDIT_HOLE

	merge_hole: S_MERGE_HOLE

	trash_hole: CUT_HOLE

	unregister_holes is
		do
			trash_hole.unregister
			edit_hole.unregister
			merge_hole.unregister
		end
	
	make (a_name: STRING; a_parent: COMPOSITE; ed: STATE_EDITOR) is
		local
			separator1, separator2: THREE_D_SEPARATOR
		do
			form_create (a_name, a_parent)
			!! separator1.make ("", Current)
			!! separator2.make ("", Current)
			!! trash_hole.make (Current)
			!! edit_hole.make (ed, Current)
			!! merge_hole.make (ed, Current)
			attach_top (separator1, 0)
			attach_left (separator1, 0)
			attach_right (separator1, 0)
			attach_top_widget (separator1, edit_hole, 0)
			attach_top_widget (separator1, merge_hole, 0)
			attach_top_widget (separator1, trash_hole, 0)
			attach_left (edit_hole, 0)
			attach_left_widget (edit_hole, merge_hole, 0)
			attach_left_widget (merge_hole, trash_hole, 0)
			attach_bottom_widget (separator2, edit_hole, 0)
			attach_bottom_widget (separator2, merge_hole, 0)
			attach_bottom_widget (separator2, trash_hole, 0)
			attach_bottom (separator2, 0)
			attach_left (separator2, 0)
			attach_right (separator2, 0)
		end

end
