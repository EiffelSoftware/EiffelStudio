%{
note
	description: "Scan C header file for type definitions"
	status: "See notice at end of class"
	author: "Based on http://www.lysator.liu.se/c"
	date: "$Date: 2006/05/30 13:22:26 $"
	revision: "$Revision: 1.9 $"
	info: "Based on: http://www.lysator.liu.se/c"

deferred class EWG_C_SCANNER

inherit

	EWG_C_SCANNER_SKELETON

%}
%option line position
%x SC_FILE
%x SC_IMPL
%x SC_MSC_DECLSPEC
%x SC_GCC_ATTRIBUTE


D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
E			[Ee][+-]?{D}+
FS			(f|F|l|L)
IS			(u|U|l|L)*

WS    [ \r\f\v\t\n]
WS_NON_NEWLINE    [ \t]
NL    [\r\n

%%

^{WS_NON_NEWLINE}*#.*			{
				set_start_condition (SC_FILE)
				less (0)
			}
-- NOTE:big evil line directive hack
-- i am not exporting the results to the parser
-- since it would complicate the grammar to much
-- instead the last line number and header file name
-- are added as state to the lexer (`set_header_file_name' and `set_header_line_number')
-- it currently supports line directives from 'GNU CPP', 'Visual C++' and 'lcc'

<SC_FILE>{WS_NON_NEWLINE}*#{WS}+[0-9]+{WS}+\" { -- GNU CPP style
				set_header_line_number ((text_substring (3, text_count - 2)).to_integer)
				}
<SC_FILE>{WS_NON_NEWLINE}*#line{WS}+[0-9]+{WS}+\" {  -- Visual C++ style
				if (text_substring (7, text_count - 2)).is_integer then
					set_header_line_number ((text_substring (7, text_count - 2)).to_integer)
				elseif (text_substring (11, text_count - 2)).is_integer then
					set_header_line_number ((text_substring (11, text_count - 2)).to_integer)
				else
					set_header_line_number ((text_substring (15, text_count - 2)).to_integer)
				end			
			}
<SC_FILE>{WS_NON_NEWLINE}*(_+|#)pragma.*\n   {  set_start_condition (INITIAL) } -- eat pragmas
<SC_FILE>[^"\n]+       { set_header_file_name (text) }
<SC_FILE>\"{WS_NON_NEWLINE}?.*\n    {set_start_condition (INITIAL) } -- eat misc stuff


<SC_IMPL>("{"|"<%")		{
					implementation_bracket_counter := implementation_bracket_counter + 1
				}
<SC_IMPL>("}"|"%>")		{
					implementation_bracket_counter := implementation_bracket_counter - 1
					if implementation_bracket_counter = 0 then
						last_token := Right_brace_code
						last_string_value := text
					end
				}

<SC_IMPL>L?\"(\\.|[^\\"])*\"	{ } -- eat

<SC_IMPL>[^{}]	{ } -- eat
				-- TODO: "%>" and "<%" must also not be eaten!

"__declspec"			{
					check
						msc_declspec_bracket_counter_is_zero: msc_declspec_bracket_counter = 0
					end
					if is_msc_extensions_enabled then
						-- grammar for "__declspec" construct is ambiguos.
						-- we don't need this information -> we ignore it
						-- (now we need to the "(dllimport)" part too)
						set_start_condition (SC_MSC_DECLSPEC)
					else
						report_type_or_identifier (text)
					end
				}
<SC_MSC_DECLSPEC>"("	{
				msc_declspec_bracket_counter := msc_declspec_bracket_counter + 1
			}
<SC_MSC_DECLSPEC>")"	{
					msc_declspec_bracket_counter := msc_declspec_bracket_counter - 1
					if msc_declspec_bracket_counter = 0 then
						set_start_condition (INITIAL)
					end
			}
<SC_MSC_DECLSPEC>.	{} -- eat

-- "/*"			{ comment(); }
-- NOTE: assume document contains no comments,

