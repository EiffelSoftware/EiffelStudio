indexing

	description: "Motif implementation of form";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FORM_M

inherit

	FORM_R_M
		export
			{NONE} all
		end;

	FORM_I;

	BULLETIN_M
		undefine
			make
		end

creation

	make

feature {NONE} -- Creation

	make (a_form: FORM; man: BOOLEAN) is
			-- Create a motif form.
		local
			ext_name_form: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name_form := a_form.identifier.to_c;
			screen_object := create_form ($ext_name_form,
					parent_screen_object (a_form, widget_index),
					man);
		end

feature 

	attach_right (a_child: WIDGET_I; right_offset: INTEGER) is
			-- Attach right side of `a_child' to the left side of current form
			-- with `right_offset' spaces between each other.
		require else
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			offset_non_negative: right_offset >= 0
		do
			xm_attach_right (a_child.screen_object, right_offset)
		end;

	attach_left (a_child: WIDGET_I; left_offset: INTEGER) is
			-- Attach left side of `a_child' to the left side of current form
			-- with `left_offset' spaces between each other.
		require else
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			offset_non_negative: left_offset >= 0
		do
			xm_attach_left (a_child.screen_object, left_offset)
		end;

	attach_bottom (a_child: WIDGET_I; bottom_offset: INTEGER) is
			-- Attach bottom side of `a_child' to the bottom side of current form
			-- with `bottom_offset' spaces between each other.
		require else
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			offset_non_negative: bottom_offset >= 0
		do
			xm_attach_bottom (a_child.screen_object, bottom_offset)
		end;

	attach_top (a_child: WIDGET_I; top_offset: INTEGER) is
			-- Attach top side of `a_child' to the top side of current form
			-- with `top_offset' spaces between each other.
		require else
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			offset_non_negative: top_offset >= 0
		do
			xm_attach_top (a_child.screen_object, top_offset)
		end;

	attach_right_widget (a_widget: WIDGET_I; a_child: WIDGET_I; right_offset: INTEGER) is
			-- Attach right side of `a_child' to the left side of
			-- `a_widget' with `right_offset' spaces between each other.
		require else
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			not_widget_void: not (a_widget = Void);
			offset_non_negative: right_offset >= 0
		do
			xm_attach_right_widget (a_widget.screen_object,
						a_child.screen_object, right_offset)
		end;

	attach_left_widget (a_widget: WIDGET_I; a_child: WIDGET_I; left_offset: INTEGER) is
			-- Attach left side of `a_child' to the right side of
			-- `a_widget' with `left_offset' spaces between each other.
		require else
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			not_widget_void: not (a_widget = Void);
			offset_non_negative: left_offset >= 0
		do
			xm_attach_left_widget (a_widget.screen_object,
						a_child.screen_object, left_offset)
		end;

	attach_bottom_widget (a_widget: WIDGET_I; a_child: WIDGET_I; bottom_offset: INTEGER) is
			-- Attach bottom side of `a_child' to the top side of
			-- `a_widget' with `bottom_offset' spaces between each other.
		require else
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			not_widget_void: not (a_widget = Void);
			offset_non_negative: bottom_offset >= 0
		do
			xm_attach_bottom_widget (a_widget.screen_object,
						a_child.screen_object, bottom_offset)
		end;

	attach_top_widget (a_widget: WIDGET_I; a_child: WIDGET_I; top_offset: INTEGER) is
			-- Attach top side of `a_child' to the bottom side of
			-- `a_widget' with `top_offset' spaces between each other.
		require else
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			not_widget_void: not (a_widget = Void);
			offset_non_negative: top_offset >= 0
		do
			xm_attach_top_widget (a_widget.screen_object,
						a_child.screen_object, top_offset)
		end;

	attach_left_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach left side of `a_child' to a position that is
			-- relative to left side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require else
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		do
			xm_attach_left_position (a_child.screen_object, a_position)
		end;

	attach_right_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach right side of `a_child' to a position that is
			-- relative to right side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require else
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		do
			xm_attach_right_position (a_child.screen_object, a_position)
		end;

	attach_bottom_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach bottom side of `a_child' to a position that is
			-- relative to bottom side of current form and is a fraction
			-- of the height of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require else
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		do
			xm_attach_bottom_position (a_child.screen_object, a_position)
		end;

	attach_top_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach top side of `a_child' to a position that is
			-- relative to top side of current form and is a fraction
			-- of the height of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		require else
			not_child_void: not (a_child = Void);
			not_shell_child: is_valid (a_child);
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		do
			xm_attach_top_position (a_child.screen_object, a_position)
		end;

	detach_right (a_child: WIDGET_I) is
			-- Detach right side of `a_child'.
		require else
			not_child_void: not (a_child = Void)
		do
			xm_detach_right (a_child.screen_object)
		end;

	detach_left (a_child: WIDGET_I) is
			-- Detach left side of `a_child'.
		require else
			not_child_void: not (a_child = Void)
		do
			xm_detach_left (a_child.screen_object)
		end;

	detach_bottom (a_child: WIDGET_I) is
			-- Detach bottom side of `a_child'.
		require else
			not_child_void: not (a_child = Void)
		do
			xm_detach_bottom (a_child.screen_object)
		end;

	detach_top (a_child: WIDGET_I) is
			-- Detach top side of `a_child'.
		require else
			not_child_void: not (a_child = Void)
		do
			xm_detach_top (a_child.screen_object)
		end;

	set_fraction_base (a_value: INTEGER) is
			-- Set fraction_base to `a_value'.
			-- Unsecure to set it after any position attachment,
			-- contradictory constraints could occur.
		require else
			a_value_strictly_greater_than_zero: a_value > 0
		do
			set_xt_int (screen_object, a_value, MfractionBase)
		ensure then
			fraction_base = a_value
		end;

	fraction_base: INTEGER is
			-- Value used to compute child position with
			-- position attachment
		do
			Result := xt_int (screen_object, MfractionBase)
		ensure then
			fraction_base_strictly_greater_than_zero: Result > 0
		end;

feature {NONE} -- External features

	xm_attach_right (scr_obj: POINTER; offset: INTEGER) is
		external
			"C"
		end;

	xm_detach_top (scr_obj: POINTER) is
		external
			"C"
		end;

	xm_detach_bottom (scr_obj: POINTER) is
		external
			"C"
		end;

	xm_detach_left (scr_obj: POINTER) is
		external
			"C"
		end;

	xm_detach_right (scr_obj: POINTER) is
		external
			"C"
		end;

	xm_attach_top_position (scr_obj: POINTER; position: INTEGER) is
		external
			"C"
		end;

	xm_attach_bottom_position (scr_obj: POINTER; position: INTEGER) is
		external
			"C"
		end;

	xm_attach_right_position (scr_obj: POINTER; position: INTEGER) is
		external
			"C"
		end;

	xm_attach_left_position (scr_obj: POINTER; offset: INTEGER) is
		external
			"C"
		end;

	xm_attach_top_widget (scr_obj1, scr_obj2: POINTER; offset: INTEGER) is
		external
			"C"
		end;

	xm_attach_bottom_widget (scr_obj1, scr_obj2: POINTER; offset: INTEGER) is
		external
			"C"
		end;

	xm_attach_left_widget (scr_obj1, scr_obj2: POINTER; offset: INTEGER) is
		external
			"C"
		end;

	xm_attach_right_widget (scr_obj1, scr_obj2: POINTER; offset: INTEGER) is
		external
			"C"
		end;

	xm_attach_top (scr_obj: POINTER; offset: INTEGER) is
		external
			"C"
		end;

	xm_attach_bottom (scr_obj: POINTER; offset: INTEGER) is
		external
			"C"
		end;

	xm_attach_left (scr_obj: POINTER; offset: INTEGER) is
		external
			"C"
		end;

	create_form (f_name: POINTER; scr_obj: POINTER;
			man: BOOLEAN): POINTER is
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
