class SCROLL_LIST_ACTIONS_WINDOW

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

	start_b,
	finish_b,
	forth_b,
	wipe_out_b,
	put_right_b,
	remove_b,
	item_b,
	select_item_b,
	selected_it_b,
	selected_pos_b,
	set_visible_item_count_b: ACTION_WINDOW_BUTTON

	set_other_widgets is
		do
			set_size (330, 550)
			!!start_b.associate (Current, b_start, "Start", 20, 300)
			!!finish_b.associate (Current, b_finish, "Finish", 180, 300)
			!!forth_b.associate (Current, b_forth, "Forth", 20, 340)
			!!wipe_out_b.associate (Current, b_wipe_out, "Wipe out", 180, 340)
			!!put_right_b.associate (Current, b_put_right, "Put right", 20, 380)
			!!remove_b.associate (Current, b_remove, "Remove", 180, 380)
			!!item_b.associate (Current, b_item, "Item", 20, 420)
			!!select_item_b.associate (Current, b_select_item, "Select item", 180, 420)
			!!selected_it_b.associate (Current, b_selected_it, "Selected it", 20, 460)
			!!selected_pos_b.associate (Current, b_selected_pos, "Selected pos", 180, 460)
			!!set_visible_item_count_b.associate (Current, b_set_visible_item_count, "Set visibl it count", 20, 500)
		end

	descendant_actions(arg: INTEGER_REF) is
		local
			widget: SCROLLABLE_LIST
			elem: SCROLLABLE_LIST_STRING_ELEMENT
		do
			widget ?= demo_window_array.item (main_window.current_demo).main_widget
			inspect arg.item
			when b_start then
				widget.start
				widget.scroll_to_current
			when b_finish then
				widget.finish
				widget.scroll_to_current
			when b_forth then
				if not widget.empty and then widget.index <= widget.count then
					widget.forth
					widget.scroll_to_current
				end
			when b_wipe_out then
				widget.wipe_out
			when b_put_right then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_put_right)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					!! elem.make_from_string (prompt.selection_text)
					widget.put_right (elem)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_put_right
					prompt.set_selection_label("Enter string:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_put_right)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			when b_set_visible_item_count then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_visible_item_count)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					if prompt.selection_text.to_integer > 0 then
						widget.set_visible_item_count (prompt.selection_text.to_integer)
					end
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt.add_ok_action (Current, b_set_visible_item_count)
					prompt.add_cancel_action (Current, b_cancel)
					prompt_type:=b_set_visible_item_count
					prompt.set_selection_label ("Enter number:")
					prompt.set_selection_text ("")
					set_widgets_insensitive
					prompt.popup
				end
			when b_remove then
				widget.remove
			when b_item then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_item)
					set_widgets_sensitive
				else
					md.set_message (widget.item.value)
					md.add_ok_action (Current, b_item)
					md.popup
					set_widgets_insensitive
				end
			when b_select_item then
				if not widget.off then
					widget.select_item
				end
			when b_selected_it then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_selected_it)
					set_widgets_sensitive
				else
					md.set_message (widget.selected_item.value)
					md.add_ok_action (Current, b_selected_it)
					md.popup
					set_widgets_insensitive
				end
			when b_selected_pos then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, b_selected_pos)
					set_widgets_sensitive
				else
					md.set_message (widget.selected_position.out)
					md.add_ok_action (Current, b_selected_pos)
					md.popup
					set_widgets_insensitive
				end
			else
			end
		end

	set_other_widgets_insensitive is
		do
			start_b.set_insensitive
			finish_b.set_insensitive
			forth_b.set_insensitive
			wipe_out_b.set_insensitive
			put_right_b.set_insensitive
			remove_b.set_insensitive
			item_b.set_insensitive
			select_item_b.set_insensitive
			selected_it_b.set_insensitive
			selected_pos_b.set_insensitive
		end

	set_other_widgets_sensitive is
		do
			start_b.set_sensitive
			finish_b.set_sensitive
			forth_b.set_sensitive
			wipe_out_b.set_sensitive
			put_right_b.set_sensitive
			remove_b.set_sensitive
			item_b.set_sensitive
			select_item_b.set_sensitive
			selected_it_b.set_sensitive
			selected_pos_b.set_sensitive
		end

end -- class SCROLL_LIST_ACTIONS_WINDOW

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

