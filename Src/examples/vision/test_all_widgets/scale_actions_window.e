class SCALE_ACTIONS_WINDOW

inherit

	ACTIONS_WINDOW
		redefine
			set_other_widgets,
			descendant_actions,
			set_other_widgets_insensitive,
			set_other_widgets_sensitive
		end

creation

	make

feature

	output_only_b,
	input_output_b,
	show_value_b,
	hide_value_b,
	set_text_b: ACTION_WINDOW_BUTTON

	set_other_widgets is
		do
			set_size (330, 430)
			!!output_only_b.associate (Current, b_output_only, "Output only", 20, 300)
			!!input_output_b.associate (Current, b_input_output, "Input-output", 180, 300)
			!!show_value_b.associate (Current, b_show_value, "Show value", 20, 340)
			!!hide_value_b.associate (Current, b_hide_value, "Hide value", 180, 340)
			!!set_text_b.associate (Current, b_set_text, "Set text", 20, 380)
		end

	descendant_actions(arg: INTEGER_REF) is
		local
			widget: SCALE
		do
			widget ?= demo_window_array.item(main_window.current_demo).main_widget
			inspect arg.item
			when b_output_only then
				widget.set_output_only (True)
			when b_input_output then
				widget.set_output_only (False)
			when b_show_value then
				widget.show_value (True)
			when b_hide_value then
				widget.show_value (False)
			when b_set_text then
				if prompt.is_popped_up then
					prompt.popdown
					prompt.remove_ok_action (Current, b_set_text)
					prompt_type := 0
					prompt.remove_cancel_action (Current, b_cancel)
					widget.set_text (prompt.selection_text)
					set_widgets_sensitive
				else
					prompt.add_ok_action (Current, b_set_text)
					prompt_type := b_set_text
					prompt.add_cancel_action (Current, b_cancel)
					prompt.set_selection_label ("Enter text:")
					prompt.set_selection_text ("")
					set_widgets_insensitive
					prompt.popup
				end
			else
			end
		end

	set_other_widgets_insensitive is
		do
			output_only_b.set_insensitive
			input_output_b.set_insensitive
			show_value_b.set_insensitive
			hide_value_b.set_insensitive
			set_text_b.set_insensitive
		end

	set_other_widgets_sensitive is
		do
			output_only_b.set_sensitive
			input_output_b.set_sensitive
			show_value_b.set_sensitive
			hide_value_b.set_sensitive
			set_text_b.set_sensitive
		end

end -- class SCALE_ACTIONS_WINDOW

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

