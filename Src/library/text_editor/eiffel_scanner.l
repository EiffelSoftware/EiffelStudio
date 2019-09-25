%{
note

	description:

		"Scanners for Eiffel parsers"

	author:     "Eric Bezault <ericb@gobo.demon.co.uk>"
	copyright:  "Copyright (c) 1998, Eric Bezault"
	date:       "$Date$"
	revision:   "$Revision$"

	fixme: "there are still some problems with this scanner %
			%to be resolved. (especially with manifest strings). - Andreas Leitner"

class EIFFEL_SCANNER

inherit

	YY_FULL_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton,
			reset as reset_compressed_scanner_skeleton
		end

	EIFFEL_TOKENS
		export
			{NONE} all
		end

	UT_CHARACTER_CODES
		export
			{NONE} all
		end

	KL_IMPORTED_INTEGER_ROUTINES
	KL_IMPORTED_STRING_ROUTINES
	KL_SHARED_PLATFORM
	KL_SHARED_EXCEPTIONS
	KL_SHARED_ARGUMENTS

creation

	make, execute, benchmark
%}

%x IN_STR
%option nodefault outfile="eiffel_scanner.e" full nometa-ecs noecs

%%

----------/** Separators **/----------------------------------------------------

[ \t\r]+			move (text_count) -- Ignore separators
\n+				move (text_count); eif_lineno := eif_lineno + text_count


----------/** Eiffel comments **/-----------------------------------------------

"--".*				move (text_count); last_token := E_COMMENT -- Ignore comments
"--".*\n[ \t\r]*	move (text_count); last_token := E_COMMENT; eif_lineno := eif_lineno + 1


----------/** Eiffel symbols **/------------------------------------------------

"-"					move (text_count); last_token := Minus_code
"+"					move (text_count); last_token := Plus_code
"*"					move (text_count); last_token := Star_code
"/"					move (text_count); last_token := Slash_code
"^"					move (text_count); last_token := Caret_code
"="					move (text_count); last_token := Equal_code
">"					move (text_count); last_token := Greater_than_code
"<"					move (text_count); last_token := Less_than_code
"."					move (text_count); last_token := Dot_code
";"					move (text_count); last_token := Semicolon_code
","					move (text_count); last_token := Comma_code
":"					move (text_count); last_token := Colon_code
"!"					move (text_count); last_token := Exclamation_code
"("					move (text_count); last_token := Left_parenthesis_code
")"					move (text_count); last_token := Right_parenthesis_code
"{"					move (text_count); last_token := Left_brace_code
"}"					move (text_count); last_token := Right_brace_code
"["					move (text_count); last_token := Left_bracket_code
"]"					move (text_count); last_token := Right_bracket_code
"$"					move (text_count); last_token := Dollar_code
"//"				move (text_count); last_token := E_DIV
"\\\\"				move (text_count); last_token := E_MOD
"/="				move (text_count); last_token := E_NE
">="				move (text_count); last_token := E_GE
"<="				move (text_count); last_token := E_LE
"!!"				move (text_count); last_token := E_BANGBANG
"->"				move (text_count); last_token := E_ARROW
".."				move (text_count); last_token := E_DOTDOT
"<<"				move (text_count); last_token := E_LARRAY
">>"				move (text_count); last_token := E_RARRAY
":="				move (text_count); last_token := E_ASSIGN
"?="				move (text_count); last_token := E_REVERSE


----------/** Reserved words **/------------------------------------------------

