indexing

	description: 
		"EiffelVision shell, gtk implementation.";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"
	
--XXdeferred class
class
	SHELL_IMP
	
inherit
	SHELL_I
	COMPOSITE_IMP
	


feature -- Status setting

	set_override (flag: BOOLEAN) is
		do
			check
				not_be_called: False
			end
		end;

	allow_resize is
			-- Allow geometry resize to all geometry requests
			-- from its children.
		do
			check
				not_be_called: False
			end
		end;

	forbid_resize is
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		do
			check
				not_be_called: False
			end
		end;

end -- class SHELL_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
