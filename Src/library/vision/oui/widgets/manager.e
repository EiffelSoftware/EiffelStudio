indexing

	description: "General parent widget";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	MANAGER 

inherit 

	COMPOSITE
		redefine
			implementation, parent
		end

	STACKABLE
		redefine
			implementation
		end;

feature -- Access

	parent: COMPOSITE is
			-- Parent of manager widget
		do
			Result ?= widget_manager.parent (Current)
		end;

	foreground_color: COLOR is
			-- Foreground color of manager widget
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
			color_not_void: new_color /= Void
		do
			implementation.set_foreground_color (new_color)
		ensure
			foreground_color = new_color
		end;

	set_foreground (new_color: COLOR) is
			-- Set foreground color to `new_color'.
		require
			exists: not destroyed;
			color_not_void: new_color /= Void
		do
			set_foreground_color (new_color)
		ensure
			foreground_color = new_color
		end 
	
	set_initial_input_focus (a_child: WIDGET) is
			-- Set child which will initially have input focus
		require
			exists: not destroyed;
			a_child_not_void: not (a_child = Void)
			is_a_child: children.has (a_child)
		do
			implementation.set_initial_input_focus (a_child)
		end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: MANAGER_I;
			-- Implementation of manager widget

invariant

	valid_parent: (not destroyed and then parent /= Void) implies depth > 0

end -- class MANAGER



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