[aA][lL][iI][aA][sS]					move (text_count); last_token := E_ALIAS 
[aA][lL][lL]							move (text_count); last_token := E_ALL
[aA][nN][dD]							last_token := E_AND;move (text_count)
[aA][sS]								last_token := E_AS;move (text_count)
[bB][iI][tT]							last_token := E_BITTYPE;move (text_count)
[cC][hH][eE][cC][kK]					last_token := E_CHECK;move (text_count)
[cC][lL][aA][sS][sS]					last_token := E_CLASS;move (text_count)
[cC][rR][eE][aA][tT][iI][oO][nN]		last_token := E_CREATION;move (text_count)
[cC][uU][rR][rR][eE][nN][tT]			last_token := E_CURRENT;move (text_count)
[dD][eE][bB][uU][gG]					last_token := E_DEBUG;move (text_count)
[dD][eE][fF][eE][rR][rR][eE][dD]		last_token := E_DEFERRED;move (text_count)
[dD][oO]								last_token := E_DO;move (text_count)
[eE][lL][sS][eE]						last_token := E_ELSE;move (text_count)
[eE][lL][sS][eE][iI][fF]				last_token := E_ELSEIF;move (text_count)
[eE][nN][dD]							last_token := E_END;move (text_count)
[eE][nN][sS][uU][rR][eE]				last_token := E_ENSURE;move (text_count)
[eE][xX][pP][aA][nN][dD][eE][dD]		last_token := E_EXPANDED;move (text_count)
[eE][xX][pP][oO][rR][tT]				last_token := E_EXPORT;move (text_count)
[eE][xX][tT][eE][rR][nN][aA][lL]		last_token := E_EXTERNAL;move (text_count)
[fF][aA][lL][sS][eE]					last_token := E_FALSE;move (text_count)
[fF][eE][aA][tT][uU][rR][eE]			last_token := E_FEATURE;move (text_count)
[fF][rR][oO][mM]						last_token := E_FROM;move (text_count)
[fF][rR][oO][zZ][eE][nN]				last_token := E_FROZEN;move (text_count)
[iI][fF]								last_token := E_IF;move (text_count)
[iI][mM][pP][lL][iI][eE][sS]			last_token := E_IMPLIES;move (text_count)
[iI][nN][dD][eE][xX][iI][nN][gG]		last_token := E_INDEXING;move (text_count)
[iI][nN][hH][eE][rR][iI][tT]			last_token := E_INHERIT;move (text_count)
[iI][nN][sS][pP][eE][cC][tT]			last_token := E_INSPECT;move (text_count)
[iI][nN][vV][aA][rR][iI][aA][nN][tT]	last_token := E_INVARIANT;move (text_count)
[iI][sS]								last_token := E_IS;move (text_count)
[lL][iI][kK][eE]						last_token := E_LIKE;move (text_count)
[lL][oO][cC][aA][lL]					last_token := E_LOCAL;move (text_count)
[lL][oO][oO][pP]						last_token := E_LOOP;move (text_count)
[nN][oO][tT]							last_token := E_NOT;move (text_count)
[oO][bB][sS][oO][lL][eE][tT][eE]		last_token := E_OBSOLETE;move (text_count)
[oO][lL][dD]							last_token := E_OLD;move (text_count)
[oO][nN][cC][eE]						last_token := E_ONCE;move (text_count)
[oO][rR]								last_token := E_OR;move (text_count)
[pP][rR][eE][cC][uU][rR][sS][oO][rR]	last_token := E_PRECURSOR;move (text_count)
[rR][eE][dD][eE][fF][iI][nN][eE]		last_token := E_REDEFINE;move (text_count)
[rR][eE][nN][aA][mM][eE]				last_token := E_RENAME;move (text_count)
[rR][eE][qQ][uU][iI][rR][eE]			last_token := E_REQUIRE;move (text_count)
[rR][eE][sS][cC][uU][eE]				last_token := E_RESCUE;move (text_count)
[rR][eE][sS][uU][lL][tT]				last_token := E_RESULT;move (text_count)
[rR][eE][tT][rR][yY]					last_token := E_RETRY;move (text_count)
[sS][eE][lL][eE][cC][tT]				last_token := E_SELECT;move (text_count)
[sS][eE][pP][aA][rR][aA][tT][eE]		last_token := E_SEPARATE;move (text_count)
[sS][tT][rR][iI][pP]					last_token := E_STRIP;move (text_count)
[tT][hH][eE][nN]						last_token := E_THEN;move (text_count)
[tT][rR][uU][eE]						last_token := E_TRUE;move (text_count)
[uU][nN][dD][eE][fF][iI][nN][eE]		last_token := E_UNDEFINE;move (text_count)
[uU][nN][iI][qQ][uU][eE]				last_token := E_UNIQUE;move (text_count)
[uU][nN][tT][iI][lL]					last_token := E_UNTIL;move (text_count)
[vV][aA][rR][iI][aA][nN][tT]			last_token := E_VARIANT;move (text_count)
[wW][hH][eE][nN]						last_token := E_WHEN;move (text_count)
[xX][oO][rR]							last_token := E_XOR;move (text_count)


