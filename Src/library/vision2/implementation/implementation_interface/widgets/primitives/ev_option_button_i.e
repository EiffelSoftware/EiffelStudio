indexing

	description:
		"EiffelVision option button, implementation interface";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_OPTION_BUTTON_I

inherit
	EV_MENU_HOLDER_I

	EV_BUTTON_I
		redefine
			set_center_alignment,
			set_left_alignment,
			set_right_alignment,
			add_click_command,
			set_text
		end

feature -- Status setting

	clear_selection is
		deferred
		end

feature {EV_OPTION_BUTTON} -- Status report

	selected_item: EV_MENU_ITEM is
		deferred
		end

feature {NONE} -- Inapplicable

	set_center_alignment is
		do
			check
				Inapplicable: False
			end
		end

	set_left_alignment is
		do
			check
				Inapplicable: False
			end
		end

	set_right_alignment is
		do
			check
				Inapplicable: False
			end
		end

	add_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		-- Do not work with option buttons in GTK.
		-- use add_button_press_command instead.
		do
			check
				Inapplicable: False
			end
		end

	set_text (txt: STRING) is
		do
			check
				Inapplicable: False
			end
		end

feature {EV_OPTION_BUTTON, EV_MENU_IMP} -- Implementation

	menu_items_array: ARRAYED_LIST [EV_MENU_ITEM_IMP]
			-- List of the children (menu_items) of the
			-- child (menu). We need it for `selected item'.

end -- class EV_OPTION_BUTTON_I

--|----------------------------------------------------------------
--| EiffelVision : library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|---------------------------------------------------------------
