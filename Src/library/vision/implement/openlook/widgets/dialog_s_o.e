indexing

	description: "OpenLook dialog shell implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DIALOG_S_O 

inherit

	DIALOG_S_I
		
		export
			{NONE} all
		end;

	WM_SHELL_O;

	POPUP_S_O
		redefine
			set_x, set_y, set_x_y
		end

creation

	make
	
feature 

	make (a_dialog_shell: DIALOG_SHELL) is
			-- Create a dialog shell.
		local
			ext_name: ANY;
		do
			!!is_poped_up_ref;
			ext_name := a_dialog_shell.identifier.to_c;
			screen_object := create_dialog_shell ($ext_name, a_dialog_shell.parent.implementation.screen_object);
			a_dialog_shell.set_wm_imp (Current);
			initialize (a_dialog_shell);
			popup;
		end; 

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x'
		
		local
			x_name: ANY;
		do
			if  not realized then
				xt_set_geometry (screen_object, new_x, y)
			else
				if shown then
					x_name := Ox.to_c;
					set_posit (screen_object, new_x, $x_name)
				else
					xt_move_widget (screen_object, new_x, y)
				end
			end
		end;

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y'
		
		local
			x_name: ANY;
			y_name: ANY;
		do
			if  not realized then
				xt_set_geometry (screen_object, new_x, new_y)
			else
				if shown then
					x_name := Ox.to_c;
					y_name := Oy.to_c;
					set_posit (screen_object, new_x, $x_name);
					set_posit (screen_object, new_y, $y_name);
				else
					xt_move_widget (screen_object, new_x, new_y)
				end
			end;
		end; 

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y'
		
		local
			y_name: ANY;
		do
			if  not realized then
				xt_set_geometry (screen_object, x, new_y)
			else
				if shown then
					y_name := Oy.to_c;
					set_posit (screen_object, new_y, $y_name);
				else
					xt_move_widget (screen_object, x, new_y)
				end
			end
		end

feature {NONE} -- External features

	create_dialog_shell (name: POINTER; parent: POINTER): POINTER is
		external
			"C"
		end; 
	
	xt_set_geometry (scr_obj: POINTER; new_x, new_y: INTEGER) is
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
