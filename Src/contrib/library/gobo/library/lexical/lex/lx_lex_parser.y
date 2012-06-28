%{
indexing

	description:

		"Parsers for lexical analyzer generators such as 'gelex'"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999-2004, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class LX_LEX_PARSER

inherit

	LX_LEX_PARSER_SKELETON
		redefine
			last_integer_value
		end

	LX_LEX_SCANNER
		rename
			make as make_lex_scanner,
			make_from_description as make_lex_scanner_from_description,
			reset as reset_lex_scanner
		redefine
			last_integer_value
		end

create

	make, make_from_description

%}

%token ENDSECT EOF_OP PIPED EMPTY

%token <STRING> EIF_CODE NAME '['
%token <INTEGER> CHAR NUMBER
%token <LX_SYMBOL_CLASS> CCL_OP

%type <INTEGER> Start_condition Less_than
%type <LX_NFA> Rule Regular_expression Regular_expression2 Series Series_singleton Singleton String
%type <LX_SYMBOL_CLASS> CCl Full_CCl

%start Scanner_description
%expect 7

%%

Scanner_description: Section1 Section2 Init_rule Section3
		{
			process_default_rule
			if description.equiv_classes /= Void then
				build_equiv_classes
			end
			check_options
		}
	;

Section1: ENDSECT
		{
			override_options
			if description.equiv_classes_used then
				description.create_equiv_classes
			end
		}
	;

Section2: -- Empty
	| Section2 Start_condition Init_rule Pattern Action
		{
			start_condition_stack.keep_first ($2)
		}
	| Section2 Start_condition '{' Section2 '}'
		{
			start_condition_stack.keep_first ($2)
		}
	;

Action: -- Empty
	| EIF_CODE
		{
			set_action ($1)
		}
	| PIPED
	| EMPTY
		{
			set_action ("")
		}
	;

Init_rule: -- Empty
		{
				-- Initialize for a parse of one rule.
			in_trail_context := False
			create rule.make_default (description.rules.count + 1)
		}
	;

Start_condition: -- Empty
		{
			$$ := start_condition_stack.count
		}
	| Less_than '*' '>'
		{
			$$ := $1
			start_condition_stack.append_start_conditions (description.start_conditions)
		}
	| Less_than Name_list '>'
		{ $$ := $1 }
	;

Less_than: '<'
		{
			$$ := start_condition_stack.count
		}
	;

Name_list: NAME
		{
			push_start_condition ($1, start_condition_stack)
		}
	| Name_list ',' NAME
		{
			push_start_condition ($3, start_condition_stack)
		}
	| error
		{
			report_bad_start_condition_list_error
		}
	;

Pattern: '^' Rule
		{
			process_bol_rule ($2)
		}
	| Rule
		{
			process_rule ($1)
		}
	| EOF_OP
		{
			process_eof_rule
		}
	| error
		{
			report_unrecognized_rule_error
		}
	;

Rule: Regular_expression2 Regular_expression
		{
			has_trail_context := True
			trail_count := regexp_count
			$$ := append_trail_context_to_regexp ($2, $1)
		}
	| Regular_expression '$'
		{
			has_trail_context := True
			head_count := regexp_count
			head_line := regexp_line
			head_column := regexp_column
			trail_count := 1
			$$ := append_eol_to_regexp ($1)
		}
	| Regular_expression
		{
			$$ := $1
			has_trail_context := False
			head_count := regexp_count
			head_line := regexp_line
			head_column := regexp_column
			trail_count := 0
		}
	| Regular_expression2 Regular_expression2
		{
			report_trailing_context_used_twice_error
			has_trail_context := True
			trail_count := regexp_count
			$$ := new_epsilon_nfa
		}
	| Regular_expression2 Regular_expression '$'
		{
			report_trailing_context_used_twice_error
			has_trail_context := True
			trail_count := regexp_count
			$$ := new_epsilon_nfa
		}
	;

Regular_expression: Series
		{
			$$ := $1
			regexp_count := series_count
			regexp_line := series_line
			regexp_column := series_column
		}
	| Regular_expression '|'
		{
			old_regexp_lines.force (regexp_line)
			old_regexp_columns.force (regexp_column)
			old_regexp_counts.force (regexp_count)
		}
	  Series
		{
			regexp_line := old_regexp_lines.item
			old_regexp_lines.remove
			regexp_column := old_regexp_columns.item
			old_regexp_columns.remove
			regexp_count := old_regexp_counts.item
			old_regexp_counts.remove
			$$ := $1
			$$.build_union ($4)
			process_regexp_or_series
		}
	;

