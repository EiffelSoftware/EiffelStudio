indexing

	description:
		"Objects to which numerical operations are applicable";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	NUMERIC

feature -- Basic operations

	infix "+" (other: NUMERIC): NUMERIC is
			-- Sum with `other'
		require
			other_exists: other /= Void
		deferred
		end;

	infix "-" (other: NUMERIC): NUMERIC is
			-- Result of subtracting `other'
		require
			other_exists: other /= Void
		deferred
		end;

	infix "*" (other: NUMERIC): NUMERIC is
			-- Product by `other'
		require
			other_exists: other /= Void
		deferred
		end;

	infix "/" (other: NUMERIC): NUMERIC is
			-- Division by `other'
		require
			other_exists: other /= Void
		deferred
		end;

--	infix "^" (other: NUMERIC): NUMERIC is
--			-- Current object to the power `other'
--		require
--			other_exists: other /= Void
--		deferred
--		end;

	prefix "+": NUMERIC is
			-- Unary plus
		deferred
		end;

	prefix "-": NUMERIC is
			-- Unary minus
		deferred
		end;

end -- class NUMERIC


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
