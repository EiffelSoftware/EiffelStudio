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
D		[0-9]
H		([0-9]|[A-F]|[a-f])
A		([a-z]|[A-Z])
X		([a-z]|[A-Z]|[0-9]|_)
C		([^ \t\r\n])
CS		([^ \t\r\n\.])
S		(\{[A-Z]([A-Z]|_|{D})*\})


%%

-- Email
{A}{CS}*{H}@{H}{CS}*(\.{CS}+)*	{
				add_email_tokens
				reset_last_type
			}

-- URL
((www\.)|(https{0,1}:\/\/)|(ftp:\/\/)|(file:\/\/)){C}*		{				
				add_url_tokens
				reset_last_type				
			}

-- Quoted feature
`{C}+\'		{
				add_quote_feature
			}

-- Braced class
\{[A-Z]([A-Z]|{D}|_)*\}	{
				add_class
				set_start_condition (DOT_FEATURE)
			}

-- Cluster
\[{C}+\]		{
				add_cluster
				reset_last_type
			}

-- M
{CS}+		{
				add_text (text)
				reset_last_type
			}

\n			{
				text_formatter.process_new_line
				reset_last_type
			}

\r			{
				reset_last_type
			}

[ \t]+		{
				add_text (text)
				reset_last_type
			}			

<DOT_FEATURE>
{
\.{A}{X}*	{
				add_dot_feature
			}

[ \n\t\r]	{
				set_start_condition (INITIAL)
				reset_last_type
			}

<<EOF>>		{
				set_start_condition (INITIAL)
			}
}

-- End
<<EOF>>		{
				terminate
			}
			
.			{
				add_text (text)
				reset_last_type	
			}
						
%%

end -- class COMMENT_SCANNER
