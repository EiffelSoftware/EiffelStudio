/*

 #####     ##    #####    ####   ######  #####            #   #
 #    #   #  #   #    #  #       #       #    #            # #
 #    #  #    #  #    #   ####   #####   #    #             #
 #####   ######  #####        #  #       #####    ###       #
 #       #    #  #   #   #    #  #       #   #    ###       #
 #       #    #  #    #   ####   ######  #    #   ###       #

		Eiffel Yacc grammar
*/
%{
#include "eiffel_c.h"
#include <stdio.h>

#define NORMAL_LEVEL	0
#define ASSERT_LEVEL	1
#define INVARIANT_LEVEL	2
#define SET_POS(x) yacc_position = x->start_position; yacc_line_number = x->line_number

#ifndef FALSE
#define FALSE 0
#endif
#ifndef TRUE
#define TRUE 1
#endif
#ifndef NULL
#define NULL 0
#endif

extern char token_str[];
int fclause_pos;	/* To memorize the beginning of a feature clause */
int fbody_pos;		/* To memorize the beginning of a feature body */

#define CR_EMPTY	0
#define CR_ROUTINE	1
#define CR_CONSTANT	2

%}

%union {
	char *node;

	int32 value;

	struct location *loc;

	struct cr_struct {		/* Structure used for resolving conflicts on
							 * feature declaration body 
							 */
		char *cr_node;		/* either node ROUTINE_AS or CONSTANT_AS */
		int cr_type;		/* either CR_ROUTINE  or CR_CONSTANT */
	} cr_node;
}

%start		Class_declaration

%nonassoc	TE_DOTDOT
%left		TE_IMPLIES
%left		TE_OR
%left		TE_XOR
%left		TE_AND
/* %nonassoc	TE_NE TE_EQ TE_LT TE_GT TE_LE TE_GE; */
/* I'm not convinced of this */
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

%token 		TE_ALIAS
%token		TE_ALL
%token		TE_INTEGER
%token		TE_CHAR
%token		TE_REAL
%token		TE_STRING
%token		TE_ID
%token		TE_A_BIT
%token		TE_BANG
%token		TE_BIT
%token		TE_SEMICOLON
%token		TE_TILDE
%token		TE_COLON
%token		TE_COMMA
%token 		TE_CREATION
%token		TE_LARRAY
%token		TE_RARRAY
%token		TE_LTUPLE
%token		TE_RTUPLE
%token 		TE_RPARAN
%token		TE_LCURLY
%token		TE_RCURLY
%token		TE_LSQURE
%token		TE_RSQURE
%token		TE_CONSTRAIN
%token		TE_FALSE TE_TRUE
%token		TE_ACCEPT
%token		TE_ADDRESS
%token		TE_AS
%token		TE_ASSIGN
%token		TE_CHECK
%token		TE_CLASS
%token		TE_CURRENT
%token		TE_DEBUG
%token		TE_DEFERRED
%token		TE_DO
%token		TE_ELSE
%token		TE_ELSEIF
%token		TE_END
%token		TE_ENSURE
%token		TE_EXPANDED
%token		TE_EXPORT
%token		TE_EXTERNAL
%token		TE_FEATURE
%token		TE_FROM
%token		TE_FROZEN
%token		TE_IF
%token		TE_INDEXING
%token		TE_IN_END
%token		TE_INFIX
%token		TE_INHERIT
%token		TE_INSPECT
%token		TE_INVARIANT
%token		TE_IS
%token		TE_LIKE
%token		TE_LOCAL
%token		TE_LOOP
%token		TE_OBSOLETE
%token		TE_ONCE
%token		TE_PRECURSOR
%token		TE_PREFIX
%token		TE_REDEFINE
%token		TE_RENAME
%token		TE_REQUIRE
%token		TE_RESCUE
%token		TE_RESULT
%token		TE_RETRY
%token		TE_SELECT
%token		TE_SEPARATE
%token		TE_SIGNATURE
%token		TE_THEN
%token		TE_UNDEFINE
%token		TE_UNIQUE
%token		TE_UNTIL
%token		TE_VARIANT
%token		TE_WHEN

%token		EIF_ERROR2
%token		EIF_ERROR3
%token		EIF_ERROR4
%token		EIF_ERROR5
%token		EIF_ERROR6
%token		EIF_ERROR7


%type <node> Class_declaration Indexing Index Index_clause Identifier Index_value
Manifest_constant Boolean_constant Character_constant Integer_constant
Real_constant Bit_constant Non_empty_string Manifest_string Obsolete Feature_clause
Feature_clause_list
Clients Feature_declaration
Declaration_body Inheritance Parent Rename New_exports New_export_item
Feature_set Undefine Redefine Select Formal_arguments Type_mark
Routine Routine_body External External_language
External_name Internal Local_declarations Precondition
Instruction 
Postcondition Assertion_clause Type Class_type Existing_generics
Actual_generics
Formal_generics Formal_generic Constraint Creation_constraint Conditional Elsif Elsif_part
Else_part When_part Multi_branch Loop Invariant Variant Debug Debug_keys
Retry Rescue Assignment Reverse_assignment Creators Creation_clause
Creation Creation_type Creation_target Creation_call Creation_expression
Routine_creation Expression Actual_parameter
Manifest_array Manifest_tuple Choice Features Rename_pair
Entity_declaration_group Call Check Assertion A_feature Call_on_result
Call_on_current Call_on_feature Feature_call Remote_call Parameters
Expression_constant Client_list
Call_on_feature_access Feature_access Class_invariant Free_operator
Call_on_expression Inspect_default
Call_on_precursor A_precursor 

%type <loc> Set_position

%type <value> Sign Pushing_id Feature_name Infix_operator Prefix_operator Infix Prefix
New_feature New_feature_list

%type <cr_node> Feature_value Constant_or_routine

%%


/*
 * Root rule
 */

Class_declaration:
	Indexing Header_mark {click_list_init();yacc_error_code=1; } TE_CLASS Pushing_id
	Formal_generics Obsolete Inheritance Creators Features Class_invariant TE_END
		{
			/* node is set at the Eiffel level for root class */
			rn_ast = create_class(click_list_elem ($<value>5),deferred,expanded,separate,$1,$6,$7,$8,$9,$10,$11,click_list_new(), current_location->start_position);
			yacc_error_code=2; 
		}
	;

Pushing_id:
		TE_ID
		{
		yacc_error_code=4; 
		$$ = click_list_push ();
		click_list_set (create_id (token_str), $$);
		}
	;

/*
 * Indexing
 */

Indexing:				/* empty */
							{$$ = NULL; yacc_error_code=5; }	
	|					TE_INDEXING {list_init();yacc_error_code=6; } Index_list
							{$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=7; }
	|					TE_INDEXING 
							{$$ = NULL;yacc_error_code=8; }
	;

Index_list:				Index_clause
							{list_push($1);yacc_error_code=9; }
	|					Index_list Index_clause
							{list_push($2);yacc_error_code=10; }
	;

