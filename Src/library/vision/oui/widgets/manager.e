indexing

	description: "General parent widget";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class MANAGER 

inherit 

	COMPOSITE
		redefine
			implementation, parent
		end

	STACKABLE
		redefine
			implementation
		end;

feature -- Parent composite

	parent: COMPOSITE is
			-- Parent of manager widget
		do
			Result ?= widget_manager.parent (Current)
		end;

feature -- Color

	foreground_color: COLOR is
			-- Foreground color of manager widget
		require
			exists: not destroyed
		do
			Result:= implementation.foreground_color
		ensure
			valid_result: Result /= Void
		end;

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

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: MANAGER_I;
			-- Implementation of manager widget

invariant

	valid_parent: (not destroyed and then parent /= Void) implies depth > 0

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
