%{
indexing

	description: "Eiffel classname finders"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class CLASSNAME_FINDER

inherit

	CLASSNAME_FINDER_SKELETON

creation

	make

%}

%x IN_CLASS
%option nodefault outfile="classname_finder.e"

A		([a-z]|[A-Z])
X		([a-z]|[A-Z]|[0-9]|_)

%%

[cC][lL][aA][sS][sS]	{
				set_start_condition (IN_CLASS)
			}

<IN_CLASS>{A}{X}*		{
				classname := text
				last_token := TE_ID
			}

[^cC"'%\n-]*										-- Ignore

<*>{
	["%]([^"%\n]|%([^/\n\r]|("/"[0-9]+"/")))*["%]	-- Ignore
	\'([^'%\n]|%([^/\n]|("/"[0-9]+"/")))\'			-- Ignore
	"--".*											-- Ignore
	\n+												-- Ignore
	.												-- Ignore
}

%%

end -- class CLASSNAME_FINDER


--|----------------------------------------------------------------
--| Copyright (C) 1992-1999, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
