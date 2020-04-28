%{
note
	description: "Parse type definitions from a C header file"
	status: "See notice at end of class"
	author: "Based on http://www.lysator.liu.se/c"
	date: "$Date$"
	revision: "$Revision$"
	info: "Based on http://www.lysator.liu.se/c"

class EWG_C_PARSER

inherit

	EWG_C_PARSER_SKELETON

	EWG_C_PHASE_1_AST_FACTORY

create

	make

%}

%token <STRING> TOK_IDENTIFIER
%token <STRING> TOK_CONSTANT
%token <STRING> TOK_STRING_LITERAL
%token <STRING> TOK_SIZEOF
%token <STRING> TOK_PTR_OP
%token <STRING> TOK_INC_OP
%token <STRING> TOK_DEC_OP
%token <STRING> TOK_LEFT_OP
%token <STRING> TOK_RIGHT_OP
%token <STRING> TOK_LE_OP
%token <STRING> TOK_GE_OP
%token <STRING> TOK_EQ_OP
%token <STRING> TOK_NE_OP
%token <STRING> TOK_AND_OP
%token <STRING> TOK_OR_OP
%token <STRING> TOK_MUL_ASSIGN
%token <STRING> TOK_DIV_ASSIGN
%token <STRING> TOK_MOD_ASSIGN
%token <STRING> TOK_ADD_ASSIGN
%token <STRING> TOK_SUB_ASSIGN
%token <STRING> TOK_LEFT_ASSIGN
%token <STRING> TOK_RIGHT_ASSIGN
%token <STRING> TOK_AND_ASSIGN
%token <STRING> TOK_XOR_ASSIGN
%token <STRING> TOK_OR_ASSIGN
%token <STRING> TOK_TYPE_NAME

%token <STRING> TOK_TYPEDEF
%token <STRING> TOK_EXTERN
%token <STRING> TOK_STATIC
%token <STRING> TOK_AUTO
%token <STRING> TOK_REGISTER
%token <STRING> TOK_CHAR
%token <STRING> TOK_SHORT
%token <STRING> TOK_INT
%token <STRING> TOK_LONG
%token <STRING> TOK_SIGNED
%token <STRING> TOK_UNSIGNED
%token <STRING> TOK_FLOAT
%token <STRING> TOK_DOUBLE
%token <STRING> TOK_CONST
%token <STRING> TOK_VOLATILE
%token <STRING> TOK_VOID
%token <STRING> TOK_STRUCT
%token <STRING> TOK_UNION
%token <STRING> TOK_ENUM
%token <STRING> TOK_ELLIPSIS

%token <STRING> TOK_CASE
%token <STRING> TOK_DEFAULT
%token <STRING> TOK_IF
%token <STRING> TOK_ELSE
%token <STRING> TOK_SWITCH
%token <STRING> TOK_WHILE
%token <STRING> TOK_DO
%token <STRING> TOK_FOR
%token <STRING> TOK_GOTO
%token <STRING> TOK_CONTINUE
%token <STRING> TOK_BREAK
%token <STRING> TOK_RETURN

%token <STRING> TOK_INLINE -- C99 keyword (added to original grammar)

-- VC specific
%token <STRING> TOK_CL_INT_8
%token <STRING> TOK_CL_INT_16
%token <STRING> TOK_CL_INT_32
%token <STRING> TOK_CL_INT_64
%token <STRING> TOK_CL_FASTCALL
%token <STRING> TOK_CL_BASED
%token <STRING> TOK_CL_CDECL
%token <STRING> TOK_CL_STDCALL
%token <STRING> TOK_CL_INLINE
%token <STRING> TOK_CL_ASM

%type <EWG_C_PHASE_1_DECLARATION> declaration
%type <DS_LINKED_LIST[EWG_C_PHASE_1_DECLARATOR]> init_declarator_list
%type <EWG_C_PHASE_1_DECLARATOR> init_declarator
%type <EWG_C_PHASE_1_DECLARATOR> declarator
%type <EWG_C_PHASE_1_DIRECT_DECLARATOR> direct_declarator
%type <EWG_C_PHASE_1_DECLARATOR> abstract_declarator
%type <EWG_C_PHASE_1_DIRECT_DECLARATOR> direct_abstract_declarator

