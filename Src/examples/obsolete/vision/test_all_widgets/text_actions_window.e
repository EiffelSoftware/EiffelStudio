note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class TEXT_ACTIONS_WINDOW

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

	sel_begin_b,
	sel_end_b,
	cursor_pos_b,
	margin_hei_b,
	margin_wid_b,
	clear_sel_b,
	set_sel_b: ACTION_WINDOW_BUTTON

	modify_b: ACTION_WINDOW_TOGGLE_B

	set_other_widgets
		do
			set_size (330, 470)
			create modify_b.associate (Current, b_modify, "Modify", 20, 300)
			create sel_begin_b.associate (Current, b_sel_begin, "Sel begin", 20, 340)
			create sel_end_b.associate (Current, b_sel_end, "Sel end", 20, 380)
			create cursor_pos_b.associate (Current, b_cursor_pos, "Cursor pos", 180, 300)
			create margin_hei_b.associate (Current, b_margin_hei, "Margin hei", 180, 340)
			create margin_wid_b.associate (Current, b_margin_wid, "Margin wid", 180, 380)
			create clear_sel_b.associate (Current, b_clear_sel, "Clear sel", 20, 420)
			create set_sel_b.associate (Current, b_set_sel, "Set sel", 180, 420)
			modify_action:=False
		end

	modify_action: BOOLEAN

	finish
		do
			if modify_action then
				md.remove_ok_action (Current, m_modify)
				md.popdown
				modify_action:=False
				modify_b.set_toggle_off
				if modify_b.insensitive then
					set_widgets_sensitive
				end
			end
		end

	first_entered: BOOLEAN
	first,
	last: INTEGER

	descendant_actions(arg: INTEGER_REF)
		local
			widget: TEXT
		do
			widget ?= demo_window_array.item(main_window.current_demo).main_widget

			inspect arg.item
			when b_modify then
				if modify_b.state then
					widget.add_modify_action (Current, m_modify)
				else
					widget.remove_modify_action (Current, m_modify)
				end
			when m_modify then
				if modify_action then
					md.remove_ok_action (Current, m_modify)
					md.popdown
					modify_action:=False
					if modify_b.insensitive then
						set_widgets_sensitive
					end
				elseif not md.is_popped_up then
					md.set_message("Modify action")
					md.add_ok_action (Current, m_modify)
					modify_action:=True
					set_widgets_insensitive
					md.popup
				else
					md.set_message("Modify action")
					md.add_ok_action (Current, m_modify)
					modify_action:=True
				end
			when b_sel_begin then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_sel_begin)
					set_widgets_sensitive
				else
					if widget.realized and then widget.is_selection_active then
						md.set_message(widget.begin_of_selection.out)
					else
						md.set_message("no selection active")
					end
					md.add_ok_action (Current, b_sel_begin)
					set_widgets_insensitive
					md.popup
				end
			when b_sel_end then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_sel_end)
					set_widgets_sensitive
				else
					if widget.realized and then widget.is_selection_active then
						md.set_message(widget.end_of_selection.out)
					else
						md.set_message("no selection active")
					end
					md.add_ok_action (Current, b_sel_end)
					set_widgets_insensitive
					md.popup
				end
			when b_cursor_pos then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_cursor_pos)
					set_widgets_sensitive
				else
					md.set_message(widget.cursor_position.out)
					md.add_ok_action (Current, b_cursor_pos)
					set_widgets_insensitive
					md.popup
				end
			when b_margin_hei then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_margin_hei)
					set_widgets_sensitive
				else
					md.set_message(widget.margin_height.out)
					md.add_ok_action (Current, b_margin_hei)
					set_widgets_insensitive
					md.popup
				end
			when b_margin_wid then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_margin_wid)
					set_widgets_sensitive
				else
					md.set_message(widget.margin_width.out)
					md.add_ok_action (Current, b_margin_wid)
					set_widgets_insensitive
					md.popup
				end
			when b_clear_sel then
				widget.clear_selection
			when b_set_sel then
				if prompt.is_popped_up then
					if first_entered then
						last:=prompt.selection_text.to_integer
						prompt.remove_ok_action (Current, b_set_sel)
						prompt.remove_cancel_action (Current, b_cancel)
						if first>=0 and last<=widget.count and first<=last and widget.realized then
							widget.set_selection( first, last)
						end
						set_widgets_sensitive
						prompt.popdown
					else
						first_entered:=True
						first:=prompt.selection_text.to_integer
						prompt.set_selection_label("Enter last:")
						prompt.set_selection_text("")
					end
				else
					first_entered:=False
					prompt.add_ok_action (Current, b_set_sel)
					prompt.add_cancel_action (Current, b_cancel)
					prompt_type:=b_set_sel
					prompt.set_selection_label("Enter first:")
					prompt.set_selection_text("")
					set_widgets_insensitive
					prompt.popup
				end
			else
			end
		end

	set_other_widgets_insensitive
		do
			modify_b.set_insensitive
			sel_begin_b.set_insensitive
			sel_end_b.set_insensitive
			cursor_pos_b.set_insensitive
			margin_hei_b.set_insensitive
			margin_wid_b.set_insensitive
			clear_sel_b.set_insensitive
			set_sel_b.set_insensitive
		end

	set_other_widgets_sensitive
		do
			modify_b.set_sensitive
			sel_begin_b.set_sensitive
			sel_end_b.set_sensitive
			cursor_pos_b.set_sensitive
			margin_hei_b.set_sensitive
			margin_wid_b.set_sensitive
			clear_sel_b.set_sensitive
			set_sel_b.set_sensitive
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


end -- class TEXT_ACTIONS_WINDOW

