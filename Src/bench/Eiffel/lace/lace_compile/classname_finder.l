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

%x IN_CLASS VERBATIM_STR1 VERBATIM_STR2 VERBATIM_STR3
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

[^cC"\n-]*		-- Ignore
{A}{X}*			-- Ignore

<INITIAL,IN_CLASS>{
		-- Basic manifest string:
	\"([^"%\n]|%([^/\n\r\t ]|([ \t\r]*\n[ \t\r\n]*%)|("/"[0-9]+"/")))*\"	-- Ignore
		-- Verbatim string:
	\"[^\n"%]*\[/[ \t\r]*\n {
				verbatim_marker.clear_all
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				last_start_condition := start_condition
				set_start_condition (VERBATIM_STR3)
			}
		-- Comment:
	"--".*		-- Ignore
	\n+			-- Ignore
	.			-- Ignore
}
<VERBATIM_STR3>{
		-- Discard space characters at the
		-- end of Verbatim_string_opener.
	[ \t\r]*\n {
				set_start_condition (VERBATIM_STR1)
			}
	.		{
					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			}
	<<EOF>>	{
					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			}
}
<VERBATIM_STR1>{
		-- Read one line of a verbatim string body
		-- from the beginning of line.
	[ \t\r]*\][^%\n"]*\" {
				if is_verbatim_string_closer then
					set_start_condition (last_start_condition)
				else
					set_start_condition (VERBATIM_STR2)
				end
			}
	[^"\n]*\" {
				set_start_condition (VERBATIM_STR2)
			}
	[^"\n]*\n {
				-- Ignore.
			}
	[^"\n]* {
					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			}
	<<EOF>>	{
					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			}
}
<VERBATIM_STR2>{
		-- Read remaining characters of a line
		-- in verbatim string body.
	.*\n	{
				set_start_condition (VERBATIM_STR1)
			}
	.*		{
					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			}
	<<EOF>>	{
					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			}
}

%%

end -- class CLASSNAME_FINDER


--|----------------------------------------------------------------
--| Copyright (C) 1992-2000, Interactive Software Engineering Inc.
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
