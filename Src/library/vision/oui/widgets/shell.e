
-- Shell is the base class for all shell widgets. 

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class SHELL 

inherit

	COMPOSITE
		export
			{NONE} set_managed, manage, unmanage, managed
		redefine 
			implementation
		end
	
feature -- Windowing

	set_override (flag: BOOLEAN) is
		require
			exists: not destroyed
		do
			implementation.set_override (flag);
		end;

	allow_resize is
			-- Allow geometry resize to all geometry requests
			-- from its children.
		require
			exists: not destroyed
		do
			implementation.allow_resize
		end;

	forbid_resize is
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		require
			exists: not destroyed
		do
			implementation.forbid_resize
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
