
indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SHELL_O 

inherit

	SHELL_R_O
		export
			{NONE} all
		end;

	COMPOSITE_O
		redefine
			define_cursor_if_shell, undefine_cursor_if_shell,
			real_x, real_y, set_managed
		end

feature 

	allow_resize is
			-- Allow geometry resize to all geometry requests
			-- from its children.
		do
			set_xt_boolean (screen_object, True, OallowShellResize)
		end;

feature {ALL_CURS_X}

	define_cursor_if_shell (a_cursor: SCREEN_CURSOR) is
			-- Define `cursor' if the current widget is a shell.
		require else
			a_cursor_exists: not (a_cursor = Void)
		local
			display_pointer, window, void_pointer: POINTER;
			cursor_implementation: SCREEN_CURSOR_X	
		do
			window := xt_window (screen_object);
			if window /= void_pointer then
				display_pointer := xt_display (screen_object);
				cursor_implementation ?= a_cursor.implementation;
				x_define_cursor (display_pointer, window, cursor_implementation.cursor_id (screen));
				x_flush (display_pointer)
			end
		end;

feature 

	forbid_resize is
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		do
			set_xt_boolean (screen_object, False, OallowShellResize)
		end;

	lower is
			-- Lower the shell in the stacking order.
		
		local
            window, display_pointer, void_pointer: POINTER
		do
			window := xt_window (screen_object);
			if window /= void_pointer then
				display_pointer := xt_display (screen_object);
				x_lower_window (display_pointer, window)
			end
		end;

	raise is
			-- Raise the shell to the top of the stacking order.
		
		local
            window, display_pointer, void_pointer: POINTEr
		do
			window := xt_window (screen_object);
			if window /= void_pointer then
				display_pointer := xt_display (screen_object);
				x_raise_window (display_pointer, window)
			end
		end;

	real_x: INTEGER is
			-- Vertical position relative to root window
		
		local
			ext_name: ANY;
		do
			ext_name := Ox.to_c;		
			Result := get_position (screen_object, $ext_name)
		end;

	real_y: INTEGER is
			-- Horizontal position relative to root window
		
		local
			ext_name: ANY;
		do
			ext_name := Oy.to_c;		
			Result := get_position (screen_object, $ext_name)
		end; 

	set_managed (flag: BOOLEAN) is
			-- Enable geometry managment on screen widget implementation,
			-- by window manager of parent widget if `flag', disable it
			-- otherwise.
		do
		ensure then
			managed = flag
		end; 

feature {ALL_CURS_X}

	undefine_cursor_if_shell is
			-- Undefine the cursor if the current widget is a shell.
		
		local
			display_pointer, window, void_pointer: POINTER;
		do
			window := xt_window (screen_object);
			if window /= void_pointer then
				display_pointer := xt_display (screen_object);
				x_undefine_cursor (display_pointer, window);
				x_flush (display_pointer)
			end
		end

feature {NONE} -- External features

	x_undefine_cursor (display, window: POINTER) is
		external
			"C"
		end;

	xt_move_widget (scr_obj: POINTER; an_x, an_y: INTEGER) is
		external
			"C"
		end; 

	x_lower_window (disp, wind: POINTER) is
		external
			"C"
		end; 

	x_raise_window (disp, wind: POINTER) is
		external
			"C"
		end; 

end



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
