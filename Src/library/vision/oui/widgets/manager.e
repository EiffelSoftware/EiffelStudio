
-- General parent widget.

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class MANAGER 

inherit 

	COMPOSITE
		redefine
			implementation, parent
		end

feature -- Parent composite

	parent: COMPOSITE is
			-- Parent of manager widget
        do
            Result ?= widget_manager.parent (Current)
        end;

feature -- Color

	foreground: COLOR is
			-- Foreground color of manager widget
		do
			Result:= implementation.foreground
		end;

	set_foreground (new_color: COLOR) is
			-- Set foreground color to `new_color'.
		require
			color_not_void: not (new_color = Void)
		do
			implementation.set_foreground (new_color)
		ensure
			foreground = new_color
		end 

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: MANAGER_I;
			-- Implementation of manager widget

invariant

	Valid_parent: parent /= Void implies depth > 0

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