----------/** Eiffel identifiers **/--------------------------------------------

[a-zA-Z][a-zA-Z0-9_]*	{
				last_token := E_IDENTIFIER
				last_value := text;move (text_count)
			}


----------/** Eiffel free operators **/-----------------------------------------

[@#|&][^%" \t\r\n]*	{
				last_token := E_FREEOP
				last_value := text;move (text_count)
			}

		-- Note: Accepts non-printable characters as well,
		-- provided that they are not break characters.


----------/** Eiffel characters **/---------------------------------------------

\'[^%\n']\'			last_token := E_CHARACTER; last_value := text_item (2);move (text_count)
	-- The following line is not correct Eiffel but
	-- it appears in some Halstenbach Eiffel libraries.
\'\'\'				last_token := E_CHARACTER; last_value := '%'';move (text_count)
\'%A\'				last_token := E_CHARACTER; last_value := '%A';move (text_count)
\'%B\'				last_token := E_CHARACTER; last_value := '%B';move (text_count)
\'%C\'				last_token := E_CHARACTER; last_value := '%C';move (text_count)
\'%D\'				last_token := E_CHARACTER; last_value := '%D';move (text_count)
\'%F\'				last_token := E_CHARACTER; last_value := '%F';move (text_count)
\'%H\'				last_token := E_CHARACTER; last_value := '%H';move (text_count)
\'%L\'				last_token := E_CHARACTER; last_value := '%L';move (text_count)
\'%N\'				last_token := E_CHARACTER; last_value := '%N';move (text_count)
\'%Q\'				last_token := E_CHARACTER; last_value := '%Q';move (text_count)
\'%R\'				last_token := E_CHARACTER; last_value := '%R';move (text_count)
\'%S\'				last_token := E_CHARACTER; last_value := '%S';move (text_count)
\'%T\'				last_token := E_CHARACTER; last_value := '%T';move (text_count)
\'%U\'				last_token := E_CHARACTER; last_value := '%U';move (text_count)
\'%V\'				last_token := E_CHARACTER; last_value := '%V';move (text_count)
\'%%\'				last_token := E_CHARACTER; last_value := '%%';move (text_count)
\'%\'\'				last_token := E_CHARACTER; last_value := '%'';move (text_count)
\'%\"\'				last_token := E_CHARACTER; last_value := '%"';move (text_count)
\'%\(\'				last_token := E_CHARACTER; last_value := '%(';move (text_count)
\'%\)\'				last_token := E_CHARACTER; last_value := '%)';move (text_count)
\'%<\'				last_token := E_CHARACTER; last_value := '%<';move (text_count)
\'%>\'				last_token := E_CHARACTER; last_value := '%>';move (text_count)
\'%\/[0-9]+\/\'		{
						code_ := text_substring (4, text_count - 2).to_integer
						if code_ > Platform.Maximum_character_code then
							last_token := E_CHARERR
						else
							last_token := E_CHARACTER
							last_value := INTEGER_.to_character (code_)
						end
						move (text_count)
					}
	-- The following line is not correct Eiffel but
	-- it appears in some Visual Eiffel libraries.
\'%.\'				last_token := E_CHARACTER; last_value := text_item (3);move (text_count)

\'.{1,2}			|
\'%\/[0-9]+(\/)?	last_token := E_CHARERR;move (text_count)	-- Catch-all rules (no backing up)


----------/** Eiffel strings **/------------------------------------------------

