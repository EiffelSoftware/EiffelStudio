

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

	edit_stone: S_EDIT_STONE;

	
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
			!!edit_stone;
			edit_stone.make_visible (Current);
			!!merge_hole.make (ed);
			merge_hole.make_visible (Current);
			!!close_button.make (ed);
			close_button.make_visible (Current);

			attach_top (edit_hole, 0);
			attach_top (close_button, 0);
			attach_top (merge_hole, 0);
			attach_left (edit_hole, 0);
			attach_right (close_button, 0);
			attach_left_widget (edit_hole, edit_stone, 10);
			attach_left_widget (edit_stone, merge_hole, 40);
		end;

	hide_edit_stone is
		do
			edit_stone.hide
		end;

	set_function (stone: STATE) is
		do
			if (stone = Void) then
				edit_stone.reset
			else
				edit_stone.set_state_stone (stone);
				if edit_stone.realized then
					edit_stone.show
				end
			end
		end;

	update_name is
		do
			edit_stone.update_name
		end;

end
