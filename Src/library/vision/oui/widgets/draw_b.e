indexing

	description: "Drawable rectangle with a shadow border";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	DRAW_B 

inherit

	BUTTON
		redefine
			implementation
		end;

	DRAWING
		
creation

	make
	
feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a draw button with `a_name' as identifier
			-- and `a_parent' as parent.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void;
			parent_not_menu_bar: is_valid (a_parent)
		do
			create_ev_widget (a_name, a_parent, True)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged draw button with `a_name' as identifier
			-- and `a_parent' as parent.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void;
			parent_not_menu_bar: is_valid (a_parent)
		do
			create_ev_widget (a_name, a_parent, True)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a draw button with `a_name' as identifier
			-- and `a_parent' as parent.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			!DRAW_B_IMP!implementation.make (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

feature -- Status report

	is_valid (other: COMPOSITE): BOOLEAN is
			-- Is `other' a valid parent?
		local
			a_bar: BAR
		do
			a_bar ?= other;
			Result := (a_bar = Void)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: DRAW_B_I;
			-- Implementation of draw button
	
feature {NONE} -- Implementation

	set_default is
			-- Set default values to current drawing button.
		do
		end;

end -- class DRAW_B



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