Index_clause:			Index {list_init();yacc_error_code=11; } Index_terms ASemi
							{$$ = create_node2(INDEX_AS,$1,list_new(CONSTRUCT_LIST_AS));yacc_error_code=12; }
	;

Index:					Identifier TE_COLON
							{$$ = $1;yacc_error_code=13;}
	|					  
							{$$ = NULL;yacc_error_code=14;}
	;

Index_terms:			Index_value
							{list_push($1);yacc_error_code=15;}
	|					Index_terms TE_COMMA Index_value
							{list_push($3);yacc_error_code=16;}
	|					TE_SEMICOLON
	;

Index_value:			Identifier
							{$$ = $1;yacc_error_code=17;}
	|					Manifest_constant
							{$$ = $1;yacc_error_code=18;}
	;

/*
 * header mark
 */

Header_mark:			/* empty */
							{deferred = FALSE; expanded = FALSE; separate = FALSE;yacc_error_code=19;}
	|					TE_DEFERRED
							{deferred = TRUE; expanded = FALSE; separate = FALSE;yacc_error_code=20;}
	|					TE_EXPANDED
							{expanded = TRUE; deferred = FALSE; separate = FALSE;yacc_error_code=21;}
	|					TE_SEPARATE
							{expanded = FALSE; deferred = FALSE; separate = TRUE;yacc_error_code=22;}
	;


/*
 * obsolete
 */

Obsolete:				/* empty */
							{$$ = NULL;yacc_error_code=23;}
	|					TE_OBSOLETE Manifest_string
							{$$ = $2;yacc_error_code=24;}
	;

/*
 * features
 */


Features:
	{$$ = NULL;yacc_error_code=25;}
	| {list_init();yacc_error_code=26;} Feature_clause_list
		{$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=27;}
	;

Feature_clause_list:
	Feature_clause
		{list_push($1); yacc_error_code=28;}
	| Feature_clause_list Feature_clause
		{list_push($2);yacc_error_code=29;}
	;

Feature_clause:
	TE_FEATURE {fclause_pos = current_location->end_position;yacc_error_code=30;} Clients {list_init();yacc_error_code=31;} Feature_declaration_list
		{
		$$ = list_new(CONSTRUCT_LIST_AS);
		$$ = ($$ == NULL)?NULL:create_fclause_as($3,$$,fclause_pos);
		yacc_error_code=32;}
	;


Clients: /* empty */	
			{$$ = NULL;yacc_error_code=33;}
	|	 Client_list
			{
			$$ = create_node1(CLIENT_AS,$1);
			yacc_error_code=34;}
	;

Client_list:			TE_LCURLY TE_RCURLY
							{	list_init();
								list_push(create_id("none"));
								$$ = list_new(CONSTRUCT_LIST_AS);
							yacc_error_code=35;}
	|					TE_LCURLY {list_init();yacc_error_code=36;} Class_list TE_RCURLY
							{$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=37;}
	;

Class_list:				Identifier
							{
							list_push($1);
							yacc_error_code=38;}
	|					Class_list TE_COMMA Identifier
							{
							list_push($3);
							yacc_error_code=39;}
	;

Feature_declaration_list:	/* empty */
	|						Feature_declaration_list Feature_declaration
								{list_push($2);yacc_error_code=40;}
	;

ASemi:	/* empty */
	|	TE_SEMICOLON
	;

Feature_declaration:
	{list_init();yacc_error_code=41;} New_feature_list {$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=42;} Declaration_body ASemi
		{
		$$ = create_feature_as($<node>3,$4,click_list_start($<value>2),current_location->start_position);
		click_list_set ($$, $<value>2);
		yacc_error_code=43;}
	;

New_feature_list:
	New_feature
		{
		$$ = $<value>1;
		list_push(click_list_elem($$));
		yacc_error_code=44;}
	| New_feature_list TE_COMMA New_feature
		{
		$$ = $<value>1;
		list_push(click_list_elem($<value>3));
		yacc_error_code=45;}
	;

New_feature:
	Feature_name_mark Feature_name
		{
		$$ = $<value>2;
		yacc_error_code=46;}
	;

Feature_name_mark:
		{
		is_frozen = FALSE;
		yacc_error_code=47;
		}
	| TE_FROZEN
		{
		is_frozen = TRUE;
		yacc_error_code=48;
		}
	;

Feature_name:
	Pushing_id
		{
		$$ = $<value>1;
		click_list_set (create_feature_name(FEAT_NAME_ID_AS,click_list_elem($$),is_frozen), $$);
		yacc_error_code=49;}
	| Infix
		{
		$$ = $<value>1;
		yacc_error_code=50;}
	| Prefix
		{
		$$ = $<value>1;
		yacc_error_code=51;}
	;

Infix:
	TE_INFIX Infix_operator
		{
		$$ = $<value>2;
		click_list_set (create_feature_name(INFIX_AS,click_list_elem($$),is_frozen), $$);
		yacc_error_code=52;}
	;


Prefix:
	TE_PREFIX Prefix_operator
		{
		$$ = $<value>2;
		click_list_set (create_feature_name(PREFIX_AS,click_list_elem($$),is_frozen), $$);
		yacc_error_code=53;}
	;

Infix_operator:
	Manifest_string
		{
		extern int is_infix(char *s);

		$$ = click_list_push ();
		click_list_set ($1, $$);

		if (0 == is_infix(token_str))	/* Check infixed declaration */
			yyerror((char *) 0);
		yacc_error_code=54;}
	;

Prefix_operator:
	Manifest_string
		{
		extern int is_prefix(char *s);

		$$ = click_list_push ();
		click_list_set ($1, $$);

		if (0 == is_prefix(token_str))	/* Check prefixed declaration */
			yyerror((char *) 0);
		yacc_error_code=55;}
	;

Declaration_body:		Formal_arguments Type_mark Constant_or_routine
							{$$ = create_node3(BODY_AS,$1,$2,$3.cr_node);
	/* Validity test for feature declaration */
		if 	(
			/* either arguments or type or body */
			(($1 == NULL) && ($2 == NULL) && ($3.cr_node == NULL))
			||
			/* constant implies no argument but type */
			(($3.cr_type == CR_CONSTANT) && (($1 != NULL) || ($2 == NULL)))
			||
			/* arguments implies non-void routine */
			(($1 != NULL) && (($3.cr_type != CR_ROUTINE) || ($3.cr_node == NULL)))
			)
		{
			yyerror((char *) 0);
		}
	yacc_error_code=56;}
	;


Constant_or_routine:	/* empty */
							{$$.cr_node = NULL; $$.cr_type = CR_EMPTY;yacc_error_code=57;}
	|					TE_IS Feature_value
							{$$.cr_node = $2.cr_node;$$.cr_type = $2.cr_type;yacc_error_code=58;}
	;