%type <DS_LINKED_LIST[ANY]> declaration_specifiers
	-- ANY here should realy be one of:
	-- EWG_C_PHASE_1_TYPE_QUALIFIER
	-- EWG_C_PHASE_1_TYPE_SPECIFIER
	-- EWG_C_PHASE_1_STORAGE_CLASS_SPECIFIERS

%type <DS_LINKED_LIST[EWG_C_PHASE_1_TYPE_QUALIFIER]> type_qualifier_list

%type <DS_LINKED_LIST[ANY]> non_wrapped_declaration_specifiers
%type <EWG_C_PHASE_1_TYPE_QUALIFIER> type_qualifier
%type <EWG_C_PHASE_1_TYPE_SPECIFIER> type_specifier
%type <EWG_C_PHASE_1_TYPE_SPECIFIER> type_specifier_no_type_name
%type <EWG_C_PHASE_1_TYPE_SPECIFIER> type_specifier_type_name
%type <EWG_C_PHASE_1_STORAGE_CLASS_SPECIFIERS> storage_class_specifier
%type <EWG_C_PHASE_1_TYPE_SPECIFIER> struct_or_union_specifier

%type <BOOLEAN> struct_or_union
%type <DS_LINKED_LIST[EWG_C_PHASE_1_DECLARATION]> struct_declaration_list
%type <EWG_C_PHASE_1_DECLARATION> struct_declaration
%type <DS_LINKED_LIST[EWG_C_PHASE_1_DECLARATOR]> struct_declarator_list
%type <EWG_C_PHASE_1_DECLARATOR> struct_declarator

%type <EWG_C_PHASE_1_TYPE_SPECIFIER> enum_specifier

%type <EWG_C_PHASE_1_DECLARATION> enumerator
%type <DS_LINKED_LIST[EWG_C_PHASE_1_DECLARATION]> enumerator_list_with_opt_comma
%type <DS_LINKED_LIST[EWG_C_PHASE_1_DECLARATION]> enumerator_list
%type <DS_LINKED_LIST [ANY]> specifier_qualifier_list
	-- ANY here should realy be one of:
	-- EWG_C_PHASE_1_TYPE_QUALIFIER
	-- EWG_C_PHASE_1_TYPE_SPECIFIER

%type <DS_LINKED_LIST [ANY]> non_wrapped_specifier_qualifier_list

%type <DS_LINKED_LIST [EWG_C_PHASE_1_POINTER]> pointer

%type <EWG_C_PHASE_1_PARAMETER_TYPE_LIST> parameter_type_list
%type <DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATION]> parameter_list
%type <EWG_C_PHASE_1_DECLARATION> parameter_declaration

%type <DS_LINKED_LIST [INTEGER]> attribute_sequence
	-- Items are really constans defined in EWG_CL_ATTRIBUTE_CONSTANTS

%type <INTEGER> attribute
	-- Constans defined in EWG_CL_ATTRIBUTE_CONSTANTS


-- The following rules are of type string, because
-- we they are only used for knowing the size of arrays.
-- And for this purpose, a plain unparsed string suffices.
%type <STRING> constant_expression
%type <STRING> conditional_expression
%type <STRING> logical_or_expression
%type <STRING> expression
%type <STRING> assignment_expression
%type <STRING> logical_and_expression
%type <STRING> inclusive_or_expression
%type <STRING> exclusive_or_expression
%type <STRING> and_expression
%type <STRING> equality_expression
%type <STRING> relational_expression
%type <STRING> shift_expression
%type <STRING> additive_expression
%type <STRING> multiplicative_expression
%type <STRING> cast_expression
%type <STRING> unary_expression
%type <STRING> postfix_expression
%type <STRING> primary_expression
%type <STRING> argument_expression_list
%type <STRING> assignment_operator
%type <STRING> unary_operator
%type <STRING> type_name

%start translation_unit

%expect 1
	-- There is one shift/reduce problem in the grammar.
	-- We all know it's bad.
	-- I think this shift/reduce problem is the infamous 'dangling else' problem
	-- and is AFAIK handled by this parser as the C standard mandates.

%%
primary_expression
	: TOK_IDENTIFIER
		{
			$$ := $1
		}
	| TOK_CONSTANT
		{
			$$ := $1
		}
	| TOK_STRING_LITERAL
		{
			$$ := $1
		}
	| '(' expression ')'
		{
			$$ := $2
			$$.prepend ("(")
			$$.append_character (')')
		}
	;

