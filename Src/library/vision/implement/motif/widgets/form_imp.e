indexing

	description: 
		"EiffelVision implementation of a Motif form.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	FORM_IMP

inherit

	FORM_I;

	BULLETIN_IMP
		rename
			is_valid as is_widget_valid,
			attach_right as child_attach_right,
			attach_left as child_attach_left,
			attach_top as child_attach_top,
			attach_bottom as child_attach_bottom,
			detach_right as child_detach_right,
			detach_left as child_detach_left,
			detach_top as child_detach_top,
			detach_bottom as child_detach_bottom
		undefine
			create_widget, is_form
		redefine
			make
		end

	MEL_FORM
		rename
			make as form_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown,
			attach_right as child_attach_right,
			attach_left as child_attach_left,
			attach_top as child_attach_top,
			attach_bottom as child_attach_bottom,
			detach_right as child_detach_right,
			detach_left as child_detach_left,
			detach_top as child_detach_top,
			detach_bottom as child_detach_bottom,
			is_valid as is_widget_valid
		select
			form_make, make_no_auto_unmanage
		end

creation

	make

feature {NONE} -- Initialization

	make (a_form: FORM; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif form.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			form_make (a_form.identifier, mc, man);
		end

feature -- Element change

	attach_right (a_child: WIDGET_I; r_offset: INTEGER) is
			-- Attach right side of `a_child' to the left side of current form
			-- with `r_offset' spaces between each other.
		local
			w: MEL_RECT_OBJ
		do
			w := real_child (a_child);
			w.attach_right;
			w.set_right_offset (r_offset)
		end;

	attach_left (a_child: WIDGET_I; l_offset: INTEGER) is
			-- Attach left side of `a_child' to the left side of current form
			-- with `l_offset' spaces between each other.
		local
			w: MEL_RECT_OBJ
		do
			w := real_child (a_child);
			w.attach_left;
			w.set_left_offset (l_offset)
		end;

	attach_bottom (a_child: WIDGET_I; b_offset: INTEGER) is
			-- Attach bottom side of `a_child' to the bottom side of current form
			-- with `b_offset' spaces between each other.
		local
			w: MEL_RECT_OBJ
		do
			w := real_child (a_child);
			w.attach_bottom;
			w.set_bottom_offset (b_offset)
		end;

	attach_top (a_child: WIDGET_I; t_offset: INTEGER) is
			-- Attach top side of `a_child' to the top side of current form
			-- with `t_offset' spaces between each other.
		local
			w: MEL_RECT_OBJ
		do
			w := real_child (a_child);
			w.attach_top;
			w.set_top_offset (t_offset)
		end;

	attach_right_widget (a_widget: WIDGET_I; a_child: WIDGET_I; r_offset: INTEGER) is
			-- Attach right side of `a_child' to the left side of
			-- `a_widget' with `r_offset' spaces between each other.
		local
			w, t: MEL_RECT_OBJ
		do
			t := real_child (a_widget);
			w := real_child (a_child);
			w.attach_right_to_widget (t);
			w.set_right_offset (r_offset);
		end;

	attach_left_widget (a_widget: WIDGET_I; a_child: WIDGET_I; l_offset: INTEGER) is
			-- Attach left side of `a_child' to the right side of
			-- `a_widget' with `l_offset' spaces between each other.
		local
			w, t: MEL_RECT_OBJ
		do
			t := real_child (a_widget);
			w := real_child (a_child);
			w.attach_left_to_widget (t);
			w.set_left_offset (l_offset);
		end;

	attach_bottom_widget (a_widget: WIDGET_I; a_child: WIDGET_I; b_offset: INTEGER) is
			-- Attach bottom side of `a_child' to the top side of
			-- `a_widget' with `b_offset' spaces between each other.
		local
			w, t: MEL_RECT_OBJ
		do
			t := real_child (a_widget);
			w := real_child (a_child);
			w.attach_bottom_to_widget (t);
			w.set_bottom_offset (b_offset);
		end;

	attach_top_widget (a_widget: WIDGET_I; a_child: WIDGET_I; t_offset: INTEGER) is
			-- Attach top side of `a_child' to the bottom side of
			-- `a_widget' with `t_offset' spaces between each other.
		local
			w, t: MEL_RECT_OBJ
		do
			t := real_child (a_widget);
			w := real_child (a_child);
			w.attach_top_to_widget (t);
			w.set_top_offset (t_offset);
		end;

	attach_left_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach left side of `a_child' to a position that is
			-- relative to left side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		local
			w: MEL_RECT_OBJ
		do
			w := real_child (a_child);
			w.attach_left_to_position (a_position);
			w.set_left_offset (0)
		end;

	attach_right_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach right side of `a_child' to a position that is
			-- relative to right side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		local
			w: MEL_RECT_OBJ
		do
			w := real_child (a_child);
			w.attach_right_to_position (a_position);
			w.set_right_offset (0)
		end;

	attach_bottom_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach bottom side of `a_child' to a position that is
			-- relative to bottom side of current form and is a fraction
			-- of the height of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		local
			w: MEL_RECT_OBJ
		do
			w := real_child (a_child);
			w.attach_bottom_to_position (a_position);
			w.set_bottom_offset (0);
		end;

	attach_top_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach top side of `a_child' to a position that is
			-- relative to top side of current form and is a fraction
			-- of the height of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		local
			w: MEL_RECT_OBJ
		do
			w := real_child (a_child);
			w.attach_top_to_position (a_position);
			w.set_top_offset (0);
		end;

	detach_right (a_child: WIDGET_I) is
			-- Detach right side of `a_child'.
		local
			w: MEL_RECT_OBJ
		do
			w := real_child (a_child);
			w.detach_right;
		end;

	detach_left (a_child: WIDGET_I) is
			-- Detach left side of `a_child'.
		local
			w: MEL_RECT_OBJ
		do
			w := real_child (a_child);
			w.detach_left;
		end;

	detach_bottom (a_child: WIDGET_I) is
			-- Detach bottom side of `a_child'.
		local
			w: MEL_RECT_OBJ
		do
			w := real_child (a_child);
			w.detach_bottom;
		end;

	detach_top (a_child: WIDGET_I) is
			-- Detach top side of `a_child'.
		local
			w: MEL_RECT_OBJ
		do
			w := real_child (a_child);
			w.detach_top;
		end;

feature {NONE} -- Implementation

	real_child (a_child: WIDGET_I): MEL_RECT_OBJ is
			-- Get the real mel child of the `a_child'
		do
			Result ?= a_child;
			if Result.parent /= Current then
				-- This means that the widget could be
				-- scrolled_text or a scrolled_list
				-- and the actual attachment should be
				-- done to the parent widget.
				Result := Result.parent
			end
			if Result.parent /= Current then
				-- This means that the widget could be
				-- opt_pull and the attachment should
				-- be done to the grandparent of the
				-- widget.
				Result := Result.parent
			end	
			check
				form_consistency: Result.parent = Current
			end

		end;

end -- class FORM_IMP


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

