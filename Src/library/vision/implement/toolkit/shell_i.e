indexing

	description: "General shell implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	SHELL_I 

inherit

	COMPOSITE_I
	
feature -- Status setting

	set_override (flag: BOOLEAN) is
		require 
			valid_flag: flag /= Void;
		deferred
		end;

	allow_resize is
			-- Allow geometry resize to all geometry requests
			-- from its children.
		deferred
		end;

	forbid_resize is
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		deferred
		end;

end -- class SHELL_I

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

