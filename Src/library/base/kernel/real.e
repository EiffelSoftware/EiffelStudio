--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

expanded class REAL

inherit

	REAL_REF
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

	infix "<" (other: REAL): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			-- Built-in
		end; -- infix "<"

feature -- Numeric

	infix "+" (other: REAL): REAL is
			-- Sum of `Current' and `other'
		do
			-- Built-in
		end; -- infix "+"

	infix "-" (other: REAL): REAL is
			-- Difference between `Current' and `other'
		do
			-- Built-in
		end; -- infix "-"

	infix "*" (other: REAL): REAL is
			-- Product of `Current' by `other'
		do
			-- Built-in
		end; -- infix "*"

	infix "/" (other: REAL): REAL is
			-- Division of `Current' by `other'
		do
			-- Built-in
		end; -- infix "/"

	prefix "+": REAL is
			-- Unary addition applied to `Current'
		do
			-- Built-in
		end; -- prefix "+"

	prefix "-": REAL is
			-- Unary subtraction applied to `Current'
		do
			-- Built-in
		end; -- prefix 

end -- class REAL
