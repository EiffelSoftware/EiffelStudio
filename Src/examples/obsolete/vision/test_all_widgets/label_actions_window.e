note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class LABEL_ACTIONS_WINDOW

inherit

	ACTIONS_WINDOW
		redefine
			set_other_widgets,
			descendant_actions,
			set_other_widgets_insensitive,
			set_other_widgets_sensitive
		end

create

	make

feature


	set_font_b,
	set_fg_b,
	set_center_b,
	set_left_b,
	set_text_b: ACTION_WINDOW_BUTTON

	set_other_widgets
		do
			set_size (330, 430)
			create set_font_b.associate (Current, b_set_font, "Set font", 20, 300)
			create set_fg_b.associate (Current, b_set_fg, "Set fg", 20, 340)
			create set_center_b.associate (Current, b_set_center, "Set center", 180, 300)
			create set_left_b.associate (Current, b_set_left, "Set left", 180, 340)
			create set_text_b.associate (Current, b_set_text, "Set text", 180, 380)
		end

	descendant_actions(arg: INTEGER_REF)
		local
			widget: LABEL
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
			when b_set_center then
				widget.set_center_alignment
			when b_set_left then
				widget.set_left_alignment
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

	set_other_widgets_insensitive
		do
			set_font_b.set_insensitive
			set_fg_b.set_insensitive
			set_center_b.set_insensitive
			set_left_b.set_insensitive
			set_text_b.set_insensitive
		end

	set_other_widgets_sensitive
		do
			set_font_b.set_sensitive
			set_fg_b.set_sensitive
			set_center_b.set_sensitive
			set_left_b.set_sensitive
			set_text_b.set_sensitive
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


end -- class LABEL_ACTIONS_WINDOW

