--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

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

	Positive_depth: depth > 0;
	Valid_parent: parent /= Void

end
