
indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FONT_B_D_O 

inherit

	FONT_B_D_I
		export
			{NONE} all
		end;

	FONT_BOX_O
		undefine
			make, set_managed, real_x, real_y, action_target,
			undefine_cursor_if_shell, define_cursor_if_shell
		redefine
			set_x, set_y, set_x_y
		end;

	DIALOG_O
		redefine
			set_x, set_y, set_x_y
        end

creation

	make

feature 

	make (a_font_box_dialog: FONT_BOX_D) is
			-- Create a motif font box.
		local
			ext_name: ANY
		do
			!!is_poped_up_ref;
			ext_name := a_font_box_dialog.identifier.to_c;
			data := font_box_create ($ext_name,
					a_font_box_dialog.parent.implementation.screen_object, True);
			screen_object := font_box_form (data);
			a_font_box_dialog.set_dialog_imp (Current);
			forbid_resize
			action_target := screen_object;
		end;

feature 

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x'
		local
			ext_name_Ox: ANY
		do
			if  not realized then
				xt_set_geometry (screen_object, new_x, y)
			else
				if shown then
					ext_name_Ox := Ox.to_c;
					set_posit (screen_object, new_x, $ext_name_Ox)
				else
					xt_move_widget (screen_object, new_x, y)
				end
			end
		end;

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y'
		local
			ext_name_Ox, ext_name_Oy: ANY
		do
			if  not realized then
				xt_set_geometry (screen_object, new_x, new_y)
			else
				if shown then
					ext_name_Ox := Ox.to_c;
					ext_name_Oy := Oy.to_c;
					set_posit (screen_object, new_x, $ext_name_Ox);
					set_posit (screen_object, new_y, $ext_name_Oy);
				else
					xt_move_widget (screen_object, new_x, new_y)
				end
			end;
		end;

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y'
		local
			ext_name_Oy: ANY
		do
			if  not realized then
				xt_set_geometry (screen_object, x, new_y)
			else
				if shown then
					ext_name_Oy := Oy.to_c;
					set_posit (screen_object, new_y, $ext_name_Oy);
				else
					xt_move_widget (screen_object, x, new_y)
				end
			end
		end;

feature {NONE} -- External features

	xt_set_geometry (scr_obj: POINTER; x_value, y_value: INTEGER) is
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
