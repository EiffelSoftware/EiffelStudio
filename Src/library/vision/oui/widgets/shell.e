
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
		end;

	is_popup_shell: BOOLEAN is
		do
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: SHELL_I;
			-- Implementation of shell

end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
