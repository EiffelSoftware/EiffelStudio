
class APP_BAR 

inherit

	FORM
		rename
			make as form_create
		export
			{NONE} all
		end;

creation

	make
	
feature 

	focus_label: FOCUS_LABEL;

	make (a_name: STRING; a_parent: COMPOSITE; app_editor: APP_EDITOR) is
			-- Create application menu bar.
		local
			new_state_b: APP_NEW_STATE;
			init_state_hole: APP_INIT_ST_H;
			self_hole: APP_SELF_HOLE;
			return_hole: APP_RETURN_H;
			exit_hole: APP_EXIT_HOLE;
			close_b: CLOSE_WINDOW_BUTTON
		do
            form_create (a_name, a_parent);
			!! focus_label.make (Current);
			!! close_b.make (app_editor, Current, focus_label);
			!! new_state_b.make (Current);
			!! self_hole.make (Current);
			!! return_hole.make (Current);
			!! exit_hole.make (Current);
			!! init_state_hole.make (Current); 

			attach_top (new_state_b, 0);
			attach_top (init_state_hole, 0);
			attach_top (return_hole, 0);
			attach_top (exit_hole, 0);
			attach_top (self_hole, 0);
			attach_top (close_b, 0);
			attach_top (focus_label, 0);
			attach_left (new_state_b, 0);
			attach_left_widget (new_state_b, init_state_hole, 0);
			attach_left_widget (init_state_hole, return_hole, 0);
			attach_left_widget (return_hole, self_hole, 0);
			attach_left_widget (self_hole, exit_hole, 0);
			attach_left_widget (exit_hole, focus_label, 0);
			attach_right_widget (close_b, focus_label, 0);
			attach_right (close_b, 0);
			attach_bottom (focus_label, 0);
			attach_bottom (new_state_b, 0);
			attach_bottom (init_state_hole, 0);
			attach_bottom (return_hole, 0);
			attach_bottom (exit_hole, 0);
			attach_bottom (self_hole, 0);
			attach_bottom (close_b, 0);
		end;

end 