postfix_expression
	: primary_expression
		{
			$$ := $1
		}
	| postfix_expression '[' expression ']'
		{
			$$ := $1
			$$.append_character ('[')
			$$.append_string ($3)
			$$.append_character (']')
		}
	| postfix_expression '(' ')'
		{
			$$ := $1
			$$.append_string ("()")
		}
	| postfix_expression '(' argument_expression_list ')'
		{
			$$ := $1
			$$.append_character ('(')
			$$.append_string ($3)
			$$.append_character (')')
		}
	| postfix_expression '.' TOK_IDENTIFIER
		{
			$$ := $1
			$$.append_character ('.')
			$$.append_string ($3)
		}
	| postfix_expression TOK_PTR_OP TOK_IDENTIFIER
		{
			$$ := $1
			$$.append_string ($2)
			$$.append_string ($3)
		}
	| postfix_expression TOK_INC_OP
		{
			$$ := $1
			$$.append_string ($2)
		}
	| postfix_expression TOK_DEC_OP
		{
			$$ := $1
			$$.append_string ($2)
		}
	;

argument_expression_list
	: assignment_expression
		{
			$$ := $1
		}
	| argument_expression_list ',' assignment_expression
		{
			$$ := $1
			$$.append_character (',')
			$$.append_string ($3)
		}
	;

unary_expression
	: postfix_expression
		{
			$$ := $1
		}
	| TOK_INC_OP unary_expression
		{
			$$ := $1
			$$.append_string ($2)
		}
	| TOK_DEC_OP unary_expression
		{
			$$ := $1
			$$.append_string ($2)
		}
	| unary_operator cast_expression
		{
			$$ := $1
			$$.append_string ($2)
		}
	| TOK_SIZEOF unary_expression
		{
			$$ := $1
			$$.append_string ($2)
		}
	| TOK_SIZEOF '(' type_name pop_type_name_scope ')'
		{
			$$ := $1
			$$.append_character ('(')
			$$.append_string ($3)
			$$.append_character (')')
		}
	;

unary_operator
	: '&'
		{
			$$ := "&"
		}
	| '*'
		{
			$$ := "*"
		}
	| '+'
		{
			$$ := "+"
		}
	| '-'
		{
			$$ := "-"
		}
	| '~'
		{
			$$ := "~"
		}
	| '!'
		{
			$$ := "!"
		}
	;

cast_expression
	: unary_expression
		{
			$$ := $1
		}
	| '(' type_name pop_type_name_scope ')' cast_expression
		{
			$$ := $2
			$$.prepend ("(")
			$$.append_character (')')
			$$.append_string ($5)
		}
	;

multiplicative_expression
	: cast_expression
		{
			$$ := $1
		}
	| multiplicative_expression '*' cast_expression
		{
			$$ := $1
			$$.append_character ('*')
			$$.append_string ($3)
		}
	| multiplicative_expression '/' cast_expression
		{
			$$ := $1
			$$.append_character ('/')
			$$.append_string ($3)
		}
	| multiplicative_expression '%' cast_expression
		{
			$$ := $1
			$$.append_character ('%%')
			$$.append_string ($3)
		}
	;

additive_expression
	: multiplicative_expression
		{
			$$ := $1
		}
	| additive_expression '+' multiplicative_expression
		{
			$$ := $1
			$$.append_character ('+')
			$$.append_string ($3)
		}
	| additive_expression '-' multiplicative_expression
		{
			$$ := $1
			$$.append_character ('-')
			$$.append_string ($3)
		}
	;

shift_expression
	: additive_expression
		{
			$$ := $1
		}
	| shift_expression TOK_LEFT_OP additive_expression
		{
			$$ := $1
			$$.append_string ($2)
			$$.append_string ($3)
		}
	| shift_expression TOK_RIGHT_OP additive_expression
		{
			$$ := $1
			$$.append_string ($2)
			$$.append_string ($3)
		}
	;

