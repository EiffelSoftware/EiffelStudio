indexing

	description: "Implementation of popup menu";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	POPUP_IMP

inherit

	POPUP_I;

	MENU_IMP
		rename
			is_shown as shown
		undefine
			create_callback_struct
		redefine
			parent
		end;

	MEL_POPUP_MENU
		rename
			make as popup_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		redefine
			parent
		end

creation

	make

feature {NONE} -- Initialization

	make (a_popup: POPUP; oui_parent: COMPOSITE) is
			-- Create a motif popup menu.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			popup_make (a_popup.identifier, mc);
			abstract_menu := a_popup
		end;

feature -- Access

	parent: MEL_MENU_SHELL
			-- Parent of popup

feature -- Display

	popup is
			-- Popup current popup menu on screen.
		do
			manage
		end;

end -- class POPUP_IMP


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