"auto"			{ last_token := TOK_AUTO; last_string_value := text}
"break"			{ last_token := TOK_BREAK; last_string_value := text }
"case"			{ last_token := TOK_CASE; last_string_value := text }
"char"			{ last_token := TOK_CHAR; last_string_value := text }
"const"			{ last_token := TOK_CONST; last_string_value := text }
"continue"		{ last_token := TOK_CONTINUE; last_string_value := text }
"default"		{ last_token := TOK_DEFAULT; last_string_value := text }
"do"			{ last_token := TOK_DO; last_string_value := text }
"double"		{ last_token := TOK_DOUBLE; last_string_value := text }
"else"			{ last_token := TOK_ELSE; last_string_value := text }
"enum"			{ last_token := TOK_ENUM; last_string_value := text }
"extern"		{ last_token := TOK_EXTERN; last_string_value := text }
"float"			{ last_token := TOK_FLOAT; last_string_value := text }
"for"			{ last_token := TOK_FOR; last_string_value := text }
"goto"			{ last_token := TOK_GOTO; last_string_value := text }
"if"			{ last_token := TOK_IF; last_string_value := text }
"int"			{ last_token := TOK_INT; last_string_value := text }
"bool"			{ last_token := TOK_INT; last_string_value := text }
"_Bool"			{ last_token := TOK_INT; last_string_value := text } -- TODO: introduce proper bool type
"long"			{ last_token := TOK_LONG; last_string_value := text }
"register"		{ last_token := TOK_REGISTER; last_string_value := text }
"return"		{ last_token := TOK_RETURN; last_string_value := text }
"short"			{ last_token := TOK_SHORT; last_string_value := text }
"signed"		{ last_token := TOK_SIGNED; last_string_value := text }
"sizeof"		{ last_token := TOK_SIZEOF; last_string_value := text }
"static"		{ last_token := TOK_STATIC; last_string_value := text }
"inline"		{ last_token := TOK_INLINE; last_string_value := text } -- added to original lexer
"struct"		{ last_token := TOK_STRUCT; last_string_value := text }
"switch"		{ last_token := TOK_SWITCH; last_string_value := text }
"typedef"		{ last_token := TOK_TYPEDEF; last_string_value := text }
"union"			{ last_token := TOK_UNION; last_string_value := text }
"unsigned"		{ last_token := TOK_UNSIGNED; last_string_value := text }
"void"			{ last_token := TOK_VOID; last_string_value := text }
"volatile"		{ last_token := TOK_VOLATILE; last_string_value := text }
"while"			{ last_token := TOK_WHILE; last_string_value := text }
"__signed__"		{
				-- gcc extension
				last_token := TOK_SIGNED; last_string_value := text 			   }
"__signed"		{
				-- gcc extension MacOs
				last_token := TOK_SIGNED; last_string_value := text 			   }




"__extension__" { } -- eat, has no effect other than
					-- telling gcc to not emit warnings for a construct

"__const"		{ last_token := TOK_CONST; last_string_value := text }
"__restrict"	{ }	-- eat, shoudn't bother us anyway

"__attribute__" {
				 -- eat, hopefully this thing is not usefull for us
					gcc_attribute_bracket_counter := 0
					set_start_condition (SC_GCC_ATTRIBUTE)
				}

<SC_GCC_ATTRIBUTE>"(" {
				gcc_attribute_bracket_counter := gcc_attribute_bracket_counter + 1
			 } -- eat
<SC_GCC_ATTRIBUTE>")" {
				gcc_attribute_bracket_counter := gcc_attribute_bracket_counter - 1
				if gcc_attribute_bracket_counter = 0 then
					set_start_condition (INITIAL)
				end
			 }
<SC_GCC_ATTRIBUTE>.	{} -- eat

"__inline"			{} -- eat (gcc and msc)

"__inline__"      {} -- eat (gcc)

-- NOTE: The following tokens are VC extensions
"__int8"			{
					if is_msc_extensions_enabled then
						last_token := TOK_CL_INT_8
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				}
"__int16"			{
					if is_msc_extensions_enabled then
						last_token := TOK_CL_INT_16
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				}
"__int32"			{
					if is_msc_extensions_enabled then
						last_token := TOK_CL_INT_32
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				}
"__int64"			{
					if is_msc_extensions_enabled then
						last_token := TOK_CL_INT_64
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				}
"__ptr32"		{
					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
				}				
"__ptr64"			{
					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
				}
"__fastcall"			{
					if is_msc_extensions_enabled then
						last_token := TOK_CL_FASTCALL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				}
"__based"			{
					if is_msc_extensions_enabled then
						-- last_token := TOK_CL_BASED
						-- last_string_value := text
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
				}
"__asm"				{
					if is_msc_extensions_enabled then
						last_token := TOK_CL_ASM
						last_string_value := text
					else
						-- This is a gcc extension, we ignore it
						gcc_attribute_bracket_counter := 0
						set_start_condition (SC_GCC_ATTRIBUTE)
					end
				}
"__asm__"			{
					if is_msc_extensions_enabled then
						-- ignore, we don't need it, it's a gcc extension
					else
						-- This is a gcc extension, we ignore it
						gcc_attribute_bracket_counter := 0
						set_start_condition (SC_GCC_ATTRIBUTE)
					end
				}
"_asm"				{
					if is_msc_extensions_enabled then
						last_token := TOK_CL_ASM
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				}
"_inline"			{
					if is_msc_extensions_enabled then
						-- last_token := TOK_CL_INLINE
						-- last_string_value := text
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
				}
"__cdecl"			{
					if is_msc_extensions_enabled then
						last_token := TOK_CL_CDECL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				}
"_cdecl"			{
					if is_msc_extensions_enabled then
						last_token := TOK_CL_CDECL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				}