relational_expression
	: shift_expression
		{
			$$ := $1
		}
	| relational_expression '<' shift_expression
		{
			$$ := $1
			$$.append_character ('<')
			$$.append_string ($3)
		}
	| relational_expression '>' shift_expression
		{
			$$ := $1
			$$.append_character ('>')
			$$.append_string ($3)
		}
	| relational_expression TOK_LE_OP shift_expression
		{
			$$ := $1
			$$.append_string ($2)
			$$.append_string ($3)
		}
	| relational_expression TOK_GE_OP shift_expression
		{
			$$ := $1
			$$.append_string ($2)
			$$.append_string ($3)
		}
	;

equality_expression
	: relational_expression
		{
			$$ := $1
		}
	| equality_expression TOK_EQ_OP relational_expression
		{
			$$ := $1
			$$.append_string ($2)
			$$.append_string ($3)
		}
	| equality_expression TOK_NE_OP relational_expression
		{
			$$ := $1
			$$.append_string ($2)
			$$.append_string ($3)
		}
	;

and_expression
	: equality_expression
		{
			$$ := $1
		}
	| and_expression '&' equality_expression
		{
			$$ := $1
			$$.append_character ('&')
			$$.append_string ($3)
		}
	;

exclusive_or_expression
	: and_expression
		{
			$$ := $1
		}
	| exclusive_or_expression '^' and_expression
		{
			$$ := $1
			$$.append_character ('^')
			$$.append_string ($3)
		}
	;

inclusive_or_expression
	: exclusive_or_expression
		{
			$$ := $1
		}
	| inclusive_or_expression '|' exclusive_or_expression
		{
			$$ := $1
			$$.append_character ('|')
			$$.append_string ($3)
		}
	;

logical_and_expression
	: inclusive_or_expression
		{
			$$ := $1
		}
	| logical_and_expression TOK_AND_OP inclusive_or_expression
		{
			$$ := $1
			$$.append_string ($2)
			$$.append_string ($3)
		}
	;

logical_or_expression
	: logical_and_expression
		{
			$$ := $1
		}
	| logical_or_expression TOK_OR_OP logical_and_expression
		{
			$$ := $1
			$$.append_string ($2)
			$$.append_string ($3)
		}
	;

conditional_expression
	: logical_or_expression
		{
			$$ := $1
		}
	| logical_or_expression '?' expression ':' conditional_expression
		{
			$$ := $1
			$$.append_character ('?')
			$$.append_string ($3)
			$$.append_character (':')
			$$.append_string ($3)
		}
	;

assignment_expression
	: conditional_expression
		{
			$$ := $1
		}
	| unary_expression assignment_operator assignment_expression
		{
			$$ := $1
			$$.append_string ($2)
			$$.append_string ($3)
		}
	;

assignment_operator
	: '='
		{
			$$ := "="
		}
	| TOK_MUL_ASSIGN
		{
			$$ := $1
		}
	| TOK_DIV_ASSIGN
		{
			$$ := $1
		}
	| TOK_MOD_ASSIGN
		{
			$$ := $1
		}
	| TOK_ADD_ASSIGN
		{
			$$ := $1
		}
	| TOK_SUB_ASSIGN
		{
			$$ := $1
		}
	| TOK_LEFT_ASSIGN
		{
			$$ := $1
		}
	| TOK_RIGHT_ASSIGN
		{
			$$ := $1
		}
	| TOK_AND_ASSIGN
		{
			$$ := $1
		}
	| TOK_XOR_ASSIGN
		{
			$$ := $1
		}
	| TOK_OR_ASSIGN
		{
			$$ := $1
		}
	;

expression
	: assignment_expression
		{
			$$ := $1
		}
	| expression ',' assignment_expression
		{
			$$ := $1
			$$.append_character (',')
			$$.append_string ($3)
		}
	;

constant_expression
	: conditional_expression
		{
			$$ := $1
		}
	;

	-- MS extension for extra function calling conventions
attribute_sequence
	: attribute
		{ create $$.make; $$.put_last ($1) }
	| attribute attribute_sequence
		{ $$ := $2; $$.put_last ($1) }
	;

	-- MS extension for extra function calling conventions
attribute
	: TOK_CL_ASM
		{ $$ := cl_attribute_asm }
	| TOK_CL_FASTCALL
		{ $$ := cl_attribute_fastcall }
	| TOK_CL_BASED
		{ $$ := cl_attribute_based }
	| TOK_CL_INLINE
		{ $$ := cl_attribute_inline }
	| TOK_CL_CDECL
		{ $$ := cl_attribute_cdecl }
	| TOK_CL_STDCALL
		{ $$ := cl_attribute_stdcall }
	;

