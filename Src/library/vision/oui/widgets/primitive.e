indexing

	description:
		"General notion of primitive widget, %
		%i.e. which cannot accept any children";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	PRIMITIVE 

inherit

	WIDGET
		redefine
			implementation, parent
		end;

	STACKABLE
		redefine
			implementation
		end;
	
feature -- Access

	parent: COMPOSITE is
			-- Parent of Current widget
		do
			Result ?= widget_manager.parent (Current)
		end;

	foreground_color: COLOR is
			-- Foreground color of Current widget
		require
			exists: not destroyed
		do
			Result:= implementation.foreground_color
		ensure
			valid_result: Result /= Void
		end;

feature -- Element change

	set_foreground_color (new_color: COLOR) is
			-- Set foreground color to `new_color'.
		require
			exists: not destroyed;
			Valid_color: new_color /= Void
		do
			implementation.set_foreground_color (new_color)
		ensure
			foreground_set: foreground_color = new_color
		end 

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: PRIMITIVE_I;
			-- Implementation of Current widget

invariant

	Positive_depth: depth > 0;
	Has_parent: not destroyed implies parent /= Void

end -- class PRIMITIVE



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

