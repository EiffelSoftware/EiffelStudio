indexing

	description: "Shell is the base class for all shell widgets";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	SHELL 

inherit

	COMPOSITE
		export
			{NONE} set_managed, manage, unmanage, managed
		redefine 
			implementation
		end
	
feature -- Status report

	is_popup_shell: BOOLEAN is
		do
		end;

feature -- Status setting

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

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: SHELL_I;
			-- Implementation of shell

end -- class SHELL



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

