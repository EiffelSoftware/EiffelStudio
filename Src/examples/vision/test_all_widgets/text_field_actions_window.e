class TEXT_FIELD_ACTIONS_WINDOW

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

	set_max_size_b,
	get_text_b,
	append_b,
	insert_b,
	replace_b,
	clear_b,
	set_text_b: ACTION_WINDOW_BUTTON

	activate_b: ACTION_WINDOW_TOGGLE_B

	set_other_widgets is
		do
			set_size (330, 470)
			!!activate_b.associate (Current, b_activate, "Activate", 20, 300)
			!!set_max_size_b.associate (Current, b_set_max_size, "Set max size", 20, 340)
			!!get_text_b.associate (Current, b_get_text, "Text", 20, 380)
			!!append_b.associate (Current, b_append, "Append", 180, 300)
			!!insert_b.associate (Current, b_insert, "Insert", 180, 340)
			!!replace_b.associate (Current, b_replace, "Replace", 180, 380)
			!!clear_b.associate (Current, b_clear, "Clear", 20, 420)
			!!set_text_b.associate (Current, b_set_text, "Set text", 180, 420)
			activate_action:=False
		end

	activate_action: BOOLEAN

	finish is
		do
			if activate_action then
				md.remove_ok_action (Current, m_activate)
				md.popdown
				activate_action:=False
				activate_b.set_toggle_off
				if activate_b.insensitive then
					set_widgets_sensitive
				end
			end
		end

	position1_entered,
	position2_entered: BOOLEAN
	position1,
	position2: INTEGER

	descendant_actions(arg: INTEGER_REF) is
		local
			widget: TEXT_FIELD
		do
			widget ?= demo_window_array.item(main_window.current_demo).main_widget

			inspect arg.item
			when b_activate then
				if activate_b.state then
					widget.add_activate_action (Current, m_activate)
				else
					widget.remove_activate_action (Current, m_activate)
				end
			when m_activate then
				if activate_action then
					md.remove_ok_action (Current, m_activate)
					md.popdown
					activate_action:=False
					if activate_b.insensitive then
						set_widgets_sensitive
					end
				elseif not md.is_popped_up then
					md.set_message("Activated")
					md.add_ok_action (Current, m_activate)
					activate_action:=True
					set_widgets_insensitive
					md.popup
				else
					md.set_message("Activated")
					md.add_ok_action (Current, m_activate)
					activate_action:=True
				end
			when b_set_max_size then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_max_size)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					widget.set_maximum_size(prompt.selection_text.to_integer)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_set_max_size
					prompt.set_selection_label("Enter integer:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_set_max_size)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			when b_get_text then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_get_text)
					set_widgets_sensitive
				else
					md.set_message(widget.text)
					md.add_ok_action (Current, b_get_text)
					set_widgets_insensitive
					md.popup
				end
			when b_append then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_append)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					widget.append(prompt.selection_text)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_append
					prompt.set_selection_label("Enter string:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_append)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			when b_insert then
				if prompt.is_popped_up then
					if position1_entered then
						prompt.remove_ok_action (Current, b_insert)
						prompt.remove_cancel_action (Current, b_cancel)
						if position1>=0 and position1<=widget.count then
							widget.insert(prompt.selection_text, position1)
						end
						set_widgets_sensitive
						prompt.popdown
					else
						position1_entered:=True
						position1:=prompt.selection_text.to_integer
						prompt.set_selection_label("Enter string:")
						prompt.set_selection_text("")
					end
				else
					position1_entered:=False
					prompt.add_ok_action (Current, b_insert)
					prompt.add_cancel_action (Current, b_cancel)
					prompt_type:=b_insert
					prompt.set_selection_label("Enter position:")
					prompt.set_selection_text("")
					set_widgets_insensitive
					prompt.popup
				end
			when b_replace then
				if prompt.is_popped_up then
					if position1_entered then
						if position2_entered then
							prompt.remove_ok_action (Current, b_replace)
							prompt.remove_cancel_action (Current, b_cancel)
							if position1>=0 and position1<=widget.count then
								widget.replace(position1, position2, prompt.selection_text)
							end
							set_widgets_sensitive
							prompt.popdown
						else
							position2_entered:=True
							position2:=prompt.selection_text.to_integer
							prompt.set_selection_label("Enter string:")
							prompt.set_selection_text("")
						end
					else
						position1_entered:=True
						position1:=prompt.selection_text.to_integer
						prompt.set_selection_label("Enter second position:")
						prompt.set_selection_text("")
					end
				else
					position1_entered:=False
					position2_entered:=False
					prompt.add_ok_action (Current, b_replace)
					prompt.add_cancel_action (Current, b_cancel)
					prompt_type:=b_replace
					prompt.set_selection_label("Enter first position:")
					prompt.set_selection_text("")
					set_widgets_insensitive
					prompt.popup
				end
			when b_clear then
				widget.clear
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
			else
			end
		end

	set_other_widgets_insensitive is
		do
			activate_b.set_insensitive
			set_max_size_b.set_insensitive
			get_text_b.set_insensitive
			append_b.set_insensitive
			insert_b.set_insensitive
			replace_b.set_insensitive
			clear_b.set_insensitive
			set_text_b.set_insensitive
		end

	set_other_widgets_sensitive is
		do
			activate_b.set_sensitive
			set_max_size_b.set_sensitive
			get_text_b.set_sensitive
			append_b.set_sensitive
			insert_b.set_sensitive
			replace_b.set_sensitive
			clear_b.set_sensitive
			set_text_b.set_sensitive
		end

end -- class TEXT_FIELD_ACTIONS_WINDOW

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

