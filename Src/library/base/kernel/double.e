--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

expanded class DOUBLE

inherit

	DOUBLE_REF
		redefine
			infix "<",
			infix "+",
			infix "-",
			infix "*",
			infix "/",
			prefix "+",
			prefix "-"
		end

feature	-- Comparison

	infix "<" (other: DOUBLE): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			-- Built-in
		end;

feature -- Numeric

	infix "+" (other: DOUBLE): DOUBLE is
			-- Sum of `Current' and `other'
		do
			-- Built-in
		end;

	infix "-" (other: DOUBLE): DOUBLE is
			-- Difference between `Current' and `other'
		do
			-- Built-in
		end;

	infix "*" (other: DOUBLE): DOUBLE is
			-- Product of `Current' by `other'
		do
			-- Built-in
		end;

	infix "/" (other: DOUBLE): DOUBLE is
			-- Division of `Current' by `other'
		do
			-- Built-in
		end;

	prefix "+": DOUBLE is
			-- Unary addition applied to `Current'
		do
			-- Built-in
		end;

	prefix "-": DOUBLE is
			-- Unary subtraction applied to `Current'
		do
			-- Built-in
		end; 

end -- class DOUBLE