\"\+\"								last_token := process_operator (E_STRPLUS);move (text_count)
\"-\"								last_token := process_operator (E_STRMINUS);move (text_count)
\"\*\"								last_token := process_operator (E_STRSTAR);move (text_count)
\"\/\"								last_token := process_operator (E_STRSLASH);move (text_count)
\"\/\/\"							last_token := process_operator (E_STRDIV);move (text_count)
\"\\\\\"							last_token := process_operator (E_STRMOD);move (text_count)
\"^\"								last_token := process_operator (E_STRPOWER);move (text_count)
\"<\"								last_token := process_operator (E_STRLT);move (text_count)
\"<=\"								last_token := process_operator (E_STRLE);move (text_count)
\">\"								last_token := process_operator (E_STRGT);move (text_count)
\">=\"								last_token := process_operator (E_STRGE);move (text_count)
\"[nN][oO][tT]\"					last_token := process_operator (E_STRNOT);move (text_count)
\"[aA][nN][dD]\"					last_token := process_operator (E_STRAND);move (text_count)
\"[oO][rR]\"						last_token := process_operator (E_STROR);move (text_count)
\"[xX][oO][rR]\"					last_token := process_operator (E_STRXOR);move (text_count)
\"[aA][nN][dD]\ [tT][hH][eE][nN]\"	last_token := process_operator (E_STRANDTHEN);move (text_count)
\"[oO][rR]\ [eE][lL][sS][eE]\"		last_token := process_operator (E_STRORELSE);move (text_count)
\"[iI][mM][pP][lL][iI][eE][sS]\"	last_token := process_operator (E_STRIMPLIES);move (text_count)
\"[@#|&][^%" \t\r\n]*\"		{
			if is_operator then
				is_operator := False
				last_token := E_STRFREEOP
			else
				last_token := E_STRING
			end
			last_value := text_substring (2, text_count - 1);move (text_count)
		}
\"[^%\n"]*\" {
				last_token := E_STRING
				last_value := text_substring (2, text_count - 1);move (text_count)
			}
\"[^%\n"]*	{
				if text_count > 1 then
					eif_buffer.append_string (text_substring (2, text_count))
				end
				set_start_condition (IN_STR);move (text_count)
			}
<IN_STR>[^%\n"]+	eif_buffer.append_string (text);move (text_count)
<IN_STR>%A			eif_buffer.append_character ('%A');move (text_count)
<IN_STR>%B			eif_buffer.append_character ('%B');move (text_count)
<IN_STR>%C			eif_buffer.append_character ('%C');move (text_count)
<IN_STR>%D			eif_buffer.append_character ('%D');move (text_count)
<IN_STR>%F			eif_buffer.append_character ('%F');move (text_count)
<IN_STR>%H			eif_buffer.append_character ('%H');move (text_count)
<IN_STR>%L			eif_buffer.append_character ('%L');move (text_count)
<IN_STR>%N			eif_buffer.append_character ('%N');move (text_count)
<IN_STR>%Q			eif_buffer.append_character ('%Q');move (text_count)
<IN_STR>%R			eif_buffer.append_character ('%R');move (text_count)
<IN_STR>%S			eif_buffer.append_character ('%S');move (text_count)
<IN_STR>%T			eif_buffer.append_character ('%T');move (text_count)
<IN_STR>%U			eif_buffer.append_character ('%U');move (text_count)
<IN_STR>%V			eif_buffer.append_character ('%V');move (text_count)
<IN_STR>%%			eif_buffer.append_character ('%%');move (text_count)
<IN_STR>%\'			eif_buffer.append_character ('%'');move (text_count)
<IN_STR>%\"			eif_buffer.append_character ('%"');move (text_count)
<IN_STR>%\(			eif_buffer.append_character ('%(');move (text_count)
<IN_STR>%\)			eif_buffer.append_character ('%)');move (text_count)
<IN_STR>%<			eif_buffer.append_character ('%<');move (text_count)
<IN_STR>%>			eif_buffer.append_character ('%>');move (text_count)
<IN_STR>%\/[0-9]+\/	{
			code_ := text_substring (3, text_count - 1).to_integer
			if (code_ > Platform.Maximum_character_code) then
				last_token := E_STRERR
				set_start_condition (INITIAL)
			else
				eif_buffer.append_character (INTEGER_.to_character (code_))
			end;move (text_count)
		}
