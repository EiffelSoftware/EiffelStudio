indexing

    date: "$Date$";
    revision: "$Revision$"

deferred class STACKABLE

feature

	is_stackable: BOOLEAN is
		do
			Result := implementation.is_stackable;
		end

	window: POINTER is
		do
			Result := implementation.window;
		end;

	parent: COMPOSITE is
		deferred
		end;

	realized: BOOLEAN is
		deferred
		end;


feature {NONE}

	implementation: STACKABLE_I;


end -- STACKABLE

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
