--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

expanded class INTEGER

inherit

	INTEGER_REF
		redefine
			infix "<",
			infix "+",
			infix "-",
			infix "*",
			infix "/",
			prefix "+",
			prefix "-",
			infix "//",
			infix "\\"
		end

feature	-- Comparison

	infix "<" (other: INTEGER): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			-- Built-in
		end;

feature -- Numeric

	infix "+" (other: INTEGER): INTEGER is
			-- Sum of `Current' and `other'
		do
			-- Built-in
		end;

	infix "-" (other: INTEGER): INTEGER is
			-- Difference between `Current' and `other'
		do
			-- Built-in
		end;

	infix "*" (other: INTEGER): INTEGER is
			-- Product of `Current' by `other'
		do
			-- Built-in
		end;

	infix "/" (other: INTEGER): INTEGER is
			-- Division of `Current' by `other'
		do
			-- Built-in
		end;

	prefix "+": INTEGER is
			-- Unary addition applied to `Current'
		do
			-- Built-in
		end;

	prefix "-": INTEGER is
			-- Unary subtraction applied to `Current'
		do
			-- Built-in
		end; 

feature	-- Div, mod

	infix "//" (other: INTEGER): INTEGER is
			-- Integer division of Current by `other'
		do
			-- Built-in
		end;

	infix "\\" (other: INTEGER): INTEGER is
			-- Remainder of the integer division of Current by `other'
		do
			-- Built-in
		end;

end -- class INTEGER
