--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Shell is the base class for all shell widgets. 

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class SHELL 

inherit

	COMPOSITE
		redefine implementation
		end
	
feature -- Windowing

	allow_resize is
			-- Allow geometry resize to all geometry requests
			-- from its children.
		do
			implementation.allow_resize
		end;

	forbid_resize is
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		do
			implementation.forbid_resize
		end;

	lower is
			-- Lower the shell in the stacking order.
		do
			implementation.lower
		end;

	raise is
			-- Raise the shell to the top of the stacking order.
		do
			implementation.raise
		end 

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: SHELL_I;
			-- Implementation of shell

end 
