indexing

	description: 
		"EiffelVision implmentation of a Motif scrollbar.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCROLLBAR_M 

inherit

	SCROLLBAR_I;

	PRIMITIVE_M
		rename
			is_shown as shown
		undefine
			create_callback_struct
		end;

	MEL_SCROLL_BAR
		rename
			make as mel_scroll_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen,
			increment as granularity,
			value as position,
			set_increment as set_granularity,
			set_horizontal as mel_set_horizontal,
			set_value as set_position,
			is_shown as shown
		end

creation

	make

feature {NONE} -- Initialization

	make (a_scrollbar: SCROLLBAR; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif scrollbar.
		do
			widget_index := widget_manager.last_inserted_position;
            mel_scroll_make (a_scrollbar.identifier,
                    mel_parent (a_scrollbar, widget_index),
                    man);
		end;

feature -- Status report

	is_maximum_right_bottom: BOOLEAN is
			-- Is maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical?
		do
			if is_horizontal then
				Result := not is_maximum_on_left
			else
				Result := not is_maximum_on_top
			end
		end;

feature -- Status setting

	set_horizontal (flag: BOOLEAN) is
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
		do
				mel_set_horizontal (flag)
		end;

	set_maximum_right_bottom (flag: BOOLEAN) is
			-- Set maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical if `flag', and at the opposite side otherwise.
		do
			if flag then
				if is_horizontal then
					set_maximum_on_left (False)
				else
					set_maximum_on_top (False)
				end
			else
				if is_horizontal then
					set_maximum_on_left (True)
				else
					set_maximum_on_top (True)
				end
			end
		end;

feature -- Element change

	add_move_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when slide
			-- is moved.
		do
            add_drag_callback (mel_vision_callback (a_command), argument)
		end; 

	add_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		do
            add_value_changed_callback (mel_vision_callback (a_command), argument)
		end;

feature -- Removal

	remove_move_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- slide is moved.
		do
            remove_drag_callback (mel_vision_callback (a_command), argument)
		end;

	remove_value_changed_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		do
            remove_value_changed_callback (mel_vision_callback (a_command), argument)
		end;

end -- class SCROLLBAR_M

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