Feature_value:			Manifest_constant
					{$$.cr_node = create_node1(CONSTANT_AS,create_node1(VALUE_AS,$1));$$.cr_type = CR_CONSTANT;yacc_error_code=59;}
	|					TE_UNIQUE
					{$$.cr_node = create_node1(CONSTANT_AS,create_node1(VALUE_AS,create_node(UNIQUE_AS)));$$.cr_type = CR_CONSTANT;yacc_error_code=60;}
	|					Routine
							{$$.cr_node = $1;$$.cr_type = CR_ROUTINE;yacc_error_code=61;}
	;


/*
 * inheritance
 */

Inheritance:
	/* empty */
		{$$ = NULL;yacc_error_code=62;}
	| TE_INHERIT {list_init();yacc_error_code=63;} Parent_list 
		{
		$$ = list_new(CONSTRUCT_LIST_AS);
		yacc_error_code=64;}
	| TE_INHERIT ASemi
		{ $$ = NULL;yacc_error_code=65;}
	;

Parent_list:
    Parent ASemi
		{list_push($1);yacc_error_code=66;}
 	| Parent_list Parent ASemi
		{list_push($2);yacc_error_code=67;} 
	;

Parent: 
	 Pushing_id Actual_generics
		{
		rn_ast = create_node2(CLASS_TYPE_AS,click_list_elem($<value>1),$2);
		$$ = create_node6(PARENT_AS,rn_ast,NULL,NULL,NULL,NULL,NULL);
		click_list_set (rn_ast, $<value>1);
		yacc_error_code=68;}
	| Pushing_id Actual_generics TE_END
		{
		inherit_context = 1;
		rn_ast = create_node2(CLASS_TYPE_AS,click_list_elem($<value>1),$2);
		$$ = create_node6(PARENT_AS,rn_ast,NULL,NULL,NULL,NULL,NULL);
		click_list_set (rn_ast, $<value>1);
		yacc_error_code=69;}
	| Pushing_id Actual_generics Rename New_exports Undefine Redefine Select TE_END
		{
		inherit_context = ($3==NULL)&&($4==NULL)&&($5==NULL)&&($6==NULL)&&($7==NULL);
		rn_ast = create_node2(CLASS_TYPE_AS,click_list_elem($<value>1),$2);
		$$ = create_node6(PARENT_AS,rn_ast,$3,$4,$5,$6,$7);
		click_list_set (rn_ast, $<value>1);
		yacc_error_code=70;}
	;

Actual_generics:
	{$$ = NULL;yacc_error_code=71;}
	| Existing_generics
		{$$ = $1;yacc_error_code=72;}
	;

Rename:
		{$$ = NULL;yacc_error_code=73;}
	| TE_RENAME
		{$$ = NULL;yacc_error_code=74;}
	| TE_RENAME {list_init();yacc_error_code=75;} Rename_list
		{$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=76;}
	;

Rename_list:
	Rename_pair
		{list_push($1);yacc_error_code=77;}
	| Rename_list TE_COMMA Rename_pair
		{list_push($3);yacc_error_code=78;}
	;

Rename_pair:
	Feature_name TE_AS Feature_name
		{
		$$ = create_node2(RENAME_AS,click_list_elem($<value>1),click_list_elem($<value>3));
		click_list_set (click_list_elem($<value>3), $<value>1);
		yacc_error_code=79;}
	;

New_exports:	 /* empty */
					{$$ = NULL;yacc_error_code=80;}
	| 			TE_EXPORT {list_init();yacc_error_code=81;} New_export_list
					{$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=82;}
	|			TE_EXPORT ASemi
					{$$ = NULL;yacc_error_code=83;}
	;

New_export_list: 
    New_export_item ASemi
		{list_push($1);yacc_error_code=84;}
	| New_export_list New_export_item ASemi
		{list_push($2);yacc_error_code=85;}
	;

New_export_item: Client_list Feature_set
		{	$$ = create_node1(CLIENT_AS,$1);
			$$ = create_node2(EXPORT_ITEM_AS,$$,$2);
		yacc_error_code=86;}
	;

Feature_set:
	TE_ALL			
		{$$ = create_node(ALL_AS);yacc_error_code=87;}
	| {list_init();yacc_error_code=88;} Feature_list
		{$$ = create_node1 (FEATURE_LIST_AS,list_new(CONSTRUCT_LIST_AS));yacc_error_code=89;}
	;

Feature_list:
	Feature_name
		{list_push(click_list_elem($<value>1));yacc_error_code=90;}
	| Feature_list TE_COMMA Feature_name
		{list_push(click_list_elem($<value>3));yacc_error_code=91;}
	;

Undefine:
		{$$ = NULL;yacc_error_code=92;}
	| TE_UNDEFINE
		{$$ = NULL;yacc_error_code=93;}
	| TE_UNDEFINE {list_init();yacc_error_code=94;} Feature_list
		{$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=95;}
	;

Redefine:
		{$$ = NULL;yacc_error_code=96;}
	| TE_REDEFINE
		{$$ = NULL;yacc_error_code=97;}
	| TE_REDEFINE {list_init();yacc_error_code=98;} Feature_list
		{$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=99;}
	;

Select:
		{$$ = NULL;yacc_error_code=100;}
	| TE_SELECT
		{$$ = NULL;yacc_error_code=101;}
	| TE_SELECT {list_init();yacc_error_code=102;} Feature_list
		{$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=103;}
	;

/*
 * feature declaration
 */

Formal_arguments:		/* empty */
							{$$ = NULL;yacc_error_code=104;}
	|					TE_LPARAN TE_RPARAN
							{yyerror((char *)0);yacc_error_code=105;}
	|					TE_LPARAN {list_init();yacc_error_code=106;} Entity_declaration_list TE_RPARAN
							{$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=107;}
	;

Entity_declaration_list:	/* empty */
	|						Entity_declaration_list Entity_declaration_group
								{list_push($2);yacc_error_code=108;}
	;

Entity_declaration_group:	{list_init();yacc_error_code=109;} Identifier_list {$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=110;} TE_COLON Type ASemi
								{$$ = create_node2(TYPE_DEC_AS,$<node>3,$5);yacc_error_code=111;}
	;

Identifier_list: 			Identifier
								{list_push($1);yacc_error_code=112;}
	|						Identifier_list TE_COMMA Identifier
								{list_push($3);yacc_error_code=113;}
	;

Strip_identifier_list:		/* empty */
	|						Identifier_list
	;

Type_mark:					/* empty */
								{$$ = NULL;yacc_error_code=114;}
	|						TE_COLON Type
								{$$ = $2;yacc_error_code=115;}
	;


Routine:					Obsolete {fbody_pos = current_location->start_position;yacc_error_code=116;} 
							Precondition Local_declarations
							Routine_body Postcondition Rescue TE_END
								{$$ = create_routine_as($1,fbody_pos,$3,$4,$5,$6,$7);yacc_error_code=117;}
	;

Routine_body: 				Internal
								{$$ = $1;yacc_error_code=118;}
	|						External
								{$$ = $1;yacc_error_code=119;}
	|						TE_DEFERRED
								{$$ = create_node(DEFERRED_AS);yacc_error_code=120;}
	;

