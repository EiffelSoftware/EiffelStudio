
-- Text in Scrolled Window

indexing

	date: "$Date$";
	revision: "$Revision$"

class SCROLLED_T 

inherit

	TEXT
		rename
			make as text_make
		redefine
			implementation
		end

creation

	make
	
feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a scrolled text with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			implementation := toolkit.scrolled_t (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifier_set: identifier.is_equal (a_name)
		end;
	
feature -- Scrollbar visibility and orientation 

	show_vertical_scrollbar is
			-- Make vertical scrollbar visible.
		do
			implementation.show_vertical_scrollbar
		end;

	hide_vertical_scrollbar is
			-- Make vertical scrollbar invisible.
		do
			implementation.hide_vertical_scrollbar
		end;

	show_horizontal_scrollbar is
			-- Make horizontal scrollbar visible.
		do
			implementation.show_horizontal_scrollbar
		end;

	hide_horizontal_scrollbar is
			-- Make horizontal scrollbar invisible.
		do
			implementation.hide_horizontal_scrollbar
		end;

	is_vertical_scrollbar: BOOLEAN is
			-- Is vertical scrollbar visible?
		do
			Result := implementation.is_vertical_scrollbar
		end;

	is_horizontal_scrollbar: BOOLEAN is
			-- Is horizontal scrollbar visible?
		do
			Result := implementation.is_horizontal_scrollbar
		end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: SCROLLED_T_I;
			-- Implementation of current text

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