Regular_expression2: Regular_expression '/'
		{
			$$ := $1
				-- This rule is written separately so the reduction
				-- will occur before the trailing series is parsed.
			head_count := regexp_count
			head_line := regexp_line
			head_column := regexp_column
			in_trail_context := True
		}
	;

Series: Series_singleton
		{
			old_singleton_lines.remove
			old_singleton_columns.remove
			old_singleton_counts.remove
			$$ := $1
			series_count := singleton_count
			series_line := singleton_line
			series_column := singleton_column
		}
	| Series_singleton Series
		{
			singleton_line := old_singleton_lines.item
			old_singleton_lines.remove
			singleton_column := old_singleton_columns.item
			old_singleton_columns.remove
			singleton_count := old_singleton_counts.item
			old_singleton_counts.remove
			$$ := $1
			$$.build_concatenation ($2)
			process_singleton_series
		}
	;

Series_singleton: Singleton
		{
			old_singleton_lines.force (singleton_line)
			old_singleton_columns.force (singleton_column)
			old_singleton_counts.force (singleton_count)
			$$ := $1
		}
	;

Singleton: CHAR
		{
			$$ := new_nfa_from_character ($1)
			process_singleton_char ($1)
		}
	| Singleton '*'
		{
			$$ := $1
			$$.build_closure
			process_singleton_star
		}
	| Singleton '+'
		{
			$$ := $1
			$$.build_positive_closure
			process_singleton_plus
		}
	| Singleton '?'
		{
			$$ := $1
			$$.build_optional
			process_singleton_optional
		}
	| Singleton '{' NUMBER ',' NUMBER '}'
		{
			$$ := new_bounded_iteration_nfa ($1, $3, $5)
			process_singleton_bounded_iteration ($3, $5)
		}
	| Singleton '{' NUMBER ',' '}'
		{
			$$ := new_unbounded_iteration_nfa ($1, $3)
			process_singleton_unbounded_iteration ($3)
		}
	| Singleton '{' NUMBER '}'
		{
			$$ := new_iteration_nfa ($1, $3)
			process_singleton_fixed_iteration ($3)

		}
	| '.'
		{
			$$ := new_symbol_class_nfa (dot_character_class)
			process_singleton_dot
		}
	| CCL_OP
		{
			$$ := new_symbol_class_nfa ($1)
			process_singleton_symbol_class ($1)
		}
	| Full_CCl
		{
			$$ := new_nfa_from_character_class ($1)
			process_singleton_symbol_class ($1)
		}
	| '"' String '"'
		{
			$$ := $2
		}
	| '(' Regular_expression ')'
		{
			$$ := $2
			singleton_count := regexp_count
			singleton_line := regexp_line
			singleton_column := regexp_column
		}
	;

Full_CCl: '[' CCl ']'
		{
			$$ := $2
			character_classes.force ($$, $1)
		}
	| '[' '^' CCl  ']'
		{
			$$ := $3
			$$.set_negated (True)
			character_classes.force ($$, $1)
		}
	;

CCl: CHAR
		{
			$$ := append_character_to_character_class ($1, new_character_class)
		}
	| CCl CHAR
		{
			$$ := append_character_to_character_class ($2, $1)
		}
	| CHAR '-' CHAR
		{
			$$ := append_character_set_to_character_class
				($1, $3, new_character_class)
		}
	| CCl CHAR '-' CHAR
		{
			$$ := append_character_set_to_character_class ($2, $4, $1)
		}
	;
	
String: -- Empty
		{
			$$ := new_epsilon_nfa
			process_singleton_empty_string
		}
	| String CHAR
		{
			$$ := append_character_to_string ($2, $1)
			process_singleton_string ($2)
		}
	;

Section3: -- Empty
	| ENDSECT
	| ENDSECT EIF_CODE
		{
			description.set_eiffel_code ($2)
		}
	;

%%

feature {NONE} -- Access

	last_integer_value: INTEGER
			-- Last semantic value of type INTEGER

end