External:					TE_EXTERNAL External_language External_name
								{$$ = create_node2(EXTERNAL_AS,$2,$3);yacc_error_code=121;}
	;

External_language:			{SET_POS(current_location);yacc_error_code=122;} Non_empty_string
								{$$ = create_node1(EXTERNAL_LANG_AS, $2);yacc_error_code=123;}
	;

External_name:				/* empty */
								{$$ = NULL;yacc_error_code=124;}
	|						TE_ALIAS Non_empty_string
								{$$ = $2;yacc_error_code=125;}
	;

Internal:					TE_DO {list_init();yacc_error_code=126;} Compound
								{$$ = create_node1(DO_AS,list_new(CONSTRUCT_LIST_AS));yacc_error_code=127;}
	|						TE_ONCE {list_init();yacc_error_code=128;} Compound
								{$$ =
create_node1(ONCE_AS,list_new(CONSTRUCT_LIST_AS));yacc_error_code=129;}
	;


Local_declarations:			/* empty */
								{$$ = NULL;yacc_error_code=130;}
	|						TE_LOCAL {list_init();yacc_error_code=131;} Entity_declaration_list
								{$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=132;}
	;

Compound:					Instruction_list Set_position Instruction Opt_Semi
								{list_push($3);yacc_error_code=133;}
	|						/* empty */ Opt_Semi
	;
Opt_Semi:					Opt_Semi TE_SEMICOLON
	|						/* empty */
	;
Instruction_list:			Instruction_list Set_position Instruction Opt_Semi
								{list_push($3);yacc_error_code=134;}
	|						/* empty */ Opt_Semi
	;
Instruction:
							Creation
								{$$ = $1;yacc_error_code=135;}
	|						Call
								{$$ = $1;yacc_error_code=136;}
	|						Assignment
								{$$ = $1;yacc_error_code=137;}
	|						Reverse_assignment
								{$$ = $1;yacc_error_code=138;}
	|						Conditional
								{$$ = $1;yacc_error_code=139;}
	|						Multi_branch
								{$$ = $1;yacc_error_code=140;}
	|						Loop
								{$$ = $1;yacc_error_code=141;}
	|						Debug
								{$$ = $1;yacc_error_code=142;}
	|						Check
								{$$ = $1;yacc_error_code=143;}
	|						Retry
								{$$ = $1;yacc_error_code=144;}
	;

Precondition:				/* empty */
								{$$ = NULL;yacc_error_code=145;}
	|						TE_REQUIRE {id_level = ASSERT_LEVEL;yacc_error_code=146;} Assertion
								{	id_level = NORMAL_LEVEL;
									$$ = create_node1(REQUIRE_AS,$3);
								yacc_error_code=147;}
	|						TE_REQUIRE TE_ELSE {id_level = ASSERT_LEVEL;yacc_error_code=148;} Assertion
								{	id_level = NORMAL_LEVEL;
									$$ = create_node1(REQUIRE_ELSE_AS,$4);
								yacc_error_code=149;}
	;

Postcondition:				/* empty */
								{$$ = NULL;yacc_error_code=150;}
	|						TE_ENSURE {id_level = ASSERT_LEVEL;yacc_error_code=151;} Assertion
								{	id_level = NORMAL_LEVEL;
									$$ = create_node1(ENSURE_AS,$3);
								yacc_error_code=152;}
	|						TE_ENSURE TE_THEN {id_level = ASSERT_LEVEL;yacc_error_code=153;} Assertion
								{	id_level = NORMAL_LEVEL;
									$$ = create_node1(ENSURE_THEN_AS,$4);
								yacc_error_code=154;}
	;


Assertion:					{list_init();yacc_error_code=155;} Assertion_list 
								{$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=156;}
	;

Assertion_list:				/* empty */
	|						Assertion_list_non_empty
	;
Assertion_list_non_empty:	Set_position Assertion_clause ASemi
								{list_push($2);yacc_error_code=157;}
	|						Assertion_list_non_empty Set_position Assertion_clause ASemi
								{list_push($3);yacc_error_code=158;}
	;

Assertion_clause: 			Expression
								{
									$<node>$ = create_node2(TAGGED_AS,NULL,$1);
								yacc_error_code=159;}
	|						Identifier TE_COLON Expression
								{
									$<node>$ = create_node2(TAGGED_AS,$1,$3);
								yacc_error_code=160;}
	|						Identifier TE_COLON 
								{ $$ = NULL;yacc_error_code=161;}
	;

/*
 * Type
 */


Type:
	Pushing_id
		{
		$$ = create_type_class(click_list_elem($<value>1),NULL);
		click_list_set ($$, $<value>1);
		yacc_error_code=162;}
	| Pushing_id Existing_generics
		{
		$$ = create_type_class(click_list_elem($<value>1),$2);
		click_list_set ($$, $<value>1);
		yacc_error_code=163;}
	| TE_EXPANDED Pushing_id
		{
		$$ = create_exp_class_type(click_list_elem($<value>2),NULL);
		click_list_set ($$, $<value>2);
		yacc_error_code=164;}
	| TE_EXPANDED Pushing_id Existing_generics
		{
		$$ = create_exp_class_type(click_list_elem($<value>2),$3);
		click_list_set ($$, $<value>2);
		yacc_error_code=165;}
	| TE_SEPARATE Pushing_id
		{
		$$ = create_separate_class_type(click_list_elem($<value>2),NULL);
		click_list_set ($$, $<value>2);
		yacc_error_code=166;}
	| TE_SEPARATE Pushing_id Existing_generics
		{
		$$ = create_separate_class_type(click_list_elem($<value>2),$3);
		click_list_set ($$, $<value>2);
		yacc_error_code=167;}
	| TE_BIT Integer_constant
		{
		$$ = create_node1(BITS_AS,$2);
		yacc_error_code=168;}
	| TE_BIT Identifier
		{
		$$ = create_node1(BITS_SYMBOL_AS,$2);
		yacc_error_code=169;}
	| TE_LIKE Identifier
		{
		$$ = create_node1(LIKE_ID_AS, $2);
		yacc_error_code=170;}
	| TE_LIKE TE_CURRENT
		{
		$$ = create_node(LIKE_CUR_AS);
		yacc_error_code=171;}
	| TE_SIGNATURE Identifier
		{
		$$ = create_node1(SIGNATURE_AS, $2);
		yacc_error_code=3;}
	;

Class_type:
    Pushing_id
        {
        $$ = create_type_class(click_list_elem($<value>1),NULL);
        click_list_set ($$, $<value>1);
        yacc_error_code=172;}
    | Pushing_id Existing_generics
        {
        $$ = create_type_class(click_list_elem($<value>1),$2);
        click_list_set ($$, $<value>1);
        yacc_error_code=173;}
	;

Existing_generics:
	TE_LSQURE TE_RSQURE
		{$$ = NULL;yacc_error_code=174;}
	| TE_LSQURE {list_init();yacc_error_code=175;} Type_list TE_RSQURE
		{
		$$ = list_new(CONSTRUCT_LIST_AS);
		yacc_error_code=176;}
	;
		
