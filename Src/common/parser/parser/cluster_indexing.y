%{
indexing

	description: "Cluster indexing parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class CLUSTER_INDEXING_PARSER

inherit
	EIFFEL_PARSER_SKELETON

creation
	make

%}

%start		Class_declaration

%nonassoc	TE_DOTDOT
%left		TE_IMPLIES
%left		TE_OR
%left		TE_XOR
%left		TE_AND
%left 		TE_NE TE_EQ TE_LT TE_GT TE_LE TE_GE
%left		TE_PLUS TE_MINUS
%left		TE_STAR TE_SLASH TE_MOD TE_DIV
%right		TE_POWER
%left		TE_FREE
%right		TE_NOT
%nonassoc	TE_STRIP
%left		TE_OLD
%left		TE_DOT
%right		TE_LPARAN

%token		TE_ALIAS TE_ALL TE_INTEGER TE_CHAR TE_REAL TE_STRING
%token		TE_ID TE_A_BIT TE_BANG TE_BIT TE_SEMICOLON TE_TILDE
%token		TE_COLON TE_COMMA TE_CREATE TE_CREATION TE_LARRAY TE_RARRAY TE_RPARAN
%token		TE_LCURLY TE_RCURLY TE_LSQURE TE_RSQURE TE_CONSTRAIN
%token		TE_FALSE TE_TRUE TE_ACCEPT TE_ADDRESS TE_AS TE_ASSIGN
%token		TE_CHECK TE_CLASS TE_CURRENT TE_DEBUG TE_DEFERRED TE_DO
%token		TE_ELSE TE_ELSEIF TE_END TE_ENSURE TE_EXPANDED TE_EXPORT
%token		TE_EXTERNAL TE_FEATURE TE_FROM TE_FROZEN TE_IF TE_INDEXING
%token		TE_INFIX TE_INHERIT TE_INSPECT TE_INVARIANT TE_IS
%token		TE_LIKE TE_LOCAL TE_LOOP TE_OBSOLETE TE_ONCE TE_PRECURSOR
%token		TE_AGENT
%token		TE_PREFIX TE_REDEFINE TE_RENAME TE_REQUIRE TE_RESCUE
%token		TE_RESULT TE_RETRY TE_SELECT TE_SEPARATE TE_THEN TE_UNDEFINE
%token		TE_UNIQUE TE_UNTIL TE_VARIANT TE_WHEN TE_QUESTION TE_CURLYTILDE
%token		TE_BOOLEAN_ID TE_CHARACTER_ID TE_DOUBLE_ID TE_INTEGER_ID
%token		TE_INTEGER_8_ID TE_INTEGER_16_ID TE_INTEGER_64_ID TE_WIDE_CHAR_ID
%token		TE_NONE_ID TE_POINTER_ID TE_REAL_ID TE_EMPTY_STRING
%token		TE_VERBATIM_STRING TE_EMPTY_VERBATIM_STRING

%token		TE_STR_LT TE_STR_LE TE_STR_GT TE_STR_GE TE_STR_MINUS
%token		TE_STR_PLUS TE_STR_STAR TE_STR_SLASH TE_STR_MOD
%token		TE_STR_DIV TE_STR_POWER TE_STR_AND TE_STR_AND_THEN
%token		TE_STR_IMPLIES TE_STR_OR TE_STR_OR_ELSE TE_STR_XOR
%token		TE_STR_NOT TE_STR_FREE

%type <ATOMIC_AS>			Index_value Manifest_constant
%type <BIT_CONST_AS>		Bit_constant
%type <BOOL_AS>				Boolean_constant
%type <CHAR_AS>				Character_constant
%type <ID_AS>				Identifier Index
%type <INDEX_AS>			Index_clause
%type <INTEGER_AS>			Integer_constant
%type <REAL_AS>				Real_constant
%type <STRING_AS>			Manifest_string Non_empty_string

%type <EIFFEL_LIST [ATOMIC_AS]>			Index_terms
%type <INDEXING_CLAUSE_AS>			Indexing Index_list

%expect 25

%%

-- Root rule

Class_declaration:
		Indexing
			{
				create root_node
				root_node.set_top_indexes ($1)
			};

-- Indexing

Indexing: -- Empty
		-- { $$ := Void }
	|	TE_INDEXING Index_list
			{ $$ := $2 }
	|	TE_INDEXING 
			-- { $$ := Void }
	;

Index_list: Index_clause
			{
				$$ := new_eiffel_list_index_as (Initial_index_list_size)
				$$.extend ($1)
			}
	|	Index_list Index_clause
			{
				$$ := $1
				$$.extend ($2)
			}
	;

Index_clause: Index Index_terms ASemi
			{ $$ := new_index_as ($1, $2) }
	;

Index: Identifier TE_COLON
			{ $$ := $1 }
	|	-- Empty
			-- { $$ := Void }
	;

Index_terms: Index_value
			{
				$$ := new_eiffel_list_atomic_as (Initial_index_terms_size)
				$$.extend ($1)
			}
	|	Index_terms TE_COMMA Index_value
			{
				$$ := $1
				$$.extend ($3)
			}
	|	TE_SEMICOLON
			{
-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				$$ := new_eiffel_list_atomic_as (0)
			}
	;