declaration
	: declaration_specifiers pop_type_name_scope ';'
		{
			create $$.make ($1, new_declarator_list, last_header_file_name)
			add_top_level_declaration ($$)
		}
	| declaration_specifiers init_declarator_list pop_type_name_scope ';'
		{
			update_type_names ($1, $2)
			create $$.make ($1, $2, last_header_file_name)
			add_top_level_declaration ($$)
		}
	;

declaration_specifiers
	: push_reporting_type_name_scope non_wrapped_declaration_specifiers
		{ $$ := $2 }
	| attribute_sequence push_reporting_type_name_scope non_wrapped_declaration_specifiers
		-- VC specific
		-- I think calling conventions specifie at this position via `attribute_sequence'
		-- are ignored.
		{ $$ := $3 }
	;

non_wrapped_declaration_specifiers
	: storage_class_specifier
		{ create $$.make; $$.put_last ($1) }
	| storage_class_specifier non_wrapped_declaration_specifiers
		{ $$ := $2; $$.put_first ($1) }
	| type_specifier
		{ create $$.make; $$.put_last ($1) }
	| type_specifier non_wrapped_declaration_specifiers
		{ $$ := $2; $$.put_first ($1) }
	| type_qualifier
		{ create $$.make; $$.put_last ($1) }
	| type_qualifier non_wrapped_declaration_specifiers
		{ $$ := $2; $$.put_first ($1) }
	;

init_declarator_list
	: init_declarator
		{ create $$.make; $$.put_last ($1) }
	| init_declarator_list ',' init_declarator
		{ $1.put_last ($3); $$ := $1 }
	;

init_declarator
	: declarator
		{ $$ := $1 }
	| declarator '=' initializer
		{ $$ := $1 }
	;

storage_class_specifier
	: TOK_TYPEDEF
		{ create $$.make; $$.set_typedef }
	| TOK_EXTERN
		{ create $$.make; $$.set_extern }
	| TOK_STATIC
		{ create $$.make; $$.set_static }
	| TOK_AUTO
		{ create $$.make; $$.set_auto }
	| TOK_REGISTER
		{ create $$.make; $$.set_register }
	| TOK_INLINE
		{ create $$.make; $$.set_inline }
	;

type_specifier
	: disable_type_name_reporting_for_this_scope type_specifier_no_type_name
		{ $$ := $2 }
	| disable_type_name_reporting_for_this_scope type_specifier_type_name
		{ $$ := $2 }
	;

type_specifier_no_type_name
	: TOK_VOID
		{ create $$.make ($1) }
	| TOK_CHAR
		{ create $$.make ($1) }
	| TOK_SHORT
		{ create $$.make ($1) }
	| TOK_INT
		{ create $$.make ($1) }
	| TOK_CL_INT_8
		{ create $$.make ($1) }
	| TOK_CL_INT_16
		{ create $$.make ($1) }
	| TOK_CL_INT_32
		{ create $$.make ($1) }
	| TOK_CL_INT_64
		{ create $$.make ($1) }
	| TOK_LONG
		{ create $$.make ($1) }
	| TOK_FLOAT
		{ create $$.make ($1) }
	| TOK_DOUBLE
		{ create $$.make ($1) }
	| TOK_SIGNED
		{ create $$.make ($1) }
	| TOK_UNSIGNED
		{ create $$.make ($1) }
	;

type_specifier_type_name
	: struct_or_union_specifier
		{ $$ := $1 }
	| enum_specifier
		{ $$ := $1 }
	| TOK_TYPE_NAME
		{ create $$.make ($1) }
	;

struct_or_union_specifier
	: struct_or_union TOK_IDENTIFIER push_reporting_type_name_scope '{' struct_declaration_list pop_type_name_scope '}'
		{ if $1 then
			create $$.make_struct ($2, $5)
		  else
			create $$.make_union ($2, $5)
		  end
		}
	| struct_or_union push_reporting_type_name_scope '{' struct_declaration_list pop_type_name_scope '}'
		{ if $1 then
			create $$.make_struct (Void, $4)
		  else
			create $$.make_union (Void, $4)
		  end
		}
	| struct_or_union TOK_IDENTIFIER
		{ if $1 then
			create $$.make_struct ($2, Void)
		  else
			create $$.make_union ($2, Void)
		  end
		}
	| struct_or_union TOK_TYPE_NAME	-- NOTE: workaround for _IO_FILE problem
		{ if $1 then
			create $$.make_struct ($2, Void)
		  else
			create $$.make_union ($2, Void)
		  end
		}
	;

struct_or_union
	: TOK_STRUCT
		{ $$ := True }
	| TOK_UNION
		{ $$ := False }
	;

struct_declaration_list
	: struct_declaration
		{ create $$.make; $$.put_last ($1) }
	| struct_declaration_list struct_declaration
		{ $1.put_last ($2); $$ := $1 }
	;

struct_declaration
	: specifier_qualifier_list struct_declarator_list pop_type_name_scope ';'
		{ create $$.make ($1, $2, last_header_file_name) }
	| specifier_qualifier_list  pop_type_name_scope ';'
		{ create $$.make_without_declarator ($1, last_header_file_name) }
			-- NOTE: This is a non ANSI C extension.
			--       It is needed to parse the VC extension of anonymous struct
			--  	  members of type struct/enum/union.
			--       At least cl and gcc support it.
	;


specifier_qualifier_list
	: push_reporting_type_name_scope non_wrapped_specifier_qualifier_list
		{ $$ := $2 }
	;
non_wrapped_specifier_qualifier_list
	: type_specifier non_wrapped_specifier_qualifier_list
		{ $$ := $2; $$.put_first ($1) }
	| type_specifier
		{ create $$.make; $$.put_last ($1) }
	| type_qualifier non_wrapped_specifier_qualifier_list
		{ $$ := $2; $$.put_first ($1) }
	| type_qualifier
		{ create $$.make; $$.put_last ($1) }
	;

struct_declarator_list
		-- NOTE: Because 'struct_declarator' can return `Void',
		-- we need some 'if's here.
	: struct_declarator
		{
			create $$.make
			if $1 /= Void then
				$$.put_last ($1)
			end
		}
	| struct_declarator_list ',' struct_declarator
		{
			$$ := $1
			if $3 /= Void then
				$1.put_last ($3)
			end
		}
	;