"__stdcall"			{
					if is_msc_extensions_enabled then
						last_token := TOK_CL_STDCALL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				}
"_stdcall"			{
					if is_msc_extensions_enabled then
						last_token := TOK_CL_STDCALL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
					}
"_forceinline"			{
					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
					}
"__forceinline"			{
					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
					}
"__unaligned"			{
					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
					}

"__w64"			{ } -- ignore


{L}({L}|{D})*		{ report_type_or_identifier (text)	}

0[xX]{H}+{IS}?		{ last_token := TOK_CONSTANT; last_string_value := text }
0{D}+{IS}?		{ last_token := TOK_CONSTANT; last_string_value := text }
{D}+{IS}?		{ last_token := TOK_CONSTANT; last_string_value := text }
L?'(\\.|[^\\'])+'	{ last_token := TOK_CONSTANT; last_string_value := text }

{D}+{E}{FS}?		{ last_token := TOK_CONSTANT; last_string_value := text }
{D}*"."{D}+({E})?{FS}?	{ last_token := TOK_CONSTANT; last_string_value := text }
{D}+"."{D}*({E})?{FS}?	{ last_token := TOK_CONSTANT; last_string_value := text }

L?\"(\\.|[^\\"])*\"	{ last_token := TOK_STRING_LITERAL; last_string_value := text }

"..."			{ last_token := TOK_ELLIPSIS; last_string_value := text }
">>="			{ last_token := TOK_RIGHT_ASSIGN; last_string_value := text }
"<<="			{ last_token := TOK_LEFT_ASSIGN; last_string_value := text }
"+="			{ last_token := TOK_ADD_ASSIGN; last_string_value := text }
"-="			{ last_token := TOK_SUB_ASSIGN; last_string_value := text }
"*="			{ last_token := TOK_MUL_ASSIGN; last_string_value := text }
"/="			{ last_token := TOK_DIV_ASSIGN; last_string_value := text }
"%="			{ last_token := TOK_MOD_ASSIGN; last_string_value := text }
"&="			{ last_token := TOK_AND_ASSIGN; last_string_value := text }
"^="			{ last_token := TOK_XOR_ASSIGN; last_string_value := text }
"|="			{ last_token := TOK_OR_ASSIGN; last_string_value := text }
">>"			{ last_token := TOK_RIGHT_OP; last_string_value := text }
"<<"			{ last_token := TOK_LEFT_OP; last_string_value := text }
"++"			{ last_token := TOK_INC_OP; last_string_value := text }
"--"			{ last_token := TOK_DEC_OP; last_string_value := text }
"->"			{ last_token := TOK_PTR_OP; last_string_value := text }
"&&"			{ last_token := TOK_AND_OP; last_string_value := text }
"||"			{ last_token := TOK_OR_OP; last_string_value := text }
"<="			{ last_token := TOK_LE_OP; last_string_value := text }
">="			{ last_token := TOK_GE_OP; last_string_value := text }
"=="			{ last_token := TOK_EQ_OP; last_string_value := text }
"!="			{ last_token := TOK_NE_OP; last_string_value := text }

";"				{ last_token := Semicolon_code; last_string_value := text}
("{"|"<%")		{ last_token := Left_brace_code; last_string_value := text }
("}"|"%>")		{ last_token := Right_brace_code; last_string_value := text }
","				{ last_token := Comma_code; last_string_value := text }
":"				{ last_token := Colon_code; last_string_value := text }
"="				{ last_token := Equal_code; last_string_value := text }
"("				{ last_token := Left_parenthesis_code; last_string_value := text }
")"				{ last_token := Right_parenthesis_code; last_string_value := text }
("["|"<:")		{ last_token := Left_bracket_code; last_string_value := text }
("]"|":>")		{ last_token := Right_bracket_code; last_string_value := text }
"."				{ last_token := Dot_code; last_string_value := text }
"&"				{ last_token := 38; last_string_value := text } -- TODO: Add to UT_CHARACTER_CODES ?
"!"				{ last_token := Exclamation_code; last_string_value := text }
"~"				{ last_token := 126; last_string_value := text } -- TODO: Add to UT_CHARACTER_CODES ?
"-"				{ last_token := Minus_code; last_string_value := text }
"+"				{ last_token := Plus_code; last_string_value := text }
"*"				{ last_token := Star_code; last_string_value := text }
"/"				{ last_token := Slash_code; last_string_value := text }
"%"				{ last_token := 37; last_string_value := text } -- TODO: Add to UT_CHARACTER_CODES ?
"<"				{ last_token := Less_than_code; last_string_value := text }
">"				{ last_token := Greater_than_code; last_string_value := text }
"^"				{ last_token := Caret_code; last_string_value := text }
"|"				{ last_token := Bar_code; last_string_value := text }
"?"				{ last_token := Question_mark_code; last_string_value := text }

[ \t\v\n\f]		{ }
.			{ } --/* ignore bad characters */

%%
feature
end
