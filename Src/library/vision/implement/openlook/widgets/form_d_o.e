
-- OpenLook form dialog implementaiton.

indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FORM_D_O 

inherit

	FORM_D_I
		export
			{NONE} all
		end;

	FORM_O
		rename
			execute as form_execute
		undefine
			real_x, real_y, set_managed,
			define_cursor_if_shell,
			undefine_cursor_if_shell,
			make
		redefine
			set_x, set_y, set_x_y
		end;

	FORM_O
		undefine
			real_x, real_y, set_managed,
			define_cursor_if_shell,
			undefine_cursor_if_shell,
			make
		redefine
			set_x, set_y, set_x_y,
			execute
		select
			execute, hide, show
		end;

	DIALOG_O
		rename 
			execute as dialog_execute,
			realize as dialog_realize,
			initialize as dialog_initialize,
			xt_move_widget as dialog_xt_move_widget,
			hide as dialog_hide,
			show as dialog_show
		undefine
			set_x, set_y, set_x_y
		select
			dialog_realize
		end;

	DIALOG_O
		rename 
			initialize as dialog_initialize,
			xt_move_widget as dialog_xt_move_widget,
			hide as dialog_hide,
			show as dialog_show
		undefine
			set_x, set_y, set_x_y, set_size
		redefine 
			execute
		select
			execute
		end;

creation

	make

feature {NONE}

	popup_screen_object: POINTER;
		
feature 

	make (a_form_dialog: FORM_D) is
			-- Create an openlook form dialog.
		local
			ext_name: ANY;
		do
			!!is_poped_up_ref;
			ext_name := a_form_dialog.identifier.to_c;		
			screen_object := create_form_d ($ext_name, a_form_dialog.parent.implementation.screen_object);
			a_form_dialog.set_dialog_imp (Current);
			initialize (a_form_dialog);
			popup_screen_object := xt_parent (screen_object);
			dialog_initialize (a_form_dialog); --! initializes callbacks
			-- TO FIX forbid_resize;
		end; 

	execute (argument: ANY) is
		local
			bool_ref: BOOLEAN_REF
		do
			bool_ref ?= argument;
			if bool_ref /= Void then
				dialog_execute (bool_ref)
			else
				form_execute (argument)
			end
		end;

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x'
		
		local
			ext_x: ANY;
		do
			if  not realized then
				xt_set_geometry (popup_screen_object, new_x, y)
			else
				if shown then
					ext_x := Ox.to_c;
					set_posit (popup_screen_object, new_x, $ext_x)
				else
					xt_move_widget (popup_screen_object, new_x, y)
				end
			end
		end;

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y'
		
		local
			ext_x, ext_y: ANY;
		do
			if  not realized then
				xt_set_geometry (popup_screen_object, new_x, new_y)
			else
				if shown then
					ext_x := Ox.to_c;
					ext_y := Oy.to_c;
					set_posit (popup_screen_object, new_x, $ext_x);
					set_posit (popup_screen_object, new_y, $ext_y);
				else
					xt_move_widget (popup_screen_object, new_x, new_y)
				end
			end;
		end; 

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y'
		
		local
			ext_y: ANY;
		do
			if  not realized then
				xt_set_geometry (popup_screen_object, x, new_y)
			else
				if shown then
					ext_y := Oy.to_c;
					set_posit (popup_screen_object, new_y, $ext_y);
				else
					xt_move_widget (popup_screen_object, x, new_y)
				end
			end
		end

feature {NONE} -- External features

	create_form_d (name: ANY; parent: POINTER): POINTER is
		external
			"C"
		end;

	xt_set_geometry (scr_obj: POINTER; new_x, new_y: INTEGER) is
		external
			"C"
		end; 

	xt_move_widget (scr_obj: POINTER; an_x, an_y: INTEGER) is
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
