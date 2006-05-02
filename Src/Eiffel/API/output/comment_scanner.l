%{
indexing

	description: "Scanners for Eiffel comment"
	status: "See notice at end of class"
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
H		([0-9]|[A-F]|[a-f])
A		([a-z]|[A-Z])
X		([a-z]|[A-Z]|[0-9]|_)
C		([^ \t\r\n])
CM		([^ \t\r\n\.])
CS		([^ \t\r\n\.\{\}\[\]`\'])
S		(\{[A-Z]([A-Z]|_|{D})*\})
EMAIL	{A}{CM}*{H}@{H}{CM}*(\.{CM}+)*
URL		((www\.)|(https{0,1}:\/\/)|(ftp:\/\/)|(file:\/\/)){C}*
FEATURE	`{C}+\'
CLASS	\{[A-Z]([A-Z]|{D}|_)*\}
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

-- Braced class
{CLASS}		{
				append_buffer
				add_class
				last_condition := NOT_BREAK_TOKEN
				set_start_condition (DOT_FEATURE)
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

-- Braced class
{CLASS}	{
				add_class
				last_condition := BREAK_TOKEN
				set_start_condition (DOT_FEATURE)
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

end -- class COMMENT_SCANNER
