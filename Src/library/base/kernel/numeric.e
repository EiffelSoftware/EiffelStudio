--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class NUMERIC

feature -- Numeric

	infix "+" (other: NUMERIC): NUMERIC is
			-- Sum of `Current' and `other'
		require
			other_exists: other /= Void
		deferred
		end;

	infix "-" (other: NUMERIC): NUMERIC is
			-- Difference between `Current' and `other'
		require
			other_exists: other /= Void
		deferred
		end;

	infix "*" (other: NUMERIC): NUMERIC is
			-- Product of `Current' by `other'
		require
			other_exists: other /= Void
		deferred
		end;

	infix "/" (other: NUMERIC): NUMERIC is
			-- Division of `Current' by `other'
		require
			other_exists: other /= Void
		deferred
		end;

	prefix "+": NUMERIC is
			-- Unary addition applied to `Current'
		deferred
		end;

	prefix "-": NUMERIC is
			-- Unary subtraction applied to `Current'
		deferred
		end;

end -- class NUMERIC
