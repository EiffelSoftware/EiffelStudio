--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Simple frame which can only contain one child.

indexing

	date: "$Date$";
	revision: "$Revision$"

class FRAME 

inherit

	MANAGER
		redefine
			implementation
		end

creation

	make
	
feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a frame with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
            depth := a_parent.depth+1;
            widget_manager.new (Current, a_parent);
			identifier:= a_name.duplicate;
			implementation:= toolkit.frame (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifier_set: identifier.is_equal (a_name)
		end;
	
feature {NONE}

	set_default is
			-- Set default values to current frame.
		do
		end;
	
feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: FRAME_I
			-- Implementation of frame

end 
