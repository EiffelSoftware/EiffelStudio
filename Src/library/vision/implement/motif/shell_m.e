indexing

	description: 
		"EiffelVision implementation of MOTIF shell.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SHELL_M 

inherit

	COMPOSITE_M
		undefine
			real_x, real_y, managed,
			make_from_existing, unmanage, manage,
			clean_up_callbacks
		redefine
			define_cursor_if_shell, undefine_cursor_if_shell
		end;

	MEL_SHELL
		rename
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen
		end;

feature -- Geometry operations

	allow_resize is
			-- Allow geometry resize to all geometry requests
			-- from its children.
		do
			set_allow_shell_resize (True)
		end;

	forbid_resize is
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		do
			set_allow_shell_resize (False)
		end;

feature  -- Status Setting

	set_override (flag: BOOLEAN) is
			-- Enable or disable the keyboard focus
			-- away from the application windows according
			-- to `flag'.
		do
			set_override_redirect (flag);
		end;

feature {ALL_CURS_X} -- Implementation

	define_cursor_if_shell (a_cursor: SCREEN_CURSOR) is
			-- Define `cursor' if the current widget is a shell.
		require else
			a_cursor_exists: not (a_cursor = Void)
		local
			display_pointer, void_pointer: POINTER;
			a_cursor_implementation: SCREEN_CURSOR_X
		do
			--window := xt_window (screen_object);
			--if window /= void_pointer then
				--display_pointer := xt_display (screen_object);
				--a_cursor_implementation ?= a_cursor.implementation;
				--x_define_cursor (display_pointer, window, a_cursor_implementation.cursor_id (screen));
				--x_flush (display_pointer)
			--end
		end;

	undefine_cursor_if_shell is
			-- Undefine the cursor if the current widget is a shell.
		local
			display_pointer: POINTER
		do
			--if window /= 0 then
				--display_pointer := xt_display (screen_object);
				--x_undefine_cursor (display_pointer, window);
				--x_flush (display_pointer)
			--end
		end;

end -- class SHELL_M

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
