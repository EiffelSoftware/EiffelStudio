--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- General notion of primitive widget,
-- i.e. which cannot accept any children.

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class PRIMITIVE 

inherit

	WIDGET
		redefine
			implementation, parent
		end
	
feature -- Widget hierarchy

	parent: COMPOSITE is
			-- Parent of Current widget
        do
            Result ?= widget_manager.parent (Current)
        end; -- parent

feature -- Color

	foreground: COLOR is
			-- Foreground color of Current widget
		do
			Result:= implementation.foreground
		end;

	set_foreground (new_color: COLOR) is
			-- Set foreground color to `new_color'.
		require
			Valid_color: new_color /= Void
		do
			implementation.set_foreground (new_color)
		ensure
			Foreground_set: foreground = new_color
		end 

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: PRIMITIVE_I;
			-- Implementation of Current widget

invariant

	Positive_depth: depth > 0;
	Has_parent: not (parent = Void)

end
