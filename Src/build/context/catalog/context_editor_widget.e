indexing
	description: "Context editor that is displayed on the %
				% main panel."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	CONTEXT_EDITOR_WIDGET

inherit
	FORM
		undefine
			init_toolkit
		redefine
			make, destroy, raise
		select
			implementation,
			parent
		end

	CONTEXT_EDITOR
		rename
			implementation as composite_implementation,
			parent as composite_parent
		redefine
			destroy, raise
		end

	CONSTANTS

creation

	make

feature -- Creation

	make (a_name: STRING a_parent: COMPOSITE) is
		local
			i: INTEGER
--			close_button: CLOSE_WINDOW_BUTTON
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
			!! form_list.make (1, Context_const.total_nbr_of_forms)

			{FORM} Precursor (a_name, a_parent)
			!! focus_area_form.make (Widget_names.form1, Current)
			!! context_hole.make (Current, focus_area_form)
			!! first_separator.make (Widget_names.separator, Current)
			!! context_editor_label.make ("Context editor", focus_area_form)
			!! formats_rc.make (Widget_names.row_column, focus_area_form)
			!! scrolled_w.make ("", Current)

				--| Set values
			first_separator.set_horizontal (True)
			formats_rc.set_row_layout
			formats_rc.set_preferred_count (1)
			update_title

				--| Perform attachments
			focus_area_form.attach_top (context_hole, 0)
			focus_area_form.attach_top (context_editor_label, 3)
			focus_area_form.attach_top (formats_rc, 0)
			focus_area_form.attach_left (context_hole, 0)
			focus_area_form.attach_left_widget (context_hole, context_editor_label, 5)
			focus_area_form.attach_left_widget (context_editor_label, formats_rc, 5)
			focus_area_form.attach_bottom (context_hole, 0)
			focus_area_form.attach_bottom (context_editor_label, 0)
			focus_area_form.attach_bottom (formats_rc, 0)

			attach_top (focus_area_form, 0)
			attach_left (focus_area_form, 0)
			attach_right (focus_area_form, 0)
			attach_top_widget (focus_area_form, first_separator, 2)
			attach_left (first_separator, 0)
			attach_right (first_separator, 0)
			attach_top_widget (first_separator, scrolled_w, 0)
			attach_left (scrolled_w, 0)
			attach_right (scrolled_w, 0)
			attach_bottom (scrolled_w, 0)

				-- *************************
				-- * Creation of the forms *
				-- *************************

			!! behavior_form.make (Current)
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
			!! bull_resize_form.make (Current)
			!! grid_form.make (Current)
			!! toggle_form.make (Current)

			!! format_list.make (formats_rc, Current)

			current_form_number := 0
		end

feature {NONE} -- Attributes

	first_separator: THREE_D_SEPARATOR

feature

	raise is
		do
			main_panel.raise
		end

	top_form: FORM is
		do
			Result := Current
		end

	destroy is
		do
			clear
		end

	set_icon_name (a_name: STRING) is
		do
		end

	set_title (a_title: STRING) is
		do
			context_editor_label.set_text (a_title)
		end

	update_title is
		local
			tmp: STRING
		do
			if edited_context = Void then
				set_title ("Empty context editor")
			else
				!! tmp.make (15)
				tmp.append (edited_context.label)
				set_title (tmp)
			end
		end

feature {NONE} -- Attribute

	context_editor_label: LABEL
		-- Label displaying the name of `edited_context'

end -- class CONTEXT_EDITOR_WIDGET
