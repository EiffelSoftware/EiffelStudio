indexing

	description: 
		"EiffleVision implementation of a MOTIF application shell widget.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	BASE_M 

inherit

	BASE_I;

	TOP_M
		rename
			make as top_shell_make,
			is_shown as shown
		redefine
			mel_screen
		end;

	MEL_APPLICATION_SHELL
		rename
			make as app_shell_make,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			icon_mask as mel_icon_mask,
			set_icon_mask as mel_set_icon_mask,
			icon_pixmap as mel_icon_pixmap,
			set_icon_pixmap as mel_set_icon_pixmap,
			screen as mel_screen,
			is_shown as shown
		undefine
			set_x, set_y, set_x_y
		redefine
			mel_screen
		select
			app_shell_make
		end

creation

	make

feature {NONE} -- Initialization

	make (a_base: BASE; application_class: STRING) is
			-- Create an application shell.
		local
			x_display: MEL_DISPLAY
		do
			widget_index := widget_manager.last_inserted_position;
			oui_top := a_base;
			x_display ?= a_base.screen.implementation;
				-- Use default screen.
			app_shell_make (a_base.identifier, application_class, x_display.default_screen);
			a_base.set_wm_imp (Current);
			add_protocol
		end

feature -- Access

	mel_screen: MEL_SCREEN
			-- Screen of the shell

end -- class BASE_M

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
