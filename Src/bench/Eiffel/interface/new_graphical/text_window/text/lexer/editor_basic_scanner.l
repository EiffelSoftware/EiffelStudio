%{
indexing
	description:"Basic texts scanners for TEXT_PANEL"
	author:     "Etienne Amodeo"
	date:       "$Date$"
	revision:   "$Revision$"

class EDITOR_BASIC_SCANNER

inherit

	EDITOR_SCANNER

create
	make
%}

%option outfile="editor_basic_scanner.e"

%%

----------/** Separators **/----------------------------------------------------

[\r]+				-- Ignore carriage return
[ ]+				{
					create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
					update_token_list
					}
[\t]+				{
					create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count, tab_size_cell)
					update_token_list
					}
\n+				{
					from i_ := 1 until i_ > text_count loop
						create {EDITOR_TOKEN_EOL} curr_token.make
						update_token_list
						i_ := i_ + 1
					end
					}
[^\n\t\r ]+			{
					create {EDITOR_TOKEN_TEXT} curr_token.make(text, tab_size_cell)
					update_token_list
					}



--------------------------------------------------------------------------------

<<EOF>>			terminate

--------------------------------------------------------------------------------
%%

end -- class EDITOR_BASIC_SCANNER
