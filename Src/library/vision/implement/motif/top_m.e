indexing

	description:
		"EiffelVision implementation of a Motif top shell widget.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class TOP_M 

inherit

	WM_SHELL_M
		redefine
			set_x, set_y, set_x_y, mel_screen
		end;

	SHELL_M
		redefine
			set_x, set_y, set_x_y, set_background_color,
			update_background_color, mel_screen
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
			screen as mel_screen
		undefine
			set_x, set_y, set_x_y
		redefine
			mel_screen
		end;

	MEL_CALLBACK

feature -- Access

	mel_screen: MEL_SCREEN
			-- The screen of the shell

feature -- Status Report

	is_iconic_state: BOOLEAN is
			-- Does application start in iconic state?
		do
			Result := is_iconic
		end;

feature -- Status Setting

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x'.
		local
			geo_string: STRING	
		do
				--if is_shown then
					--ext_name_Mx := Mx.to_c;
					--set_xt_position (screen_object, new_x, $ext_name_Mx)
				--else
					--xt_move_widget (screen_object, new_x, y)
				--end
			set_xt_position (screen_object, XmNx, new_x)
		end;

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y'.
		local
			ext_name_My: ANY
		do
			if  not realized then
				--xt_set_geometry (screen_object, x, new_y)
			else
				if is_shown then
					--ext_name_My := My.to_c;
					--set_posit (screen_object, new_y, $ext_name_My);
				else
					--xt_move_widget (screen_object, x, new_y)
				end
			end
			set_xt_position (screen_object, XmNy, new_y)
		end;

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y'.
		do
			if  not realized then
				--xt_set_geometry (screen_object, new_x, new_y)
			else
				--xt_move_widget (screen_object, new_x, new_y)
			end;
			set_xt_position (screen_object, XmNx, new_x)
			set_xt_position (screen_object, XmNy, new_y)
		end;

	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
		local
			pixmap_implementation: PIXMAP_X;
			color_implementation: COLOR_X;
			ext_name: ANY
		do
			if private_background_pixmap /= Void then
				pixmap_implementation ?= private_background_pixmap.implementation;
				pixmap_implementation.remove_object (Current);
				private_background_pixmap := Void
			end;
			if private_background_color /= Void then
				color_implementation ?= private_background_color.implementation;
				color_implementation.remove_object (Current)
			end;
			private_background_color := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.put_object (Current);
			--ext_name := Mbackground.to_c;
			--c_set_color (screen_object, color_implementation.pixel (screen),
						--$ext_name)
		end;

	set_iconic_state is
			-- Set start state of the application to be iconic.
		do
			set_initial_state_normal (False)
		end;

	set_normal_state is
			-- Set start state of the application to be normal.
		do
			set_initial_state_normal (True)
		end;

	delete_window_action is
			-- Execute command when close button is activated.
		deferred
		end;

feature -- Element change

	add_protocol is
			-- Add the protocol to catch the close button from
			-- the window manager
		local
			atom: MEL_ATOM
		do
			!! atom.make (mel_screen.display, "WM_DELETE_WINDOW", False);
			--set_delete_response_do_nothing;
			--add_wm_protocol (atom);
			--!! atom.make_from_existing (screen_object);
			add_wm_protocol_callback (atom, Current, Void);
		end;

feature -- Execution

	execute (arg: ANY) is
			-- Execute the delete window command.
		do
			delete_window_action
		end;

feature {COLOR_X} -- Implementation

	update_background_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			ext_name: ANY;
			color_implementation: COLOR_X;
		do
			--ext_name := Mbackground.to_c;
			color_implementation ?= background_color.implementation;
			--c_set_color (screen_object, color_implementation.pixel (screen), $ext_name)
		end;

feature {NONE} -- External features

	xt_set_geometry (scr_obj: POINTER; x_value, y_value: INTEGER) is
		external
			"C"
		end;

	xt_move_widget (scr_obj: POINTER; x_value, y_value: INTEGER) is
		external
			"C"
		end;

end -- class TOP_M

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