struct_declarator
	: declarator
		{ $$ := $1 }
	| ':' constant_expression
		-- NOTE: I have no idea what I should do with that.
		-- It is meant to specify padding in the struct.
		-- We don't need this information.
		-- Leaving it `Void', rules who use this rule need to deal with it.
		{ create $$.make_default}
	| declarator ':' constant_expression
		{ $$ := $1 }
	;

enum_specifier
	: TOK_ENUM '{' enumerator_list_with_opt_comma '}'
		{ create $$.make_enum (Void, $3) }
	| TOK_ENUM TOK_IDENTIFIER '{' enumerator_list_with_opt_comma '}'
		{ create $$.make_enum ($2, $4) }
	| TOK_ENUM TOK_IDENTIFIER
		{ create $$.make_enum ($2, Void) }
	;

enumerator_list_with_opt_comma
		-- NOTE: The `opt_coma' is not allowed in ANSI C,
		-- but is accepted by cl.
	: enumerator_list opt_comma
		{ $$ := $1 }
	;

enumerator_list
	: enumerator
		{ create $$.make; $$.put_last ($1) }
	| enumerator_list ',' enumerator
		{ $1.put_last ($3); $$ := $1 }
	;

opt_comma
	: -- Empty
	| ','
	;

enumerator
	: TOK_IDENTIFIER
		{ $$ := new_enum_declaration ($1, last_header_file_name) }
	| TOK_IDENTIFIER '=' constant_expression
		{ $$ := new_enum_declaration ($1, last_header_file_name) }
	;

type_qualifier
	: TOK_CONST
		{ create $$.make; $$.set_const }
	| TOK_VOLATILE
		{ create $$.make; $$.set_volatile }
	;