Type_list:
	Type
		{list_push($1);yacc_error_code=177;}
	| Type_list TE_COMMA Type
		{list_push($3);yacc_error_code=178;}
	;

/*
 * Formal generics
 */

Formal_generics:
		{
		$$ = NULL;
		yacc_error_code=179;}
	| TE_LSQURE {list_init();yacc_error_code=180;} Formal_generic_list TE_RSQURE
		{
		$$ = list_new(CONSTRUCT_LIST_AS);
		yacc_error_code=181;}
	;

Formal_generic_list:
	/* empty */
	| Formal_generic
		{list_push($1);yacc_error_code=182;}
	| Formal_generic_list TE_COMMA Formal_generic
		{list_push($3);yacc_error_code=183;}
	;

Formal_generic:
	TE_ID {strcpy(generic_name, token_str);yacc_error_code=184;} Constraint Creation_constraint
		{generic_inc(); $$ = create_generic(generic_name, $3, $4);yacc_error_code=185;}
    ;

Constraint:
	/* empty */
		{$$ = NULL;yacc_error_code=186;}
    | TE_CONSTRAIN Class_type 
		{$$ = $2;yacc_error_code=187;}
    ;

Creation_constraint:
	/* empty */
		{ $$ = NULL;yacc_error_code=188;}
	| TE_CREATION {list_init ();yacc_error_code=189;} Feature_list TE_END
		{$$ = list_new (CONSTRUCT_LIST_AS); yacc_error_code=190;}	
	;

/*
 * Instructions
 */

Conditional:				{$<loc>$ = current_location;yacc_error_code=191;} TE_IF Expression TE_THEN {list_init();yacc_error_code=192;} Compound {$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=193;} Elsif Else_part TE_END
								{SET_POS($<loc>1); $$ = create_node4(IF_AS,$3,$<node>7,$8,$9);yacc_error_code=194;}
	;

Elsif:						/* empty */
								{$$ = NULL;yacc_error_code=195;}
	|						{list_init();yacc_error_code=196;} Elsif_list 
								{$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=197;}
	;

Elsif_list:					Elsif_part
								{list_push($1);yacc_error_code=198;}
	|						Elsif_list Elsif_part
								{list_push($2);yacc_error_code=199;}
	;

Elsif_part:					TE_ELSEIF Expression TE_THEN {list_init();yacc_error_code=200;} Compound
								{$$ = create_node2(ELSIF_AS,$2,list_new(CONSTRUCT_LIST_AS));yacc_error_code=201;}
	;

Inspect_default:            /* empty */
                                {$$ = NULL;yacc_error_code=202;}
    |                       TE_ELSE {list_init();yacc_error_code=203;} Compound
                                {$$ = inspect_else();yacc_error_code=204;}
    ;
 
Else_part:					/* empty */
								{$$ = NULL;yacc_error_code=205;}
	|						TE_ELSE {list_init();yacc_error_code=206;} Compound 
								{$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=207;}
	;

Multi_branch:				{$<loc>$ = current_location;yacc_error_code=208;} TE_INSPECT
							Expression {list_init();yacc_error_code=209;} When_part_list {$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=210;}
							Inspect_default TE_END
								{SET_POS($<loc>1); $$ = create_node3(INSPECT_AS,$3,$<node>6,$7);yacc_error_code=211;}
	;

/*
When_part_list:				When_part
								{list_push($1);yacc_error_code=212;}
	|						When_part_list When_part
								{list_push($2);yacc_error_code=213;}
	;
*/

When_part_list:				/* empty */
	|						When_part When_part_list
								{list_push($1);yacc_error_code=214;}
	;

When_part:					TE_WHEN {list_init();yacc_error_code=215;} Choices {$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=216;} TE_THEN {list_init();yacc_error_code=217;} Compound
								{$$ = create_node2(CASE_AS,$<node>4,list_new(CONSTRUCT_LIST_AS));yacc_error_code=218;}
	;

Choices:					Choice
								{list_push($1);yacc_error_code=219;}
	|						Choices TE_COMMA Choice
								{list_push($3);yacc_error_code=220;}
	;

Choice:						Integer_constant
				{$$ = create_node2(INTERVAL_AS,$1,NULL);yacc_error_code=221;}
	|						Character_constant
				{$$ = create_node2(INTERVAL_AS,$1,NULL);yacc_error_code=222;}
	|						Identifier
				{$$ = create_node2(INTERVAL_AS,$1,NULL);yacc_error_code=223;}
	|						Integer_constant TE_DOTDOT Integer_constant
				{$$ = create_node2(INTERVAL_AS,$1,$3);yacc_error_code=224;}
	|						Integer_constant TE_DOTDOT Identifier
				{$$ = create_node2(INTERVAL_AS,$1,$3);yacc_error_code=225;}
	|						Identifier TE_DOTDOT Integer_constant
				{$$ = create_node2(INTERVAL_AS,$1,$3);yacc_error_code=226;}
	|						Identifier TE_DOTDOT Identifier
				{$$ = create_node2(INTERVAL_AS,$1,$3);yacc_error_code=227;}
	|						Character_constant TE_DOTDOT Character_constant
				{$$ = create_node2(INTERVAL_AS,$1,$3);yacc_error_code=228;}
	|						Identifier TE_DOTDOT Character_constant
				{$$ = create_node2(INTERVAL_AS,$1,$3);yacc_error_code=229;}
	|						Character_constant TE_DOTDOT Identifier
				{$$ = create_node2(INTERVAL_AS,$1,$3);yacc_error_code=230;}
	;

Loop:						{$<loc>$ = current_location;yacc_error_code=231;} TE_FROM {list_init();yacc_error_code=232;} Compound {$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=233;} Invariant Variant TE_UNTIL Expression TE_LOOP {list_init();yacc_error_code=234;} Compound TE_END
								{SET_POS($<loc>1); $$ = create_node5(LOOP_AS,$<node>5,$6,$7,$9,list_new(CONSTRUCT_LIST_AS));yacc_error_code=235;}
	;

Invariant:					/* empty */
								{$$ = NULL;yacc_error_code=236;}
	|						TE_INVARIANT Assertion
								{$$ = $2;yacc_error_code=237;}
	;

Class_invariant:
		{$$ = NULL;yacc_error_code=238;}
	| TE_INVARIANT {id_level = INVARIANT_LEVEL;yacc_error_code=239;} Assertion
		{
		id_level = NORMAL_LEVEL;
		$$ = create_node1(INVARIANT_AS,$3);
		yacc_error_code=240;}
	;
					

Variant:					/* empty */
								{$$ = NULL;yacc_error_code=241;}
	|						TE_VARIANT Identifier TE_COLON Expression
								{$$ = create_node2(VARIANT_AS,$2,$4);yacc_error_code=242;}
	|						TE_VARIANT Expression
								{$$ = create_node2(VARIANT_AS,NULL,$2);yacc_error_code=243;}
	;