-- The following line should be:
--		<IN_STR>%\n[ \t\r]*%	eif_lineno := eif_lineno + 1;move (text_count)
-- but some Eiffel classes in Halstenbach libraries
-- have a space after the % character!
<IN_STR>%[ \t\r]*\n[ \t\r]*%	eif_lineno := eif_lineno + 1;move (text_count)
<IN_STR>[^%\n"]*\"		{
			last_token := E_STRING
			if text_count > 1 then
				eif_buffer.append_string (text_substring (1, text_count - 1))
			end
			str_ := STRING_.make (eif_buffer.count)
			str_.append_string (eif_buffer)
			eif_buffer.wipe_out
			last_value := str_
			set_start_condition (INITIAL);move (text_count)
		}
	-- The following line is not correct Eiffel
	-- but is used in Visual Eiffel.
<IN_STR>%.			eif_buffer.append_character (text_item (2));move (text_count)

<IN_STR>.|\n				|
<IN_STR>%[ \t\r]*\n[ \t\r]*	|
<IN_STR>%\/([0-9]+(\/)?)?	|
<IN_STR><<EOF>>			{	-- Catch-all rules (no backing up)
							last_token := E_STRERR
							set_start_condition (INITIAL);move (text_count)
						}


----------/** Eiffel bits **/---------------------------------------------------

[0-1]+[bB]			last_token := E_BIT; last_value := text;move (text_count)


----------/** Eiffel integers **/-----------------------------------------------

[0-9]+				{
						last_token := E_INTEGER
						last_value := text.to_integer;move (text_count)
					}
[0-9]{1,3}(_[0-9]{3})+	{
						last_token := E_INTEGER
						str_ := text
						nb_ := text_count
						from i_ := 1 until i_ > nb_ loop
							char_ := str_.item (i_)
							if char_ /= '_' then
								eif_buffer.append_character (char_)
							end 
							i_ := i_ + 1
						end
						last_value := eif_buffer.to_integer
						eif_buffer.wipe_out;move (text_count)
					}
[0-9_]+				last_token := E_INTERR	;move (text_count)-- Catch-all rule (no backing up)


---------/** Eiffel reals **/---------------------------------------------------

[0-9]+\./[^.0-9]					|
[0-9]+\.[0-9]*[eE][+-]?[0-9]+		|
[0-9]*\.[0-9]+([eE][+-]?[0-9]+)?	{
						last_token := E_REAL
						last_value := text.to_double;move (text_count)
					}
[0-9]{1,3}(_[0-9]{3})+\./[^.0-9]	|
[0-9]{1,3}(_[0-9]{3})*\.([0-9]{1,3}(_[0-9]{3})*)?[eE][+-]?[0-9]{1,3}(_[0-9]{3})*	|
([0-9]{1,3}(_[0-9]{3})*)?\.[0-9]{1,3}(_[0-9]{3})*([eE][+-]?[0-9]{1,3}(_[0-9]{3})*)?	{
						last_token := E_REAL
						str_ := text
						nb_ := text_count
						from i_ := 1 until i_ > nb_ loop
							char_ := str_.item (i_)
							if char_ /= '_' then
								eif_buffer.append_character (char_)
							end
							i_ := i_ + 1
						end
						last_value := eif_buffer.to_double
						eif_buffer.wipe_out;move (text_count)
					}

		-- The first and fourth expressions use a trailing context
		-- to make sure that an integer followed by two dots is
		-- not recognized as a real followed by a dot.

--------------------------------------------------------------------------------

<<EOF>>			terminate
.				last_token := text_item (1).code;move (text_count)

--------------------------------------------------------------------------------
%%

feature {NONE} -- Local variables

	i_, nb_: INTEGER
	char_: CHARACTER
	str_: STRING
	code_: INTEGER

