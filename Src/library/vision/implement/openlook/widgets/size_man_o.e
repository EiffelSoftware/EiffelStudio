indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SIZE_MAN_O
	
feature {NONE}

	allow_recompute_size is
			-- Allow current button to recompute its  size according to
			-- some changes on its text.
		do
			recompute_size := TRUE;
		end;

	forbid_recompute_size is
			-- Forbid current button to recompute its size according to
			-- some changes on its text.
		do
			recompute_size := FALSE;
		end; 

	recompute_size: BOOLEAN;

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
