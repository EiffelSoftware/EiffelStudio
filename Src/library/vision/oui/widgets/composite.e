--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- General notion of composite widget 
-- i.e. which accepts children.

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class COMPOSITE 

inherit

	WIDGET
		redefine
			implementation, parent
		end

feature -- Widget hierarchy

	parent: COMPOSITE is
			-- Parent of composite
        do
            Result ?= widget_manager.parent (Current)
        end;

	children_count: INTEGER is
			-- Number of children
		do
			Result:= implementation.children_count
		ensure
			Positive_result: Result >= 0
		end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: COMPOSITE_I;
			-- Implementation of Current

end