Index_value: Identifier
			{ $$ := $1 }
	|	Manifest_constant
			{ $$ := $1 }
	;


ASemi: -- Empty
	|	TE_SEMICOLON
	;


-- Miscellaneous
 

Identifier: TE_ID
			{ $$ := new_id_as (token_buffer) }
	|	TE_BOOLEAN_ID
			{ $$ := new_boolean_id_as }
	|	TE_CHARACTER_ID
			{ $$ := new_character_id_as (False) }
	|	TE_WIDE_CHAR_ID
			{ $$ := new_character_id_as (True) }
	|	TE_DOUBLE_ID
			{ $$ := new_double_id_as }
	|	TE_INTEGER_8_ID
			{ $$ := new_integer_id_as (8) }
	|	TE_INTEGER_16_ID
			{ $$ := new_integer_id_as (16) }
	|	TE_INTEGER_ID
			{ $$ := new_integer_id_as (32) }
	|	TE_INTEGER_64_ID
			{ $$ := new_integer_id_as (64) }
	|	TE_NONE_ID
			{ $$ := new_none_id_as }
	|	TE_POINTER_ID
			{ $$ := new_pointer_id_as }
	|	TE_REAL_ID
			{ $$ := new_real_id_as }
	;

Manifest_constant: Boolean_constant
			{ $$ := $1 }
	|	Character_constant
			{ $$ := $1 }
	|	Integer_constant
			{ $$ := $1 }
	|	Real_constant
			{ $$ := $1 }
	|	Bit_constant
			{ $$ := $1 }
	|	Manifest_string
			{ $$ := $1 }
	;

Boolean_constant: TE_FALSE
			{ $$ := new_boolean_as (False) }
	|	TE_TRUE
			{ $$ := new_boolean_as (True) }
	;

Character_constant: TE_CHAR
			{
				check is_character: not token_buffer.is_empty end
				$$ := new_character_as (token_buffer.item (1))
			}
	;

Integer_constant: TE_INTEGER
			{
				if token_buffer.is_integer then
					$$ := new_integer_as (token_buffer.to_integer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					$$ := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					$$ := new_integer_as (0)
				end
			}
	|	TE_PLUS TE_INTEGER
			{
				if token_buffer.is_integer then
					$$ := new_integer_as (token_buffer.to_integer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					$$ := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					$$ := new_integer_as (0)
				end
			}
	|	TE_MINUS TE_INTEGER
			{
				if token_buffer.is_integer then
					$$ := new_integer_as (- token_buffer.to_integer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					$$ := new_integer_as_from_hexa (token_buffer)	
				else
					token_buffer.precede ('-')
					report_integer_too_small_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					$$ := new_integer_as (0)
				end
			}
	;

Real_constant: TE_REAL
			{ $$ := new_real_as (cloned_string (token_buffer)) }
	|	TE_PLUS TE_REAL
			{ $$ := new_real_as (cloned_string (token_buffer)) }
	|	TE_MINUS TE_REAL
			{
				token_buffer.precede ('-')
				$$ := new_real_as (cloned_string (token_buffer))
			}
	;

Bit_constant: TE_A_BIT
			{ $$ := new_bit_const_as (new_id_as (token_buffer)) }
	;

Manifest_string: Non_empty_string
			{ $$ := $1 }
	|	TE_EMPTY_STRING
			{ $$ := new_empty_string_as }
	|	TE_EMPTY_VERBATIM_STRING
			{ $$ := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) }
	;

Non_empty_string: TE_STRING
			{ $$ := new_string_as (cloned_string (token_buffer)) }
	|	TE_VERBATIM_STRING
			{ $$ := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) }
	|	TE_STR_LT
			{ $$ := new_lt_string_as }
	|	TE_STR_LE
			{ $$ := new_le_string_as }
	|	TE_STR_GT
			{ $$ := new_gt_string_as }
	|	TE_STR_GE
			{ $$ := new_ge_string_as }
	|	TE_STR_MINUS
			{ $$ := new_minus_string_as }
	|	TE_STR_PLUS
			{ $$ := new_plus_string_as }
	|	TE_STR_STAR
			{ $$ := new_star_string_as }
	|	TE_STR_SLASH
			{ $$ := new_slash_string_as }
	|	TE_STR_MOD
			{ $$ := new_mod_string_as }
	|	TE_STR_DIV
			{ $$ := new_div_string_as }
	|	TE_STR_POWER
			{ $$ := new_power_string_as }
	|	TE_STR_AND
			{ $$ := new_string_as (cloned_string (token_buffer)) }
	|	TE_STR_AND_THEN
			{ $$ := new_string_as (cloned_string (token_buffer)) }
	|	TE_STR_IMPLIES
			{ $$ := new_string_as (cloned_string (token_buffer)) }
	|	TE_STR_OR
			{ $$ := new_string_as (cloned_string (token_buffer)) }
	|	TE_STR_OR_ELSE
			{ $$ := new_string_as (cloned_string (token_buffer)) }
	|	TE_STR_XOR
			{ $$ := new_string_as (cloned_string (token_buffer)) }
	|	TE_STR_NOT
			{ $$ := new_string_as (cloned_string (token_buffer)) }
	|	TE_STR_FREE
			{ $$ := new_string_as (cloned_string (token_buffer)) }
	;

%%

end -- class EIFFEL_PARSER


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
