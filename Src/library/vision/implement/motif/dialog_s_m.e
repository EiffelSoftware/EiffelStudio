
-- Motif dialog shell implementation.

indexing

	copyright: "See notice at end of class";
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
			set_x, set_y, set_x_y
		end

creation

	make

feature 

	make (a_dialog_shell: DIALOG_SHELL) is
			-- Create a dialog shell.
		local
			ext_name_shell: ANY
		do
			!!is_poped_up_ref;
			ext_name_shell := a_dialog_shell.identifier.to_c;
			screen_object := create_dialog_shell ($ext_name_shell,
							a_dialog_shell.parent.implementation.screen_object);
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

feature {NONE} -- External features

	create_dialog_shell (s_name: ANY; scr_obj: POINTER): POINTER is
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
