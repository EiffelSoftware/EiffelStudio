--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

expanded class BOOLEAN

inherit

	BOOLEAN_REF
		redefine
			infix "and",
			infix "and then",
			infix "implies",
			prefix "not",
			infix "or",
			infix "or else",
			infix "xor"
		end

feature -- Boolean

	infix "and" (other: BOOLEAN): BOOLEAN is
			-- Boolean conjunction of `Current' and `other'
		do
			-- Built-in
		end;

	infix "and then" (other: BOOLEAN): BOOLEAN is
			-- Boolean semi-strict conjunction of `Current' and `other'
		do
			-- Built-in
		end;

	infix "implies" (other: BOOLEAN): BOOLEAN is
			-- Boolean implication of `Current' and `other'
			-- (semi-strict)
		do
			-- Built-in
		end;

	prefix "not" : BOOLEAN is
			-- Negation of `Current'
		do
			-- Built-in
		end;

	infix "or" (other: BOOLEAN): BOOLEAN is
			-- Boolean disjunction of `Current' and `other'
		do
			-- Built-in
		end;

	infix "or else" (other: BOOLEAN): BOOLEAN is
			-- Boolean semi-strict disjunction of `Current' and `other'
		do
			-- Built-in
		end;

	infix "xor" (other: BOOLEAN): BOOLEAN is
			-- Boolean exclusive or of `Current' and `other'
		do
			-- Built-in
		end;

end -- class BOOLEAN
