indexing

	description: "Motif dialog shell implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DIALOG_S_M 

inherit

	DIALOG_S_I
		export
			{NONE} all
		end;

	WM_SHELL_M;

	POPUP_S_M
		redefine
			set_x, set_y, set_x_y, set_background_color,
			update_background_color
		end

creation

	make

feature {NONE} -- Creation

	make (a_dialog_shell: DIALOG_SHELL) is
			-- Create a dialog shell.
		local
			ext_name_shell: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			!!is_popped_up_ref;
			ext_name_shell := a_dialog_shell.identifier.to_c;
			screen_object := create_dialog_shell ($ext_name_shell,
							parent_screen_object (a_dialog_shell, widget_index));
			a_dialog_shell.set_wm_imp (Current);
			initialize (a_dialog_shell);
		end;

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x'
		local
			ext_name_Mx: ANY
		do
			if  not realized then
				xt_set_geometry (screen_object, new_x, y)
			else
				if shown then
					ext_name_Mx := Mx.to_c;
					set_posit (screen_object, new_x, $ext_name_Mx)
				else
					xt_move_widget (screen_object, new_x, y)
				end
			end
		end;

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y'
		local
			ext_name_Mx, ext_name_My: ANY
		do
			if  not realized then
				xt_set_geometry (screen_object, new_x, new_y)
			else
				if shown then
					ext_name_Mx := Mx.to_c;
					ext_name_My := My.to_c;
					set_posit (screen_object, new_x, $ext_name_Mx);
					set_posit (screen_object, new_y, $ext_name_My);
				else
					xt_move_widget (screen_object, new_x, new_y)
				end;
			end;
		end;

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y'
		local
			ext_name_My: ANY
		do
			if  not realized then
				xt_set_geometry (screen_object, x, new_y)
			else
				if shown then
					ext_name_My := My.to_c;
					set_posit (screen_object, new_y, $ext_name_My);
				else
					xt_move_widget (screen_object, x, new_y)
				end
			end
		end

feature -- Color

	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
		local
			pixmap_implementation: PIXMAP_X;
			color_implementation: COLOR_X;
			ext_name: ANY
		do
			if bg_pixmap /= Void then
				pixmap_implementation ?= bg_pixmap.implementation;
				pixmap_implementation.remove_object (Current);
				bg_pixmap := Void
			end;
			if bg_color /= Void then
				color_implementation ?= background_color.implementation;
				color_implementation.remove_object (Current)
			end;
			bg_color := a_color;
			color_implementation ?= background_color.implementation;
			color_implementation.put_object (Current);
			ext_name := Mbackground.to_c;
			c_set_color (screen_object, color_implementation.pixel (screen),
						$ext_name)
		end;

feature {COLOR_X} 

	update_background_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			ext_name: ANY;
			color_implementation: COLOR_X;
		do
			ext_name := Mbackground.to_c;
			color_implementation ?= background_color.implementation;
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name)
		end;


feature {NONE} -- External features

	create_dialog_shell (s_name: POINTER; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	xt_set_geometry (scr_obj: POINTER; x_val, y_val: INTEGER) is
		external
			"C"
		end;

	xt_move_widget (scr_obj: POINTER; x_val, y_val: INTEGER) is
		external
			"C"
		end;

end



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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
