indexing

	description:
		"EiffelVision implementation of a Motif top shell widget.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	TOP_IMP

inherit

	WM_SHELL_IMP
		undefine
			is_shown, mel_destroy, mel_set_insensitive
		redefine
			mel_screen, set_x, set_y, set_x_y
		end;

	SHELL_IMP
		undefine
			is_shown, mel_destroy, mel_set_insensitive
		redefine
			mel_screen, set_x, set_y, set_x_y
		end;

	MEL_TOP_LEVEL_SHELL
		rename
			icon_mask as mel_icon_mask,
			set_icon_mask as mel_set_icon_mask,
			icon_pixmap as mel_icon_pixmap,
			set_icon_pixmap as mel_set_icon_pixmap,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen
		redefine
			mel_screen, set_x, set_y, set_x_y
		end;

	MEL_COMMAND

feature -- Access

	mel_screen: MEL_SCREEN
			-- The screen of the shell

feature -- Status Report

	is_iconic_state: BOOLEAN is
			-- Does application start in iconic state?
		do
			Result := is_iconic
		end;

	is_maximized_state: BOOLEAN is
			-- Does application start in maximized state?
		do
			-- Not implemented
		end

feature -- Status Setting

	set_maximized_state is
			-- Set start state of the application to be maximized.
		do
			-- Not implemented.
		end

	set_iconic_state is
			-- Set start state of the application to be iconic.
		do
			set_initial_state_to_iconic
		end;

	set_normal_state is
			-- Set start state of the application to be normal.
		do
			set_initial_state_to_normal
		end;

	delete_window_action is
			-- Execute command when close button is activated.
		deferred
		end;

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x'
		do
			set_x_y (new_x, y)
		end;

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y'
		do
			set_x_y (x, new_y)
		end;

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y'
		do
			if realized then
				move_to (new_x, new_y)
			else
				set_geometry_position (new_x, new_y)
			end
		end;

feature -- Element change

	add_protocol is
			-- Add the protocol to catch the close button from
			-- the window manager
		local
			atom: MEL_ATOM
		do
			!! atom.make (mel_screen.display, "WM_DELETE_WINDOW", False);
			set_delete_response_do_nothing;
			set_wm_protocol_callback (atom, Current, Void)
		end;

feature -- Execution

	execute (arg: ANY) is
			-- Execute the delete window command.
		do
			delete_window_action
		end;

end -- class TOP_IMP


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

