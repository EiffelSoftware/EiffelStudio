indexing

	description: 
		"EiffelVision implementation of a Motif dialog shell.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	DIALOG_S_M 

inherit

	DIALOG_S_I;

	WM_SHELL_M
		undefine
			popdown
		end;

	POPUP_S_M
		redefine
			set_background_color, update_background_color
		end;

	MEL_DIALOG_SHELL
		rename
			make as mel_dialog_make,
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
			popdown
		end

creation

	make

feature {NONE} -- Initialization

	make (a_dialog_shell: DIALOG_SHELL) is
			-- Create a dialog shell.
		do
			widget_index := widget_manager.last_inserted_position;
			mel_dialog_make (a_dialog_shell.identifier,
				mel_parent (a_dialog_shell, widget_index));
			a_dialog_shell.set_wm_imp (Current);
			initialize (Current)
		end;

feature -- Status setting

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

	xt_set_geometry (scr_obj: POINTER; x_val, y_val: INTEGER) is
		external
			"C"
		end;

	xt_move_widget (scr_obj: POINTER; x_val, y_val: INTEGER) is
		external
			"C"
		end;

end -- class DIALOG_S_M

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
