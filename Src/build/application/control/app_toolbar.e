
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

	make (a_name: STRING; a_parent: COMPOSITE; app_editor: APP_EDITOR) is
			-- Create application menu bar.
		local
			new_state_b: APP_NEW_STATE;
			init_state_hole: APP_INIT_ST_H;
			self_hole: APP_SELF_HOLE;
			return_hole: APP_RETURN_H;
			exit_hole: APP_EXIT_HOLE;
		do
			!!new_state_b.make;
			form_create (a_name, a_parent);
			!!self_hole.make (app_editor);
			!!return_hole.make (app_editor);
			!!exit_hole.make;
			!!init_state_hole.make (app_editor); 

			new_state_b.make_visible (Current);
			return_hole.make_visible (Current);
			self_hole.make_visible (Current);
			init_state_hole.make_visible (Current);
			exit_hole.make_visible (Current);

			attach_top (new_state_b, 2);
			attach_top (init_state_hole, 2);
			attach_top (return_hole, 2);
			attach_top (exit_hole, 2);
			attach_top (self_hole, 2);
			attach_left (new_state_b, 0);
			attach_left_widget (new_state_b, init_state_hole, 0);
			attach_left_widget (init_state_hole, return_hole, 0);
			attach_left_widget (return_hole, self_hole, 0);
			attach_left_widget (self_hole, exit_hole, 0);
		end;

end 