Debug:						{$<loc>$ = current_location; yacc_error_code=244;} TE_DEBUG Debug_keys {list_init();yacc_error_code=245;} Compound TE_END 
								{SET_POS($<loc>1); $$ = create_node2(DEBUG_AS,$3,list_new(CONSTRUCT_LIST_AS));yacc_error_code=246;}
	;

Debug_keys:					/* empty */
								{$$ = NULL;yacc_error_code=247;}
	|						TE_LPARAN TE_RPARAN
								{$$ = NULL;yacc_error_code=248;}
	|						TE_LPARAN {list_init();yacc_error_code=249;} Debug_key_list TE_RPARAN
								{$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=250;}
	;

Debug_key_list:				Non_empty_string
								{list_push($1);yacc_error_code=251;}
	|						Debug_key_list TE_COMMA Non_empty_string
								{list_push($3);yacc_error_code=252;}
	;
							
Retry:						TE_RETRY
								{$$ = create_node(RETRY_AS);yacc_error_code=253;}
	;

Rescue:						/* empty */
								{$$ = NULL;yacc_error_code=254;}
	|						TE_RESCUE {list_init();yacc_error_code=255;} Compound 
								{$$ = rescue_instr();yacc_error_code=256;}
	;
/*
Assignment:					Set_position Identifier TE_ASSIGN Expression
								{$$ = create_node2(ASSIGN_AS,create_node2(ACCESS_ID_AS,$2,NULL),$4);yacc_error_code=257;}
	|						Set_position TE_RESULT TE_ASSIGN Expression
								{$$ = create_node2(ASSIGN_AS,create_node(RESULT_AS),$4);yacc_error_code=258;}
	;

Reverse_assignment:			Set_position Identifier TE_ACCEPT Expression
								{$$ = create_node2(REVERSE_AS,create_node2(ACCESS_ID_AS,$2,NULL),$4);yacc_error_code=259;}
	|						Set_position TE_RESULT TE_ACCEPT Expression
								{$$ = create_node2(REVERSE_AS,create_node(RESULT_AS),$4);yacc_error_code=260;}
	;
*/

Assignment:                 Identifier TE_ASSIGN Expression
                                {$$ = create_node2(ASSIGN_AS,create_node2(ACCESS_ID_AS,$1,NULL),$3);yacc_error_code=261;}
    |                       TE_RESULT TE_ASSIGN Expression
                                {$$ = create_node2(ASSIGN_AS,create_node(RESULT_AS),$3);yacc_error_code=262;}
    ;

Reverse_assignment:         Identifier TE_ACCEPT Expression
                                {$$ = create_node2(REVERSE_AS,create_node2(ACCESS_ID_AS,$1,NULL),$3);yacc_error_code=263;}
    |                       TE_RESULT TE_ACCEPT Expression
                                {$$ = create_node2(REVERSE_AS,create_node(RESULT_AS),$3);yacc_error_code=264;}
    ;


Creators:					/* empty */
								{$$ = NULL;yacc_error_code=265;}
	|						{list_init();yacc_error_code=266;} Creation_clause_list
								{$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=267;}
	;

Creation_clause_list:		Creation_clause
								{list_push($1);yacc_error_code=268;}
	|						Creation_clause_list Creation_clause
								{list_push($2);yacc_error_code=269;}
	;

Creation_clause:			TE_CREATION
								{$$ = create_node2(CREATE_AS,NULL,NULL);yacc_error_code=270;}
	|						TE_CREATION Clients {list_init();yacc_error_code=271;} Feature_list
								{$$ = create_node2(CREATE_AS,$2,list_new(CONSTRUCT_LIST_AS));yacc_error_code=272;}
	|						TE_CREATION Client_list 
								{
									$$ = create_node1(CLIENT_AS,$2);
									$$ = create_node2(CREATE_AS,$$,NULL);
								yacc_error_code=273;}
	;

Routine_creation:			TE_TILDE TE_LCURLY Type TE_RCURLY Feature_name
								{$$ = create_node2(ROUTINE_CREATION_AS,$3,click_list_elem($<value>5));}
	|						TE_TILDE Feature_name
								{$$ = create_node2(ROUTINE_CREATION_AS,NULL,click_list_elem($<value>2));}
	;

Creation:					TE_BANG Creation_type TE_BANG Creation_target Creation_call
								{$$ = create_node3(CREATION_AS,$2,$4,$5);yacc_error_code=274;}
	|						TE_CREATION Creation_target Creation_call
								{$$ = create_node3(CREATION_AS,NULL,$2,$3);yacc_error_code=274;}
	|						TE_CREATION TE_LCURLY Type TE_RCURLY Creation_target Creation_call
								{$$ = create_node3(CREATION_AS,$3,$5,$6);yacc_error_code=274;}
	;

Creation_expression:		TE_CREATION TE_LCURLY Type TE_RCURLY Creation_call
								{$$=create_node2 (CREATION_EXPR_AS,$3,$5);}
	|						TE_BANG Type TE_BANG Creation_call
								{$$=create_node2 (CREATION_EXPR_AS,$2,$4);}
	;

Creation_type:				/* empty */
								{$$ = NULL;yacc_error_code=275;}
	|						Type
								{$$ = $1;yacc_error_code=276;}
	;

Creation_target:			Identifier
								{$$ = create_node2(ACCESS_ID_AS,$1,NULL);yacc_error_code=277;}
	|						TE_RESULT
								{$$ = create_node(RESULT_AS);yacc_error_code=278;}
	;

Creation_call:				/* empty */
								{$$ = NULL;yacc_error_code=279;}
	|						TE_DOT Identifier Parameters
								{$$ = create_node2(ACCESS_INV_AS,$2,$3);yacc_error_code=280;}
	;

/*
 * Instruction call
 */
 
Call:						A_feature
								{$$ = create_node1(INSTR_CALL_AS,$1);yacc_error_code=281;}
	|						Call_on_result
								{$$ = create_node1(INSTR_CALL_AS,$1);yacc_error_code=282;}
	|						Call_on_feature
								{$$ = create_node1(INSTR_CALL_AS,$1);yacc_error_code=283;}
	|						Call_on_current
								{$$ = create_node1(INSTR_CALL_AS,$1);yacc_error_code=284;}
	|						Call_on_expression
								{$$ = create_node1(INSTR_CALL_AS,$1);yacc_error_code=285;}
	|						A_precursor
								{$$ = create_node1(INSTR_CALL_AS,$1);yacc_error_code=286;}
	|						Call_on_precursor
								{$$ = create_node1(INSTR_CALL_AS,$1);yacc_error_code=287;}
	;

Check:						{$<loc>$ = current_location; yacc_error_code=288;} TE_CHECK Assertion TE_END
								{SET_POS($<loc>1); $$ = create_node1(CHECK_AS,$3);yacc_error_code=289;}
	;

/*
 * expression
 */

