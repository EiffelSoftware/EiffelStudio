--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Message box with a specific working symbol to inform
-- the user that there is a time-consuming operation in progress and
-- allow him to cancel the operation.
-- A dialog shell is automatically created as its parent.

indexing

	date: "$Date$";
	revision: "$Revision$"

class WORKING_D 

inherit

	MESSAGE_D
		rename
			make as message_d_make
		redefine
			implementation
		end


creation

	make

	
feature 

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a working dialog with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			name_not_void: not (a_name = Void);
			parent_not_void: not (a_parent = Void)
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= a_name.duplicate;
			implementation:= toolkit.working_d (Current);
			set_default
		ensure
			parent = a_parent;
			identifier.is_equal (a_name)
		end;

	
feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: WORKING_D_I
			-- Implementation of working dialog

end