declarator
	: pointer direct_declarator
		{ create $$.make_with_pointers ($2, $1, last_header_file_name)}
	| direct_declarator
		{ create $$.make ($1, last_header_file_name)}
	| pointer attribute_sequence direct_declarator
			-- VC specific
		{
			create $$.make_with_pointers ($3, $1, last_header_file_name)
			$$.direct_declarator.set_calling_convention_from_attribute_sequence ($2)
		}
	| attribute_sequence pointer direct_declarator
			-- VC specific
		{
		  create $$.make_with_pointers ($3, $2, last_header_file_name)
		  $$.direct_declarator.set_calling_convention_from_attribute_sequence ($1)
		}
	| attribute_sequence direct_declarator
			-- VC specific
		{
			create $$.make ($2, last_header_file_name)
			$$.direct_declarator.set_calling_convention_from_attribute_sequence ($1)
		}
	;

direct_declarator
	: TOK_IDENTIFIER
		{ create $$.make ($1)}
	| '(' declarator ')'
		{ create $$.make_anonymous ($2) }
	| direct_declarator push_reporting_type_name_scope '[' constant_expression pop_type_name_scope ']'
			-- NOTE: Here we could also determine the array size,
			-- but I don't think we need it.
		{ $$ := $1; $$.add_array_last (new_array_with_size ($4)); }
	| direct_declarator push_reporting_type_name_scope '[' pop_type_name_scope ']'
		{ $$ := $1; $$.add_array_last (new_array) }
	| direct_declarator push_reporting_type_name_scope '(' parameter_type_list pop_type_name_scope ')'
		{ $$ := $1; $$.set_parameters ($4) }
	| direct_declarator push_reporting_type_name_scope '(' identifier_list pop_type_name_scope ')' -- old style
		{ $$ := $1; $$.set_parameters (new_empty_elipsis_parameter_type_list) } -- TODO
	| direct_declarator push_reporting_type_name_scope '(' pop_type_name_scope ')'
		{ $$ := $1; $$.set_parameters (new_empty_elipsis_parameter_type_list) }
	;

pointer
	: '*'
		{ create $$.make; $$.put_last (new_pointer) }
	| '*' type_qualifier_list
		{ create $$.make; $$.put_last (new_pointer_with_type_qualifier_list ($2)) }
	| '*' pointer
		{  $$ := $2; $$.put_first (new_pointer) }
	| '*' type_qualifier_list pointer
		{  $$ := $3; $$.put_first (new_pointer_with_type_qualifier_list ($2)) }
	;

type_qualifier_list
	: type_qualifier
		{ create $$.make; $$.put_last ($1) }
	| type_qualifier_list type_qualifier
		{ $$ := $1; $$.put_last ($2) }
	;

parameter_type_list
	: parameter_list
		{ create $$.make ($1) }
	| parameter_list ',' TOK_ELLIPSIS
		{ create $$.make_with_ellipsis ($1) }
	;

parameter_list
	: parameter_declaration
		{
			create $$.make
			check
				every_parameter_has_exactly_one_name: $1.declarators.count = 1 or
										(attached $1.type_specifier as l_type_specifier and then  l_type_specifier.is_void)
			end
			$$.put_last ($1)
		}
	| parameter_list ',' parameter_declaration
		{
			$$ := $1
			check
				every_parameter_has_exactly_one_name: $3.declarators.count = 1
			end
			$$.put_last ($3)
		}
	;

parameter_declaration
	: declaration_specifiers declarator pop_type_name_scope
		{ create $$.make_with_one_declarator ($1, $2, last_header_file_name) }
	| declaration_specifiers abstract_declarator pop_type_name_scope
		{ create $$.make_with_one_declarator ($1, $2, last_header_file_name) }
	| declaration_specifiers pop_type_name_scope
		{ create $$.make_with_one_declarator ($1, new_abstract_declarator (last_header_file_name), last_header_file_name) }
	;

identifier_list
	: TOK_IDENTIFIER
	| identifier_list ',' TOK_IDENTIFIER
	;

type_name
	: specifier_qualifier_list
		{
			$$ := c_code_from_specifier_qualifier_list ($1)
		}
	| specifier_qualifier_list abstract_declarator
		{
			$$ := c_code_from_specifier_qualifier_list ($1)
			$$.append_string ($2.c_code)
		}
	;

