indexing

	description: "Implementation of popup menu"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

create

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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class POPUP_IMP

