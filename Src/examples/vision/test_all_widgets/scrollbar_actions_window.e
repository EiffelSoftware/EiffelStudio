class SCROLLBAR_ACTIONS_WINDOW

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

	move_action_b,
	val_ch_act_b,
	set_granul_b,
	set_max_b,
	set_min_b,
	set_value_b,
	value_b: ACTION_WINDOW_BUTTON

	set_other_widgets is
		do
			set_size (330, 470)
			!!move_action_b.associate (Current, b_move_action, "Move action", 20, 300)
			!!val_ch_act_b.associate (Current, b_val_ch_act, "Val ch act", 20, 340)
			!!set_granul_b.associate (Current, b_set_granul, "Set granul", 20, 380)
			!!set_max_b.associate (Current, b_set_max, "Set max", 180, 300)
			!!set_min_b.associate (Current, b_set_min, "Set min", 180, 340)
			!!set_value_b.associate (Current, b_set_value, "Set value", 180, 380)
			!!value_b.associate (Current, b_value, "Value", 20, 380)
			move_action:=False
			val_ch_act:=False
		end

	finish is
		do
			if move_action then
				md.popdown
				set_widgets_sensitive
				md.remove_ok_action (Current, m_move_action)
			end
			if val_ch_act then
				md.popdown
				set_widgets_sensitive
				md.remove_ok_action (Current, m_val_ch_act)
			end
			if md.is_popped_up then
				md.popdown
				md.remove_ok_action (Current, b_value)
				set_widgets_sensitive
			end
		end

	move_action,
	val_ch_act: BOOLEAN

	descendant_actions(arg: INTEGER_REF) is
		local
			widget: SCROLLBAR
		do
			widget ?= demo_window_array.item(main_window.current_demo).main_widget
			inspect arg.item
			when b_move_action then
				if move_action then
					move_action:=False
					widget.remove_move_action (Current, m_move_action)
				else
					move_action:=True
					widget.add_move_action (Current, m_move_action)
				end
			when m_move_action then
				if md.is_popped_up then
					md.popdown
					set_widgets_sensitive
					md.remove_ok_action (Current, m_move_action)
				else
					md.add_ok_action (Current, m_move_action)
					md.set_message ("Moved")
					set_widgets_insensitive
					md.popup
				end
			when b_val_ch_act then
				if val_ch_act then
					val_ch_act:=False
					widget.remove_value_changed_action (Current, m_val_ch_act)
				else
					val_ch_act:=True
					widget.add_value_changed_action (Current, m_val_ch_act)
				end
			when m_val_ch_act then
				if md.is_popped_up then
					md.popdown
					set_widgets_sensitive
					md.remove_ok_action (Current, m_val_ch_act)
				else
					md.add_ok_action (Current, m_val_ch_act)
					md.set_message ("Value changed")
					set_widgets_insensitive
					md.popup
				end
			when b_set_granul then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_granul)
					prompt.remove_cancel_action (Current, b_cancel)
					widget.set_granularity (prompt.selection_text.to_integer) 
					set_widgets_sensitive
					prompt.popdown
				else
					prompt.add_ok_action (Current, b_set_granul)
					prompt.add_cancel_action (Current, b_cancel)
					prompt.set_selection_label("Enter new granularity:")
					prompt.set_selection_text ("")
					prompt_type:=b_set_granul
					set_widgets_insensitive
					prompt.popup
				end
			when b_set_max then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_max)
					prompt.remove_cancel_action (Current, b_cancel)
					widget.set_maximum (prompt.selection_text.to_integer) 
					set_widgets_sensitive
					prompt.popdown
				else
					prompt.add_ok_action (Current, b_set_max)
					prompt.add_cancel_action (Current, b_cancel)
					prompt.set_selection_label("Enter new maximum:")
					prompt.set_selection_text ("")
					prompt_type:=b_set_max
					set_widgets_insensitive
					prompt.popup
				end
			when b_set_min then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_min)
					prompt.remove_cancel_action (Current, b_cancel)
					widget.set_minimum (prompt.selection_text.to_integer) 
					set_widgets_sensitive
					prompt.popdown
				else
					prompt.add_ok_action (Current, b_set_min)
					prompt.add_cancel_action (Current, b_cancel)
					prompt.set_selection_label("Enter new minimum:")
					prompt.set_selection_text ("")
					prompt_type:=b_set_min
					set_widgets_insensitive
					prompt.popup
				end
			when b_set_value then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_value)
					prompt.remove_cancel_action (Current, b_cancel)
					widget.set_value (prompt.selection_text.to_integer) 
					set_widgets_sensitive
					prompt.popdown
				else
					prompt.add_ok_action (Current, b_set_value)
					prompt.add_cancel_action (Current, b_cancel)
					prompt.set_selection_label("Enter new value:")
					prompt.set_selection_text ("")
					prompt_type:=b_set_value
					set_widgets_insensitive
					prompt.popup
				end
			when b_value then
				if md.is_popped_up then
					md.remove_ok_action (Current, b_value)
					md.popdown
					set_widgets_sensitive
				else
					md.add_ok_action (Current, b_value)
					md.set_message (widget.value.out)
					set_widgets_insensitive
					md.popup
				end
			else
			end
		end

	set_other_widgets_insensitive is
		do
			move_action_b.set_insensitive
			val_ch_act_b.set_insensitive
			set_granul_b.set_insensitive
			set_max_b.set_insensitive
			set_min_b.set_insensitive
			set_value_b.set_insensitive
			value_b.set_insensitive
		end

	set_other_widgets_sensitive is
		do
			move_action_b.set_sensitive
			val_ch_act_b.set_sensitive
			set_granul_b.set_sensitive
			set_max_b.set_sensitive
			set_min_b.set_sensitive
			set_value_b.set_sensitive
			value_b.set_sensitive
		end

end -- class SCROLLBAR_ACTIONS_WINDOW

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

