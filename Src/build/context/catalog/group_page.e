indexing
	description: "Page in the context catalog representing the %
				% group category."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class GROUP_PAGE 

inherit

	CONTEXT_CAT_PAGE

creation
	
	make
	
feature 

	icon_box: GROUP_BOX
	
	clear is
			-- Clear the group page
		do
			icon_box.wipe_out
		end

feature {NONE}

	build_interface is
		local
			scrolled_w: SCROLLED_W
			group_hole: GROUP_HOLE
			group_name: LABEL
			text: TEXT_FIELD
		do
			!! group_hole.make (Current)
			group_hole.set_background_color (background_color) 
			!! scrolled_w.make (Widget_names.scrolledwindow, Current)
			!! icon_box.make (Widget_names.icon_box, scrolled_w)
			icon_box.set_column_layout
			icon_box.set_preferred_count (5)

			!! group_name.make (Widget_names.group_name, Current)
			group_name.set_background_color (background_color)	
			group_name.set_foreground_color (foreground_color)
			!! text.make (Widget_names.textfield, Current)

			text.set_size (80, 20)
			text.add_activate_action (group_hole, text)

			attach_top (scrolled_w, 1)
			attach_left (scrolled_w, 1)
			attach_right (scrolled_w, 1)
			attach_top_widget (scrolled_w, group_hole, 15)
			attach_top_widget (scrolled_w,group_name, 17)
			attach_top_widget (scrolled_w, text, 15)

			attach_left (group_hole, 0)
			attach_left_widget (group_hole, group_name, 10)
			attach_left_widget (group_name, text, 5)
			attach_right (text, 0)

			attach_bottom (group_hole, 0)
			attach_bottom (group_name, 0)
			
            button.set_focus_string (Focus_labels.groups_label)
        end

	symbol: PIXMAP is
		do
			Result := Pixmaps.groups_pixmap
		end

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_groups_pixmap
		end


end
