
-- Scrollable window.

indexing

	date: "$Date$";
	revision: "$Revision$"

class SCROLLED_W 

inherit

	MANAGER
		redefine
			implementation
		end

creation

	make
	
feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a scrolled window with `a_name' as identifier
			-- `a_parent' as parent.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			implementation:= toolkit.scrolled_w (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifier_set: identifier.is_equal (a_name)
		end;

feature -- Working Area

	working_area: WIDGET is
			-- Working area of window which will
			-- be moved using scrollbars
		do
			Result := implementation.working_area
		end;

	set_working_area (a_widget: WIDGET) is
			-- Set work area of windon to `a_widget'.
		require
			not_a_widget_void: not (a_widget = Void)
		do
			implementation.set_working_area (a_widget)
		ensure
			working_area = a_widget
		end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: SCROLLED_W_I;
			-- Implementation of scrolled window

feature {NONE}

	set_default is
			-- Set default values to current scrolled window.
		do
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
