indexing

	description: "Button drawn on screen with an arrow";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	ARROW_B 

inherit

	BUTTON
		redefine
			implementation, text, set_text, 
			font, set_font,
			set_left_alignment, set_center_alignment
		end

creation

	make, make_unmanaged

feature {NONE} -- Initialization 
	
	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an arrow button with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
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
			-- Default_orientation: up
		end

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged arrow button with `a_name' 
			-- as identifier, `a_parent' as parent and 
			-- call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void;
			parent_not_menu_bar: is_valid (a_parent)
		do
			create_ev_widget (a_name, a_parent, False)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
			-- default_orientation: up
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create an arrow button with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			!ARROW_B_IMP!implementation.make (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

feature -- Status report

	down: BOOLEAN is
			-- Is the arrow direction down ?
		require
			exists: not destroyed
		do
			Result := implementation.down
		end;

	left: BOOLEAN is
			-- Is the arrow direction left ?
		require
			exists: not destroyed
		do
			Result := implementation.left
		end;

	right: BOOLEAN is
			-- Is the arrow direction right ?
		require
			exists: not destroyed
		do
			Result := implementation.right
		end;

	up: BOOLEAN is
			-- Is the arrow direction up ?
		require
			exists: not destroyed
		do
			Result := implementation.up
		end;

	is_valid (other: COMPOSITE): BOOLEAN is
			-- Is `other' a valid parent?
		local
			a_bar: BAR
		do
			a_bar ?= other;
			Result := (a_bar = Void)
		end;

feature -- Status setting

	set_down is
			-- Set the arrow direction to down.
		require
			exists: not destroyed
		do
			implementation.set_down
		end;

	set_left is
			-- Set the arrow direction to left.
		require
			exists: not destroyed
		do
			implementation.set_left
		end;

	set_right is
			-- Set the arrow direction to right.
		require
			exists: not destroyed
		do
			implementation.set_right
		end;

	set_up is
			-- Set the arrow direction to up.
		require
			exists: not destroyed
		do
			implementation.set_up
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: ARROW_B_I;
			-- Implementation of arrow button

feature {NONE} -- Implementation

	set_default is
			-- Set default values to current arrow button.
		do
		end;

feature {NONE} -- Inapplicable

	font: FONT is
			-- Font of arrow button
		do
		end;

	set_font (a_font: FONT) is
			-- Set font to `a_font'.
		do
		end;

	text: STRING is
			-- Text of current button
		do
		end;

	set_text (a_text: STRING) is
			-- Do nothing. 
		do
		end;

	set_left_alignment is
			-- Set text alignment to left.
		do
		end;
 
	set_center_alignment is
			-- Set text alignment to center.
		do
		end;

	set_right_alignment is
			-- Set text alignment to right.
		do
		end

end -- class ARROW_B



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

