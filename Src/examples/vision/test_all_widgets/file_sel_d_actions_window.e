class FILE_SEL_D_ACTIONS_WINDOW

inherit

	ACTIONS_WINDOW
		redefine
			set_other_widgets,
			descendant_actions,
			set_other_widgets_insensitive,
			set_other_widgets_sensitive,
			finish
		end

creation

	make

feature

	allow_resize_b,
	forbid_resize_b,
	hide_help_b,
	hide_cancel_b,
	hide_ok_b,
	hide_filter_b,
	show_help_b,
	show_cancel_b,
	show_ok_b,
	show_filter_b,
	hide_file_selection_label_b,
	hide_file_selection_list_b,
	show_file_selection_label_b,
	show_file_selection_list_b,
	dir_count_b,
	file_count_b,
	directory_b,
	filter_b,
	is_dir_valid_b,
	is_list_updated_b,
	pattern_b,
	selected_file_b,
	set_all_selection_b,
	set_dir_list_label_b,
	set_directory_b,
	set_directory_selection_b,
	set_file_list_label_b,
	set_file_list_width_b,
	set_file_selection_b,
	set_filter_b,
	set_filter_label_b,
	set_pattern_b,
	popup_b,
	popdown_b: ACTION_WINDOW_BUTTON

	help_action_b,
	cancel_action_b,
	filter_action_b,
	ok_action_b: ACTION_WINDOW_TOGGLE_B

	set_other_widgets is
		do
			set_size (490, 710)
			!!allow_resize_b.associate (Current, b_allow_resize, "Allow resize", 20, 260)
			!!forbid_resize_b.associate (Current, b_forbid_resize, "Forbid resize", 180, 260)
			!!popup_b.associate (Current, b_popup, "Popup", 20, 300)
			!!popdown_b.associate (Current, b_popdown, "Popdown", 180, 300)
			!!hide_help_b.associate (Current, b_hide_help, "Hide Help", 20, 340)
			!!show_help_b.associate (Current, b_show_help, "Show Help", 180, 340)
			!!hide_cancel_b.associate (Current, b_hide_cancel, "Hide Cancel", 20, 380)
			!!show_cancel_b.associate (Current, b_show_cancel, "Show Cancel", 180, 380)
			!!hide_ok_b.associate (Current, b_hide_ok, "Hide Ok", 20, 420)
			!!show_ok_b.associate (Current, b_show_ok, "Show Ok", 180, 420)
			!!hide_filter_b.associate (Current, b_hide_filter, "Hide Filter", 20, 460)
			!!show_filter_b.associate (Current, b_show_filter, "Show Filter", 180, 460)
			!!hide_file_selection_label_b.associate (Current, b_hide_file_selection_label, "Hide fs label", 20, 500)
			!!show_file_selection_label_b.associate (Current, b_show_file_selection_label, "Show fs label", 180, 500)
			!!hide_file_selection_list_b.associate (Current, b_hide_file_selection_list, "Hide fs list", 20, 540)
			!!show_file_selection_list_b.associate (Current, b_show_file_selection_list, "Show fs list", 180, 540)
			!!help_action_b.associate (Current, b_help_action, "Help Action", 20, 580)
			!!cancel_action_b.associate (Current, b_cancel_action, "Cancel action", 180, 580)
			!!filter_action_b.associate (Current, b_filter_action, "Filter action", 20, 620)
			!!ok_action_b.associate (Current, b_ok_action, "Ok action", 180, 620)
			!!dir_count_b.associate (Current, b_dir_count, "Dir count", 20, 660)
			!!file_count_b.associate (Current, b_file_count, "File count", 180, 660)

			!!directory_b.associate (Current, b_directory, "Directory", 340, 60)
			!!filter_b.associate (Current, b_filter, "Filter", 340, 100)
			!!is_dir_valid_b.associate (Current, b_is_dir_valid, "Is_dir_valid", 340, 140)
			!!is_list_updated_b.associate (Current, b_is_list_updated, "Is_list_updated", 340, 180)
			!!pattern_b.associate (Current, b_pattern, "Pattern", 340, 220)
			!!selected_file_b.associate (Current, b_selected_file, "Selected File", 340, 260)
			!!set_all_selection_b.associate (Current, b_set_all_selection, "Set_all_selection", 340, 300)
			!!set_dir_list_label_b.associate (Current, b_set_dir_list_label, "Set_dir_list_label", 340, 340)
			!!set_directory_b.associate (Current, b_set_directory, "Set_directory", 340, 380)
			!!set_directory_selection_b.associate (Current, b_set_directory_selection, "Set dir selection", 340, 420)
			!!set_file_list_label_b.associate (Current, b_set_file_list_label, "Set_file_list_label", 340, 460)
			!!set_file_list_width_b.associate (Current, b_set_file_list_width, "Set_file_list_width", 340, 500)
			!!set_file_selection_b.associate (Current, b_set_file_selection, "Set_file_selection", 340, 540)
			!!set_filter_b.associate (Current, b_set_filter, "Set_filter", 340, 580)
			!!set_filter_label_b.associate (Current, b_set_filter_label, "Set_filter_label", 340, 620)
			!!set_pattern_b.associate (Current, b_set_pattern, "Set_pattern", 340, 660)

			help_action:=False
			ok_action:=False
			cancel_action:=False
			filter_action:=False
		end

	help_action,
	cancel_action,
	filter_action,
	ok_action: BOOLEAN

	finish is
		do
			if cancel_action then
				md.remove_ok_action (Current, m_cancel_action)
				md.popdown
				cancel_action:=False
				cancel_action_b.set_toggle_off
				if cancel_action_b.insensitive then
					set_widgets_sensitive
				end
			end
			if help_action then
				md.remove_ok_action (Current, m_help_action)
				md.popdown
				help_action:=False
				help_action_b.set_toggle_off
				if help_action_b.insensitive then
					set_widgets_sensitive
				end
			end
			if ok_action then
				md.remove_ok_action (Current, m_ok_action)
				md.popdown
				ok_action:=False
				ok_action_b.set_toggle_off
				if ok_action_b.insensitive then
					set_widgets_sensitive
				end
			end
			if filter_action then
				md.remove_ok_action (Current, m_filter_action)
				md.popdown
				filter_action:=False
				filter_action_b.set_toggle_off
				if filter_action_b.insensitive then
					set_widgets_sensitive
				end
			end
		end

	descendant_actions(arg: INTEGER_REF) is
		local
			widget: FILE_SEL_D
		do
			widget ?= demo_window_array.item(main_window.current_demo)

			inspect arg.item
			when b_allow_resize then
				widget.allow_resize
			when b_forbid_resize then
				widget.forbid_resize
			when b_popup then
				widget.popup
			when b_popdown then
				widget.popdown
			when b_hide_help then
				widget.hide_help_button
			when b_show_help then
				widget.show_help_button
			when b_hide_cancel then
				widget.hide_cancel_button
			when b_show_cancel then
				widget.show_cancel_button
			when b_hide_ok then
				widget.hide_ok_button
			when b_show_ok then
				widget.show_ok_button
			when b_hide_filter then
				widget.hide_filter_button
			when b_show_filter then
				widget.show_filter_button
			when b_hide_file_selection_label then
				widget.hide_file_selection_label
			when b_show_file_selection_label then
				widget.show_file_selection_label
			when b_hide_file_selection_list then
				widget.hide_file_selection_list
			when b_show_file_selection_list then
				widget.show_file_selection_list
			when b_help_action then
				if help_action_b.state then
					widget.add_help_action (Current, m_help_action)
				else
					widget.remove_help_action (Current, m_help_action)
				end
			when m_help_action then
				if help_action then
					md.remove_ok_action (Current, m_help_action)
					md.popdown
					help_action:=False
					if help_action_b.insensitive then
						set_widgets_sensitive
					end
				elseif not md.is_popped_up then
					md.set_message("Help action")
					md.add_ok_action (Current, m_help_action)
					help_action:=True
					set_widgets_insensitive
					md.popup
				else
					md.set_message("Help action")
					md.add_ok_action (Current, m_help_action)
					help_action:=True
				end
			when b_cancel_action then
				if cancel_action_b.state then
					widget.add_cancel_action (Current, m_cancel_action)
				else
					widget.remove_cancel_action (Current, m_cancel_action)
				end
			when m_cancel_action then
				if cancel_action then
					md.remove_ok_action (Current, m_cancel_action)
					md.popdown
					cancel_action:=False
					if cancel_action_b.insensitive then
						set_widgets_sensitive
					end
				elseif not md.is_popped_up then
					md.set_message("Cancel action")
					md.add_ok_action (Current, m_cancel_action)
					cancel_action:=True
					set_widgets_insensitive
					md.popup
				else
					md.set_message("Cancel action")
					md.add_ok_action (Current, m_cancel_action)
					cancel_action:=True
				end
			when b_ok_action then
				if ok_action_b.state then
					widget.add_ok_action (current, m_ok_action)
				else
					widget.remove_ok_action (Current, m_ok_action)
				end
			when m_ok_action then
				if ok_action then
					md.remove_ok_action (Current, m_ok_action)
					md.popdown
					ok_action:=False
					if ok_action_b.insensitive then
						set_widgets_sensitive
					end
				elseif not md.is_popped_up then
					md.set_message("Ok action")
					md.add_ok_action (Current, m_ok_action)
					ok_action:=True
					set_widgets_insensitive
					md.popup
				else
					md.set_message("Ok action")
					md.add_ok_action (Current, m_ok_action)
					ok_action:=True
				end
			when b_filter_action then
				if filter_action_b.state then
					widget.add_filter_action (current, m_filter_action)
				else
					widget.remove_filter_action (Current, m_filter_action)
				end
			when m_filter_action then
				if filter_action then
					md.remove_ok_action (Current, m_filter_action)
					md.popdown
					filter_action:=False
					if filter_action_b.insensitive then
						set_widgets_sensitive
					end
				elseif not md.is_popped_up then
					md.set_message("Filter action")
					md.add_ok_action (Current, m_filter_action)
					filter_action:=True
					set_widgets_insensitive
					md.popup
				else
					md.set_message("Filter action")
					md.add_ok_action (Current, m_filter_action)
					filter_action:=True
				end
			when b_dir_count then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_dir_count)
					set_widgets_sensitive
				else
					md.set_message(widget.dir_count.out)
					md.add_ok_action (Current, b_dir_count)
					set_widgets_insensitive
					md.popup
				end
			when b_directory then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_directory)
					set_widgets_sensitive
				else
					md.set_message(widget.directory)
					md.add_ok_action (Current, b_directory)
					set_widgets_insensitive
					md.popup
				end
			when b_file_count then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_file_count)
					set_widgets_sensitive
				else
					md.set_message(widget.file_count.out)
					md.add_ok_action (Current, b_file_count)
					set_widgets_insensitive
					md.popup
				end
			when b_filter then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_filter)
					set_widgets_sensitive
				else
					md.set_message(widget.filter)
					md.add_ok_action (Current, b_filter)
					set_widgets_insensitive
					md.popup
				end
			when b_pattern then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_pattern)
					set_widgets_sensitive
				else
					md.set_message(widget.pattern)
					md.add_ok_action (Current, b_pattern)
					set_widgets_insensitive
					md.popup
				end
			when b_selected_file then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_selected_file)
					set_widgets_sensitive
				else
					md.set_message(widget.selected_file)
					md.add_ok_action (Current, b_selected_file)
					set_widgets_insensitive
					md.popup
				end
			when b_is_dir_valid then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_is_dir_valid)
					set_widgets_sensitive
				else
					md.set_message(widget.is_dir_valid.out)
					md.add_ok_action (Current, b_is_dir_valid)
					set_widgets_insensitive
					md.popup
				end
			when b_is_list_updated then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_is_list_updated)
					set_widgets_sensitive
				else
					md.set_message(widget.is_list_updated.out)
					md.add_ok_action (Current, b_is_list_updated)
					set_widgets_insensitive
					md.popup
				end
			when b_set_all_selection then
				widget.set_all_selection
			when b_set_dir_list_label then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_dir_list_label)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					widget.set_dir_list_label(prompt.selection_text)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_set_dir_list_label
					prompt.set_selection_label("Enter string:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_set_dir_list_label)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			when b_set_directory then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_directory)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					widget.set_directory(prompt.selection_text)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_set_directory
					prompt.set_selection_label("Enter directory:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_set_directory)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			when b_set_directory_selection then
				widget.set_directory_selection
			when b_set_file_list_label then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_file_list_label)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					widget.set_file_list_label(prompt.selection_text)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_set_file_list_label
					prompt.set_selection_label("Enter string:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_set_file_list_label)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			when b_set_file_list_width then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_file_list_width)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					widget.set_file_list_width(prompt.selection_text.to_integer)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_set_file_list_width
					prompt.set_selection_label("Enter integer:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_set_file_list_width)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			when b_set_file_selection then
				widget.set_file_selection
			when b_set_filter then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_filter)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					widget.set_filter(prompt.selection_text)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_set_filter
					prompt.set_selection_label("Enter filter:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_set_filter)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			when b_set_filter_label then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_filter_label)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					widget.set_filter_label(prompt.selection_text)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_set_filter_label
					prompt.set_selection_label("Enter string:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_set_filter_label)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			when b_set_pattern then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_pattern)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					widget.set_pattern(prompt.selection_text)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_set_pattern
					prompt.set_selection_label("Enter pattern:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_set_pattern)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			else
			end
		end

	set_other_widgets_insensitive is
		do
			allow_resize_b.set_insensitive
			forbid_resize_b.set_insensitive
			hide_help_b.set_insensitive
			hide_cancel_b.set_insensitive
			hide_ok_b.set_insensitive
			hide_filter_b.set_insensitive
			show_help_b.set_insensitive
			show_cancel_b.set_insensitive
			show_ok_b.set_insensitive
			show_filter_b.set_insensitive
			hide_file_selection_label_b.set_insensitive
			hide_file_selection_list_b.set_insensitive
			show_file_selection_label_b.set_insensitive
			show_file_selection_list_b.set_insensitive
			dir_count_b.set_insensitive
			file_count_b.set_insensitive
			directory_b.set_insensitive
			filter_b.set_insensitive
			is_dir_valid_b.set_insensitive
			is_list_updated_b.set_insensitive
			pattern_b.set_insensitive
			selected_file_b.set_insensitive
			set_all_selection_b.set_insensitive
			set_dir_list_label_b.set_insensitive
			set_directory_b.set_insensitive
			set_directory_selection_b.set_insensitive
			set_file_list_label_b.set_insensitive
			set_file_list_width_b.set_insensitive
			set_file_selection_b.set_insensitive
			set_filter_b.set_insensitive
			set_filter_label_b.set_insensitive
			set_pattern_b.set_insensitive
			popup_b.set_insensitive
			popdown_b.set_insensitive
			help_action_b.set_insensitive
			cancel_action_b.set_insensitive
			filter_action_b.set_insensitive
			ok_action_b.set_insensitive
		end

	set_other_widgets_sensitive is
		do
			allow_resize_b.set_sensitive
			forbid_resize_b.set_sensitive
			hide_help_b.set_sensitive
			hide_cancel_b.set_sensitive
			hide_ok_b.set_sensitive
			hide_filter_b.set_sensitive
			show_help_b.set_sensitive
			show_cancel_b.set_sensitive
			show_ok_b.set_sensitive
			show_filter_b.set_sensitive
			hide_file_selection_label_b.set_sensitive
			hide_file_selection_list_b.set_sensitive
			show_file_selection_label_b.set_sensitive
			show_file_selection_list_b.set_sensitive
			dir_count_b.set_sensitive
			file_count_b.set_sensitive
			directory_b.set_sensitive
			filter_b.set_sensitive
			is_dir_valid_b.set_sensitive
			is_list_updated_b.set_sensitive
			pattern_b.set_sensitive
			selected_file_b.set_sensitive
			set_all_selection_b.set_sensitive
			set_dir_list_label_b.set_sensitive
			set_directory_b.set_sensitive
			set_directory_selection_b.set_sensitive
			set_file_list_label_b.set_sensitive
			set_file_list_width_b.set_sensitive
			set_file_selection_b.set_sensitive
			set_filter_b.set_sensitive
			set_filter_label_b.set_sensitive
			set_pattern_b.set_sensitive
			popup_b.set_sensitive
			popdown_b.set_sensitive
			help_action_b.set_sensitive
			cancel_action_b.set_sensitive
			filter_action_b.set_sensitive
			ok_action_b.set_sensitive
		end

end -- class FILE_SEL_D_ACTIONS_WINDOW

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

