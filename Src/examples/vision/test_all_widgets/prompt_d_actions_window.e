class PROMPT_D_ACTIONS_WINDOW

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
	hide_apply_b,
	hide_cancel_b,
	hide_help_b,
	hide_ok_b,
	show_apply_b,
	show_cancel_b,
	show_help_b,
	show_ok_b,
	set_apply_label_b,
	set_cancel_label_b,
	set_help_label_b,
	set_ok_label_b,
	set_selection_label_b,
	set_selection_text_b,
	selection_text_b,
	popup_b,
	popdown_b: ACTION_WINDOW_BUTTON

	apply_action_b,
	cancel_action_b,
	ok_action_b,
	help_action_b: ACTION_WINDOW_TOGGLE_B

	set_other_widgets is
		do
			set_size (330, 750)
			!!allow_resize_b.associate (Current, b_allow_resize, "Allow resize", 20, 260)
			!!forbid_resize_b.associate (Current, b_forbid_resize, "Forbid resize", 180, 260)
			!!popup_b.associate (Current, b_popup, "Popup", 20, 300)
			!!popdown_b.associate (Current, b_popdown, "Popdown", 180, 300)
			!!hide_apply_b.associate (Current, b_hide_apply, "Hide Apply", 20, 340)
			!!show_apply_b.associate (Current, b_show_apply, "Show Apply", 180, 340)
			!!hide_cancel_b.associate (Current, b_hide_cancel, "Hide Cancel", 20, 380)
			!!show_cancel_b.associate (Current, b_show_cancel, "Show Cancel", 180, 380)
			!!hide_help_b.associate (Current, b_hide_help, "Hide Help", 20, 420)
			!!show_help_b.associate (Current, b_show_help, "Show Help", 180, 420)
			!!hide_ok_b.associate (Current, b_hide_ok, "Hide Ok", 20, 460)
			!!show_ok_b.associate (Current, b_show_ok, "Show Ok", 180, 460)
			!!set_apply_label_b.associate (Current, b_set_apply, "Set Apply", 20, 500)
			!!set_cancel_label_b.associate (Current, b_set_cancel, "Set Cancel", 20, 540)
			!!set_help_label_b.associate (Current, b_set_help, "Set Help", 20, 580)
			!!set_ok_label_b.associate (Current, b_set_ok, "Set Ok", 20, 620)
			!!apply_action_b.associate (Current, b_apply_action, "Apply Action", 180, 500)
			!!cancel_action_b.associate (Current, b_cancel_action, "Cancel action", 180, 540)
			!!ok_action_b.associate (Current, b_ok_action, "Ok action", 180, 580)
			!!help_action_b.associate (Current, b_help_action, "Help action", 180, 620)
			!!set_selection_label_b.associate (Current, b_set_selection_label, "Set Selection Label", 20, 660)
			!!set_selection_text_b.associate (Current, b_set_selection_text, "Set Selection Text", 180, 660)
			!!selection_text_b.associate (Current, b_selection_text, "Selection Text", 20, 700)
			apply_action:=False
			help_action:=False
			ok_action:=False
			cancel_action:=False
		end

	apply_action,
	cancel_action,
	help_action,
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
		end

	descendant_actions(arg: INTEGER_REF) is
		local
			widget: PROMPT_D
		do
			widget ?= demo_window_array.item(main_window.current_demo).main_widget

			inspect arg.item
			when b_allow_resize then
				widget.allow_resize
			when b_forbid_resize then
				widget.forbid_resize
			when b_popup then
				widget.popup
			when b_popdown then
				widget.popdown
			when b_hide_apply then
				widget.hide_apply_button
			when b_show_apply then
				widget.show_apply_button
			when b_hide_cancel then
				widget.hide_cancel_button
			when b_show_cancel then
				widget.show_cancel_button
			when b_hide_help then
				widget.hide_help_button
			when b_show_help then
				widget.show_help_button
			when b_hide_ok then
				widget.hide_ok_button
			when b_show_ok then
				widget.show_ok_button
			when b_set_apply then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_apply)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					widget.set_apply_label(prompt.selection_text)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_set_apply
					prompt.set_selection_label("Enter string:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_set_apply)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			when b_set_cancel then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_cancel)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					widget.set_cancel_label(prompt.selection_text)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_set_cancel
					prompt.set_selection_label("Enter string:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_set_cancel)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			when b_set_help then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_help)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					widget.set_help_label(prompt.selection_text)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_set_help
					prompt.set_selection_label("Enter string:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_set_help)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			when b_set_ok then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_ok)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					widget.set_ok_label(prompt.selection_text)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_set_ok
					prompt.set_selection_label("Enter string:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_set_ok)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			when b_apply_action then
				if apply_action_b.state then
					widget.add_apply_action (Current, m_apply_action)
				else
					widget.remove_apply_action (Current, m_apply_action)
				end
			when m_apply_action then
				if apply_action then
					md.remove_ok_action (Current, m_apply_action)
					md.popdown
					apply_action:=False
					if apply_action_b.insensitive then
						set_widgets_sensitive
					end
				elseif not md.is_popped_up then
					md.set_message("apply action")
					md.add_ok_action (Current, m_apply_action)
					apply_action:=True
					set_widgets_insensitive
					md.popup
				else
					md.set_message("apply action")
					md.add_ok_action (Current, m_apply_action)
					apply_action:=True
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
			when b_ok_action then
				if ok_action_b.state then
					widget.add_ok_action (Current, m_ok_action)
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
			when b_set_selection_label then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_selection_label)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					widget.set_selection_label(prompt.selection_text)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_set_selection_label
					prompt.set_selection_label("Enter string:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_set_selection_label)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			when b_set_selection_text then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_selection_text)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					widget.set_selection_text(prompt.selection_text)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_set_selection_text
					prompt.set_selection_label("Enter string:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_set_selection_text)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			when b_selection_text then
				if md.is_popped_up then
					md.remove_ok_action (Current, b_selection_text)
					md.popdown
					set_widgets_sensitive
				else
					md.add_ok_action (Current, b_selection_text)
					md.set_message (widget.selection_text)
					set_widgets_insensitive
					md.popup
				end
			else
			end
		end

	set_other_widgets_insensitive is
		do
			allow_resize_b.set_insensitive
			forbid_resize_b.set_insensitive
			hide_apply_b.set_insensitive
			hide_cancel_b.set_insensitive
			hide_help_b.set_insensitive
			hide_ok_b.set_insensitive
			show_apply_b.set_insensitive
			show_cancel_b.set_insensitive
			show_help_b.set_insensitive
			show_ok_b.set_insensitive
			set_apply_label_b.set_insensitive
			set_cancel_label_b.set_insensitive
			set_help_label_b.set_insensitive
			set_ok_label_b.set_insensitive
			set_selection_label_b.set_insensitive
			set_selection_text_b.set_insensitive
			selection_text_b.set_insensitive
			popup_b.set_insensitive
			popdown_b.set_insensitive
			apply_action_b.set_insensitive
			cancel_action_b.set_insensitive
			ok_action_b.set_insensitive
			help_action_b.set_insensitive
		end

	set_other_widgets_sensitive is
		do
			allow_resize_b.set_sensitive
			forbid_resize_b.set_sensitive
			hide_apply_b.set_sensitive
			hide_cancel_b.set_sensitive
			hide_help_b.set_sensitive
			hide_ok_b.set_sensitive
			show_apply_b.set_sensitive
			show_cancel_b.set_sensitive
			show_help_b.set_sensitive
			show_ok_b.set_sensitive
			set_apply_label_b.set_sensitive
			set_cancel_label_b.set_sensitive
			set_help_label_b.set_sensitive
			set_ok_label_b.set_sensitive
			set_selection_label_b.set_sensitive
			set_selection_text_b.set_sensitive
			selection_text_b.set_sensitive
			popup_b.set_sensitive
			popdown_b.set_sensitive
			apply_action_b.set_sensitive
			cancel_action_b.set_sensitive
			ok_action_b.set_sensitive
			help_action_b.set_sensitive
		end

end -- class PROMPT_D_ACTIONS_WINDOW

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

