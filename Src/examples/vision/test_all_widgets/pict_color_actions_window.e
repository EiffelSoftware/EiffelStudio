class PICT_COLOR_ACTIONS_WINDOW

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

	set_pixmap_b: ACTION_WINDOW_BUTTON

	set_other_widgets is
	do
			set_size (330, 350)
			!!set_pixmap_b.associate (Current, b_set_pixmap, "Set pixmap", 20, 300);
		end;

	descendant_actions(arg: INTEGER_REF) is
		local
			widget: PICT_COLOR_B
			pixmap: PIXMAP
		do
			widget ?= demo_window_array.item(main_window.current_demo).main_widget
			if arg.item=b_set_pixmap then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_pixmap)
					prompt.remove_cancel_action (Current, b_cancel)
					!!pixmap.make
					pixmap.read_from_file (prompt.selection_text)
					if pixmap.is_valid then
						widget.set_pixmap (pixmap)
					end
					set_widgets_sensitive
					prompt.popdown
				else
					prompt.add_ok_action (Current, b_set_pixmap)
					prompt.add_cancel_action (Current, b_cancel)
					prompt.set_selection_label("Enter pixmap file:")
					prompt.set_selection_text ("")
					prompt_type:=b_set_pixmap
					set_widgets_insensitive
					prompt.popup
				end
			else
			end
		end;

	set_other_widgets_insensitive is
		do
			set_pixmap_b.set_insensitive
		end

	set_other_widgets_sensitive is
		do
			set_pixmap_b.set_sensitive
		end

end -- class PICT_COLOR_ACTIONS_WINDOW

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

