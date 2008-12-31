note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class TOGGLE_ACTIONS_WINDOW

inherit

	ACTIONS_WINDOW
		redefine
			set_other_widgets,
			descendant_actions,
			set_other_widgets_insensitive,
			set_other_widgets_sensitive,
			finish
		end

create

	make

feature

	set_font_b,
	set_fg_b,
	arm_b,
	disarm_b,
	set_text_b,
	state_b: ACTION_WINDOW_BUTTON

	activate_b,
	value_changed_b: ACTION_WINDOW_TOGGLE_B

	set_other_widgets
		do
			set_size (330, 470)
			create set_font_b.associate (Current, b_set_font, "Set font", 20, 300)
			create set_fg_b.associate (Current, b_set_fg, "Set fg", 20, 340)
			create activate_b.associate (Current, b_activate, "Activate", 20, 380)
			create arm_b.associate (Current, b_arm, "Arm", 180, 300)
			create disarm_b.associate (Current, b_disarm, "Disarm", 180, 340)
			create set_text_b.associate (Current, b_set_text, "Set text", 180, 380)
			create value_changed_b.associate (Current, b_value_changed, "Value changed", 20, 420)
			create state_b.associate (Current, b_state, "State", 180, 420)
			activate_action:=False
			value_changed:=False
		end

	value_changed,
	activate_action: BOOLEAN

	finish
	local
		widget: TOGGLE_B
	do
		if activate_action then
			activate_action:=False
			widget ?= demo_window_array.item(main_window.current_demo).main_widget
			widget.remove_activate_action (Current, m_activate)
			if activate_b.insensitive then
				set_widgets_sensitive
			end
		end
		if value_changed then
			md.remove_ok_action (Current, m_value_changed)
			md.popdown
			value_changed:=False
			value_changed_b.set_toggle_off
			if value_changed_b.insensitive then
				set_widgets_sensitive
			end
		end
	end

	descendant_actions(arg: INTEGER_REF)
		local
			widget: TOGGLE_B
			color: COLOR
		do
			widget ?= demo_window_array.item(main_window.current_demo).main_widget
			inspect arg.item
			when b_set_font then
				if font_box.is_popped_up then
					font_box.remove_ok_action (Current, b_set_font)
					font_box.remove_cancel_action (Current, b_font_cancel)
					widget.set_font (font_box.font)
					font_box.popdown
					set_widgets_sensitive
				else
					font_box.add_ok_action (Current, b_set_font)
					font_box.add_cancel_action (Current, b_font_cancel)
					set_widgets_insensitive
					font_box.popup
				end
			when b_font_cancel then
				font_box.remove_ok_action (Current, b_set_font)
				font_box.remove_cancel_action (Current, b_font_cancel)
				font_box.popdown
				set_widgets_sensitive
			when b_set_fg then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_bg_color)
					prompt.remove_cancel_action (Current, b_cancel)
					create color.make
					color.set_name(prompt.selection_text)
					widget.set_foreground_color (color)
					set_widgets_sensitive
					prompt.popdown
				else
					prompt.add_ok_action (Current, b_bg_color)
					prompt.add_cancel_action (Current, b_cancel)
					prompt.set_selection_label("Enter color:")
					prompt.set_selection_text ("")
					prompt_type:=b_bg_color
					set_widgets_insensitive
					prompt.popup
				end
			when b_activate then
				if activate_b.state then
					widget.add_activate_action (Current, m_activate)
				else
					widget.remove_activate_action (Current, m_activate)
				end
			when m_activate then
				if activate_action then
					md.popdown
					md.remove_ok_action (Current, m_activate)
					activate_action:=False
					if activate_b.insensitive then
						set_widgets_sensitive
					end
				elseif not md.is_popped_up then
					md.set_message ("Activated")
					md.add_ok_action (Current, m_activate)
					activate_action:=True
					md.popup
					set_widgets_insensitive
				else
					md.set_message ("Activated")
					md.add_ok_action (Current, m_activate)
					activate_action:=True
				end
			when b_value_changed then
				if value_changed_b.state then
					widget.add_value_changed_action (Current, m_value_changed)
				else
					widget.remove_value_changed_action (Current, m_value_changed)
				end
			when m_value_changed then
				if value_changed then
					md.remove_ok_action (Current, m_value_changed)
					md.popdown
					value_changed:=False
					if value_changed_b.insensitive then
						set_widgets_sensitive
					end
				elseif not md.is_popped_up then
					md.set_message("Value changed")
					md.add_ok_action (Current, m_value_changed)
					value_changed:=True
					set_widgets_insensitive
					md.popup
				else
					md.set_message("Value changed")
					md.add_ok_action (Current, m_value_changed)
					value_changed:=True
				end
			when b_arm then
					widget.arm
			when b_disarm then
					widget.disarm
			when b_set_text then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_text)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					widget.set_text(prompt.selection_text)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_set_text
					prompt.set_selection_label("Enter string:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_set_text)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			when b_state then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_state)
					set_widgets_sensitive
				else
					md.set_message(widget.state.out)
					md.add_ok_action (Current, b_state)
					set_widgets_insensitive
					md.popup
				end
			else
			end
		end

	set_other_widgets_insensitive
		do
			set_font_b.set_insensitive
			set_fg_b.set_insensitive
			activate_b.set_insensitive
			arm_b.set_insensitive
			disarm_b.set_insensitive
			set_text_b.set_insensitive
			value_changed_b.set_insensitive
			state_b.set_insensitive
		end

	set_other_widgets_sensitive
		do
			set_font_b.set_sensitive
			set_fg_b.set_sensitive
			activate_b.set_sensitive
			arm_b.set_sensitive
			disarm_b.set_sensitive
			set_text_b.set_sensitive
			value_changed_b.set_sensitive
			state_b.set_sensitive
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class TOGGLE_ACTIONS_WINDOW