Expression:					Expression_constant
								{yyerrok;$$ = create_node1(VALUE_AS,$1);yacc_error_code=290;}
	|						Manifest_array
								{yyerrok;$$ = create_node1(VALUE_AS,$1);yacc_error_code=291;}
	|						Manifest_tuple
								{yyerrok;$$ = create_node1(VALUE_AS,$1);yacc_error_code=291;}
	|						Feature_call
								{$$ = create_node1(EXPR_CALL_AS, $1);yacc_error_code=292;}
	|						Routine_creation
								{$$ = $1;}
	|						TE_LPARAN Expression TE_RPARAN
								{$$ = create_node1(PARAN_AS, $2);yacc_error_code=293;}
	|						Expression TE_PLUS Expression
								{yyerrok;$$ = create_node2(BIN_PLUS_AS,$1,$3);yacc_error_code=294;}
	|						Expression TE_MINUS Expression
								{yyerrok;$$ = create_node2(BIN_MINUS_AS,$1,$3);yacc_error_code=295;}
	|						Expression TE_STAR Expression
								{yyerrok;$$ = create_node2(BIN_STAR_AS,$1,$3);yacc_error_code=296;}
	|						Expression TE_SLASH Expression
								{yyerrok;$$ = create_node2(BIN_SLASH_AS,$1,$3);yacc_error_code=297;}
	|						Expression TE_MOD Expression
								{yyerrok;$$ = create_node2(BIN_MOD_AS,$1,$3);yacc_error_code=298;}
	|						Expression TE_DIV Expression
								{yyerrok;$$ = create_node2(BIN_DIV_AS,$1,$3);yacc_error_code=299;}
	|						Expression TE_POWER Expression
								{yyerrok;$$ = create_node2(BIN_POWER_AS,$1,$3);yacc_error_code=300;}
	|						Expression TE_AND Expression
								{yyerrok;$$ = create_node2(BIN_AND_AS,$1,$3);yacc_error_code=301;}
	|						Expression TE_AND TE_THEN Expression %prec TE_AND
								{yyerrok;$$ = create_node2(BIN_AND_THEN_AS,$1,$4);yacc_error_code=302;}
	|						Expression TE_OR Expression
								{yyerrok;$$ = create_node2(BIN_OR_AS,$1,$3);yacc_error_code=303;}
	|						Expression TE_OR TE_ELSE Expression %prec TE_OR
								{yyerrok;$$ = create_node2(BIN_OR_ELSE_AS,$1,$4);yacc_error_code=304;}
	|						Expression TE_IMPLIES Expression
								{yyerrok;$$ = create_node2(BIN_IMPLIES_AS,$1,$3);yacc_error_code=304;}
	|						Expression TE_XOR Expression
								{yyerrok;$$ = create_node2(BIN_XOR_AS,$1,$3);yacc_error_code=305;}
	|						Expression TE_GE Expression
								{yyerrok;$$ = create_node2(BIN_GE_AS,$1,$3);yacc_error_code=306;}
	|						Expression TE_GT Expression
								{yyerrok;$$ = create_node2(BIN_GT_AS,$1,$3);yacc_error_code=307;}
	|						Expression TE_LE Expression
								{yyerrok;$$ = create_node2(BIN_LE_AS,$1,$3);yacc_error_code=308;}
	|						Expression TE_LT Expression
								{yyerrok;$$ = create_node2(BIN_LT_AS,$1,$3);yacc_error_code=309;}
	|						Expression TE_EQ Expression
								{yyerrok;$$ = create_node2(BIN_EQ_AS,$1,$3);yacc_error_code=310;}
	|						Expression TE_NE Expression
								{yyerrok;$$ = create_node2(BIN_NE_AS,$1,$3);yacc_error_code=311;}
	|						Expression Free_operator Expression %prec TE_FREE
								{	yyerrok;
									$$ = create_node3(BIN_FREE_AS,$1,$2,$3);yacc_error_code=312;}
	|						TE_MINUS Expression %prec TE_NOT
								{yyerrok;$$ = create_node1(UN_MINUS_AS,$2);yacc_error_code=313;}
	|						TE_PLUS Expression %prec TE_NOT
								{yyerrok;$$ = create_node1(UN_PLUS_AS,$2);yacc_error_code=314;}
	|						TE_NOT Expression
								{yyerrok;$$ = create_node1(UN_NOT_AS, $2);yacc_error_code=315;}
	|						TE_OLD Expression
								{yyerrok;$$ = create_node1(UN_OLD_AS,$2);yacc_error_code=316;}
	|						Free_operator Expression %prec TE_NOT
								{yyerrok;$$ = create_node2(UN_FREE_AS,$1,$2);yacc_error_code=317;}
	|						TE_STRIP {yyerrok;list_init();yacc_error_code=318;} TE_LPARAN Strip_identifier_list TE_RPARAN
								{yyerrok;$$ = create_node1(UN_STRIP_AS,list_new(CONSTRUCT_LIST_AS));yacc_error_code=319;}
	;

Actual_parameter:			Expression
								{$$ = $1;yacc_error_code=320;}
	|						TE_ADDRESS Feature_name
								{
								yyerrok;
								$$ = create_node1(ADDRESS_AS,click_list_elem($<value>2));
								yacc_error_code=321;}
	|						TE_ADDRESS TE_LPARAN Expression TE_RPARAN
								{
								yyerrok;
								$$ = create_node1(EXPR_ADDRESS_AS,$3);
								yacc_error_code=322;}
	|						TE_ADDRESS TE_CURRENT
								{yyerrok;$$ = create_node(ADDRESS_CURRENT_AS);yacc_error_code=323;}
	|						TE_ADDRESS TE_RESULT
								{yyerrok;$$ = create_node(ADDRESS_RESULT_AS);yacc_error_code=324;}
	;

Free_operator:				TE_FREE
								{$$ = create_id(token_str);yacc_error_code=325;}
	;

/*
 * expression call
 */

Feature_call:				Call_on_current
								{$$ = $1;yacc_error_code=326;}
	|						Call_on_result
								{$$ = $1;yacc_error_code=327;}
	|						Call_on_feature
								{$$ = $1;yacc_error_code=328;}
	|						TE_CURRENT
								{$$ = create_node(CURRENT_AS);yacc_error_code=329;}
	|						TE_RESULT
								{$$ = create_node(RESULT_AS);yacc_error_code=330;}
	|						A_feature
								{$$ = $1;yacc_error_code=331;}
	|						Call_on_expression
								{$$ = $1;yacc_error_code=332;}
	|						A_precursor
								{$$ = $1;yacc_error_code=333;}
	|						Call_on_precursor
								{$$ = $1;yacc_error_code=334;}
	|						Creation_expression
								{$$ = $1;}
	;

Call_on_current:			TE_CURRENT TE_DOT Remote_call
								{$$ = create_node2(NESTED_AS,create_node(CURRENT_AS),$3);yacc_error_code=335;}
	;

