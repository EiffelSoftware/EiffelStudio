indexing

	description: 
		"EiffelVision implementation of MOTIF shell."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	SHELL_IMP

inherit

	COMPOSITE_IMP
		undefine
			real_x, real_y, mel_destroy, make_from_existing, 
			unmanage, manage, mel_set_insensitive
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
			set_insensitive as mel_set_insensitive,
			screen as mel_screen
		end;

feature -- Geometry operations

	allow_resize is
			-- Allow geometry resize to all geometry requests
			-- from its children.
		do
			allow_shell_resize 
		end;

	forbid_resize is
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		do
			forbid_shell_resize 
		end;

feature  -- Status Setting

	set_override (flag: BOOLEAN) is
			-- Enable or disable the keyboard focus
			-- away from the application windows according
			-- to `flag'.
		do
			if flag then
				enable_override_redirect
			else
				disable_override_redirect
			end
		end;

feature {ALL_CURS_X} -- Implementation

	define_cursor_if_shell (a_cursor: SCREEN_CURSOR) is
			-- Define `cursor' if the current widget is a shell.
		local
			cursor_implementation: SCREEN_CURSOR_IMP
		do
			cursor_implementation ?= a_cursor.implementation;
			cursor_implementation.allocate_cursor;
			define_cursor (cursor_implementation);
			display.flush
		end;

	undefine_cursor_if_shell is
			-- Undefine the cursor if the current widget is a shell.
		do
			undefine_cursor;
			display.flush
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




end -- class SHELL_IMP