feature {NONE} -- Initialization

	make is
			-- Create a new Eiffel scanner.
		do
			make_with_buffer (Empty_buffer)
			eif_buffer := STRING_.make (Init_buffer_size)
			eif_lineno := 1
		end

	execute is
			-- Analyze Eiffel files `arguments (1..argument_count)'.
		local
			j, n: INTEGER
			a_filename: STRING
			a_file: like INPUT_STREAM_TYPE
		do
			make
			n := Arguments.argument_count
			if n = 0 then
				std.error.put_string ("usage: eiffel_scanner filename ...%N")
				Exceptions.die (1)
			else
				from j := 1 until j > n loop
					a_filename := Arguments.argument (j)
					a_file := INPUT_STREAM_.make_file_open_read (a_filename)
					if INPUT_STREAM_.is_open_read (a_file) then
						set_input_buffer (new_file_buffer (a_file))
						scan
						INPUT_STREAM_.close (a_file)
					else
						std.error.put_string ("eiffel_scanner: cannot read %'")
						std.error.put_string (a_filename)
						std.error.put_string ("%'%N")
					end
					j := j + 1
				end
			end
		end

	benchmark is
			-- Analyze Eiffel file `argument (2)' `argument (1)' times.
		local
			j, n: INTEGER
			a_filename: STRING
			a_file: like INPUT_STREAM_TYPE
		do
			make
			if
				Arguments.argument_count < 2 or else
				not STRING_.is_integer (Arguments.argument (1))
			then
				std.error.put_string ("usage: eiffel_scanner nb filename%N")
				Exceptions.die (1)
			else
				n := Arguments.argument (1).to_integer
				a_filename := Arguments.argument (2)
				from j := 1 until j > n loop
					a_file := INPUT_STREAM_.make_file_open_read (a_filename)
					if INPUT_STREAM_.is_open_read (a_file) then
						set_input_buffer (new_file_buffer (a_file))
						scan
						INPUT_STREAM_.close (a_file)
					else
						std.error.put_string ("eiffel_scanner: cannot read %'")
						std.error.put_string (a_filename)
						std.error.put_string ("%'%N")
						Exceptions.die (1)
					end
					j := j + 1
				end
			end
		end
		
	scan_string (a_text: STRING) is
		require
			a_text /= Void
		do
			reset
			set_input_buffer (new_string_buffer (a_text))

			from
				read_token
			until
				last_token <= 0
			loop
				on_token_found
				read_token
			end
			
		end

	on_token_found is
		require
--			consistent_positions: token_first_pos <= token_last_pos
		do
			print ("found a token%N")
		end
feature -- Initialization

	reset is
			-- Reset scanner before scanning next input.
		do
			reset_compressed_scanner_skeleton
			eif_lineno := 1
			eif_buffer.wipe_out
			eif_position := 1
		end

feature -- Access

	eif_position: INTEGER
	
	token_first_pos: INTEGER is
		do
				--| Because of an error in the analyzer we need to check
				--| the size of text_count for validity
			if text_count = 0 then
				Result := token_last_pos
			else
				Result := token_last_pos - text_count + 1
			end
		end

	token_last_pos: INTEGER is
		do
				--| Because of an error in the analyzer we need to assure `Result'
				--| will be ok.
			Result := (1).max (eif_position - 1)
		ensure
			valid_result: Result >= 1
		end
	
	last_value: ANY
			-- Semantic value to be passed to the parser

	eif_buffer: STRING
			-- Buffer for lexial tokens

	eif_lineno: INTEGER
			-- Current line number

	is_operator: BOOLEAN
			-- Parsing an operator declaration?

feature {NONE} -- Processing

	move (i: INTEGER) is
		do
			eif_position := eif_position + i
		end
		
	process_operator (op: INTEGER): INTEGER is
			-- Process current token as operator `op' or as
			-- an Eiffel string depending on the context
		require
			text_count_large_enough: text_count > 2
		do
			if is_operator then
				is_operator := False
				Result := op
			else
				Result := E_STRING
				last_value := text_substring (2, text_count - 1)
			end
		end

feature {NONE} -- Constants

	Init_buffer_size: INTEGER is 256
				-- Initial size for `eif_buffer'

invariant

	eif_buffer_not_void: eif_buffer /= Void
	
	
end -- class EIFFEL_SCANNER