Call_on_result:				TE_RESULT TE_DOT Remote_call
								{$$ = create_node2(NESTED_AS,create_node(RESULT_AS),$3);yacc_error_code=336;}
	;

Call_on_feature:			A_feature TE_DOT Remote_call
								{$$ = create_node2(NESTED_AS,$1,$3);yacc_error_code=337;}
	;

Call_on_expression:			TE_LPARAN Expression TE_RPARAN TE_DOT Remote_call
								{$$ = create_node2(NESTED_EXPR_AS,$2,$5);yacc_error_code=338;}
	;

Call_on_precursor:			A_precursor TE_DOT Remote_call
								{$$ = create_node2(NESTED_AS,$1,$3);yacc_error_code=339;}
	;

A_precursor:				TE_PRECURSOR Parameters
								{$$ = create_node2(PRECURSOR_AS,NULL,$2);yacc_error_code=340;}
	|						TE_LCURLY Pushing_id TE_RCURLY TE_PRECURSOR Parameters
								{
								$$ = create_node2(PRECURSOR_AS,click_list_elem ($<value>2),$5);
								click_list_set ($$, $<value>2);
								yacc_error_code=341;}
	|						TE_LCURLY TE_LCURLY Pushing_id TE_RCURLY TE_RCURLY TE_PRECURSOR Parameters
								{
								$$ = create_node2(PRECURSOR_AS,click_list_elem ($<value>3),$7);
								click_list_set ($$, $<value>3);
								yacc_error_code=342;}
	;

Remote_call:				Call_on_feature_access
								{$$ = $1;yacc_error_code=343;}
	|						Feature_access
								{$$ = $1;yacc_error_code=344;}
	;

Call_on_feature_access:		Feature_access TE_DOT Feature_access
								{$$ = create_node2(NESTED_AS,$1,$3);yacc_error_code=345;}
	|						Feature_access TE_DOT Call_on_feature_access
								{$$ = create_node2(NESTED_AS,$1,$3);yacc_error_code=346;}
	;

A_feature:					Identifier Parameters
						{	switch(id_level) {
							case NORMAL_LEVEL:
								$$ = create_node2(ACCESS_ID_AS, $1,$2);
								break;
							case ASSERT_LEVEL:
								$$ = create_node2(ACCESS_ASSERT_AS,$1,$2);
								break;
							case INVARIANT_LEVEL:
								$$ = create_node2(ACCESS_INV_AS,$1,$2);
								break;
							}
						yacc_error_code=347;
						};

Feature_access:				Identifier Parameters
								{$$ = create_node2(ACCESS_FEAT_AS,$1,$2);yacc_error_code=348;}
	;

Parameters:					/* empty */
								{$$ = NULL;yacc_error_code=349;}
	|						TE_LPARAN TE_RPARAN
								{$$ = NULL;yacc_error_code=350;}
	|						TE_LPARAN {list_init();yacc_error_code=351;} Parameter_list TE_RPARAN
								{$$ = list_new(CONSTRUCT_LIST_AS);yacc_error_code=352;}
	;

Parameter_list:				Actual_parameter
								{list_push($1);yacc_error_code=353;}
	|						Parameter_list TE_COMMA Actual_parameter
								{list_push($3);yacc_error_code=354;}
	;

Expression_list:			Expression
								{list_push($1);yacc_error_code=355;}
	|						Expression_list TE_COMMA Expression
								{list_push($3);yacc_error_code=356;}
	;

Manifest_expression_list:	/* empty */
	|						Expression_list
	;

/*
 * etc
 */

Identifier:		TE_ID
				{
				$$ = create_id(token_str);
				yacc_error_code=357;}
	;

Manifest_constant:		Boolean_constant
							{$$ = $1;yacc_error_code=358;}
	|					Character_constant
							{$$ = $1;yacc_error_code=359;}
	|					Integer_constant
							{$$ = $1;yacc_error_code=360;}
	|					Real_constant
							{$$ = $1;yacc_error_code=361;}
	|					Bit_constant
							{$$ = $1;yacc_error_code=362;}
	|					Manifest_string
							{$$ = $1;yacc_error_code=363;}
	;

Expression_constant:	Boolean_constant
							{$$ = $1;yacc_error_code=364;}
	|				   Character_constant
							{$$ = $1;yacc_error_code=365;}
	|				   TE_INTEGER
							{$$ = create_int(token_str,0);yacc_error_code=366;}
	|				   TE_REAL
							{$$ = create_real(token_str,0);yacc_error_code=367;}
	|				   Bit_constant
							{$$ = $1;yacc_error_code=368;}
	|				   Manifest_string
							{$$ = $1;yacc_error_code=369;}
	;

Boolean_constant:		TE_FALSE
							{$$ = create_bool(0);yacc_error_code=370;}
	|					TE_TRUE
							{$$ = create_bool(1);yacc_error_code=371;}
	;

Character_constant:		TE_CHAR
							{$$ = create_char(token_str);yacc_error_code=372;}
	;

Integer_constant:		Sign TE_INTEGER
							{$$ = create_int(token_str,$1);yacc_error_code=373;}
	;

Sign:					/* empty */
							{$$ = 0;yacc_error_code=374;}
	|					TE_PLUS
							{$$ = 0;yacc_error_code=375;}
	|					TE_MINUS
							{$$ = 1;yacc_error_code=376;}
	;

Real_constant:			Sign TE_REAL
							{$$ = create_real(token_str,$1);yacc_error_code=377;}
	;

Bit_constant:			TE_A_BIT
							{$$ = create_node1(BIT_CONST_AS,create_id(token_str));yacc_error_code=378;}
	;

Manifest_string:		TE_STRING
							{$$ = create_string(token_str);yacc_error_code=379;}
	|					EIF_ERROR6
							{$$ = create_string(token_str);yacc_error_code=380;}
	;

Non_empty_string:		TE_STRING
							{$$ = create_string(token_str);yacc_error_code=381;}
	;

Manifest_array:			TE_LARRAY {list_init();yacc_error_code=382;} Manifest_expression_list TE_RARRAY
							{$$ = create_node1(ARRAY_AS,list_new(CONSTRUCT_LIST_AS));yacc_error_code=383;}
	;

Manifest_tuple:			TE_LTUPLE {list_init();yacc_error_code=382;} Manifest_expression_list TE_RTUPLE
							{$$ = create_node1(TUPLE_AS,list_new(CONSTRUCT_LIST_AS));yacc_error_code=383;}
	;

Set_position: 			{SET_POS (current_location) ; $$ = current_location;}
	;

%%
char deferred;					/* Boolean mark for deferred class */
char expanded;					/* Boolean mark for expanded class */
char separate;					/* Boolean mark for separate class */
char is_frozen;					/* Boolean mark for frozen feature names */

int id_level;					/* Boolean for controlling the semantic
								 * action of rule `A_feature' .
								 */
int inherit_context;			/* Flag for context sensitivity of token
								 * TE_END.
								 */
char generic_name[IDLENGTH];	/* Formal generic parameter name */
int yywrap(void)
{
	return 1;
}
