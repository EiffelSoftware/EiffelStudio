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

create

	make, execute, benchmark

feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= IN_STR)
		end

feature {NONE} -- Implementation

	yy_build_tables
			-- Build scanner tables.
		do
			yy_nxt := yy_nxt_template
			yy_accept := yy_accept_template
		end

	yy_execute_action (yy_act: INTEGER)
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count) -- Ignore separators
when 2 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); eif_lineno := eif_lineno + text_count
when 3 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := E_COMMENT -- Ignore comments
when 4 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := E_COMMENT; eif_lineno := eif_lineno + 1
when 5 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Minus_code
when 6 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Plus_code
when 7 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Star_code
when 8 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Slash_code
when 9 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Caret_code
when 10 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Equal_code
when 11 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Greater_than_code
when 12 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Less_than_code
when 13 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Dot_code
when 14 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Semicolon_code
when 15 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Comma_code
when 16 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Colon_code
when 17 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Exclamation_code
when 18 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Left_parenthesis_code
when 19 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Right_parenthesis_code
when 20 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Left_brace_code
when 21 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Right_brace_code
when 22 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Left_bracket_code
when 23 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Right_bracket_code
when 24 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := Dollar_code
when 25 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := E_DIV
when 26 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := E_MOD
when 27 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := E_NE
when 28 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := E_GE
when 29 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := E_LE
when 30 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := E_BANGBANG
when 31 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := E_ARROW
when 32 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := E_DOTDOT
when 33 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := E_LARRAY
when 34 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := E_RARRAY
when 35 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := E_ASSIGN
when 36 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := E_REVERSE
when 37 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := E_ALIAS 
when 38 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
move (text_count); last_token := E_ALL
when 39 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_AND;move (text_count)
when 40 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_AS;move (text_count)
when 41 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_BITTYPE;move (text_count)
when 42 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHECK;move (text_count)
when 43 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CLASS;move (text_count)
when 44 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CREATION;move (text_count)
when 45 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CURRENT;move (text_count)
when 46 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_DEBUG;move (text_count)
when 47 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_DEFERRED;move (text_count)
when 48 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_DO;move (text_count)
when 49 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_ELSE;move (text_count)
when 50 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_ELSEIF;move (text_count)
when 51 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_END;move (text_count)
when 52 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_ENSURE;move (text_count)
when 53 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_EXPANDED;move (text_count)
when 54 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_EXPORT;move (text_count)
when 55 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_EXTERNAL;move (text_count)
when 56 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_FALSE;move (text_count)
when 57 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_FEATURE;move (text_count)
when 58 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_FROM;move (text_count)
when 59 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_FROZEN;move (text_count)
when 60 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_IF;move (text_count)
when 61 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_IMPLIES;move (text_count)
when 62 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_INDEXING;move (text_count)
when 63 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end

										is_operator := True
										last_token := E_INFIX;move (text_count)
									
when 64 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_INHERIT;move (text_count)
when 65 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_INSPECT;move (text_count)
when 66 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_INVARIANT;move (text_count)
when 67 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_IS;move (text_count)
when 68 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_LIKE;move (text_count)
when 69 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_LOCAL;move (text_count)
when 70 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_LOOP;move (text_count)
when 71 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_NOT;move (text_count)
when 72 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_OBSOLETE;move (text_count)
when 73 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_OLD;move (text_count)
when 74 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_ONCE;move (text_count)
when 75 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_OR;move (text_count)
when 76 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_PRECURSOR;move (text_count)
when 77 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end

										is_operator := True
										last_token := E_PREFIX;move (text_count)
									
when 78 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_REDEFINE;move (text_count)
when 79 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_RENAME;move (text_count)
when 80 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_REQUIRE;move (text_count)
when 81 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_RESCUE;move (text_count)
when 82 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_RESULT;move (text_count)
when 83 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_RETRY;move (text_count)
when 84 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_SELECT;move (text_count)
when 85 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_SEPARATE;move (text_count)
when 86 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_STRIP;move (text_count)
when 87 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_THEN;move (text_count)
when 88 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_TRUE;move (text_count)
when 89 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_UNDEFINE;move (text_count)
when 90 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_UNIQUE;move (text_count)
when 91 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_UNTIL;move (text_count)
when 92 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_VARIANT;move (text_count)
when 93 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_WHEN;move (text_count)
when 94 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_XOR;move (text_count)
when 95 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end

				last_token := E_IDENTIFIER
				last_value := text;move (text_count)
			
when 96 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end

				last_token := E_FREEOP
				last_value := text;move (text_count)
			
when 97 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := text_item (2);move (text_count)
when 98 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%'';move (text_count)
when 99 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%A';move (text_count)
when 100 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%B';move (text_count)
when 101 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%C';move (text_count)
when 102 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%D';move (text_count)
when 103 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%F';move (text_count)
when 104 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%H';move (text_count)
when 105 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%L';move (text_count)
when 106 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%N';move (text_count)
when 107 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%Q';move (text_count)
when 108 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%R';move (text_count)
when 109 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%S';move (text_count)
when 110 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%T';move (text_count)
when 111 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%U';move (text_count)
when 112 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%V';move (text_count)
when 113 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%%';move (text_count)
when 114 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%'';move (text_count)
when 115 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%"';move (text_count)
when 116 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%(';move (text_count)
when 117 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%)';move (text_count)
when 118 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%<';move (text_count)
when 119 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := '%>';move (text_count)
when 120 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end

						code_ := text_substring (4, text_count - 2).to_integer
						if code_ > Platform.Maximum_character_code then
							last_token := E_CHARERR
						else
							last_token := E_CHARACTER
							last_value := INTEGER_.to_character (code_)
						end
						move (text_count)
					
when 121 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARACTER; last_value := text_item (3);move (text_count)
when 122, 123 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_CHARERR;move (text_count)	-- Catch-all rules (no backing up)
when 124 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STRPLUS);move (text_count)
when 125 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STRMINUS);move (text_count)
when 126 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STRSTAR);move (text_count)
when 127 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STRSLASH);move (text_count)
when 128 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STRDIV);move (text_count)
when 129 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STRMOD);move (text_count)
when 130 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STRPOWER);move (text_count)
when 131 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STRLT);move (text_count)
when 132 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STRLE);move (text_count)
when 133 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STRGT);move (text_count)
when 134 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STRGE);move (text_count)
when 135 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STRNOT);move (text_count)
when 136 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STRAND);move (text_count)
when 137 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STROR);move (text_count)
when 138 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STRXOR);move (text_count)
when 139 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STRANDTHEN);move (text_count)
when 140 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STRORELSE);move (text_count)
when 141 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := process_operator (E_STRIMPLIES);move (text_count)
when 142 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end

			if is_operator then
				is_operator := False
				last_token := E_STRFREEOP
			else
				last_token := E_STRING
			end
			last_value := text_substring (2, text_count - 1);move (text_count)
		
when 143 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end

				last_token := E_STRING
				last_value := text_substring (2, text_count - 1);move (text_count)
			
when 144 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end

				if text_count > 1 then
					eif_buffer.append_string (text_substring (2, text_count))
				end
				set_start_condition (IN_STR);move (text_count)
			
when 145 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_string (text);move (text_count)
when 146 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%A');move (text_count)
when 147 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%B');move (text_count)
when 148 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%C');move (text_count)
when 149 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%D');move (text_count)
when 150 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%F');move (text_count)
when 151 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%H');move (text_count)
when 152 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%L');move (text_count)
when 153 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%N');move (text_count)
when 154 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%Q');move (text_count)
when 155 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%R');move (text_count)
when 156 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%S');move (text_count)
when 157 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%T');move (text_count)
when 158 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%U');move (text_count)
when 159 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%V');move (text_count)
when 160 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%%');move (text_count)
when 161 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%'');move (text_count)
when 162 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%"');move (text_count)
when 163 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%(');move (text_count)
when 164 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%)');move (text_count)
when 165 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%<');move (text_count)
when 166 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character ('%>');move (text_count)
when 167 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end

			code_ := text_substring (3, text_count - 1).to_integer
			if (code_ > Platform.Maximum_character_code) then
				last_token := E_STRERR
				set_start_condition (INITIAL)
			else
				eif_buffer.append_character (INTEGER_.to_character (code_))
			end;move (text_count)
		
when 168 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_lineno := eif_lineno + 1;move (text_count)
when 169 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end

			last_token := E_STRING
			if text_count > 1 then
				eif_buffer.append_string (text_substring (1, text_count - 1))
			end
			str_ := STRING_.make (eif_buffer.count)
			str_.append_string (eif_buffer)
			eif_buffer.wipe_out
			last_value := str_
			set_start_condition (INITIAL);move (text_count)
		
when 170 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
eif_buffer.append_character (text_item (2));move (text_count)
when 171, 172, 173 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
	-- Catch-all rules (no backing up)
							last_token := E_STRERR
							set_start_condition (INITIAL);move (text_count)
						
when 174 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_BIT; last_value := text;move (text_count)
when 175 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end

						last_token := E_INTEGER
						last_value := text.to_integer;move (text_count)
					
when 176 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end

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
					
when 177 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := E_INTERR	;move (text_count)-- Catch-all rule (no backing up)
when 178 then
	yy_end := yy_end - 1
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end

						last_token := E_REAL
						last_value := text.to_double;move (text_count)
					
when 179, 180 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end

						last_token := E_REAL
						last_value := text.to_double;move (text_count)
					
when 181 then
	yy_end := yy_end - 1
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end

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
					
when 182, 183 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end

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
					
when 184 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := text_item (1).code;move (text_count)
when 185 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
last_token := yyError_token
fatal_error ("scanner jammed")
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
		end

	yy_execute_eof_action (yy_sc: INTEGER)
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 0 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
terminate
when 1 then
--|#line <not available> "eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'eiffel_scanner.l' at line <not available>")
end
	-- Catch-all rules (no backing up)
							last_token := E_STRERR
							set_start_condition (INITIAL);move (text_count)
						
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER]
			-- Template for `yy_nxt'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 137494)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			yy_nxt_template_5 (an_array)
			yy_nxt_template_6 (an_array)
			yy_nxt_template_7 (an_array)
			yy_nxt_template_8 (an_array)
			yy_nxt_template_9 (an_array)
			yy_nxt_template_10 (an_array)
			yy_nxt_template_11 (an_array)
			yy_nxt_template_12 (an_array)
			yy_nxt_template_13 (an_array)
			yy_nxt_template_14 (an_array)
			yy_nxt_template_15 (an_array)
			yy_nxt_template_16 (an_array)
			yy_nxt_template_17 (an_array)
			yy_nxt_template_18 (an_array)
			yy_nxt_template_19 (an_array)
			yy_nxt_template_20 (an_array)
			yy_nxt_template_21 (an_array)
			yy_nxt_template_22 (an_array)
			yy_nxt_template_23 (an_array)
			yy_nxt_template_24 (an_array)
			yy_nxt_template_25 (an_array)
			yy_nxt_template_26 (an_array)
			yy_nxt_template_27 (an_array)
			yy_nxt_template_28 (an_array)
			yy_nxt_template_29 (an_array)
			yy_nxt_template_30 (an_array)
			yy_nxt_template_31 (an_array)
			yy_nxt_template_32 (an_array)
			yy_nxt_template_33 (an_array)
			yy_nxt_template_34 (an_array)
			yy_nxt_template_35 (an_array)
			yy_nxt_template_36 (an_array)
			yy_nxt_template_37 (an_array)
			yy_nxt_template_38 (an_array)
			yy_nxt_template_39 (an_array)
			yy_nxt_template_40 (an_array)
			yy_nxt_template_41 (an_array)
			yy_nxt_template_42 (an_array)
			yy_nxt_template_43 (an_array)
			yy_nxt_template_44 (an_array)
			yy_nxt_template_45 (an_array)
			yy_nxt_template_46 (an_array)
			yy_nxt_template_47 (an_array)
			yy_nxt_template_48 (an_array)
			yy_nxt_template_49 (an_array)
			yy_nxt_template_50 (an_array)
			yy_nxt_template_51 (an_array)
			yy_nxt_template_52 (an_array)
			yy_nxt_template_53 (an_array)
			yy_nxt_template_54 (an_array)
			yy_nxt_template_55 (an_array)
			yy_nxt_template_56 (an_array)
			yy_nxt_template_57 (an_array)
			yy_nxt_template_58 (an_array)
			yy_nxt_template_59 (an_array)
			yy_nxt_template_60 (an_array)
			yy_nxt_template_61 (an_array)
			yy_nxt_template_62 (an_array)
			yy_nxt_template_63 (an_array)
			yy_nxt_template_64 (an_array)
			yy_nxt_template_65 (an_array)
			yy_nxt_template_66 (an_array)
			yy_nxt_template_67 (an_array)
			yy_nxt_template_68 (an_array)
			yy_nxt_template_69 (an_array)
			yy_nxt_template_70 (an_array)
			yy_nxt_template_71 (an_array)
			yy_nxt_template_72 (an_array)
			yy_nxt_template_73 (an_array)
			yy_nxt_template_74 (an_array)
			yy_nxt_template_75 (an_array)
			yy_nxt_template_76 (an_array)
			yy_nxt_template_77 (an_array)
			yy_nxt_template_78 (an_array)
			yy_nxt_template_79 (an_array)
			yy_nxt_template_80 (an_array)
			yy_nxt_template_81 (an_array)
			yy_nxt_template_82 (an_array)
			yy_nxt_template_83 (an_array)
			yy_nxt_template_84 (an_array)
			yy_nxt_template_85 (an_array)
			yy_nxt_template_86 (an_array)
			yy_nxt_template_87 (an_array)
			yy_nxt_template_88 (an_array)
			yy_nxt_template_89 (an_array)
			yy_nxt_template_90 (an_array)
			yy_nxt_template_91 (an_array)
			yy_nxt_template_92 (an_array)
			yy_nxt_template_93 (an_array)
			yy_nxt_template_94 (an_array)
			yy_nxt_template_95 (an_array)
			yy_nxt_template_96 (an_array)
			yy_nxt_template_97 (an_array)
			yy_nxt_template_98 (an_array)
			yy_nxt_template_99 (an_array)
			yy_nxt_template_100 (an_array)
			yy_nxt_template_101 (an_array)
			yy_nxt_template_102 (an_array)
			yy_nxt_template_103 (an_array)
			yy_nxt_template_104 (an_array)
			yy_nxt_template_105 (an_array)
			yy_nxt_template_106 (an_array)
			yy_nxt_template_107 (an_array)
			yy_nxt_template_108 (an_array)
			yy_nxt_template_109 (an_array)
			yy_nxt_template_110 (an_array)
			yy_nxt_template_111 (an_array)
			yy_nxt_template_112 (an_array)
			yy_nxt_template_113 (an_array)
			yy_nxt_template_114 (an_array)
			yy_nxt_template_115 (an_array)
			yy_nxt_template_116 (an_array)
			yy_nxt_template_117 (an_array)
			yy_nxt_template_118 (an_array)
			yy_nxt_template_119 (an_array)
			yy_nxt_template_120 (an_array)
			yy_nxt_template_121 (an_array)
			yy_nxt_template_122 (an_array)
			yy_nxt_template_123 (an_array)
			yy_nxt_template_124 (an_array)
			yy_nxt_template_125 (an_array)
			yy_nxt_template_126 (an_array)
			yy_nxt_template_127 (an_array)
			yy_nxt_template_128 (an_array)
			yy_nxt_template_129 (an_array)
			yy_nxt_template_130 (an_array)
			yy_nxt_template_131 (an_array)
			yy_nxt_template_132 (an_array)
			yy_nxt_template_133 (an_array)
			yy_nxt_template_134 (an_array)
			yy_nxt_template_135 (an_array)
			yy_nxt_template_136 (an_array)
			yy_nxt_template_137 (an_array)
			yy_nxt_template_138 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    5,    6,    6,
			    6,    6,    6,    6,    6,    6,    7,    8,    6,    6,
			    7,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    7,
			    9,   10,   11,   12,    6,   11,   13,   14,   15,   16,

			   17,   18,   19,   20,   21,   22,   22,   23,   23,   23,
			   23,   23,   23,   23,   23,   24,   25,   26,   27,   28,
			   29,   11,   30,   31,   32,   33,   34,   35,   36,   36,
			   37,   36,   36,   38,   36,   39,   40,   41,   36,   42,
			   43,   44,   45,   46,   47,   48,   36,   36,   49,   50,
			   51,   52,   53,    6,   30,   31,   32,   33,   34,   35,
			   36,   36,   37,   36,   36,   38,   36,   39,   40,   41,
			   36,   42,   43,   44,   45,   46,   47,   48,   36,   36,
			   54,   11,   55,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,

			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,

			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    5,    6,    6,    6,    6,    6,
			    6,    6,    6,    7,    8,    6,    6,    7,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    7,    9,   10,   11,
			   12,    6,   11,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   22,   22,   23,   23,   23,   23,   23,   23,
			   23,   23,   24,   25,   26,   27,   28,   29,   11,   30,
			   31,   32,   33,   34,   35,   36,   36,   37,   36,   36,
			   38,   36,   39,   40,   41,   36,   42,   43,   44,   45,

			   46,   47,   48,   36,   36,   49,   50,   51,   52,   53,
			    6,   30,   31,   32,   33,   34,   35,   36,   36,   37,
			   36,   36,   38,   36,   39,   40,   41,   36,   42,   43,
			   44,   45,   46,   47,   48,   36,   36,   54,   11,   55,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,

			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    6,    6,    6,
			    6,    5,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   57,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,

			   56,   56,   56,   56,   56,   58,   56,   56,   59,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,

			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,    5,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   57,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   58,   56,   56,   59,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,

			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,

			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,

			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,

			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,

			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
			   -5,   -5,    5,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,

			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,

			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,
			   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,   -6,    5,

			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   60,   -7,
			   -7,   -7,   60,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   60,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,

			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7,   -7,   -7,   -7,   -7,    5,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   61,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,

			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,

			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,

			   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,   -8,
			   -8,   -8,   -8,    5,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   62,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,

			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,

			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,   -9,
			    5,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			  -10,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   64,   65,   63,  -10,   65,   63,
			   63,   63,   66,   67,   63,   68,   63,   69,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   70,   63,   71,   63,   65,   72,   63,   63,   63,   63,
			   63,   63,   63,   73,   63,   63,   63,   63,   74,   75,
			   63,   63,   63,   63,   63,   63,   63,   63,   76,   63,
			   63,   63,   77,   63,   78,   63,   63,   72,   63,   63,
			   63,   63,   63,   63,   63,   73,   63,   63,   63,   63,
			   74,   75,   63,   63,   63,   63,   63,   63,   63,   63,
			   76,   63,   63,   63,   65,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,    5,   79,   79,
			   79,   79,   79,   79,   79,   79,  -11,  -11,   79,   79,
			  -11,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,  -11,
			   79,  -11,   79,   79,  -11,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,

			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79, yy_Dummy>>,
			1, 1000, 2000)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,    5,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,

			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,

			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,

			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,  -12,
			  -12,    5,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,  -13,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   81,   80,
			   82,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,

			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,

			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,    5,  -14,

			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,

			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,

			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,  -14,
			  -14,  -14,  -14,  -14,  -14,    5,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,

			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15, yy_Dummy>>,
			1, 1000, 3000)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,

			  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
			  -15,  -15,    5,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,

			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,

			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,
			  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,  -16,    5,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,

			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,

			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,

			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,  -17,
			  -17,  -17,  -17,  -17,  -17,  -17,    5,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,

			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,

			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,  -18,
			  -18,  -18,  -18,    5,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,

			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,   83,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,   84,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19, yy_Dummy>>,
			1, 1000, 4000)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,

			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,  -19,
			    5,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,   85,  -20,   86,   86,
			   86,   86,   86,   86,   86,   86,   86,   86,  -20,  -20,

			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,

			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,  -20,
			  -20,  -20,  -20,  -20,  -20,  -20,  -20,    5,  -21,  -21,

			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,   87,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,   88,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,

			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,

			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,  -21,
			  -21,  -21,  -21,  -21,    5,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,

			   89,  -22,   90,   90,   91,   91,   91,   91,   91,   91,
			   91,   91,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			   92,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,   93,
			  -22,  -22,   92,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,

			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,

			  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,  -22,
			  -22,    5,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,   89,  -23,   91,
			   91,   91,   91,   91,   91,   91,   91,   91,   91,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23, yy_Dummy>>,
			1, 1000, 5000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  -23,  -23,  -23,  -23,  -23,  -23,   93,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,

			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,
			  -23,  -23,  -23,  -23,  -23,  -23,  -23,  -23,    5,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,

			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,   94,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,

			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,

			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,  -24,
			  -24,  -24,  -24,  -24,  -24,    5,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,

			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,

			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
			  -25,  -25,    5,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,

			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,   95,   96,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,

			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,

			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,    5,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27, yy_Dummy>>,
			1, 1000, 6000)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,

			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,  -27,
			  -27,  -27,  -27,  -27,  -27,  -27,    5,  -28,  -28,  -28,

			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,   97,   98,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,

			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,

			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,  -28,
			  -28,  -28,  -28,    5,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,

			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,   99,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,

			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,

			  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,  -29,
			    5,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
			  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
			  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
			  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
			  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  -30,  -30,
			  -30,  -30,  -30,  -30,  -30,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  101,  100,  102,  100,
			  100,  100,  100,  103,  100,  100,  100,  100,  100,  100,

			  100,  -30,  -30,  -30,  -30,  100,  -30,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  101,  100,
			  102,  100,  100,  100,  100,  103,  100,  100,  100,  100,
			  100,  100,  100,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
			  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
			  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
			  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
			  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
			  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
			  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,

			  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
			  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
			  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
			  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
			  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
			  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,  -30,
			  -30,  -30,  -30,  -30,  -30,  -30,  -30,    5,  -31,  -31,
			  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,
			  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,
			  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31, yy_Dummy>>,
			1, 1000, 7000)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,
			  -31,  -31,  -31,  -31,  -31,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  -31,  -31,  -31,  -31,  -31,
			  -31,  -31,  100,  100,  100,  100,  100,  100,  100,  100,
			  104,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  -31,  -31,
			  -31,  -31,  100,  -31,  100,  100,  100,  100,  100,  100,
			  100,  100,  104,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,

			  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,
			  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,
			  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,
			  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,
			  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,
			  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,
			  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,
			  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,
			  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,
			  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,

			  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,
			  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,  -31,
			  -31,  -31,  -31,  -31,    5,  -32,  -32,  -32,  -32,  -32,
			  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,
			  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,
			  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,
			  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,
			  -32,  -32,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  100,
			  100,  100,  100,  100,  100,  100,  105,  100,  100,  100,

			  106,  100,  100,  100,  100,  100,  107,  100,  100,  108,
			  100,  100,  100,  100,  100,  -32,  -32,  -32,  -32,  100,
			  -32,  100,  100,  100,  100,  100,  100,  100,  105,  100,
			  100,  100,  106,  100,  100,  100,  100,  100,  107,  100,
			  100,  108,  100,  100,  100,  100,  100,  -32,  -32,  -32,
			  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,
			  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,
			  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,
			  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,
			  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,

			  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,
			  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,
			  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,
			  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,
			  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,
			  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,
			  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,
			  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,  -32,
			  -32,    5,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,
			  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,

			  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,
			  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,
			  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  -33,
			  -33,  -33,  -33,  -33,  -33,  -33,  100,  100,  100,  100,
			  109,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  110,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  -33,  -33,  -33,  -33,  100,  -33,  100,  100,
			  100,  100,  109,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  110,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  -33,  -33,  -33,  -33,  -33,  -33,
			  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,
			  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,
			  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,
			  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,
			  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,
			  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,
			  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,
			  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,
			  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,

			  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,
			  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,
			  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,
			  -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,    5,  -34,
			  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
			  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
			  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
			  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
			  -34,  -34,  -34,  -34,  -34,  -34,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  -34,  -34,  -34,  -34,

			  -34,  -34,  -34,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  111,  100,  112,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  113,  100,  100,  -34,
			  -34,  -34,  -34,  100,  -34,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  111,  100,  112,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  113,  100,
			  100,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
			  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
			  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
			  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,

			  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
			  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
			  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
			  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
			  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
			  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
			  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
			  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
			  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,  -34,
			  -34,  -34,  -34,  -34,  -34,    5,  -35,  -35,  -35,  -35, yy_Dummy>>,
			1, 1000, 8000)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
			  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
			  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
			  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
			  -35,  -35,  -35,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
			  114,  100,  100,  100,  115,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  116,  100,  100,
			  100,  100,  100,  100,  100,  100,  -35,  -35,  -35,  -35,
			  100,  -35,  114,  100,  100,  100,  115,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  116,
			  100,  100,  100,  100,  100,  100,  100,  100,  -35,  -35,
			  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
			  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
			  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
			  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
			  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
			  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
			  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
			  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,

			  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
			  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
			  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
			  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
			  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
			  -35,  -35,    5,  -36,  -36,  -36,  -36,  -36,  -36,  -36,
			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,
			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,
			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,
			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  -36,  -36,  -36,  -36,  100,  -36,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  -36,  -36,  -36,  -36,  -36,
			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,
			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,

			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,
			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,
			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,
			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,
			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,
			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,
			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,
			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,
			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,
			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,

			  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,    5,
			  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
			  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
			  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
			  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
			  -37,  -37,  -37,  -37,  -37,  -37,  -37,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  -37,  -37,  -37,
			  -37,  -37,  -37,  -37,  100,  100,  100,  100,  100,  117,
			  100,  100,  100,  100,  100,  100,  118,  119,  100,  100,
			  100,  100,  120,  100,  100,  100,  100,  100,  100,  100,

			  -37,  -37,  -37,  -37,  100,  -37,  100,  100,  100,  100,
			  100,  117,  100,  100,  100,  100,  100,  100,  118,  119,
			  100,  100,  100,  100,  120,  100,  100,  100,  100,  100,
			  100,  100,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
			  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
			  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
			  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
			  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
			  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
			  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,

			  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
			  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
			  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
			  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
			  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
			  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,  -37,
			  -37,  -37,  -37,  -37,  -37,  -37,    5,  -38,  -38,  -38,
			  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,
			  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,
			  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,

			  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,
			  -38,  -38,  -38,  -38,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  -38,  -38,  -38,  -38,  -38,  -38,
			  -38,  100,  100,  100,  100,  100,  100,  100,  100,  121,
			  100,  100,  100,  100,  100,  122,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  -38,  -38,  -38,
			  -38,  100,  -38,  100,  100,  100,  100,  100,  100,  100,
			  100,  121,  100,  100,  100,  100,  100,  122,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  -38,
			  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,

			  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,
			  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,
			  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,
			  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,
			  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,
			  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,
			  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,
			  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,
			  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,
			  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38, yy_Dummy>>,
			1, 1000, 9000)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,
			  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,  -38,
			  -38,  -38,  -38,    5,  -39,  -39,  -39,  -39,  -39,  -39,
			  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,
			  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,
			  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,
			  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,
			  -39,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  123,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  -39,  -39,  -39,  -39,  100,  -39,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  123,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  -39,  -39,  -39,  -39,
			  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,
			  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,
			  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,
			  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,
			  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,

			  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,
			  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,
			  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,
			  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,
			  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,
			  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,
			  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,
			  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,  -39,
			    5,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,
			  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,

			  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,
			  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,
			  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  -40,  -40,
			  -40,  -40,  -40,  -40,  -40,  100,  124,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  125,  100,  126,  100,
			  100,  100,  127,  100,  100,  100,  100,  100,  100,  100,
			  100,  -40,  -40,  -40,  -40,  100,  -40,  100,  124,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  125,  100,
			  126,  100,  100,  100,  127,  100,  100,  100,  100,  100,

			  100,  100,  100,  -40,  -40,  -40,  -40,  -40,  -40,  -40,
			  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,
			  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,
			  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,
			  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,
			  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,
			  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,
			  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,
			  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,
			  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,

			  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,
			  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,
			  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,  -40,
			  -40,  -40,  -40,  -40,  -40,  -40,  -40,    5,  -41,  -41,
			  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,
			  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,
			  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,
			  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,
			  -41,  -41,  -41,  -41,  -41,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  -41,  -41,  -41,  -41,  -41,

			  -41,  -41,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  128,
			  100,  100,  100,  100,  100,  100,  100,  100,  -41,  -41,
			  -41,  -41,  100,  -41,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  128,  100,  100,  100,  100,  100,  100,  100,  100,
			  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,
			  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,
			  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,
			  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,

			  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,
			  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,
			  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,
			  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,
			  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,
			  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,
			  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,
			  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,
			  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,  -41,
			  -41,  -41,  -41,  -41,    5,  -42,  -42,  -42,  -42,  -42,

			  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,
			  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,
			  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,
			  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,
			  -42,  -42,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  100,
			  100,  100,  100,  129,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  -42,  -42,  -42,  -42,  100,
			  -42,  100,  100,  100,  100,  129,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  -42,  -42,  -42,
			  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,
			  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,
			  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,
			  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,
			  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,
			  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,
			  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,
			  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42, yy_Dummy>>,
			1, 1000, 10000)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,
			  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,
			  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,
			  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,
			  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,  -42,
			  -42,    5,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,
			  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,
			  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,
			  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,
			  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  -43,
			  -43,  -43,  -43,  -43,  -43,  -43,  100,  100,  100,  100,
			  130,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  131,  100,  100,  100,  100,
			  100,  100,  -43,  -43,  -43,  -43,  100,  -43,  100,  100,
			  100,  100,  130,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  131,  100,  100,
			  100,  100,  100,  100,  -43,  -43,  -43,  -43,  -43,  -43,
			  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,
			  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,

			  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,
			  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,
			  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,
			  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,
			  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,
			  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,
			  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,
			  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,
			  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,
			  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,

			  -43,  -43,  -43,  -43,  -43,  -43,  -43,  -43,    5,  -44,
			  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,
			  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,
			  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,
			  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,
			  -44,  -44,  -44,  -44,  -44,  -44,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  -44,  -44,  -44,  -44,
			  -44,  -44,  -44,  100,  100,  100,  100,  100,  100,  100,
			  132,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  133,  100,  100,  100,  100,  100,  100,  100,  100,  -44,

			  -44,  -44,  -44,  100,  -44,  100,  100,  100,  100,  100,
			  100,  100,  132,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  133,  100,  100,  100,  100,  100,  100,  100,
			  100,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,
			  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,
			  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,
			  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,
			  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,
			  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,
			  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,

			  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,
			  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,
			  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,
			  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,
			  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,
			  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,  -44,
			  -44,  -44,  -44,  -44,  -44,    5,  -45,  -45,  -45,  -45,
			  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
			  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
			  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,

			  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
			  -45,  -45,  -45,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  134,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  -45,  -45,  -45,  -45,
			  100,  -45,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  134,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  -45,  -45,
			  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,

			  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
			  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
			  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
			  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
			  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
			  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
			  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
			  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
			  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
			  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,

			  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
			  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
			  -45,  -45,    5,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  135,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  -46,  -46,  -46,  -46,  100,  -46,  135,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  -46,  -46,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46, yy_Dummy>>,
			1, 1000, 11000)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,    5,
			  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,
			  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,

			  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,
			  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,
			  -47,  -47,  -47,  -47,  -47,  -47,  -47,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  -47,  -47,  -47,
			  -47,  -47,  -47,  -47,  100,  100,  100,  100,  100,  100,
			  100,  136,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  -47,  -47,  -47,  -47,  100,  -47,  100,  100,  100,  100,
			  100,  100,  100,  136,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,
			  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,
			  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,
			  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,
			  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,
			  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,
			  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,
			  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,
			  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,
			  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,

			  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,
			  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,
			  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,  -47,
			  -47,  -47,  -47,  -47,  -47,  -47,    5,  -48,  -48,  -48,
			  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,
			  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,
			  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,
			  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,
			  -48,  -48,  -48,  -48,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  -48,  -48,  -48,  -48,  -48,  -48,

			  -48,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  137,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  -48,  -48,  -48,
			  -48,  100,  -48,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  137,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  -48,
			  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,
			  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,
			  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,
			  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,

			  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,
			  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,
			  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,
			  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,
			  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,
			  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,
			  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,
			  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,
			  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,  -48,
			  -48,  -48,  -48,    5,  -49,  -49,  -49,  -49,  -49,  -49,

			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,

			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,

			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,  -49,
			    5,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,

			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  138,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50, yy_Dummy>>,
			1, 1000, 12000)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,

			  -50,  -50,  -50,  -50,  -50,  -50,  -50,    5,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,

			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,

			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,
			  -51,  -51,  -51,  -51,    5,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,

			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,

			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,

			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,    5,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  139,
			  139,  139,  139,  139,  139,  139,  139,  139,  139,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,

			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  139,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,

			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,    5,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,

			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54, yy_Dummy>>,
			1, 1000, 13000)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,

			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,  -54,
			  -54,  -54,  -54,  -54,  -54,    5,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,

			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,

			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
			  -55,  -55,    5,  140,  140,  140,  140,  140,  140,  140,

			  140,  140,  -56,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  141,  140,  140,  -56,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,

			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,

			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,    5,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,

			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,

			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,
			  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,  -57,

			  -57,  -57,  -57,  -57,  -57,  -57,    5,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58, yy_Dummy>>,
			1, 1000, 14000)
		end

	yy_nxt_template_16 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,

			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,  -58,
			  -58,  -58,  -58,    5,  142,  142,  142,  142,  142,  142,
			  142,  142,  143,  144,  142,  142,  143,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  143,  142,  145,  142,  142,

			  146,  142,  147,  148,  149,  142,  142,  142,  142,  142,
			  150,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  151,  142,  152,  142,  142,  153,  154,
			  155,  156,  142,  157,  142,  158,  142,  142,  142,  159,
			  142,  160,  142,  142,  161,  162,  163,  164,  165,  166,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,

			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,

			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			    5,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,   60,
			  -60,  -60,  -60,   60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,   60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,

			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,

			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,    5,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,   61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,

			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,

			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,

			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,
			  -61,  -61,  -61,  -61,    5,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62, yy_Dummy>>,
			1, 1000, 15000)
		end

	yy_nxt_template_17 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,

			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,    5,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,  -63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   64,   63,   63,  -63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,    5,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,

			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,

			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,
			  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,  -64,

			  -64,  -64,  -64,  -64,  -64,    5,   65,   65,   65,   65,
			   65,   65,   65,   65,   63,  -65,   65,   65,   63,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   63,   65,  167,
			   65,   65,  -65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,

			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,

			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,    5,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,  -66,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,  168,   63,   63,  -66, yy_Dummy>>,
			1, 1000, 16000)
		end

	yy_nxt_template_18 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,    5,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,  -67,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,  169,   63,   63,  -67,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,    5,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,  -68,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			  170,   63,   63,  -68,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,    5,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,  -69,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,  171,   63,   63,
			  -69,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			  172,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			    5,   63,   63,   63,   63,   63,   63,   63,   63,   63, yy_Dummy>>,
			1, 1000, 17000)
		end

	yy_nxt_template_19 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  -70,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,  173,   63,   63,  -70,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,  174,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,    5,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,  -71,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,  175,   63,   63,  -71,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,  176,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,    5,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,  -72,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   64,   63,
			   63,  -72,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,  177,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,  177,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,    5,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,  -73,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   64,   63,   63,  -73,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,  178,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			  178,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63, yy_Dummy>>,
			1, 1000, 18000)
		end

	yy_nxt_template_20 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,    5,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,  -74,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   64,   63,   63,  -74,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,  179,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,  179,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,    5,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,  -75,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   64,
			   63,   63,  -75,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,  180,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,  180,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,    5,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,  -76,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   64,   63,   63,  -76,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,  181,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,  181,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,    5,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,  -77,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   64,   63,   63,  -77,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,  182,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63, yy_Dummy>>,
			1, 1000, 19000)
		end

	yy_nxt_template_21 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,    5,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,  -78,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			  183,   63,   63,  -78,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,    5,   79,   79,   79,   79,   79,   79,
			   79,   79,  -79,  -79,   79,   79,  -79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,  -79,   79,  -79,   79,   79,
			  -79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,

			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,

			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			    5,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  -80,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  185,

			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,

			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,

			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,    5,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  -81,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  187,  186,  186,  188,  186,  189,  190,  191,  186,
			  186,  186,  186,  186,  192,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  193,  186,  194,
			  186,  186,  195,  196,  197,  198,  186,  199,  186,  200,
			  186,  186,  186,  201,  186,  202,  186,  186,  203,  204,

			  205,  206,  207,  208,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186, yy_Dummy>>,
			1, 1000, 20000)
		end

	yy_nxt_template_22 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,    5,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  -82,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,

			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  209,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,

			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,

			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,    5,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,  210,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,

			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,

			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,    5,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,

			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,

			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,

			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,  -84,
			  -84,  -84,  -84,  -84,  -84,    5,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,

			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85, yy_Dummy>>,
			1, 1000, 21000)
		end

	yy_nxt_template_23 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,
			  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,  -85,

			  -85,  -85,    5,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  212,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  213,  -86,  -86,

			  -86,  -86,  -86,  212,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,

			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,
			  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,  -86,    5,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,

			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,

			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,

			  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,    5,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,

			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,

			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,  -88,
			  -88,  -88,  -88,    5,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,

			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  -89,
			  214,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  216,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  216,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214, yy_Dummy>>,
			1, 1000, 22000)
		end

	yy_nxt_template_24 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,

			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			    5,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,   89,  -90,  217,  217,
			  218,  218,  218,  218,  218,  218,  218,  218,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,   92,  -90,  -90,  -90,

			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,   93,  -90,  -90,   92,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,

			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,  -90,
			  -90,  -90,  -90,  -90,  -90,  -90,  -90,    5,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,

			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,   89,  -91,  218,  218,  218,  218,  218,
			  218,  218,  218,  218,  218,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,   93,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,

			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,

			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			  -91,  -91,  -91,  -91,    5,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,

			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,

			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,
			  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,  -92,

			  -92,    5,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  139,  -93,  -93,  -93, yy_Dummy>>,
			1, 1000, 23000)
		end

	yy_nxt_template_25 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,

			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,
			  -93,  -93,  -93,  -93,  -93,  -93,  -93,  -93,    5,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,

			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,

			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,

			  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,  -94,
			  -94,  -94,  -94,  -94,  -94,    5,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,

			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,

			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,  -95,
			  -95,  -95,    5,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,

			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,

			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,

			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,
			  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,  -96,    5,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97, yy_Dummy>>,
			1, 1000, 24000)
		end

	yy_nxt_template_26 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,

			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,  -97,
			  -97,  -97,  -97,  -97,  -97,  -97,    5,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,

			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,

			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,

			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,  -98,
			  -98,  -98,  -98,    5,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,

			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,

			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,
			  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,  -99,

			    5, -100, -100, -100, -100, -100, -100, -100, -100, -100,
			 -100, -100, -100, -100, -100, -100, -100, -100, -100, -100,
			 -100, -100, -100, -100, -100, -100, -100, -100, -100, -100,
			 -100, -100, -100, -100, -100, -100, -100, -100, -100, -100,
			 -100, -100, -100, -100, -100, -100, -100, -100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -100, -100,
			 -100, -100, -100, -100, -100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -100, -100, -100, -100,  100, -100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -100, -100, -100, -100, -100, -100, -100,
			 -100, -100, -100, -100, -100, -100, -100, -100, -100, -100,
			 -100, -100, -100, -100, -100, -100, -100, -100, -100, -100,
			 -100, -100, -100, -100, -100, -100, -100, -100, -100, -100,
			 -100, -100, -100, -100, -100, -100, -100, -100, -100, -100,
			 -100, -100, -100, -100, -100, -100, -100, -100, -100, -100,
			 -100, -100, -100, -100, -100, -100, -100, -100, -100, -100,
			 -100, -100, -100, -100, -100, -100, -100, -100, -100, -100,

			 -100, -100, -100, -100, -100, -100, -100, -100, -100, -100,
			 -100, -100, -100, -100, -100, -100, -100, -100, -100, -100,
			 -100, -100, -100, -100, -100, -100, -100, -100, -100, -100,
			 -100, -100, -100, -100, -100, -100, -100, -100, -100, -100,
			 -100, -100, -100, -100, -100, -100, -100, -100, -100, -100,
			 -100, -100, -100, -100, -100, -100, -100,    5, -101, -101,
			 -101, -101, -101, -101, -101, -101, -101, -101, -101, -101,
			 -101, -101, -101, -101, -101, -101, -101, -101, -101, -101,
			 -101, -101, -101, -101, -101, -101, -101, -101, -101, -101,
			 -101, -101, -101, -101, -101, -101, -101, -101, -101, -101, yy_Dummy>>,
			1, 1000, 25000)
		end

	yy_nxt_template_27 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -101, -101, -101, -101, -101,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -101, -101, -101, -101, -101,
			 -101, -101,  100,  100,  100,  100,  100,  100,  100,  100,
			  220,  100,  100,  221,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -101, -101,
			 -101, -101,  100, -101,  100,  100,  100,  100,  100,  100,
			  100,  100,  220,  100,  100,  221,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -101, -101, -101, -101, -101, -101, -101, -101, -101, -101,
			 -101, -101, -101, -101, -101, -101, -101, -101, -101, -101,

			 -101, -101, -101, -101, -101, -101, -101, -101, -101, -101,
			 -101, -101, -101, -101, -101, -101, -101, -101, -101, -101,
			 -101, -101, -101, -101, -101, -101, -101, -101, -101, -101,
			 -101, -101, -101, -101, -101, -101, -101, -101, -101, -101,
			 -101, -101, -101, -101, -101, -101, -101, -101, -101, -101,
			 -101, -101, -101, -101, -101, -101, -101, -101, -101, -101,
			 -101, -101, -101, -101, -101, -101, -101, -101, -101, -101,
			 -101, -101, -101, -101, -101, -101, -101, -101, -101, -101,
			 -101, -101, -101, -101, -101, -101, -101, -101, -101, -101,
			 -101, -101, -101, -101, -101, -101, -101, -101, -101, -101,

			 -101, -101, -101, -101, -101, -101, -101, -101, -101, -101,
			 -101, -101, -101, -101,    5, -102, -102, -102, -102, -102,
			 -102, -102, -102, -102, -102, -102, -102, -102, -102, -102,
			 -102, -102, -102, -102, -102, -102, -102, -102, -102, -102,
			 -102, -102, -102, -102, -102, -102, -102, -102, -102, -102,
			 -102, -102, -102, -102, -102, -102, -102, -102, -102, -102,
			 -102, -102,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -102, -102, -102, -102, -102, -102, -102,  100,
			  100,  100,  222,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100, -102, -102, -102, -102,  100,
			 -102,  100,  100,  100,  222,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -102, -102, -102,
			 -102, -102, -102, -102, -102, -102, -102, -102, -102, -102,
			 -102, -102, -102, -102, -102, -102, -102, -102, -102, -102,
			 -102, -102, -102, -102, -102, -102, -102, -102, -102, -102,
			 -102, -102, -102, -102, -102, -102, -102, -102, -102, -102,
			 -102, -102, -102, -102, -102, -102, -102, -102, -102, -102,
			 -102, -102, -102, -102, -102, -102, -102, -102, -102, -102,

			 -102, -102, -102, -102, -102, -102, -102, -102, -102, -102,
			 -102, -102, -102, -102, -102, -102, -102, -102, -102, -102,
			 -102, -102, -102, -102, -102, -102, -102, -102, -102, -102,
			 -102, -102, -102, -102, -102, -102, -102, -102, -102, -102,
			 -102, -102, -102, -102, -102, -102, -102, -102, -102, -102,
			 -102, -102, -102, -102, -102, -102, -102, -102, -102, -102,
			 -102, -102, -102, -102, -102, -102, -102, -102, -102, -102,
			 -102,    5, -103, -103, -103, -103, -103, -103, -103, -103,
			 -103, -103, -103, -103, -103, -103, -103, -103, -103, -103,
			 -103, -103, -103, -103, -103, -103, -103, -103, -103, -103,

			 -103, -103, -103, -103, -103, -103, -103, -103, -103, -103,
			 -103, -103, -103, -103, -103, -103, -103, -103, -103,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -103,
			 -103, -103, -103, -103, -103, -103,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -103, -103, -103, -103,  100, -103,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -103, -103, -103, -103, -103, -103,

			 -103, -103, -103, -103, -103, -103, -103, -103, -103, -103,
			 -103, -103, -103, -103, -103, -103, -103, -103, -103, -103,
			 -103, -103, -103, -103, -103, -103, -103, -103, -103, -103,
			 -103, -103, -103, -103, -103, -103, -103, -103, -103, -103,
			 -103, -103, -103, -103, -103, -103, -103, -103, -103, -103,
			 -103, -103, -103, -103, -103, -103, -103, -103, -103, -103,
			 -103, -103, -103, -103, -103, -103, -103, -103, -103, -103,
			 -103, -103, -103, -103, -103, -103, -103, -103, -103, -103,
			 -103, -103, -103, -103, -103, -103, -103, -103, -103, -103,
			 -103, -103, -103, -103, -103, -103, -103, -103, -103, -103,

			 -103, -103, -103, -103, -103, -103, -103, -103, -103, -103,
			 -103, -103, -103, -103, -103, -103, -103, -103, -103, -103,
			 -103, -103, -103, -103, -103, -103, -103, -103,    5, -104,
			 -104, -104, -104, -104, -104, -104, -104, -104, -104, -104,
			 -104, -104, -104, -104, -104, -104, -104, -104, -104, -104,
			 -104, -104, -104, -104, -104, -104, -104, -104, -104, -104,
			 -104, -104, -104, -104, -104, -104, -104, -104, -104, -104,
			 -104, -104, -104, -104, -104, -104,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -104, -104, -104, -104,
			 -104, -104, -104,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  223,  100,  100,  100,  100,  100,  100, -104,
			 -104, -104, -104,  100, -104,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  223,  100,  100,  100,  100,  100,
			  100, -104, -104, -104, -104, -104, -104, -104, -104, -104,
			 -104, -104, -104, -104, -104, -104, -104, -104, -104, -104,
			 -104, -104, -104, -104, -104, -104, -104, -104, -104, -104,
			 -104, -104, -104, -104, -104, -104, -104, -104, -104, -104,
			 -104, -104, -104, -104, -104, -104, -104, -104, -104, -104,

			 -104, -104, -104, -104, -104, -104, -104, -104, -104, -104,
			 -104, -104, -104, -104, -104, -104, -104, -104, -104, -104,
			 -104, -104, -104, -104, -104, -104, -104, -104, -104, -104,
			 -104, -104, -104, -104, -104, -104, -104, -104, -104, -104,
			 -104, -104, -104, -104, -104, -104, -104, -104, -104, -104,
			 -104, -104, -104, -104, -104, -104, -104, -104, -104, -104,
			 -104, -104, -104, -104, -104, -104, -104, -104, -104, -104,
			 -104, -104, -104, -104, -104, -104, -104, -104, -104, -104,
			 -104, -104, -104, -104, -104,    5, -105, -105, -105, -105,
			 -105, -105, -105, -105, -105, -105, -105, -105, -105, -105, yy_Dummy>>,
			1, 1000, 26000)
		end

	yy_nxt_template_28 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -105, -105, -105, -105, -105, -105, -105, -105, -105, -105,
			 -105, -105, -105, -105, -105, -105, -105, -105, -105, -105,
			 -105, -105, -105, -105, -105, -105, -105, -105, -105, -105,
			 -105, -105, -105,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -105, -105, -105, -105, -105, -105, -105,
			  100,  100,  100,  100,  224,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -105, -105, -105, -105,
			  100, -105,  100,  100,  100,  100,  224,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100, -105, -105,
			 -105, -105, -105, -105, -105, -105, -105, -105, -105, -105,
			 -105, -105, -105, -105, -105, -105, -105, -105, -105, -105,
			 -105, -105, -105, -105, -105, -105, -105, -105, -105, -105,
			 -105, -105, -105, -105, -105, -105, -105, -105, -105, -105,
			 -105, -105, -105, -105, -105, -105, -105, -105, -105, -105,
			 -105, -105, -105, -105, -105, -105, -105, -105, -105, -105,
			 -105, -105, -105, -105, -105, -105, -105, -105, -105, -105,
			 -105, -105, -105, -105, -105, -105, -105, -105, -105, -105,
			 -105, -105, -105, -105, -105, -105, -105, -105, -105, -105,

			 -105, -105, -105, -105, -105, -105, -105, -105, -105, -105,
			 -105, -105, -105, -105, -105, -105, -105, -105, -105, -105,
			 -105, -105, -105, -105, -105, -105, -105, -105, -105, -105,
			 -105, -105, -105, -105, -105, -105, -105, -105, -105, -105,
			 -105, -105,    5, -106, -106, -106, -106, -106, -106, -106,
			 -106, -106, -106, -106, -106, -106, -106, -106, -106, -106,
			 -106, -106, -106, -106, -106, -106, -106, -106, -106, -106,
			 -106, -106, -106, -106, -106, -106, -106, -106, -106, -106,
			 -106, -106, -106, -106, -106, -106, -106, -106, -106, -106,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			 -106, -106, -106, -106, -106, -106, -106,  225,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -106, -106, -106, -106,  100, -106,  225,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -106, -106, -106, -106, -106,
			 -106, -106, -106, -106, -106, -106, -106, -106, -106, -106,
			 -106, -106, -106, -106, -106, -106, -106, -106, -106, -106,
			 -106, -106, -106, -106, -106, -106, -106, -106, -106, -106,

			 -106, -106, -106, -106, -106, -106, -106, -106, -106, -106,
			 -106, -106, -106, -106, -106, -106, -106, -106, -106, -106,
			 -106, -106, -106, -106, -106, -106, -106, -106, -106, -106,
			 -106, -106, -106, -106, -106, -106, -106, -106, -106, -106,
			 -106, -106, -106, -106, -106, -106, -106, -106, -106, -106,
			 -106, -106, -106, -106, -106, -106, -106, -106, -106, -106,
			 -106, -106, -106, -106, -106, -106, -106, -106, -106, -106,
			 -106, -106, -106, -106, -106, -106, -106, -106, -106, -106,
			 -106, -106, -106, -106, -106, -106, -106, -106, -106, -106,
			 -106, -106, -106, -106, -106, -106, -106, -106, -106,    5,

			 -107, -107, -107, -107, -107, -107, -107, -107, -107, -107,
			 -107, -107, -107, -107, -107, -107, -107, -107, -107, -107,
			 -107, -107, -107, -107, -107, -107, -107, -107, -107, -107,
			 -107, -107, -107, -107, -107, -107, -107, -107, -107, -107,
			 -107, -107, -107, -107, -107, -107, -107,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -107, -107, -107,
			 -107, -107, -107, -107,  100,  100,  100,  100,  226,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -107, -107, -107, -107,  100, -107,  100,  100,  100,  100,

			  226,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -107, -107, -107, -107, -107, -107, -107, -107,
			 -107, -107, -107, -107, -107, -107, -107, -107, -107, -107,
			 -107, -107, -107, -107, -107, -107, -107, -107, -107, -107,
			 -107, -107, -107, -107, -107, -107, -107, -107, -107, -107,
			 -107, -107, -107, -107, -107, -107, -107, -107, -107, -107,
			 -107, -107, -107, -107, -107, -107, -107, -107, -107, -107,
			 -107, -107, -107, -107, -107, -107, -107, -107, -107, -107,
			 -107, -107, -107, -107, -107, -107, -107, -107, -107, -107,

			 -107, -107, -107, -107, -107, -107, -107, -107, -107, -107,
			 -107, -107, -107, -107, -107, -107, -107, -107, -107, -107,
			 -107, -107, -107, -107, -107, -107, -107, -107, -107, -107,
			 -107, -107, -107, -107, -107, -107, -107, -107, -107, -107,
			 -107, -107, -107, -107, -107, -107, -107, -107, -107, -107,
			 -107, -107, -107, -107, -107, -107,    5, -108, -108, -108,
			 -108, -108, -108, -108, -108, -108, -108, -108, -108, -108,
			 -108, -108, -108, -108, -108, -108, -108, -108, -108, -108,
			 -108, -108, -108, -108, -108, -108, -108, -108, -108, -108,
			 -108, -108, -108, -108, -108, -108, -108, -108, -108, -108,

			 -108, -108, -108, -108,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -108, -108, -108, -108, -108, -108,
			 -108,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  227,  100,
			  100,  100,  100,  100,  100,  100,  100, -108, -108, -108,
			 -108,  100, -108,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  227,  100,  100,  100,  100,  100,  100,  100,  100, -108,
			 -108, -108, -108, -108, -108, -108, -108, -108, -108, -108,
			 -108, -108, -108, -108, -108, -108, -108, -108, -108, -108,

			 -108, -108, -108, -108, -108, -108, -108, -108, -108, -108,
			 -108, -108, -108, -108, -108, -108, -108, -108, -108, -108,
			 -108, -108, -108, -108, -108, -108, -108, -108, -108, -108,
			 -108, -108, -108, -108, -108, -108, -108, -108, -108, -108,
			 -108, -108, -108, -108, -108, -108, -108, -108, -108, -108,
			 -108, -108, -108, -108, -108, -108, -108, -108, -108, -108,
			 -108, -108, -108, -108, -108, -108, -108, -108, -108, -108,
			 -108, -108, -108, -108, -108, -108, -108, -108, -108, -108,
			 -108, -108, -108, -108, -108, -108, -108, -108, -108, -108,
			 -108, -108, -108, -108, -108, -108, -108, -108, -108, -108, yy_Dummy>>,
			1, 1000, 27000)
		end

	yy_nxt_template_29 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -108, -108, -108, -108, -108, -108, -108, -108, -108, -108,
			 -108, -108, -108,    5, -109, -109, -109, -109, -109, -109,
			 -109, -109, -109, -109, -109, -109, -109, -109, -109, -109,
			 -109, -109, -109, -109, -109, -109, -109, -109, -109, -109,
			 -109, -109, -109, -109, -109, -109, -109, -109, -109, -109,
			 -109, -109, -109, -109, -109, -109, -109, -109, -109, -109,
			 -109,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -109, -109, -109, -109, -109, -109, -109,  100,  228,
			  100,  100,  100,  229,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100, -109, -109, -109, -109,  100, -109,
			  100,  228,  100,  100,  100,  229,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -109, -109, -109, -109,
			 -109, -109, -109, -109, -109, -109, -109, -109, -109, -109,
			 -109, -109, -109, -109, -109, -109, -109, -109, -109, -109,
			 -109, -109, -109, -109, -109, -109, -109, -109, -109, -109,
			 -109, -109, -109, -109, -109, -109, -109, -109, -109, -109,
			 -109, -109, -109, -109, -109, -109, -109, -109, -109, -109,
			 -109, -109, -109, -109, -109, -109, -109, -109, -109, -109,

			 -109, -109, -109, -109, -109, -109, -109, -109, -109, -109,
			 -109, -109, -109, -109, -109, -109, -109, -109, -109, -109,
			 -109, -109, -109, -109, -109, -109, -109, -109, -109, -109,
			 -109, -109, -109, -109, -109, -109, -109, -109, -109, -109,
			 -109, -109, -109, -109, -109, -109, -109, -109, -109, -109,
			 -109, -109, -109, -109, -109, -109, -109, -109, -109, -109,
			 -109, -109, -109, -109, -109, -109, -109, -109, -109, -109,
			    5, -110, -110, -110, -110, -110, -110, -110, -110, -110,
			 -110, -110, -110, -110, -110, -110, -110, -110, -110, -110,
			 -110, -110, -110, -110, -110, -110, -110, -110, -110, -110,

			 -110, -110, -110, -110, -110, -110, -110, -110, -110, -110,
			 -110, -110, -110, -110, -110, -110, -110, -110,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -110, -110,
			 -110, -110, -110, -110, -110,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -110, -110, -110, -110,  100, -110,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -110, -110, -110, -110, -110, -110, -110,

			 -110, -110, -110, -110, -110, -110, -110, -110, -110, -110,
			 -110, -110, -110, -110, -110, -110, -110, -110, -110, -110,
			 -110, -110, -110, -110, -110, -110, -110, -110, -110, -110,
			 -110, -110, -110, -110, -110, -110, -110, -110, -110, -110,
			 -110, -110, -110, -110, -110, -110, -110, -110, -110, -110,
			 -110, -110, -110, -110, -110, -110, -110, -110, -110, -110,
			 -110, -110, -110, -110, -110, -110, -110, -110, -110, -110,
			 -110, -110, -110, -110, -110, -110, -110, -110, -110, -110,
			 -110, -110, -110, -110, -110, -110, -110, -110, -110, -110,
			 -110, -110, -110, -110, -110, -110, -110, -110, -110, -110,

			 -110, -110, -110, -110, -110, -110, -110, -110, -110, -110,
			 -110, -110, -110, -110, -110, -110, -110, -110, -110, -110,
			 -110, -110, -110, -110, -110, -110, -110,    5, -111, -111,
			 -111, -111, -111, -111, -111, -111, -111, -111, -111, -111,
			 -111, -111, -111, -111, -111, -111, -111, -111, -111, -111,
			 -111, -111, -111, -111, -111, -111, -111, -111, -111, -111,
			 -111, -111, -111, -111, -111, -111, -111, -111, -111, -111,
			 -111, -111, -111, -111, -111,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -111, -111, -111, -111, -111,
			 -111, -111,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  230,  100,  100,  100,  100,  100,  100,  100, -111, -111,
			 -111, -111,  100, -111,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  230,  100,  100,  100,  100,  100,  100,  100,
			 -111, -111, -111, -111, -111, -111, -111, -111, -111, -111,
			 -111, -111, -111, -111, -111, -111, -111, -111, -111, -111,
			 -111, -111, -111, -111, -111, -111, -111, -111, -111, -111,
			 -111, -111, -111, -111, -111, -111, -111, -111, -111, -111,
			 -111, -111, -111, -111, -111, -111, -111, -111, -111, -111,

			 -111, -111, -111, -111, -111, -111, -111, -111, -111, -111,
			 -111, -111, -111, -111, -111, -111, -111, -111, -111, -111,
			 -111, -111, -111, -111, -111, -111, -111, -111, -111, -111,
			 -111, -111, -111, -111, -111, -111, -111, -111, -111, -111,
			 -111, -111, -111, -111, -111, -111, -111, -111, -111, -111,
			 -111, -111, -111, -111, -111, -111, -111, -111, -111, -111,
			 -111, -111, -111, -111, -111, -111, -111, -111, -111, -111,
			 -111, -111, -111, -111, -111, -111, -111, -111, -111, -111,
			 -111, -111, -111, -111,    5, -112, -112, -112, -112, -112,
			 -112, -112, -112, -112, -112, -112, -112, -112, -112, -112,

			 -112, -112, -112, -112, -112, -112, -112, -112, -112, -112,
			 -112, -112, -112, -112, -112, -112, -112, -112, -112, -112,
			 -112, -112, -112, -112, -112, -112, -112, -112, -112, -112,
			 -112, -112,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -112, -112, -112, -112, -112, -112, -112,  100,
			  100,  100,  231,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  232,  100,  100,
			  100,  100,  100,  100,  100, -112, -112, -112, -112,  100,
			 -112,  100,  100,  100,  231,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  232,

			  100,  100,  100,  100,  100,  100,  100, -112, -112, -112,
			 -112, -112, -112, -112, -112, -112, -112, -112, -112, -112,
			 -112, -112, -112, -112, -112, -112, -112, -112, -112, -112,
			 -112, -112, -112, -112, -112, -112, -112, -112, -112, -112,
			 -112, -112, -112, -112, -112, -112, -112, -112, -112, -112,
			 -112, -112, -112, -112, -112, -112, -112, -112, -112, -112,
			 -112, -112, -112, -112, -112, -112, -112, -112, -112, -112,
			 -112, -112, -112, -112, -112, -112, -112, -112, -112, -112,
			 -112, -112, -112, -112, -112, -112, -112, -112, -112, -112,
			 -112, -112, -112, -112, -112, -112, -112, -112, -112, -112, yy_Dummy>>,
			1, 1000, 28000)
		end

	yy_nxt_template_30 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -112, -112, -112, -112, -112, -112, -112, -112, -112, -112,
			 -112, -112, -112, -112, -112, -112, -112, -112, -112, -112,
			 -112, -112, -112, -112, -112, -112, -112, -112, -112, -112,
			 -112, -112, -112, -112, -112, -112, -112, -112, -112, -112,
			 -112,    5, -113, -113, -113, -113, -113, -113, -113, -113,
			 -113, -113, -113, -113, -113, -113, -113, -113, -113, -113,
			 -113, -113, -113, -113, -113, -113, -113, -113, -113, -113,
			 -113, -113, -113, -113, -113, -113, -113, -113, -113, -113,
			 -113, -113, -113, -113, -113, -113, -113, -113, -113,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -113,

			 -113, -113, -113, -113, -113, -113,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  233,  100,  100,  100,  234,  100,  100,  100,  100,
			  100,  100, -113, -113, -113, -113,  100, -113,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  233,  100,  100,  100,  234,  100,  100,
			  100,  100,  100,  100, -113, -113, -113, -113, -113, -113,
			 -113, -113, -113, -113, -113, -113, -113, -113, -113, -113,
			 -113, -113, -113, -113, -113, -113, -113, -113, -113, -113,
			 -113, -113, -113, -113, -113, -113, -113, -113, -113, -113,

			 -113, -113, -113, -113, -113, -113, -113, -113, -113, -113,
			 -113, -113, -113, -113, -113, -113, -113, -113, -113, -113,
			 -113, -113, -113, -113, -113, -113, -113, -113, -113, -113,
			 -113, -113, -113, -113, -113, -113, -113, -113, -113, -113,
			 -113, -113, -113, -113, -113, -113, -113, -113, -113, -113,
			 -113, -113, -113, -113, -113, -113, -113, -113, -113, -113,
			 -113, -113, -113, -113, -113, -113, -113, -113, -113, -113,
			 -113, -113, -113, -113, -113, -113, -113, -113, -113, -113,
			 -113, -113, -113, -113, -113, -113, -113, -113, -113, -113,
			 -113, -113, -113, -113, -113, -113, -113, -113,    5, -114,

			 -114, -114, -114, -114, -114, -114, -114, -114, -114, -114,
			 -114, -114, -114, -114, -114, -114, -114, -114, -114, -114,
			 -114, -114, -114, -114, -114, -114, -114, -114, -114, -114,
			 -114, -114, -114, -114, -114, -114, -114, -114, -114, -114,
			 -114, -114, -114, -114, -114, -114,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -114, -114, -114, -114,
			 -114, -114, -114,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  235,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -114,
			 -114, -114, -114,  100, -114,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  235,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -114, -114, -114, -114, -114, -114, -114, -114, -114,
			 -114, -114, -114, -114, -114, -114, -114, -114, -114, -114,
			 -114, -114, -114, -114, -114, -114, -114, -114, -114, -114,
			 -114, -114, -114, -114, -114, -114, -114, -114, -114, -114,
			 -114, -114, -114, -114, -114, -114, -114, -114, -114, -114,
			 -114, -114, -114, -114, -114, -114, -114, -114, -114, -114,
			 -114, -114, -114, -114, -114, -114, -114, -114, -114, -114,
			 -114, -114, -114, -114, -114, -114, -114, -114, -114, -114,

			 -114, -114, -114, -114, -114, -114, -114, -114, -114, -114,
			 -114, -114, -114, -114, -114, -114, -114, -114, -114, -114,
			 -114, -114, -114, -114, -114, -114, -114, -114, -114, -114,
			 -114, -114, -114, -114, -114, -114, -114, -114, -114, -114,
			 -114, -114, -114, -114, -114, -114, -114, -114, -114, -114,
			 -114, -114, -114, -114, -114,    5, -115, -115, -115, -115,
			 -115, -115, -115, -115, -115, -115, -115, -115, -115, -115,
			 -115, -115, -115, -115, -115, -115, -115, -115, -115, -115,
			 -115, -115, -115, -115, -115, -115, -115, -115, -115, -115,
			 -115, -115, -115, -115, -115, -115, -115, -115, -115, -115,

			 -115, -115, -115,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -115, -115, -115, -115, -115, -115, -115,
			  236,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -115, -115, -115, -115,
			  100, -115,  236,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -115, -115,
			 -115, -115, -115, -115, -115, -115, -115, -115, -115, -115,
			 -115, -115, -115, -115, -115, -115, -115, -115, -115, -115,

			 -115, -115, -115, -115, -115, -115, -115, -115, -115, -115,
			 -115, -115, -115, -115, -115, -115, -115, -115, -115, -115,
			 -115, -115, -115, -115, -115, -115, -115, -115, -115, -115,
			 -115, -115, -115, -115, -115, -115, -115, -115, -115, -115,
			 -115, -115, -115, -115, -115, -115, -115, -115, -115, -115,
			 -115, -115, -115, -115, -115, -115, -115, -115, -115, -115,
			 -115, -115, -115, -115, -115, -115, -115, -115, -115, -115,
			 -115, -115, -115, -115, -115, -115, -115, -115, -115, -115,
			 -115, -115, -115, -115, -115, -115, -115, -115, -115, -115,
			 -115, -115, -115, -115, -115, -115, -115, -115, -115, -115,

			 -115, -115, -115, -115, -115, -115, -115, -115, -115, -115,
			 -115, -115,    5, -116, -116, -116, -116, -116, -116, -116,
			 -116, -116, -116, -116, -116, -116, -116, -116, -116, -116,
			 -116, -116, -116, -116, -116, -116, -116, -116, -116, -116,
			 -116, -116, -116, -116, -116, -116, -116, -116, -116, -116,
			 -116, -116, -116, -116, -116, -116, -116, -116, -116, -116,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -116, -116, -116, -116, -116, -116, -116,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  237,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100, -116, -116, -116, -116,  100, -116,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  237,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -116, -116, -116, -116, -116,
			 -116, -116, -116, -116, -116, -116, -116, -116, -116, -116,
			 -116, -116, -116, -116, -116, -116, -116, -116, -116, -116,
			 -116, -116, -116, -116, -116, -116, -116, -116, -116, -116,
			 -116, -116, -116, -116, -116, -116, -116, -116, -116, -116,
			 -116, -116, -116, -116, -116, -116, -116, -116, -116, -116,
			 -116, -116, -116, -116, -116, -116, -116, -116, -116, -116, yy_Dummy>>,
			1, 1000, 29000)
		end

	yy_nxt_template_31 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -116, -116, -116, -116, -116, -116, -116, -116, -116, -116,
			 -116, -116, -116, -116, -116, -116, -116, -116, -116, -116,
			 -116, -116, -116, -116, -116, -116, -116, -116, -116, -116,
			 -116, -116, -116, -116, -116, -116, -116, -116, -116, -116,
			 -116, -116, -116, -116, -116, -116, -116, -116, -116, -116,
			 -116, -116, -116, -116, -116, -116, -116, -116, -116, -116,
			 -116, -116, -116, -116, -116, -116, -116, -116, -116,    5,
			 -117, -117, -117, -117, -117, -117, -117, -117, -117, -117,
			 -117, -117, -117, -117, -117, -117, -117, -117, -117, -117,
			 -117, -117, -117, -117, -117, -117, -117, -117, -117, -117,

			 -117, -117, -117, -117, -117, -117, -117, -117, -117, -117,
			 -117, -117, -117, -117, -117, -117, -117,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -117, -117, -117,
			 -117, -117, -117, -117,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -117, -117, -117, -117,  100, -117,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -117, -117, -117, -117, -117, -117, -117, -117,

			 -117, -117, -117, -117, -117, -117, -117, -117, -117, -117,
			 -117, -117, -117, -117, -117, -117, -117, -117, -117, -117,
			 -117, -117, -117, -117, -117, -117, -117, -117, -117, -117,
			 -117, -117, -117, -117, -117, -117, -117, -117, -117, -117,
			 -117, -117, -117, -117, -117, -117, -117, -117, -117, -117,
			 -117, -117, -117, -117, -117, -117, -117, -117, -117, -117,
			 -117, -117, -117, -117, -117, -117, -117, -117, -117, -117,
			 -117, -117, -117, -117, -117, -117, -117, -117, -117, -117,
			 -117, -117, -117, -117, -117, -117, -117, -117, -117, -117,
			 -117, -117, -117, -117, -117, -117, -117, -117, -117, -117,

			 -117, -117, -117, -117, -117, -117, -117, -117, -117, -117,
			 -117, -117, -117, -117, -117, -117, -117, -117, -117, -117,
			 -117, -117, -117, -117, -117, -117,    5, -118, -118, -118,
			 -118, -118, -118, -118, -118, -118, -118, -118, -118, -118,
			 -118, -118, -118, -118, -118, -118, -118, -118, -118, -118,
			 -118, -118, -118, -118, -118, -118, -118, -118, -118, -118,
			 -118, -118, -118, -118, -118, -118, -118, -118, -118, -118,
			 -118, -118, -118, -118,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -118, -118, -118, -118, -118, -118,
			 -118,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  238,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -118, -118, -118,
			 -118,  100, -118,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  238,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -118,
			 -118, -118, -118, -118, -118, -118, -118, -118, -118, -118,
			 -118, -118, -118, -118, -118, -118, -118, -118, -118, -118,
			 -118, -118, -118, -118, -118, -118, -118, -118, -118, -118,
			 -118, -118, -118, -118, -118, -118, -118, -118, -118, -118,
			 -118, -118, -118, -118, -118, -118, -118, -118, -118, -118,

			 -118, -118, -118, -118, -118, -118, -118, -118, -118, -118,
			 -118, -118, -118, -118, -118, -118, -118, -118, -118, -118,
			 -118, -118, -118, -118, -118, -118, -118, -118, -118, -118,
			 -118, -118, -118, -118, -118, -118, -118, -118, -118, -118,
			 -118, -118, -118, -118, -118, -118, -118, -118, -118, -118,
			 -118, -118, -118, -118, -118, -118, -118, -118, -118, -118,
			 -118, -118, -118, -118, -118, -118, -118, -118, -118, -118,
			 -118, -118, -118, -118, -118, -118, -118, -118, -118, -118,
			 -118, -118, -118,    5, -119, -119, -119, -119, -119, -119,
			 -119, -119, -119, -119, -119, -119, -119, -119, -119, -119,

			 -119, -119, -119, -119, -119, -119, -119, -119, -119, -119,
			 -119, -119, -119, -119, -119, -119, -119, -119, -119, -119,
			 -119, -119, -119, -119, -119, -119, -119, -119, -119, -119,
			 -119,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -119, -119, -119, -119, -119, -119, -119,  100,  100,
			  100,  239,  100,  240,  100,  241,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  242,  100,  100,  243,
			  100,  100,  100,  100, -119, -119, -119, -119,  100, -119,
			  100,  100,  100,  239,  100,  240,  100,  241,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  242,  100,

			  100,  243,  100,  100,  100,  100, -119, -119, -119, -119,
			 -119, -119, -119, -119, -119, -119, -119, -119, -119, -119,
			 -119, -119, -119, -119, -119, -119, -119, -119, -119, -119,
			 -119, -119, -119, -119, -119, -119, -119, -119, -119, -119,
			 -119, -119, -119, -119, -119, -119, -119, -119, -119, -119,
			 -119, -119, -119, -119, -119, -119, -119, -119, -119, -119,
			 -119, -119, -119, -119, -119, -119, -119, -119, -119, -119,
			 -119, -119, -119, -119, -119, -119, -119, -119, -119, -119,
			 -119, -119, -119, -119, -119, -119, -119, -119, -119, -119,
			 -119, -119, -119, -119, -119, -119, -119, -119, -119, -119,

			 -119, -119, -119, -119, -119, -119, -119, -119, -119, -119,
			 -119, -119, -119, -119, -119, -119, -119, -119, -119, -119,
			 -119, -119, -119, -119, -119, -119, -119, -119, -119, -119,
			 -119, -119, -119, -119, -119, -119, -119, -119, -119, -119,
			    5, -120, -120, -120, -120, -120, -120, -120, -120, -120,
			 -120, -120, -120, -120, -120, -120, -120, -120, -120, -120,
			 -120, -120, -120, -120, -120, -120, -120, -120, -120, -120,
			 -120, -120, -120, -120, -120, -120, -120, -120, -120, -120,
			 -120, -120, -120, -120, -120, -120, -120, -120,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -120, -120,

			 -120, -120, -120, -120, -120,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -120, -120, -120, -120,  100, -120,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -120, -120, -120, -120, -120, -120, -120,
			 -120, -120, -120, -120, -120, -120, -120, -120, -120, -120,
			 -120, -120, -120, -120, -120, -120, -120, -120, -120, -120,
			 -120, -120, -120, -120, -120, -120, -120, -120, -120, -120, yy_Dummy>>,
			1, 1000, 30000)
		end

	yy_nxt_template_32 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -120, -120, -120, -120, -120, -120, -120, -120, -120, -120,
			 -120, -120, -120, -120, -120, -120, -120, -120, -120, -120,
			 -120, -120, -120, -120, -120, -120, -120, -120, -120, -120,
			 -120, -120, -120, -120, -120, -120, -120, -120, -120, -120,
			 -120, -120, -120, -120, -120, -120, -120, -120, -120, -120,
			 -120, -120, -120, -120, -120, -120, -120, -120, -120, -120,
			 -120, -120, -120, -120, -120, -120, -120, -120, -120, -120,
			 -120, -120, -120, -120, -120, -120, -120, -120, -120, -120,
			 -120, -120, -120, -120, -120, -120, -120, -120, -120, -120,
			 -120, -120, -120, -120, -120, -120, -120,    5, -121, -121,

			 -121, -121, -121, -121, -121, -121, -121, -121, -121, -121,
			 -121, -121, -121, -121, -121, -121, -121, -121, -121, -121,
			 -121, -121, -121, -121, -121, -121, -121, -121, -121, -121,
			 -121, -121, -121, -121, -121, -121, -121, -121, -121, -121,
			 -121, -121, -121, -121, -121,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -121, -121, -121, -121, -121,
			 -121, -121,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  244,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -121, -121,
			 -121, -121,  100, -121,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  244,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -121, -121, -121, -121, -121, -121, -121, -121, -121, -121,
			 -121, -121, -121, -121, -121, -121, -121, -121, -121, -121,
			 -121, -121, -121, -121, -121, -121, -121, -121, -121, -121,
			 -121, -121, -121, -121, -121, -121, -121, -121, -121, -121,
			 -121, -121, -121, -121, -121, -121, -121, -121, -121, -121,
			 -121, -121, -121, -121, -121, -121, -121, -121, -121, -121,
			 -121, -121, -121, -121, -121, -121, -121, -121, -121, -121,
			 -121, -121, -121, -121, -121, -121, -121, -121, -121, -121,

			 -121, -121, -121, -121, -121, -121, -121, -121, -121, -121,
			 -121, -121, -121, -121, -121, -121, -121, -121, -121, -121,
			 -121, -121, -121, -121, -121, -121, -121, -121, -121, -121,
			 -121, -121, -121, -121, -121, -121, -121, -121, -121, -121,
			 -121, -121, -121, -121, -121, -121, -121, -121, -121, -121,
			 -121, -121, -121, -121,    5, -122, -122, -122, -122, -122,
			 -122, -122, -122, -122, -122, -122, -122, -122, -122, -122,
			 -122, -122, -122, -122, -122, -122, -122, -122, -122, -122,
			 -122, -122, -122, -122, -122, -122, -122, -122, -122, -122,
			 -122, -122, -122, -122, -122, -122, -122, -122, -122, -122,

			 -122, -122,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -122, -122, -122, -122, -122, -122, -122,  100,
			  100,  245,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  246,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -122, -122, -122, -122,  100,
			 -122,  100,  100,  245,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  246,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -122, -122, -122,
			 -122, -122, -122, -122, -122, -122, -122, -122, -122, -122,
			 -122, -122, -122, -122, -122, -122, -122, -122, -122, -122,

			 -122, -122, -122, -122, -122, -122, -122, -122, -122, -122,
			 -122, -122, -122, -122, -122, -122, -122, -122, -122, -122,
			 -122, -122, -122, -122, -122, -122, -122, -122, -122, -122,
			 -122, -122, -122, -122, -122, -122, -122, -122, -122, -122,
			 -122, -122, -122, -122, -122, -122, -122, -122, -122, -122,
			 -122, -122, -122, -122, -122, -122, -122, -122, -122, -122,
			 -122, -122, -122, -122, -122, -122, -122, -122, -122, -122,
			 -122, -122, -122, -122, -122, -122, -122, -122, -122, -122,
			 -122, -122, -122, -122, -122, -122, -122, -122, -122, -122,
			 -122, -122, -122, -122, -122, -122, -122, -122, -122, -122,

			 -122, -122, -122, -122, -122, -122, -122, -122, -122, -122,
			 -122,    5, -123, -123, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123, -123, -123,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -123,
			 -123, -123, -123, -123, -123, -123,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  247,  100,  100,  100,  100,

			  100,  100, -123, -123, -123, -123,  100, -123,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  247,  100,  100,
			  100,  100,  100,  100, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123, -123, -123, -123,

			 -123, -123, -123, -123, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123, -123,    5, -124,
			 -124, -124, -124, -124, -124, -124, -124, -124, -124, -124,
			 -124, -124, -124, -124, -124, -124, -124, -124, -124, -124,
			 -124, -124, -124, -124, -124, -124, -124, -124, -124, -124,

			 -124, -124, -124, -124, -124, -124, -124, -124, -124, -124,
			 -124, -124, -124, -124, -124, -124,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -124, -124, -124, -124,
			 -124, -124, -124,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  248,  100,  100,  100,  100,  100,  100,  100, -124,
			 -124, -124, -124,  100, -124,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  248,  100,  100,  100,  100,  100,  100,
			  100, -124, -124, -124, -124, -124, -124, -124, -124, -124, yy_Dummy>>,
			1, 1000, 31000)
		end

	yy_nxt_template_33 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -124, -124, -124, -124, -124, -124, -124, -124, -124, -124,
			 -124, -124, -124, -124, -124, -124, -124, -124, -124, -124,
			 -124, -124, -124, -124, -124, -124, -124, -124, -124, -124,
			 -124, -124, -124, -124, -124, -124, -124, -124, -124, -124,
			 -124, -124, -124, -124, -124, -124, -124, -124, -124, -124,
			 -124, -124, -124, -124, -124, -124, -124, -124, -124, -124,
			 -124, -124, -124, -124, -124, -124, -124, -124, -124, -124,
			 -124, -124, -124, -124, -124, -124, -124, -124, -124, -124,
			 -124, -124, -124, -124, -124, -124, -124, -124, -124, -124,
			 -124, -124, -124, -124, -124, -124, -124, -124, -124, -124,

			 -124, -124, -124, -124, -124, -124, -124, -124, -124, -124,
			 -124, -124, -124, -124, -124, -124, -124, -124, -124, -124,
			 -124, -124, -124, -124, -124,    5, -125, -125, -125, -125,
			 -125, -125, -125, -125, -125, -125, -125, -125, -125, -125,
			 -125, -125, -125, -125, -125, -125, -125, -125, -125, -125,
			 -125, -125, -125, -125, -125, -125, -125, -125, -125, -125,
			 -125, -125, -125, -125, -125, -125, -125, -125, -125, -125,
			 -125, -125, -125,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -125, -125, -125, -125, -125, -125, -125,
			  100,  100,  100,  249,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -125, -125, -125, -125,
			  100, -125,  100,  100,  100,  249,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -125, -125,
			 -125, -125, -125, -125, -125, -125, -125, -125, -125, -125,
			 -125, -125, -125, -125, -125, -125, -125, -125, -125, -125,
			 -125, -125, -125, -125, -125, -125, -125, -125, -125, -125,
			 -125, -125, -125, -125, -125, -125, -125, -125, -125, -125,
			 -125, -125, -125, -125, -125, -125, -125, -125, -125, -125,

			 -125, -125, -125, -125, -125, -125, -125, -125, -125, -125,
			 -125, -125, -125, -125, -125, -125, -125, -125, -125, -125,
			 -125, -125, -125, -125, -125, -125, -125, -125, -125, -125,
			 -125, -125, -125, -125, -125, -125, -125, -125, -125, -125,
			 -125, -125, -125, -125, -125, -125, -125, -125, -125, -125,
			 -125, -125, -125, -125, -125, -125, -125, -125, -125, -125,
			 -125, -125, -125, -125, -125, -125, -125, -125, -125, -125,
			 -125, -125, -125, -125, -125, -125, -125, -125, -125, -125,
			 -125, -125,    5, -126, -126, -126, -126, -126, -126, -126,
			 -126, -126, -126, -126, -126, -126, -126, -126, -126, -126,

			 -126, -126, -126, -126, -126, -126, -126, -126, -126, -126,
			 -126, -126, -126, -126, -126, -126, -126, -126, -126, -126,
			 -126, -126, -126, -126, -126, -126, -126, -126, -126, -126,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -126, -126, -126, -126, -126, -126, -126,  100,  100,  250,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -126, -126, -126, -126,  100, -126,  100,
			  100,  250,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100, -126, -126, -126, -126, -126,
			 -126, -126, -126, -126, -126, -126, -126, -126, -126, -126,
			 -126, -126, -126, -126, -126, -126, -126, -126, -126, -126,
			 -126, -126, -126, -126, -126, -126, -126, -126, -126, -126,
			 -126, -126, -126, -126, -126, -126, -126, -126, -126, -126,
			 -126, -126, -126, -126, -126, -126, -126, -126, -126, -126,
			 -126, -126, -126, -126, -126, -126, -126, -126, -126, -126,
			 -126, -126, -126, -126, -126, -126, -126, -126, -126, -126,
			 -126, -126, -126, -126, -126, -126, -126, -126, -126, -126,
			 -126, -126, -126, -126, -126, -126, -126, -126, -126, -126,

			 -126, -126, -126, -126, -126, -126, -126, -126, -126, -126,
			 -126, -126, -126, -126, -126, -126, -126, -126, -126, -126,
			 -126, -126, -126, -126, -126, -126, -126, -126, -126, -126,
			 -126, -126, -126, -126, -126, -126, -126, -126, -126,    5,
			 -127, -127, -127, -127, -127, -127, -127, -127, -127, -127,
			 -127, -127, -127, -127, -127, -127, -127, -127, -127, -127,
			 -127, -127, -127, -127, -127, -127, -127, -127, -127, -127,
			 -127, -127, -127, -127, -127, -127, -127, -127, -127, -127,
			 -127, -127, -127, -127, -127, -127, -127,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -127, -127, -127,

			 -127, -127, -127, -127,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -127, -127, -127, -127,  100, -127,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -127, -127, -127, -127, -127, -127, -127, -127,
			 -127, -127, -127, -127, -127, -127, -127, -127, -127, -127,
			 -127, -127, -127, -127, -127, -127, -127, -127, -127, -127,
			 -127, -127, -127, -127, -127, -127, -127, -127, -127, -127,

			 -127, -127, -127, -127, -127, -127, -127, -127, -127, -127,
			 -127, -127, -127, -127, -127, -127, -127, -127, -127, -127,
			 -127, -127, -127, -127, -127, -127, -127, -127, -127, -127,
			 -127, -127, -127, -127, -127, -127, -127, -127, -127, -127,
			 -127, -127, -127, -127, -127, -127, -127, -127, -127, -127,
			 -127, -127, -127, -127, -127, -127, -127, -127, -127, -127,
			 -127, -127, -127, -127, -127, -127, -127, -127, -127, -127,
			 -127, -127, -127, -127, -127, -127, -127, -127, -127, -127,
			 -127, -127, -127, -127, -127, -127, -127, -127, -127, -127,
			 -127, -127, -127, -127, -127, -127,    5, -128, -128, -128,

			 -128, -128, -128, -128, -128, -128, -128, -128, -128, -128,
			 -128, -128, -128, -128, -128, -128, -128, -128, -128, -128,
			 -128, -128, -128, -128, -128, -128, -128, -128, -128, -128,
			 -128, -128, -128, -128, -128, -128, -128, -128, -128, -128,
			 -128, -128, -128, -128,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -128, -128, -128, -128, -128, -128,
			 -128,  100,  100,  100,  100,  251,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -128, -128, -128,
			 -128,  100, -128,  100,  100,  100,  100,  251,  100,  100, yy_Dummy>>,
			1, 1000, 32000)
		end

	yy_nxt_template_34 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -128,
			 -128, -128, -128, -128, -128, -128, -128, -128, -128, -128,
			 -128, -128, -128, -128, -128, -128, -128, -128, -128, -128,
			 -128, -128, -128, -128, -128, -128, -128, -128, -128, -128,
			 -128, -128, -128, -128, -128, -128, -128, -128, -128, -128,
			 -128, -128, -128, -128, -128, -128, -128, -128, -128, -128,
			 -128, -128, -128, -128, -128, -128, -128, -128, -128, -128,
			 -128, -128, -128, -128, -128, -128, -128, -128, -128, -128,
			 -128, -128, -128, -128, -128, -128, -128, -128, -128, -128,

			 -128, -128, -128, -128, -128, -128, -128, -128, -128, -128,
			 -128, -128, -128, -128, -128, -128, -128, -128, -128, -128,
			 -128, -128, -128, -128, -128, -128, -128, -128, -128, -128,
			 -128, -128, -128, -128, -128, -128, -128, -128, -128, -128,
			 -128, -128, -128, -128, -128, -128, -128, -128, -128, -128,
			 -128, -128, -128,    5, -129, -129, -129, -129, -129, -129,
			 -129, -129, -129, -129, -129, -129, -129, -129, -129, -129,
			 -129, -129, -129, -129, -129, -129, -129, -129, -129, -129,
			 -129, -129, -129, -129, -129, -129, -129, -129, -129, -129,
			 -129, -129, -129, -129, -129, -129, -129, -129, -129, -129,

			 -129,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -129, -129, -129, -129, -129, -129, -129,  100,  100,
			  100,  252,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  253,  100,  100,  254,  100,  255,  256,  100,  100,
			  100,  100,  100,  100, -129, -129, -129, -129,  100, -129,
			  100,  100,  100,  252,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  253,  100,  100,  254,  100,  255,  256,
			  100,  100,  100,  100,  100,  100, -129, -129, -129, -129,
			 -129, -129, -129, -129, -129, -129, -129, -129, -129, -129,
			 -129, -129, -129, -129, -129, -129, -129, -129, -129, -129,

			 -129, -129, -129, -129, -129, -129, -129, -129, -129, -129,
			 -129, -129, -129, -129, -129, -129, -129, -129, -129, -129,
			 -129, -129, -129, -129, -129, -129, -129, -129, -129, -129,
			 -129, -129, -129, -129, -129, -129, -129, -129, -129, -129,
			 -129, -129, -129, -129, -129, -129, -129, -129, -129, -129,
			 -129, -129, -129, -129, -129, -129, -129, -129, -129, -129,
			 -129, -129, -129, -129, -129, -129, -129, -129, -129, -129,
			 -129, -129, -129, -129, -129, -129, -129, -129, -129, -129,
			 -129, -129, -129, -129, -129, -129, -129, -129, -129, -129,
			 -129, -129, -129, -129, -129, -129, -129, -129, -129, -129,

			 -129, -129, -129, -129, -129, -129, -129, -129, -129, -129,
			    5, -130, -130, -130, -130, -130, -130, -130, -130, -130,
			 -130, -130, -130, -130, -130, -130, -130, -130, -130, -130,
			 -130, -130, -130, -130, -130, -130, -130, -130, -130, -130,
			 -130, -130, -130, -130, -130, -130, -130, -130, -130, -130,
			 -130, -130, -130, -130, -130, -130, -130, -130,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -130, -130,
			 -130, -130, -130, -130, -130,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  257,  100,  100,  100,
			  258,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100, -130, -130, -130, -130,  100, -130,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  257,  100,
			  100,  100,  258,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -130, -130, -130, -130, -130, -130, -130,
			 -130, -130, -130, -130, -130, -130, -130, -130, -130, -130,
			 -130, -130, -130, -130, -130, -130, -130, -130, -130, -130,
			 -130, -130, -130, -130, -130, -130, -130, -130, -130, -130,
			 -130, -130, -130, -130, -130, -130, -130, -130, -130, -130,
			 -130, -130, -130, -130, -130, -130, -130, -130, -130, -130,
			 -130, -130, -130, -130, -130, -130, -130, -130, -130, -130,

			 -130, -130, -130, -130, -130, -130, -130, -130, -130, -130,
			 -130, -130, -130, -130, -130, -130, -130, -130, -130, -130,
			 -130, -130, -130, -130, -130, -130, -130, -130, -130, -130,
			 -130, -130, -130, -130, -130, -130, -130, -130, -130, -130,
			 -130, -130, -130, -130, -130, -130, -130, -130, -130, -130,
			 -130, -130, -130, -130, -130, -130, -130, -130, -130, -130,
			 -130, -130, -130, -130, -130, -130, -130,    5, -131, -131,
			 -131, -131, -131, -131, -131, -131, -131, -131, -131, -131,
			 -131, -131, -131, -131, -131, -131, -131, -131, -131, -131,
			 -131, -131, -131, -131, -131, -131, -131, -131, -131, -131,

			 -131, -131, -131, -131, -131, -131, -131, -131, -131, -131,
			 -131, -131, -131, -131, -131,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -131, -131, -131, -131, -131,
			 -131, -131,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  259,
			  100,  100,  100,  100,  100,  100,  100,  100, -131, -131,
			 -131, -131,  100, -131,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  259,  100,  100,  100,  100,  100,  100,  100,  100,
			 -131, -131, -131, -131, -131, -131, -131, -131, -131, -131,

			 -131, -131, -131, -131, -131, -131, -131, -131, -131, -131,
			 -131, -131, -131, -131, -131, -131, -131, -131, -131, -131,
			 -131, -131, -131, -131, -131, -131, -131, -131, -131, -131,
			 -131, -131, -131, -131, -131, -131, -131, -131, -131, -131,
			 -131, -131, -131, -131, -131, -131, -131, -131, -131, -131,
			 -131, -131, -131, -131, -131, -131, -131, -131, -131, -131,
			 -131, -131, -131, -131, -131, -131, -131, -131, -131, -131,
			 -131, -131, -131, -131, -131, -131, -131, -131, -131, -131,
			 -131, -131, -131, -131, -131, -131, -131, -131, -131, -131,
			 -131, -131, -131, -131, -131, -131, -131, -131, -131, -131,

			 -131, -131, -131, -131, -131, -131, -131, -131, -131, -131,
			 -131, -131, -131, -131, -131, -131, -131, -131, -131, -131,
			 -131, -131, -131, -131,    5, -132, -132, -132, -132, -132,
			 -132, -132, -132, -132, -132, -132, -132, -132, -132, -132,
			 -132, -132, -132, -132, -132, -132, -132, -132, -132, -132,
			 -132, -132, -132, -132, -132, -132, -132, -132, -132, -132,
			 -132, -132, -132, -132, -132, -132, -132, -132, -132, -132,
			 -132, -132,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -132, -132, -132, -132, -132, -132, -132,  100,
			  100,  100,  100,  260,  100,  100,  100,  100,  100,  100, yy_Dummy>>,
			1, 1000, 33000)
		end

	yy_nxt_template_35 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -132, -132, -132, -132,  100,
			 -132,  100,  100,  100,  100,  260,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -132, -132, -132,
			 -132, -132, -132, -132, -132, -132, -132, -132, -132, -132,
			 -132, -132, -132, -132, -132, -132, -132, -132, -132, -132,
			 -132, -132, -132, -132, -132, -132, -132, -132, -132, -132,
			 -132, -132, -132, -132, -132, -132, -132, -132, -132, -132,
			 -132, -132, -132, -132, -132, -132, -132, -132, -132, -132,

			 -132, -132, -132, -132, -132, -132, -132, -132, -132, -132,
			 -132, -132, -132, -132, -132, -132, -132, -132, -132, -132,
			 -132, -132, -132, -132, -132, -132, -132, -132, -132, -132,
			 -132, -132, -132, -132, -132, -132, -132, -132, -132, -132,
			 -132, -132, -132, -132, -132, -132, -132, -132, -132, -132,
			 -132, -132, -132, -132, -132, -132, -132, -132, -132, -132,
			 -132, -132, -132, -132, -132, -132, -132, -132, -132, -132,
			 -132, -132, -132, -132, -132, -132, -132, -132, -132, -132,
			 -132,    5, -133, -133, -133, -133, -133, -133, -133, -133,
			 -133, -133, -133, -133, -133, -133, -133, -133, -133, -133,

			 -133, -133, -133, -133, -133, -133, -133, -133, -133, -133,
			 -133, -133, -133, -133, -133, -133, -133, -133, -133, -133,
			 -133, -133, -133, -133, -133, -133, -133, -133, -133,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -133,
			 -133, -133, -133, -133, -133, -133,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  261,  100,  100,  100,
			  100,  100, -133, -133, -133, -133,  100, -133,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  261,  100,

			  100,  100,  100,  100, -133, -133, -133, -133, -133, -133,
			 -133, -133, -133, -133, -133, -133, -133, -133, -133, -133,
			 -133, -133, -133, -133, -133, -133, -133, -133, -133, -133,
			 -133, -133, -133, -133, -133, -133, -133, -133, -133, -133,
			 -133, -133, -133, -133, -133, -133, -133, -133, -133, -133,
			 -133, -133, -133, -133, -133, -133, -133, -133, -133, -133,
			 -133, -133, -133, -133, -133, -133, -133, -133, -133, -133,
			 -133, -133, -133, -133, -133, -133, -133, -133, -133, -133,
			 -133, -133, -133, -133, -133, -133, -133, -133, -133, -133,
			 -133, -133, -133, -133, -133, -133, -133, -133, -133, -133,

			 -133, -133, -133, -133, -133, -133, -133, -133, -133, -133,
			 -133, -133, -133, -133, -133, -133, -133, -133, -133, -133,
			 -133, -133, -133, -133, -133, -133, -133, -133, -133, -133,
			 -133, -133, -133, -133, -133, -133, -133, -133,    5, -134,
			 -134, -134, -134, -134, -134, -134, -134, -134, -134, -134,
			 -134, -134, -134, -134, -134, -134, -134, -134, -134, -134,
			 -134, -134, -134, -134, -134, -134, -134, -134, -134, -134,
			 -134, -134, -134, -134, -134, -134, -134, -134, -134, -134,
			 -134, -134, -134, -134, -134, -134,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -134, -134, -134, -134,

			 -134, -134, -134,  100,  100,  100,  262,  100,  100,  100,
			  100,  263,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  264,  100,  100,  100,  100,  100,  100, -134,
			 -134, -134, -134,  100, -134,  100,  100,  100,  262,  100,
			  100,  100,  100,  263,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  264,  100,  100,  100,  100,  100,
			  100, -134, -134, -134, -134, -134, -134, -134, -134, -134,
			 -134, -134, -134, -134, -134, -134, -134, -134, -134, -134,
			 -134, -134, -134, -134, -134, -134, -134, -134, -134, -134,
			 -134, -134, -134, -134, -134, -134, -134, -134, -134, -134,

			 -134, -134, -134, -134, -134, -134, -134, -134, -134, -134,
			 -134, -134, -134, -134, -134, -134, -134, -134, -134, -134,
			 -134, -134, -134, -134, -134, -134, -134, -134, -134, -134,
			 -134, -134, -134, -134, -134, -134, -134, -134, -134, -134,
			 -134, -134, -134, -134, -134, -134, -134, -134, -134, -134,
			 -134, -134, -134, -134, -134, -134, -134, -134, -134, -134,
			 -134, -134, -134, -134, -134, -134, -134, -134, -134, -134,
			 -134, -134, -134, -134, -134, -134, -134, -134, -134, -134,
			 -134, -134, -134, -134, -134, -134, -134, -134, -134, -134,
			 -134, -134, -134, -134, -134,    5, -135, -135, -135, -135,

			 -135, -135, -135, -135, -135, -135, -135, -135, -135, -135,
			 -135, -135, -135, -135, -135, -135, -135, -135, -135, -135,
			 -135, -135, -135, -135, -135, -135, -135, -135, -135, -135,
			 -135, -135, -135, -135, -135, -135, -135, -135, -135, -135,
			 -135, -135, -135,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -135, -135, -135, -135, -135, -135, -135,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  265,  100,  100,
			  100,  100,  100,  100,  100,  100, -135, -135, -135, -135,
			  100, -135,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  265,
			  100,  100,  100,  100,  100,  100,  100,  100, -135, -135,
			 -135, -135, -135, -135, -135, -135, -135, -135, -135, -135,
			 -135, -135, -135, -135, -135, -135, -135, -135, -135, -135,
			 -135, -135, -135, -135, -135, -135, -135, -135, -135, -135,
			 -135, -135, -135, -135, -135, -135, -135, -135, -135, -135,
			 -135, -135, -135, -135, -135, -135, -135, -135, -135, -135,
			 -135, -135, -135, -135, -135, -135, -135, -135, -135, -135,
			 -135, -135, -135, -135, -135, -135, -135, -135, -135, -135,
			 -135, -135, -135, -135, -135, -135, -135, -135, -135, -135,

			 -135, -135, -135, -135, -135, -135, -135, -135, -135, -135,
			 -135, -135, -135, -135, -135, -135, -135, -135, -135, -135,
			 -135, -135, -135, -135, -135, -135, -135, -135, -135, -135,
			 -135, -135, -135, -135, -135, -135, -135, -135, -135, -135,
			 -135, -135, -135, -135, -135, -135, -135, -135, -135, -135,
			 -135, -135,    5, -136, -136, -136, -136, -136, -136, -136,
			 -136, -136, -136, -136, -136, -136, -136, -136, -136, -136,
			 -136, -136, -136, -136, -136, -136, -136, -136, -136, -136,
			 -136, -136, -136, -136, -136, -136, -136, -136, -136, -136,
			 -136, -136, -136, -136, -136, -136, -136, -136, -136, -136, yy_Dummy>>,
			1, 1000, 34000)
		end

	yy_nxt_template_36 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -136, -136, -136, -136, -136, -136, -136,  100,  100,  100,
			  100,  266,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -136, -136, -136, -136,  100, -136,  100,
			  100,  100,  100,  266,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -136, -136, -136, -136, -136,
			 -136, -136, -136, -136, -136, -136, -136, -136, -136, -136,
			 -136, -136, -136, -136, -136, -136, -136, -136, -136, -136,

			 -136, -136, -136, -136, -136, -136, -136, -136, -136, -136,
			 -136, -136, -136, -136, -136, -136, -136, -136, -136, -136,
			 -136, -136, -136, -136, -136, -136, -136, -136, -136, -136,
			 -136, -136, -136, -136, -136, -136, -136, -136, -136, -136,
			 -136, -136, -136, -136, -136, -136, -136, -136, -136, -136,
			 -136, -136, -136, -136, -136, -136, -136, -136, -136, -136,
			 -136, -136, -136, -136, -136, -136, -136, -136, -136, -136,
			 -136, -136, -136, -136, -136, -136, -136, -136, -136, -136,
			 -136, -136, -136, -136, -136, -136, -136, -136, -136, -136,
			 -136, -136, -136, -136, -136, -136, -136, -136, -136, -136,

			 -136, -136, -136, -136, -136, -136, -136, -136, -136,    5,
			 -137, -137, -137, -137, -137, -137, -137, -137, -137, -137,
			 -137, -137, -137, -137, -137, -137, -137, -137, -137, -137,
			 -137, -137, -137, -137, -137, -137, -137, -137, -137, -137,
			 -137, -137, -137, -137, -137, -137, -137, -137, -137, -137,
			 -137, -137, -137, -137, -137, -137, -137,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -137, -137, -137,
			 -137, -137, -137, -137,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  267,  100,  100,  100,  100,  100,  100,  100,  100,

			 -137, -137, -137, -137,  100, -137,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  267,  100,  100,  100,  100,  100,  100,
			  100,  100, -137, -137, -137, -137, -137, -137, -137, -137,
			 -137, -137, -137, -137, -137, -137, -137, -137, -137, -137,
			 -137, -137, -137, -137, -137, -137, -137, -137, -137, -137,
			 -137, -137, -137, -137, -137, -137, -137, -137, -137, -137,
			 -137, -137, -137, -137, -137, -137, -137, -137, -137, -137,
			 -137, -137, -137, -137, -137, -137, -137, -137, -137, -137,
			 -137, -137, -137, -137, -137, -137, -137, -137, -137, -137,

			 -137, -137, -137, -137, -137, -137, -137, -137, -137, -137,
			 -137, -137, -137, -137, -137, -137, -137, -137, -137, -137,
			 -137, -137, -137, -137, -137, -137, -137, -137, -137, -137,
			 -137, -137, -137, -137, -137, -137, -137, -137, -137, -137,
			 -137, -137, -137, -137, -137, -137, -137, -137, -137, -137,
			 -137, -137, -137, -137, -137, -137, -137, -137, -137, -137,
			 -137, -137, -137, -137, -137, -137,    5, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,

			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,

			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,

			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138, -138, -138, -138, -138, -138, -138, -138,
			 -138, -138, -138,    5, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139,  139,  139,  139,  139,  139,  139,  139,  139,  139,
			  139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,

			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139,  139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,

			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			 -139, -139, -139, -139, -139, -139, -139, -139, -139, -139,
			    5,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			 -140,  140,  140,  140,  140,  140,  140,  140,  140,  140, yy_Dummy>>,
			1, 1000, 35000)
		end

	yy_nxt_template_37 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  141,  140,  140, -140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,

			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,

			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,    5, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,

			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,

			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141, -141, -141, -141, -141, -141, -141,
			 -141, -141, -141, -141,    5, -142, -142, -142, -142, -142,

			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,

			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,

			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142, -142, -142, -142, -142, -142, -142, -142, -142, -142,
			 -142,    5, -143, -143, -143, -143, -143, -143, -143, -143,
			  268,  144, -143, -143,  268, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143,  268, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,

			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,

			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143,
			 -143, -143, -143, -143, -143, -143, -143, -143, -143, -143, yy_Dummy>>,
			1, 1000, 36000)
		end

	yy_nxt_template_38 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -143, -143, -143, -143, -143, -143, -143, -143,    5, -144,
			 -144, -144, -144, -144, -144, -144, -144,  144, -144, -144,
			 -144,  144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			  144, -144, -144, -144, -144,  269, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,

			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,

			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144, -144, -144, -144, -144, -144,
			 -144, -144, -144, -144, -144,    5, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,

			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,

			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,

			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145, -145, -145, -145, -145, -145, -145, -145, -145,
			 -145, -145,    5, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,

			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,

			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146, -146,
			 -146, -146, -146, -146, -146, -146, -146, -146, -146,    5,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,

			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,

			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147, yy_Dummy>>,
			1, 1000, 37000)
		end

	yy_nxt_template_39 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147, -147, -147, -147, -147,
			 -147, -147, -147, -147, -147, -147,    5, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,

			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,

			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148, -148, -148, -148, -148, -148, -148, -148,
			 -148, -148, -148,    5, -149, -149, -149, -149, -149, -149,

			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,

			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,

			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			 -149, -149, -149, -149, -149, -149, -149, -149, -149, -149,
			    5, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150,  270,  270,

			  270,  270,  270,  270,  270,  270,  270,  270, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,

			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,
			 -150, -150, -150, -150, -150, -150, -150, -150, -150, -150,

			 -150, -150, -150, -150, -150, -150, -150,    5, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,

			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151, yy_Dummy>>,
			1, 1000, 38000)
		end

	yy_nxt_template_40 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151, -151, -151, -151, -151, -151, -151,
			 -151, -151, -151, -151,    5, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,

			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,

			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,

			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152, -152, -152, -152, -152, -152, -152, -152, -152, -152,
			 -152,    5, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,

			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,

			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153,    5, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,

			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,

			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,

			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154,    5, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,

			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155, yy_Dummy>>,
			1, 1000, 39000)
		end

	yy_nxt_template_41 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155,    5, -156, -156, -156, -156, -156, -156, -156,

			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,

			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,

			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156,    5,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,

			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,

			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,

			 -157, -157, -157, -157, -157, -157,    5, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,

			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,

			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158, -158, -158, -158, -158, -158, -158, -158,
			 -158, -158, -158,    5, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,

			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159, yy_Dummy>>,
			1, 1000, 40000)
		end

	yy_nxt_template_42 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,

			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			 -159, -159, -159, -159, -159, -159, -159, -159, -159, -159,
			    5, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,

			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,

			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160, -160, -160, -160,
			 -160, -160, -160, -160, -160, -160, -160,    5, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,

			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,

			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,

			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161, -161, -161, -161, -161, -161, -161,
			 -161, -161, -161, -161,    5, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,

			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,

			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162, -162, -162, -162, -162, -162, -162, -162, -162, -162,
			 -162,    5, -163, -163, -163, -163, -163, -163, -163, -163,

			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163, yy_Dummy>>,
			1, 1000, 41000)
		end

	yy_nxt_template_43 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,

			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163, -163, -163,
			 -163, -163, -163, -163, -163, -163, -163, -163,    5, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,

			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,

			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,
			 -164, -164, -164, -164, -164, -164, -164, -164, -164, -164,

			 -164, -164, -164, -164, -164,    5, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,

			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,

			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165, -165, -165, -165, -165, -165, -165, -165, -165,
			 -165, -165,    5, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,

			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,

			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,

			 -166, -166, -166, -166, -166, -166, -166, -166, -166, -166,
			 -166, -166, -166, -166, -166, -166, -166, -166, -166,    5,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167, yy_Dummy>>,
			1, 1000, 42000)
		end

	yy_nxt_template_44 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,

			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167, -167, -167, -167, -167,
			 -167, -167, -167, -167, -167, -167,    5, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,

			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,

			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,

			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168, -168, -168, -168, -168, -168, -168, -168,
			 -168, -168, -168,    5, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,

			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,

			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			 -169, -169, -169, -169, -169, -169, -169, -169, -169, -169,
			    5, -170, -170, -170, -170, -170, -170, -170, -170, -170,

			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,

			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,

			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170, -170, -170, -170,
			 -170, -170, -170, -170, -170, -170, -170,    5, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171, yy_Dummy>>,
			1, 1000, 43000)
		end

	yy_nxt_template_45 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,

			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,
			 -171, -171, -171, -171, -171, -171, -171, -171, -171, -171,

			 -171, -171, -171, -171,    5,   63,   63,   63,   63,   63,
			   63,   63,   63,   63, -172,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,  271,   63,
			   63, -172,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,    5, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,

			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,

			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,

			 -173, -173, -173, -173, -173, -173, -173, -173, -173, -173,
			 -173, -173, -173, -173, -173, -173, -173, -173,    5,   63,
			   63,   63,   63,   63,   63,   63,   63,   63, -174,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,  272,   63,   63, -174,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,    5, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175, yy_Dummy>>,
			1, 1000, 44000)
		end

	yy_nxt_template_46 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,

			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,

			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175, -175, -175, -175, -175, -175, -175, -175, -175,
			 -175, -175,    5,   63,   63,   63,   63,   63,   63,   63,
			   63,   63, -176,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,  273,   63,   63, -176,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,    5,
			   63,   63,   63,   63,   63,   63,   63,   63,   63, -177,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   64,   63,   63, -177,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,  274,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,  274,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,    5,   63,   63,   63,
			   63,   63,   63,   63,   63,   63, -178,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   64,   63,   63, -178,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,  275,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,  275,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63, yy_Dummy>>,
			1, 1000, 45000)
		end

	yy_nxt_template_47 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			   63,   63,   63,    5,   63,   63,   63,   63,   63,   63,
			   63,   63,   63, -179,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   64,   63,   63,
			 -179,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,  276,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,  276,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			    5,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			 -180,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,  277,   63,  278,   63,   63, -180,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,    5,   63,   63,
			   63,   63,   63,   63,   63,   63,   63, -181,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   64,   63,   63, -181,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,  279,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,  279,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,    5,   63,   63,   63,   63,   63,
			   63,   63,   63,   63, -182,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,  280,   63,
			   63, -182,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63, yy_Dummy>>,
			1, 1000, 46000)
		end

	yy_nxt_template_48 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,    5, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,

			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,

			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183, -183, -183,
			 -183, -183, -183, -183, -183, -183, -183, -183,    5, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,

			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,

			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,

			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184, -184, -184, -184, -184, -184,
			 -184, -184, -184, -184, -184,    5, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,

			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,

			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,
			 -185, -185, -185, -185, -185, -185, -185, -185, -185, -185,

			 -185, -185,    5, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186,  281, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,

			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186, yy_Dummy>>,
			1, 1000, 47000)
		end

	yy_nxt_template_49 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186, -186,
			 -186, -186, -186, -186, -186, -186, -186, -186, -186,    5,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187,  282, -187,

			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,

			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,

			 -187, -187, -187, -187, -187, -187, -187, -187, -187, -187,
			 -187, -187, -187, -187, -187, -187,    5, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188,  283, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,

			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,

			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188, -188, -188, -188, -188, -188, -188, -188,
			 -188, -188, -188,    5, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,

			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189,  284, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,

			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,

			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			 -189, -189, -189, -189, -189, -189, -189, -189, -189, -189,
			    5, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190,  285,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,

			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190, yy_Dummy>>,
			1, 1000, 48000)
		end

	yy_nxt_template_50 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190, -190, -190, -190,
			 -190, -190, -190, -190, -190, -190, -190,    5, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,

			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191,  286, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,

			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,

			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191, -191, -191, -191, -191, -191, -191,
			 -191, -191, -191, -191,    5, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192,  281, -192, -192, -192, -192, -192, -192,
			 -192, -192,  287,  287,  287,  287,  287,  287,  287,  287,

			  287,  287, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,

			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,
			 -192, -192, -192, -192, -192, -192, -192, -192, -192, -192,

			 -192,    5, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			  288, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,

			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,

			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193, -193, -193,
			 -193, -193, -193, -193, -193, -193, -193, -193,    5, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194,  289, -194, -194,

			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194, yy_Dummy>>,
			1, 1000, 49000)
		end

	yy_nxt_template_51 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,

			 -194, -194, -194, -194, -194, -194, -194, -194, -194, -194,
			 -194, -194, -194, -194, -194,    5, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195,  290, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,

			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,

			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195, -195, -195, -195, -195, -195, -195, -195, -195,
			 -195, -195,    5, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,

			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196,  291, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,

			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,

			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196, -196,
			 -196, -196, -196, -196, -196, -196, -196, -196, -196,    5,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197,  292, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,

			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,

			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197, -197, -197, -197, -197,
			 -197, -197, -197, -197, -197, -197,    5, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,

			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198,  293, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198, yy_Dummy>>,
			1, 1000, 50000)
		end

	yy_nxt_template_52 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,

			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198, -198, -198, -198, -198, -198, -198, -198,
			 -198, -198, -198,    5, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199,  294, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,

			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,

			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,
			 -199, -199, -199, -199, -199, -199, -199, -199, -199, -199,

			    5, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200,  295,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,

			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,

			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200, -200, -200, -200,
			 -200, -200, -200, -200, -200, -200, -200,    5, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201,  296, -201, -201, -201,

			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,

			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,

			 -201, -201, -201, -201, -201, -201, -201, -201, -201, -201,
			 -201, -201, -201, -201,    5, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202,  297, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202, yy_Dummy>>,
			1, 1000, 51000)
		end

	yy_nxt_template_53 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,

			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202, -202, -202, -202, -202, -202, -202, -202, -202, -202,
			 -202,    5, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,

			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			  298, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,

			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,

			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203, -203, -203,
			 -203, -203, -203, -203, -203, -203, -203, -203,    5, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204,  299, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,

			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,

			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204, -204, -204, -204, -204, -204,
			 -204, -204, -204, -204, -204,    5, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,

			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205,  300, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,

			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,

			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205, -205, -205, -205, -205, -205, -205, -205, -205,
			 -205, -205,    5, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206,  301, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206, yy_Dummy>>,
			1, 1000, 52000)
		end

	yy_nxt_template_54 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,

			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206, -206,
			 -206, -206, -206, -206, -206, -206, -206, -206, -206,    5,

			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207,  302, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,

			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,

			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207, -207, -207, -207, -207,
			 -207, -207, -207, -207, -207, -207,    5, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208,  303, -208, -208, -208, -208,

			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,

			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,

			 -208, -208, -208, -208, -208, -208, -208, -208, -208, -208,
			 -208, -208, -208,    5, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,

			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,

			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			 -209, -209, -209, -209, -209, -209, -209, -209, -209, -209,
			    5, -210, -210, -210, -210, -210, -210, -210, -210,  210,
			 -210, -210, -210,  210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210, yy_Dummy>>,
			1, 1000, 53000)
		end

	yy_nxt_template_55 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -210, -210,  210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,

			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,

			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210, -210, -210, -210,
			 -210, -210, -210, -210, -210, -210, -210,    5, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211,  304,  304,  304,  304,  304,
			  304,  304,  304,  304,  304, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211,  212, -211, -211, -211,

			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211,  213, -211, -211, -211, -211, -211,  212, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,

			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211, -211, -211, -211, -211, -211, -211,
			 -211, -211, -211, -211,    5, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,

			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212,  305, -212,  305,
			 -212, -212,  306,  306,  306,  306,  306,  306,  306,  306,
			  306,  306, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,

			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,

			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212, -212, -212, -212, -212, -212, -212, -212, -212, -212,
			 -212,    5, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213,  307,
			  307,  307,  307,  307,  307,  307,  307,  307,  307, -213,

			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,

			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213, -213, -213,
			 -213, -213, -213, -213, -213, -213, -213, -213,    5, -214, yy_Dummy>>,
			1, 1000, 54000)
		end

	yy_nxt_template_56 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,

			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,

			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214, -214, -214, -214, -214, -214,
			 -214, -214, -214, -214, -214,    5, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,

			 -215, -215, -215,  308,  308,  308,  308,  308,  308,  308,
			  308,  308,  308, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215,  309, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			  310, -215, -215, -215, -215, -215,  309, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,

			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,

			 -215, -215, -215, -215, -215, -215, -215, -215, -215, -215,
			 -215, -215,    5, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216,  311, -216,  311, -216, -216,
			  312,  312,  312,  312,  312,  312,  312,  312,  312,  312,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,

			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,

			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216, -216,
			 -216, -216, -216, -216, -216, -216, -216, -216, -216,    5,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,

			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217,   89, -217,  313,  313,  314,
			  314,  314,  314,  314,  314,  314,  314, -217, -217, -217,
			 -217, -217, -217, -217, -217,   92, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217,   93, -217, -217,   92, -217, -217,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,

			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217, yy_Dummy>>,
			1, 1000, 55000)
		end

	yy_nxt_template_57 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217, -217, -217, -217, -217, -217,
			 -217, -217, -217, -217, -217, -217,    5, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218,   89, -218,  314,  314,  314,  314,  314,  314,
			  314,  314,  314,  314, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,

			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218,   93, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,

			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218,    5, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,

			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219,  315,  315,  315,  315,  315,  315,  315,  315,  315,
			  315, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219,  139, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,

			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,

			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			 -219, -219, -219, -219, -219, -219, -219, -219, -219, -219,
			    5, -220, -220, -220, -220, -220, -220, -220, -220, -220,
			 -220, -220, -220, -220, -220, -220, -220, -220, -220, -220,
			 -220, -220, -220, -220, -220, -220, -220, -220, -220, -220,
			 -220, -220, -220, -220, -220, -220, -220, -220, -220, -220,
			 -220, -220, -220, -220, -220, -220, -220, -220,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -220, -220,

			 -220, -220, -220, -220, -220,  316,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -220, -220, -220, -220,  100, -220,  316,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -220, -220, -220, -220, -220, -220, -220,
			 -220, -220, -220, -220, -220, -220, -220, -220, -220, -220,
			 -220, -220, -220, -220, -220, -220, -220, -220, -220, -220,
			 -220, -220, -220, -220, -220, -220, -220, -220, -220, -220,

			 -220, -220, -220, -220, -220, -220, -220, -220, -220, -220,
			 -220, -220, -220, -220, -220, -220, -220, -220, -220, -220,
			 -220, -220, -220, -220, -220, -220, -220, -220, -220, -220,
			 -220, -220, -220, -220, -220, -220, -220, -220, -220, -220,
			 -220, -220, -220, -220, -220, -220, -220, -220, -220, -220,
			 -220, -220, -220, -220, -220, -220, -220, -220, -220, -220,
			 -220, -220, -220, -220, -220, -220, -220, -220, -220, -220,
			 -220, -220, -220, -220, -220, -220, -220, -220, -220, -220,
			 -220, -220, -220, -220, -220, -220, -220, -220, -220, -220,
			 -220, -220, -220, -220, -220, -220, -220,    5, -221, -221,

			 -221, -221, -221, -221, -221, -221, -221, -221, -221, -221,
			 -221, -221, -221, -221, -221, -221, -221, -221, -221, -221,
			 -221, -221, -221, -221, -221, -221, -221, -221, -221, -221,
			 -221, -221, -221, -221, -221, -221, -221, -221, -221, -221,
			 -221, -221, -221, -221, -221,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -221, -221, -221, -221, -221,
			 -221, -221,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -221, -221,
			 -221, -221,  100, -221,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -221, -221, -221, -221, -221, -221, -221, -221, -221, -221,
			 -221, -221, -221, -221, -221, -221, -221, -221, -221, -221,
			 -221, -221, -221, -221, -221, -221, -221, -221, -221, -221,
			 -221, -221, -221, -221, -221, -221, -221, -221, -221, -221,
			 -221, -221, -221, -221, -221, -221, -221, -221, -221, -221,
			 -221, -221, -221, -221, -221, -221, -221, -221, -221, -221,
			 -221, -221, -221, -221, -221, -221, -221, -221, -221, -221,
			 -221, -221, -221, -221, -221, -221, -221, -221, -221, -221, yy_Dummy>>,
			1, 1000, 56000)
		end

	yy_nxt_template_58 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -221, -221, -221, -221, -221, -221, -221, -221, -221, -221,
			 -221, -221, -221, -221, -221, -221, -221, -221, -221, -221,
			 -221, -221, -221, -221, -221, -221, -221, -221, -221, -221,
			 -221, -221, -221, -221, -221, -221, -221, -221, -221, -221,
			 -221, -221, -221, -221, -221, -221, -221, -221, -221, -221,
			 -221, -221, -221, -221,    5, -222, -222, -222, -222, -222,
			 -222, -222, -222, -222, -222, -222, -222, -222, -222, -222,
			 -222, -222, -222, -222, -222, -222, -222, -222, -222, -222,
			 -222, -222, -222, -222, -222, -222, -222, -222, -222, -222,
			 -222, -222, -222, -222, -222, -222, -222, -222, -222, -222,

			 -222, -222,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -222, -222, -222, -222, -222, -222, -222,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -222, -222, -222, -222,  100,
			 -222,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -222, -222, -222,
			 -222, -222, -222, -222, -222, -222, -222, -222, -222, -222,
			 -222, -222, -222, -222, -222, -222, -222, -222, -222, -222,

			 -222, -222, -222, -222, -222, -222, -222, -222, -222, -222,
			 -222, -222, -222, -222, -222, -222, -222, -222, -222, -222,
			 -222, -222, -222, -222, -222, -222, -222, -222, -222, -222,
			 -222, -222, -222, -222, -222, -222, -222, -222, -222, -222,
			 -222, -222, -222, -222, -222, -222, -222, -222, -222, -222,
			 -222, -222, -222, -222, -222, -222, -222, -222, -222, -222,
			 -222, -222, -222, -222, -222, -222, -222, -222, -222, -222,
			 -222, -222, -222, -222, -222, -222, -222, -222, -222, -222,
			 -222, -222, -222, -222, -222, -222, -222, -222, -222, -222,
			 -222, -222, -222, -222, -222, -222, -222, -222, -222, -222,

			 -222, -222, -222, -222, -222, -222, -222, -222, -222, -222,
			 -222,    5, -223, -223, -223, -223, -223, -223, -223, -223,
			 -223, -223, -223, -223, -223, -223, -223, -223, -223, -223,
			 -223, -223, -223, -223, -223, -223, -223, -223, -223, -223,
			 -223, -223, -223, -223, -223, -223, -223, -223, -223, -223,
			 -223, -223, -223, -223, -223, -223, -223, -223, -223,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -223,
			 -223, -223, -223, -223, -223, -223,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100, -223, -223, -223, -223,  100, -223,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -223, -223, -223, -223, -223, -223,
			 -223, -223, -223, -223, -223, -223, -223, -223, -223, -223,
			 -223, -223, -223, -223, -223, -223, -223, -223, -223, -223,
			 -223, -223, -223, -223, -223, -223, -223, -223, -223, -223,
			 -223, -223, -223, -223, -223, -223, -223, -223, -223, -223,
			 -223, -223, -223, -223, -223, -223, -223, -223, -223, -223,
			 -223, -223, -223, -223, -223, -223, -223, -223, -223, -223,

			 -223, -223, -223, -223, -223, -223, -223, -223, -223, -223,
			 -223, -223, -223, -223, -223, -223, -223, -223, -223, -223,
			 -223, -223, -223, -223, -223, -223, -223, -223, -223, -223,
			 -223, -223, -223, -223, -223, -223, -223, -223, -223, -223,
			 -223, -223, -223, -223, -223, -223, -223, -223, -223, -223,
			 -223, -223, -223, -223, -223, -223, -223, -223, -223, -223,
			 -223, -223, -223, -223, -223, -223, -223, -223,    5, -224,
			 -224, -224, -224, -224, -224, -224, -224, -224, -224, -224,
			 -224, -224, -224, -224, -224, -224, -224, -224, -224, -224,
			 -224, -224, -224, -224, -224, -224, -224, -224, -224, -224,

			 -224, -224, -224, -224, -224, -224, -224, -224, -224, -224,
			 -224, -224, -224, -224, -224, -224,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -224, -224, -224, -224,
			 -224, -224, -224,  100,  100,  317,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -224,
			 -224, -224, -224,  100, -224,  100,  100,  317,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -224, -224, -224, -224, -224, -224, -224, -224, -224,

			 -224, -224, -224, -224, -224, -224, -224, -224, -224, -224,
			 -224, -224, -224, -224, -224, -224, -224, -224, -224, -224,
			 -224, -224, -224, -224, -224, -224, -224, -224, -224, -224,
			 -224, -224, -224, -224, -224, -224, -224, -224, -224, -224,
			 -224, -224, -224, -224, -224, -224, -224, -224, -224, -224,
			 -224, -224, -224, -224, -224, -224, -224, -224, -224, -224,
			 -224, -224, -224, -224, -224, -224, -224, -224, -224, -224,
			 -224, -224, -224, -224, -224, -224, -224, -224, -224, -224,
			 -224, -224, -224, -224, -224, -224, -224, -224, -224, -224,
			 -224, -224, -224, -224, -224, -224, -224, -224, -224, -224,

			 -224, -224, -224, -224, -224, -224, -224, -224, -224, -224,
			 -224, -224, -224, -224, -224, -224, -224, -224, -224, -224,
			 -224, -224, -224, -224, -224,    5, -225, -225, -225, -225,
			 -225, -225, -225, -225, -225, -225, -225, -225, -225, -225,
			 -225, -225, -225, -225, -225, -225, -225, -225, -225, -225,
			 -225, -225, -225, -225, -225, -225, -225, -225, -225, -225,
			 -225, -225, -225, -225, -225, -225, -225, -225, -225, -225,
			 -225, -225, -225,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -225, -225, -225, -225, -225, -225, -225,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  318,  100,
			  100,  100,  100,  100,  100,  100, -225, -225, -225, -225,
			  100, -225,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  318,  100,  100,  100,  100,  100,  100,  100, -225, -225,
			 -225, -225, -225, -225, -225, -225, -225, -225, -225, -225,
			 -225, -225, -225, -225, -225, -225, -225, -225, -225, -225,
			 -225, -225, -225, -225, -225, -225, -225, -225, -225, -225,
			 -225, -225, -225, -225, -225, -225, -225, -225, -225, -225,
			 -225, -225, -225, -225, -225, -225, -225, -225, -225, -225, yy_Dummy>>,
			1, 1000, 57000)
		end

	yy_nxt_template_59 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -225, -225, -225, -225, -225, -225, -225, -225, -225, -225,
			 -225, -225, -225, -225, -225, -225, -225, -225, -225, -225,
			 -225, -225, -225, -225, -225, -225, -225, -225, -225, -225,
			 -225, -225, -225, -225, -225, -225, -225, -225, -225, -225,
			 -225, -225, -225, -225, -225, -225, -225, -225, -225, -225,
			 -225, -225, -225, -225, -225, -225, -225, -225, -225, -225,
			 -225, -225, -225, -225, -225, -225, -225, -225, -225, -225,
			 -225, -225, -225, -225, -225, -225, -225, -225, -225, -225,
			 -225, -225,    5, -226, -226, -226, -226, -226, -226, -226,
			 -226, -226, -226, -226, -226, -226, -226, -226, -226, -226,

			 -226, -226, -226, -226, -226, -226, -226, -226, -226, -226,
			 -226, -226, -226, -226, -226, -226, -226, -226, -226, -226,
			 -226, -226, -226, -226, -226, -226, -226, -226, -226, -226,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -226, -226, -226, -226, -226, -226, -226,  319,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -226, -226, -226, -226,  100, -226,  319,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100, -226, -226, -226, -226, -226,
			 -226, -226, -226, -226, -226, -226, -226, -226, -226, -226,
			 -226, -226, -226, -226, -226, -226, -226, -226, -226, -226,
			 -226, -226, -226, -226, -226, -226, -226, -226, -226, -226,
			 -226, -226, -226, -226, -226, -226, -226, -226, -226, -226,
			 -226, -226, -226, -226, -226, -226, -226, -226, -226, -226,
			 -226, -226, -226, -226, -226, -226, -226, -226, -226, -226,
			 -226, -226, -226, -226, -226, -226, -226, -226, -226, -226,
			 -226, -226, -226, -226, -226, -226, -226, -226, -226, -226,
			 -226, -226, -226, -226, -226, -226, -226, -226, -226, -226,

			 -226, -226, -226, -226, -226, -226, -226, -226, -226, -226,
			 -226, -226, -226, -226, -226, -226, -226, -226, -226, -226,
			 -226, -226, -226, -226, -226, -226, -226, -226, -226, -226,
			 -226, -226, -226, -226, -226, -226, -226, -226, -226,    5,
			 -227, -227, -227, -227, -227, -227, -227, -227, -227, -227,
			 -227, -227, -227, -227, -227, -227, -227, -227, -227, -227,
			 -227, -227, -227, -227, -227, -227, -227, -227, -227, -227,
			 -227, -227, -227, -227, -227, -227, -227, -227, -227, -227,
			 -227, -227, -227, -227, -227, -227, -227,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -227, -227, -227,

			 -227, -227, -227, -227,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  320,  100,  100,  100,  100,  100,  100,  100,  100,
			 -227, -227, -227, -227,  100, -227,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  320,  100,  100,  100,  100,  100,  100,
			  100,  100, -227, -227, -227, -227, -227, -227, -227, -227,
			 -227, -227, -227, -227, -227, -227, -227, -227, -227, -227,
			 -227, -227, -227, -227, -227, -227, -227, -227, -227, -227,
			 -227, -227, -227, -227, -227, -227, -227, -227, -227, -227,

			 -227, -227, -227, -227, -227, -227, -227, -227, -227, -227,
			 -227, -227, -227, -227, -227, -227, -227, -227, -227, -227,
			 -227, -227, -227, -227, -227, -227, -227, -227, -227, -227,
			 -227, -227, -227, -227, -227, -227, -227, -227, -227, -227,
			 -227, -227, -227, -227, -227, -227, -227, -227, -227, -227,
			 -227, -227, -227, -227, -227, -227, -227, -227, -227, -227,
			 -227, -227, -227, -227, -227, -227, -227, -227, -227, -227,
			 -227, -227, -227, -227, -227, -227, -227, -227, -227, -227,
			 -227, -227, -227, -227, -227, -227, -227, -227, -227, -227,
			 -227, -227, -227, -227, -227, -227,    5, -228, -228, -228,

			 -228, -228, -228, -228, -228, -228, -228, -228, -228, -228,
			 -228, -228, -228, -228, -228, -228, -228, -228, -228, -228,
			 -228, -228, -228, -228, -228, -228, -228, -228, -228, -228,
			 -228, -228, -228, -228, -228, -228, -228, -228, -228, -228,
			 -228, -228, -228, -228,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -228, -228, -228, -228, -228, -228,
			 -228,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  321,  100,  100,  100,  100,  100, -228, -228, -228,
			 -228,  100, -228,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  321,  100,  100,  100,  100,  100, -228,
			 -228, -228, -228, -228, -228, -228, -228, -228, -228, -228,
			 -228, -228, -228, -228, -228, -228, -228, -228, -228, -228,
			 -228, -228, -228, -228, -228, -228, -228, -228, -228, -228,
			 -228, -228, -228, -228, -228, -228, -228, -228, -228, -228,
			 -228, -228, -228, -228, -228, -228, -228, -228, -228, -228,
			 -228, -228, -228, -228, -228, -228, -228, -228, -228, -228,
			 -228, -228, -228, -228, -228, -228, -228, -228, -228, -228,
			 -228, -228, -228, -228, -228, -228, -228, -228, -228, -228,

			 -228, -228, -228, -228, -228, -228, -228, -228, -228, -228,
			 -228, -228, -228, -228, -228, -228, -228, -228, -228, -228,
			 -228, -228, -228, -228, -228, -228, -228, -228, -228, -228,
			 -228, -228, -228, -228, -228, -228, -228, -228, -228, -228,
			 -228, -228, -228, -228, -228, -228, -228, -228, -228, -228,
			 -228, -228, -228,    5, -229, -229, -229, -229, -229, -229,
			 -229, -229, -229, -229, -229, -229, -229, -229, -229, -229,
			 -229, -229, -229, -229, -229, -229, -229, -229, -229, -229,
			 -229, -229, -229, -229, -229, -229, -229, -229, -229, -229,
			 -229, -229, -229, -229, -229, -229, -229, -229, -229, -229,

			 -229,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -229, -229, -229, -229, -229, -229, -229,  100,  100,
			  100,  100,  322,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -229, -229, -229, -229,  100, -229,
			  100,  100,  100,  100,  322,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -229, -229, -229, -229,
			 -229, -229, -229, -229, -229, -229, -229, -229, -229, -229,
			 -229, -229, -229, -229, -229, -229, -229, -229, -229, -229, yy_Dummy>>,
			1, 1000, 58000)
		end

	yy_nxt_template_60 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -229, -229, -229, -229, -229, -229, -229, -229, -229, -229,
			 -229, -229, -229, -229, -229, -229, -229, -229, -229, -229,
			 -229, -229, -229, -229, -229, -229, -229, -229, -229, -229,
			 -229, -229, -229, -229, -229, -229, -229, -229, -229, -229,
			 -229, -229, -229, -229, -229, -229, -229, -229, -229, -229,
			 -229, -229, -229, -229, -229, -229, -229, -229, -229, -229,
			 -229, -229, -229, -229, -229, -229, -229, -229, -229, -229,
			 -229, -229, -229, -229, -229, -229, -229, -229, -229, -229,
			 -229, -229, -229, -229, -229, -229, -229, -229, -229, -229,
			 -229, -229, -229, -229, -229, -229, -229, -229, -229, -229,

			 -229, -229, -229, -229, -229, -229, -229, -229, -229, -229,
			    5, -230, -230, -230, -230, -230, -230, -230, -230, -230,
			 -230, -230, -230, -230, -230, -230, -230, -230, -230, -230,
			 -230, -230, -230, -230, -230, -230, -230, -230, -230, -230,
			 -230, -230, -230, -230, -230, -230, -230, -230, -230, -230,
			 -230, -230, -230, -230, -230, -230, -230, -230,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -230, -230,
			 -230, -230, -230, -230, -230,  100,  100,  100,  100,  323,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100, -230, -230, -230, -230,  100, -230,  100,  100,  100,
			  100,  323,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -230, -230, -230, -230, -230, -230, -230,
			 -230, -230, -230, -230, -230, -230, -230, -230, -230, -230,
			 -230, -230, -230, -230, -230, -230, -230, -230, -230, -230,
			 -230, -230, -230, -230, -230, -230, -230, -230, -230, -230,
			 -230, -230, -230, -230, -230, -230, -230, -230, -230, -230,
			 -230, -230, -230, -230, -230, -230, -230, -230, -230, -230,
			 -230, -230, -230, -230, -230, -230, -230, -230, -230, -230,

			 -230, -230, -230, -230, -230, -230, -230, -230, -230, -230,
			 -230, -230, -230, -230, -230, -230, -230, -230, -230, -230,
			 -230, -230, -230, -230, -230, -230, -230, -230, -230, -230,
			 -230, -230, -230, -230, -230, -230, -230, -230, -230, -230,
			 -230, -230, -230, -230, -230, -230, -230, -230, -230, -230,
			 -230, -230, -230, -230, -230, -230, -230, -230, -230, -230,
			 -230, -230, -230, -230, -230, -230, -230,    5, -231, -231,
			 -231, -231, -231, -231, -231, -231, -231, -231, -231, -231,
			 -231, -231, -231, -231, -231, -231, -231, -231, -231, -231,
			 -231, -231, -231, -231, -231, -231, -231, -231, -231, -231,

			 -231, -231, -231, -231, -231, -231, -231, -231, -231, -231,
			 -231, -231, -231, -231, -231,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -231, -231, -231, -231, -231,
			 -231, -231,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -231, -231,
			 -231, -231,  100, -231,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -231, -231, -231, -231, -231, -231, -231, -231, -231, -231,

			 -231, -231, -231, -231, -231, -231, -231, -231, -231, -231,
			 -231, -231, -231, -231, -231, -231, -231, -231, -231, -231,
			 -231, -231, -231, -231, -231, -231, -231, -231, -231, -231,
			 -231, -231, -231, -231, -231, -231, -231, -231, -231, -231,
			 -231, -231, -231, -231, -231, -231, -231, -231, -231, -231,
			 -231, -231, -231, -231, -231, -231, -231, -231, -231, -231,
			 -231, -231, -231, -231, -231, -231, -231, -231, -231, -231,
			 -231, -231, -231, -231, -231, -231, -231, -231, -231, -231,
			 -231, -231, -231, -231, -231, -231, -231, -231, -231, -231,
			 -231, -231, -231, -231, -231, -231, -231, -231, -231, -231,

			 -231, -231, -231, -231, -231, -231, -231, -231, -231, -231,
			 -231, -231, -231, -231, -231, -231, -231, -231, -231, -231,
			 -231, -231, -231, -231,    5, -232, -232, -232, -232, -232,
			 -232, -232, -232, -232, -232, -232, -232, -232, -232, -232,
			 -232, -232, -232, -232, -232, -232, -232, -232, -232, -232,
			 -232, -232, -232, -232, -232, -232, -232, -232, -232, -232,
			 -232, -232, -232, -232, -232, -232, -232, -232, -232, -232,
			 -232, -232,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -232, -232, -232, -232, -232, -232, -232,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  324,
			  100,  100,  100,  100,  100, -232, -232, -232, -232,  100,
			 -232,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  324,  100,  100,  100,  100,  100, -232, -232, -232,
			 -232, -232, -232, -232, -232, -232, -232, -232, -232, -232,
			 -232, -232, -232, -232, -232, -232, -232, -232, -232, -232,
			 -232, -232, -232, -232, -232, -232, -232, -232, -232, -232,
			 -232, -232, -232, -232, -232, -232, -232, -232, -232, -232,
			 -232, -232, -232, -232, -232, -232, -232, -232, -232, -232,

			 -232, -232, -232, -232, -232, -232, -232, -232, -232, -232,
			 -232, -232, -232, -232, -232, -232, -232, -232, -232, -232,
			 -232, -232, -232, -232, -232, -232, -232, -232, -232, -232,
			 -232, -232, -232, -232, -232, -232, -232, -232, -232, -232,
			 -232, -232, -232, -232, -232, -232, -232, -232, -232, -232,
			 -232, -232, -232, -232, -232, -232, -232, -232, -232, -232,
			 -232, -232, -232, -232, -232, -232, -232, -232, -232, -232,
			 -232, -232, -232, -232, -232, -232, -232, -232, -232, -232,
			 -232,    5, -233, -233, -233, -233, -233, -233, -233, -233,
			 -233, -233, -233, -233, -233, -233, -233, -233, -233, -233,

			 -233, -233, -233, -233, -233, -233, -233, -233, -233, -233,
			 -233, -233, -233, -233, -233, -233, -233, -233, -233, -233,
			 -233, -233, -233, -233, -233, -233, -233, -233, -233,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -233,
			 -233, -233, -233, -233, -233, -233,  325,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  326,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -233, -233, -233, -233,  100, -233,  325,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  326,  100,  100,  100,  100,  100,  100,  100, yy_Dummy>>,
			1, 1000, 59000)
		end

	yy_nxt_template_61 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  100,  100,  100,  100, -233, -233, -233, -233, -233, -233,
			 -233, -233, -233, -233, -233, -233, -233, -233, -233, -233,
			 -233, -233, -233, -233, -233, -233, -233, -233, -233, -233,
			 -233, -233, -233, -233, -233, -233, -233, -233, -233, -233,
			 -233, -233, -233, -233, -233, -233, -233, -233, -233, -233,
			 -233, -233, -233, -233, -233, -233, -233, -233, -233, -233,
			 -233, -233, -233, -233, -233, -233, -233, -233, -233, -233,
			 -233, -233, -233, -233, -233, -233, -233, -233, -233, -233,
			 -233, -233, -233, -233, -233, -233, -233, -233, -233, -233,
			 -233, -233, -233, -233, -233, -233, -233, -233, -233, -233,

			 -233, -233, -233, -233, -233, -233, -233, -233, -233, -233,
			 -233, -233, -233, -233, -233, -233, -233, -233, -233, -233,
			 -233, -233, -233, -233, -233, -233, -233, -233, -233, -233,
			 -233, -233, -233, -233, -233, -233, -233, -233,    5, -234,
			 -234, -234, -234, -234, -234, -234, -234, -234, -234, -234,
			 -234, -234, -234, -234, -234, -234, -234, -234, -234, -234,
			 -234, -234, -234, -234, -234, -234, -234, -234, -234, -234,
			 -234, -234, -234, -234, -234, -234, -234, -234, -234, -234,
			 -234, -234, -234, -234, -234, -234,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -234, -234, -234, -234,

			 -234, -234, -234,  100,  100,  100,  100,  327,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -234,
			 -234, -234, -234,  100, -234,  100,  100,  100,  100,  327,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -234, -234, -234, -234, -234, -234, -234, -234, -234,
			 -234, -234, -234, -234, -234, -234, -234, -234, -234, -234,
			 -234, -234, -234, -234, -234, -234, -234, -234, -234, -234,
			 -234, -234, -234, -234, -234, -234, -234, -234, -234, -234,

			 -234, -234, -234, -234, -234, -234, -234, -234, -234, -234,
			 -234, -234, -234, -234, -234, -234, -234, -234, -234, -234,
			 -234, -234, -234, -234, -234, -234, -234, -234, -234, -234,
			 -234, -234, -234, -234, -234, -234, -234, -234, -234, -234,
			 -234, -234, -234, -234, -234, -234, -234, -234, -234, -234,
			 -234, -234, -234, -234, -234, -234, -234, -234, -234, -234,
			 -234, -234, -234, -234, -234, -234, -234, -234, -234, -234,
			 -234, -234, -234, -234, -234, -234, -234, -234, -234, -234,
			 -234, -234, -234, -234, -234, -234, -234, -234, -234, -234,
			 -234, -234, -234, -234, -234,    5, -235, -235, -235, -235,

			 -235, -235, -235, -235, -235, -235, -235, -235, -235, -235,
			 -235, -235, -235, -235, -235, -235, -235, -235, -235, -235,
			 -235, -235, -235, -235, -235, -235, -235, -235, -235, -235,
			 -235, -235, -235, -235, -235, -235, -235, -235, -235, -235,
			 -235, -235, -235,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -235, -235, -235, -235, -235, -235, -235,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  328,  100,
			  100,  100,  100,  100,  100,  100, -235, -235, -235, -235,
			  100, -235,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  328,  100,  100,  100,  100,  100,  100,  100, -235, -235,
			 -235, -235, -235, -235, -235, -235, -235, -235, -235, -235,
			 -235, -235, -235, -235, -235, -235, -235, -235, -235, -235,
			 -235, -235, -235, -235, -235, -235, -235, -235, -235, -235,
			 -235, -235, -235, -235, -235, -235, -235, -235, -235, -235,
			 -235, -235, -235, -235, -235, -235, -235, -235, -235, -235,
			 -235, -235, -235, -235, -235, -235, -235, -235, -235, -235,
			 -235, -235, -235, -235, -235, -235, -235, -235, -235, -235,
			 -235, -235, -235, -235, -235, -235, -235, -235, -235, -235,

			 -235, -235, -235, -235, -235, -235, -235, -235, -235, -235,
			 -235, -235, -235, -235, -235, -235, -235, -235, -235, -235,
			 -235, -235, -235, -235, -235, -235, -235, -235, -235, -235,
			 -235, -235, -235, -235, -235, -235, -235, -235, -235, -235,
			 -235, -235, -235, -235, -235, -235, -235, -235, -235, -235,
			 -235, -235,    5, -236, -236, -236, -236, -236, -236, -236,
			 -236, -236, -236, -236, -236, -236, -236, -236, -236, -236,
			 -236, -236, -236, -236, -236, -236, -236, -236, -236, -236,
			 -236, -236, -236, -236, -236, -236, -236, -236, -236, -236,
			 -236, -236, -236, -236, -236, -236, -236, -236, -236, -236,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -236, -236, -236, -236, -236, -236, -236,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  329,  100,  100,  100,
			  100,  100,  100, -236, -236, -236, -236,  100, -236,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  329,  100,
			  100,  100,  100,  100,  100, -236, -236, -236, -236, -236,
			 -236, -236, -236, -236, -236, -236, -236, -236, -236, -236,
			 -236, -236, -236, -236, -236, -236, -236, -236, -236, -236,

			 -236, -236, -236, -236, -236, -236, -236, -236, -236, -236,
			 -236, -236, -236, -236, -236, -236, -236, -236, -236, -236,
			 -236, -236, -236, -236, -236, -236, -236, -236, -236, -236,
			 -236, -236, -236, -236, -236, -236, -236, -236, -236, -236,
			 -236, -236, -236, -236, -236, -236, -236, -236, -236, -236,
			 -236, -236, -236, -236, -236, -236, -236, -236, -236, -236,
			 -236, -236, -236, -236, -236, -236, -236, -236, -236, -236,
			 -236, -236, -236, -236, -236, -236, -236, -236, -236, -236,
			 -236, -236, -236, -236, -236, -236, -236, -236, -236, -236,
			 -236, -236, -236, -236, -236, -236, -236, -236, -236, -236,

			 -236, -236, -236, -236, -236, -236, -236, -236, -236,    5,
			 -237, -237, -237, -237, -237, -237, -237, -237, -237, -237,
			 -237, -237, -237, -237, -237, -237, -237, -237, -237, -237,
			 -237, -237, -237, -237, -237, -237, -237, -237, -237, -237,
			 -237, -237, -237, -237, -237, -237, -237, -237, -237, -237,
			 -237, -237, -237, -237, -237, -237, -237,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -237, -237, -237,
			 -237, -237, -237, -237,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  330,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  331, yy_Dummy>>,
			1, 1000, 60000)
		end

	yy_nxt_template_62 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -237, -237, -237, -237,  100, -237,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  330,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  331, -237, -237, -237, -237, -237, -237, -237, -237,
			 -237, -237, -237, -237, -237, -237, -237, -237, -237, -237,
			 -237, -237, -237, -237, -237, -237, -237, -237, -237, -237,
			 -237, -237, -237, -237, -237, -237, -237, -237, -237, -237,
			 -237, -237, -237, -237, -237, -237, -237, -237, -237, -237,
			 -237, -237, -237, -237, -237, -237, -237, -237, -237, -237,
			 -237, -237, -237, -237, -237, -237, -237, -237, -237, -237,

			 -237, -237, -237, -237, -237, -237, -237, -237, -237, -237,
			 -237, -237, -237, -237, -237, -237, -237, -237, -237, -237,
			 -237, -237, -237, -237, -237, -237, -237, -237, -237, -237,
			 -237, -237, -237, -237, -237, -237, -237, -237, -237, -237,
			 -237, -237, -237, -237, -237, -237, -237, -237, -237, -237,
			 -237, -237, -237, -237, -237, -237, -237, -237, -237, -237,
			 -237, -237, -237, -237, -237, -237,    5, -238, -238, -238,
			 -238, -238, -238, -238, -238, -238, -238, -238, -238, -238,
			 -238, -238, -238, -238, -238, -238, -238, -238, -238, -238,
			 -238, -238, -238, -238, -238, -238, -238, -238, -238, -238,

			 -238, -238, -238, -238, -238, -238, -238, -238, -238, -238,
			 -238, -238, -238, -238,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -238, -238, -238, -238, -238, -238,
			 -238,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  332,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -238, -238, -238,
			 -238,  100, -238,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  332,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -238,
			 -238, -238, -238, -238, -238, -238, -238, -238, -238, -238,

			 -238, -238, -238, -238, -238, -238, -238, -238, -238, -238,
			 -238, -238, -238, -238, -238, -238, -238, -238, -238, -238,
			 -238, -238, -238, -238, -238, -238, -238, -238, -238, -238,
			 -238, -238, -238, -238, -238, -238, -238, -238, -238, -238,
			 -238, -238, -238, -238, -238, -238, -238, -238, -238, -238,
			 -238, -238, -238, -238, -238, -238, -238, -238, -238, -238,
			 -238, -238, -238, -238, -238, -238, -238, -238, -238, -238,
			 -238, -238, -238, -238, -238, -238, -238, -238, -238, -238,
			 -238, -238, -238, -238, -238, -238, -238, -238, -238, -238,
			 -238, -238, -238, -238, -238, -238, -238, -238, -238, -238,

			 -238, -238, -238, -238, -238, -238, -238, -238, -238, -238,
			 -238, -238, -238, -238, -238, -238, -238, -238, -238, -238,
			 -238, -238, -238,    5, -239, -239, -239, -239, -239, -239,
			 -239, -239, -239, -239, -239, -239, -239, -239, -239, -239,
			 -239, -239, -239, -239, -239, -239, -239, -239, -239, -239,
			 -239, -239, -239, -239, -239, -239, -239, -239, -239, -239,
			 -239, -239, -239, -239, -239, -239, -239, -239, -239, -239,
			 -239,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -239, -239, -239, -239, -239, -239, -239,  100,  100,
			  100,  100,  333,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -239, -239, -239, -239,  100, -239,
			  100,  100,  100,  100,  333,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -239, -239, -239, -239,
			 -239, -239, -239, -239, -239, -239, -239, -239, -239, -239,
			 -239, -239, -239, -239, -239, -239, -239, -239, -239, -239,
			 -239, -239, -239, -239, -239, -239, -239, -239, -239, -239,
			 -239, -239, -239, -239, -239, -239, -239, -239, -239, -239,
			 -239, -239, -239, -239, -239, -239, -239, -239, -239, -239,

			 -239, -239, -239, -239, -239, -239, -239, -239, -239, -239,
			 -239, -239, -239, -239, -239, -239, -239, -239, -239, -239,
			 -239, -239, -239, -239, -239, -239, -239, -239, -239, -239,
			 -239, -239, -239, -239, -239, -239, -239, -239, -239, -239,
			 -239, -239, -239, -239, -239, -239, -239, -239, -239, -239,
			 -239, -239, -239, -239, -239, -239, -239, -239, -239, -239,
			 -239, -239, -239, -239, -239, -239, -239, -239, -239, -239,
			 -239, -239, -239, -239, -239, -239, -239, -239, -239, -239,
			    5, -240, -240, -240, -240, -240, -240, -240, -240, -240,
			 -240, -240, -240, -240, -240, -240, -240, -240, -240, -240,

			 -240, -240, -240, -240, -240, -240, -240, -240, -240, -240,
			 -240, -240, -240, -240, -240, -240, -240, -240, -240, -240,
			 -240, -240, -240, -240, -240, -240, -240, -240,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -240, -240,
			 -240, -240, -240, -240, -240,  100,  100,  100,  100,  100,
			  100,  100,  100,  334,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -240, -240, -240, -240,  100, -240,  100,  100,  100,
			  100,  100,  100,  100,  100,  334,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100, -240, -240, -240, -240, -240, -240, -240,
			 -240, -240, -240, -240, -240, -240, -240, -240, -240, -240,
			 -240, -240, -240, -240, -240, -240, -240, -240, -240, -240,
			 -240, -240, -240, -240, -240, -240, -240, -240, -240, -240,
			 -240, -240, -240, -240, -240, -240, -240, -240, -240, -240,
			 -240, -240, -240, -240, -240, -240, -240, -240, -240, -240,
			 -240, -240, -240, -240, -240, -240, -240, -240, -240, -240,
			 -240, -240, -240, -240, -240, -240, -240, -240, -240, -240,
			 -240, -240, -240, -240, -240, -240, -240, -240, -240, -240,
			 -240, -240, -240, -240, -240, -240, -240, -240, -240, -240,

			 -240, -240, -240, -240, -240, -240, -240, -240, -240, -240,
			 -240, -240, -240, -240, -240, -240, -240, -240, -240, -240,
			 -240, -240, -240, -240, -240, -240, -240, -240, -240, -240,
			 -240, -240, -240, -240, -240, -240, -240,    5, -241, -241,
			 -241, -241, -241, -241, -241, -241, -241, -241, -241, -241,
			 -241, -241, -241, -241, -241, -241, -241, -241, -241, -241,
			 -241, -241, -241, -241, -241, -241, -241, -241, -241, -241,
			 -241, -241, -241, -241, -241, -241, -241, -241, -241, -241,
			 -241, -241, -241, -241, -241,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -241, -241, -241, -241, -241, yy_Dummy>>,
			1, 1000, 61000)
		end

	yy_nxt_template_63 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -241, -241,  100,  100,  100,  100,  335,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -241, -241,
			 -241, -241,  100, -241,  100,  100,  100,  100,  335,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -241, -241, -241, -241, -241, -241, -241, -241, -241, -241,
			 -241, -241, -241, -241, -241, -241, -241, -241, -241, -241,
			 -241, -241, -241, -241, -241, -241, -241, -241, -241, -241,
			 -241, -241, -241, -241, -241, -241, -241, -241, -241, -241,

			 -241, -241, -241, -241, -241, -241, -241, -241, -241, -241,
			 -241, -241, -241, -241, -241, -241, -241, -241, -241, -241,
			 -241, -241, -241, -241, -241, -241, -241, -241, -241, -241,
			 -241, -241, -241, -241, -241, -241, -241, -241, -241, -241,
			 -241, -241, -241, -241, -241, -241, -241, -241, -241, -241,
			 -241, -241, -241, -241, -241, -241, -241, -241, -241, -241,
			 -241, -241, -241, -241, -241, -241, -241, -241, -241, -241,
			 -241, -241, -241, -241, -241, -241, -241, -241, -241, -241,
			 -241, -241, -241, -241, -241, -241, -241, -241, -241, -241,
			 -241, -241, -241, -241,    5, -242, -242, -242, -242, -242,

			 -242, -242, -242, -242, -242, -242, -242, -242, -242, -242,
			 -242, -242, -242, -242, -242, -242, -242, -242, -242, -242,
			 -242, -242, -242, -242, -242, -242, -242, -242, -242, -242,
			 -242, -242, -242, -242, -242, -242, -242, -242, -242, -242,
			 -242, -242,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -242, -242, -242, -242, -242, -242, -242,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  336,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -242, -242, -242, -242,  100,
			 -242,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  336,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -242, -242, -242,
			 -242, -242, -242, -242, -242, -242, -242, -242, -242, -242,
			 -242, -242, -242, -242, -242, -242, -242, -242, -242, -242,
			 -242, -242, -242, -242, -242, -242, -242, -242, -242, -242,
			 -242, -242, -242, -242, -242, -242, -242, -242, -242, -242,
			 -242, -242, -242, -242, -242, -242, -242, -242, -242, -242,
			 -242, -242, -242, -242, -242, -242, -242, -242, -242, -242,
			 -242, -242, -242, -242, -242, -242, -242, -242, -242, -242,
			 -242, -242, -242, -242, -242, -242, -242, -242, -242, -242,

			 -242, -242, -242, -242, -242, -242, -242, -242, -242, -242,
			 -242, -242, -242, -242, -242, -242, -242, -242, -242, -242,
			 -242, -242, -242, -242, -242, -242, -242, -242, -242, -242,
			 -242, -242, -242, -242, -242, -242, -242, -242, -242, -242,
			 -242, -242, -242, -242, -242, -242, -242, -242, -242, -242,
			 -242,    5, -243, -243, -243, -243, -243, -243, -243, -243,
			 -243, -243, -243, -243, -243, -243, -243, -243, -243, -243,
			 -243, -243, -243, -243, -243, -243, -243, -243, -243, -243,
			 -243, -243, -243, -243, -243, -243, -243, -243, -243, -243,
			 -243, -243, -243, -243, -243, -243, -243, -243, -243,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100, -243,
			 -243, -243, -243, -243, -243, -243,  337,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -243, -243, -243, -243,  100, -243,  337,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -243, -243, -243, -243, -243, -243,
			 -243, -243, -243, -243, -243, -243, -243, -243, -243, -243,
			 -243, -243, -243, -243, -243, -243, -243, -243, -243, -243,

			 -243, -243, -243, -243, -243, -243, -243, -243, -243, -243,
			 -243, -243, -243, -243, -243, -243, -243, -243, -243, -243,
			 -243, -243, -243, -243, -243, -243, -243, -243, -243, -243,
			 -243, -243, -243, -243, -243, -243, -243, -243, -243, -243,
			 -243, -243, -243, -243, -243, -243, -243, -243, -243, -243,
			 -243, -243, -243, -243, -243, -243, -243, -243, -243, -243,
			 -243, -243, -243, -243, -243, -243, -243, -243, -243, -243,
			 -243, -243, -243, -243, -243, -243, -243, -243, -243, -243,
			 -243, -243, -243, -243, -243, -243, -243, -243, -243, -243,
			 -243, -243, -243, -243, -243, -243, -243, -243, -243, -243,

			 -243, -243, -243, -243, -243, -243, -243, -243,    5, -244,
			 -244, -244, -244, -244, -244, -244, -244, -244, -244, -244,
			 -244, -244, -244, -244, -244, -244, -244, -244, -244, -244,
			 -244, -244, -244, -244, -244, -244, -244, -244, -244, -244,
			 -244, -244, -244, -244, -244, -244, -244, -244, -244, -244,
			 -244, -244, -244, -244, -244, -244,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -244, -244, -244, -244,
			 -244, -244, -244,  100,  100,  100,  100,  338,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -244,

			 -244, -244, -244,  100, -244,  100,  100,  100,  100,  338,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -244, -244, -244, -244, -244, -244, -244, -244, -244,
			 -244, -244, -244, -244, -244, -244, -244, -244, -244, -244,
			 -244, -244, -244, -244, -244, -244, -244, -244, -244, -244,
			 -244, -244, -244, -244, -244, -244, -244, -244, -244, -244,
			 -244, -244, -244, -244, -244, -244, -244, -244, -244, -244,
			 -244, -244, -244, -244, -244, -244, -244, -244, -244, -244,
			 -244, -244, -244, -244, -244, -244, -244, -244, -244, -244,

			 -244, -244, -244, -244, -244, -244, -244, -244, -244, -244,
			 -244, -244, -244, -244, -244, -244, -244, -244, -244, -244,
			 -244, -244, -244, -244, -244, -244, -244, -244, -244, -244,
			 -244, -244, -244, -244, -244, -244, -244, -244, -244, -244,
			 -244, -244, -244, -244, -244, -244, -244, -244, -244, -244,
			 -244, -244, -244, -244, -244, -244, -244, -244, -244, -244,
			 -244, -244, -244, -244, -244,    5, -245, -245, -245, -245,
			 -245, -245, -245, -245, -245, -245, -245, -245, -245, -245,
			 -245, -245, -245, -245, -245, -245, -245, -245, -245, -245,
			 -245, -245, -245, -245, -245, -245, -245, -245, -245, -245, yy_Dummy>>,
			1, 1000, 62000)
		end

	yy_nxt_template_64 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -245, -245, -245, -245, -245, -245, -245, -245, -245, -245,
			 -245, -245, -245,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -245, -245, -245, -245, -245, -245, -245,
			  339,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -245, -245, -245, -245,
			  100, -245,  339,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -245, -245,
			 -245, -245, -245, -245, -245, -245, -245, -245, -245, -245,

			 -245, -245, -245, -245, -245, -245, -245, -245, -245, -245,
			 -245, -245, -245, -245, -245, -245, -245, -245, -245, -245,
			 -245, -245, -245, -245, -245, -245, -245, -245, -245, -245,
			 -245, -245, -245, -245, -245, -245, -245, -245, -245, -245,
			 -245, -245, -245, -245, -245, -245, -245, -245, -245, -245,
			 -245, -245, -245, -245, -245, -245, -245, -245, -245, -245,
			 -245, -245, -245, -245, -245, -245, -245, -245, -245, -245,
			 -245, -245, -245, -245, -245, -245, -245, -245, -245, -245,
			 -245, -245, -245, -245, -245, -245, -245, -245, -245, -245,
			 -245, -245, -245, -245, -245, -245, -245, -245, -245, -245,

			 -245, -245, -245, -245, -245, -245, -245, -245, -245, -245,
			 -245, -245, -245, -245, -245, -245, -245, -245, -245, -245,
			 -245, -245,    5, -246, -246, -246, -246, -246, -246, -246,
			 -246, -246, -246, -246, -246, -246, -246, -246, -246, -246,
			 -246, -246, -246, -246, -246, -246, -246, -246, -246, -246,
			 -246, -246, -246, -246, -246, -246, -246, -246, -246, -246,
			 -246, -246, -246, -246, -246, -246, -246, -246, -246, -246,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -246, -246, -246, -246, -246, -246, -246,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  340,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -246, -246, -246, -246,  100, -246,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  340,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -246, -246, -246, -246, -246,
			 -246, -246, -246, -246, -246, -246, -246, -246, -246, -246,
			 -246, -246, -246, -246, -246, -246, -246, -246, -246, -246,
			 -246, -246, -246, -246, -246, -246, -246, -246, -246, -246,
			 -246, -246, -246, -246, -246, -246, -246, -246, -246, -246,
			 -246, -246, -246, -246, -246, -246, -246, -246, -246, -246,

			 -246, -246, -246, -246, -246, -246, -246, -246, -246, -246,
			 -246, -246, -246, -246, -246, -246, -246, -246, -246, -246,
			 -246, -246, -246, -246, -246, -246, -246, -246, -246, -246,
			 -246, -246, -246, -246, -246, -246, -246, -246, -246, -246,
			 -246, -246, -246, -246, -246, -246, -246, -246, -246, -246,
			 -246, -246, -246, -246, -246, -246, -246, -246, -246, -246,
			 -246, -246, -246, -246, -246, -246, -246, -246, -246, -246,
			 -246, -246, -246, -246, -246, -246, -246, -246, -246,    5,
			 -247, -247, -247, -247, -247, -247, -247, -247, -247, -247,
			 -247, -247, -247, -247, -247, -247, -247, -247, -247, -247,

			 -247, -247, -247, -247, -247, -247, -247, -247, -247, -247,
			 -247, -247, -247, -247, -247, -247, -247, -247, -247, -247,
			 -247, -247, -247, -247, -247, -247, -247,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -247, -247, -247,
			 -247, -247, -247, -247,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -247, -247, -247, -247,  100, -247,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100, -247, -247, -247, -247, -247, -247, -247, -247,
			 -247, -247, -247, -247, -247, -247, -247, -247, -247, -247,
			 -247, -247, -247, -247, -247, -247, -247, -247, -247, -247,
			 -247, -247, -247, -247, -247, -247, -247, -247, -247, -247,
			 -247, -247, -247, -247, -247, -247, -247, -247, -247, -247,
			 -247, -247, -247, -247, -247, -247, -247, -247, -247, -247,
			 -247, -247, -247, -247, -247, -247, -247, -247, -247, -247,
			 -247, -247, -247, -247, -247, -247, -247, -247, -247, -247,
			 -247, -247, -247, -247, -247, -247, -247, -247, -247, -247,
			 -247, -247, -247, -247, -247, -247, -247, -247, -247, -247,

			 -247, -247, -247, -247, -247, -247, -247, -247, -247, -247,
			 -247, -247, -247, -247, -247, -247, -247, -247, -247, -247,
			 -247, -247, -247, -247, -247, -247, -247, -247, -247, -247,
			 -247, -247, -247, -247, -247, -247,    5, -248, -248, -248,
			 -248, -248, -248, -248, -248, -248, -248, -248, -248, -248,
			 -248, -248, -248, -248, -248, -248, -248, -248, -248, -248,
			 -248, -248, -248, -248, -248, -248, -248, -248, -248, -248,
			 -248, -248, -248, -248, -248, -248, -248, -248, -248, -248,
			 -248, -248, -248, -248,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -248, -248, -248, -248, -248, -248,

			 -248,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  341,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -248, -248, -248,
			 -248,  100, -248,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  341,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -248,
			 -248, -248, -248, -248, -248, -248, -248, -248, -248, -248,
			 -248, -248, -248, -248, -248, -248, -248, -248, -248, -248,
			 -248, -248, -248, -248, -248, -248, -248, -248, -248, -248,
			 -248, -248, -248, -248, -248, -248, -248, -248, -248, -248,

			 -248, -248, -248, -248, -248, -248, -248, -248, -248, -248,
			 -248, -248, -248, -248, -248, -248, -248, -248, -248, -248,
			 -248, -248, -248, -248, -248, -248, -248, -248, -248, -248,
			 -248, -248, -248, -248, -248, -248, -248, -248, -248, -248,
			 -248, -248, -248, -248, -248, -248, -248, -248, -248, -248,
			 -248, -248, -248, -248, -248, -248, -248, -248, -248, -248,
			 -248, -248, -248, -248, -248, -248, -248, -248, -248, -248,
			 -248, -248, -248, -248, -248, -248, -248, -248, -248, -248,
			 -248, -248, -248, -248, -248, -248, -248, -248, -248, -248,
			 -248, -248, -248,    5, -249, -249, -249, -249, -249, -249, yy_Dummy>>,
			1, 1000, 63000)
		end

	yy_nxt_template_65 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -249, -249, -249, -249, -249, -249, -249, -249, -249, -249,
			 -249, -249, -249, -249, -249, -249, -249, -249, -249, -249,
			 -249, -249, -249, -249, -249, -249, -249, -249, -249, -249,
			 -249, -249, -249, -249, -249, -249, -249, -249, -249, -249,
			 -249,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -249, -249, -249, -249, -249, -249, -249,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -249, -249, -249, -249,  100, -249,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -249, -249, -249, -249,
			 -249, -249, -249, -249, -249, -249, -249, -249, -249, -249,
			 -249, -249, -249, -249, -249, -249, -249, -249, -249, -249,
			 -249, -249, -249, -249, -249, -249, -249, -249, -249, -249,
			 -249, -249, -249, -249, -249, -249, -249, -249, -249, -249,
			 -249, -249, -249, -249, -249, -249, -249, -249, -249, -249,
			 -249, -249, -249, -249, -249, -249, -249, -249, -249, -249,
			 -249, -249, -249, -249, -249, -249, -249, -249, -249, -249,
			 -249, -249, -249, -249, -249, -249, -249, -249, -249, -249,

			 -249, -249, -249, -249, -249, -249, -249, -249, -249, -249,
			 -249, -249, -249, -249, -249, -249, -249, -249, -249, -249,
			 -249, -249, -249, -249, -249, -249, -249, -249, -249, -249,
			 -249, -249, -249, -249, -249, -249, -249, -249, -249, -249,
			 -249, -249, -249, -249, -249, -249, -249, -249, -249, -249,
			    5, -250, -250, -250, -250, -250, -250, -250, -250, -250,
			 -250, -250, -250, -250, -250, -250, -250, -250, -250, -250,
			 -250, -250, -250, -250, -250, -250, -250, -250, -250, -250,
			 -250, -250, -250, -250, -250, -250, -250, -250, -250, -250,
			 -250, -250, -250, -250, -250, -250, -250, -250,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100, -250, -250,
			 -250, -250, -250, -250, -250,  100,  100,  100,  100,  342,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -250, -250, -250, -250,  100, -250,  100,  100,  100,
			  100,  342,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -250, -250, -250, -250, -250, -250, -250,
			 -250, -250, -250, -250, -250, -250, -250, -250, -250, -250,
			 -250, -250, -250, -250, -250, -250, -250, -250, -250, -250,

			 -250, -250, -250, -250, -250, -250, -250, -250, -250, -250,
			 -250, -250, -250, -250, -250, -250, -250, -250, -250, -250,
			 -250, -250, -250, -250, -250, -250, -250, -250, -250, -250,
			 -250, -250, -250, -250, -250, -250, -250, -250, -250, -250,
			 -250, -250, -250, -250, -250, -250, -250, -250, -250, -250,
			 -250, -250, -250, -250, -250, -250, -250, -250, -250, -250,
			 -250, -250, -250, -250, -250, -250, -250, -250, -250, -250,
			 -250, -250, -250, -250, -250, -250, -250, -250, -250, -250,
			 -250, -250, -250, -250, -250, -250, -250, -250, -250, -250,
			 -250, -250, -250, -250, -250, -250, -250, -250, -250, -250,

			 -250, -250, -250, -250, -250, -250, -250,    5, -251, -251,
			 -251, -251, -251, -251, -251, -251, -251, -251, -251, -251,
			 -251, -251, -251, -251, -251, -251, -251, -251, -251, -251,
			 -251, -251, -251, -251, -251, -251, -251, -251, -251, -251,
			 -251, -251, -251, -251, -251, -251, -251, -251, -251, -251,
			 -251, -251, -251, -251, -251,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -251, -251, -251, -251, -251,
			 -251, -251,  100,  100,  343,  100,  100,  344,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -251, -251,

			 -251, -251,  100, -251,  100,  100,  343,  100,  100,  344,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -251, -251, -251, -251, -251, -251, -251, -251, -251, -251,
			 -251, -251, -251, -251, -251, -251, -251, -251, -251, -251,
			 -251, -251, -251, -251, -251, -251, -251, -251, -251, -251,
			 -251, -251, -251, -251, -251, -251, -251, -251, -251, -251,
			 -251, -251, -251, -251, -251, -251, -251, -251, -251, -251,
			 -251, -251, -251, -251, -251, -251, -251, -251, -251, -251,
			 -251, -251, -251, -251, -251, -251, -251, -251, -251, -251,

			 -251, -251, -251, -251, -251, -251, -251, -251, -251, -251,
			 -251, -251, -251, -251, -251, -251, -251, -251, -251, -251,
			 -251, -251, -251, -251, -251, -251, -251, -251, -251, -251,
			 -251, -251, -251, -251, -251, -251, -251, -251, -251, -251,
			 -251, -251, -251, -251, -251, -251, -251, -251, -251, -251,
			 -251, -251, -251, -251, -251, -251, -251, -251, -251, -251,
			 -251, -251, -251, -251,    5, -252, -252, -252, -252, -252,
			 -252, -252, -252, -252, -252, -252, -252, -252, -252, -252,
			 -252, -252, -252, -252, -252, -252, -252, -252, -252, -252,
			 -252, -252, -252, -252, -252, -252, -252, -252, -252, -252,

			 -252, -252, -252, -252, -252, -252, -252, -252, -252, -252,
			 -252, -252,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -252, -252, -252, -252, -252, -252, -252,  100,
			  100,  100,  100,  345,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -252, -252, -252, -252,  100,
			 -252,  100,  100,  100,  100,  345,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -252, -252, -252,
			 -252, -252, -252, -252, -252, -252, -252, -252, -252, -252,

			 -252, -252, -252, -252, -252, -252, -252, -252, -252, -252,
			 -252, -252, -252, -252, -252, -252, -252, -252, -252, -252,
			 -252, -252, -252, -252, -252, -252, -252, -252, -252, -252,
			 -252, -252, -252, -252, -252, -252, -252, -252, -252, -252,
			 -252, -252, -252, -252, -252, -252, -252, -252, -252, -252,
			 -252, -252, -252, -252, -252, -252, -252, -252, -252, -252,
			 -252, -252, -252, -252, -252, -252, -252, -252, -252, -252,
			 -252, -252, -252, -252, -252, -252, -252, -252, -252, -252,
			 -252, -252, -252, -252, -252, -252, -252, -252, -252, -252,
			 -252, -252, -252, -252, -252, -252, -252, -252, -252, -252, yy_Dummy>>,
			1, 1000, 64000)
		end

	yy_nxt_template_66 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -252, -252, -252, -252, -252, -252, -252, -252, -252, -252,
			 -252, -252, -252, -252, -252, -252, -252, -252, -252, -252,
			 -252,    5, -253, -253, -253, -253, -253, -253, -253, -253,
			 -253, -253, -253, -253, -253, -253, -253, -253, -253, -253,
			 -253, -253, -253, -253, -253, -253, -253, -253, -253, -253,
			 -253, -253, -253, -253, -253, -253, -253, -253, -253, -253,
			 -253, -253, -253, -253, -253, -253, -253, -253, -253,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -253,
			 -253, -253, -253, -253, -253, -253,  346,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -253, -253, -253, -253,  100, -253,  346,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -253, -253, -253, -253, -253, -253,
			 -253, -253, -253, -253, -253, -253, -253, -253, -253, -253,
			 -253, -253, -253, -253, -253, -253, -253, -253, -253, -253,
			 -253, -253, -253, -253, -253, -253, -253, -253, -253, -253,
			 -253, -253, -253, -253, -253, -253, -253, -253, -253, -253,
			 -253, -253, -253, -253, -253, -253, -253, -253, -253, -253,

			 -253, -253, -253, -253, -253, -253, -253, -253, -253, -253,
			 -253, -253, -253, -253, -253, -253, -253, -253, -253, -253,
			 -253, -253, -253, -253, -253, -253, -253, -253, -253, -253,
			 -253, -253, -253, -253, -253, -253, -253, -253, -253, -253,
			 -253, -253, -253, -253, -253, -253, -253, -253, -253, -253,
			 -253, -253, -253, -253, -253, -253, -253, -253, -253, -253,
			 -253, -253, -253, -253, -253, -253, -253, -253, -253, -253,
			 -253, -253, -253, -253, -253, -253, -253, -253,    5, -254,
			 -254, -254, -254, -254, -254, -254, -254, -254, -254, -254,
			 -254, -254, -254, -254, -254, -254, -254, -254, -254, -254,

			 -254, -254, -254, -254, -254, -254, -254, -254, -254, -254,
			 -254, -254, -254, -254, -254, -254, -254, -254, -254, -254,
			 -254, -254, -254, -254, -254, -254,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -254, -254, -254, -254,
			 -254, -254, -254,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  347,  100,  100,  100,  100,  100, -254,
			 -254, -254, -254,  100, -254,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  347,  100,  100,  100,  100,

			  100, -254, -254, -254, -254, -254, -254, -254, -254, -254,
			 -254, -254, -254, -254, -254, -254, -254, -254, -254, -254,
			 -254, -254, -254, -254, -254, -254, -254, -254, -254, -254,
			 -254, -254, -254, -254, -254, -254, -254, -254, -254, -254,
			 -254, -254, -254, -254, -254, -254, -254, -254, -254, -254,
			 -254, -254, -254, -254, -254, -254, -254, -254, -254, -254,
			 -254, -254, -254, -254, -254, -254, -254, -254, -254, -254,
			 -254, -254, -254, -254, -254, -254, -254, -254, -254, -254,
			 -254, -254, -254, -254, -254, -254, -254, -254, -254, -254,
			 -254, -254, -254, -254, -254, -254, -254, -254, -254, -254,

			 -254, -254, -254, -254, -254, -254, -254, -254, -254, -254,
			 -254, -254, -254, -254, -254, -254, -254, -254, -254, -254,
			 -254, -254, -254, -254, -254, -254, -254, -254, -254, -254,
			 -254, -254, -254, -254, -254,    5, -255, -255, -255, -255,
			 -255, -255, -255, -255, -255, -255, -255, -255, -255, -255,
			 -255, -255, -255, -255, -255, -255, -255, -255, -255, -255,
			 -255, -255, -255, -255, -255, -255, -255, -255, -255, -255,
			 -255, -255, -255, -255, -255, -255, -255, -255, -255, -255,
			 -255, -255, -255,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -255, -255, -255, -255, -255, -255, -255,

			  100,  100,  348,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  349,  100,  100,  100,  100,  100, -255, -255, -255, -255,
			  100, -255,  100,  100,  348,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  349,  100,  100,  100,  100,  100, -255, -255,
			 -255, -255, -255, -255, -255, -255, -255, -255, -255, -255,
			 -255, -255, -255, -255, -255, -255, -255, -255, -255, -255,
			 -255, -255, -255, -255, -255, -255, -255, -255, -255, -255,
			 -255, -255, -255, -255, -255, -255, -255, -255, -255, -255,

			 -255, -255, -255, -255, -255, -255, -255, -255, -255, -255,
			 -255, -255, -255, -255, -255, -255, -255, -255, -255, -255,
			 -255, -255, -255, -255, -255, -255, -255, -255, -255, -255,
			 -255, -255, -255, -255, -255, -255, -255, -255, -255, -255,
			 -255, -255, -255, -255, -255, -255, -255, -255, -255, -255,
			 -255, -255, -255, -255, -255, -255, -255, -255, -255, -255,
			 -255, -255, -255, -255, -255, -255, -255, -255, -255, -255,
			 -255, -255, -255, -255, -255, -255, -255, -255, -255, -255,
			 -255, -255, -255, -255, -255, -255, -255, -255, -255, -255,
			 -255, -255,    5, -256, -256, -256, -256, -256, -256, -256,

			 -256, -256, -256, -256, -256, -256, -256, -256, -256, -256,
			 -256, -256, -256, -256, -256, -256, -256, -256, -256, -256,
			 -256, -256, -256, -256, -256, -256, -256, -256, -256, -256,
			 -256, -256, -256, -256, -256, -256, -256, -256, -256, -256,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -256, -256, -256, -256, -256, -256, -256,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  350,  100,  100,  100,  100,  100,
			  100,  100,  100, -256, -256, -256, -256,  100, -256,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  350,  100,  100,  100,
			  100,  100,  100,  100,  100, -256, -256, -256, -256, -256,
			 -256, -256, -256, -256, -256, -256, -256, -256, -256, -256,
			 -256, -256, -256, -256, -256, -256, -256, -256, -256, -256,
			 -256, -256, -256, -256, -256, -256, -256, -256, -256, -256,
			 -256, -256, -256, -256, -256, -256, -256, -256, -256, -256,
			 -256, -256, -256, -256, -256, -256, -256, -256, -256, -256,
			 -256, -256, -256, -256, -256, -256, -256, -256, -256, -256,
			 -256, -256, -256, -256, -256, -256, -256, -256, -256, -256,
			 -256, -256, -256, -256, -256, -256, -256, -256, -256, -256, yy_Dummy>>,
			1, 1000, 65000)
		end

	yy_nxt_template_67 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -256, -256, -256, -256, -256, -256, -256, -256, -256, -256,
			 -256, -256, -256, -256, -256, -256, -256, -256, -256, -256,
			 -256, -256, -256, -256, -256, -256, -256, -256, -256, -256,
			 -256, -256, -256, -256, -256, -256, -256, -256, -256, -256,
			 -256, -256, -256, -256, -256, -256, -256, -256, -256,    5,
			 -257, -257, -257, -257, -257, -257, -257, -257, -257, -257,
			 -257, -257, -257, -257, -257, -257, -257, -257, -257, -257,
			 -257, -257, -257, -257, -257, -257, -257, -257, -257, -257,
			 -257, -257, -257, -257, -257, -257, -257, -257, -257, -257,
			 -257, -257, -257, -257, -257, -257, -257,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100, -257, -257, -257,
			 -257, -257, -257, -257,  100,  100,  100,  100,  351,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -257, -257, -257, -257,  100, -257,  100,  100,  100,  100,
			  351,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -257, -257, -257, -257, -257, -257, -257, -257,
			 -257, -257, -257, -257, -257, -257, -257, -257, -257, -257,
			 -257, -257, -257, -257, -257, -257, -257, -257, -257, -257,

			 -257, -257, -257, -257, -257, -257, -257, -257, -257, -257,
			 -257, -257, -257, -257, -257, -257, -257, -257, -257, -257,
			 -257, -257, -257, -257, -257, -257, -257, -257, -257, -257,
			 -257, -257, -257, -257, -257, -257, -257, -257, -257, -257,
			 -257, -257, -257, -257, -257, -257, -257, -257, -257, -257,
			 -257, -257, -257, -257, -257, -257, -257, -257, -257, -257,
			 -257, -257, -257, -257, -257, -257, -257, -257, -257, -257,
			 -257, -257, -257, -257, -257, -257, -257, -257, -257, -257,
			 -257, -257, -257, -257, -257, -257, -257, -257, -257, -257,
			 -257, -257, -257, -257, -257, -257, -257, -257, -257, -257,

			 -257, -257, -257, -257, -257, -257,    5, -258, -258, -258,
			 -258, -258, -258, -258, -258, -258, -258, -258, -258, -258,
			 -258, -258, -258, -258, -258, -258, -258, -258, -258, -258,
			 -258, -258, -258, -258, -258, -258, -258, -258, -258, -258,
			 -258, -258, -258, -258, -258, -258, -258, -258, -258, -258,
			 -258, -258, -258, -258,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -258, -258, -258, -258, -258, -258,
			 -258,  352,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -258, -258, -258,

			 -258,  100, -258,  352,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -258,
			 -258, -258, -258, -258, -258, -258, -258, -258, -258, -258,
			 -258, -258, -258, -258, -258, -258, -258, -258, -258, -258,
			 -258, -258, -258, -258, -258, -258, -258, -258, -258, -258,
			 -258, -258, -258, -258, -258, -258, -258, -258, -258, -258,
			 -258, -258, -258, -258, -258, -258, -258, -258, -258, -258,
			 -258, -258, -258, -258, -258, -258, -258, -258, -258, -258,
			 -258, -258, -258, -258, -258, -258, -258, -258, -258, -258,

			 -258, -258, -258, -258, -258, -258, -258, -258, -258, -258,
			 -258, -258, -258, -258, -258, -258, -258, -258, -258, -258,
			 -258, -258, -258, -258, -258, -258, -258, -258, -258, -258,
			 -258, -258, -258, -258, -258, -258, -258, -258, -258, -258,
			 -258, -258, -258, -258, -258, -258, -258, -258, -258, -258,
			 -258, -258, -258, -258, -258, -258, -258, -258, -258, -258,
			 -258, -258, -258,    5, -259, -259, -259, -259, -259, -259,
			 -259, -259, -259, -259, -259, -259, -259, -259, -259, -259,
			 -259, -259, -259, -259, -259, -259, -259, -259, -259, -259,
			 -259, -259, -259, -259, -259, -259, -259, -259, -259, -259,

			 -259, -259, -259, -259, -259, -259, -259, -259, -259, -259,
			 -259,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -259, -259, -259, -259, -259, -259, -259,  100,  100,
			  100,  100,  100,  100,  100,  100,  353,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -259, -259, -259, -259,  100, -259,
			  100,  100,  100,  100,  100,  100,  100,  100,  353,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -259, -259, -259, -259,
			 -259, -259, -259, -259, -259, -259, -259, -259, -259, -259,

			 -259, -259, -259, -259, -259, -259, -259, -259, -259, -259,
			 -259, -259, -259, -259, -259, -259, -259, -259, -259, -259,
			 -259, -259, -259, -259, -259, -259, -259, -259, -259, -259,
			 -259, -259, -259, -259, -259, -259, -259, -259, -259, -259,
			 -259, -259, -259, -259, -259, -259, -259, -259, -259, -259,
			 -259, -259, -259, -259, -259, -259, -259, -259, -259, -259,
			 -259, -259, -259, -259, -259, -259, -259, -259, -259, -259,
			 -259, -259, -259, -259, -259, -259, -259, -259, -259, -259,
			 -259, -259, -259, -259, -259, -259, -259, -259, -259, -259,
			 -259, -259, -259, -259, -259, -259, -259, -259, -259, -259,

			 -259, -259, -259, -259, -259, -259, -259, -259, -259, -259,
			 -259, -259, -259, -259, -259, -259, -259, -259, -259, -259,
			    5, -260, -260, -260, -260, -260, -260, -260, -260, -260,
			 -260, -260, -260, -260, -260, -260, -260, -260, -260, -260,
			 -260, -260, -260, -260, -260, -260, -260, -260, -260, -260,
			 -260, -260, -260, -260, -260, -260, -260, -260, -260, -260,
			 -260, -260, -260, -260, -260, -260, -260, -260,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -260, -260,
			 -260, -260, -260, -260, -260,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  354,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -260, -260, -260, -260,  100, -260,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  354,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -260, -260, -260, -260, -260, -260, -260,
			 -260, -260, -260, -260, -260, -260, -260, -260, -260, -260,
			 -260, -260, -260, -260, -260, -260, -260, -260, -260, -260,
			 -260, -260, -260, -260, -260, -260, -260, -260, -260, -260,
			 -260, -260, -260, -260, -260, -260, -260, -260, -260, -260,
			 -260, -260, -260, -260, -260, -260, -260, -260, -260, -260, yy_Dummy>>,
			1, 1000, 66000)
		end

	yy_nxt_template_68 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -260, -260, -260, -260, -260, -260, -260, -260, -260, -260,
			 -260, -260, -260, -260, -260, -260, -260, -260, -260, -260,
			 -260, -260, -260, -260, -260, -260, -260, -260, -260, -260,
			 -260, -260, -260, -260, -260, -260, -260, -260, -260, -260,
			 -260, -260, -260, -260, -260, -260, -260, -260, -260, -260,
			 -260, -260, -260, -260, -260, -260, -260, -260, -260, -260,
			 -260, -260, -260, -260, -260, -260, -260, -260, -260, -260,
			 -260, -260, -260, -260, -260, -260, -260,    5, -261, -261,
			 -261, -261, -261, -261, -261, -261, -261, -261, -261, -261,
			 -261, -261, -261, -261, -261, -261, -261, -261, -261, -261,

			 -261, -261, -261, -261, -261, -261, -261, -261, -261, -261,
			 -261, -261, -261, -261, -261, -261, -261, -261, -261, -261,
			 -261, -261, -261, -261, -261,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -261, -261, -261, -261, -261,
			 -261, -261,  100,  100,  100,  100,  355,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -261, -261,
			 -261, -261,  100, -261,  100,  100,  100,  100,  355,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			 -261, -261, -261, -261, -261, -261, -261, -261, -261, -261,
			 -261, -261, -261, -261, -261, -261, -261, -261, -261, -261,
			 -261, -261, -261, -261, -261, -261, -261, -261, -261, -261,
			 -261, -261, -261, -261, -261, -261, -261, -261, -261, -261,
			 -261, -261, -261, -261, -261, -261, -261, -261, -261, -261,
			 -261, -261, -261, -261, -261, -261, -261, -261, -261, -261,
			 -261, -261, -261, -261, -261, -261, -261, -261, -261, -261,
			 -261, -261, -261, -261, -261, -261, -261, -261, -261, -261,
			 -261, -261, -261, -261, -261, -261, -261, -261, -261, -261,
			 -261, -261, -261, -261, -261, -261, -261, -261, -261, -261,

			 -261, -261, -261, -261, -261, -261, -261, -261, -261, -261,
			 -261, -261, -261, -261, -261, -261, -261, -261, -261, -261,
			 -261, -261, -261, -261, -261, -261, -261, -261, -261, -261,
			 -261, -261, -261, -261,    5, -262, -262, -262, -262, -262,
			 -262, -262, -262, -262, -262, -262, -262, -262, -262, -262,
			 -262, -262, -262, -262, -262, -262, -262, -262, -262, -262,
			 -262, -262, -262, -262, -262, -262, -262, -262, -262, -262,
			 -262, -262, -262, -262, -262, -262, -262, -262, -262, -262,
			 -262, -262,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -262, -262, -262, -262, -262, -262, -262,  100,

			  100,  100,  100,  356,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -262, -262, -262, -262,  100,
			 -262,  100,  100,  100,  100,  356,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -262, -262, -262,
			 -262, -262, -262, -262, -262, -262, -262, -262, -262, -262,
			 -262, -262, -262, -262, -262, -262, -262, -262, -262, -262,
			 -262, -262, -262, -262, -262, -262, -262, -262, -262, -262,
			 -262, -262, -262, -262, -262, -262, -262, -262, -262, -262,

			 -262, -262, -262, -262, -262, -262, -262, -262, -262, -262,
			 -262, -262, -262, -262, -262, -262, -262, -262, -262, -262,
			 -262, -262, -262, -262, -262, -262, -262, -262, -262, -262,
			 -262, -262, -262, -262, -262, -262, -262, -262, -262, -262,
			 -262, -262, -262, -262, -262, -262, -262, -262, -262, -262,
			 -262, -262, -262, -262, -262, -262, -262, -262, -262, -262,
			 -262, -262, -262, -262, -262, -262, -262, -262, -262, -262,
			 -262, -262, -262, -262, -262, -262, -262, -262, -262, -262,
			 -262, -262, -262, -262, -262, -262, -262, -262, -262, -262,
			 -262,    5, -263, -263, -263, -263, -263, -263, -263, -263,

			 -263, -263, -263, -263, -263, -263, -263, -263, -263, -263,
			 -263, -263, -263, -263, -263, -263, -263, -263, -263, -263,
			 -263, -263, -263, -263, -263, -263, -263, -263, -263, -263,
			 -263, -263, -263, -263, -263, -263, -263, -263, -263,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -263,
			 -263, -263, -263, -263, -263, -263,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  357,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -263, -263, -263, -263,  100, -263,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  357,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -263, -263, -263, -263, -263, -263,
			 -263, -263, -263, -263, -263, -263, -263, -263, -263, -263,
			 -263, -263, -263, -263, -263, -263, -263, -263, -263, -263,
			 -263, -263, -263, -263, -263, -263, -263, -263, -263, -263,
			 -263, -263, -263, -263, -263, -263, -263, -263, -263, -263,
			 -263, -263, -263, -263, -263, -263, -263, -263, -263, -263,
			 -263, -263, -263, -263, -263, -263, -263, -263, -263, -263,
			 -263, -263, -263, -263, -263, -263, -263, -263, -263, -263,
			 -263, -263, -263, -263, -263, -263, -263, -263, -263, -263,

			 -263, -263, -263, -263, -263, -263, -263, -263, -263, -263,
			 -263, -263, -263, -263, -263, -263, -263, -263, -263, -263,
			 -263, -263, -263, -263, -263, -263, -263, -263, -263, -263,
			 -263, -263, -263, -263, -263, -263, -263, -263, -263, -263,
			 -263, -263, -263, -263, -263, -263, -263, -263,    5, -264,
			 -264, -264, -264, -264, -264, -264, -264, -264, -264, -264,
			 -264, -264, -264, -264, -264, -264, -264, -264, -264, -264,
			 -264, -264, -264, -264, -264, -264, -264, -264, -264, -264,
			 -264, -264, -264, -264, -264, -264, -264, -264, -264, -264,
			 -264, -264, -264, -264, -264, -264,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100, -264, -264, -264, -264,
			 -264, -264, -264,  100,  100,  100,  100,  100,  100,  100,
			  100,  358,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -264,
			 -264, -264, -264,  100, -264,  100,  100,  100,  100,  100,
			  100,  100,  100,  358,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -264, -264, -264, -264, -264, -264, -264, -264, -264,
			 -264, -264, -264, -264, -264, -264, -264, -264, -264, -264,
			 -264, -264, -264, -264, -264, -264, -264, -264, -264, -264, yy_Dummy>>,
			1, 1000, 67000)
		end

	yy_nxt_template_69 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -264, -264, -264, -264, -264, -264, -264, -264, -264, -264,
			 -264, -264, -264, -264, -264, -264, -264, -264, -264, -264,
			 -264, -264, -264, -264, -264, -264, -264, -264, -264, -264,
			 -264, -264, -264, -264, -264, -264, -264, -264, -264, -264,
			 -264, -264, -264, -264, -264, -264, -264, -264, -264, -264,
			 -264, -264, -264, -264, -264, -264, -264, -264, -264, -264,
			 -264, -264, -264, -264, -264, -264, -264, -264, -264, -264,
			 -264, -264, -264, -264, -264, -264, -264, -264, -264, -264,
			 -264, -264, -264, -264, -264, -264, -264, -264, -264, -264,
			 -264, -264, -264, -264, -264, -264, -264, -264, -264, -264,

			 -264, -264, -264, -264, -264,    5, -265, -265, -265, -265,
			 -265, -265, -265, -265, -265, -265, -265, -265, -265, -265,
			 -265, -265, -265, -265, -265, -265, -265, -265, -265, -265,
			 -265, -265, -265, -265, -265, -265, -265, -265, -265, -265,
			 -265, -265, -265, -265, -265, -265, -265, -265, -265, -265,
			 -265, -265, -265,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -265, -265, -265, -265, -265, -265, -265,
			  100,  100,  100,  100,  100,  100,  100,  100,  359,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -265, -265, -265, -265,

			  100, -265,  100,  100,  100,  100,  100,  100,  100,  100,
			  359,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -265, -265,
			 -265, -265, -265, -265, -265, -265, -265, -265, -265, -265,
			 -265, -265, -265, -265, -265, -265, -265, -265, -265, -265,
			 -265, -265, -265, -265, -265, -265, -265, -265, -265, -265,
			 -265, -265, -265, -265, -265, -265, -265, -265, -265, -265,
			 -265, -265, -265, -265, -265, -265, -265, -265, -265, -265,
			 -265, -265, -265, -265, -265, -265, -265, -265, -265, -265,
			 -265, -265, -265, -265, -265, -265, -265, -265, -265, -265,

			 -265, -265, -265, -265, -265, -265, -265, -265, -265, -265,
			 -265, -265, -265, -265, -265, -265, -265, -265, -265, -265,
			 -265, -265, -265, -265, -265, -265, -265, -265, -265, -265,
			 -265, -265, -265, -265, -265, -265, -265, -265, -265, -265,
			 -265, -265, -265, -265, -265, -265, -265, -265, -265, -265,
			 -265, -265, -265, -265, -265, -265, -265, -265, -265, -265,
			 -265, -265,    5, -266, -266, -266, -266, -266, -266, -266,
			 -266, -266, -266, -266, -266, -266, -266, -266, -266, -266,
			 -266, -266, -266, -266, -266, -266, -266, -266, -266, -266,
			 -266, -266, -266, -266, -266, -266, -266, -266, -266, -266,

			 -266, -266, -266, -266, -266, -266, -266, -266, -266, -266,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -266, -266, -266, -266, -266, -266, -266,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  360,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -266, -266, -266, -266,  100, -266,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  360,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -266, -266, -266, -266, -266,
			 -266, -266, -266, -266, -266, -266, -266, -266, -266, -266,

			 -266, -266, -266, -266, -266, -266, -266, -266, -266, -266,
			 -266, -266, -266, -266, -266, -266, -266, -266, -266, -266,
			 -266, -266, -266, -266, -266, -266, -266, -266, -266, -266,
			 -266, -266, -266, -266, -266, -266, -266, -266, -266, -266,
			 -266, -266, -266, -266, -266, -266, -266, -266, -266, -266,
			 -266, -266, -266, -266, -266, -266, -266, -266, -266, -266,
			 -266, -266, -266, -266, -266, -266, -266, -266, -266, -266,
			 -266, -266, -266, -266, -266, -266, -266, -266, -266, -266,
			 -266, -266, -266, -266, -266, -266, -266, -266, -266, -266,
			 -266, -266, -266, -266, -266, -266, -266, -266, -266, -266,

			 -266, -266, -266, -266, -266, -266, -266, -266, -266, -266,
			 -266, -266, -266, -266, -266, -266, -266, -266, -266,    5,
			 -267, -267, -267, -267, -267, -267, -267, -267, -267, -267,
			 -267, -267, -267, -267, -267, -267, -267, -267, -267, -267,
			 -267, -267, -267, -267, -267, -267, -267, -267, -267, -267,
			 -267, -267, -267, -267, -267, -267, -267, -267, -267, -267,
			 -267, -267, -267, -267, -267, -267, -267,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -267, -267, -267,
			 -267, -267, -267, -267,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -267, -267, -267, -267,  100, -267,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -267, -267, -267, -267, -267, -267, -267, -267,
			 -267, -267, -267, -267, -267, -267, -267, -267, -267, -267,
			 -267, -267, -267, -267, -267, -267, -267, -267, -267, -267,
			 -267, -267, -267, -267, -267, -267, -267, -267, -267, -267,
			 -267, -267, -267, -267, -267, -267, -267, -267, -267, -267,
			 -267, -267, -267, -267, -267, -267, -267, -267, -267, -267,

			 -267, -267, -267, -267, -267, -267, -267, -267, -267, -267,
			 -267, -267, -267, -267, -267, -267, -267, -267, -267, -267,
			 -267, -267, -267, -267, -267, -267, -267, -267, -267, -267,
			 -267, -267, -267, -267, -267, -267, -267, -267, -267, -267,
			 -267, -267, -267, -267, -267, -267, -267, -267, -267, -267,
			 -267, -267, -267, -267, -267, -267, -267, -267, -267, -267,
			 -267, -267, -267, -267, -267, -267, -267, -267, -267, -267,
			 -267, -267, -267, -267, -267, -267,    5, -268, -268, -268,
			 -268, -268, -268, -268, -268,  268,  144, -268, -268,  268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,

			 -268, -268, -268, -268, -268, -268, -268, -268,  268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268, yy_Dummy>>,
			1, 1000, 68000)
		end

	yy_nxt_template_70 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,

			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268, -268, -268, -268, -268, -268, -268, -268,
			 -268, -268, -268,    5, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,

			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,

			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			 -269, -269, -269, -269, -269, -269, -269, -269, -269, -269,
			    5, -270, -270, -270, -270, -270, -270, -270, -270, -270,

			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270,  361,  270,  270,
			  270,  270,  270,  270,  270,  270,  270,  270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,

			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,

			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270, -270, -270, -270,
			 -270, -270, -270, -270, -270, -270, -270,    5, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,

			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,

			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,
			 -271, -271, -271, -271, -271, -271, -271, -271, -271, -271,

			 -271, -271, -271, -271,    5, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272, yy_Dummy>>,
			1, 1000, 69000)
		end

	yy_nxt_template_71 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,

			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272, -272, -272, -272, -272, -272, -272, -272, -272, -272,
			 -272,    5, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,

			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,

			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,

			 -273, -273, -273, -273, -273, -273, -273, -273, -273, -273,
			 -273, -273, -273, -273, -273, -273, -273, -273,    5,   63,
			   63,   63,   63,   63,   63,   63,   63,   63, -274,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			  362,   63,  363,   63,   63, -274,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,    5,   63,   63,   63,   63,
			   63,   63,   63,   63,   63, -275,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   64,
			   63,   63, -275,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,  364,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,  364,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,    5,   63,   63,   63,   63,   63,   63,   63,
			   63,   63, -276,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,  365,   63,   63, -276,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63, yy_Dummy>>,
			1, 1000, 70000)
		end

	yy_nxt_template_72 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,    5,
			   63,   63,   63,   63,   63,   63,   63,   63,   63, -277,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   64,   63,   63, -277,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,  366,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			  366,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,    5, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,

			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,

			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,
			 -278, -278, -278, -278, -278, -278, -278, -278, -278, -278,

			 -278, -278, -278,    5,   63,   63,   63,   63,   63,   63,
			   63,   63,   63, -279,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,  367,   63,   63,
			 -279,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			    5, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280, yy_Dummy>>,
			1, 1000, 71000)
		end

	yy_nxt_template_73 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,

			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,

			 -280, -280, -280, -280, -280, -280, -280, -280, -280, -280,
			 -280, -280, -280, -280, -280, -280, -280,    5, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,

			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,

			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281, -281, -281, -281, -281, -281, -281,
			 -281, -281, -281, -281,    5, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,

			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,

			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,

			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282, -282, -282, -282, -282, -282, -282, -282, -282, -282,
			 -282,    5, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,

			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,

			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283, -283, -283,
			 -283, -283, -283, -283, -283, -283, -283, -283,    5, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284, yy_Dummy>>,
			1, 1000, 72000)
		end

	yy_nxt_template_74 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,

			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,

			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284, -284, -284, -284, -284, -284,
			 -284, -284, -284, -284, -284,    5, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,

			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,

			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,
			 -285, -285, -285, -285, -285, -285, -285, -285, -285, -285,

			 -285, -285,    5, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,

			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,

			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286, -286,
			 -286, -286, -286, -286, -286, -286, -286, -286, -286,    5,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,

			 -287, -287, -287, -287, -287, -287,  368,  287,  287,  287,
			  287,  287,  287,  287,  287,  287,  287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,

			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287, yy_Dummy>>,
			1, 1000, 73000)
		end

	yy_nxt_template_75 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -287, -287, -287, -287, -287, -287, -287, -287, -287, -287,
			 -287, -287, -287, -287, -287, -287,    5, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,

			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,

			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288, -288, -288, -288, -288, -288, -288, -288,
			 -288, -288, -288,    5, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,

			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,

			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,

			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			 -289, -289, -289, -289, -289, -289, -289, -289, -289, -289,
			    5, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,

			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,

			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290, -290, -290, -290,
			 -290, -290, -290, -290, -290, -290, -290,    5, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,

			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,

			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291, yy_Dummy>>,
			1, 1000, 74000)
		end

	yy_nxt_template_76 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291, -291, -291, -291, -291, -291, -291,
			 -291, -291, -291, -291,    5, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,

			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,

			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,
			 -292, -292, -292, -292, -292, -292, -292, -292, -292, -292,

			 -292,    5, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,

			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,

			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293, -293, -293,
			 -293, -293, -293, -293, -293, -293, -293, -293,    5, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,

			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,

			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,

			 -294, -294, -294, -294, -294, -294, -294, -294, -294, -294,
			 -294, -294, -294, -294, -294,    5, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,

			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295, yy_Dummy>>,
			1, 1000, 75000)
		end

	yy_nxt_template_77 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295, -295, -295, -295, -295, -295, -295, -295, -295,
			 -295, -295,    5, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,

			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,

			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,

			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296, -296,
			 -296, -296, -296, -296, -296, -296, -296, -296, -296,    5,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,

			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,

			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297, -297, -297, -297, -297,
			 -297, -297, -297, -297, -297, -297,    5, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,

			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,

			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,

			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298, -298, -298, -298, -298, -298, -298, -298,
			 -298, -298, -298,    5, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,

			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299, yy_Dummy>>,
			1, 1000, 76000)
		end

	yy_nxt_template_78 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,
			 -299, -299, -299, -299, -299, -299, -299, -299, -299, -299,

			    5, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,

			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,

			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300, -300, -300, -300,
			 -300, -300, -300, -300, -300, -300, -300,    5, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,

			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,

			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,

			 -301, -301, -301, -301, -301, -301, -301, -301, -301, -301,
			 -301, -301, -301, -301,    5, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,

			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,

			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302, -302, -302, -302, -302, -302, -302, -302, -302, -302,
			 -302,    5, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,

			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303, yy_Dummy>>,
			1, 1000, 77000)
		end

	yy_nxt_template_79 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,

			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303, -303, -303,
			 -303, -303, -303, -303, -303, -303, -303, -303,    5, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304,  369,  369,  369,  369,
			  369,  369,  369,  369,  369,  369, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304,  212, -304, -304,

			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304,  213, -304, -304, -304, -304, -304,  212,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,

			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304, -304, -304, -304, -304, -304,
			 -304, -304, -304, -304, -304,    5, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,

			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305,  306,  306,  306,  306,  306,  306,  306,
			  306,  306,  306, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,

			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,

			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305, -305, -305, -305, -305, -305, -305, -305, -305,
			 -305, -305,    5, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			  370,  370,  370,  370,  370,  370,  370,  370,  370,  370,

			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306,  371, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,

			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306, -306,
			 -306, -306, -306, -306, -306, -306, -306, -306, -306,    5,

			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307,  372,  372,  372,
			  372,  372,  372,  372,  372,  372,  372, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307, yy_Dummy>>,
			1, 1000, 78000)
		end

	yy_nxt_template_80 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,

			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307, -307, -307, -307, -307,
			 -307, -307, -307, -307, -307, -307,    5, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,

			 -308, -308, -308, -308,  373,  373,  373,  373,  373,  373,
			  373,  373,  373,  373, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308,  309, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308,  310, -308, -308, -308, -308, -308,  309, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,

			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,

			 -308, -308, -308, -308, -308, -308, -308, -308, -308, -308,
			 -308, -308, -308,    5, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309,  374, -309,  374, -309,
			 -309,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,

			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,

			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			 -309, -309, -309, -309, -309, -309, -309, -309, -309, -309,
			    5, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,

			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310,  376,  376,
			  376,  376,  376,  376,  376,  376,  376,  376, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,

			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,

			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310,    5, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311,  312,  312,  312,  312,  312,
			  312,  312,  312,  312,  312, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311, yy_Dummy>>,
			1, 1000, 79000)
		end

	yy_nxt_template_81 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,

			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311, -311, -311, -311, -311, -311, -311,
			 -311, -311, -311, -311,    5, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,

			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312,  377,  377,  377,  377,  377,  377,  377,  377,
			  377,  377, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312,  378,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,

			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,

			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312, -312, -312, -312, -312, -312, -312, -312, -312, -312,
			 -312,    5, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313,  379, -313,  313,
			  313,  314,  314,  314,  314,  314,  314,  314,  314, -313,

			 -313, -313, -313, -313, -313, -313, -313,   92, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313,  139, -313, -313,   92,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,

			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313, -313, -313,
			 -313, -313, -313, -313, -313, -313, -313, -313,    5, -314,

			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314,  379, -314,  314,  314,  314,  314,
			  314,  314,  314,  314,  314,  314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314,  139, -314, -314, -314, -314, -314, -314,

			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,

			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314, -314, -314, -314, -314, -314,
			 -314, -314, -314, -314, -314,    5, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315, yy_Dummy>>,
			1, 1000, 80000)
		end

	yy_nxt_template_82 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -315, -315, -315,  380,  380,  380,  380,  380,  380,  380,
			  380,  380,  380, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			  139, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,

			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,

			 -315, -315, -315, -315, -315, -315, -315, -315, -315, -315,
			 -315, -315,    5, -316, -316, -316, -316, -316, -316, -316,
			 -316, -316, -316, -316, -316, -316, -316, -316, -316, -316,
			 -316, -316, -316, -316, -316, -316, -316, -316, -316, -316,
			 -316, -316, -316, -316, -316, -316, -316, -316, -316, -316,
			 -316, -316, -316, -316, -316, -316, -316, -316, -316, -316,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -316, -316, -316, -316, -316, -316, -316,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  381,  100,  100,  100,  100,

			  100,  100,  100, -316, -316, -316, -316,  100, -316,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  381,  100,  100,
			  100,  100,  100,  100,  100, -316, -316, -316, -316, -316,
			 -316, -316, -316, -316, -316, -316, -316, -316, -316, -316,
			 -316, -316, -316, -316, -316, -316, -316, -316, -316, -316,
			 -316, -316, -316, -316, -316, -316, -316, -316, -316, -316,
			 -316, -316, -316, -316, -316, -316, -316, -316, -316, -316,
			 -316, -316, -316, -316, -316, -316, -316, -316, -316, -316,
			 -316, -316, -316, -316, -316, -316, -316, -316, -316, -316,

			 -316, -316, -316, -316, -316, -316, -316, -316, -316, -316,
			 -316, -316, -316, -316, -316, -316, -316, -316, -316, -316,
			 -316, -316, -316, -316, -316, -316, -316, -316, -316, -316,
			 -316, -316, -316, -316, -316, -316, -316, -316, -316, -316,
			 -316, -316, -316, -316, -316, -316, -316, -316, -316, -316,
			 -316, -316, -316, -316, -316, -316, -316, -316, -316, -316,
			 -316, -316, -316, -316, -316, -316, -316, -316, -316,    5,
			 -317, -317, -317, -317, -317, -317, -317, -317, -317, -317,
			 -317, -317, -317, -317, -317, -317, -317, -317, -317, -317,
			 -317, -317, -317, -317, -317, -317, -317, -317, -317, -317,

			 -317, -317, -317, -317, -317, -317, -317, -317, -317, -317,
			 -317, -317, -317, -317, -317, -317, -317,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -317, -317, -317,
			 -317, -317, -317, -317,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  382,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -317, -317, -317, -317,  100, -317,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  382,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -317, -317, -317, -317, -317, -317, -317, -317,

			 -317, -317, -317, -317, -317, -317, -317, -317, -317, -317,
			 -317, -317, -317, -317, -317, -317, -317, -317, -317, -317,
			 -317, -317, -317, -317, -317, -317, -317, -317, -317, -317,
			 -317, -317, -317, -317, -317, -317, -317, -317, -317, -317,
			 -317, -317, -317, -317, -317, -317, -317, -317, -317, -317,
			 -317, -317, -317, -317, -317, -317, -317, -317, -317, -317,
			 -317, -317, -317, -317, -317, -317, -317, -317, -317, -317,
			 -317, -317, -317, -317, -317, -317, -317, -317, -317, -317,
			 -317, -317, -317, -317, -317, -317, -317, -317, -317, -317,
			 -317, -317, -317, -317, -317, -317, -317, -317, -317, -317,

			 -317, -317, -317, -317, -317, -317, -317, -317, -317, -317,
			 -317, -317, -317, -317, -317, -317, -317, -317, -317, -317,
			 -317, -317, -317, -317, -317, -317,    5, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -318, -318, -318, -318, -318, -318,
			 -318,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  383,
			  100,  100,  100,  100,  100,  100,  100, -318, -318, -318,
			 -318,  100, -318,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  383,  100,  100,  100,  100,  100,  100,  100, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,

			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318,    5, -319, -319, -319, -319, -319, -319,
			 -319, -319, -319, -319, -319, -319, -319, -319, -319, -319, yy_Dummy>>,
			1, 1000, 81000)
		end

	yy_nxt_template_83 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -319, -319, -319, -319, -319, -319, -319, -319, -319, -319,
			 -319, -319, -319, -319, -319, -319, -319, -319, -319, -319,
			 -319, -319, -319, -319, -319, -319, -319, -319, -319, -319,
			 -319,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -319, -319, -319, -319, -319, -319, -319,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  384,  100,  100,
			  100,  100,  100,  100, -319, -319, -319, -319,  100, -319,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  384,

			  100,  100,  100,  100,  100,  100, -319, -319, -319, -319,
			 -319, -319, -319, -319, -319, -319, -319, -319, -319, -319,
			 -319, -319, -319, -319, -319, -319, -319, -319, -319, -319,
			 -319, -319, -319, -319, -319, -319, -319, -319, -319, -319,
			 -319, -319, -319, -319, -319, -319, -319, -319, -319, -319,
			 -319, -319, -319, -319, -319, -319, -319, -319, -319, -319,
			 -319, -319, -319, -319, -319, -319, -319, -319, -319, -319,
			 -319, -319, -319, -319, -319, -319, -319, -319, -319, -319,
			 -319, -319, -319, -319, -319, -319, -319, -319, -319, -319,
			 -319, -319, -319, -319, -319, -319, -319, -319, -319, -319,

			 -319, -319, -319, -319, -319, -319, -319, -319, -319, -319,
			 -319, -319, -319, -319, -319, -319, -319, -319, -319, -319,
			 -319, -319, -319, -319, -319, -319, -319, -319, -319, -319,
			 -319, -319, -319, -319, -319, -319, -319, -319, -319, -319,
			    5, -320, -320, -320, -320, -320, -320, -320, -320, -320,
			 -320, -320, -320, -320, -320, -320, -320, -320, -320, -320,
			 -320, -320, -320, -320, -320, -320, -320, -320, -320, -320,
			 -320, -320, -320, -320, -320, -320, -320, -320, -320, -320,
			 -320, -320, -320, -320, -320, -320, -320, -320,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -320, -320,

			 -320, -320, -320, -320, -320,  100,  100,  100,  100,  385,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -320, -320, -320, -320,  100, -320,  100,  100,  100,
			  100,  385,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -320, -320, -320, -320, -320, -320, -320,
			 -320, -320, -320, -320, -320, -320, -320, -320, -320, -320,
			 -320, -320, -320, -320, -320, -320, -320, -320, -320, -320,
			 -320, -320, -320, -320, -320, -320, -320, -320, -320, -320,

			 -320, -320, -320, -320, -320, -320, -320, -320, -320, -320,
			 -320, -320, -320, -320, -320, -320, -320, -320, -320, -320,
			 -320, -320, -320, -320, -320, -320, -320, -320, -320, -320,
			 -320, -320, -320, -320, -320, -320, -320, -320, -320, -320,
			 -320, -320, -320, -320, -320, -320, -320, -320, -320, -320,
			 -320, -320, -320, -320, -320, -320, -320, -320, -320, -320,
			 -320, -320, -320, -320, -320, -320, -320, -320, -320, -320,
			 -320, -320, -320, -320, -320, -320, -320, -320, -320, -320,
			 -320, -320, -320, -320, -320, -320, -320, -320, -320, -320,
			 -320, -320, -320, -320, -320, -320, -320,    5, -321, -321,

			 -321, -321, -321, -321, -321, -321, -321, -321, -321, -321,
			 -321, -321, -321, -321, -321, -321, -321, -321, -321, -321,
			 -321, -321, -321, -321, -321, -321, -321, -321, -321, -321,
			 -321, -321, -321, -321, -321, -321, -321, -321, -321, -321,
			 -321, -321, -321, -321, -321,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -321, -321, -321, -321, -321,
			 -321, -321,  100,  100,  100,  100,  100,  100,  386,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -321, -321,
			 -321, -321,  100, -321,  100,  100,  100,  100,  100,  100,

			  386,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -321, -321, -321, -321, -321, -321, -321, -321, -321, -321,
			 -321, -321, -321, -321, -321, -321, -321, -321, -321, -321,
			 -321, -321, -321, -321, -321, -321, -321, -321, -321, -321,
			 -321, -321, -321, -321, -321, -321, -321, -321, -321, -321,
			 -321, -321, -321, -321, -321, -321, -321, -321, -321, -321,
			 -321, -321, -321, -321, -321, -321, -321, -321, -321, -321,
			 -321, -321, -321, -321, -321, -321, -321, -321, -321, -321,
			 -321, -321, -321, -321, -321, -321, -321, -321, -321, -321,

			 -321, -321, -321, -321, -321, -321, -321, -321, -321, -321,
			 -321, -321, -321, -321, -321, -321, -321, -321, -321, -321,
			 -321, -321, -321, -321, -321, -321, -321, -321, -321, -321,
			 -321, -321, -321, -321, -321, -321, -321, -321, -321, -321,
			 -321, -321, -321, -321, -321, -321, -321, -321, -321, -321,
			 -321, -321, -321, -321,    5, -322, -322, -322, -322, -322,
			 -322, -322, -322, -322, -322, -322, -322, -322, -322, -322,
			 -322, -322, -322, -322, -322, -322, -322, -322, -322, -322,
			 -322, -322, -322, -322, -322, -322, -322, -322, -322, -322,
			 -322, -322, -322, -322, -322, -322, -322, -322, -322, -322,

			 -322, -322,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -322, -322, -322, -322, -322, -322, -322,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  387,  100,  100,  100,
			  100,  100,  100,  100,  100, -322, -322, -322, -322,  100,
			 -322,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  387,  100,
			  100,  100,  100,  100,  100,  100,  100, -322, -322, -322,
			 -322, -322, -322, -322, -322, -322, -322, -322, -322, -322,
			 -322, -322, -322, -322, -322, -322, -322, -322, -322, -322,

			 -322, -322, -322, -322, -322, -322, -322, -322, -322, -322,
			 -322, -322, -322, -322, -322, -322, -322, -322, -322, -322,
			 -322, -322, -322, -322, -322, -322, -322, -322, -322, -322,
			 -322, -322, -322, -322, -322, -322, -322, -322, -322, -322,
			 -322, -322, -322, -322, -322, -322, -322, -322, -322, -322,
			 -322, -322, -322, -322, -322, -322, -322, -322, -322, -322,
			 -322, -322, -322, -322, -322, -322, -322, -322, -322, -322,
			 -322, -322, -322, -322, -322, -322, -322, -322, -322, -322,
			 -322, -322, -322, -322, -322, -322, -322, -322, -322, -322,
			 -322, -322, -322, -322, -322, -322, -322, -322, -322, -322, yy_Dummy>>,
			1, 1000, 82000)
		end

	yy_nxt_template_84 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -322, -322, -322, -322, -322, -322, -322, -322, -322, -322,
			 -322,    5, -323, -323, -323, -323, -323, -323, -323, -323,
			 -323, -323, -323, -323, -323, -323, -323, -323, -323, -323,
			 -323, -323, -323, -323, -323, -323, -323, -323, -323, -323,
			 -323, -323, -323, -323, -323, -323, -323, -323, -323, -323,
			 -323, -323, -323, -323, -323, -323, -323, -323, -323,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -323,
			 -323, -323, -323, -323, -323, -323,  100,  100,  100,  100,
			  100,  100,  100,  100,  388,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100, -323, -323, -323, -323,  100, -323,  100,  100,
			  100,  100,  100,  100,  100,  100,  388,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -323, -323, -323, -323, -323, -323,
			 -323, -323, -323, -323, -323, -323, -323, -323, -323, -323,
			 -323, -323, -323, -323, -323, -323, -323, -323, -323, -323,
			 -323, -323, -323, -323, -323, -323, -323, -323, -323, -323,
			 -323, -323, -323, -323, -323, -323, -323, -323, -323, -323,
			 -323, -323, -323, -323, -323, -323, -323, -323, -323, -323,
			 -323, -323, -323, -323, -323, -323, -323, -323, -323, -323,

			 -323, -323, -323, -323, -323, -323, -323, -323, -323, -323,
			 -323, -323, -323, -323, -323, -323, -323, -323, -323, -323,
			 -323, -323, -323, -323, -323, -323, -323, -323, -323, -323,
			 -323, -323, -323, -323, -323, -323, -323, -323, -323, -323,
			 -323, -323, -323, -323, -323, -323, -323, -323, -323, -323,
			 -323, -323, -323, -323, -323, -323, -323, -323, -323, -323,
			 -323, -323, -323, -323, -323, -323, -323, -323,    5, -324,
			 -324, -324, -324, -324, -324, -324, -324, -324, -324, -324,
			 -324, -324, -324, -324, -324, -324, -324, -324, -324, -324,
			 -324, -324, -324, -324, -324, -324, -324, -324, -324, -324,

			 -324, -324, -324, -324, -324, -324, -324, -324, -324, -324,
			 -324, -324, -324, -324, -324, -324,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -324, -324, -324, -324,
			 -324, -324, -324,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  389,  100,  100,  100,  100,  100,  100,  100,  100, -324,
			 -324, -324, -324,  100, -324,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  389,  100,  100,  100,  100,  100,  100,  100,
			  100, -324, -324, -324, -324, -324, -324, -324, -324, -324,

			 -324, -324, -324, -324, -324, -324, -324, -324, -324, -324,
			 -324, -324, -324, -324, -324, -324, -324, -324, -324, -324,
			 -324, -324, -324, -324, -324, -324, -324, -324, -324, -324,
			 -324, -324, -324, -324, -324, -324, -324, -324, -324, -324,
			 -324, -324, -324, -324, -324, -324, -324, -324, -324, -324,
			 -324, -324, -324, -324, -324, -324, -324, -324, -324, -324,
			 -324, -324, -324, -324, -324, -324, -324, -324, -324, -324,
			 -324, -324, -324, -324, -324, -324, -324, -324, -324, -324,
			 -324, -324, -324, -324, -324, -324, -324, -324, -324, -324,
			 -324, -324, -324, -324, -324, -324, -324, -324, -324, -324,

			 -324, -324, -324, -324, -324, -324, -324, -324, -324, -324,
			 -324, -324, -324, -324, -324, -324, -324, -324, -324, -324,
			 -324, -324, -324, -324, -324,    5, -325, -325, -325, -325,
			 -325, -325, -325, -325, -325, -325, -325, -325, -325, -325,
			 -325, -325, -325, -325, -325, -325, -325, -325, -325, -325,
			 -325, -325, -325, -325, -325, -325, -325, -325, -325, -325,
			 -325, -325, -325, -325, -325, -325, -325, -325, -325, -325,
			 -325, -325, -325,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -325, -325, -325, -325, -325, -325, -325,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  390,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -325, -325, -325, -325,
			  100, -325,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  390,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -325, -325,
			 -325, -325, -325, -325, -325, -325, -325, -325, -325, -325,
			 -325, -325, -325, -325, -325, -325, -325, -325, -325, -325,
			 -325, -325, -325, -325, -325, -325, -325, -325, -325, -325,
			 -325, -325, -325, -325, -325, -325, -325, -325, -325, -325,
			 -325, -325, -325, -325, -325, -325, -325, -325, -325, -325,

			 -325, -325, -325, -325, -325, -325, -325, -325, -325, -325,
			 -325, -325, -325, -325, -325, -325, -325, -325, -325, -325,
			 -325, -325, -325, -325, -325, -325, -325, -325, -325, -325,
			 -325, -325, -325, -325, -325, -325, -325, -325, -325, -325,
			 -325, -325, -325, -325, -325, -325, -325, -325, -325, -325,
			 -325, -325, -325, -325, -325, -325, -325, -325, -325, -325,
			 -325, -325, -325, -325, -325, -325, -325, -325, -325, -325,
			 -325, -325, -325, -325, -325, -325, -325, -325, -325, -325,
			 -325, -325,    5, -326, -326, -326, -326, -326, -326, -326,
			 -326, -326, -326, -326, -326, -326, -326, -326, -326, -326,

			 -326, -326, -326, -326, -326, -326, -326, -326, -326, -326,
			 -326, -326, -326, -326, -326, -326, -326, -326, -326, -326,
			 -326, -326, -326, -326, -326, -326, -326, -326, -326, -326,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -326, -326, -326, -326, -326, -326, -326,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  391,  100,  100,  100,  100,  100,
			  100,  100,  100, -326, -326, -326, -326,  100, -326,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  391,  100,  100,  100,

			  100,  100,  100,  100,  100, -326, -326, -326, -326, -326,
			 -326, -326, -326, -326, -326, -326, -326, -326, -326, -326,
			 -326, -326, -326, -326, -326, -326, -326, -326, -326, -326,
			 -326, -326, -326, -326, -326, -326, -326, -326, -326, -326,
			 -326, -326, -326, -326, -326, -326, -326, -326, -326, -326,
			 -326, -326, -326, -326, -326, -326, -326, -326, -326, -326,
			 -326, -326, -326, -326, -326, -326, -326, -326, -326, -326,
			 -326, -326, -326, -326, -326, -326, -326, -326, -326, -326,
			 -326, -326, -326, -326, -326, -326, -326, -326, -326, -326,
			 -326, -326, -326, -326, -326, -326, -326, -326, -326, -326, yy_Dummy>>,
			1, 1000, 83000)
		end

	yy_nxt_template_85 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -326, -326, -326, -326, -326, -326, -326, -326, -326, -326,
			 -326, -326, -326, -326, -326, -326, -326, -326, -326, -326,
			 -326, -326, -326, -326, -326, -326, -326, -326, -326, -326,
			 -326, -326, -326, -326, -326, -326, -326, -326, -326,    5,
			 -327, -327, -327, -327, -327, -327, -327, -327, -327, -327,
			 -327, -327, -327, -327, -327, -327, -327, -327, -327, -327,
			 -327, -327, -327, -327, -327, -327, -327, -327, -327, -327,
			 -327, -327, -327, -327, -327, -327, -327, -327, -327, -327,
			 -327, -327, -327, -327, -327, -327, -327,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -327, -327, -327,

			 -327, -327, -327, -327,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  392,  100,  100,  100,  100,  100,  100,  100,  100,
			 -327, -327, -327, -327,  100, -327,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  392,  100,  100,  100,  100,  100,  100,
			  100,  100, -327, -327, -327, -327, -327, -327, -327, -327,
			 -327, -327, -327, -327, -327, -327, -327, -327, -327, -327,
			 -327, -327, -327, -327, -327, -327, -327, -327, -327, -327,
			 -327, -327, -327, -327, -327, -327, -327, -327, -327, -327,

			 -327, -327, -327, -327, -327, -327, -327, -327, -327, -327,
			 -327, -327, -327, -327, -327, -327, -327, -327, -327, -327,
			 -327, -327, -327, -327, -327, -327, -327, -327, -327, -327,
			 -327, -327, -327, -327, -327, -327, -327, -327, -327, -327,
			 -327, -327, -327, -327, -327, -327, -327, -327, -327, -327,
			 -327, -327, -327, -327, -327, -327, -327, -327, -327, -327,
			 -327, -327, -327, -327, -327, -327, -327, -327, -327, -327,
			 -327, -327, -327, -327, -327, -327, -327, -327, -327, -327,
			 -327, -327, -327, -327, -327, -327, -327, -327, -327, -327,
			 -327, -327, -327, -327, -327, -327,    5, -328, -328, -328,

			 -328, -328, -328, -328, -328, -328, -328, -328, -328, -328,
			 -328, -328, -328, -328, -328, -328, -328, -328, -328, -328,
			 -328, -328, -328, -328, -328, -328, -328, -328, -328, -328,
			 -328, -328, -328, -328, -328, -328, -328, -328, -328, -328,
			 -328, -328, -328, -328,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -328, -328, -328, -328, -328, -328,
			 -328,  100,  100,  100,  100,  393,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -328, -328, -328,
			 -328,  100, -328,  100,  100,  100,  100,  393,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -328,
			 -328, -328, -328, -328, -328, -328, -328, -328, -328, -328,
			 -328, -328, -328, -328, -328, -328, -328, -328, -328, -328,
			 -328, -328, -328, -328, -328, -328, -328, -328, -328, -328,
			 -328, -328, -328, -328, -328, -328, -328, -328, -328, -328,
			 -328, -328, -328, -328, -328, -328, -328, -328, -328, -328,
			 -328, -328, -328, -328, -328, -328, -328, -328, -328, -328,
			 -328, -328, -328, -328, -328, -328, -328, -328, -328, -328,
			 -328, -328, -328, -328, -328, -328, -328, -328, -328, -328,

			 -328, -328, -328, -328, -328, -328, -328, -328, -328, -328,
			 -328, -328, -328, -328, -328, -328, -328, -328, -328, -328,
			 -328, -328, -328, -328, -328, -328, -328, -328, -328, -328,
			 -328, -328, -328, -328, -328, -328, -328, -328, -328, -328,
			 -328, -328, -328, -328, -328, -328, -328, -328, -328, -328,
			 -328, -328, -328,    5, -329, -329, -329, -329, -329, -329,
			 -329, -329, -329, -329, -329, -329, -329, -329, -329, -329,
			 -329, -329, -329, -329, -329, -329, -329, -329, -329, -329,
			 -329, -329, -329, -329, -329, -329, -329, -329, -329, -329,
			 -329, -329, -329, -329, -329, -329, -329, -329, -329, -329,

			 -329,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -329, -329, -329, -329, -329, -329, -329,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  394,  100,
			  100,  100,  100,  100, -329, -329, -329, -329,  100, -329,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  394,  100,  100,  100,  100,  100, -329, -329, -329, -329,
			 -329, -329, -329, -329, -329, -329, -329, -329, -329, -329,
			 -329, -329, -329, -329, -329, -329, -329, -329, -329, -329,

			 -329, -329, -329, -329, -329, -329, -329, -329, -329, -329,
			 -329, -329, -329, -329, -329, -329, -329, -329, -329, -329,
			 -329, -329, -329, -329, -329, -329, -329, -329, -329, -329,
			 -329, -329, -329, -329, -329, -329, -329, -329, -329, -329,
			 -329, -329, -329, -329, -329, -329, -329, -329, -329, -329,
			 -329, -329, -329, -329, -329, -329, -329, -329, -329, -329,
			 -329, -329, -329, -329, -329, -329, -329, -329, -329, -329,
			 -329, -329, -329, -329, -329, -329, -329, -329, -329, -329,
			 -329, -329, -329, -329, -329, -329, -329, -329, -329, -329,
			 -329, -329, -329, -329, -329, -329, -329, -329, -329, -329,

			 -329, -329, -329, -329, -329, -329, -329, -329, -329, -329,
			    5, -330, -330, -330, -330, -330, -330, -330, -330, -330,
			 -330, -330, -330, -330, -330, -330, -330, -330, -330, -330,
			 -330, -330, -330, -330, -330, -330, -330, -330, -330, -330,
			 -330, -330, -330, -330, -330, -330, -330, -330, -330, -330,
			 -330, -330, -330, -330, -330, -330, -330, -330,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -330, -330,
			 -330, -330, -330, -330, -330,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100, -330, -330, -330, -330,  100, -330,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -330, -330, -330, -330, -330, -330, -330,
			 -330, -330, -330, -330, -330, -330, -330, -330, -330, -330,
			 -330, -330, -330, -330, -330, -330, -330, -330, -330, -330,
			 -330, -330, -330, -330, -330, -330, -330, -330, -330, -330,
			 -330, -330, -330, -330, -330, -330, -330, -330, -330, -330,
			 -330, -330, -330, -330, -330, -330, -330, -330, -330, -330,
			 -330, -330, -330, -330, -330, -330, -330, -330, -330, -330, yy_Dummy>>,
			1, 1000, 84000)
		end

	yy_nxt_template_86 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -330, -330, -330, -330, -330, -330, -330, -330, -330, -330,
			 -330, -330, -330, -330, -330, -330, -330, -330, -330, -330,
			 -330, -330, -330, -330, -330, -330, -330, -330, -330, -330,
			 -330, -330, -330, -330, -330, -330, -330, -330, -330, -330,
			 -330, -330, -330, -330, -330, -330, -330, -330, -330, -330,
			 -330, -330, -330, -330, -330, -330, -330, -330, -330, -330,
			 -330, -330, -330, -330, -330, -330, -330,    5, -331, -331,
			 -331, -331, -331, -331, -331, -331, -331, -331, -331, -331,
			 -331, -331, -331, -331, -331, -331, -331, -331, -331, -331,
			 -331, -331, -331, -331, -331, -331, -331, -331, -331, -331,

			 -331, -331, -331, -331, -331, -331, -331, -331, -331, -331,
			 -331, -331, -331, -331, -331,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -331, -331, -331, -331, -331,
			 -331, -331,  100,  100,  100,  100,  395,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -331, -331,
			 -331, -331,  100, -331,  100,  100,  100,  100,  395,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -331, -331, -331, -331, -331, -331, -331, -331, -331, -331,

			 -331, -331, -331, -331, -331, -331, -331, -331, -331, -331,
			 -331, -331, -331, -331, -331, -331, -331, -331, -331, -331,
			 -331, -331, -331, -331, -331, -331, -331, -331, -331, -331,
			 -331, -331, -331, -331, -331, -331, -331, -331, -331, -331,
			 -331, -331, -331, -331, -331, -331, -331, -331, -331, -331,
			 -331, -331, -331, -331, -331, -331, -331, -331, -331, -331,
			 -331, -331, -331, -331, -331, -331, -331, -331, -331, -331,
			 -331, -331, -331, -331, -331, -331, -331, -331, -331, -331,
			 -331, -331, -331, -331, -331, -331, -331, -331, -331, -331,
			 -331, -331, -331, -331, -331, -331, -331, -331, -331, -331,

			 -331, -331, -331, -331, -331, -331, -331, -331, -331, -331,
			 -331, -331, -331, -331, -331, -331, -331, -331, -331, -331,
			 -331, -331, -331, -331,    5, -332, -332, -332, -332, -332,
			 -332, -332, -332, -332, -332, -332, -332, -332, -332, -332,
			 -332, -332, -332, -332, -332, -332, -332, -332, -332, -332,
			 -332, -332, -332, -332, -332, -332, -332, -332, -332, -332,
			 -332, -332, -332, -332, -332, -332, -332, -332, -332, -332,
			 -332, -332,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -332, -332, -332, -332, -332, -332, -332,  100,
			  100,  100,  100,  100,  100,  100,  100,  396,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -332, -332, -332, -332,  100,
			 -332,  100,  100,  100,  100,  100,  100,  100,  100,  396,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -332, -332, -332,
			 -332, -332, -332, -332, -332, -332, -332, -332, -332, -332,
			 -332, -332, -332, -332, -332, -332, -332, -332, -332, -332,
			 -332, -332, -332, -332, -332, -332, -332, -332, -332, -332,
			 -332, -332, -332, -332, -332, -332, -332, -332, -332, -332,
			 -332, -332, -332, -332, -332, -332, -332, -332, -332, -332,

			 -332, -332, -332, -332, -332, -332, -332, -332, -332, -332,
			 -332, -332, -332, -332, -332, -332, -332, -332, -332, -332,
			 -332, -332, -332, -332, -332, -332, -332, -332, -332, -332,
			 -332, -332, -332, -332, -332, -332, -332, -332, -332, -332,
			 -332, -332, -332, -332, -332, -332, -332, -332, -332, -332,
			 -332, -332, -332, -332, -332, -332, -332, -332, -332, -332,
			 -332, -332, -332, -332, -332, -332, -332, -332, -332, -332,
			 -332, -332, -332, -332, -332, -332, -332, -332, -332, -332,
			 -332,    5, -333, -333, -333, -333, -333, -333, -333, -333,
			 -333, -333, -333, -333, -333, -333, -333, -333, -333, -333,

			 -333, -333, -333, -333, -333, -333, -333, -333, -333, -333,
			 -333, -333, -333, -333, -333, -333, -333, -333, -333, -333,
			 -333, -333, -333, -333, -333, -333, -333, -333, -333,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -333,
			 -333, -333, -333, -333, -333, -333,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  397,
			  100,  100, -333, -333, -333, -333,  100, -333,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  397,  100,  100, -333, -333, -333, -333, -333, -333,
			 -333, -333, -333, -333, -333, -333, -333, -333, -333, -333,
			 -333, -333, -333, -333, -333, -333, -333, -333, -333, -333,
			 -333, -333, -333, -333, -333, -333, -333, -333, -333, -333,
			 -333, -333, -333, -333, -333, -333, -333, -333, -333, -333,
			 -333, -333, -333, -333, -333, -333, -333, -333, -333, -333,
			 -333, -333, -333, -333, -333, -333, -333, -333, -333, -333,
			 -333, -333, -333, -333, -333, -333, -333, -333, -333, -333,
			 -333, -333, -333, -333, -333, -333, -333, -333, -333, -333,
			 -333, -333, -333, -333, -333, -333, -333, -333, -333, -333,

			 -333, -333, -333, -333, -333, -333, -333, -333, -333, -333,
			 -333, -333, -333, -333, -333, -333, -333, -333, -333, -333,
			 -333, -333, -333, -333, -333, -333, -333, -333, -333, -333,
			 -333, -333, -333, -333, -333, -333, -333, -333,    5, -334,
			 -334, -334, -334, -334, -334, -334, -334, -334, -334, -334,
			 -334, -334, -334, -334, -334, -334, -334, -334, -334, -334,
			 -334, -334, -334, -334, -334, -334, -334, -334, -334, -334,
			 -334, -334, -334, -334, -334, -334, -334, -334, -334, -334,
			 -334, -334, -334, -334, -334, -334,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -334, -334, -334, -334,

			 -334, -334, -334,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  398,  100,  100, -334,
			 -334, -334, -334,  100, -334,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  398,  100,
			  100, -334, -334, -334, -334, -334, -334, -334, -334, -334,
			 -334, -334, -334, -334, -334, -334, -334, -334, -334, -334,
			 -334, -334, -334, -334, -334, -334, -334, -334, -334, -334,
			 -334, -334, -334, -334, -334, -334, -334, -334, -334, -334, yy_Dummy>>,
			1, 1000, 85000)
		end

	yy_nxt_template_87 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -334, -334, -334, -334, -334, -334, -334, -334, -334, -334,
			 -334, -334, -334, -334, -334, -334, -334, -334, -334, -334,
			 -334, -334, -334, -334, -334, -334, -334, -334, -334, -334,
			 -334, -334, -334, -334, -334, -334, -334, -334, -334, -334,
			 -334, -334, -334, -334, -334, -334, -334, -334, -334, -334,
			 -334, -334, -334, -334, -334, -334, -334, -334, -334, -334,
			 -334, -334, -334, -334, -334, -334, -334, -334, -334, -334,
			 -334, -334, -334, -334, -334, -334, -334, -334, -334, -334,
			 -334, -334, -334, -334, -334, -334, -334, -334, -334, -334,
			 -334, -334, -334, -334, -334,    5, -335, -335, -335, -335,

			 -335, -335, -335, -335, -335, -335, -335, -335, -335, -335,
			 -335, -335, -335, -335, -335, -335, -335, -335, -335, -335,
			 -335, -335, -335, -335, -335, -335, -335, -335, -335, -335,
			 -335, -335, -335, -335, -335, -335, -335, -335, -335, -335,
			 -335, -335, -335,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -335, -335, -335, -335, -335, -335, -335,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  399,  100,  100,
			  100,  100,  100,  100,  100,  100, -335, -335, -335, -335,
			  100, -335,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  399,
			  100,  100,  100,  100,  100,  100,  100,  100, -335, -335,
			 -335, -335, -335, -335, -335, -335, -335, -335, -335, -335,
			 -335, -335, -335, -335, -335, -335, -335, -335, -335, -335,
			 -335, -335, -335, -335, -335, -335, -335, -335, -335, -335,
			 -335, -335, -335, -335, -335, -335, -335, -335, -335, -335,
			 -335, -335, -335, -335, -335, -335, -335, -335, -335, -335,
			 -335, -335, -335, -335, -335, -335, -335, -335, -335, -335,
			 -335, -335, -335, -335, -335, -335, -335, -335, -335, -335,
			 -335, -335, -335, -335, -335, -335, -335, -335, -335, -335,

			 -335, -335, -335, -335, -335, -335, -335, -335, -335, -335,
			 -335, -335, -335, -335, -335, -335, -335, -335, -335, -335,
			 -335, -335, -335, -335, -335, -335, -335, -335, -335, -335,
			 -335, -335, -335, -335, -335, -335, -335, -335, -335, -335,
			 -335, -335, -335, -335, -335, -335, -335, -335, -335, -335,
			 -335, -335,    5, -336, -336, -336, -336, -336, -336, -336,
			 -336, -336, -336, -336, -336, -336, -336, -336, -336, -336,
			 -336, -336, -336, -336, -336, -336, -336, -336, -336, -336,
			 -336, -336, -336, -336, -336, -336, -336, -336, -336, -336,
			 -336, -336, -336, -336, -336, -336, -336, -336, -336, -336,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -336, -336, -336, -336, -336, -336, -336,  100,  100,  100,
			  100,  400,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -336, -336, -336, -336,  100, -336,  100,
			  100,  100,  100,  400,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -336, -336, -336, -336, -336,
			 -336, -336, -336, -336, -336, -336, -336, -336, -336, -336,
			 -336, -336, -336, -336, -336, -336, -336, -336, -336, -336,

			 -336, -336, -336, -336, -336, -336, -336, -336, -336, -336,
			 -336, -336, -336, -336, -336, -336, -336, -336, -336, -336,
			 -336, -336, -336, -336, -336, -336, -336, -336, -336, -336,
			 -336, -336, -336, -336, -336, -336, -336, -336, -336, -336,
			 -336, -336, -336, -336, -336, -336, -336, -336, -336, -336,
			 -336, -336, -336, -336, -336, -336, -336, -336, -336, -336,
			 -336, -336, -336, -336, -336, -336, -336, -336, -336, -336,
			 -336, -336, -336, -336, -336, -336, -336, -336, -336, -336,
			 -336, -336, -336, -336, -336, -336, -336, -336, -336, -336,
			 -336, -336, -336, -336, -336, -336, -336, -336, -336, -336,

			 -336, -336, -336, -336, -336, -336, -336, -336, -336,    5,
			 -337, -337, -337, -337, -337, -337, -337, -337, -337, -337,
			 -337, -337, -337, -337, -337, -337, -337, -337, -337, -337,
			 -337, -337, -337, -337, -337, -337, -337, -337, -337, -337,
			 -337, -337, -337, -337, -337, -337, -337, -337, -337, -337,
			 -337, -337, -337, -337, -337, -337, -337,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -337, -337, -337,
			 -337, -337, -337, -337,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  401,  100,  100,  100,  100,  100,  100,  100,  100,

			 -337, -337, -337, -337,  100, -337,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  401,  100,  100,  100,  100,  100,  100,
			  100,  100, -337, -337, -337, -337, -337, -337, -337, -337,
			 -337, -337, -337, -337, -337, -337, -337, -337, -337, -337,
			 -337, -337, -337, -337, -337, -337, -337, -337, -337, -337,
			 -337, -337, -337, -337, -337, -337, -337, -337, -337, -337,
			 -337, -337, -337, -337, -337, -337, -337, -337, -337, -337,
			 -337, -337, -337, -337, -337, -337, -337, -337, -337, -337,
			 -337, -337, -337, -337, -337, -337, -337, -337, -337, -337,

			 -337, -337, -337, -337, -337, -337, -337, -337, -337, -337,
			 -337, -337, -337, -337, -337, -337, -337, -337, -337, -337,
			 -337, -337, -337, -337, -337, -337, -337, -337, -337, -337,
			 -337, -337, -337, -337, -337, -337, -337, -337, -337, -337,
			 -337, -337, -337, -337, -337, -337, -337, -337, -337, -337,
			 -337, -337, -337, -337, -337, -337, -337, -337, -337, -337,
			 -337, -337, -337, -337, -337, -337,    5, -338, -338, -338,
			 -338, -338, -338, -338, -338, -338, -338, -338, -338, -338,
			 -338, -338, -338, -338, -338, -338, -338, -338, -338, -338,
			 -338, -338, -338, -338, -338, -338, -338, -338, -338, -338,

			 -338, -338, -338, -338, -338, -338, -338, -338, -338, -338,
			 -338, -338, -338, -338,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -338, -338, -338, -338, -338, -338,
			 -338,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -338, -338, -338,
			 -338,  100, -338,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -338,
			 -338, -338, -338, -338, -338, -338, -338, -338, -338, -338, yy_Dummy>>,
			1, 1000, 86000)
		end

	yy_nxt_template_88 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -338, -338, -338, -338, -338, -338, -338, -338, -338, -338,
			 -338, -338, -338, -338, -338, -338, -338, -338, -338, -338,
			 -338, -338, -338, -338, -338, -338, -338, -338, -338, -338,
			 -338, -338, -338, -338, -338, -338, -338, -338, -338, -338,
			 -338, -338, -338, -338, -338, -338, -338, -338, -338, -338,
			 -338, -338, -338, -338, -338, -338, -338, -338, -338, -338,
			 -338, -338, -338, -338, -338, -338, -338, -338, -338, -338,
			 -338, -338, -338, -338, -338, -338, -338, -338, -338, -338,
			 -338, -338, -338, -338, -338, -338, -338, -338, -338, -338,
			 -338, -338, -338, -338, -338, -338, -338, -338, -338, -338,

			 -338, -338, -338, -338, -338, -338, -338, -338, -338, -338,
			 -338, -338, -338, -338, -338, -338, -338, -338, -338, -338,
			 -338, -338, -338,    5, -339, -339, -339, -339, -339, -339,
			 -339, -339, -339, -339, -339, -339, -339, -339, -339, -339,
			 -339, -339, -339, -339, -339, -339, -339, -339, -339, -339,
			 -339, -339, -339, -339, -339, -339, -339, -339, -339, -339,
			 -339, -339, -339, -339, -339, -339, -339, -339, -339, -339,
			 -339,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -339, -339, -339, -339, -339, -339, -339,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  402,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -339, -339, -339, -339,  100, -339,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  402,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -339, -339, -339, -339,
			 -339, -339, -339, -339, -339, -339, -339, -339, -339, -339,
			 -339, -339, -339, -339, -339, -339, -339, -339, -339, -339,
			 -339, -339, -339, -339, -339, -339, -339, -339, -339, -339,
			 -339, -339, -339, -339, -339, -339, -339, -339, -339, -339,
			 -339, -339, -339, -339, -339, -339, -339, -339, -339, -339,

			 -339, -339, -339, -339, -339, -339, -339, -339, -339, -339,
			 -339, -339, -339, -339, -339, -339, -339, -339, -339, -339,
			 -339, -339, -339, -339, -339, -339, -339, -339, -339, -339,
			 -339, -339, -339, -339, -339, -339, -339, -339, -339, -339,
			 -339, -339, -339, -339, -339, -339, -339, -339, -339, -339,
			 -339, -339, -339, -339, -339, -339, -339, -339, -339, -339,
			 -339, -339, -339, -339, -339, -339, -339, -339, -339, -339,
			 -339, -339, -339, -339, -339, -339, -339, -339, -339, -339,
			    5, -340, -340, -340, -340, -340, -340, -340, -340, -340,
			 -340, -340, -340, -340, -340, -340, -340, -340, -340, -340,

			 -340, -340, -340, -340, -340, -340, -340, -340, -340, -340,
			 -340, -340, -340, -340, -340, -340, -340, -340, -340, -340,
			 -340, -340, -340, -340, -340, -340, -340, -340,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -340, -340,
			 -340, -340, -340, -340, -340,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -340, -340, -340, -340,  100, -340,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100, -340, -340, -340, -340, -340, -340, -340,
			 -340, -340, -340, -340, -340, -340, -340, -340, -340, -340,
			 -340, -340, -340, -340, -340, -340, -340, -340, -340, -340,
			 -340, -340, -340, -340, -340, -340, -340, -340, -340, -340,
			 -340, -340, -340, -340, -340, -340, -340, -340, -340, -340,
			 -340, -340, -340, -340, -340, -340, -340, -340, -340, -340,
			 -340, -340, -340, -340, -340, -340, -340, -340, -340, -340,
			 -340, -340, -340, -340, -340, -340, -340, -340, -340, -340,
			 -340, -340, -340, -340, -340, -340, -340, -340, -340, -340,
			 -340, -340, -340, -340, -340, -340, -340, -340, -340, -340,

			 -340, -340, -340, -340, -340, -340, -340, -340, -340, -340,
			 -340, -340, -340, -340, -340, -340, -340, -340, -340, -340,
			 -340, -340, -340, -340, -340, -340, -340, -340, -340, -340,
			 -340, -340, -340, -340, -340, -340, -340,    5, -341, -341,
			 -341, -341, -341, -341, -341, -341, -341, -341, -341, -341,
			 -341, -341, -341, -341, -341, -341, -341, -341, -341, -341,
			 -341, -341, -341, -341, -341, -341, -341, -341, -341, -341,
			 -341, -341, -341, -341, -341, -341, -341, -341, -341, -341,
			 -341, -341, -341, -341, -341,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -341, -341, -341, -341, -341,

			 -341, -341,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  403,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -341, -341,
			 -341, -341,  100, -341,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  403,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -341, -341, -341, -341, -341, -341, -341, -341, -341, -341,
			 -341, -341, -341, -341, -341, -341, -341, -341, -341, -341,
			 -341, -341, -341, -341, -341, -341, -341, -341, -341, -341,
			 -341, -341, -341, -341, -341, -341, -341, -341, -341, -341,

			 -341, -341, -341, -341, -341, -341, -341, -341, -341, -341,
			 -341, -341, -341, -341, -341, -341, -341, -341, -341, -341,
			 -341, -341, -341, -341, -341, -341, -341, -341, -341, -341,
			 -341, -341, -341, -341, -341, -341, -341, -341, -341, -341,
			 -341, -341, -341, -341, -341, -341, -341, -341, -341, -341,
			 -341, -341, -341, -341, -341, -341, -341, -341, -341, -341,
			 -341, -341, -341, -341, -341, -341, -341, -341, -341, -341,
			 -341, -341, -341, -341, -341, -341, -341, -341, -341, -341,
			 -341, -341, -341, -341, -341, -341, -341, -341, -341, -341,
			 -341, -341, -341, -341,    5, -342, -342, -342, -342, -342,

			 -342, -342, -342, -342, -342, -342, -342, -342, -342, -342,
			 -342, -342, -342, -342, -342, -342, -342, -342, -342, -342,
			 -342, -342, -342, -342, -342, -342, -342, -342, -342, -342,
			 -342, -342, -342, -342, -342, -342, -342, -342, -342, -342,
			 -342, -342,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -342, -342, -342, -342, -342, -342, -342,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -342, -342, -342, -342,  100,
			 -342,  100,  100,  100,  100,  100,  100,  100,  100,  100, yy_Dummy>>,
			1, 1000, 87000)
		end

	yy_nxt_template_89 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -342, -342, -342,
			 -342, -342, -342, -342, -342, -342, -342, -342, -342, -342,
			 -342, -342, -342, -342, -342, -342, -342, -342, -342, -342,
			 -342, -342, -342, -342, -342, -342, -342, -342, -342, -342,
			 -342, -342, -342, -342, -342, -342, -342, -342, -342, -342,
			 -342, -342, -342, -342, -342, -342, -342, -342, -342, -342,
			 -342, -342, -342, -342, -342, -342, -342, -342, -342, -342,
			 -342, -342, -342, -342, -342, -342, -342, -342, -342, -342,
			 -342, -342, -342, -342, -342, -342, -342, -342, -342, -342,

			 -342, -342, -342, -342, -342, -342, -342, -342, -342, -342,
			 -342, -342, -342, -342, -342, -342, -342, -342, -342, -342,
			 -342, -342, -342, -342, -342, -342, -342, -342, -342, -342,
			 -342, -342, -342, -342, -342, -342, -342, -342, -342, -342,
			 -342, -342, -342, -342, -342, -342, -342, -342, -342, -342,
			 -342,    5, -343, -343, -343, -343, -343, -343, -343, -343,
			 -343, -343, -343, -343, -343, -343, -343, -343, -343, -343,
			 -343, -343, -343, -343, -343, -343, -343, -343, -343, -343,
			 -343, -343, -343, -343, -343, -343, -343, -343, -343, -343,
			 -343, -343, -343, -343, -343, -343, -343, -343, -343,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100, -343,
			 -343, -343, -343, -343, -343, -343,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  404,  100,  100,  100,
			  100,  100, -343, -343, -343, -343,  100, -343,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  404,  100,
			  100,  100,  100,  100, -343, -343, -343, -343, -343, -343,
			 -343, -343, -343, -343, -343, -343, -343, -343, -343, -343,
			 -343, -343, -343, -343, -343, -343, -343, -343, -343, -343,

			 -343, -343, -343, -343, -343, -343, -343, -343, -343, -343,
			 -343, -343, -343, -343, -343, -343, -343, -343, -343, -343,
			 -343, -343, -343, -343, -343, -343, -343, -343, -343, -343,
			 -343, -343, -343, -343, -343, -343, -343, -343, -343, -343,
			 -343, -343, -343, -343, -343, -343, -343, -343, -343, -343,
			 -343, -343, -343, -343, -343, -343, -343, -343, -343, -343,
			 -343, -343, -343, -343, -343, -343, -343, -343, -343, -343,
			 -343, -343, -343, -343, -343, -343, -343, -343, -343, -343,
			 -343, -343, -343, -343, -343, -343, -343, -343, -343, -343,
			 -343, -343, -343, -343, -343, -343, -343, -343, -343, -343,

			 -343, -343, -343, -343, -343, -343, -343, -343,    5, -344,
			 -344, -344, -344, -344, -344, -344, -344, -344, -344, -344,
			 -344, -344, -344, -344, -344, -344, -344, -344, -344, -344,
			 -344, -344, -344, -344, -344, -344, -344, -344, -344, -344,
			 -344, -344, -344, -344, -344, -344, -344, -344, -344, -344,
			 -344, -344, -344, -344, -344, -344,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -344, -344, -344, -344,
			 -344, -344, -344,  100,  100,  100,  100,  100,  100,  100,
			  100,  405,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -344,

			 -344, -344, -344,  100, -344,  100,  100,  100,  100,  100,
			  100,  100,  100,  405,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -344, -344, -344, -344, -344, -344, -344, -344, -344,
			 -344, -344, -344, -344, -344, -344, -344, -344, -344, -344,
			 -344, -344, -344, -344, -344, -344, -344, -344, -344, -344,
			 -344, -344, -344, -344, -344, -344, -344, -344, -344, -344,
			 -344, -344, -344, -344, -344, -344, -344, -344, -344, -344,
			 -344, -344, -344, -344, -344, -344, -344, -344, -344, -344,
			 -344, -344, -344, -344, -344, -344, -344, -344, -344, -344,

			 -344, -344, -344, -344, -344, -344, -344, -344, -344, -344,
			 -344, -344, -344, -344, -344, -344, -344, -344, -344, -344,
			 -344, -344, -344, -344, -344, -344, -344, -344, -344, -344,
			 -344, -344, -344, -344, -344, -344, -344, -344, -344, -344,
			 -344, -344, -344, -344, -344, -344, -344, -344, -344, -344,
			 -344, -344, -344, -344, -344, -344, -344, -344, -344, -344,
			 -344, -344, -344, -344, -344,    5, -345, -345, -345, -345,
			 -345, -345, -345, -345, -345, -345, -345, -345, -345, -345,
			 -345, -345, -345, -345, -345, -345, -345, -345, -345, -345,
			 -345, -345, -345, -345, -345, -345, -345, -345, -345, -345,

			 -345, -345, -345, -345, -345, -345, -345, -345, -345, -345,
			 -345, -345, -345,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -345, -345, -345, -345, -345, -345, -345,
			  100,  100,  100,  100,  100,  406,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -345, -345, -345, -345,
			  100, -345,  100,  100,  100,  100,  100,  406,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -345, -345,
			 -345, -345, -345, -345, -345, -345, -345, -345, -345, -345,

			 -345, -345, -345, -345, -345, -345, -345, -345, -345, -345,
			 -345, -345, -345, -345, -345, -345, -345, -345, -345, -345,
			 -345, -345, -345, -345, -345, -345, -345, -345, -345, -345,
			 -345, -345, -345, -345, -345, -345, -345, -345, -345, -345,
			 -345, -345, -345, -345, -345, -345, -345, -345, -345, -345,
			 -345, -345, -345, -345, -345, -345, -345, -345, -345, -345,
			 -345, -345, -345, -345, -345, -345, -345, -345, -345, -345,
			 -345, -345, -345, -345, -345, -345, -345, -345, -345, -345,
			 -345, -345, -345, -345, -345, -345, -345, -345, -345, -345,
			 -345, -345, -345, -345, -345, -345, -345, -345, -345, -345,

			 -345, -345, -345, -345, -345, -345, -345, -345, -345, -345,
			 -345, -345, -345, -345, -345, -345, -345, -345, -345, -345,
			 -345, -345,    5, -346, -346, -346, -346, -346, -346, -346,
			 -346, -346, -346, -346, -346, -346, -346, -346, -346, -346,
			 -346, -346, -346, -346, -346, -346, -346, -346, -346, -346,
			 -346, -346, -346, -346, -346, -346, -346, -346, -346, -346,
			 -346, -346, -346, -346, -346, -346, -346, -346, -346, -346,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -346, -346, -346, -346, -346, -346, -346,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  407, yy_Dummy>>,
			1, 1000, 88000)
		end

	yy_nxt_template_90 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -346, -346, -346, -346,  100, -346,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  407,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -346, -346, -346, -346, -346,
			 -346, -346, -346, -346, -346, -346, -346, -346, -346, -346,
			 -346, -346, -346, -346, -346, -346, -346, -346, -346, -346,
			 -346, -346, -346, -346, -346, -346, -346, -346, -346, -346,
			 -346, -346, -346, -346, -346, -346, -346, -346, -346, -346,
			 -346, -346, -346, -346, -346, -346, -346, -346, -346, -346,

			 -346, -346, -346, -346, -346, -346, -346, -346, -346, -346,
			 -346, -346, -346, -346, -346, -346, -346, -346, -346, -346,
			 -346, -346, -346, -346, -346, -346, -346, -346, -346, -346,
			 -346, -346, -346, -346, -346, -346, -346, -346, -346, -346,
			 -346, -346, -346, -346, -346, -346, -346, -346, -346, -346,
			 -346, -346, -346, -346, -346, -346, -346, -346, -346, -346,
			 -346, -346, -346, -346, -346, -346, -346, -346, -346, -346,
			 -346, -346, -346, -346, -346, -346, -346, -346, -346,    5,
			 -347, -347, -347, -347, -347, -347, -347, -347, -347, -347,
			 -347, -347, -347, -347, -347, -347, -347, -347, -347, -347,

			 -347, -347, -347, -347, -347, -347, -347, -347, -347, -347,
			 -347, -347, -347, -347, -347, -347, -347, -347, -347, -347,
			 -347, -347, -347, -347, -347, -347, -347,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -347, -347, -347,
			 -347, -347, -347, -347,  100,  100,  100,  100,  100,  100,
			  100,  100,  408,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -347, -347, -347, -347,  100, -347,  100,  100,  100,  100,
			  100,  100,  100,  100,  408,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100, -347, -347, -347, -347, -347, -347, -347, -347,
			 -347, -347, -347, -347, -347, -347, -347, -347, -347, -347,
			 -347, -347, -347, -347, -347, -347, -347, -347, -347, -347,
			 -347, -347, -347, -347, -347, -347, -347, -347, -347, -347,
			 -347, -347, -347, -347, -347, -347, -347, -347, -347, -347,
			 -347, -347, -347, -347, -347, -347, -347, -347, -347, -347,
			 -347, -347, -347, -347, -347, -347, -347, -347, -347, -347,
			 -347, -347, -347, -347, -347, -347, -347, -347, -347, -347,
			 -347, -347, -347, -347, -347, -347, -347, -347, -347, -347,
			 -347, -347, -347, -347, -347, -347, -347, -347, -347, -347,

			 -347, -347, -347, -347, -347, -347, -347, -347, -347, -347,
			 -347, -347, -347, -347, -347, -347, -347, -347, -347, -347,
			 -347, -347, -347, -347, -347, -347, -347, -347, -347, -347,
			 -347, -347, -347, -347, -347, -347,    5, -348, -348, -348,
			 -348, -348, -348, -348, -348, -348, -348, -348, -348, -348,
			 -348, -348, -348, -348, -348, -348, -348, -348, -348, -348,
			 -348, -348, -348, -348, -348, -348, -348, -348, -348, -348,
			 -348, -348, -348, -348, -348, -348, -348, -348, -348, -348,
			 -348, -348, -348, -348,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -348, -348, -348, -348, -348, -348,

			 -348,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  409,  100,  100,  100,  100,  100, -348, -348, -348,
			 -348,  100, -348,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  409,  100,  100,  100,  100,  100, -348,
			 -348, -348, -348, -348, -348, -348, -348, -348, -348, -348,
			 -348, -348, -348, -348, -348, -348, -348, -348, -348, -348,
			 -348, -348, -348, -348, -348, -348, -348, -348, -348, -348,
			 -348, -348, -348, -348, -348, -348, -348, -348, -348, -348,

			 -348, -348, -348, -348, -348, -348, -348, -348, -348, -348,
			 -348, -348, -348, -348, -348, -348, -348, -348, -348, -348,
			 -348, -348, -348, -348, -348, -348, -348, -348, -348, -348,
			 -348, -348, -348, -348, -348, -348, -348, -348, -348, -348,
			 -348, -348, -348, -348, -348, -348, -348, -348, -348, -348,
			 -348, -348, -348, -348, -348, -348, -348, -348, -348, -348,
			 -348, -348, -348, -348, -348, -348, -348, -348, -348, -348,
			 -348, -348, -348, -348, -348, -348, -348, -348, -348, -348,
			 -348, -348, -348, -348, -348, -348, -348, -348, -348, -348,
			 -348, -348, -348,    5, -349, -349, -349, -349, -349, -349,

			 -349, -349, -349, -349, -349, -349, -349, -349, -349, -349,
			 -349, -349, -349, -349, -349, -349, -349, -349, -349, -349,
			 -349, -349, -349, -349, -349, -349, -349, -349, -349, -349,
			 -349, -349, -349, -349, -349, -349, -349, -349, -349, -349,
			 -349,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -349, -349, -349, -349, -349, -349, -349,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  410,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -349, -349, -349, -349,  100, -349,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  410,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -349, -349, -349, -349,
			 -349, -349, -349, -349, -349, -349, -349, -349, -349, -349,
			 -349, -349, -349, -349, -349, -349, -349, -349, -349, -349,
			 -349, -349, -349, -349, -349, -349, -349, -349, -349, -349,
			 -349, -349, -349, -349, -349, -349, -349, -349, -349, -349,
			 -349, -349, -349, -349, -349, -349, -349, -349, -349, -349,
			 -349, -349, -349, -349, -349, -349, -349, -349, -349, -349,
			 -349, -349, -349, -349, -349, -349, -349, -349, -349, -349,
			 -349, -349, -349, -349, -349, -349, -349, -349, -349, -349,

			 -349, -349, -349, -349, -349, -349, -349, -349, -349, -349,
			 -349, -349, -349, -349, -349, -349, -349, -349, -349, -349,
			 -349, -349, -349, -349, -349, -349, -349, -349, -349, -349,
			 -349, -349, -349, -349, -349, -349, -349, -349, -349, -349,
			 -349, -349, -349, -349, -349, -349, -349, -349, -349, -349,
			    5, -350, -350, -350, -350, -350, -350, -350, -350, -350,
			 -350, -350, -350, -350, -350, -350, -350, -350, -350, -350,
			 -350, -350, -350, -350, -350, -350, -350, -350, -350, -350,
			 -350, -350, -350, -350, -350, -350, -350, -350, -350, -350,
			 -350, -350, -350, -350, -350, -350, -350, -350,  100,  100, yy_Dummy>>,
			1, 1000, 89000)
		end

	yy_nxt_template_91 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  100,  100,  100,  100,  100,  100,  100,  100, -350, -350,
			 -350, -350, -350, -350, -350,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  411,
			  100, -350, -350, -350, -350,  100, -350,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  411,  100, -350, -350, -350, -350, -350, -350, -350,
			 -350, -350, -350, -350, -350, -350, -350, -350, -350, -350,
			 -350, -350, -350, -350, -350, -350, -350, -350, -350, -350,

			 -350, -350, -350, -350, -350, -350, -350, -350, -350, -350,
			 -350, -350, -350, -350, -350, -350, -350, -350, -350, -350,
			 -350, -350, -350, -350, -350, -350, -350, -350, -350, -350,
			 -350, -350, -350, -350, -350, -350, -350, -350, -350, -350,
			 -350, -350, -350, -350, -350, -350, -350, -350, -350, -350,
			 -350, -350, -350, -350, -350, -350, -350, -350, -350, -350,
			 -350, -350, -350, -350, -350, -350, -350, -350, -350, -350,
			 -350, -350, -350, -350, -350, -350, -350, -350, -350, -350,
			 -350, -350, -350, -350, -350, -350, -350, -350, -350, -350,
			 -350, -350, -350, -350, -350, -350, -350, -350, -350, -350,

			 -350, -350, -350, -350, -350, -350, -350,    5, -351, -351,
			 -351, -351, -351, -351, -351, -351, -351, -351, -351, -351,
			 -351, -351, -351, -351, -351, -351, -351, -351, -351, -351,
			 -351, -351, -351, -351, -351, -351, -351, -351, -351, -351,
			 -351, -351, -351, -351, -351, -351, -351, -351, -351, -351,
			 -351, -351, -351, -351, -351,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -351, -351, -351, -351, -351,
			 -351, -351,  100,  100,  412,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -351, -351,

			 -351, -351,  100, -351,  100,  100,  412,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -351, -351, -351, -351, -351, -351, -351, -351, -351, -351,
			 -351, -351, -351, -351, -351, -351, -351, -351, -351, -351,
			 -351, -351, -351, -351, -351, -351, -351, -351, -351, -351,
			 -351, -351, -351, -351, -351, -351, -351, -351, -351, -351,
			 -351, -351, -351, -351, -351, -351, -351, -351, -351, -351,
			 -351, -351, -351, -351, -351, -351, -351, -351, -351, -351,
			 -351, -351, -351, -351, -351, -351, -351, -351, -351, -351,

			 -351, -351, -351, -351, -351, -351, -351, -351, -351, -351,
			 -351, -351, -351, -351, -351, -351, -351, -351, -351, -351,
			 -351, -351, -351, -351, -351, -351, -351, -351, -351, -351,
			 -351, -351, -351, -351, -351, -351, -351, -351, -351, -351,
			 -351, -351, -351, -351, -351, -351, -351, -351, -351, -351,
			 -351, -351, -351, -351, -351, -351, -351, -351, -351, -351,
			 -351, -351, -351, -351,    5, -352, -352, -352, -352, -352,
			 -352, -352, -352, -352, -352, -352, -352, -352, -352, -352,
			 -352, -352, -352, -352, -352, -352, -352, -352, -352, -352,
			 -352, -352, -352, -352, -352, -352, -352, -352, -352, -352,

			 -352, -352, -352, -352, -352, -352, -352, -352, -352, -352,
			 -352, -352,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -352, -352, -352, -352, -352, -352, -352,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  413,  100,  100,  100,
			  100,  100,  100,  100,  100, -352, -352, -352, -352,  100,
			 -352,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  413,  100,
			  100,  100,  100,  100,  100,  100,  100, -352, -352, -352,
			 -352, -352, -352, -352, -352, -352, -352, -352, -352, -352,

			 -352, -352, -352, -352, -352, -352, -352, -352, -352, -352,
			 -352, -352, -352, -352, -352, -352, -352, -352, -352, -352,
			 -352, -352, -352, -352, -352, -352, -352, -352, -352, -352,
			 -352, -352, -352, -352, -352, -352, -352, -352, -352, -352,
			 -352, -352, -352, -352, -352, -352, -352, -352, -352, -352,
			 -352, -352, -352, -352, -352, -352, -352, -352, -352, -352,
			 -352, -352, -352, -352, -352, -352, -352, -352, -352, -352,
			 -352, -352, -352, -352, -352, -352, -352, -352, -352, -352,
			 -352, -352, -352, -352, -352, -352, -352, -352, -352, -352,
			 -352, -352, -352, -352, -352, -352, -352, -352, -352, -352,

			 -352, -352, -352, -352, -352, -352, -352, -352, -352, -352,
			 -352, -352, -352, -352, -352, -352, -352, -352, -352, -352,
			 -352,    5, -353, -353, -353, -353, -353, -353, -353, -353,
			 -353, -353, -353, -353, -353, -353, -353, -353, -353, -353,
			 -353, -353, -353, -353, -353, -353, -353, -353, -353, -353,
			 -353, -353, -353, -353, -353, -353, -353, -353, -353, -353,
			 -353, -353, -353, -353, -353, -353, -353, -353, -353,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -353,
			 -353, -353, -353, -353, -353, -353,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  414,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -353, -353, -353, -353,  100, -353,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  414,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -353, -353, -353, -353, -353, -353,
			 -353, -353, -353, -353, -353, -353, -353, -353, -353, -353,
			 -353, -353, -353, -353, -353, -353, -353, -353, -353, -353,
			 -353, -353, -353, -353, -353, -353, -353, -353, -353, -353,
			 -353, -353, -353, -353, -353, -353, -353, -353, -353, -353,
			 -353, -353, -353, -353, -353, -353, -353, -353, -353, -353,

			 -353, -353, -353, -353, -353, -353, -353, -353, -353, -353,
			 -353, -353, -353, -353, -353, -353, -353, -353, -353, -353,
			 -353, -353, -353, -353, -353, -353, -353, -353, -353, -353,
			 -353, -353, -353, -353, -353, -353, -353, -353, -353, -353,
			 -353, -353, -353, -353, -353, -353, -353, -353, -353, -353,
			 -353, -353, -353, -353, -353, -353, -353, -353, -353, -353,
			 -353, -353, -353, -353, -353, -353, -353, -353, -353, -353,
			 -353, -353, -353, -353, -353, -353, -353, -353,    5, -354,
			 -354, -354, -354, -354, -354, -354, -354, -354, -354, -354,
			 -354, -354, -354, -354, -354, -354, -354, -354, -354, -354, yy_Dummy>>,
			1, 1000, 90000)
		end

	yy_nxt_template_92 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -354, -354, -354, -354, -354, -354, -354, -354, -354, -354,
			 -354, -354, -354, -354, -354, -354, -354, -354, -354, -354,
			 -354, -354, -354, -354, -354, -354,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -354, -354, -354, -354,
			 -354, -354, -354,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -354,
			 -354, -354, -354,  100, -354,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100, -354, -354, -354, -354, -354, -354, -354, -354, -354,
			 -354, -354, -354, -354, -354, -354, -354, -354, -354, -354,
			 -354, -354, -354, -354, -354, -354, -354, -354, -354, -354,
			 -354, -354, -354, -354, -354, -354, -354, -354, -354, -354,
			 -354, -354, -354, -354, -354, -354, -354, -354, -354, -354,
			 -354, -354, -354, -354, -354, -354, -354, -354, -354, -354,
			 -354, -354, -354, -354, -354, -354, -354, -354, -354, -354,
			 -354, -354, -354, -354, -354, -354, -354, -354, -354, -354,
			 -354, -354, -354, -354, -354, -354, -354, -354, -354, -354,
			 -354, -354, -354, -354, -354, -354, -354, -354, -354, -354,

			 -354, -354, -354, -354, -354, -354, -354, -354, -354, -354,
			 -354, -354, -354, -354, -354, -354, -354, -354, -354, -354,
			 -354, -354, -354, -354, -354, -354, -354, -354, -354, -354,
			 -354, -354, -354, -354, -354,    5, -355, -355, -355, -355,
			 -355, -355, -355, -355, -355, -355, -355, -355, -355, -355,
			 -355, -355, -355, -355, -355, -355, -355, -355, -355, -355,
			 -355, -355, -355, -355, -355, -355, -355, -355, -355, -355,
			 -355, -355, -355, -355, -355, -355, -355, -355, -355, -355,
			 -355, -355, -355,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -355, -355, -355, -355, -355, -355, -355,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -355, -355, -355, -355,
			  100, -355,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -355, -355,
			 -355, -355, -355, -355, -355, -355, -355, -355, -355, -355,
			 -355, -355, -355, -355, -355, -355, -355, -355, -355, -355,
			 -355, -355, -355, -355, -355, -355, -355, -355, -355, -355,
			 -355, -355, -355, -355, -355, -355, -355, -355, -355, -355,

			 -355, -355, -355, -355, -355, -355, -355, -355, -355, -355,
			 -355, -355, -355, -355, -355, -355, -355, -355, -355, -355,
			 -355, -355, -355, -355, -355, -355, -355, -355, -355, -355,
			 -355, -355, -355, -355, -355, -355, -355, -355, -355, -355,
			 -355, -355, -355, -355, -355, -355, -355, -355, -355, -355,
			 -355, -355, -355, -355, -355, -355, -355, -355, -355, -355,
			 -355, -355, -355, -355, -355, -355, -355, -355, -355, -355,
			 -355, -355, -355, -355, -355, -355, -355, -355, -355, -355,
			 -355, -355, -355, -355, -355, -355, -355, -355, -355, -355,
			 -355, -355,    5, -356, -356, -356, -356, -356, -356, -356,

			 -356, -356, -356, -356, -356, -356, -356, -356, -356, -356,
			 -356, -356, -356, -356, -356, -356, -356, -356, -356, -356,
			 -356, -356, -356, -356, -356, -356, -356, -356, -356, -356,
			 -356, -356, -356, -356, -356, -356, -356, -356, -356, -356,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -356, -356, -356, -356, -356, -356, -356,  100,  100,  100,
			  100,  100,  415,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -356, -356, -356, -356,  100, -356,  100,
			  100,  100,  100,  100,  415,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -356, -356, -356, -356, -356,
			 -356, -356, -356, -356, -356, -356, -356, -356, -356, -356,
			 -356, -356, -356, -356, -356, -356, -356, -356, -356, -356,
			 -356, -356, -356, -356, -356, -356, -356, -356, -356, -356,
			 -356, -356, -356, -356, -356, -356, -356, -356, -356, -356,
			 -356, -356, -356, -356, -356, -356, -356, -356, -356, -356,
			 -356, -356, -356, -356, -356, -356, -356, -356, -356, -356,
			 -356, -356, -356, -356, -356, -356, -356, -356, -356, -356,
			 -356, -356, -356, -356, -356, -356, -356, -356, -356, -356,

			 -356, -356, -356, -356, -356, -356, -356, -356, -356, -356,
			 -356, -356, -356, -356, -356, -356, -356, -356, -356, -356,
			 -356, -356, -356, -356, -356, -356, -356, -356, -356, -356,
			 -356, -356, -356, -356, -356, -356, -356, -356, -356, -356,
			 -356, -356, -356, -356, -356, -356, -356, -356, -356,    5,
			 -357, -357, -357, -357, -357, -357, -357, -357, -357, -357,
			 -357, -357, -357, -357, -357, -357, -357, -357, -357, -357,
			 -357, -357, -357, -357, -357, -357, -357, -357, -357, -357,
			 -357, -357, -357, -357, -357, -357, -357, -357, -357, -357,
			 -357, -357, -357, -357, -357, -357, -357,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100, -357, -357, -357,
			 -357, -357, -357, -357,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  416,  100,  100,  100,  100,  100,
			 -357, -357, -357, -357,  100, -357,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  416,  100,  100,  100,
			  100,  100, -357, -357, -357, -357, -357, -357, -357, -357,
			 -357, -357, -357, -357, -357, -357, -357, -357, -357, -357,
			 -357, -357, -357, -357, -357, -357, -357, -357, -357, -357,

			 -357, -357, -357, -357, -357, -357, -357, -357, -357, -357,
			 -357, -357, -357, -357, -357, -357, -357, -357, -357, -357,
			 -357, -357, -357, -357, -357, -357, -357, -357, -357, -357,
			 -357, -357, -357, -357, -357, -357, -357, -357, -357, -357,
			 -357, -357, -357, -357, -357, -357, -357, -357, -357, -357,
			 -357, -357, -357, -357, -357, -357, -357, -357, -357, -357,
			 -357, -357, -357, -357, -357, -357, -357, -357, -357, -357,
			 -357, -357, -357, -357, -357, -357, -357, -357, -357, -357,
			 -357, -357, -357, -357, -357, -357, -357, -357, -357, -357,
			 -357, -357, -357, -357, -357, -357, -357, -357, -357, -357, yy_Dummy>>,
			1, 1000, 91000)
		end

	yy_nxt_template_93 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -357, -357, -357, -357, -357, -357,    5, -358, -358, -358,
			 -358, -358, -358, -358, -358, -358, -358, -358, -358, -358,
			 -358, -358, -358, -358, -358, -358, -358, -358, -358, -358,
			 -358, -358, -358, -358, -358, -358, -358, -358, -358, -358,
			 -358, -358, -358, -358, -358, -358, -358, -358, -358, -358,
			 -358, -358, -358, -358,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -358, -358, -358, -358, -358, -358,
			 -358,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  417,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -358, -358, -358,

			 -358,  100, -358,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  417,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -358,
			 -358, -358, -358, -358, -358, -358, -358, -358, -358, -358,
			 -358, -358, -358, -358, -358, -358, -358, -358, -358, -358,
			 -358, -358, -358, -358, -358, -358, -358, -358, -358, -358,
			 -358, -358, -358, -358, -358, -358, -358, -358, -358, -358,
			 -358, -358, -358, -358, -358, -358, -358, -358, -358, -358,
			 -358, -358, -358, -358, -358, -358, -358, -358, -358, -358,
			 -358, -358, -358, -358, -358, -358, -358, -358, -358, -358,

			 -358, -358, -358, -358, -358, -358, -358, -358, -358, -358,
			 -358, -358, -358, -358, -358, -358, -358, -358, -358, -358,
			 -358, -358, -358, -358, -358, -358, -358, -358, -358, -358,
			 -358, -358, -358, -358, -358, -358, -358, -358, -358, -358,
			 -358, -358, -358, -358, -358, -358, -358, -358, -358, -358,
			 -358, -358, -358, -358, -358, -358, -358, -358, -358, -358,
			 -358, -358, -358,    5, -359, -359, -359, -359, -359, -359,
			 -359, -359, -359, -359, -359, -359, -359, -359, -359, -359,
			 -359, -359, -359, -359, -359, -359, -359, -359, -359, -359,
			 -359, -359, -359, -359, -359, -359, -359, -359, -359, -359,

			 -359, -359, -359, -359, -359, -359, -359, -359, -359, -359,
			 -359,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -359, -359, -359, -359, -359, -359, -359,  418,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -359, -359, -359, -359,  100, -359,
			  418,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -359, -359, -359, -359,
			 -359, -359, -359, -359, -359, -359, -359, -359, -359, -359,

			 -359, -359, -359, -359, -359, -359, -359, -359, -359, -359,
			 -359, -359, -359, -359, -359, -359, -359, -359, -359, -359,
			 -359, -359, -359, -359, -359, -359, -359, -359, -359, -359,
			 -359, -359, -359, -359, -359, -359, -359, -359, -359, -359,
			 -359, -359, -359, -359, -359, -359, -359, -359, -359, -359,
			 -359, -359, -359, -359, -359, -359, -359, -359, -359, -359,
			 -359, -359, -359, -359, -359, -359, -359, -359, -359, -359,
			 -359, -359, -359, -359, -359, -359, -359, -359, -359, -359,
			 -359, -359, -359, -359, -359, -359, -359, -359, -359, -359,
			 -359, -359, -359, -359, -359, -359, -359, -359, -359, -359,

			 -359, -359, -359, -359, -359, -359, -359, -359, -359, -359,
			 -359, -359, -359, -359, -359, -359, -359, -359, -359, -359,
			    5, -360, -360, -360, -360, -360, -360, -360, -360, -360,
			 -360, -360, -360, -360, -360, -360, -360, -360, -360, -360,
			 -360, -360, -360, -360, -360, -360, -360, -360, -360, -360,
			 -360, -360, -360, -360, -360, -360, -360, -360, -360, -360,
			 -360, -360, -360, -360, -360, -360, -360, -360,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -360, -360,
			 -360, -360, -360, -360, -360,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -360, -360, -360, -360,  100, -360,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -360, -360, -360, -360, -360, -360, -360,
			 -360, -360, -360, -360, -360, -360, -360, -360, -360, -360,
			 -360, -360, -360, -360, -360, -360, -360, -360, -360, -360,
			 -360, -360, -360, -360, -360, -360, -360, -360, -360, -360,
			 -360, -360, -360, -360, -360, -360, -360, -360, -360, -360,
			 -360, -360, -360, -360, -360, -360, -360, -360, -360, -360,

			 -360, -360, -360, -360, -360, -360, -360, -360, -360, -360,
			 -360, -360, -360, -360, -360, -360, -360, -360, -360, -360,
			 -360, -360, -360, -360, -360, -360, -360, -360, -360, -360,
			 -360, -360, -360, -360, -360, -360, -360, -360, -360, -360,
			 -360, -360, -360, -360, -360, -360, -360, -360, -360, -360,
			 -360, -360, -360, -360, -360, -360, -360, -360, -360, -360,
			 -360, -360, -360, -360, -360, -360, -360, -360, -360, -360,
			 -360, -360, -360, -360, -360, -360, -360,    5, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,

			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,

			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361, yy_Dummy>>,
			1, 1000, 92000)
		end

	yy_nxt_template_94 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361, -361, -361, -361, -361, -361, -361,
			 -361, -361, -361, -361,    5,   63,   63,   63,   63,   63,
			   63,   63,   63,   63, -362,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   64,   63,
			   63, -362,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,  419,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			  419,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,    5, -363, -363, -363, -363, -363, -363, -363, -363,

			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,

			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,

			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363, -363, -363,
			 -363, -363, -363, -363, -363, -363, -363, -363,    5,   63,
			   63,   63,   63,   63,   63,   63,   63,   63, -364,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   64,   63,   63, -364,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,  420,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,  420,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,    5, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,

			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365, yy_Dummy>>,
			1, 1000, 93000)
		end

	yy_nxt_template_95 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365, -365, -365, -365, -365, -365, -365, -365, -365,
			 -365, -365,    5,   63,   63,   63,   63,   63,   63,   63,
			   63,   63, -366,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   64,   63,   63, -366,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,  421,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			  421,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,    5,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,

			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,

			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367, -367, -367, -367, -367,
			 -367, -367, -367, -367, -367, -367,    5, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,

			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368,  422, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,

			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,

			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368, -368, -368, -368, -368, -368, -368, -368,
			 -368, -368, -368,    5, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369,  369,  369,  369,  369,  369,  369,  369,  369,  369,
			  369, -369, -369, -369, -369, -369, -369, -369, -369, -369,

			 -369, -369,  423, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369,  423, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369, yy_Dummy>>,
			1, 1000, 94000)
		end

	yy_nxt_template_96 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			 -369, -369, -369, -369, -369, -369, -369, -369, -369, -369,
			    5, -370, -370, -370, -370, -370, -370, -370, -370, -370,

			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370,  424,  424,
			  424,  424,  424,  424,  424,  424,  424,  424, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370,  371, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,

			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,

			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370, -370, -370, -370,
			 -370, -370, -370, -370, -370, -370, -370,    5, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371,  425,  425,  425,  425,  425,

			  425,  425,  425,  425,  425, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,

			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,
			 -371, -371, -371, -371, -371, -371, -371, -371, -371, -371,

			 -371, -371, -371, -371,    5, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372,  426,  426,  426,  426,  426,  426,  426,  426,
			  426,  426, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,

			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,

			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372, -372, -372, -372, -372, -372, -372, -372, -372, -372,
			 -372,    5, -373, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,

			 -373, -373, -373, -373, -373, -373, -373, -373, -373,  427,
			  427,  427,  427,  427,  427,  427,  427,  427,  427, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,
			  309, -373, -373, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373,  310, -373, -373, -373,
			 -373, -373,  309, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373, yy_Dummy>>,
			1, 1000, 95000)
		end

	yy_nxt_template_97 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,

			 -373, -373, -373, -373, -373, -373, -373, -373, -373, -373,
			 -373, -373, -373, -373, -373, -373, -373, -373,    5, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,

			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,

			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374, -374, -374, -374, -374, -374,
			 -374, -374, -374, -374, -374,    5, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,

			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			  429, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,

			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,

			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375, -375, -375, -375, -375, -375, -375, -375, -375,
			 -375, -375,    5, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			  430,  430,  430,  430,  430,  430,  430,  430,  430,  430,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,

			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,

			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376, -376,
			 -376, -376, -376, -376, -376, -376, -376, -376, -376,    5,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,

			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377,  431,  431,  431,
			  431,  431,  431,  431,  431,  431,  431, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377,  378, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377, yy_Dummy>>,
			1, 1000, 96000)
		end

	yy_nxt_template_98 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,

			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377, -377, -377, -377, -377,
			 -377, -377, -377, -377, -377, -377,    5, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378,  432,  432,  432,  432,  432,  432,

			  432,  432,  432,  432, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,

			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,
			 -378, -378, -378, -378, -378, -378, -378, -378, -378, -378,

			 -378, -378, -378,    5,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214, -379,
			  214,  427,  427,  427,  427,  427,  427,  427,  427,  427,
			  427,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  433,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,

			  214,  214,  214,  214,  433,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,

			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,
			    5, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,

			 -380, -380, -380, -380, -380, -380,  434, -380,  139,  139,
			  139,  139,  139,  139,  139,  139,  139,  139, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380,   93, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,

			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,

			 -380, -380, -380, -380, -380, -380, -380, -380, -380, -380,
			 -380, -380, -380, -380, -380, -380, -380,    5, -381, -381,
			 -381, -381, -381, -381, -381, -381, -381, -381, -381, -381,
			 -381, -381, -381, -381, -381, -381, -381, -381, -381, -381,
			 -381, -381, -381, -381, -381, -381, -381, -381, -381, -381,
			 -381, -381, -381, -381, -381, -381, -381, -381, -381, -381,
			 -381, -381, -381, -381, -381,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -381, -381, -381, -381, -381,
			 -381, -381,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100, yy_Dummy>>,
			1, 1000, 97000)
		end

	yy_nxt_template_99 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  100,  100,  100,  100,  100,  100,  100,  100, -381, -381,
			 -381, -381,  100, -381,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -381, -381, -381, -381, -381, -381, -381, -381, -381, -381,
			 -381, -381, -381, -381, -381, -381, -381, -381, -381, -381,
			 -381, -381, -381, -381, -381, -381, -381, -381, -381, -381,
			 -381, -381, -381, -381, -381, -381, -381, -381, -381, -381,
			 -381, -381, -381, -381, -381, -381, -381, -381, -381, -381,
			 -381, -381, -381, -381, -381, -381, -381, -381, -381, -381,

			 -381, -381, -381, -381, -381, -381, -381, -381, -381, -381,
			 -381, -381, -381, -381, -381, -381, -381, -381, -381, -381,
			 -381, -381, -381, -381, -381, -381, -381, -381, -381, -381,
			 -381, -381, -381, -381, -381, -381, -381, -381, -381, -381,
			 -381, -381, -381, -381, -381, -381, -381, -381, -381, -381,
			 -381, -381, -381, -381, -381, -381, -381, -381, -381, -381,
			 -381, -381, -381, -381, -381, -381, -381, -381, -381, -381,
			 -381, -381, -381, -381,    5, -382, -382, -382, -382, -382,
			 -382, -382, -382, -382, -382, -382, -382, -382, -382, -382,
			 -382, -382, -382, -382, -382, -382, -382, -382, -382, -382,

			 -382, -382, -382, -382, -382, -382, -382, -382, -382, -382,
			 -382, -382, -382, -382, -382, -382, -382, -382, -382, -382,
			 -382, -382,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -382, -382, -382, -382, -382, -382, -382,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -382, -382, -382, -382,  100,
			 -382,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -382, -382, -382,

			 -382, -382, -382, -382, -382, -382, -382, -382, -382, -382,
			 -382, -382, -382, -382, -382, -382, -382, -382, -382, -382,
			 -382, -382, -382, -382, -382, -382, -382, -382, -382, -382,
			 -382, -382, -382, -382, -382, -382, -382, -382, -382, -382,
			 -382, -382, -382, -382, -382, -382, -382, -382, -382, -382,
			 -382, -382, -382, -382, -382, -382, -382, -382, -382, -382,
			 -382, -382, -382, -382, -382, -382, -382, -382, -382, -382,
			 -382, -382, -382, -382, -382, -382, -382, -382, -382, -382,
			 -382, -382, -382, -382, -382, -382, -382, -382, -382, -382,
			 -382, -382, -382, -382, -382, -382, -382, -382, -382, -382,

			 -382, -382, -382, -382, -382, -382, -382, -382, -382, -382,
			 -382, -382, -382, -382, -382, -382, -382, -382, -382, -382,
			 -382, -382, -382, -382, -382, -382, -382, -382, -382, -382,
			 -382,    5, -383, -383, -383, -383, -383, -383, -383, -383,
			 -383, -383, -383, -383, -383, -383, -383, -383, -383, -383,
			 -383, -383, -383, -383, -383, -383, -383, -383, -383, -383,
			 -383, -383, -383, -383, -383, -383, -383, -383, -383, -383,
			 -383, -383, -383, -383, -383, -383, -383, -383, -383,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -383,
			 -383, -383, -383, -383, -383, -383,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -383, -383, -383, -383,  100, -383,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -383, -383, -383, -383, -383, -383,
			 -383, -383, -383, -383, -383, -383, -383, -383, -383, -383,
			 -383, -383, -383, -383, -383, -383, -383, -383, -383, -383,
			 -383, -383, -383, -383, -383, -383, -383, -383, -383, -383,
			 -383, -383, -383, -383, -383, -383, -383, -383, -383, -383,

			 -383, -383, -383, -383, -383, -383, -383, -383, -383, -383,
			 -383, -383, -383, -383, -383, -383, -383, -383, -383, -383,
			 -383, -383, -383, -383, -383, -383, -383, -383, -383, -383,
			 -383, -383, -383, -383, -383, -383, -383, -383, -383, -383,
			 -383, -383, -383, -383, -383, -383, -383, -383, -383, -383,
			 -383, -383, -383, -383, -383, -383, -383, -383, -383, -383,
			 -383, -383, -383, -383, -383, -383, -383, -383, -383, -383,
			 -383, -383, -383, -383, -383, -383, -383, -383, -383, -383,
			 -383, -383, -383, -383, -383, -383, -383, -383,    5, -384,
			 -384, -384, -384, -384, -384, -384, -384, -384, -384, -384,

			 -384, -384, -384, -384, -384, -384, -384, -384, -384, -384,
			 -384, -384, -384, -384, -384, -384, -384, -384, -384, -384,
			 -384, -384, -384, -384, -384, -384, -384, -384, -384, -384,
			 -384, -384, -384, -384, -384, -384,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -384, -384, -384, -384,
			 -384, -384, -384,  100,  100,  100,  100,  100,  100,  100,
			  100,  435,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -384,
			 -384, -384, -384,  100, -384,  100,  100,  100,  100,  100,
			  100,  100,  100,  435,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -384, -384, -384, -384, -384, -384, -384, -384, -384,
			 -384, -384, -384, -384, -384, -384, -384, -384, -384, -384,
			 -384, -384, -384, -384, -384, -384, -384, -384, -384, -384,
			 -384, -384, -384, -384, -384, -384, -384, -384, -384, -384,
			 -384, -384, -384, -384, -384, -384, -384, -384, -384, -384,
			 -384, -384, -384, -384, -384, -384, -384, -384, -384, -384,
			 -384, -384, -384, -384, -384, -384, -384, -384, -384, -384,
			 -384, -384, -384, -384, -384, -384, -384, -384, -384, -384,
			 -384, -384, -384, -384, -384, -384, -384, -384, -384, -384,

			 -384, -384, -384, -384, -384, -384, -384, -384, -384, -384,
			 -384, -384, -384, -384, -384, -384, -384, -384, -384, -384,
			 -384, -384, -384, -384, -384, -384, -384, -384, -384, -384,
			 -384, -384, -384, -384, -384, -384, -384, -384, -384, -384,
			 -384, -384, -384, -384, -384,    5, -385, -385, -385, -385,
			 -385, -385, -385, -385, -385, -385, -385, -385, -385, -385,
			 -385, -385, -385, -385, -385, -385, -385, -385, -385, -385,
			 -385, -385, -385, -385, -385, -385, -385, -385, -385, -385,
			 -385, -385, -385, -385, -385, -385, -385, -385, -385, -385,
			 -385, -385, -385,  100,  100,  100,  100,  100,  100,  100, yy_Dummy>>,
			1, 1000, 98000)
		end

	yy_nxt_template_100 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  100,  100,  100, -385, -385, -385, -385, -385, -385, -385,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  436,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -385, -385, -385, -385,
			  100, -385,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  436,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -385, -385,
			 -385, -385, -385, -385, -385, -385, -385, -385, -385, -385,
			 -385, -385, -385, -385, -385, -385, -385, -385, -385, -385,
			 -385, -385, -385, -385, -385, -385, -385, -385, -385, -385,

			 -385, -385, -385, -385, -385, -385, -385, -385, -385, -385,
			 -385, -385, -385, -385, -385, -385, -385, -385, -385, -385,
			 -385, -385, -385, -385, -385, -385, -385, -385, -385, -385,
			 -385, -385, -385, -385, -385, -385, -385, -385, -385, -385,
			 -385, -385, -385, -385, -385, -385, -385, -385, -385, -385,
			 -385, -385, -385, -385, -385, -385, -385, -385, -385, -385,
			 -385, -385, -385, -385, -385, -385, -385, -385, -385, -385,
			 -385, -385, -385, -385, -385, -385, -385, -385, -385, -385,
			 -385, -385, -385, -385, -385, -385, -385, -385, -385, -385,
			 -385, -385, -385, -385, -385, -385, -385, -385, -385, -385,

			 -385, -385,    5, -386, -386, -386, -386, -386, -386, -386,
			 -386, -386, -386, -386, -386, -386, -386, -386, -386, -386,
			 -386, -386, -386, -386, -386, -386, -386, -386, -386, -386,
			 -386, -386, -386, -386, -386, -386, -386, -386, -386, -386,
			 -386, -386, -386, -386, -386, -386, -386, -386, -386, -386,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -386, -386, -386, -386, -386, -386, -386,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -386, -386, -386, -386,  100, -386,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -386, -386, -386, -386, -386,
			 -386, -386, -386, -386, -386, -386, -386, -386, -386, -386,
			 -386, -386, -386, -386, -386, -386, -386, -386, -386, -386,
			 -386, -386, -386, -386, -386, -386, -386, -386, -386, -386,
			 -386, -386, -386, -386, -386, -386, -386, -386, -386, -386,
			 -386, -386, -386, -386, -386, -386, -386, -386, -386, -386,
			 -386, -386, -386, -386, -386, -386, -386, -386, -386, -386,
			 -386, -386, -386, -386, -386, -386, -386, -386, -386, -386,

			 -386, -386, -386, -386, -386, -386, -386, -386, -386, -386,
			 -386, -386, -386, -386, -386, -386, -386, -386, -386, -386,
			 -386, -386, -386, -386, -386, -386, -386, -386, -386, -386,
			 -386, -386, -386, -386, -386, -386, -386, -386, -386, -386,
			 -386, -386, -386, -386, -386, -386, -386, -386, -386, -386,
			 -386, -386, -386, -386, -386, -386, -386, -386, -386,    5,
			 -387, -387, -387, -387, -387, -387, -387, -387, -387, -387,
			 -387, -387, -387, -387, -387, -387, -387, -387, -387, -387,
			 -387, -387, -387, -387, -387, -387, -387, -387, -387, -387,
			 -387, -387, -387, -387, -387, -387, -387, -387, -387, -387,

			 -387, -387, -387, -387, -387, -387, -387,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -387, -387, -387,
			 -387, -387, -387, -387,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  437,  100,  100,  100,  100,  100,  100,  100,  100,
			 -387, -387, -387, -387,  100, -387,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  437,  100,  100,  100,  100,  100,  100,
			  100,  100, -387, -387, -387, -387, -387, -387, -387, -387,
			 -387, -387, -387, -387, -387, -387, -387, -387, -387, -387,

			 -387, -387, -387, -387, -387, -387, -387, -387, -387, -387,
			 -387, -387, -387, -387, -387, -387, -387, -387, -387, -387,
			 -387, -387, -387, -387, -387, -387, -387, -387, -387, -387,
			 -387, -387, -387, -387, -387, -387, -387, -387, -387, -387,
			 -387, -387, -387, -387, -387, -387, -387, -387, -387, -387,
			 -387, -387, -387, -387, -387, -387, -387, -387, -387, -387,
			 -387, -387, -387, -387, -387, -387, -387, -387, -387, -387,
			 -387, -387, -387, -387, -387, -387, -387, -387, -387, -387,
			 -387, -387, -387, -387, -387, -387, -387, -387, -387, -387,
			 -387, -387, -387, -387, -387, -387, -387, -387, -387, -387,

			 -387, -387, -387, -387, -387, -387, -387, -387, -387, -387,
			 -387, -387, -387, -387, -387, -387,    5, -388, -388, -388,
			 -388, -388, -388, -388, -388, -388, -388, -388, -388, -388,
			 -388, -388, -388, -388, -388, -388, -388, -388, -388, -388,
			 -388, -388, -388, -388, -388, -388, -388, -388, -388, -388,
			 -388, -388, -388, -388, -388, -388, -388, -388, -388, -388,
			 -388, -388, -388, -388,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -388, -388, -388, -388, -388, -388,
			 -388,  100,  100,  100,  100,  100,  438,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100, -388, -388, -388,
			 -388,  100, -388,  100,  100,  100,  100,  100,  438,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -388,
			 -388, -388, -388, -388, -388, -388, -388, -388, -388, -388,
			 -388, -388, -388, -388, -388, -388, -388, -388, -388, -388,
			 -388, -388, -388, -388, -388, -388, -388, -388, -388, -388,
			 -388, -388, -388, -388, -388, -388, -388, -388, -388, -388,
			 -388, -388, -388, -388, -388, -388, -388, -388, -388, -388,
			 -388, -388, -388, -388, -388, -388, -388, -388, -388, -388,

			 -388, -388, -388, -388, -388, -388, -388, -388, -388, -388,
			 -388, -388, -388, -388, -388, -388, -388, -388, -388, -388,
			 -388, -388, -388, -388, -388, -388, -388, -388, -388, -388,
			 -388, -388, -388, -388, -388, -388, -388, -388, -388, -388,
			 -388, -388, -388, -388, -388, -388, -388, -388, -388, -388,
			 -388, -388, -388, -388, -388, -388, -388, -388, -388, -388,
			 -388, -388, -388, -388, -388, -388, -388, -388, -388, -388,
			 -388, -388, -388,    5, -389, -389, -389, -389, -389, -389,
			 -389, -389, -389, -389, -389, -389, -389, -389, -389, -389,
			 -389, -389, -389, -389, -389, -389, -389, -389, -389, -389, yy_Dummy>>,
			1, 1000, 99000)
		end

	yy_nxt_template_101 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -389, -389, -389, -389, -389, -389, -389, -389, -389, -389,
			 -389, -389, -389, -389, -389, -389, -389, -389, -389, -389,
			 -389,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -389, -389, -389, -389, -389, -389, -389,  100,  100,
			  100,  100,  439,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -389, -389, -389, -389,  100, -389,
			  100,  100,  100,  100,  439,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -389, -389, -389, -389,

			 -389, -389, -389, -389, -389, -389, -389, -389, -389, -389,
			 -389, -389, -389, -389, -389, -389, -389, -389, -389, -389,
			 -389, -389, -389, -389, -389, -389, -389, -389, -389, -389,
			 -389, -389, -389, -389, -389, -389, -389, -389, -389, -389,
			 -389, -389, -389, -389, -389, -389, -389, -389, -389, -389,
			 -389, -389, -389, -389, -389, -389, -389, -389, -389, -389,
			 -389, -389, -389, -389, -389, -389, -389, -389, -389, -389,
			 -389, -389, -389, -389, -389, -389, -389, -389, -389, -389,
			 -389, -389, -389, -389, -389, -389, -389, -389, -389, -389,
			 -389, -389, -389, -389, -389, -389, -389, -389, -389, -389,

			 -389, -389, -389, -389, -389, -389, -389, -389, -389, -389,
			 -389, -389, -389, -389, -389, -389, -389, -389, -389, -389,
			 -389, -389, -389, -389, -389, -389, -389, -389, -389, -389,
			    5, -390, -390, -390, -390, -390, -390, -390, -390, -390,
			 -390, -390, -390, -390, -390, -390, -390, -390, -390, -390,
			 -390, -390, -390, -390, -390, -390, -390, -390, -390, -390,
			 -390, -390, -390, -390, -390, -390, -390, -390, -390, -390,
			 -390, -390, -390, -390, -390, -390, -390, -390,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -390, -390,
			 -390, -390, -390, -390, -390,  100,  100,  100,  440,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -390, -390, -390, -390,  100, -390,  100,  100,  100,
			  440,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -390, -390, -390, -390, -390, -390, -390,
			 -390, -390, -390, -390, -390, -390, -390, -390, -390, -390,
			 -390, -390, -390, -390, -390, -390, -390, -390, -390, -390,
			 -390, -390, -390, -390, -390, -390, -390, -390, -390, -390,
			 -390, -390, -390, -390, -390, -390, -390, -390, -390, -390,

			 -390, -390, -390, -390, -390, -390, -390, -390, -390, -390,
			 -390, -390, -390, -390, -390, -390, -390, -390, -390, -390,
			 -390, -390, -390, -390, -390, -390, -390, -390, -390, -390,
			 -390, -390, -390, -390, -390, -390, -390, -390, -390, -390,
			 -390, -390, -390, -390, -390, -390, -390, -390, -390, -390,
			 -390, -390, -390, -390, -390, -390, -390, -390, -390, -390,
			 -390, -390, -390, -390, -390, -390, -390, -390, -390, -390,
			 -390, -390, -390, -390, -390, -390, -390, -390, -390, -390,
			 -390, -390, -390, -390, -390, -390, -390,    5, -391, -391,
			 -391, -391, -391, -391, -391, -391, -391, -391, -391, -391,

			 -391, -391, -391, -391, -391, -391, -391, -391, -391, -391,
			 -391, -391, -391, -391, -391, -391, -391, -391, -391, -391,
			 -391, -391, -391, -391, -391, -391, -391, -391, -391, -391,
			 -391, -391, -391, -391, -391,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -391, -391, -391, -391, -391,
			 -391, -391,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  441,  100,  100,  100,  100,  100,  100, -391, -391,
			 -391, -391,  100, -391,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  441,  100,  100,  100,  100,  100,  100,
			 -391, -391, -391, -391, -391, -391, -391, -391, -391, -391,
			 -391, -391, -391, -391, -391, -391, -391, -391, -391, -391,
			 -391, -391, -391, -391, -391, -391, -391, -391, -391, -391,
			 -391, -391, -391, -391, -391, -391, -391, -391, -391, -391,
			 -391, -391, -391, -391, -391, -391, -391, -391, -391, -391,
			 -391, -391, -391, -391, -391, -391, -391, -391, -391, -391,
			 -391, -391, -391, -391, -391, -391, -391, -391, -391, -391,
			 -391, -391, -391, -391, -391, -391, -391, -391, -391, -391,
			 -391, -391, -391, -391, -391, -391, -391, -391, -391, -391,

			 -391, -391, -391, -391, -391, -391, -391, -391, -391, -391,
			 -391, -391, -391, -391, -391, -391, -391, -391, -391, -391,
			 -391, -391, -391, -391, -391, -391, -391, -391, -391, -391,
			 -391, -391, -391, -391, -391, -391, -391, -391, -391, -391,
			 -391, -391, -391, -391,    5, -392, -392, -392, -392, -392,
			 -392, -392, -392, -392, -392, -392, -392, -392, -392, -392,
			 -392, -392, -392, -392, -392, -392, -392, -392, -392, -392,
			 -392, -392, -392, -392, -392, -392, -392, -392, -392, -392,
			 -392, -392, -392, -392, -392, -392, -392, -392, -392, -392,
			 -392, -392,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100, -392, -392, -392, -392, -392, -392, -392,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  442,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -392, -392, -392, -392,  100,
			 -392,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  442,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -392, -392, -392,
			 -392, -392, -392, -392, -392, -392, -392, -392, -392, -392,
			 -392, -392, -392, -392, -392, -392, -392, -392, -392, -392,
			 -392, -392, -392, -392, -392, -392, -392, -392, -392, -392,

			 -392, -392, -392, -392, -392, -392, -392, -392, -392, -392,
			 -392, -392, -392, -392, -392, -392, -392, -392, -392, -392,
			 -392, -392, -392, -392, -392, -392, -392, -392, -392, -392,
			 -392, -392, -392, -392, -392, -392, -392, -392, -392, -392,
			 -392, -392, -392, -392, -392, -392, -392, -392, -392, -392,
			 -392, -392, -392, -392, -392, -392, -392, -392, -392, -392,
			 -392, -392, -392, -392, -392, -392, -392, -392, -392, -392,
			 -392, -392, -392, -392, -392, -392, -392, -392, -392, -392,
			 -392, -392, -392, -392, -392, -392, -392, -392, -392, -392,
			 -392, -392, -392, -392, -392, -392, -392, -392, -392, -392, yy_Dummy>>,
			1, 1000, 100000)
		end

	yy_nxt_template_102 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -392,    5, -393, -393, -393, -393, -393, -393, -393, -393,
			 -393, -393, -393, -393, -393, -393, -393, -393, -393, -393,
			 -393, -393, -393, -393, -393, -393, -393, -393, -393, -393,
			 -393, -393, -393, -393, -393, -393, -393, -393, -393, -393,
			 -393, -393, -393, -393, -393, -393, -393, -393, -393,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -393,
			 -393, -393, -393, -393, -393, -393,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -393, -393, -393, -393,  100, -393,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -393, -393, -393, -393, -393, -393,
			 -393, -393, -393, -393, -393, -393, -393, -393, -393, -393,
			 -393, -393, -393, -393, -393, -393, -393, -393, -393, -393,
			 -393, -393, -393, -393, -393, -393, -393, -393, -393, -393,
			 -393, -393, -393, -393, -393, -393, -393, -393, -393, -393,
			 -393, -393, -393, -393, -393, -393, -393, -393, -393, -393,
			 -393, -393, -393, -393, -393, -393, -393, -393, -393, -393,
			 -393, -393, -393, -393, -393, -393, -393, -393, -393, -393,

			 -393, -393, -393, -393, -393, -393, -393, -393, -393, -393,
			 -393, -393, -393, -393, -393, -393, -393, -393, -393, -393,
			 -393, -393, -393, -393, -393, -393, -393, -393, -393, -393,
			 -393, -393, -393, -393, -393, -393, -393, -393, -393, -393,
			 -393, -393, -393, -393, -393, -393, -393, -393, -393, -393,
			 -393, -393, -393, -393, -393, -393, -393, -393,    5, -394,
			 -394, -394, -394, -394, -394, -394, -394, -394, -394, -394,
			 -394, -394, -394, -394, -394, -394, -394, -394, -394, -394,
			 -394, -394, -394, -394, -394, -394, -394, -394, -394, -394,
			 -394, -394, -394, -394, -394, -394, -394, -394, -394, -394,

			 -394, -394, -394, -394, -394, -394,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -394, -394, -394, -394,
			 -394, -394, -394,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  443,  100,  100,  100,  100,  100,  100,  100,  100, -394,
			 -394, -394, -394,  100, -394,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  443,  100,  100,  100,  100,  100,  100,  100,
			  100, -394, -394, -394, -394, -394, -394, -394, -394, -394,
			 -394, -394, -394, -394, -394, -394, -394, -394, -394, -394,

			 -394, -394, -394, -394, -394, -394, -394, -394, -394, -394,
			 -394, -394, -394, -394, -394, -394, -394, -394, -394, -394,
			 -394, -394, -394, -394, -394, -394, -394, -394, -394, -394,
			 -394, -394, -394, -394, -394, -394, -394, -394, -394, -394,
			 -394, -394, -394, -394, -394, -394, -394, -394, -394, -394,
			 -394, -394, -394, -394, -394, -394, -394, -394, -394, -394,
			 -394, -394, -394, -394, -394, -394, -394, -394, -394, -394,
			 -394, -394, -394, -394, -394, -394, -394, -394, -394, -394,
			 -394, -394, -394, -394, -394, -394, -394, -394, -394, -394,
			 -394, -394, -394, -394, -394, -394, -394, -394, -394, -394,

			 -394, -394, -394, -394, -394, -394, -394, -394, -394, -394,
			 -394, -394, -394, -394, -394,    5, -395, -395, -395, -395,
			 -395, -395, -395, -395, -395, -395, -395, -395, -395, -395,
			 -395, -395, -395, -395, -395, -395, -395, -395, -395, -395,
			 -395, -395, -395, -395, -395, -395, -395, -395, -395, -395,
			 -395, -395, -395, -395, -395, -395, -395, -395, -395, -395,
			 -395, -395, -395,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -395, -395, -395, -395, -395, -395, -395,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  444,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100, -395, -395, -395, -395,
			  100, -395,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  444,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -395, -395,
			 -395, -395, -395, -395, -395, -395, -395, -395, -395, -395,
			 -395, -395, -395, -395, -395, -395, -395, -395, -395, -395,
			 -395, -395, -395, -395, -395, -395, -395, -395, -395, -395,
			 -395, -395, -395, -395, -395, -395, -395, -395, -395, -395,
			 -395, -395, -395, -395, -395, -395, -395, -395, -395, -395,
			 -395, -395, -395, -395, -395, -395, -395, -395, -395, -395,

			 -395, -395, -395, -395, -395, -395, -395, -395, -395, -395,
			 -395, -395, -395, -395, -395, -395, -395, -395, -395, -395,
			 -395, -395, -395, -395, -395, -395, -395, -395, -395, -395,
			 -395, -395, -395, -395, -395, -395, -395, -395, -395, -395,
			 -395, -395, -395, -395, -395, -395, -395, -395, -395, -395,
			 -395, -395, -395, -395, -395, -395, -395, -395, -395, -395,
			 -395, -395, -395, -395, -395, -395, -395, -395, -395, -395,
			 -395, -395,    5, -396, -396, -396, -396, -396, -396, -396,
			 -396, -396, -396, -396, -396, -396, -396, -396, -396, -396,
			 -396, -396, -396, -396, -396, -396, -396, -396, -396, -396,

			 -396, -396, -396, -396, -396, -396, -396, -396, -396, -396,
			 -396, -396, -396, -396, -396, -396, -396, -396, -396, -396,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -396, -396, -396, -396, -396, -396, -396,  100,  100,  100,
			  100,  445,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -396, -396, -396, -396,  100, -396,  100,
			  100,  100,  100,  445,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -396, -396, -396, -396, -396,

			 -396, -396, -396, -396, -396, -396, -396, -396, -396, -396,
			 -396, -396, -396, -396, -396, -396, -396, -396, -396, -396,
			 -396, -396, -396, -396, -396, -396, -396, -396, -396, -396,
			 -396, -396, -396, -396, -396, -396, -396, -396, -396, -396,
			 -396, -396, -396, -396, -396, -396, -396, -396, -396, -396,
			 -396, -396, -396, -396, -396, -396, -396, -396, -396, -396,
			 -396, -396, -396, -396, -396, -396, -396, -396, -396, -396,
			 -396, -396, -396, -396, -396, -396, -396, -396, -396, -396,
			 -396, -396, -396, -396, -396, -396, -396, -396, -396, -396,
			 -396, -396, -396, -396, -396, -396, -396, -396, -396, -396, yy_Dummy>>,
			1, 1000, 101000)
		end

	yy_nxt_template_103 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -396, -396, -396, -396, -396, -396, -396, -396, -396, -396,
			 -396, -396, -396, -396, -396, -396, -396, -396, -396, -396,
			 -396, -396, -396, -396, -396, -396, -396, -396, -396,    5,
			 -397, -397, -397, -397, -397, -397, -397, -397, -397, -397,
			 -397, -397, -397, -397, -397, -397, -397, -397, -397, -397,
			 -397, -397, -397, -397, -397, -397, -397, -397, -397, -397,
			 -397, -397, -397, -397, -397, -397, -397, -397, -397, -397,
			 -397, -397, -397, -397, -397, -397, -397,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -397, -397, -397,
			 -397, -397, -397, -397,  100,  100,  100,  100,  100,  100,

			  100,  100,  446,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -397, -397, -397, -397,  100, -397,  100,  100,  100,  100,
			  100,  100,  100,  100,  446,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -397, -397, -397, -397, -397, -397, -397, -397,
			 -397, -397, -397, -397, -397, -397, -397, -397, -397, -397,
			 -397, -397, -397, -397, -397, -397, -397, -397, -397, -397,
			 -397, -397, -397, -397, -397, -397, -397, -397, -397, -397,
			 -397, -397, -397, -397, -397, -397, -397, -397, -397, -397,

			 -397, -397, -397, -397, -397, -397, -397, -397, -397, -397,
			 -397, -397, -397, -397, -397, -397, -397, -397, -397, -397,
			 -397, -397, -397, -397, -397, -397, -397, -397, -397, -397,
			 -397, -397, -397, -397, -397, -397, -397, -397, -397, -397,
			 -397, -397, -397, -397, -397, -397, -397, -397, -397, -397,
			 -397, -397, -397, -397, -397, -397, -397, -397, -397, -397,
			 -397, -397, -397, -397, -397, -397, -397, -397, -397, -397,
			 -397, -397, -397, -397, -397, -397, -397, -397, -397, -397,
			 -397, -397, -397, -397, -397, -397,    5, -398, -398, -398,
			 -398, -398, -398, -398, -398, -398, -398, -398, -398, -398,

			 -398, -398, -398, -398, -398, -398, -398, -398, -398, -398,
			 -398, -398, -398, -398, -398, -398, -398, -398, -398, -398,
			 -398, -398, -398, -398, -398, -398, -398, -398, -398, -398,
			 -398, -398, -398, -398,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -398, -398, -398, -398, -398, -398,
			 -398,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -398, -398, -398,
			 -398,  100, -398,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100, -398,
			 -398, -398, -398, -398, -398, -398, -398, -398, -398, -398,
			 -398, -398, -398, -398, -398, -398, -398, -398, -398, -398,
			 -398, -398, -398, -398, -398, -398, -398, -398, -398, -398,
			 -398, -398, -398, -398, -398, -398, -398, -398, -398, -398,
			 -398, -398, -398, -398, -398, -398, -398, -398, -398, -398,
			 -398, -398, -398, -398, -398, -398, -398, -398, -398, -398,
			 -398, -398, -398, -398, -398, -398, -398, -398, -398, -398,
			 -398, -398, -398, -398, -398, -398, -398, -398, -398, -398,
			 -398, -398, -398, -398, -398, -398, -398, -398, -398, -398,

			 -398, -398, -398, -398, -398, -398, -398, -398, -398, -398,
			 -398, -398, -398, -398, -398, -398, -398, -398, -398, -398,
			 -398, -398, -398, -398, -398, -398, -398, -398, -398, -398,
			 -398, -398, -398, -398, -398, -398, -398, -398, -398, -398,
			 -398, -398, -398,    5, -399, -399, -399, -399, -399, -399,
			 -399, -399, -399, -399, -399, -399, -399, -399, -399, -399,
			 -399, -399, -399, -399, -399, -399, -399, -399, -399, -399,
			 -399, -399, -399, -399, -399, -399, -399, -399, -399, -399,
			 -399, -399, -399, -399, -399, -399, -399, -399, -399, -399,
			 -399,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100, -399, -399, -399, -399, -399, -399, -399,  100,  100,
			  100,  100,  100,  100,  100,  100,  447,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -399, -399, -399, -399,  100, -399,
			  100,  100,  100,  100,  100,  100,  100,  100,  447,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -399, -399, -399, -399,
			 -399, -399, -399, -399, -399, -399, -399, -399, -399, -399,
			 -399, -399, -399, -399, -399, -399, -399, -399, -399, -399,
			 -399, -399, -399, -399, -399, -399, -399, -399, -399, -399,

			 -399, -399, -399, -399, -399, -399, -399, -399, -399, -399,
			 -399, -399, -399, -399, -399, -399, -399, -399, -399, -399,
			 -399, -399, -399, -399, -399, -399, -399, -399, -399, -399,
			 -399, -399, -399, -399, -399, -399, -399, -399, -399, -399,
			 -399, -399, -399, -399, -399, -399, -399, -399, -399, -399,
			 -399, -399, -399, -399, -399, -399, -399, -399, -399, -399,
			 -399, -399, -399, -399, -399, -399, -399, -399, -399, -399,
			 -399, -399, -399, -399, -399, -399, -399, -399, -399, -399,
			 -399, -399, -399, -399, -399, -399, -399, -399, -399, -399,
			 -399, -399, -399, -399, -399, -399, -399, -399, -399, -399,

			    5, -400, -400, -400, -400, -400, -400, -400, -400, -400,
			 -400, -400, -400, -400, -400, -400, -400, -400, -400, -400,
			 -400, -400, -400, -400, -400, -400, -400, -400, -400, -400,
			 -400, -400, -400, -400, -400, -400, -400, -400, -400, -400,
			 -400, -400, -400, -400, -400, -400, -400, -400,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -400, -400,
			 -400, -400, -400, -400, -400,  100,  100,  448,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -400, -400, -400, -400,  100, -400,  100,  100,  448,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -400, -400, -400, -400, -400, -400, -400,
			 -400, -400, -400, -400, -400, -400, -400, -400, -400, -400,
			 -400, -400, -400, -400, -400, -400, -400, -400, -400, -400,
			 -400, -400, -400, -400, -400, -400, -400, -400, -400, -400,
			 -400, -400, -400, -400, -400, -400, -400, -400, -400, -400,
			 -400, -400, -400, -400, -400, -400, -400, -400, -400, -400,
			 -400, -400, -400, -400, -400, -400, -400, -400, -400, -400,
			 -400, -400, -400, -400, -400, -400, -400, -400, -400, -400, yy_Dummy>>,
			1, 1000, 102000)
		end

	yy_nxt_template_104 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -400, -400, -400, -400, -400, -400, -400, -400, -400, -400,
			 -400, -400, -400, -400, -400, -400, -400, -400, -400, -400,
			 -400, -400, -400, -400, -400, -400, -400, -400, -400, -400,
			 -400, -400, -400, -400, -400, -400, -400, -400, -400, -400,
			 -400, -400, -400, -400, -400, -400, -400, -400, -400, -400,
			 -400, -400, -400, -400, -400, -400, -400,    5, -401, -401,
			 -401, -401, -401, -401, -401, -401, -401, -401, -401, -401,
			 -401, -401, -401, -401, -401, -401, -401, -401, -401, -401,
			 -401, -401, -401, -401, -401, -401, -401, -401, -401, -401,
			 -401, -401, -401, -401, -401, -401, -401, -401, -401, -401,

			 -401, -401, -401, -401, -401,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -401, -401, -401, -401, -401,
			 -401, -401,  100,  100,  100,  100,  100,  100,  100,  100,
			  449,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -401, -401,
			 -401, -401,  100, -401,  100,  100,  100,  100,  100,  100,
			  100,  100,  449,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -401, -401, -401, -401, -401, -401, -401, -401, -401, -401,
			 -401, -401, -401, -401, -401, -401, -401, -401, -401, -401,

			 -401, -401, -401, -401, -401, -401, -401, -401, -401, -401,
			 -401, -401, -401, -401, -401, -401, -401, -401, -401, -401,
			 -401, -401, -401, -401, -401, -401, -401, -401, -401, -401,
			 -401, -401, -401, -401, -401, -401, -401, -401, -401, -401,
			 -401, -401, -401, -401, -401, -401, -401, -401, -401, -401,
			 -401, -401, -401, -401, -401, -401, -401, -401, -401, -401,
			 -401, -401, -401, -401, -401, -401, -401, -401, -401, -401,
			 -401, -401, -401, -401, -401, -401, -401, -401, -401, -401,
			 -401, -401, -401, -401, -401, -401, -401, -401, -401, -401,
			 -401, -401, -401, -401, -401, -401, -401, -401, -401, -401,

			 -401, -401, -401, -401, -401, -401, -401, -401, -401, -401,
			 -401, -401, -401, -401,    5, -402, -402, -402, -402, -402,
			 -402, -402, -402, -402, -402, -402, -402, -402, -402, -402,
			 -402, -402, -402, -402, -402, -402, -402, -402, -402, -402,
			 -402, -402, -402, -402, -402, -402, -402, -402, -402, -402,
			 -402, -402, -402, -402, -402, -402, -402, -402, -402, -402,
			 -402, -402,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -402, -402, -402, -402, -402, -402, -402,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100, -402, -402, -402, -402,  100,
			 -402,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -402, -402, -402,
			 -402, -402, -402, -402, -402, -402, -402, -402, -402, -402,
			 -402, -402, -402, -402, -402, -402, -402, -402, -402, -402,
			 -402, -402, -402, -402, -402, -402, -402, -402, -402, -402,
			 -402, -402, -402, -402, -402, -402, -402, -402, -402, -402,
			 -402, -402, -402, -402, -402, -402, -402, -402, -402, -402,
			 -402, -402, -402, -402, -402, -402, -402, -402, -402, -402,

			 -402, -402, -402, -402, -402, -402, -402, -402, -402, -402,
			 -402, -402, -402, -402, -402, -402, -402, -402, -402, -402,
			 -402, -402, -402, -402, -402, -402, -402, -402, -402, -402,
			 -402, -402, -402, -402, -402, -402, -402, -402, -402, -402,
			 -402, -402, -402, -402, -402, -402, -402, -402, -402, -402,
			 -402, -402, -402, -402, -402, -402, -402, -402, -402, -402,
			 -402, -402, -402, -402, -402, -402, -402, -402, -402, -402,
			 -402,    5, -403, -403, -403, -403, -403, -403, -403, -403,
			 -403, -403, -403, -403, -403, -403, -403, -403, -403, -403,
			 -403, -403, -403, -403, -403, -403, -403, -403, -403, -403,

			 -403, -403, -403, -403, -403, -403, -403, -403, -403, -403,
			 -403, -403, -403, -403, -403, -403, -403, -403, -403,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -403,
			 -403, -403, -403, -403, -403, -403,  100,  100,  100,  100,
			  450,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -403, -403, -403, -403,  100, -403,  100,  100,
			  100,  100,  450,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -403, -403, -403, -403, -403, -403,

			 -403, -403, -403, -403, -403, -403, -403, -403, -403, -403,
			 -403, -403, -403, -403, -403, -403, -403, -403, -403, -403,
			 -403, -403, -403, -403, -403, -403, -403, -403, -403, -403,
			 -403, -403, -403, -403, -403, -403, -403, -403, -403, -403,
			 -403, -403, -403, -403, -403, -403, -403, -403, -403, -403,
			 -403, -403, -403, -403, -403, -403, -403, -403, -403, -403,
			 -403, -403, -403, -403, -403, -403, -403, -403, -403, -403,
			 -403, -403, -403, -403, -403, -403, -403, -403, -403, -403,
			 -403, -403, -403, -403, -403, -403, -403, -403, -403, -403,
			 -403, -403, -403, -403, -403, -403, -403, -403, -403, -403,

			 -403, -403, -403, -403, -403, -403, -403, -403, -403, -403,
			 -403, -403, -403, -403, -403, -403, -403, -403, -403, -403,
			 -403, -403, -403, -403, -403, -403, -403, -403,    5, -404,
			 -404, -404, -404, -404, -404, -404, -404, -404, -404, -404,
			 -404, -404, -404, -404, -404, -404, -404, -404, -404, -404,
			 -404, -404, -404, -404, -404, -404, -404, -404, -404, -404,
			 -404, -404, -404, -404, -404, -404, -404, -404, -404, -404,
			 -404, -404, -404, -404, -404, -404,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -404, -404, -404, -404,
			 -404, -404, -404,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  451,  100,  100,  100,  100,  100,  100,  100,  100, -404,
			 -404, -404, -404,  100, -404,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  451,  100,  100,  100,  100,  100,  100,  100,
			  100, -404, -404, -404, -404, -404, -404, -404, -404, -404,
			 -404, -404, -404, -404, -404, -404, -404, -404, -404, -404,
			 -404, -404, -404, -404, -404, -404, -404, -404, -404, -404,
			 -404, -404, -404, -404, -404, -404, -404, -404, -404, -404,
			 -404, -404, -404, -404, -404, -404, -404, -404, -404, -404, yy_Dummy>>,
			1, 1000, 103000)
		end

	yy_nxt_template_105 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -404, -404, -404, -404, -404, -404, -404, -404, -404, -404,
			 -404, -404, -404, -404, -404, -404, -404, -404, -404, -404,
			 -404, -404, -404, -404, -404, -404, -404, -404, -404, -404,
			 -404, -404, -404, -404, -404, -404, -404, -404, -404, -404,
			 -404, -404, -404, -404, -404, -404, -404, -404, -404, -404,
			 -404, -404, -404, -404, -404, -404, -404, -404, -404, -404,
			 -404, -404, -404, -404, -404, -404, -404, -404, -404, -404,
			 -404, -404, -404, -404, -404, -404, -404, -404, -404, -404,
			 -404, -404, -404, -404, -404,    5, -405, -405, -405, -405,
			 -405, -405, -405, -405, -405, -405, -405, -405, -405, -405,

			 -405, -405, -405, -405, -405, -405, -405, -405, -405, -405,
			 -405, -405, -405, -405, -405, -405, -405, -405, -405, -405,
			 -405, -405, -405, -405, -405, -405, -405, -405, -405, -405,
			 -405, -405, -405,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -405, -405, -405, -405, -405, -405, -405,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  452,  100,  100, -405, -405, -405, -405,
			  100, -405,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  452,  100,  100, -405, -405,
			 -405, -405, -405, -405, -405, -405, -405, -405, -405, -405,
			 -405, -405, -405, -405, -405, -405, -405, -405, -405, -405,
			 -405, -405, -405, -405, -405, -405, -405, -405, -405, -405,
			 -405, -405, -405, -405, -405, -405, -405, -405, -405, -405,
			 -405, -405, -405, -405, -405, -405, -405, -405, -405, -405,
			 -405, -405, -405, -405, -405, -405, -405, -405, -405, -405,
			 -405, -405, -405, -405, -405, -405, -405, -405, -405, -405,
			 -405, -405, -405, -405, -405, -405, -405, -405, -405, -405,
			 -405, -405, -405, -405, -405, -405, -405, -405, -405, -405,

			 -405, -405, -405, -405, -405, -405, -405, -405, -405, -405,
			 -405, -405, -405, -405, -405, -405, -405, -405, -405, -405,
			 -405, -405, -405, -405, -405, -405, -405, -405, -405, -405,
			 -405, -405, -405, -405, -405, -405, -405, -405, -405, -405,
			 -405, -405,    5, -406, -406, -406, -406, -406, -406, -406,
			 -406, -406, -406, -406, -406, -406, -406, -406, -406, -406,
			 -406, -406, -406, -406, -406, -406, -406, -406, -406, -406,
			 -406, -406, -406, -406, -406, -406, -406, -406, -406, -406,
			 -406, -406, -406, -406, -406, -406, -406, -406, -406, -406,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			 -406, -406, -406, -406, -406, -406, -406,  100,  100,  100,
			  100,  100,  100,  100,  100,  453,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -406, -406, -406, -406,  100, -406,  100,
			  100,  100,  100,  100,  100,  100,  100,  453,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -406, -406, -406, -406, -406,
			 -406, -406, -406, -406, -406, -406, -406, -406, -406, -406,
			 -406, -406, -406, -406, -406, -406, -406, -406, -406, -406,
			 -406, -406, -406, -406, -406, -406, -406, -406, -406, -406,

			 -406, -406, -406, -406, -406, -406, -406, -406, -406, -406,
			 -406, -406, -406, -406, -406, -406, -406, -406, -406, -406,
			 -406, -406, -406, -406, -406, -406, -406, -406, -406, -406,
			 -406, -406, -406, -406, -406, -406, -406, -406, -406, -406,
			 -406, -406, -406, -406, -406, -406, -406, -406, -406, -406,
			 -406, -406, -406, -406, -406, -406, -406, -406, -406, -406,
			 -406, -406, -406, -406, -406, -406, -406, -406, -406, -406,
			 -406, -406, -406, -406, -406, -406, -406, -406, -406, -406,
			 -406, -406, -406, -406, -406, -406, -406, -406, -406, -406,
			 -406, -406, -406, -406, -406, -406, -406, -406, -406,    5,

			 -407, -407, -407, -407, -407, -407, -407, -407, -407, -407,
			 -407, -407, -407, -407, -407, -407, -407, -407, -407, -407,
			 -407, -407, -407, -407, -407, -407, -407, -407, -407, -407,
			 -407, -407, -407, -407, -407, -407, -407, -407, -407, -407,
			 -407, -407, -407, -407, -407, -407, -407,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -407, -407, -407,
			 -407, -407, -407, -407,  100,  100,  100,  100,  454,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -407, -407, -407, -407,  100, -407,  100,  100,  100,  100,

			  454,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -407, -407, -407, -407, -407, -407, -407, -407,
			 -407, -407, -407, -407, -407, -407, -407, -407, -407, -407,
			 -407, -407, -407, -407, -407, -407, -407, -407, -407, -407,
			 -407, -407, -407, -407, -407, -407, -407, -407, -407, -407,
			 -407, -407, -407, -407, -407, -407, -407, -407, -407, -407,
			 -407, -407, -407, -407, -407, -407, -407, -407, -407, -407,
			 -407, -407, -407, -407, -407, -407, -407, -407, -407, -407,
			 -407, -407, -407, -407, -407, -407, -407, -407, -407, -407,

			 -407, -407, -407, -407, -407, -407, -407, -407, -407, -407,
			 -407, -407, -407, -407, -407, -407, -407, -407, -407, -407,
			 -407, -407, -407, -407, -407, -407, -407, -407, -407, -407,
			 -407, -407, -407, -407, -407, -407, -407, -407, -407, -407,
			 -407, -407, -407, -407, -407, -407, -407, -407, -407, -407,
			 -407, -407, -407, -407, -407, -407,    5, -408, -408, -408,
			 -408, -408, -408, -408, -408, -408, -408, -408, -408, -408,
			 -408, -408, -408, -408, -408, -408, -408, -408, -408, -408,
			 -408, -408, -408, -408, -408, -408, -408, -408, -408, -408,
			 -408, -408, -408, -408, -408, -408, -408, -408, -408, -408,

			 -408, -408, -408, -408,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -408, -408, -408, -408, -408, -408,
			 -408,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  455,  100,
			  100,  100,  100,  100,  100,  100,  100, -408, -408, -408,
			 -408,  100, -408,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  455,  100,  100,  100,  100,  100,  100,  100,  100, -408,
			 -408, -408, -408, -408, -408, -408, -408, -408, -408, -408,
			 -408, -408, -408, -408, -408, -408, -408, -408, -408, -408, yy_Dummy>>,
			1, 1000, 104000)
		end

	yy_nxt_template_106 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -408, -408, -408, -408, -408, -408, -408, -408, -408, -408,
			 -408, -408, -408, -408, -408, -408, -408, -408, -408, -408,
			 -408, -408, -408, -408, -408, -408, -408, -408, -408, -408,
			 -408, -408, -408, -408, -408, -408, -408, -408, -408, -408,
			 -408, -408, -408, -408, -408, -408, -408, -408, -408, -408,
			 -408, -408, -408, -408, -408, -408, -408, -408, -408, -408,
			 -408, -408, -408, -408, -408, -408, -408, -408, -408, -408,
			 -408, -408, -408, -408, -408, -408, -408, -408, -408, -408,
			 -408, -408, -408, -408, -408, -408, -408, -408, -408, -408,
			 -408, -408, -408, -408, -408, -408, -408, -408, -408, -408,

			 -408, -408, -408, -408, -408, -408, -408, -408, -408, -408,
			 -408, -408, -408,    5, -409, -409, -409, -409, -409, -409,
			 -409, -409, -409, -409, -409, -409, -409, -409, -409, -409,
			 -409, -409, -409, -409, -409, -409, -409, -409, -409, -409,
			 -409, -409, -409, -409, -409, -409, -409, -409, -409, -409,
			 -409, -409, -409, -409, -409, -409, -409, -409, -409, -409,
			 -409,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -409, -409, -409, -409, -409, -409, -409,  100,  100,
			  100,  100,  456,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100, -409, -409, -409, -409,  100, -409,
			  100,  100,  100,  100,  456,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -409, -409, -409, -409,
			 -409, -409, -409, -409, -409, -409, -409, -409, -409, -409,
			 -409, -409, -409, -409, -409, -409, -409, -409, -409, -409,
			 -409, -409, -409, -409, -409, -409, -409, -409, -409, -409,
			 -409, -409, -409, -409, -409, -409, -409, -409, -409, -409,
			 -409, -409, -409, -409, -409, -409, -409, -409, -409, -409,
			 -409, -409, -409, -409, -409, -409, -409, -409, -409, -409,

			 -409, -409, -409, -409, -409, -409, -409, -409, -409, -409,
			 -409, -409, -409, -409, -409, -409, -409, -409, -409, -409,
			 -409, -409, -409, -409, -409, -409, -409, -409, -409, -409,
			 -409, -409, -409, -409, -409, -409, -409, -409, -409, -409,
			 -409, -409, -409, -409, -409, -409, -409, -409, -409, -409,
			 -409, -409, -409, -409, -409, -409, -409, -409, -409, -409,
			 -409, -409, -409, -409, -409, -409, -409, -409, -409, -409,
			    5, -410, -410, -410, -410, -410, -410, -410, -410, -410,
			 -410, -410, -410, -410, -410, -410, -410, -410, -410, -410,
			 -410, -410, -410, -410, -410, -410, -410, -410, -410, -410,

			 -410, -410, -410, -410, -410, -410, -410, -410, -410, -410,
			 -410, -410, -410, -410, -410, -410, -410, -410,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -410, -410,
			 -410, -410, -410, -410, -410,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  457,  100,  100,  100,  100,  100,
			  100, -410, -410, -410, -410,  100, -410,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  457,  100,  100,  100,
			  100,  100,  100, -410, -410, -410, -410, -410, -410, -410,

			 -410, -410, -410, -410, -410, -410, -410, -410, -410, -410,
			 -410, -410, -410, -410, -410, -410, -410, -410, -410, -410,
			 -410, -410, -410, -410, -410, -410, -410, -410, -410, -410,
			 -410, -410, -410, -410, -410, -410, -410, -410, -410, -410,
			 -410, -410, -410, -410, -410, -410, -410, -410, -410, -410,
			 -410, -410, -410, -410, -410, -410, -410, -410, -410, -410,
			 -410, -410, -410, -410, -410, -410, -410, -410, -410, -410,
			 -410, -410, -410, -410, -410, -410, -410, -410, -410, -410,
			 -410, -410, -410, -410, -410, -410, -410, -410, -410, -410,
			 -410, -410, -410, -410, -410, -410, -410, -410, -410, -410,

			 -410, -410, -410, -410, -410, -410, -410, -410, -410, -410,
			 -410, -410, -410, -410, -410, -410, -410, -410, -410, -410,
			 -410, -410, -410, -410, -410, -410, -410,    5, -411, -411,
			 -411, -411, -411, -411, -411, -411, -411, -411, -411, -411,
			 -411, -411, -411, -411, -411, -411, -411, -411, -411, -411,
			 -411, -411, -411, -411, -411, -411, -411, -411, -411, -411,
			 -411, -411, -411, -411, -411, -411, -411, -411, -411, -411,
			 -411, -411, -411, -411, -411,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -411, -411, -411, -411, -411,
			 -411, -411,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -411, -411,
			 -411, -411,  100, -411,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -411, -411, -411, -411, -411, -411, -411, -411, -411, -411,
			 -411, -411, -411, -411, -411, -411, -411, -411, -411, -411,
			 -411, -411, -411, -411, -411, -411, -411, -411, -411, -411,
			 -411, -411, -411, -411, -411, -411, -411, -411, -411, -411,
			 -411, -411, -411, -411, -411, -411, -411, -411, -411, -411,

			 -411, -411, -411, -411, -411, -411, -411, -411, -411, -411,
			 -411, -411, -411, -411, -411, -411, -411, -411, -411, -411,
			 -411, -411, -411, -411, -411, -411, -411, -411, -411, -411,
			 -411, -411, -411, -411, -411, -411, -411, -411, -411, -411,
			 -411, -411, -411, -411, -411, -411, -411, -411, -411, -411,
			 -411, -411, -411, -411, -411, -411, -411, -411, -411, -411,
			 -411, -411, -411, -411, -411, -411, -411, -411, -411, -411,
			 -411, -411, -411, -411, -411, -411, -411, -411, -411, -411,
			 -411, -411, -411, -411,    5, -412, -412, -412, -412, -412,
			 -412, -412, -412, -412, -412, -412, -412, -412, -412, -412,

			 -412, -412, -412, -412, -412, -412, -412, -412, -412, -412,
			 -412, -412, -412, -412, -412, -412, -412, -412, -412, -412,
			 -412, -412, -412, -412, -412, -412, -412, -412, -412, -412,
			 -412, -412,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -412, -412, -412, -412, -412, -412, -412,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  458,  100,
			  100,  100,  100,  100,  100, -412, -412, -412, -412,  100,
			 -412,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100, yy_Dummy>>,
			1, 1000, 105000)
		end

	yy_nxt_template_107 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  458,  100,  100,  100,  100,  100,  100, -412, -412, -412,
			 -412, -412, -412, -412, -412, -412, -412, -412, -412, -412,
			 -412, -412, -412, -412, -412, -412, -412, -412, -412, -412,
			 -412, -412, -412, -412, -412, -412, -412, -412, -412, -412,
			 -412, -412, -412, -412, -412, -412, -412, -412, -412, -412,
			 -412, -412, -412, -412, -412, -412, -412, -412, -412, -412,
			 -412, -412, -412, -412, -412, -412, -412, -412, -412, -412,
			 -412, -412, -412, -412, -412, -412, -412, -412, -412, -412,
			 -412, -412, -412, -412, -412, -412, -412, -412, -412, -412,
			 -412, -412, -412, -412, -412, -412, -412, -412, -412, -412,

			 -412, -412, -412, -412, -412, -412, -412, -412, -412, -412,
			 -412, -412, -412, -412, -412, -412, -412, -412, -412, -412,
			 -412, -412, -412, -412, -412, -412, -412, -412, -412, -412,
			 -412, -412, -412, -412, -412, -412, -412, -412, -412, -412,
			 -412,    5, -413, -413, -413, -413, -413, -413, -413, -413,
			 -413, -413, -413, -413, -413, -413, -413, -413, -413, -413,
			 -413, -413, -413, -413, -413, -413, -413, -413, -413, -413,
			 -413, -413, -413, -413, -413, -413, -413, -413, -413, -413,
			 -413, -413, -413, -413, -413, -413, -413, -413, -413,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -413,

			 -413, -413, -413, -413, -413, -413,  459,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -413, -413, -413, -413,  100, -413,  459,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -413, -413, -413, -413, -413, -413,
			 -413, -413, -413, -413, -413, -413, -413, -413, -413, -413,
			 -413, -413, -413, -413, -413, -413, -413, -413, -413, -413,
			 -413, -413, -413, -413, -413, -413, -413, -413, -413, -413,

			 -413, -413, -413, -413, -413, -413, -413, -413, -413, -413,
			 -413, -413, -413, -413, -413, -413, -413, -413, -413, -413,
			 -413, -413, -413, -413, -413, -413, -413, -413, -413, -413,
			 -413, -413, -413, -413, -413, -413, -413, -413, -413, -413,
			 -413, -413, -413, -413, -413, -413, -413, -413, -413, -413,
			 -413, -413, -413, -413, -413, -413, -413, -413, -413, -413,
			 -413, -413, -413, -413, -413, -413, -413, -413, -413, -413,
			 -413, -413, -413, -413, -413, -413, -413, -413, -413, -413,
			 -413, -413, -413, -413, -413, -413, -413, -413, -413, -413,
			 -413, -413, -413, -413, -413, -413, -413, -413,    5, -414,

			 -414, -414, -414, -414, -414, -414, -414, -414, -414, -414,
			 -414, -414, -414, -414, -414, -414, -414, -414, -414, -414,
			 -414, -414, -414, -414, -414, -414, -414, -414, -414, -414,
			 -414, -414, -414, -414, -414, -414, -414, -414, -414, -414,
			 -414, -414, -414, -414, -414, -414,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -414, -414, -414, -414,
			 -414, -414, -414,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -414,
			 -414, -414, -414,  100, -414,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -414, -414, -414, -414, -414, -414, -414, -414, -414,
			 -414, -414, -414, -414, -414, -414, -414, -414, -414, -414,
			 -414, -414, -414, -414, -414, -414, -414, -414, -414, -414,
			 -414, -414, -414, -414, -414, -414, -414, -414, -414, -414,
			 -414, -414, -414, -414, -414, -414, -414, -414, -414, -414,
			 -414, -414, -414, -414, -414, -414, -414, -414, -414, -414,
			 -414, -414, -414, -414, -414, -414, -414, -414, -414, -414,
			 -414, -414, -414, -414, -414, -414, -414, -414, -414, -414,

			 -414, -414, -414, -414, -414, -414, -414, -414, -414, -414,
			 -414, -414, -414, -414, -414, -414, -414, -414, -414, -414,
			 -414, -414, -414, -414, -414, -414, -414, -414, -414, -414,
			 -414, -414, -414, -414, -414, -414, -414, -414, -414, -414,
			 -414, -414, -414, -414, -414, -414, -414, -414, -414, -414,
			 -414, -414, -414, -414, -414,    5, -415, -415, -415, -415,
			 -415, -415, -415, -415, -415, -415, -415, -415, -415, -415,
			 -415, -415, -415, -415, -415, -415, -415, -415, -415, -415,
			 -415, -415, -415, -415, -415, -415, -415, -415, -415, -415,
			 -415, -415, -415, -415, -415, -415, -415, -415, -415, -415,

			 -415, -415, -415,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -415, -415, -415, -415, -415, -415, -415,
			  100,  100,  100,  100,  100,  100,  100,  100,  460,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -415, -415, -415, -415,
			  100, -415,  100,  100,  100,  100,  100,  100,  100,  100,
			  460,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -415, -415,
			 -415, -415, -415, -415, -415, -415, -415, -415, -415, -415,
			 -415, -415, -415, -415, -415, -415, -415, -415, -415, -415,

			 -415, -415, -415, -415, -415, -415, -415, -415, -415, -415,
			 -415, -415, -415, -415, -415, -415, -415, -415, -415, -415,
			 -415, -415, -415, -415, -415, -415, -415, -415, -415, -415,
			 -415, -415, -415, -415, -415, -415, -415, -415, -415, -415,
			 -415, -415, -415, -415, -415, -415, -415, -415, -415, -415,
			 -415, -415, -415, -415, -415, -415, -415, -415, -415, -415,
			 -415, -415, -415, -415, -415, -415, -415, -415, -415, -415,
			 -415, -415, -415, -415, -415, -415, -415, -415, -415, -415,
			 -415, -415, -415, -415, -415, -415, -415, -415, -415, -415,
			 -415, -415, -415, -415, -415, -415, -415, -415, -415, -415,

			 -415, -415, -415, -415, -415, -415, -415, -415, -415, -415,
			 -415, -415,    5, -416, -416, -416, -416, -416, -416, -416,
			 -416, -416, -416, -416, -416, -416, -416, -416, -416, -416,
			 -416, -416, -416, -416, -416, -416, -416, -416, -416, -416,
			 -416, -416, -416, -416, -416, -416, -416, -416, -416, -416,
			 -416, -416, -416, -416, -416, -416, -416, -416, -416, -416,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -416, -416, -416, -416, -416, -416, -416,  100,  100,  100,
			  100,  461,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100, yy_Dummy>>,
			1, 1000, 106000)
		end

	yy_nxt_template_108 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  100,  100,  100, -416, -416, -416, -416,  100, -416,  100,
			  100,  100,  100,  461,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -416, -416, -416, -416, -416,
			 -416, -416, -416, -416, -416, -416, -416, -416, -416, -416,
			 -416, -416, -416, -416, -416, -416, -416, -416, -416, -416,
			 -416, -416, -416, -416, -416, -416, -416, -416, -416, -416,
			 -416, -416, -416, -416, -416, -416, -416, -416, -416, -416,
			 -416, -416, -416, -416, -416, -416, -416, -416, -416, -416,
			 -416, -416, -416, -416, -416, -416, -416, -416, -416, -416,

			 -416, -416, -416, -416, -416, -416, -416, -416, -416, -416,
			 -416, -416, -416, -416, -416, -416, -416, -416, -416, -416,
			 -416, -416, -416, -416, -416, -416, -416, -416, -416, -416,
			 -416, -416, -416, -416, -416, -416, -416, -416, -416, -416,
			 -416, -416, -416, -416, -416, -416, -416, -416, -416, -416,
			 -416, -416, -416, -416, -416, -416, -416, -416, -416, -416,
			 -416, -416, -416, -416, -416, -416, -416, -416, -416,    5,
			 -417, -417, -417, -417, -417, -417, -417, -417, -417, -417,
			 -417, -417, -417, -417, -417, -417, -417, -417, -417, -417,
			 -417, -417, -417, -417, -417, -417, -417, -417, -417, -417,

			 -417, -417, -417, -417, -417, -417, -417, -417, -417, -417,
			 -417, -417, -417, -417, -417, -417, -417,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -417, -417, -417,
			 -417, -417, -417, -417,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -417, -417, -417, -417,  100, -417,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -417, -417, -417, -417, -417, -417, -417, -417,

			 -417, -417, -417, -417, -417, -417, -417, -417, -417, -417,
			 -417, -417, -417, -417, -417, -417, -417, -417, -417, -417,
			 -417, -417, -417, -417, -417, -417, -417, -417, -417, -417,
			 -417, -417, -417, -417, -417, -417, -417, -417, -417, -417,
			 -417, -417, -417, -417, -417, -417, -417, -417, -417, -417,
			 -417, -417, -417, -417, -417, -417, -417, -417, -417, -417,
			 -417, -417, -417, -417, -417, -417, -417, -417, -417, -417,
			 -417, -417, -417, -417, -417, -417, -417, -417, -417, -417,
			 -417, -417, -417, -417, -417, -417, -417, -417, -417, -417,
			 -417, -417, -417, -417, -417, -417, -417, -417, -417, -417,

			 -417, -417, -417, -417, -417, -417, -417, -417, -417, -417,
			 -417, -417, -417, -417, -417, -417, -417, -417, -417, -417,
			 -417, -417, -417, -417, -417, -417,    5, -418, -418, -418,
			 -418, -418, -418, -418, -418, -418, -418, -418, -418, -418,
			 -418, -418, -418, -418, -418, -418, -418, -418, -418, -418,
			 -418, -418, -418, -418, -418, -418, -418, -418, -418, -418,
			 -418, -418, -418, -418, -418, -418, -418, -418, -418, -418,
			 -418, -418, -418, -418,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -418, -418, -418, -418, -418, -418,
			 -418,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  462,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -418, -418, -418,
			 -418,  100, -418,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  462,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -418,
			 -418, -418, -418, -418, -418, -418, -418, -418, -418, -418,
			 -418, -418, -418, -418, -418, -418, -418, -418, -418, -418,
			 -418, -418, -418, -418, -418, -418, -418, -418, -418, -418,
			 -418, -418, -418, -418, -418, -418, -418, -418, -418, -418,
			 -418, -418, -418, -418, -418, -418, -418, -418, -418, -418,

			 -418, -418, -418, -418, -418, -418, -418, -418, -418, -418,
			 -418, -418, -418, -418, -418, -418, -418, -418, -418, -418,
			 -418, -418, -418, -418, -418, -418, -418, -418, -418, -418,
			 -418, -418, -418, -418, -418, -418, -418, -418, -418, -418,
			 -418, -418, -418, -418, -418, -418, -418, -418, -418, -418,
			 -418, -418, -418, -418, -418, -418, -418, -418, -418, -418,
			 -418, -418, -418, -418, -418, -418, -418, -418, -418, -418,
			 -418, -418, -418, -418, -418, -418, -418, -418, -418, -418,
			 -418, -418, -418,    5,   63,   63,   63,   63,   63,   63,
			   63,   63,   63, -419,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   64,   63,   63,
			 -419,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,  463,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,  463,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			    5,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			 -420,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   64,   63,   63, -420,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63, yy_Dummy>>,
			1, 1000, 107000)
		end

	yy_nxt_template_109 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			   63,   63,   63,   63,   63,   63,   63,   63,   63,  464,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,  464,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,    5,   63,   63,

			   63,   63,   63,   63,   63,   63,   63, -421,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   64,   63,   63, -421,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			  465,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,  465,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,    5, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,

			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,

			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,

			 -422, -422, -422, -422, -422, -422, -422, -422, -422, -422,
			 -422,    5, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423,  466, -423,  466, -423, -423,  467,
			  467,  467,  467,  467,  467,  467,  467,  467,  467, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,

			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,

			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423, -423, -423,
			 -423, -423, -423, -423, -423, -423, -423, -423,    5, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424, yy_Dummy>>,
			1, 1000, 108000)
		end

	yy_nxt_template_110 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424,  467,  467,  467,  467,
			  467,  467,  467,  467,  467,  467, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424,  371, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,

			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,

			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424, -424, -424, -424, -424, -424,
			 -424, -424, -424, -424, -424,    5, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425,  468,  468,  468,  468,  468,  468,  468,
			  468,  468,  468, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,

			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,

			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425, -425, -425, -425, -425, -425, -425, -425, -425,
			 -425, -425,    5, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,

			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426,  469, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426,  213, -426, -426,
			 -426, -426, -426,  469, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,

			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,

			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426, -426,
			 -426, -426, -426, -426, -426, -426, -426, -426, -426,    5,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427,  427,  427,  427,
			  427,  427,  427,  427,  427,  427,  427, -427, -427, -427,

			 -427, -427, -427, -427, -427, -427, -427, -427,  470, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			  470, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,

			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427, -427, -427, -427, -427,
			 -427, -427, -427, -427, -427, -427,    5, -428, -428, -428, yy_Dummy>>,
			1, 1000, 109000)
		end

	yy_nxt_template_111 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428,  471,  471,  471,  471,  471,  471,
			  471,  471,  471,  471, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428,  429, -428, -428, -428, -428, -428, -428, -428, -428,

			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,

			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428, -428, -428, -428, -428, -428, -428, -428,
			 -428, -428, -428,    5, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,

			 -429,  472,  472,  472,  472,  472,  472,  472,  472,  472,
			  472, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,

			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,

			 -429, -429, -429, -429, -429, -429, -429, -429, -429, -429,
			    5, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430,  473,  473,
			  473,  473,  473,  473,  473,  473,  473,  473, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,

			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,

			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430, -430, -430, -430,
			 -430, -430, -430, -430, -430, -430, -430,    5, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,

			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431,  474,  474,  474,  474,  474,
			  474,  474,  474,  474,  474, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431,  378, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,

			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431, yy_Dummy>>,
			1, 1000, 110000)
		end

	yy_nxt_template_112 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431, -431, -431, -431, -431, -431, -431,
			 -431, -431, -431, -431,    5, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432,  475,  475,  475,  475,  475,  475,  475,  475,
			  475,  475, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,

			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,

			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432, -432, -432, -432, -432, -432, -432, -432, -432, -432,
			 -432,    5, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,

			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433,  476, -433,  476, -433, -433,  474,
			  474,  474,  474,  474,  474,  474,  474,  474,  474, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,

			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,

			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433, -433, -433,
			 -433, -433, -433, -433, -433, -433, -433, -433,    5,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477, -434,  477,  478,  478,  478,  478,
			  478,  478,  478,  478,  478,  478,  477,  477,  477,  477,

			  477,  477,  477,  477,  477,  477,  477,  479,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  479,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,

			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,    5, -435, -435, -435, -435,

			 -435, -435, -435, -435, -435, -435, -435, -435, -435, -435,
			 -435, -435, -435, -435, -435, -435, -435, -435, -435, -435,
			 -435, -435, -435, -435, -435, -435, -435, -435, -435, -435,
			 -435, -435, -435, -435, -435, -435, -435, -435, -435, -435,
			 -435, -435, -435,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -435, -435, -435, -435, -435, -435, -435,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  480,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -435, -435, -435, -435,
			  100, -435,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  480,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -435, -435,
			 -435, -435, -435, -435, -435, -435, -435, -435, -435, -435,
			 -435, -435, -435, -435, -435, -435, -435, -435, -435, -435,
			 -435, -435, -435, -435, -435, -435, -435, -435, -435, -435,
			 -435, -435, -435, -435, -435, -435, -435, -435, -435, -435,
			 -435, -435, -435, -435, -435, -435, -435, -435, -435, -435,
			 -435, -435, -435, -435, -435, -435, -435, -435, -435, -435,
			 -435, -435, -435, -435, -435, -435, -435, -435, -435, -435,
			 -435, -435, -435, -435, -435, -435, -435, -435, -435, -435, yy_Dummy>>,
			1, 1000, 111000)
		end

	yy_nxt_template_113 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -435, -435, -435, -435, -435, -435, -435, -435, -435, -435,
			 -435, -435, -435, -435, -435, -435, -435, -435, -435, -435,
			 -435, -435, -435, -435, -435, -435, -435, -435, -435, -435,
			 -435, -435, -435, -435, -435, -435, -435, -435, -435, -435,
			 -435, -435, -435, -435, -435, -435, -435, -435, -435, -435,
			 -435, -435,    5, -436, -436, -436, -436, -436, -436, -436,
			 -436, -436, -436, -436, -436, -436, -436, -436, -436, -436,
			 -436, -436, -436, -436, -436, -436, -436, -436, -436, -436,
			 -436, -436, -436, -436, -436, -436, -436, -436, -436, -436,
			 -436, -436, -436, -436, -436, -436, -436, -436, -436, -436,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -436, -436, -436, -436, -436, -436, -436,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  481,  100,  100,  100,
			  100,  100,  100, -436, -436, -436, -436,  100, -436,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  481,  100,
			  100,  100,  100,  100,  100, -436, -436, -436, -436, -436,
			 -436, -436, -436, -436, -436, -436, -436, -436, -436, -436,
			 -436, -436, -436, -436, -436, -436, -436, -436, -436, -436,

			 -436, -436, -436, -436, -436, -436, -436, -436, -436, -436,
			 -436, -436, -436, -436, -436, -436, -436, -436, -436, -436,
			 -436, -436, -436, -436, -436, -436, -436, -436, -436, -436,
			 -436, -436, -436, -436, -436, -436, -436, -436, -436, -436,
			 -436, -436, -436, -436, -436, -436, -436, -436, -436, -436,
			 -436, -436, -436, -436, -436, -436, -436, -436, -436, -436,
			 -436, -436, -436, -436, -436, -436, -436, -436, -436, -436,
			 -436, -436, -436, -436, -436, -436, -436, -436, -436, -436,
			 -436, -436, -436, -436, -436, -436, -436, -436, -436, -436,
			 -436, -436, -436, -436, -436, -436, -436, -436, -436, -436,

			 -436, -436, -436, -436, -436, -436, -436, -436, -436,    5,
			 -437, -437, -437, -437, -437, -437, -437, -437, -437, -437,
			 -437, -437, -437, -437, -437, -437, -437, -437, -437, -437,
			 -437, -437, -437, -437, -437, -437, -437, -437, -437, -437,
			 -437, -437, -437, -437, -437, -437, -437, -437, -437, -437,
			 -437, -437, -437, -437, -437, -437, -437,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -437, -437, -437,
			 -437, -437, -437, -437,  100,  100,  100,  100,  482,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			 -437, -437, -437, -437,  100, -437,  100,  100,  100,  100,
			  482,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -437, -437, -437, -437, -437, -437, -437, -437,
			 -437, -437, -437, -437, -437, -437, -437, -437, -437, -437,
			 -437, -437, -437, -437, -437, -437, -437, -437, -437, -437,
			 -437, -437, -437, -437, -437, -437, -437, -437, -437, -437,
			 -437, -437, -437, -437, -437, -437, -437, -437, -437, -437,
			 -437, -437, -437, -437, -437, -437, -437, -437, -437, -437,
			 -437, -437, -437, -437, -437, -437, -437, -437, -437, -437,

			 -437, -437, -437, -437, -437, -437, -437, -437, -437, -437,
			 -437, -437, -437, -437, -437, -437, -437, -437, -437, -437,
			 -437, -437, -437, -437, -437, -437, -437, -437, -437, -437,
			 -437, -437, -437, -437, -437, -437, -437, -437, -437, -437,
			 -437, -437, -437, -437, -437, -437, -437, -437, -437, -437,
			 -437, -437, -437, -437, -437, -437, -437, -437, -437, -437,
			 -437, -437, -437, -437, -437, -437,    5, -438, -438, -438,
			 -438, -438, -438, -438, -438, -438, -438, -438, -438, -438,
			 -438, -438, -438, -438, -438, -438, -438, -438, -438, -438,
			 -438, -438, -438, -438, -438, -438, -438, -438, -438, -438,

			 -438, -438, -438, -438, -438, -438, -438, -438, -438, -438,
			 -438, -438, -438, -438,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -438, -438, -438, -438, -438, -438,
			 -438,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -438, -438, -438,
			 -438,  100, -438,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -438,
			 -438, -438, -438, -438, -438, -438, -438, -438, -438, -438,

			 -438, -438, -438, -438, -438, -438, -438, -438, -438, -438,
			 -438, -438, -438, -438, -438, -438, -438, -438, -438, -438,
			 -438, -438, -438, -438, -438, -438, -438, -438, -438, -438,
			 -438, -438, -438, -438, -438, -438, -438, -438, -438, -438,
			 -438, -438, -438, -438, -438, -438, -438, -438, -438, -438,
			 -438, -438, -438, -438, -438, -438, -438, -438, -438, -438,
			 -438, -438, -438, -438, -438, -438, -438, -438, -438, -438,
			 -438, -438, -438, -438, -438, -438, -438, -438, -438, -438,
			 -438, -438, -438, -438, -438, -438, -438, -438, -438, -438,
			 -438, -438, -438, -438, -438, -438, -438, -438, -438, -438,

			 -438, -438, -438, -438, -438, -438, -438, -438, -438, -438,
			 -438, -438, -438, -438, -438, -438, -438, -438, -438, -438,
			 -438, -438, -438,    5, -439, -439, -439, -439, -439, -439,
			 -439, -439, -439, -439, -439, -439, -439, -439, -439, -439,
			 -439, -439, -439, -439, -439, -439, -439, -439, -439, -439,
			 -439, -439, -439, -439, -439, -439, -439, -439, -439, -439,
			 -439, -439, -439, -439, -439, -439, -439, -439, -439, -439,
			 -439,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -439, -439, -439, -439, -439, -439, -439,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -439, -439, -439, -439,  100, -439,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -439, -439, -439, -439,
			 -439, -439, -439, -439, -439, -439, -439, -439, -439, -439,
			 -439, -439, -439, -439, -439, -439, -439, -439, -439, -439,
			 -439, -439, -439, -439, -439, -439, -439, -439, -439, -439,
			 -439, -439, -439, -439, -439, -439, -439, -439, -439, -439,
			 -439, -439, -439, -439, -439, -439, -439, -439, -439, -439, yy_Dummy>>,
			1, 1000, 112000)
		end

	yy_nxt_template_114 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -439, -439, -439, -439, -439, -439, -439, -439, -439, -439,
			 -439, -439, -439, -439, -439, -439, -439, -439, -439, -439,
			 -439, -439, -439, -439, -439, -439, -439, -439, -439, -439,
			 -439, -439, -439, -439, -439, -439, -439, -439, -439, -439,
			 -439, -439, -439, -439, -439, -439, -439, -439, -439, -439,
			 -439, -439, -439, -439, -439, -439, -439, -439, -439, -439,
			 -439, -439, -439, -439, -439, -439, -439, -439, -439, -439,
			 -439, -439, -439, -439, -439, -439, -439, -439, -439, -439,
			    5, -440, -440, -440, -440, -440, -440, -440, -440, -440,
			 -440, -440, -440, -440, -440, -440, -440, -440, -440, -440,

			 -440, -440, -440, -440, -440, -440, -440, -440, -440, -440,
			 -440, -440, -440, -440, -440, -440, -440, -440, -440, -440,
			 -440, -440, -440, -440, -440, -440, -440, -440,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -440, -440,
			 -440, -440, -440, -440, -440,  100,  100,  100,  100,  483,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -440, -440, -440, -440,  100, -440,  100,  100,  100,
			  100,  483,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100, -440, -440, -440, -440, -440, -440, -440,
			 -440, -440, -440, -440, -440, -440, -440, -440, -440, -440,
			 -440, -440, -440, -440, -440, -440, -440, -440, -440, -440,
			 -440, -440, -440, -440, -440, -440, -440, -440, -440, -440,
			 -440, -440, -440, -440, -440, -440, -440, -440, -440, -440,
			 -440, -440, -440, -440, -440, -440, -440, -440, -440, -440,
			 -440, -440, -440, -440, -440, -440, -440, -440, -440, -440,
			 -440, -440, -440, -440, -440, -440, -440, -440, -440, -440,
			 -440, -440, -440, -440, -440, -440, -440, -440, -440, -440,
			 -440, -440, -440, -440, -440, -440, -440, -440, -440, -440,

			 -440, -440, -440, -440, -440, -440, -440, -440, -440, -440,
			 -440, -440, -440, -440, -440, -440, -440, -440, -440, -440,
			 -440, -440, -440, -440, -440, -440, -440, -440, -440, -440,
			 -440, -440, -440, -440, -440, -440, -440,    5, -441, -441,
			 -441, -441, -441, -441, -441, -441, -441, -441, -441, -441,
			 -441, -441, -441, -441, -441, -441, -441, -441, -441, -441,
			 -441, -441, -441, -441, -441, -441, -441, -441, -441, -441,
			 -441, -441, -441, -441, -441, -441, -441, -441, -441, -441,
			 -441, -441, -441, -441, -441,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -441, -441, -441, -441, -441,

			 -441, -441,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -441, -441,
			 -441, -441,  100, -441,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -441, -441, -441, -441, -441, -441, -441, -441, -441, -441,
			 -441, -441, -441, -441, -441, -441, -441, -441, -441, -441,
			 -441, -441, -441, -441, -441, -441, -441, -441, -441, -441,
			 -441, -441, -441, -441, -441, -441, -441, -441, -441, -441,

			 -441, -441, -441, -441, -441, -441, -441, -441, -441, -441,
			 -441, -441, -441, -441, -441, -441, -441, -441, -441, -441,
			 -441, -441, -441, -441, -441, -441, -441, -441, -441, -441,
			 -441, -441, -441, -441, -441, -441, -441, -441, -441, -441,
			 -441, -441, -441, -441, -441, -441, -441, -441, -441, -441,
			 -441, -441, -441, -441, -441, -441, -441, -441, -441, -441,
			 -441, -441, -441, -441, -441, -441, -441, -441, -441, -441,
			 -441, -441, -441, -441, -441, -441, -441, -441, -441, -441,
			 -441, -441, -441, -441, -441, -441, -441, -441, -441, -441,
			 -441, -441, -441, -441,    5, -442, -442, -442, -442, -442,

			 -442, -442, -442, -442, -442, -442, -442, -442, -442, -442,
			 -442, -442, -442, -442, -442, -442, -442, -442, -442, -442,
			 -442, -442, -442, -442, -442, -442, -442, -442, -442, -442,
			 -442, -442, -442, -442, -442, -442, -442, -442, -442, -442,
			 -442, -442,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -442, -442, -442, -442, -442, -442, -442,  484,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -442, -442, -442, -442,  100,
			 -442,  484,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -442, -442, -442,
			 -442, -442, -442, -442, -442, -442, -442, -442, -442, -442,
			 -442, -442, -442, -442, -442, -442, -442, -442, -442, -442,
			 -442, -442, -442, -442, -442, -442, -442, -442, -442, -442,
			 -442, -442, -442, -442, -442, -442, -442, -442, -442, -442,
			 -442, -442, -442, -442, -442, -442, -442, -442, -442, -442,
			 -442, -442, -442, -442, -442, -442, -442, -442, -442, -442,
			 -442, -442, -442, -442, -442, -442, -442, -442, -442, -442,
			 -442, -442, -442, -442, -442, -442, -442, -442, -442, -442,

			 -442, -442, -442, -442, -442, -442, -442, -442, -442, -442,
			 -442, -442, -442, -442, -442, -442, -442, -442, -442, -442,
			 -442, -442, -442, -442, -442, -442, -442, -442, -442, -442,
			 -442, -442, -442, -442, -442, -442, -442, -442, -442, -442,
			 -442, -442, -442, -442, -442, -442, -442, -442, -442, -442,
			 -442,    5, -443, -443, -443, -443, -443, -443, -443, -443,
			 -443, -443, -443, -443, -443, -443, -443, -443, -443, -443,
			 -443, -443, -443, -443, -443, -443, -443, -443, -443, -443,
			 -443, -443, -443, -443, -443, -443, -443, -443, -443, -443,
			 -443, -443, -443, -443, -443, -443, -443, -443, -443,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100, -443,
			 -443, -443, -443, -443, -443, -443,  100,  100,  100,  100,
			  485,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -443, -443, -443, -443,  100, -443,  100,  100,
			  100,  100,  485,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -443, -443, -443, -443, -443, -443,
			 -443, -443, -443, -443, -443, -443, -443, -443, -443, -443,
			 -443, -443, -443, -443, -443, -443, -443, -443, -443, -443, yy_Dummy>>,
			1, 1000, 113000)
		end

	yy_nxt_template_115 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -443, -443, -443, -443, -443, -443, -443, -443, -443, -443,
			 -443, -443, -443, -443, -443, -443, -443, -443, -443, -443,
			 -443, -443, -443, -443, -443, -443, -443, -443, -443, -443,
			 -443, -443, -443, -443, -443, -443, -443, -443, -443, -443,
			 -443, -443, -443, -443, -443, -443, -443, -443, -443, -443,
			 -443, -443, -443, -443, -443, -443, -443, -443, -443, -443,
			 -443, -443, -443, -443, -443, -443, -443, -443, -443, -443,
			 -443, -443, -443, -443, -443, -443, -443, -443, -443, -443,
			 -443, -443, -443, -443, -443, -443, -443, -443, -443, -443,
			 -443, -443, -443, -443, -443, -443, -443, -443, -443, -443,

			 -443, -443, -443, -443, -443, -443, -443, -443,    5, -444,
			 -444, -444, -444, -444, -444, -444, -444, -444, -444, -444,
			 -444, -444, -444, -444, -444, -444, -444, -444, -444, -444,
			 -444, -444, -444, -444, -444, -444, -444, -444, -444, -444,
			 -444, -444, -444, -444, -444, -444, -444, -444, -444, -444,
			 -444, -444, -444, -444, -444, -444,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -444, -444, -444, -444,
			 -444, -444, -444,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -444,

			 -444, -444, -444,  100, -444,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -444, -444, -444, -444, -444, -444, -444, -444, -444,
			 -444, -444, -444, -444, -444, -444, -444, -444, -444, -444,
			 -444, -444, -444, -444, -444, -444, -444, -444, -444, -444,
			 -444, -444, -444, -444, -444, -444, -444, -444, -444, -444,
			 -444, -444, -444, -444, -444, -444, -444, -444, -444, -444,
			 -444, -444, -444, -444, -444, -444, -444, -444, -444, -444,
			 -444, -444, -444, -444, -444, -444, -444, -444, -444, -444,

			 -444, -444, -444, -444, -444, -444, -444, -444, -444, -444,
			 -444, -444, -444, -444, -444, -444, -444, -444, -444, -444,
			 -444, -444, -444, -444, -444, -444, -444, -444, -444, -444,
			 -444, -444, -444, -444, -444, -444, -444, -444, -444, -444,
			 -444, -444, -444, -444, -444, -444, -444, -444, -444, -444,
			 -444, -444, -444, -444, -444, -444, -444, -444, -444, -444,
			 -444, -444, -444, -444, -444,    5, -445, -445, -445, -445,
			 -445, -445, -445, -445, -445, -445, -445, -445, -445, -445,
			 -445, -445, -445, -445, -445, -445, -445, -445, -445, -445,
			 -445, -445, -445, -445, -445, -445, -445, -445, -445, -445,

			 -445, -445, -445, -445, -445, -445, -445, -445, -445, -445,
			 -445, -445, -445,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -445, -445, -445, -445, -445, -445, -445,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  486,  100,
			  100,  100,  100,  100,  100,  100, -445, -445, -445, -445,
			  100, -445,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  486,  100,  100,  100,  100,  100,  100,  100, -445, -445,
			 -445, -445, -445, -445, -445, -445, -445, -445, -445, -445,

			 -445, -445, -445, -445, -445, -445, -445, -445, -445, -445,
			 -445, -445, -445, -445, -445, -445, -445, -445, -445, -445,
			 -445, -445, -445, -445, -445, -445, -445, -445, -445, -445,
			 -445, -445, -445, -445, -445, -445, -445, -445, -445, -445,
			 -445, -445, -445, -445, -445, -445, -445, -445, -445, -445,
			 -445, -445, -445, -445, -445, -445, -445, -445, -445, -445,
			 -445, -445, -445, -445, -445, -445, -445, -445, -445, -445,
			 -445, -445, -445, -445, -445, -445, -445, -445, -445, -445,
			 -445, -445, -445, -445, -445, -445, -445, -445, -445, -445,
			 -445, -445, -445, -445, -445, -445, -445, -445, -445, -445,

			 -445, -445, -445, -445, -445, -445, -445, -445, -445, -445,
			 -445, -445, -445, -445, -445, -445, -445, -445, -445, -445,
			 -445, -445,    5, -446, -446, -446, -446, -446, -446, -446,
			 -446, -446, -446, -446, -446, -446, -446, -446, -446, -446,
			 -446, -446, -446, -446, -446, -446, -446, -446, -446, -446,
			 -446, -446, -446, -446, -446, -446, -446, -446, -446, -446,
			 -446, -446, -446, -446, -446, -446, -446, -446, -446, -446,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -446, -446, -446, -446, -446, -446, -446,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  487,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -446, -446, -446, -446,  100, -446,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  487,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -446, -446, -446, -446, -446,
			 -446, -446, -446, -446, -446, -446, -446, -446, -446, -446,
			 -446, -446, -446, -446, -446, -446, -446, -446, -446, -446,
			 -446, -446, -446, -446, -446, -446, -446, -446, -446, -446,
			 -446, -446, -446, -446, -446, -446, -446, -446, -446, -446,
			 -446, -446, -446, -446, -446, -446, -446, -446, -446, -446,

			 -446, -446, -446, -446, -446, -446, -446, -446, -446, -446,
			 -446, -446, -446, -446, -446, -446, -446, -446, -446, -446,
			 -446, -446, -446, -446, -446, -446, -446, -446, -446, -446,
			 -446, -446, -446, -446, -446, -446, -446, -446, -446, -446,
			 -446, -446, -446, -446, -446, -446, -446, -446, -446, -446,
			 -446, -446, -446, -446, -446, -446, -446, -446, -446, -446,
			 -446, -446, -446, -446, -446, -446, -446, -446, -446, -446,
			 -446, -446, -446, -446, -446, -446, -446, -446, -446,    5,
			 -447, -447, -447, -447, -447, -447, -447, -447, -447, -447,
			 -447, -447, -447, -447, -447, -447, -447, -447, -447, -447,

			 -447, -447, -447, -447, -447, -447, -447, -447, -447, -447,
			 -447, -447, -447, -447, -447, -447, -447, -447, -447, -447,
			 -447, -447, -447, -447, -447, -447, -447,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -447, -447, -447,
			 -447, -447, -447, -447,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  488,  100,  100,  100,  100,  100,  100,
			 -447, -447, -447, -447,  100, -447,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  488,  100,  100,  100,  100, yy_Dummy>>,
			1, 1000, 114000)
		end

	yy_nxt_template_116 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  100,  100, -447, -447, -447, -447, -447, -447, -447, -447,
			 -447, -447, -447, -447, -447, -447, -447, -447, -447, -447,
			 -447, -447, -447, -447, -447, -447, -447, -447, -447, -447,
			 -447, -447, -447, -447, -447, -447, -447, -447, -447, -447,
			 -447, -447, -447, -447, -447, -447, -447, -447, -447, -447,
			 -447, -447, -447, -447, -447, -447, -447, -447, -447, -447,
			 -447, -447, -447, -447, -447, -447, -447, -447, -447, -447,
			 -447, -447, -447, -447, -447, -447, -447, -447, -447, -447,
			 -447, -447, -447, -447, -447, -447, -447, -447, -447, -447,
			 -447, -447, -447, -447, -447, -447, -447, -447, -447, -447,

			 -447, -447, -447, -447, -447, -447, -447, -447, -447, -447,
			 -447, -447, -447, -447, -447, -447, -447, -447, -447, -447,
			 -447, -447, -447, -447, -447, -447, -447, -447, -447, -447,
			 -447, -447, -447, -447, -447, -447,    5, -448, -448, -448,
			 -448, -448, -448, -448, -448, -448, -448, -448, -448, -448,
			 -448, -448, -448, -448, -448, -448, -448, -448, -448, -448,
			 -448, -448, -448, -448, -448, -448, -448, -448, -448, -448,
			 -448, -448, -448, -448, -448, -448, -448, -448, -448, -448,
			 -448, -448, -448, -448,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -448, -448, -448, -448, -448, -448,

			 -448,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  489,  100,  100,  100,  100,  100,  100, -448, -448, -448,
			 -448,  100, -448,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  489,  100,  100,  100,  100,  100,  100, -448,
			 -448, -448, -448, -448, -448, -448, -448, -448, -448, -448,
			 -448, -448, -448, -448, -448, -448, -448, -448, -448, -448,
			 -448, -448, -448, -448, -448, -448, -448, -448, -448, -448,
			 -448, -448, -448, -448, -448, -448, -448, -448, -448, -448,

			 -448, -448, -448, -448, -448, -448, -448, -448, -448, -448,
			 -448, -448, -448, -448, -448, -448, -448, -448, -448, -448,
			 -448, -448, -448, -448, -448, -448, -448, -448, -448, -448,
			 -448, -448, -448, -448, -448, -448, -448, -448, -448, -448,
			 -448, -448, -448, -448, -448, -448, -448, -448, -448, -448,
			 -448, -448, -448, -448, -448, -448, -448, -448, -448, -448,
			 -448, -448, -448, -448, -448, -448, -448, -448, -448, -448,
			 -448, -448, -448, -448, -448, -448, -448, -448, -448, -448,
			 -448, -448, -448, -448, -448, -448, -448, -448, -448, -448,
			 -448, -448, -448,    5, -449, -449, -449, -449, -449, -449,

			 -449, -449, -449, -449, -449, -449, -449, -449, -449, -449,
			 -449, -449, -449, -449, -449, -449, -449, -449, -449, -449,
			 -449, -449, -449, -449, -449, -449, -449, -449, -449, -449,
			 -449, -449, -449, -449, -449, -449, -449, -449, -449, -449,
			 -449,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -449, -449, -449, -449, -449, -449, -449,  490,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -449, -449, -449, -449,  100, -449,
			  490,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -449, -449, -449, -449,
			 -449, -449, -449, -449, -449, -449, -449, -449, -449, -449,
			 -449, -449, -449, -449, -449, -449, -449, -449, -449, -449,
			 -449, -449, -449, -449, -449, -449, -449, -449, -449, -449,
			 -449, -449, -449, -449, -449, -449, -449, -449, -449, -449,
			 -449, -449, -449, -449, -449, -449, -449, -449, -449, -449,
			 -449, -449, -449, -449, -449, -449, -449, -449, -449, -449,
			 -449, -449, -449, -449, -449, -449, -449, -449, -449, -449,
			 -449, -449, -449, -449, -449, -449, -449, -449, -449, -449,

			 -449, -449, -449, -449, -449, -449, -449, -449, -449, -449,
			 -449, -449, -449, -449, -449, -449, -449, -449, -449, -449,
			 -449, -449, -449, -449, -449, -449, -449, -449, -449, -449,
			 -449, -449, -449, -449, -449, -449, -449, -449, -449, -449,
			 -449, -449, -449, -449, -449, -449, -449, -449, -449, -449,
			    5, -450, -450, -450, -450, -450, -450, -450, -450, -450,
			 -450, -450, -450, -450, -450, -450, -450, -450, -450, -450,
			 -450, -450, -450, -450, -450, -450, -450, -450, -450, -450,
			 -450, -450, -450, -450, -450, -450, -450, -450, -450, -450,
			 -450, -450, -450, -450, -450, -450, -450, -450,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100, -450, -450,
			 -450, -450, -450, -450, -450,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  491,  100,  100,  100,  100,  100,
			  100, -450, -450, -450, -450,  100, -450,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  491,  100,  100,  100,
			  100,  100,  100, -450, -450, -450, -450, -450, -450, -450,
			 -450, -450, -450, -450, -450, -450, -450, -450, -450, -450,
			 -450, -450, -450, -450, -450, -450, -450, -450, -450, -450,

			 -450, -450, -450, -450, -450, -450, -450, -450, -450, -450,
			 -450, -450, -450, -450, -450, -450, -450, -450, -450, -450,
			 -450, -450, -450, -450, -450, -450, -450, -450, -450, -450,
			 -450, -450, -450, -450, -450, -450, -450, -450, -450, -450,
			 -450, -450, -450, -450, -450, -450, -450, -450, -450, -450,
			 -450, -450, -450, -450, -450, -450, -450, -450, -450, -450,
			 -450, -450, -450, -450, -450, -450, -450, -450, -450, -450,
			 -450, -450, -450, -450, -450, -450, -450, -450, -450, -450,
			 -450, -450, -450, -450, -450, -450, -450, -450, -450, -450,
			 -450, -450, -450, -450, -450, -450, -450, -450, -450, -450,

			 -450, -450, -450, -450, -450, -450, -450,    5, -451, -451,
			 -451, -451, -451, -451, -451, -451, -451, -451, -451, -451,
			 -451, -451, -451, -451, -451, -451, -451, -451, -451, -451,
			 -451, -451, -451, -451, -451, -451, -451, -451, -451, -451,
			 -451, -451, -451, -451, -451, -451, -451, -451, -451, -451,
			 -451, -451, -451, -451, -451,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -451, -451, -451, -451, -451,
			 -451, -451,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  492,  100,  100,  100,  100,  100,  100,  100, -451, -451, yy_Dummy>>,
			1, 1000, 115000)
		end

	yy_nxt_template_117 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -451, -451,  100, -451,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  492,  100,  100,  100,  100,  100,  100,  100,
			 -451, -451, -451, -451, -451, -451, -451, -451, -451, -451,
			 -451, -451, -451, -451, -451, -451, -451, -451, -451, -451,
			 -451, -451, -451, -451, -451, -451, -451, -451, -451, -451,
			 -451, -451, -451, -451, -451, -451, -451, -451, -451, -451,
			 -451, -451, -451, -451, -451, -451, -451, -451, -451, -451,
			 -451, -451, -451, -451, -451, -451, -451, -451, -451, -451,
			 -451, -451, -451, -451, -451, -451, -451, -451, -451, -451,

			 -451, -451, -451, -451, -451, -451, -451, -451, -451, -451,
			 -451, -451, -451, -451, -451, -451, -451, -451, -451, -451,
			 -451, -451, -451, -451, -451, -451, -451, -451, -451, -451,
			 -451, -451, -451, -451, -451, -451, -451, -451, -451, -451,
			 -451, -451, -451, -451, -451, -451, -451, -451, -451, -451,
			 -451, -451, -451, -451, -451, -451, -451, -451, -451, -451,
			 -451, -451, -451, -451,    5, -452, -452, -452, -452, -452,
			 -452, -452, -452, -452, -452, -452, -452, -452, -452, -452,
			 -452, -452, -452, -452, -452, -452, -452, -452, -452, -452,
			 -452, -452, -452, -452, -452, -452, -452, -452, -452, -452,

			 -452, -452, -452, -452, -452, -452, -452, -452, -452, -452,
			 -452, -452,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -452, -452, -452, -452, -452, -452, -452,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -452, -452, -452, -452,  100,
			 -452,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -452, -452, -452,
			 -452, -452, -452, -452, -452, -452, -452, -452, -452, -452,

			 -452, -452, -452, -452, -452, -452, -452, -452, -452, -452,
			 -452, -452, -452, -452, -452, -452, -452, -452, -452, -452,
			 -452, -452, -452, -452, -452, -452, -452, -452, -452, -452,
			 -452, -452, -452, -452, -452, -452, -452, -452, -452, -452,
			 -452, -452, -452, -452, -452, -452, -452, -452, -452, -452,
			 -452, -452, -452, -452, -452, -452, -452, -452, -452, -452,
			 -452, -452, -452, -452, -452, -452, -452, -452, -452, -452,
			 -452, -452, -452, -452, -452, -452, -452, -452, -452, -452,
			 -452, -452, -452, -452, -452, -452, -452, -452, -452, -452,
			 -452, -452, -452, -452, -452, -452, -452, -452, -452, -452,

			 -452, -452, -452, -452, -452, -452, -452, -452, -452, -452,
			 -452, -452, -452, -452, -452, -452, -452, -452, -452, -452,
			 -452,    5, -453, -453, -453, -453, -453, -453, -453, -453,
			 -453, -453, -453, -453, -453, -453, -453, -453, -453, -453,
			 -453, -453, -453, -453, -453, -453, -453, -453, -453, -453,
			 -453, -453, -453, -453, -453, -453, -453, -453, -453, -453,
			 -453, -453, -453, -453, -453, -453, -453, -453, -453,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -453,
			 -453, -453, -453, -453, -453, -453,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  493,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -453, -453, -453, -453,  100, -453,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  493,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -453, -453, -453, -453, -453, -453,
			 -453, -453, -453, -453, -453, -453, -453, -453, -453, -453,
			 -453, -453, -453, -453, -453, -453, -453, -453, -453, -453,
			 -453, -453, -453, -453, -453, -453, -453, -453, -453, -453,
			 -453, -453, -453, -453, -453, -453, -453, -453, -453, -453,
			 -453, -453, -453, -453, -453, -453, -453, -453, -453, -453,

			 -453, -453, -453, -453, -453, -453, -453, -453, -453, -453,
			 -453, -453, -453, -453, -453, -453, -453, -453, -453, -453,
			 -453, -453, -453, -453, -453, -453, -453, -453, -453, -453,
			 -453, -453, -453, -453, -453, -453, -453, -453, -453, -453,
			 -453, -453, -453, -453, -453, -453, -453, -453, -453, -453,
			 -453, -453, -453, -453, -453, -453, -453, -453, -453, -453,
			 -453, -453, -453, -453, -453, -453, -453, -453, -453, -453,
			 -453, -453, -453, -453, -453, -453, -453, -453,    5, -454,
			 -454, -454, -454, -454, -454, -454, -454, -454, -454, -454,
			 -454, -454, -454, -454, -454, -454, -454, -454, -454, -454,

			 -454, -454, -454, -454, -454, -454, -454, -454, -454, -454,
			 -454, -454, -454, -454, -454, -454, -454, -454, -454, -454,
			 -454, -454, -454, -454, -454, -454,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -454, -454, -454, -454,
			 -454, -454, -454,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -454,
			 -454, -454, -454,  100, -454,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100, -454, -454, -454, -454, -454, -454, -454, -454, -454,
			 -454, -454, -454, -454, -454, -454, -454, -454, -454, -454,
			 -454, -454, -454, -454, -454, -454, -454, -454, -454, -454,
			 -454, -454, -454, -454, -454, -454, -454, -454, -454, -454,
			 -454, -454, -454, -454, -454, -454, -454, -454, -454, -454,
			 -454, -454, -454, -454, -454, -454, -454, -454, -454, -454,
			 -454, -454, -454, -454, -454, -454, -454, -454, -454, -454,
			 -454, -454, -454, -454, -454, -454, -454, -454, -454, -454,
			 -454, -454, -454, -454, -454, -454, -454, -454, -454, -454,
			 -454, -454, -454, -454, -454, -454, -454, -454, -454, -454,

			 -454, -454, -454, -454, -454, -454, -454, -454, -454, -454,
			 -454, -454, -454, -454, -454, -454, -454, -454, -454, -454,
			 -454, -454, -454, -454, -454, -454, -454, -454, -454, -454,
			 -454, -454, -454, -454, -454,    5, -455, -455, -455, -455,
			 -455, -455, -455, -455, -455, -455, -455, -455, -455, -455,
			 -455, -455, -455, -455, -455, -455, -455, -455, -455, -455,
			 -455, -455, -455, -455, -455, -455, -455, -455, -455, -455,
			 -455, -455, -455, -455, -455, -455, -455, -455, -455, -455,
			 -455, -455, -455,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -455, -455, -455, -455, -455, -455, -455, yy_Dummy>>,
			1, 1000, 116000)
		end

	yy_nxt_template_118 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  100,  100,  100,  100,  494,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -455, -455, -455, -455,
			  100, -455,  100,  100,  100,  100,  494,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -455, -455,
			 -455, -455, -455, -455, -455, -455, -455, -455, -455, -455,
			 -455, -455, -455, -455, -455, -455, -455, -455, -455, -455,
			 -455, -455, -455, -455, -455, -455, -455, -455, -455, -455,
			 -455, -455, -455, -455, -455, -455, -455, -455, -455, -455,

			 -455, -455, -455, -455, -455, -455, -455, -455, -455, -455,
			 -455, -455, -455, -455, -455, -455, -455, -455, -455, -455,
			 -455, -455, -455, -455, -455, -455, -455, -455, -455, -455,
			 -455, -455, -455, -455, -455, -455, -455, -455, -455, -455,
			 -455, -455, -455, -455, -455, -455, -455, -455, -455, -455,
			 -455, -455, -455, -455, -455, -455, -455, -455, -455, -455,
			 -455, -455, -455, -455, -455, -455, -455, -455, -455, -455,
			 -455, -455, -455, -455, -455, -455, -455, -455, -455, -455,
			 -455, -455, -455, -455, -455, -455, -455, -455, -455, -455,
			 -455, -455,    5, -456, -456, -456, -456, -456, -456, -456,

			 -456, -456, -456, -456, -456, -456, -456, -456, -456, -456,
			 -456, -456, -456, -456, -456, -456, -456, -456, -456, -456,
			 -456, -456, -456, -456, -456, -456, -456, -456, -456, -456,
			 -456, -456, -456, -456, -456, -456, -456, -456, -456, -456,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -456, -456, -456, -456, -456, -456, -456,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -456, -456, -456, -456,  100, -456,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -456, -456, -456, -456, -456,
			 -456, -456, -456, -456, -456, -456, -456, -456, -456, -456,
			 -456, -456, -456, -456, -456, -456, -456, -456, -456, -456,
			 -456, -456, -456, -456, -456, -456, -456, -456, -456, -456,
			 -456, -456, -456, -456, -456, -456, -456, -456, -456, -456,
			 -456, -456, -456, -456, -456, -456, -456, -456, -456, -456,
			 -456, -456, -456, -456, -456, -456, -456, -456, -456, -456,
			 -456, -456, -456, -456, -456, -456, -456, -456, -456, -456,
			 -456, -456, -456, -456, -456, -456, -456, -456, -456, -456,

			 -456, -456, -456, -456, -456, -456, -456, -456, -456, -456,
			 -456, -456, -456, -456, -456, -456, -456, -456, -456, -456,
			 -456, -456, -456, -456, -456, -456, -456, -456, -456, -456,
			 -456, -456, -456, -456, -456, -456, -456, -456, -456, -456,
			 -456, -456, -456, -456, -456, -456, -456, -456, -456,    5,
			 -457, -457, -457, -457, -457, -457, -457, -457, -457, -457,
			 -457, -457, -457, -457, -457, -457, -457, -457, -457, -457,
			 -457, -457, -457, -457, -457, -457, -457, -457, -457, -457,
			 -457, -457, -457, -457, -457, -457, -457, -457, -457, -457,
			 -457, -457, -457, -457, -457, -457, -457,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100, -457, -457, -457,
			 -457, -457, -457, -457,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -457, -457, -457, -457,  100, -457,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -457, -457, -457, -457, -457, -457, -457, -457,
			 -457, -457, -457, -457, -457, -457, -457, -457, -457, -457,
			 -457, -457, -457, -457, -457, -457, -457, -457, -457, -457,

			 -457, -457, -457, -457, -457, -457, -457, -457, -457, -457,
			 -457, -457, -457, -457, -457, -457, -457, -457, -457, -457,
			 -457, -457, -457, -457, -457, -457, -457, -457, -457, -457,
			 -457, -457, -457, -457, -457, -457, -457, -457, -457, -457,
			 -457, -457, -457, -457, -457, -457, -457, -457, -457, -457,
			 -457, -457, -457, -457, -457, -457, -457, -457, -457, -457,
			 -457, -457, -457, -457, -457, -457, -457, -457, -457, -457,
			 -457, -457, -457, -457, -457, -457, -457, -457, -457, -457,
			 -457, -457, -457, -457, -457, -457, -457, -457, -457, -457,
			 -457, -457, -457, -457, -457, -457, -457, -457, -457, -457,

			 -457, -457, -457, -457, -457, -457,    5, -458, -458, -458,
			 -458, -458, -458, -458, -458, -458, -458, -458, -458, -458,
			 -458, -458, -458, -458, -458, -458, -458, -458, -458, -458,
			 -458, -458, -458, -458, -458, -458, -458, -458, -458, -458,
			 -458, -458, -458, -458, -458, -458, -458, -458, -458, -458,
			 -458, -458, -458, -458,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -458, -458, -458, -458, -458, -458,
			 -458,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -458, -458, -458,

			 -458,  100, -458,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -458,
			 -458, -458, -458, -458, -458, -458, -458, -458, -458, -458,
			 -458, -458, -458, -458, -458, -458, -458, -458, -458, -458,
			 -458, -458, -458, -458, -458, -458, -458, -458, -458, -458,
			 -458, -458, -458, -458, -458, -458, -458, -458, -458, -458,
			 -458, -458, -458, -458, -458, -458, -458, -458, -458, -458,
			 -458, -458, -458, -458, -458, -458, -458, -458, -458, -458,
			 -458, -458, -458, -458, -458, -458, -458, -458, -458, -458,

			 -458, -458, -458, -458, -458, -458, -458, -458, -458, -458,
			 -458, -458, -458, -458, -458, -458, -458, -458, -458, -458,
			 -458, -458, -458, -458, -458, -458, -458, -458, -458, -458,
			 -458, -458, -458, -458, -458, -458, -458, -458, -458, -458,
			 -458, -458, -458, -458, -458, -458, -458, -458, -458, -458,
			 -458, -458, -458, -458, -458, -458, -458, -458, -458, -458,
			 -458, -458, -458,    5, -459, -459, -459, -459, -459, -459,
			 -459, -459, -459, -459, -459, -459, -459, -459, -459, -459,
			 -459, -459, -459, -459, -459, -459, -459, -459, -459, -459,
			 -459, -459, -459, -459, -459, -459, -459, -459, -459, -459, yy_Dummy>>,
			1, 1000, 117000)
		end

	yy_nxt_template_119 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -459, -459, -459, -459, -459, -459, -459, -459, -459, -459,
			 -459,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -459, -459, -459, -459, -459, -459, -459,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  495,  100,  100,
			  100,  100,  100,  100, -459, -459, -459, -459,  100, -459,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  495,
			  100,  100,  100,  100,  100,  100, -459, -459, -459, -459,
			 -459, -459, -459, -459, -459, -459, -459, -459, -459, -459,

			 -459, -459, -459, -459, -459, -459, -459, -459, -459, -459,
			 -459, -459, -459, -459, -459, -459, -459, -459, -459, -459,
			 -459, -459, -459, -459, -459, -459, -459, -459, -459, -459,
			 -459, -459, -459, -459, -459, -459, -459, -459, -459, -459,
			 -459, -459, -459, -459, -459, -459, -459, -459, -459, -459,
			 -459, -459, -459, -459, -459, -459, -459, -459, -459, -459,
			 -459, -459, -459, -459, -459, -459, -459, -459, -459, -459,
			 -459, -459, -459, -459, -459, -459, -459, -459, -459, -459,
			 -459, -459, -459, -459, -459, -459, -459, -459, -459, -459,
			 -459, -459, -459, -459, -459, -459, -459, -459, -459, -459,

			 -459, -459, -459, -459, -459, -459, -459, -459, -459, -459,
			 -459, -459, -459, -459, -459, -459, -459, -459, -459, -459,
			    5, -460, -460, -460, -460, -460, -460, -460, -460, -460,
			 -460, -460, -460, -460, -460, -460, -460, -460, -460, -460,
			 -460, -460, -460, -460, -460, -460, -460, -460, -460, -460,
			 -460, -460, -460, -460, -460, -460, -460, -460, -460, -460,
			 -460, -460, -460, -460, -460, -460, -460, -460,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -460, -460,
			 -460, -460, -460, -460, -460,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  496,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -460, -460, -460, -460,  100, -460,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  496,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -460, -460, -460, -460, -460, -460, -460,
			 -460, -460, -460, -460, -460, -460, -460, -460, -460, -460,
			 -460, -460, -460, -460, -460, -460, -460, -460, -460, -460,
			 -460, -460, -460, -460, -460, -460, -460, -460, -460, -460,
			 -460, -460, -460, -460, -460, -460, -460, -460, -460, -460,
			 -460, -460, -460, -460, -460, -460, -460, -460, -460, -460,

			 -460, -460, -460, -460, -460, -460, -460, -460, -460, -460,
			 -460, -460, -460, -460, -460, -460, -460, -460, -460, -460,
			 -460, -460, -460, -460, -460, -460, -460, -460, -460, -460,
			 -460, -460, -460, -460, -460, -460, -460, -460, -460, -460,
			 -460, -460, -460, -460, -460, -460, -460, -460, -460, -460,
			 -460, -460, -460, -460, -460, -460, -460, -460, -460, -460,
			 -460, -460, -460, -460, -460, -460, -460, -460, -460, -460,
			 -460, -460, -460, -460, -460, -460, -460,    5, -461, -461,
			 -461, -461, -461, -461, -461, -461, -461, -461, -461, -461,
			 -461, -461, -461, -461, -461, -461, -461, -461, -461, -461,

			 -461, -461, -461, -461, -461, -461, -461, -461, -461, -461,
			 -461, -461, -461, -461, -461, -461, -461, -461, -461, -461,
			 -461, -461, -461, -461, -461,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -461, -461, -461, -461, -461,
			 -461, -461,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -461, -461,
			 -461, -461,  100, -461,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			 -461, -461, -461, -461, -461, -461, -461, -461, -461, -461,
			 -461, -461, -461, -461, -461, -461, -461, -461, -461, -461,
			 -461, -461, -461, -461, -461, -461, -461, -461, -461, -461,
			 -461, -461, -461, -461, -461, -461, -461, -461, -461, -461,
			 -461, -461, -461, -461, -461, -461, -461, -461, -461, -461,
			 -461, -461, -461, -461, -461, -461, -461, -461, -461, -461,
			 -461, -461, -461, -461, -461, -461, -461, -461, -461, -461,
			 -461, -461, -461, -461, -461, -461, -461, -461, -461, -461,
			 -461, -461, -461, -461, -461, -461, -461, -461, -461, -461,
			 -461, -461, -461, -461, -461, -461, -461, -461, -461, -461,

			 -461, -461, -461, -461, -461, -461, -461, -461, -461, -461,
			 -461, -461, -461, -461, -461, -461, -461, -461, -461, -461,
			 -461, -461, -461, -461, -461, -461, -461, -461, -461, -461,
			 -461, -461, -461, -461,    5, -462, -462, -462, -462, -462,
			 -462, -462, -462, -462, -462, -462, -462, -462, -462, -462,
			 -462, -462, -462, -462, -462, -462, -462, -462, -462, -462,
			 -462, -462, -462, -462, -462, -462, -462, -462, -462, -462,
			 -462, -462, -462, -462, -462, -462, -462, -462, -462, -462,
			 -462, -462,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -462, -462, -462, -462, -462, -462, -462,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  497,  100,
			  100,  100,  100,  100,  100, -462, -462, -462, -462,  100,
			 -462,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  497,  100,  100,  100,  100,  100,  100, -462, -462, -462,
			 -462, -462, -462, -462, -462, -462, -462, -462, -462, -462,
			 -462, -462, -462, -462, -462, -462, -462, -462, -462, -462,
			 -462, -462, -462, -462, -462, -462, -462, -462, -462, -462,
			 -462, -462, -462, -462, -462, -462, -462, -462, -462, -462,

			 -462, -462, -462, -462, -462, -462, -462, -462, -462, -462,
			 -462, -462, -462, -462, -462, -462, -462, -462, -462, -462,
			 -462, -462, -462, -462, -462, -462, -462, -462, -462, -462,
			 -462, -462, -462, -462, -462, -462, -462, -462, -462, -462,
			 -462, -462, -462, -462, -462, -462, -462, -462, -462, -462,
			 -462, -462, -462, -462, -462, -462, -462, -462, -462, -462,
			 -462, -462, -462, -462, -462, -462, -462, -462, -462, -462,
			 -462, -462, -462, -462, -462, -462, -462, -462, -462, -462,
			 -462, -462, -462, -462, -462, -462, -462, -462, -462, -462,
			 -462,    5,   63,   63,   63,   63,   63,   63,   63,   63, yy_Dummy>>,
			1, 1000, 118000)
		end

	yy_nxt_template_120 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			   63, -463,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   64,   63,   63, -463,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			  498,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,  498,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,    5,   63,
			   63,   63,   63,   63,   63,   63,   63,   63, -464,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   64,   63,   63, -464,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,  499,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,  499,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,    5,   63,   63,   63,   63,
			   63,   63,   63,   63,   63, -465,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   64,
			   63,   63, -465,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,  500,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,  500,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,    5, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,

			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			  467,  467,  467,  467,  467,  467,  467,  467,  467,  467,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,

			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466, yy_Dummy>>,
			1, 1000, 119000)
		end

	yy_nxt_template_121 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -466, -466, -466, -466, -466, -466, -466, -466, -466, -466,
			 -466, -466, -466, -466, -466, -466, -466, -466, -466,    5,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467,  467,  467,  467,
			  467,  467,  467,  467,  467,  467,  467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,

			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,

			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467, -467, -467, -467, -467,
			 -467, -467, -467, -467, -467, -467,    5, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,

			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468,  501,  501,  501,  501,  501,  501,
			  501,  501,  501,  501, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,

			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,

			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468, -468, -468, -468, -468, -468, -468, -468,
			 -468, -468, -468,    5, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469,  502, -469,  502, -469,
			 -469,  503,  503,  503,  503,  503,  503,  503,  503,  503,
			  503, -469, -469, -469, -469, -469, -469, -469, -469, -469,

			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,

			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			 -469, -469, -469, -469, -469, -469, -469, -469, -469, -469,
			    5, -470, -470, -470, -470, -470, -470, -470, -470, -470,

			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470,  504, -470,  504, -470, -470,  505,  505,
			  505,  505,  505,  505,  505,  505,  505,  505, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,

			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470, yy_Dummy>>,
			1, 1000, 120000)
		end

	yy_nxt_template_122 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470, -470, -470, -470,
			 -470, -470, -470, -470, -470, -470, -470,    5, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471,  505,  505,  505,  505,  505,

			  505,  505,  505,  505,  505, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471,  429, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,

			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,
			 -471, -471, -471, -471, -471, -471, -471, -471, -471, -471,

			 -471, -471, -471, -471,    5, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472,  506,  506,  506,  506,  506,  506,  506,  506,
			  506,  506, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,

			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,

			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472, -472, -472, -472, -472, -472, -472, -472, -472, -472,
			 -472,    5, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,

			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			  507, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473,  310, -473, -473, -473,
			 -473, -473,  507, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,

			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,

			 -473, -473, -473, -473, -473, -473, -473, -473, -473, -473,
			 -473, -473, -473, -473, -473, -473, -473, -473,    5, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474,  474,  474,  474,  474,
			  474,  474,  474,  474,  474,  474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,

			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474, yy_Dummy>>,
			1, 1000, 121000)
		end

	yy_nxt_template_123 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474, -474, -474, -474, -474, -474,
			 -474, -474, -474, -474, -474,    5, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,

			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475,  508,  508,  508,  508,  508,  508,  508,
			  508,  508,  508, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,

			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,

			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475, -475, -475, -475, -475, -475, -475, -475, -475,
			 -475, -475,    5, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			  474,  474,  474,  474,  474,  474,  474,  474,  474,  474,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,

			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,

			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476, -476,
			 -476, -476, -476, -476, -476, -476, -476, -476, -476,    5,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,

			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,

			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,

			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477, -477, -477, -477, -477,
			 -477, -477, -477, -477, -477, -477,    5, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478,  509,  509,  509,  509,  509,  509,

			  509,  509,  509,  509, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478,  507, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478,  310, -478, -478, -478, -478, -478,  507, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478, yy_Dummy>>,
			1, 1000, 122000)
		end

	yy_nxt_template_124 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,
			 -478, -478, -478, -478, -478, -478, -478, -478, -478, -478,

			 -478, -478, -478,    5, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479,  510, -479,  510, -479,
			 -479,  511,  511,  511,  511,  511,  511,  511,  511,  511,
			  511, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,

			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,

			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			 -479, -479, -479, -479, -479, -479, -479, -479, -479, -479,
			    5, -480, -480, -480, -480, -480, -480, -480, -480, -480,
			 -480, -480, -480, -480, -480, -480, -480, -480, -480, -480,
			 -480, -480, -480, -480, -480, -480, -480, -480, -480, -480,
			 -480, -480, -480, -480, -480, -480, -480, -480, -480, -480,

			 -480, -480, -480, -480, -480, -480, -480, -480,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -480, -480,
			 -480, -480, -480, -480, -480,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  512,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -480, -480, -480, -480,  100, -480,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  512,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -480, -480, -480, -480, -480, -480, -480,
			 -480, -480, -480, -480, -480, -480, -480, -480, -480, -480,

			 -480, -480, -480, -480, -480, -480, -480, -480, -480, -480,
			 -480, -480, -480, -480, -480, -480, -480, -480, -480, -480,
			 -480, -480, -480, -480, -480, -480, -480, -480, -480, -480,
			 -480, -480, -480, -480, -480, -480, -480, -480, -480, -480,
			 -480, -480, -480, -480, -480, -480, -480, -480, -480, -480,
			 -480, -480, -480, -480, -480, -480, -480, -480, -480, -480,
			 -480, -480, -480, -480, -480, -480, -480, -480, -480, -480,
			 -480, -480, -480, -480, -480, -480, -480, -480, -480, -480,
			 -480, -480, -480, -480, -480, -480, -480, -480, -480, -480,
			 -480, -480, -480, -480, -480, -480, -480, -480, -480, -480,

			 -480, -480, -480, -480, -480, -480, -480, -480, -480, -480,
			 -480, -480, -480, -480, -480, -480, -480,    5, -481, -481,
			 -481, -481, -481, -481, -481, -481, -481, -481, -481, -481,
			 -481, -481, -481, -481, -481, -481, -481, -481, -481, -481,
			 -481, -481, -481, -481, -481, -481, -481, -481, -481, -481,
			 -481, -481, -481, -481, -481, -481, -481, -481, -481, -481,
			 -481, -481, -481, -481, -481,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -481, -481, -481, -481, -481,
			 -481, -481,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100, -481, -481,
			 -481, -481,  100, -481,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -481, -481, -481, -481, -481, -481, -481, -481, -481, -481,
			 -481, -481, -481, -481, -481, -481, -481, -481, -481, -481,
			 -481, -481, -481, -481, -481, -481, -481, -481, -481, -481,
			 -481, -481, -481, -481, -481, -481, -481, -481, -481, -481,
			 -481, -481, -481, -481, -481, -481, -481, -481, -481, -481,
			 -481, -481, -481, -481, -481, -481, -481, -481, -481, -481,

			 -481, -481, -481, -481, -481, -481, -481, -481, -481, -481,
			 -481, -481, -481, -481, -481, -481, -481, -481, -481, -481,
			 -481, -481, -481, -481, -481, -481, -481, -481, -481, -481,
			 -481, -481, -481, -481, -481, -481, -481, -481, -481, -481,
			 -481, -481, -481, -481, -481, -481, -481, -481, -481, -481,
			 -481, -481, -481, -481, -481, -481, -481, -481, -481, -481,
			 -481, -481, -481, -481, -481, -481, -481, -481, -481, -481,
			 -481, -481, -481, -481,    5, -482, -482, -482, -482, -482,
			 -482, -482, -482, -482, -482, -482, -482, -482, -482, -482,
			 -482, -482, -482, -482, -482, -482, -482, -482, -482, -482,

			 -482, -482, -482, -482, -482, -482, -482, -482, -482, -482,
			 -482, -482, -482, -482, -482, -482, -482, -482, -482, -482,
			 -482, -482,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -482, -482, -482, -482, -482, -482, -482,  100,
			  100,  100,  513,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -482, -482, -482, -482,  100,
			 -482,  100,  100,  100,  513,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -482, -482, -482, yy_Dummy>>,
			1, 1000, 123000)
		end

	yy_nxt_template_125 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -482, -482, -482, -482, -482, -482, -482, -482, -482, -482,
			 -482, -482, -482, -482, -482, -482, -482, -482, -482, -482,
			 -482, -482, -482, -482, -482, -482, -482, -482, -482, -482,
			 -482, -482, -482, -482, -482, -482, -482, -482, -482, -482,
			 -482, -482, -482, -482, -482, -482, -482, -482, -482, -482,
			 -482, -482, -482, -482, -482, -482, -482, -482, -482, -482,
			 -482, -482, -482, -482, -482, -482, -482, -482, -482, -482,
			 -482, -482, -482, -482, -482, -482, -482, -482, -482, -482,
			 -482, -482, -482, -482, -482, -482, -482, -482, -482, -482,
			 -482, -482, -482, -482, -482, -482, -482, -482, -482, -482,

			 -482, -482, -482, -482, -482, -482, -482, -482, -482, -482,
			 -482, -482, -482, -482, -482, -482, -482, -482, -482, -482,
			 -482, -482, -482, -482, -482, -482, -482, -482, -482, -482,
			 -482,    5, -483, -483, -483, -483, -483, -483, -483, -483,
			 -483, -483, -483, -483, -483, -483, -483, -483, -483, -483,
			 -483, -483, -483, -483, -483, -483, -483, -483, -483, -483,
			 -483, -483, -483, -483, -483, -483, -483, -483, -483, -483,
			 -483, -483, -483, -483, -483, -483, -483, -483, -483,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -483,
			 -483, -483, -483, -483, -483, -483,  100,  100,  100,  514,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -483, -483, -483, -483,  100, -483,  100,  100,
			  100,  514,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -483, -483, -483, -483, -483, -483,
			 -483, -483, -483, -483, -483, -483, -483, -483, -483, -483,
			 -483, -483, -483, -483, -483, -483, -483, -483, -483, -483,
			 -483, -483, -483, -483, -483, -483, -483, -483, -483, -483,
			 -483, -483, -483, -483, -483, -483, -483, -483, -483, -483,

			 -483, -483, -483, -483, -483, -483, -483, -483, -483, -483,
			 -483, -483, -483, -483, -483, -483, -483, -483, -483, -483,
			 -483, -483, -483, -483, -483, -483, -483, -483, -483, -483,
			 -483, -483, -483, -483, -483, -483, -483, -483, -483, -483,
			 -483, -483, -483, -483, -483, -483, -483, -483, -483, -483,
			 -483, -483, -483, -483, -483, -483, -483, -483, -483, -483,
			 -483, -483, -483, -483, -483, -483, -483, -483, -483, -483,
			 -483, -483, -483, -483, -483, -483, -483, -483, -483, -483,
			 -483, -483, -483, -483, -483, -483, -483, -483,    5, -484,
			 -484, -484, -484, -484, -484, -484, -484, -484, -484, -484,

			 -484, -484, -484, -484, -484, -484, -484, -484, -484, -484,
			 -484, -484, -484, -484, -484, -484, -484, -484, -484, -484,
			 -484, -484, -484, -484, -484, -484, -484, -484, -484, -484,
			 -484, -484, -484, -484, -484, -484,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -484, -484, -484, -484,
			 -484, -484, -484,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  515,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -484,
			 -484, -484, -484,  100, -484,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  515,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -484, -484, -484, -484, -484, -484, -484, -484, -484,
			 -484, -484, -484, -484, -484, -484, -484, -484, -484, -484,
			 -484, -484, -484, -484, -484, -484, -484, -484, -484, -484,
			 -484, -484, -484, -484, -484, -484, -484, -484, -484, -484,
			 -484, -484, -484, -484, -484, -484, -484, -484, -484, -484,
			 -484, -484, -484, -484, -484, -484, -484, -484, -484, -484,
			 -484, -484, -484, -484, -484, -484, -484, -484, -484, -484,
			 -484, -484, -484, -484, -484, -484, -484, -484, -484, -484,
			 -484, -484, -484, -484, -484, -484, -484, -484, -484, -484,

			 -484, -484, -484, -484, -484, -484, -484, -484, -484, -484,
			 -484, -484, -484, -484, -484, -484, -484, -484, -484, -484,
			 -484, -484, -484, -484, -484, -484, -484, -484, -484, -484,
			 -484, -484, -484, -484, -484, -484, -484, -484, -484, -484,
			 -484, -484, -484, -484, -484,    5, -485, -485, -485, -485,
			 -485, -485, -485, -485, -485, -485, -485, -485, -485, -485,
			 -485, -485, -485, -485, -485, -485, -485, -485, -485, -485,
			 -485, -485, -485, -485, -485, -485, -485, -485, -485, -485,
			 -485, -485, -485, -485, -485, -485, -485, -485, -485, -485,
			 -485, -485, -485,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100, -485, -485, -485, -485, -485, -485, -485,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -485, -485, -485, -485,
			  100, -485,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -485, -485,
			 -485, -485, -485, -485, -485, -485, -485, -485, -485, -485,
			 -485, -485, -485, -485, -485, -485, -485, -485, -485, -485,
			 -485, -485, -485, -485, -485, -485, -485, -485, -485, -485,

			 -485, -485, -485, -485, -485, -485, -485, -485, -485, -485,
			 -485, -485, -485, -485, -485, -485, -485, -485, -485, -485,
			 -485, -485, -485, -485, -485, -485, -485, -485, -485, -485,
			 -485, -485, -485, -485, -485, -485, -485, -485, -485, -485,
			 -485, -485, -485, -485, -485, -485, -485, -485, -485, -485,
			 -485, -485, -485, -485, -485, -485, -485, -485, -485, -485,
			 -485, -485, -485, -485, -485, -485, -485, -485, -485, -485,
			 -485, -485, -485, -485, -485, -485, -485, -485, -485, -485,
			 -485, -485, -485, -485, -485, -485, -485, -485, -485, -485,
			 -485, -485, -485, -485, -485, -485, -485, -485, -485, -485,

			 -485, -485,    5, -486, -486, -486, -486, -486, -486, -486,
			 -486, -486, -486, -486, -486, -486, -486, -486, -486, -486,
			 -486, -486, -486, -486, -486, -486, -486, -486, -486, -486,
			 -486, -486, -486, -486, -486, -486, -486, -486, -486, -486,
			 -486, -486, -486, -486, -486, -486, -486, -486, -486, -486,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -486, -486, -486, -486, -486, -486, -486,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -486, -486, -486, -486,  100, -486,  100, yy_Dummy>>,
			1, 1000, 124000)
		end

	yy_nxt_template_126 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -486, -486, -486, -486, -486,
			 -486, -486, -486, -486, -486, -486, -486, -486, -486, -486,
			 -486, -486, -486, -486, -486, -486, -486, -486, -486, -486,
			 -486, -486, -486, -486, -486, -486, -486, -486, -486, -486,
			 -486, -486, -486, -486, -486, -486, -486, -486, -486, -486,
			 -486, -486, -486, -486, -486, -486, -486, -486, -486, -486,
			 -486, -486, -486, -486, -486, -486, -486, -486, -486, -486,
			 -486, -486, -486, -486, -486, -486, -486, -486, -486, -486,

			 -486, -486, -486, -486, -486, -486, -486, -486, -486, -486,
			 -486, -486, -486, -486, -486, -486, -486, -486, -486, -486,
			 -486, -486, -486, -486, -486, -486, -486, -486, -486, -486,
			 -486, -486, -486, -486, -486, -486, -486, -486, -486, -486,
			 -486, -486, -486, -486, -486, -486, -486, -486, -486, -486,
			 -486, -486, -486, -486, -486, -486, -486, -486, -486,    5,
			 -487, -487, -487, -487, -487, -487, -487, -487, -487, -487,
			 -487, -487, -487, -487, -487, -487, -487, -487, -487, -487,
			 -487, -487, -487, -487, -487, -487, -487, -487, -487, -487,
			 -487, -487, -487, -487, -487, -487, -487, -487, -487, -487,

			 -487, -487, -487, -487, -487, -487, -487,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -487, -487, -487,
			 -487, -487, -487, -487,  100,  100,  100,  100,  100,  100,
			  516,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -487, -487, -487, -487,  100, -487,  100,  100,  100,  100,
			  100,  100,  516,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -487, -487, -487, -487, -487, -487, -487, -487,
			 -487, -487, -487, -487, -487, -487, -487, -487, -487, -487,

			 -487, -487, -487, -487, -487, -487, -487, -487, -487, -487,
			 -487, -487, -487, -487, -487, -487, -487, -487, -487, -487,
			 -487, -487, -487, -487, -487, -487, -487, -487, -487, -487,
			 -487, -487, -487, -487, -487, -487, -487, -487, -487, -487,
			 -487, -487, -487, -487, -487, -487, -487, -487, -487, -487,
			 -487, -487, -487, -487, -487, -487, -487, -487, -487, -487,
			 -487, -487, -487, -487, -487, -487, -487, -487, -487, -487,
			 -487, -487, -487, -487, -487, -487, -487, -487, -487, -487,
			 -487, -487, -487, -487, -487, -487, -487, -487, -487, -487,
			 -487, -487, -487, -487, -487, -487, -487, -487, -487, -487,

			 -487, -487, -487, -487, -487, -487, -487, -487, -487, -487,
			 -487, -487, -487, -487, -487, -487,    5, -488, -488, -488,
			 -488, -488, -488, -488, -488, -488, -488, -488, -488, -488,
			 -488, -488, -488, -488, -488, -488, -488, -488, -488, -488,
			 -488, -488, -488, -488, -488, -488, -488, -488, -488, -488,
			 -488, -488, -488, -488, -488, -488, -488, -488, -488, -488,
			 -488, -488, -488, -488,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -488, -488, -488, -488, -488, -488,
			 -488,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100, -488, -488, -488,
			 -488,  100, -488,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -488,
			 -488, -488, -488, -488, -488, -488, -488, -488, -488, -488,
			 -488, -488, -488, -488, -488, -488, -488, -488, -488, -488,
			 -488, -488, -488, -488, -488, -488, -488, -488, -488, -488,
			 -488, -488, -488, -488, -488, -488, -488, -488, -488, -488,
			 -488, -488, -488, -488, -488, -488, -488, -488, -488, -488,
			 -488, -488, -488, -488, -488, -488, -488, -488, -488, -488,

			 -488, -488, -488, -488, -488, -488, -488, -488, -488, -488,
			 -488, -488, -488, -488, -488, -488, -488, -488, -488, -488,
			 -488, -488, -488, -488, -488, -488, -488, -488, -488, -488,
			 -488, -488, -488, -488, -488, -488, -488, -488, -488, -488,
			 -488, -488, -488, -488, -488, -488, -488, -488, -488, -488,
			 -488, -488, -488, -488, -488, -488, -488, -488, -488, -488,
			 -488, -488, -488, -488, -488, -488, -488, -488, -488, -488,
			 -488, -488, -488,    5, -489, -489, -489, -489, -489, -489,
			 -489, -489, -489, -489, -489, -489, -489, -489, -489, -489,
			 -489, -489, -489, -489, -489, -489, -489, -489, -489, -489,

			 -489, -489, -489, -489, -489, -489, -489, -489, -489, -489,
			 -489, -489, -489, -489, -489, -489, -489, -489, -489, -489,
			 -489,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -489, -489, -489, -489, -489, -489, -489,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -489, -489, -489, -489,  100, -489,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -489, -489, -489, -489,

			 -489, -489, -489, -489, -489, -489, -489, -489, -489, -489,
			 -489, -489, -489, -489, -489, -489, -489, -489, -489, -489,
			 -489, -489, -489, -489, -489, -489, -489, -489, -489, -489,
			 -489, -489, -489, -489, -489, -489, -489, -489, -489, -489,
			 -489, -489, -489, -489, -489, -489, -489, -489, -489, -489,
			 -489, -489, -489, -489, -489, -489, -489, -489, -489, -489,
			 -489, -489, -489, -489, -489, -489, -489, -489, -489, -489,
			 -489, -489, -489, -489, -489, -489, -489, -489, -489, -489,
			 -489, -489, -489, -489, -489, -489, -489, -489, -489, -489,
			 -489, -489, -489, -489, -489, -489, -489, -489, -489, -489,

			 -489, -489, -489, -489, -489, -489, -489, -489, -489, -489,
			 -489, -489, -489, -489, -489, -489, -489, -489, -489, -489,
			 -489, -489, -489, -489, -489, -489, -489, -489, -489, -489,
			    5, -490, -490, -490, -490, -490, -490, -490, -490, -490,
			 -490, -490, -490, -490, -490, -490, -490, -490, -490, -490,
			 -490, -490, -490, -490, -490, -490, -490, -490, -490, -490,
			 -490, -490, -490, -490, -490, -490, -490, -490, -490, -490,
			 -490, -490, -490, -490, -490, -490, -490, -490,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -490, -490,
			 -490, -490, -490, -490, -490,  100,  100,  100,  100,  100, yy_Dummy>>,
			1, 1000, 125000)
		end

	yy_nxt_template_127 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  100,  100,  100,  100,  100,  100,  100,  100,  517,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -490, -490, -490, -490,  100, -490,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  517,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -490, -490, -490, -490, -490, -490, -490,
			 -490, -490, -490, -490, -490, -490, -490, -490, -490, -490,
			 -490, -490, -490, -490, -490, -490, -490, -490, -490, -490,
			 -490, -490, -490, -490, -490, -490, -490, -490, -490, -490,
			 -490, -490, -490, -490, -490, -490, -490, -490, -490, -490,

			 -490, -490, -490, -490, -490, -490, -490, -490, -490, -490,
			 -490, -490, -490, -490, -490, -490, -490, -490, -490, -490,
			 -490, -490, -490, -490, -490, -490, -490, -490, -490, -490,
			 -490, -490, -490, -490, -490, -490, -490, -490, -490, -490,
			 -490, -490, -490, -490, -490, -490, -490, -490, -490, -490,
			 -490, -490, -490, -490, -490, -490, -490, -490, -490, -490,
			 -490, -490, -490, -490, -490, -490, -490, -490, -490, -490,
			 -490, -490, -490, -490, -490, -490, -490, -490, -490, -490,
			 -490, -490, -490, -490, -490, -490, -490,    5, -491, -491,
			 -491, -491, -491, -491, -491, -491, -491, -491, -491, -491,

			 -491, -491, -491, -491, -491, -491, -491, -491, -491, -491,
			 -491, -491, -491, -491, -491, -491, -491, -491, -491, -491,
			 -491, -491, -491, -491, -491, -491, -491, -491, -491, -491,
			 -491, -491, -491, -491, -491,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -491, -491, -491, -491, -491,
			 -491, -491,  100,  100,  100,  100,  518,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -491, -491,
			 -491, -491,  100, -491,  100,  100,  100,  100,  518,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -491, -491, -491, -491, -491, -491, -491, -491, -491, -491,
			 -491, -491, -491, -491, -491, -491, -491, -491, -491, -491,
			 -491, -491, -491, -491, -491, -491, -491, -491, -491, -491,
			 -491, -491, -491, -491, -491, -491, -491, -491, -491, -491,
			 -491, -491, -491, -491, -491, -491, -491, -491, -491, -491,
			 -491, -491, -491, -491, -491, -491, -491, -491, -491, -491,
			 -491, -491, -491, -491, -491, -491, -491, -491, -491, -491,
			 -491, -491, -491, -491, -491, -491, -491, -491, -491, -491,
			 -491, -491, -491, -491, -491, -491, -491, -491, -491, -491,

			 -491, -491, -491, -491, -491, -491, -491, -491, -491, -491,
			 -491, -491, -491, -491, -491, -491, -491, -491, -491, -491,
			 -491, -491, -491, -491, -491, -491, -491, -491, -491, -491,
			 -491, -491, -491, -491, -491, -491, -491, -491, -491, -491,
			 -491, -491, -491, -491,    5, -492, -492, -492, -492, -492,
			 -492, -492, -492, -492, -492, -492, -492, -492, -492, -492,
			 -492, -492, -492, -492, -492, -492, -492, -492, -492, -492,
			 -492, -492, -492, -492, -492, -492, -492, -492, -492, -492,
			 -492, -492, -492, -492, -492, -492, -492, -492, -492, -492,
			 -492, -492,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100, -492, -492, -492, -492, -492, -492, -492,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  519,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -492, -492, -492, -492,  100,
			 -492,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  519,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -492, -492, -492,
			 -492, -492, -492, -492, -492, -492, -492, -492, -492, -492,
			 -492, -492, -492, -492, -492, -492, -492, -492, -492, -492,
			 -492, -492, -492, -492, -492, -492, -492, -492, -492, -492,

			 -492, -492, -492, -492, -492, -492, -492, -492, -492, -492,
			 -492, -492, -492, -492, -492, -492, -492, -492, -492, -492,
			 -492, -492, -492, -492, -492, -492, -492, -492, -492, -492,
			 -492, -492, -492, -492, -492, -492, -492, -492, -492, -492,
			 -492, -492, -492, -492, -492, -492, -492, -492, -492, -492,
			 -492, -492, -492, -492, -492, -492, -492, -492, -492, -492,
			 -492, -492, -492, -492, -492, -492, -492, -492, -492, -492,
			 -492, -492, -492, -492, -492, -492, -492, -492, -492, -492,
			 -492, -492, -492, -492, -492, -492, -492, -492, -492, -492,
			 -492, -492, -492, -492, -492, -492, -492, -492, -492, -492,

			 -492,    5, -493, -493, -493, -493, -493, -493, -493, -493,
			 -493, -493, -493, -493, -493, -493, -493, -493, -493, -493,
			 -493, -493, -493, -493, -493, -493, -493, -493, -493, -493,
			 -493, -493, -493, -493, -493, -493, -493, -493, -493, -493,
			 -493, -493, -493, -493, -493, -493, -493, -493, -493,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -493,
			 -493, -493, -493, -493, -493, -493,  100,  100,  100,  100,
			  520,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -493, -493, -493, -493,  100, -493,  100,  100,

			  100,  100,  520,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -493, -493, -493, -493, -493, -493,
			 -493, -493, -493, -493, -493, -493, -493, -493, -493, -493,
			 -493, -493, -493, -493, -493, -493, -493, -493, -493, -493,
			 -493, -493, -493, -493, -493, -493, -493, -493, -493, -493,
			 -493, -493, -493, -493, -493, -493, -493, -493, -493, -493,
			 -493, -493, -493, -493, -493, -493, -493, -493, -493, -493,
			 -493, -493, -493, -493, -493, -493, -493, -493, -493, -493,
			 -493, -493, -493, -493, -493, -493, -493, -493, -493, -493,

			 -493, -493, -493, -493, -493, -493, -493, -493, -493, -493,
			 -493, -493, -493, -493, -493, -493, -493, -493, -493, -493,
			 -493, -493, -493, -493, -493, -493, -493, -493, -493, -493,
			 -493, -493, -493, -493, -493, -493, -493, -493, -493, -493,
			 -493, -493, -493, -493, -493, -493, -493, -493, -493, -493,
			 -493, -493, -493, -493, -493, -493, -493, -493,    5, -494,
			 -494, -494, -494, -494, -494, -494, -494, -494, -494, -494,
			 -494, -494, -494, -494, -494, -494, -494, -494, -494, -494,
			 -494, -494, -494, -494, -494, -494, -494, -494, -494, -494,
			 -494, -494, -494, -494, -494, -494, -494, -494, -494, -494, yy_Dummy>>,
			1, 1000, 126000)
		end

	yy_nxt_template_128 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -494, -494, -494, -494, -494, -494,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -494, -494, -494, -494,
			 -494, -494, -494,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -494,
			 -494, -494, -494,  100, -494,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -494, -494, -494, -494, -494, -494, -494, -494, -494,
			 -494, -494, -494, -494, -494, -494, -494, -494, -494, -494,

			 -494, -494, -494, -494, -494, -494, -494, -494, -494, -494,
			 -494, -494, -494, -494, -494, -494, -494, -494, -494, -494,
			 -494, -494, -494, -494, -494, -494, -494, -494, -494, -494,
			 -494, -494, -494, -494, -494, -494, -494, -494, -494, -494,
			 -494, -494, -494, -494, -494, -494, -494, -494, -494, -494,
			 -494, -494, -494, -494, -494, -494, -494, -494, -494, -494,
			 -494, -494, -494, -494, -494, -494, -494, -494, -494, -494,
			 -494, -494, -494, -494, -494, -494, -494, -494, -494, -494,
			 -494, -494, -494, -494, -494, -494, -494, -494, -494, -494,
			 -494, -494, -494, -494, -494, -494, -494, -494, -494, -494,

			 -494, -494, -494, -494, -494, -494, -494, -494, -494, -494,
			 -494, -494, -494, -494, -494,    5, -495, -495, -495, -495,
			 -495, -495, -495, -495, -495, -495, -495, -495, -495, -495,
			 -495, -495, -495, -495, -495, -495, -495, -495, -495, -495,
			 -495, -495, -495, -495, -495, -495, -495, -495, -495, -495,
			 -495, -495, -495, -495, -495, -495, -495, -495, -495, -495,
			 -495, -495, -495,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -495, -495, -495, -495, -495, -495, -495,
			  100,  100,  100,  100,  521,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100, -495, -495, -495, -495,
			  100, -495,  100,  100,  100,  100,  521,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -495, -495,
			 -495, -495, -495, -495, -495, -495, -495, -495, -495, -495,
			 -495, -495, -495, -495, -495, -495, -495, -495, -495, -495,
			 -495, -495, -495, -495, -495, -495, -495, -495, -495, -495,
			 -495, -495, -495, -495, -495, -495, -495, -495, -495, -495,
			 -495, -495, -495, -495, -495, -495, -495, -495, -495, -495,
			 -495, -495, -495, -495, -495, -495, -495, -495, -495, -495,

			 -495, -495, -495, -495, -495, -495, -495, -495, -495, -495,
			 -495, -495, -495, -495, -495, -495, -495, -495, -495, -495,
			 -495, -495, -495, -495, -495, -495, -495, -495, -495, -495,
			 -495, -495, -495, -495, -495, -495, -495, -495, -495, -495,
			 -495, -495, -495, -495, -495, -495, -495, -495, -495, -495,
			 -495, -495, -495, -495, -495, -495, -495, -495, -495, -495,
			 -495, -495, -495, -495, -495, -495, -495, -495, -495, -495,
			 -495, -495,    5, -496, -496, -496, -496, -496, -496, -496,
			 -496, -496, -496, -496, -496, -496, -496, -496, -496, -496,
			 -496, -496, -496, -496, -496, -496, -496, -496, -496, -496,

			 -496, -496, -496, -496, -496, -496, -496, -496, -496, -496,
			 -496, -496, -496, -496, -496, -496, -496, -496, -496, -496,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -496, -496, -496, -496, -496, -496, -496,  100,  100,  100,
			  100,  522,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -496, -496, -496, -496,  100, -496,  100,
			  100,  100,  100,  522,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -496, -496, -496, -496, -496,

			 -496, -496, -496, -496, -496, -496, -496, -496, -496, -496,
			 -496, -496, -496, -496, -496, -496, -496, -496, -496, -496,
			 -496, -496, -496, -496, -496, -496, -496, -496, -496, -496,
			 -496, -496, -496, -496, -496, -496, -496, -496, -496, -496,
			 -496, -496, -496, -496, -496, -496, -496, -496, -496, -496,
			 -496, -496, -496, -496, -496, -496, -496, -496, -496, -496,
			 -496, -496, -496, -496, -496, -496, -496, -496, -496, -496,
			 -496, -496, -496, -496, -496, -496, -496, -496, -496, -496,
			 -496, -496, -496, -496, -496, -496, -496, -496, -496, -496,
			 -496, -496, -496, -496, -496, -496, -496, -496, -496, -496,

			 -496, -496, -496, -496, -496, -496, -496, -496, -496, -496,
			 -496, -496, -496, -496, -496, -496, -496, -496, -496, -496,
			 -496, -496, -496, -496, -496, -496, -496, -496, -496,    5,
			 -497, -497, -497, -497, -497, -497, -497, -497, -497, -497,
			 -497, -497, -497, -497, -497, -497, -497, -497, -497, -497,
			 -497, -497, -497, -497, -497, -497, -497, -497, -497, -497,
			 -497, -497, -497, -497, -497, -497, -497, -497, -497, -497,
			 -497, -497, -497, -497, -497, -497, -497,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -497, -497, -497,
			 -497, -497, -497, -497,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -497, -497, -497, -497,  100, -497,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -497, -497, -497, -497, -497, -497, -497, -497,
			 -497, -497, -497, -497, -497, -497, -497, -497, -497, -497,
			 -497, -497, -497, -497, -497, -497, -497, -497, -497, -497,
			 -497, -497, -497, -497, -497, -497, -497, -497, -497, -497,
			 -497, -497, -497, -497, -497, -497, -497, -497, -497, -497,

			 -497, -497, -497, -497, -497, -497, -497, -497, -497, -497,
			 -497, -497, -497, -497, -497, -497, -497, -497, -497, -497,
			 -497, -497, -497, -497, -497, -497, -497, -497, -497, -497,
			 -497, -497, -497, -497, -497, -497, -497, -497, -497, -497,
			 -497, -497, -497, -497, -497, -497, -497, -497, -497, -497,
			 -497, -497, -497, -497, -497, -497, -497, -497, -497, -497,
			 -497, -497, -497, -497, -497, -497, -497, -497, -497, -497,
			 -497, -497, -497, -497, -497, -497, -497, -497, -497, -497,
			 -497, -497, -497, -497, -497, -497,    5,   63,   63,   63,
			   63,   63,   63,   63,   63,   63, -498,   63,   63,   63, yy_Dummy>>,
			1, 1000, 127000)
		end

	yy_nxt_template_129 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   64,   63,   63, -498,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,  523,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,  523,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,    5,   63,   63,   63,   63,   63,   63,
			   63,   63,   63, -499,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,  524,   63,   63,
			 -499,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			    5,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			 -500,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,  525,   63,   63, -500,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,    5, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,

			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501,  371, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,

			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501, yy_Dummy>>,
			1, 1000, 128000)
		end

	yy_nxt_template_130 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -501, -501, -501, -501, -501, -501, -501, -501, -501, -501,
			 -501, -501, -501, -501,    5, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502,  503,  503,  503,  503,  503,  503,  503,  503,
			  503,  503, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,

			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,

			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502, -502, -502, -502, -502, -502, -502, -502, -502, -502,
			 -502,    5, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,

			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503,  371, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,

			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,

			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503, -503, -503,
			 -503, -503, -503, -503, -503, -503, -503, -503,    5, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504,  505,  505,  505,  505,
			  505,  505,  505,  505,  505,  505, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,

			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,

			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504, -504, -504, -504, -504, -504,
			 -504, -504, -504, -504, -504,    5, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,

			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505,  505,  505,  505,  505,  505,  505,  505,
			  505,  505,  505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,

			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505, yy_Dummy>>,
			1, 1000, 129000)
		end

	yy_nxt_template_131 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505, -505, -505, -505, -505, -505, -505, -505, -505,
			 -505, -505,    5, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			  527,  527,  527,  527,  527,  527,  527,  527,  527,  527,

			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,

			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506, -506,
			 -506, -506, -506, -506, -506, -506, -506, -506, -506,    5,

			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507,  528, -507,  528, -507, -507,  529,  529,  529,
			  529,  529,  529,  529,  529,  529,  529, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,

			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,

			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507, -507, -507, -507, -507,
			 -507, -507, -507, -507, -507, -507,    5, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,

			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508,  378, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,

			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,

			 -508, -508, -508, -508, -508, -508, -508, -508, -508, -508,
			 -508, -508, -508,    5, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509,  473,  473,  473,  473,  473,  473,  473,  473,  473,
			  473, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509,  507, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,

			 -509, -509, -509, -509, -509, -509, -509, -509,  310, -509,
			 -509, -509, -509, -509,  507, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509, yy_Dummy>>,
			1, 1000, 130000)
		end

	yy_nxt_template_132 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			 -509, -509, -509, -509, -509, -509, -509, -509, -509, -509,
			    5, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,

			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510,  511,  511,
			  511,  511,  511,  511,  511,  511,  511,  511, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,

			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,

			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510, -510, -510, -510,
			 -510, -510, -510, -510, -510, -510, -510,    5, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511,  530,  530,  530,  530,  530,
			  530,  530,  530,  530,  530, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,

			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511,  378, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,

			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511, -511, -511, -511, -511, -511, -511,
			 -511, -511, -511, -511,    5, -512, -512, -512, -512, -512,
			 -512, -512, -512, -512, -512, -512, -512, -512, -512, -512,

			 -512, -512, -512, -512, -512, -512, -512, -512, -512, -512,
			 -512, -512, -512, -512, -512, -512, -512, -512, -512, -512,
			 -512, -512, -512, -512, -512, -512, -512, -512, -512, -512,
			 -512, -512,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -512, -512, -512, -512, -512, -512, -512,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -512, -512, -512, -512,  100,
			 -512,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100, -512, -512, -512,
			 -512, -512, -512, -512, -512, -512, -512, -512, -512, -512,
			 -512, -512, -512, -512, -512, -512, -512, -512, -512, -512,
			 -512, -512, -512, -512, -512, -512, -512, -512, -512, -512,
			 -512, -512, -512, -512, -512, -512, -512, -512, -512, -512,
			 -512, -512, -512, -512, -512, -512, -512, -512, -512, -512,
			 -512, -512, -512, -512, -512, -512, -512, -512, -512, -512,
			 -512, -512, -512, -512, -512, -512, -512, -512, -512, -512,
			 -512, -512, -512, -512, -512, -512, -512, -512, -512, -512,
			 -512, -512, -512, -512, -512, -512, -512, -512, -512, -512,

			 -512, -512, -512, -512, -512, -512, -512, -512, -512, -512,
			 -512, -512, -512, -512, -512, -512, -512, -512, -512, -512,
			 -512, -512, -512, -512, -512, -512, -512, -512, -512, -512,
			 -512, -512, -512, -512, -512, -512, -512, -512, -512, -512,
			 -512,    5, -513, -513, -513, -513, -513, -513, -513, -513,
			 -513, -513, -513, -513, -513, -513, -513, -513, -513, -513,
			 -513, -513, -513, -513, -513, -513, -513, -513, -513, -513,
			 -513, -513, -513, -513, -513, -513, -513, -513, -513, -513,
			 -513, -513, -513, -513, -513, -513, -513, -513, -513,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -513,

			 -513, -513, -513, -513, -513, -513,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -513, -513, -513, -513,  100, -513,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -513, -513, -513, -513, -513, -513,
			 -513, -513, -513, -513, -513, -513, -513, -513, -513, -513,
			 -513, -513, -513, -513, -513, -513, -513, -513, -513, -513,
			 -513, -513, -513, -513, -513, -513, -513, -513, -513, -513, yy_Dummy>>,
			1, 1000, 131000)
		end

	yy_nxt_template_133 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -513, -513, -513, -513, -513, -513, -513, -513, -513, -513,
			 -513, -513, -513, -513, -513, -513, -513, -513, -513, -513,
			 -513, -513, -513, -513, -513, -513, -513, -513, -513, -513,
			 -513, -513, -513, -513, -513, -513, -513, -513, -513, -513,
			 -513, -513, -513, -513, -513, -513, -513, -513, -513, -513,
			 -513, -513, -513, -513, -513, -513, -513, -513, -513, -513,
			 -513, -513, -513, -513, -513, -513, -513, -513, -513, -513,
			 -513, -513, -513, -513, -513, -513, -513, -513, -513, -513,
			 -513, -513, -513, -513, -513, -513, -513, -513, -513, -513,
			 -513, -513, -513, -513, -513, -513, -513, -513,    5, -514,

			 -514, -514, -514, -514, -514, -514, -514, -514, -514, -514,
			 -514, -514, -514, -514, -514, -514, -514, -514, -514, -514,
			 -514, -514, -514, -514, -514, -514, -514, -514, -514, -514,
			 -514, -514, -514, -514, -514, -514, -514, -514, -514, -514,
			 -514, -514, -514, -514, -514, -514,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -514, -514, -514, -514,
			 -514, -514, -514,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -514,
			 -514, -514, -514,  100, -514,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -514, -514, -514, -514, -514, -514, -514, -514, -514,
			 -514, -514, -514, -514, -514, -514, -514, -514, -514, -514,
			 -514, -514, -514, -514, -514, -514, -514, -514, -514, -514,
			 -514, -514, -514, -514, -514, -514, -514, -514, -514, -514,
			 -514, -514, -514, -514, -514, -514, -514, -514, -514, -514,
			 -514, -514, -514, -514, -514, -514, -514, -514, -514, -514,
			 -514, -514, -514, -514, -514, -514, -514, -514, -514, -514,
			 -514, -514, -514, -514, -514, -514, -514, -514, -514, -514,

			 -514, -514, -514, -514, -514, -514, -514, -514, -514, -514,
			 -514, -514, -514, -514, -514, -514, -514, -514, -514, -514,
			 -514, -514, -514, -514, -514, -514, -514, -514, -514, -514,
			 -514, -514, -514, -514, -514, -514, -514, -514, -514, -514,
			 -514, -514, -514, -514, -514, -514, -514, -514, -514, -514,
			 -514, -514, -514, -514, -514,    5, -515, -515, -515, -515,
			 -515, -515, -515, -515, -515, -515, -515, -515, -515, -515,
			 -515, -515, -515, -515, -515, -515, -515, -515, -515, -515,
			 -515, -515, -515, -515, -515, -515, -515, -515, -515, -515,
			 -515, -515, -515, -515, -515, -515, -515, -515, -515, -515,

			 -515, -515, -515,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -515, -515, -515, -515, -515, -515, -515,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100, -515, -515, -515, -515,
			  100, -515,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -515, -515,
			 -515, -515, -515, -515, -515, -515, -515, -515, -515, -515,
			 -515, -515, -515, -515, -515, -515, -515, -515, -515, -515,

			 -515, -515, -515, -515, -515, -515, -515, -515, -515, -515,
			 -515, -515, -515, -515, -515, -515, -515, -515, -515, -515,
			 -515, -515, -515, -515, -515, -515, -515, -515, -515, -515,
			 -515, -515, -515, -515, -515, -515, -515, -515, -515, -515,
			 -515, -515, -515, -515, -515, -515, -515, -515, -515, -515,
			 -515, -515, -515, -515, -515, -515, -515, -515, -515, -515,
			 -515, -515, -515, -515, -515, -515, -515, -515, -515, -515,
			 -515, -515, -515, -515, -515, -515, -515, -515, -515, -515,
			 -515, -515, -515, -515, -515, -515, -515, -515, -515, -515,
			 -515, -515, -515, -515, -515, -515, -515, -515, -515, -515,

			 -515, -515, -515, -515, -515, -515, -515, -515, -515, -515,
			 -515, -515,    5, -516, -516, -516, -516, -516, -516, -516,
			 -516, -516, -516, -516, -516, -516, -516, -516, -516, -516,
			 -516, -516, -516, -516, -516, -516, -516, -516, -516, -516,
			 -516, -516, -516, -516, -516, -516, -516, -516, -516, -516,
			 -516, -516, -516, -516, -516, -516, -516, -516, -516, -516,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -516, -516, -516, -516, -516, -516, -516,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100, -516, -516, -516, -516,  100, -516,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -516, -516, -516, -516, -516,
			 -516, -516, -516, -516, -516, -516, -516, -516, -516, -516,
			 -516, -516, -516, -516, -516, -516, -516, -516, -516, -516,
			 -516, -516, -516, -516, -516, -516, -516, -516, -516, -516,
			 -516, -516, -516, -516, -516, -516, -516, -516, -516, -516,
			 -516, -516, -516, -516, -516, -516, -516, -516, -516, -516,
			 -516, -516, -516, -516, -516, -516, -516, -516, -516, -516,

			 -516, -516, -516, -516, -516, -516, -516, -516, -516, -516,
			 -516, -516, -516, -516, -516, -516, -516, -516, -516, -516,
			 -516, -516, -516, -516, -516, -516, -516, -516, -516, -516,
			 -516, -516, -516, -516, -516, -516, -516, -516, -516, -516,
			 -516, -516, -516, -516, -516, -516, -516, -516, -516, -516,
			 -516, -516, -516, -516, -516, -516, -516, -516, -516, -516,
			 -516, -516, -516, -516, -516, -516, -516, -516, -516,    5,
			 -517, -517, -517, -517, -517, -517, -517, -517, -517, -517,
			 -517, -517, -517, -517, -517, -517, -517, -517, -517, -517,
			 -517, -517, -517, -517, -517, -517, -517, -517, -517, -517,

			 -517, -517, -517, -517, -517, -517, -517, -517, -517, -517,
			 -517, -517, -517, -517, -517, -517, -517,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -517, -517, -517,
			 -517, -517, -517, -517,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  531,  100,  100,  100,  100,  100,  100,
			 -517, -517, -517, -517,  100, -517,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  531,  100,  100,  100,  100,
			  100,  100, -517, -517, -517, -517, -517, -517, -517, -517, yy_Dummy>>,
			1, 1000, 132000)
		end

	yy_nxt_template_134 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -517, -517, -517, -517, -517, -517, -517, -517, -517, -517,
			 -517, -517, -517, -517, -517, -517, -517, -517, -517, -517,
			 -517, -517, -517, -517, -517, -517, -517, -517, -517, -517,
			 -517, -517, -517, -517, -517, -517, -517, -517, -517, -517,
			 -517, -517, -517, -517, -517, -517, -517, -517, -517, -517,
			 -517, -517, -517, -517, -517, -517, -517, -517, -517, -517,
			 -517, -517, -517, -517, -517, -517, -517, -517, -517, -517,
			 -517, -517, -517, -517, -517, -517, -517, -517, -517, -517,
			 -517, -517, -517, -517, -517, -517, -517, -517, -517, -517,
			 -517, -517, -517, -517, -517, -517, -517, -517, -517, -517,

			 -517, -517, -517, -517, -517, -517, -517, -517, -517, -517,
			 -517, -517, -517, -517, -517, -517, -517, -517, -517, -517,
			 -517, -517, -517, -517, -517, -517,    5, -518, -518, -518,
			 -518, -518, -518, -518, -518, -518, -518, -518, -518, -518,
			 -518, -518, -518, -518, -518, -518, -518, -518, -518, -518,
			 -518, -518, -518, -518, -518, -518, -518, -518, -518, -518,
			 -518, -518, -518, -518, -518, -518, -518, -518, -518, -518,
			 -518, -518, -518, -518,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100, -518, -518, -518, -518, -518, -518,
			 -518,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -518, -518, -518,
			 -518,  100, -518,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100, -518,
			 -518, -518, -518, -518, -518, -518, -518, -518, -518, -518,
			 -518, -518, -518, -518, -518, -518, -518, -518, -518, -518,
			 -518, -518, -518, -518, -518, -518, -518, -518, -518, -518,
			 -518, -518, -518, -518, -518, -518, -518, -518, -518, -518,
			 -518, -518, -518, -518, -518, -518, -518, -518, -518, -518,

			 -518, -518, -518, -518, -518, -518, -518, -518, -518, -518,
			 -518, -518, -518, -518, -518, -518, -518, -518, -518, -518,
			 -518, -518, -518, -518, -518, -518, -518, -518, -518, -518,
			 -518, -518, -518, -518, -518, -518, -518, -518, -518, -518,
			 -518, -518, -518, -518, -518, -518, -518, -518, -518, -518,
			 -518, -518, -518, -518, -518, -518, -518, -518, -518, -518,
			 -518, -518, -518, -518, -518, -518, -518, -518, -518, -518,
			 -518, -518, -518, -518, -518, -518, -518, -518, -518, -518,
			 -518, -518, -518,    5, -519, -519, -519, -519, -519, -519,
			 -519, -519, -519, -519, -519, -519, -519, -519, -519, -519,

			 -519, -519, -519, -519, -519, -519, -519, -519, -519, -519,
			 -519, -519, -519, -519, -519, -519, -519, -519, -519, -519,
			 -519, -519, -519, -519, -519, -519, -519, -519, -519, -519,
			 -519,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -519, -519, -519, -519, -519, -519, -519,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  532,  100,  100,  100,  100,
			  100,  100,  100,  100, -519, -519, -519, -519,  100, -519,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  532,  100,  100,

			  100,  100,  100,  100,  100,  100, -519, -519, -519, -519,
			 -519, -519, -519, -519, -519, -519, -519, -519, -519, -519,
			 -519, -519, -519, -519, -519, -519, -519, -519, -519, -519,
			 -519, -519, -519, -519, -519, -519, -519, -519, -519, -519,
			 -519, -519, -519, -519, -519, -519, -519, -519, -519, -519,
			 -519, -519, -519, -519, -519, -519, -519, -519, -519, -519,
			 -519, -519, -519, -519, -519, -519, -519, -519, -519, -519,
			 -519, -519, -519, -519, -519, -519, -519, -519, -519, -519,
			 -519, -519, -519, -519, -519, -519, -519, -519, -519, -519,
			 -519, -519, -519, -519, -519, -519, -519, -519, -519, -519,

			 -519, -519, -519, -519, -519, -519, -519, -519, -519, -519,
			 -519, -519, -519, -519, -519, -519, -519, -519, -519, -519,
			 -519, -519, -519, -519, -519, -519, -519, -519, -519, -519,
			 -519, -519, -519, -519, -519, -519, -519, -519, -519, -519,
			    5, -520, -520, -520, -520, -520, -520, -520, -520, -520,
			 -520, -520, -520, -520, -520, -520, -520, -520, -520, -520,
			 -520, -520, -520, -520, -520, -520, -520, -520, -520, -520,
			 -520, -520, -520, -520, -520, -520, -520, -520, -520, -520,
			 -520, -520, -520, -520, -520, -520, -520, -520,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -520, -520,

			 -520, -520, -520, -520, -520,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100, -520, -520, -520, -520,  100, -520,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100, -520, -520, -520, -520, -520, -520, -520,
			 -520, -520, -520, -520, -520, -520, -520, -520, -520, -520,
			 -520, -520, -520, -520, -520, -520, -520, -520, -520, -520,
			 -520, -520, -520, -520, -520, -520, -520, -520, -520, -520,

			 -520, -520, -520, -520, -520, -520, -520, -520, -520, -520,
			 -520, -520, -520, -520, -520, -520, -520, -520, -520, -520,
			 -520, -520, -520, -520, -520, -520, -520, -520, -520, -520,
			 -520, -520, -520, -520, -520, -520, -520, -520, -520, -520,
			 -520, -520, -520, -520, -520, -520, -520, -520, -520, -520,
			 -520, -520, -520, -520, -520, -520, -520, -520, -520, -520,
			 -520, -520, -520, -520, -520, -520, -520, -520, -520, -520,
			 -520, -520, -520, -520, -520, -520, -520, -520, -520, -520,
			 -520, -520, -520, -520, -520, -520, -520, -520, -520, -520,
			 -520, -520, -520, -520, -520, -520, -520,    5, -521, -521,

			 -521, -521, -521, -521, -521, -521, -521, -521, -521, -521,
			 -521, -521, -521, -521, -521, -521, -521, -521, -521, -521,
			 -521, -521, -521, -521, -521, -521, -521, -521, -521, -521,
			 -521, -521, -521, -521, -521, -521, -521, -521, -521, -521,
			 -521, -521, -521, -521, -521,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -521, -521, -521, -521, -521,
			 -521, -521,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -521, -521,
			 -521, -521,  100, -521,  100,  100,  100,  100,  100,  100, yy_Dummy>>,
			1, 1000, 133000)
		end

	yy_nxt_template_135 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -521, -521, -521, -521, -521, -521, -521, -521, -521, -521,
			 -521, -521, -521, -521, -521, -521, -521, -521, -521, -521,
			 -521, -521, -521, -521, -521, -521, -521, -521, -521, -521,
			 -521, -521, -521, -521, -521, -521, -521, -521, -521, -521,
			 -521, -521, -521, -521, -521, -521, -521, -521, -521, -521,
			 -521, -521, -521, -521, -521, -521, -521, -521, -521, -521,
			 -521, -521, -521, -521, -521, -521, -521, -521, -521, -521,
			 -521, -521, -521, -521, -521, -521, -521, -521, -521, -521,

			 -521, -521, -521, -521, -521, -521, -521, -521, -521, -521,
			 -521, -521, -521, -521, -521, -521, -521, -521, -521, -521,
			 -521, -521, -521, -521, -521, -521, -521, -521, -521, -521,
			 -521, -521, -521, -521, -521, -521, -521, -521, -521, -521,
			 -521, -521, -521, -521, -521, -521, -521, -521, -521, -521,
			 -521, -521, -521, -521,    5, -522, -522, -522, -522, -522,
			 -522, -522, -522, -522, -522, -522, -522, -522, -522, -522,
			 -522, -522, -522, -522, -522, -522, -522, -522, -522, -522,
			 -522, -522, -522, -522, -522, -522, -522, -522, -522, -522,
			 -522, -522, -522, -522, -522, -522, -522, -522, -522, -522,

			 -522, -522,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -522, -522, -522, -522, -522, -522, -522,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -522, -522, -522, -522,  100,
			 -522,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -522, -522, -522,
			 -522, -522, -522, -522, -522, -522, -522, -522, -522, -522,
			 -522, -522, -522, -522, -522, -522, -522, -522, -522, -522,

			 -522, -522, -522, -522, -522, -522, -522, -522, -522, -522,
			 -522, -522, -522, -522, -522, -522, -522, -522, -522, -522,
			 -522, -522, -522, -522, -522, -522, -522, -522, -522, -522,
			 -522, -522, -522, -522, -522, -522, -522, -522, -522, -522,
			 -522, -522, -522, -522, -522, -522, -522, -522, -522, -522,
			 -522, -522, -522, -522, -522, -522, -522, -522, -522, -522,
			 -522, -522, -522, -522, -522, -522, -522, -522, -522, -522,
			 -522, -522, -522, -522, -522, -522, -522, -522, -522, -522,
			 -522, -522, -522, -522, -522, -522, -522, -522, -522, -522,
			 -522, -522, -522, -522, -522, -522, -522, -522, -522, -522,

			 -522, -522, -522, -522, -522, -522, -522, -522, -522, -522,
			 -522,    5,   63,   63,   63,   63,   63,   63,   63,   63,
			   63, -523,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,  533,   63,   63, -523,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,

			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,    5, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,

			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,

			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,

			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524, -524, -524, -524, -524, -524,
			 -524, -524, -524, -524, -524,    5, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525, yy_Dummy>>,
			1, 1000, 134000)
		end

	yy_nxt_template_136 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,

			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525, -525, -525, -525, -525, -525, -525, -525, -525,
			 -525, -525,    5, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,

			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			  501,  501,  501,  501,  501,  501,  501,  501,  501,  501,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526,  371, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,

			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,

			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526, -526,
			 -526, -526, -526, -526, -526, -526, -526, -526, -526,    5,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,

			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527,  429, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,

			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527, -527, -527, -527, -527,
			 -527, -527, -527, -527, -527, -527,    5, -528, -528, -528,

			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528,  529,  529,  529,  529,  529,  529,
			  529,  529,  529,  529, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,

			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,

			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528, -528, -528, -528, -528, -528, -528, -528,
			 -528, -528, -528,    5, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529, yy_Dummy>>,
			1, 1000, 135000)
		end

	yy_nxt_template_137 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -529,  534,  534,  534,  534,  534,  534,  534,  534,  534,
			  534, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529,  429, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,

			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,

			 -529, -529, -529, -529, -529, -529, -529, -529, -529, -529,
			    5, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530,  508,  508,
			  508,  508,  508,  508,  508,  508,  508,  508, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,

			 -530, -530, -530, -530, -530,  378, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,

			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530, -530, -530, -530,
			 -530, -530, -530, -530, -530, -530, -530,    5, -531, -531,
			 -531, -531, -531, -531, -531, -531, -531, -531, -531, -531,
			 -531, -531, -531, -531, -531, -531, -531, -531, -531, -531,
			 -531, -531, -531, -531, -531, -531, -531, -531, -531, -531,

			 -531, -531, -531, -531, -531, -531, -531, -531, -531, -531,
			 -531, -531, -531, -531, -531,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -531, -531, -531, -531, -531,
			 -531, -531,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100, -531, -531,
			 -531, -531,  100, -531,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			 -531, -531, -531, -531, -531, -531, -531, -531, -531, -531,

			 -531, -531, -531, -531, -531, -531, -531, -531, -531, -531,
			 -531, -531, -531, -531, -531, -531, -531, -531, -531, -531,
			 -531, -531, -531, -531, -531, -531, -531, -531, -531, -531,
			 -531, -531, -531, -531, -531, -531, -531, -531, -531, -531,
			 -531, -531, -531, -531, -531, -531, -531, -531, -531, -531,
			 -531, -531, -531, -531, -531, -531, -531, -531, -531, -531,
			 -531, -531, -531, -531, -531, -531, -531, -531, -531, -531,
			 -531, -531, -531, -531, -531, -531, -531, -531, -531, -531,
			 -531, -531, -531, -531, -531, -531, -531, -531, -531, -531,
			 -531, -531, -531, -531, -531, -531, -531, -531, -531, -531,

			 -531, -531, -531, -531, -531, -531, -531, -531, -531, -531,
			 -531, -531, -531, -531, -531, -531, -531, -531, -531, -531,
			 -531, -531, -531, -531,    5, -532, -532, -532, -532, -532,
			 -532, -532, -532, -532, -532, -532, -532, -532, -532, -532,
			 -532, -532, -532, -532, -532, -532, -532, -532, -532, -532,
			 -532, -532, -532, -532, -532, -532, -532, -532, -532, -532,
			 -532, -532, -532, -532, -532, -532, -532, -532, -532, -532,
			 -532, -532,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100, -532, -532, -532, -532, -532, -532, -532,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,

			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100, -532, -532, -532, -532,  100,
			 -532,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100, -532, -532, -532,
			 -532, -532, -532, -532, -532, -532, -532, -532, -532, -532,
			 -532, -532, -532, -532, -532, -532, -532, -532, -532, -532,
			 -532, -532, -532, -532, -532, -532, -532, -532, -532, -532,
			 -532, -532, -532, -532, -532, -532, -532, -532, -532, -532,
			 -532, -532, -532, -532, -532, -532, -532, -532, -532, -532,

			 -532, -532, -532, -532, -532, -532, -532, -532, -532, -532,
			 -532, -532, -532, -532, -532, -532, -532, -532, -532, -532,
			 -532, -532, -532, -532, -532, -532, -532, -532, -532, -532,
			 -532, -532, -532, -532, -532, -532, -532, -532, -532, -532,
			 -532, -532, -532, -532, -532, -532, -532, -532, -532, -532,
			 -532, -532, -532, -532, -532, -532, -532, -532, -532, -532,
			 -532, -532, -532, -532, -532, -532, -532, -532, -532, -532,
			 -532, -532, -532, -532, -532, -532, -532, -532, -532, -532,
			 -532,    5, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533, yy_Dummy>>,
			1, 1000, 136000)
		end

	yy_nxt_template_138 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,

			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,

			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533, -533, -533,
			 -533, -533, -533, -533, -533, -533, -533, -533,    5, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534,  527,  527,  527,  527,
			  527,  527,  527,  527,  527,  527, -534, -534, -534, -534,

			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534,  429, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,

			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, -534, -534, -534, -534, -534,
			 -534, -534, -534, -534, -534, yy_Dummy>>,
			1, 495, 137000)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,  186,  184,    1,    2,   17,
			  144,   96,   24,  184,   18,   19,    7,    6,   15,    5,
			   13,    8,  175,  175,   16,   14,   12,   10,   11,  184,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   22,
			  184,   23,    9,  177,   20,   21,  145,  171,  169,  171,
			    1,    2,   30,  144,  143,  144,  144,  144,  144,  144,
			  144,  144,  144,  144,  144,  144,  144,  144,  144,   96,
			  122,  122,  122,    3,   31,   32,  180,   25,   27,    0,
			  175,  175,  174,  177,   35,   33,   29,   28,   34,   36,

			   95,   95,   95,   40,   95,   95,   95,   95,   95,   95,
			   48,   95,   95,   95,   95,   95,   95,   60,   95,   95,
			   67,   95,   95,   95,   95,   95,   95,   75,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,   95,   26,  177,
			  145,  169,  170,  170,  172,  162,  160,  161,  163,  164,
			  170,  165,  166,  146,  147,  148,  149,  150,  151,  152,
			  153,  154,  155,  156,  157,  158,  159,  142,  126,  124,
			  125,  127,  144,  131,  144,  133,  144,  144,  144,  144,
			  144,  144,  144,  130,  122,   97,  122,  122,  122,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  122,

			  122,  122,  122,  122,  122,  122,  122,  122,  122,   98,
			    4,  180,    0,    0,  178,  180,  178,  175,  175,  177,
			   95,   38,   39,   41,   95,   95,   95,   95,   95,   95,
			   95,   51,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,   71,   95,   73,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,   94,    0,  168,
			  173,  128,  132,  134,  144,  144,  144,  144,  137,  144,
			  129,  121,  115,  113,  114,  116,  117,  123,  118,  119,
			   99,  100,  101,  102,  103,  104,  105,  106,  107,  108,

			  109,  110,  111,  112,  180,    0,  180,    0,  180,    0,
			    0,    0,  179,  175,  175,  177,   95,   95,   95,   95,
			   95,   95,   95,   49,   95,   95,   95,   95,   95,   95,
			   58,   95,   95,   95,   95,   95,   95,   95,   68,   95,
			   70,   95,   74,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,   95,   95,   87,   88,   95,   95,   95,   95,
			   93,  167,  144,  136,  144,  135,  144,  138,  123,  180,
			  180,    0,    0,  180,    0,  179,    0,  179,    0,    0,
			  176,   37,   42,   43,   95,   95,   46,   95,   95,   95,
			   95,   95,   95,   56,   95,   95,   95,   95,   63,   95,

			   95,   95,   69,   95,   95,   95,   95,   95,   95,   95,
			   95,   83,   95,   95,   86,   95,   95,   91,   95,  144,
			  144,  144,  120,    0,  180,    0,  183,  180,  179,    0,
			    0,  179,    0,  178,    0,   95,   95,   95,   50,   52,
			   95,   54,   95,   95,   59,   95,   95,   95,   95,   95,
			   95,   95,   77,   95,   79,   95,   81,   82,   84,   95,
			   95,   90,   95,  144,  144,  144,    0,  180,    0,    0,
			    0,  179,    0,  183,  179,    0,    0,  181,  183,  181,
			   95,   45,   95,   95,   95,   57,   61,   95,   64,   65,
			   95,   95,   95,   95,   80,   95,   95,   92,  144,  144,

			  144,  183,    0,  183,    0,  179,    0,    0,  182,  183,
			    0,  182,   44,   47,   53,   55,   62,   95,   72,   95,
			   78,   85,   89,  144,  141,  140,  183,  182,    0,  182,
			  182,   66,   76,  139,  182, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyNull_equiv_class: INTEGER = 256
			-- Equivalence code for NULL character

	yyNb_rows: INTEGER = 257
			-- Number of rows in `yy_nxt'

	yyBacking_up: BOOLEAN = true
			-- Does current scanner back up?
			-- (i.e. does it have non-accepting states)

	yyNb_rules: INTEGER = 185
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 186
			-- End of buffer rule code

	yyLine_used: BOOLEAN = false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = false
			-- Is `position' used?

	INITIAL: INTEGER = 0
	IN_STR: INTEGER = 1
			-- Start condition codes

feature -- User-defined features



feature {NONE} -- Local variables

	i_, nb_: INTEGER
	char_: CHARACTER
	str_: STRING
	code_: INTEGER

feature {NONE} -- Initialization

	make
			-- Create a new Eiffel scanner.
		do
			make_with_buffer (Empty_buffer)
			eif_buffer := STRING_.make (Init_buffer_size)
			eif_lineno := 1
		end

	execute
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

	benchmark
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
		
	scan_string (a_text: STRING)
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

	on_token_found
		require
--			consistent_positions: token_first_pos <= token_last_pos
		do
			print ("found a token%N")
		end
feature -- Initialization

	reset
			-- Reset scanner before scanning next input.
		do
			reset_compressed_scanner_skeleton
			eif_lineno := 1
			eif_buffer.wipe_out
			eif_position := 1
		end

feature -- Access

	eif_position: INTEGER
	
	token_first_pos: INTEGER
		do
				--| Because of an error in the analyzer we need to check
				--| the size of text_count for validity
			if text_count = 0 then
				Result := token_last_pos
			else
				Result := token_last_pos - text_count + 1
			end
		end

	token_last_pos: INTEGER
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

	move (i: INTEGER)
		do
			eif_position := eif_position + i
		end
		
	process_operator (op: INTEGER): INTEGER
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

	Init_buffer_size: INTEGER = 256
				-- Initial size for `eif_buffer'

invariant

	eif_buffer_not_void: eif_buffer /= Void
	
	
end -- class EIFFEL_SCANNER
