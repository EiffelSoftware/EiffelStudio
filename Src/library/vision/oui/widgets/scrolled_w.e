indexing

	description: "Scrollable window";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	SCROLLED_W 

inherit

	MANAGER
		redefine
			implementation
		end

creation

	make, make_unmanaged
	
feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a scrolled window with `a_name' as identifier
			-- `a_parent' as parent.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged scrolled window with `a_name' as identifier
			-- `a_parent' as parent.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, False)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a scrolled window with `a_name' as identifier
			-- `a_parent' as parent.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			!SCROLLED_W_IMP!implementation.make (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

feature -- Access

	working_area: WIDGET is
			-- Working area of window which will
			-- be moved using scrollbars
		require
			exists: not destroyed
		do
			Result := implementation.working_area
		end;

feature -- Element change

	set_working_area (a_widget: WIDGET) is
			-- Set work area of windon to `a_widget'.
		require
			exists: not destroyed;
			not_a_widget_void: a_widget /= Void
		do
			implementation.set_working_area (a_widget)
		ensure
			working_area = a_widget
		end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: SCROLLED_W_I;
			-- Implementation of scrolled window

feature {NONE} -- Implementation

	set_default is
			-- Set default values to current scrolled window.
		do
		end;

end -- class SCROLLED_W



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