-- with ms attr seq support
abstract_declarator
	: pointer
		{
			create $$.make_with_pointers (new_direct_abstract_declarator,
							$1, last_header_file_name)
		}
	| direct_abstract_declarator
		{
			create $$.make ($1, last_header_file_name)
		}
	| pointer direct_abstract_declarator
		{
			create $$.make_with_pointers ($2, $1, last_header_file_name)
		}
	| pointer attribute_sequence direct_abstract_declarator
			-- VC specific
		{
			create $$.make_with_pointers ($3, $1, last_header_file_name)
			$3.set_calling_convention_from_attribute_sequence ($2)
		}
	| attribute_sequence pointer direct_abstract_declarator
			-- VC specific
		{
			create $$.make_with_pointers ($3, $2, last_header_file_name)
			$3.set_calling_convention_from_attribute_sequence ($1)
		}
	| attribute_sequence direct_abstract_declarator
			-- VC specific
		{
			create $$.make ($2, last_header_file_name)
			$2.set_calling_convention_from_attribute_sequence ($1)
		}
	| attribute_sequence pointer
			-- VC specific
		{
			create $$.make_with_pointers (new_direct_abstract_declarator,
								 $2, last_header_file_name)
		}
		;

direct_abstract_declarator
	: '(' abstract_declarator ')'
		{
			create $$.make_anonymous ($2)
			check
				is_abstract: $$.is_abstract
			end
		}
	| push_reporting_type_name_scope '[' pop_type_name_scope ']'
		{
			create $$.make_abstract
			$$.add_array_last (new_array)
		}
	| push_reporting_type_name_scope '[' constant_expression pop_type_name_scope ']'
			-- NOTE: Here we could also determine the array size,
			-- but I don't think we need it.
		{
			create $$.make_abstract
			$$.add_array_last (new_array_with_size ($3))
		}
	| direct_abstract_declarator push_reporting_type_name_scope '[' pop_type_name_scope ']'
		{
			$$ := $1
			$$.add_array_last (new_array)
		}
	| direct_abstract_declarator push_reporting_type_name_scope '[' constant_expression pop_type_name_scope ']'
		{
			$$ := $1
			$$.add_array_last (new_array_with_size ($4))
		}
	| '(' ')'
		{
			create $$.make_abstract
			$$.set_parameters (new_empty_elipsis_parameter_type_list)
		}
	| '(' parameter_type_list ')'
		{
			create $$.make_abstract
			$$.set_parameters ($2)
		}
	| direct_abstract_declarator push_reporting_type_name_scope '(' pop_type_name_scope ')'
		{
			$$ := $1
			$$.set_parameters (new_empty_elipsis_parameter_type_list)
		}
	| direct_abstract_declarator push_reporting_type_name_scope '(' parameter_type_list pop_type_name_scope ')'
		{
			$$ := $1
			$$.set_parameters ($4)
		}
	;

initializer
	: assignment_expression
	| '{' initializer_list '}'
	| '{' initializer_list ',' '}'
	;

initializer_list
	: initializer
	| initializer_list ',' initializer
	;

compound_statement
	: '{' '}'
		-- NOTE:Compound statements are eaten by the scanner
		-- They are not relevant for ewg and simplify parsing.
	;

declaration_list
	: declaration
	| declaration_list declaration
	;

translation_unit
	: external_declaration
	| translation_unit external_declaration
	;


external_declaration
	: function_definition
	| declaration
	;

function_definition -- TODO: make function declaration available to parent rule
	: declaration_specifiers declarator pop_type_name_scope declaration_list {enable_implementation_mode} compound_statement {disable_implementation_mode}
	| declaration_specifiers declarator pop_type_name_scope {enable_implementation_mode} compound_statement {disable_implementation_mode}
	| declarator declaration_list {enable_implementation_mode} compound_statement {disable_implementation_mode}
	| declarator {enable_implementation_mode} compound_statement {disable_implementation_mode}
	;

--
-- Empty rules with side effects to create lexical tie-ins
--

push_reporting_type_name_scope
	: -- empty
		{
			push_reporting_type_name_scope
		}
	;

disable_type_name_reporting_for_this_scope
	: -- empty
		{
			if type_name_scope_stack.count > 0 then
				disable_type_name_reporting_for_this_scope
			else
				-- We do need to disable type name
				-- reporting in the global scope
				-- because there is no TOK_TYPE_NAME / TOK_IDENTIFIER
				-- ambiguity in the global scope.
			end
		}
	;

pop_type_name_scope
	: -- empty
		{
			pop_type_name_scope
		}
	;

%%

feature

end
