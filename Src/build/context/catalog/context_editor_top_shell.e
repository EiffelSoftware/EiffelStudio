indexing
	description: "An independant context editor."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	CONTEXT_EDITOR_TOP_SHELL

inherit
	CONTEXT_EDITOR
		rename
			raise as composite_raise,
			implementation as composite_implementation
		undefine
			set_x_y, top,
			realize, screen
		redefine
			destroy
		select
			init_toolkit
		end

	EB_TOP_SHELL
		redefine
			make, destroy, set_geometry
		select
			raise, implementation
		end

	CLOSEABLE

creation
	make

feature -- Creation

	make (a_name: STRING a_screen: SCREEN) is
		local
			i: INTEGER
			close_button: CLOSE_WINDOW_BUTTON
			geometry_form: GEOMETRY_FORM
			label_text_form: LABEL_TEXT_FORM
			perm_wind_form: PERM_WIND_FORM
			temp_wind_form: TEMP_WIND_FORM
			separator_form: SEPARATOR_FORM
			text_form: TEXT_FORM
			toggle_form: TOGGLE_FORM
			menu_form: MENU_FORM
			bar_form: BAR_FORM
			pict_color_form: PICT_COLOR_FORM
			arrow_b_form: ARROW_B_FORM
			scroll_l_form: SCROLL_L_FORM
			font_form: FONT_FORM
			scale_form: SCALE_FORM
			pulldown_form: PULLDOWN_FORM
			text_field_form: TEXT_FIELD_FORM
			drawing_box_form: DRAWING_BOX_FORM
			bull_resize_form: BULL_RESIZE_FORM
			grid_form: GRID_FORM
			del_com: DELETE_WINDOW
			focus_area_form: FORM
		do
			!!form_list.make (1, Context_const.total_nbr_of_forms);

			Precursor (a_name, a_screen);
			set_title (Widget_names.context_editor);
			set_icon_name (Widget_names.context_editor);
			if Pixmaps.context_pixmap.is_valid then
				set_icon_pixmap (Pixmaps.context_pixmap);
			end;
			!!top_form.make (Widget_names.form, Current)
			!!focus_area_form.make (Widget_names.form1, top_form);

			!! context_hole.make (Current, focus_area_form);
			!! trash_hole.make (focus_area_form);
			!! close_button.make (Current, focus_area_form)
			!! first_separator.make (Widget_names.separator, top_form)
			first_separator.set_horizontal (True)
			!! second_separator.make (Widget_names.separator1, top_form)
			second_separator.set_horizontal (True)
			!! formats_rc.make (Widget_names.row_column, top_form) 
			formats_rc.set_row_layout
--			formats_rc.set_preferred_count (1)
--			formats_rc.set_spacing (5)
			!! scrolled_w.make ("", top_form)

			focus_area_form.attach_top (close_button, 0)
			focus_area_form.attach_top (context_hole, 0)
			focus_area_form.attach_top (trash_hole, 0)
			focus_area_form.attach_right (close_button, 0)
			focus_area_form.attach_left (context_hole, 0)
			focus_area_form.attach_left_widget (context_hole, trash_hole, 0)
			focus_area_form.attach_bottom (context_hole, 0)
			focus_area_form.attach_bottom (trash_hole, 0)
			focus_area_form.attach_bottom (close_button, 0)

			top_form.attach_top (focus_area_form, 0);
			top_form.attach_left (focus_area_form, 0);
			top_form.attach_right (focus_area_form, 0);
			top_form.attach_top_widget (focus_area_form, first_separator, 2)
			top_form.attach_left (first_separator, 0)
			top_form.attach_right (first_separator, 0)
			top_form.attach_top_widget (first_separator, scrolled_w, 0)
			top_form.attach_left (scrolled_w, 0)
			top_form.attach_right (scrolled_w, 0)
			top_form.attach_left (formats_rc, 0)
			top_form.attach_right (formats_rc, 0)
			top_form.attach_bottom (formats_rc, 0)
			top_form.attach_bottom_widget (formats_rc, second_separator, 0)
			top_form.attach_left (second_separator, 0)
			top_form.attach_right (second_separator, 0)
			top_form.attach_bottom_widget (second_separator, scrolled_w, 0)

				-- *************************
				-- * Creation of the forms *
				-- *************************

			!! geometry_form.make (Current)
			!! label_text_form.make (Current)
			!! perm_wind_form.make (Current)
			!! temp_wind_form.make (Current)
			!! separator_form.make (Current)
			!! text_form.make (Current)
			!! menu_form.make (Current)
			!! bar_form.make (Current)
			!! pict_color_form.make (Current)
			!! arrow_b_form.make (Current)
			!! scroll_l_form.make (Current)
			!! font_form.make (Current)
			!! alignment_form.make (Current)
			!! scale_form.make (Current)
			!! pulldown_form.make (Current)
			!! text_field_form.make (Current)
			!! color_form.make (Current)
			!! drawing_box_form.make (Current)
			!! behavior_form.make (Current)
			!! bull_resize_form.make (Current)
			!! grid_form.make (Current)
			!! toggle_form.make (Current)

			!! format_list.make (formats_rc, Current)

			current_form_number := 0;
			!! del_com.make (Current);
			set_delete_command (del_com);
			initialize_window_attributes;
		end

--	attach_attributes_form (a_form: EDITOR_FORM) is
--		do
--			top_form.attach_top_widget (first_separator, a_form, 1)
--			top_form.attach_left (a_form, 1)
--			top_form.attach_right (a_form, 1)
--			top_form.attach_bottom_widget (second_separator, a_form, 1)
--		end

feature -- Geometry

	set_geometry is
		do
			set_size (Resources.cont_ed_width,
					Resources.cont_ed_height)
		end;

feature {NONE} -- Attributes

	first_separator,
	second_separator: THREE_D_SEPARATOR
	
	top_form: FORM
			-- Form of the top shell
	
feature -- Update

	update_title is
		local
			tmp: STRING
		do
			!! tmp.make (0);
			tmp.append (Widget_names.Context_name);
			tmp.append (": ");
			tmp.append (edited_context.title_label)
			set_title (tmp);
			set_icon_name (tmp);
		end;

feature -- Closeable feature

	close is
			-- Close current editor
		do
			clear;
			window_mgr.close (Current)
		end

feature

	destroy is
		do
			{CONTEXT_EDITOR} Precursor
			{EB_TOP_SHELL} Precursor
		end

end -- class CONTEXT_EDITOR_TOP_SHELL
