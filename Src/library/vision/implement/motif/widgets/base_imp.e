indexing

	description: 
		"EiffleVision implementation of a MOTIF application shell widget.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	BASE_IMP

inherit

	BASE_I;

	TOP_IMP
		rename
			make as top_shell_make,
			is_shown as shown
		undefine
			application_context
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
			set_insensitive as mel_set_insensitive,
			icon_mask as mel_icon_mask,
			set_icon_mask as mel_set_icon_mask,
			icon_pixmap as mel_icon_pixmap,
			set_icon_pixmap as mel_set_icon_pixmap,
			screen as mel_screen,
			is_shown as shown
		undefine
			set_x, set_y, set_x_y, application_context
		redefine
			mel_screen
		select
			app_shell_make
		end
	
	SHARED_APPLICATION_CONTEXT
	
creation

	make

feature {NONE} -- Initialization

	make (a_base: BASE) is
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

end -- class BASE_IMP


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

