
class GROUP_PAGE 

inherit

	CONTEXT_CAT_PAGE

creation
	
	make
	
feature 

	icon_box: GROUP_BOX;
	
	clear is
			-- Clear the group page
		do
			icon_box.wipe_out
		end;

feature {NONE}

	build is
		local
			scrolled_w: SCROLLED_W;
			group_hole: GROUP_HOLE;
			group_name: LABEL;
			text: TEXT_FIELD;
		do
			!!group_hole.make (Current);
			!!scrolled_w.make (S_crolledwindow, Current);
			!!icon_box.make (I_con_box, scrolled_w);

			!!group_name.make (G_roup_name, Current);

			!!text.make (T_extfield, Current);
			text.set_size (60, 33);
			text.set_action ("<Key>Return", group_hole, text);

			attach_top (scrolled_w, 1);
			attach_left (scrolled_w, 1);
			attach_right (scrolled_w, 1);
			attach_bottom_widget (group_hole, scrolled_w, 10);

			attach_bottom (group_hole, 1);
			attach_bottom (group_name, 5);
			attach_bottom (text, 1);

			attach_left (group_hole, 1);
			attach_left_widget (group_hole, group_name, 10);
			attach_left_widget (group_name, text, 10);
			attach_right (text, 1);
		end;

end
