%{
indexing

	description: "Eiffel classname finders"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2001-08-12 16:50:20 -0700 (Sun, 12 Aug 2001) $"
	revision: "$Revision: 48753 $"

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

[pP][aA][rR][tT][iI][aA][lL][ \r\t\n]+[cC][lL][aA][sS][sS] {
				set_start_condition (IN_CLASS)
				set_partial_class (True)
			}
[cC][lL][aA][sS][sS]	{
				set_start_condition (IN_CLASS)
				set_partial_class (False)
			}

<IN_CLASS>{A}{X}*		{
				classname := text
					-- Class name has been found so we terminate parser
				terminate
			}

[^pPcC"\n-]*		-- Ignore
{A}{X}*			-- Ignore

<INITIAL,IN_CLASS>{
		-- Basic manifest string:
	\"([^"%\n]|%([^/\n\r\t ]|([ \t\r]*\n[ \t\r\n]*%)|("/"[0-9]+"/")))*\"	-- Ignore
		-- Verbatim string:
	\"[^\n"]*[\[\{]/[ \t\r]*\n {
				verbatim_marker.clear_all
				if text_item (text_count) = '[' then
					verbatim_marker.append_character (']')
				else
					verbatim_marker.append_character ('}')
				end
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
	[ \t\r]*[\]\}][^\n"]*\" {
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CLASSNAME_FINDER
