

class STATE_BAR 

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

	edit_hole: S_EDIT_HOLE;


	
feature 

	make (a_name: STRING; a_parent: COMPOSITE; ed: STATE_EDITOR) is
		local
			merge_hole: S_MERGE_HOLE;
			close_button: ST_EDIT_CLOSE_B;
			Nothing: ANY
		do
			form_create (a_name, a_parent);
			!!edit_hole.make (ed);
			edit_hole.make_visible (Current);
			!!merge_hole.make (ed);
			merge_hole.make_visible (Current);
			!!close_button.make (ed);
			close_button.make_visible (Current);

			attach_top (edit_hole, 0);
			attach_top (close_button, 0);
			attach_top (merge_hole, 0);
			attach_left (edit_hole, 0);
			attach_right (close_button, 0);
			attach_left_widget (edit_hole, merge_hole, 60);
		end;

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
