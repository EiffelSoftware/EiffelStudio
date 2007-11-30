%{
indexing

	description: "Scanners for Eiffel comment"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$date$"
	revision: "$Revision$"

class COMMENT_SCANNER

inherit
	COMMENT_SCANNER_SKELETON

create
	make_with_text_formatter

%}
%x DOT_FEATURE
%x NOT_BREAK_TOKEN
%x BREAK_TOKEN
%option nodefault

D		[0-9]
H		[0-9a-zA-Z]
A		[a-zA-Z]
X		[a-zA-Z0-9_]
C		([^ \t\r\n])
CM		([^ \t\r\n\.])
CS		([^ \t\r\n\.\{\}\[\]`\'])
EMAIL	{A}{CM}*{H}@{H}{CM}*(\.{CM}+)*
URL		(((https?|ftp|file|gopher|news|nntp|telnet):\/\/)|(www\.))[a-zA-Z0-9_%;&=?\/.#$:~-]*
FEATURE	(`[^`']+?\')
CLASS	\{{A}{X}*\}
CLUSTER \[{C}+\]

%%
.|\n		{
				if seperate_comment then
					set_start_condition (BREAK_TOKEN)
				else
					set_start_condition (NOT_BREAK_TOKEN)
				end
				less (0)
			}
<<EOF>>		{
				append_buffer
				terminate
			}

<NOT_BREAK_TOKEN>{
-- Email
{EMAIL}		{
				append_buffer
				add_email_tokens
			}

-- URL
{URL}		{	
				append_buffer
				add_url_tokens				
			}

-- Quoted feature
{FEATURE}	{
				append_buffer
				add_quote_feature
			}

-- Braced class with feature followed
{CLASS}\.{CS}		{
				append_buffer
				add_class (True)
				last_condition := NOT_BREAK_TOKEN
				set_start_condition (DOT_FEATURE)
				less (text_count - 2)
			}
-- Braced class
{CLASS}		{
				append_buffer
				add_class (False)
			}

-- Cluster
{CLUSTER}	{
				append_buffer
				add_cluster
			}

\n			{
				append_buffer
				text_formatter.process_new_line
			}

.			{
				buffer_token
			}
}

<BREAK_TOKEN>{
-- Email
{EMAIL}		{
				add_email_tokens
			}

-- URL
{URL}		{				
				add_url_tokens				
			}

-- Quoted feature
{FEATURE}	{
				add_quote_feature
			}

-- Braced class with feature followed.
{CLASS}\.{CS}	{
				add_class (True)
				last_condition := BREAK_TOKEN
				set_start_condition (DOT_FEATURE)
				less (text_count - 2)
			}

-- Braced class
{CLASS}		{
				add_class (False)
			}

-- Cluster
{CLUSTER}	{
				add_cluster
			}

\n			{
				text_formatter.process_new_line
			}

-- Word
{CS}+|[`~!@#$%^&*()_+-={}[]:;\'\"\|\\<>\?,\.\/]+		{
				add_normal_text
			}

\r			{
			}

[ \t]+		{
				add_normal_text
			}

-- End			
.			{
				add_normal_text	
			}
}

<DOT_FEATURE>{
\.{A}{X}*	{
				add_dot_feature
			}
.|\n		{
				less (0)
				set_start_condition (last_condition)
				reset_last_type
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

end -- class COMMENT_SCANNER
