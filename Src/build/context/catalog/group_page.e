
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

	build_interface is
		local
			scrolled_w: SCROLLED_W;
			group_hole: GROUP_HOLE;
			group_name: LABEL;
			text: TEXT_FIELD;
		do
			!!group_hole.make (Current);
			!!scrolled_w.make (Widget_names.scrolledwindow, Current);
			!!icon_box.make (Widget_names.icon_box, scrolled_w);
			icon_box.set_row_layout;
			icon_box.set_preferred_count (5);

			!!group_name.make (Widget_names.group_name, Current);

			!!text.make (Widget_names.textfield, Current);
			text.set_size (60, 33);
			text.add_activate_action (group_hole, text);

			attach_top (scrolled_w, 1);
			attach_left (scrolled_w, 1);
			attach_right (scrolled_w, 1);
			attach_bottom_widget (group_hole, scrolled_w, 10);

			attach_bottom (group_hole, 1);
			attach_bottom (group_name, 5);
			attach_bottom (text, 1);

			attach_left (group_hole, 1);
			attach_left_widget (group_hole, group_name, 40);
			attach_left_widget (group_name, text, 10);
			attach_right (text, 1);
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.groups_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_groups_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.groups_label
		end;

end
