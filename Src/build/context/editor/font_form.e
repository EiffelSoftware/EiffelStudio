indexing
	description: "Page representing the font properties."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class FONT_FORM 

inherit

	EDITOR_OK_FORM

creation

	make

feature {NONE} -- Interface

	font_b: FONT_BOX

	form_number: INTEGER is
		do
			Result := Context_const.font_form_nbr
		end

	format_number: INTEGER is
		do
			Result := Context_const.font_format_nbr
		end

	command: FONT_CMD is
		once
			!! Result
		end

	font_text: TEXT
			-- Displays font name for widget

feature -- Interface

	make_visible (a_parent: COMPOSITE) is
		local
			font_stone: FONT_STONE
			reset_button: PUSH_B
			reset_font_cmd: RESET_FONT_CMD
			font_text_form: FORM
		do
				--| Create widgets
			initialize (Widget_names.font_form_name, a_parent)
			create_ok_button
			!! font_b.make (Widget_names.font_box_name, Current)
			!! font_text_form.make (Widget_names.form1, Current)
			!! font_stone.make (font_text_form, editor)
			!! font_text.make_word_wrapped (Widget_names.text, font_text_form)
			!! reset_button.make (Widget_names.reset_font_name, Current)

				--| Set values
			set_size (300, 300)
			font_b.hide_ok_button
			font_b.hide_cancel_button
			font_b.hide_apply_button
			font_text.set_multi_line_mode
			font_text.set_read_only
			attach_left (font_b, 1)
			attach_right (font_b, 1)
			attach_top (font_b, 1)

				--| Perform attachments
			font_text_form.attach_left_widget (font_stone, font_text, 1)
			font_text_form.attach_top (font_stone, 1)
			font_text_form.attach_left (font_stone, 1)
			font_text_form.attach_right (font_text, 1)
			font_text_form.attach_bottom (font_text, 1)

 			attach_bottom_position (font_b, 75)
 			attach_top_position (font_text_form, 76)
			attach_top (font_b, 0)
			attach_right (font_b, 0)
			attach_left (font_b, 0)
 			attach_bottom_position (font_b, 75)
 			attach_top_position (font_text_form, 76)
			attach_left (font_text_form, 0)
			attach_right (font_text_form, 0)

			attach_bottom (reset_button, 10)
			attach_right (reset_button, 10)
			attach_left_position (reset_button, 52)
			attach_bottom_widget (reset_button, separator, 5)
			attach_left (separator, 0)
			attach_right (separator, 0)
			attach_bottom_widget (separator, font_text_form, 0)

				--| Set callbacks
			!! reset_font_cmd
			reset_button.add_activate_action (reset_font_cmd, editor)

			show_current
				-- Shake font box so it will
				-- resize correctly.
			font_b.set_height (font_b.height + 1)
		end

	set_font_text (a_string: STRING) is
		require
			valid_a_string: a_string /= Void
		do
			font_text.set_text (a_string)
		end
	
feature {NONE}

	reset is
		local
			font: FONT
		do
			font := context.font
			if font /= Void and then font.is_font_valid then
				if font.name /= Void then
					set_font_text (font.name)
				else
					set_font_text (Context_const.default_value)
				end
			end
		end

feature 

	apply is
		do
			context.set_font_named (font_b.font.name)
			reset
		end

end
