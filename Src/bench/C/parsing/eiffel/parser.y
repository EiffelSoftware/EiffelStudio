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
%token		TE_COLON
%token		TE_COMMA
%token 		TE_CREATION
%token		TE_LARRAY
%token		TE_RARRAY
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
Instruction1 
Postcondition Assertion_clause Type Class_type Existing_generics
Actual_generics
Formal_generics Formal_generic Constraint Creation_constraint Conditional Elsif Elsif_part
Else_part When_part Multi_branch Loop Invariant Variant Debug Debug_keys
Retry Rescue Assignment Reverse_assignment Creators Creation_clause
Creation Creation_type Creation_target Creation_call Expression Actual_parameter
Manifest_array Choice Features Rename_pair
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
	Indexing Header_mark {click_list_init();} TE_CLASS Pushing_id
	Formal_generics Obsolete Inheritance Creators Features Class_invariant TE_END
		{
			/* node is set at the Eiffel level for root class */
			rn_ast = create_class(click_list_elem ($<value>5),deferred,expanded,separate,$1,$6,$7,$8,$9,$10,$11,click_list_new(), current_location->start_position);
		}
	;

Pushing_id:
		TE_ID
		{
		$$ = click_list_push ();
		click_list_set (create_id (token_str), $$);
		}
	;

/*
 * Indexing
 */

Indexing:				/* empty */
							{$$ = NULL;}
	|					TE_INDEXING {list_init();} Index_list
							{$$ = list_new(CONSTRUCT_LIST_AS);}
	|					TE_INDEXING 
							{$$ = NULL;}
	;

Index_list:				Index_clause
							{list_push($1);}
	|					Index_list Index_clause
							{list_push($2);}
	;

Index_clause:			Index {list_init();} Index_terms ASemi
							{$$ = create_node2(INDEX_AS,$1,list_new(CONSTRUCT_LIST_AS));}
	;

Index:					Identifier TE_COLON
							{$$ = $1;}
	|					  
							{$$ = NULL;}
	;

Index_terms:			Index_value
							{list_push($1);}
	|					Index_terms TE_COMMA Index_value
							{list_push($3);}
	|					TE_SEMICOLON
	;

Index_value:			Identifier
							{$$ = $1;}
	|					Manifest_constant
							{$$ = $1;}
	;

/*
 * header mark
 */

Header_mark:			/* empty */
							{deferred = FALSE; expanded = FALSE; separate = FALSE;}
	|					TE_DEFERRED
							{deferred = TRUE; expanded = FALSE; separate = FALSE;}
	|					TE_EXPANDED
							{expanded = TRUE; deferred = FALSE; separate = FALSE;}
	|					TE_SEPARATE
							{expanded = FALSE; deferred = FALSE; separate = TRUE;}
	;


/*
 * obsolete
 */

Obsolete:				/* empty */
							{$$ = NULL;}
	|					TE_OBSOLETE Manifest_string
							{$$ = $2;}
	;

/*
 * features
 */


Features:
	{$$ = NULL;}
	| {list_init();} Feature_clause_list
		{$$ = list_new(CONSTRUCT_LIST_AS);}
	;

Feature_clause_list:
	Feature_clause
		{list_push($1);}
	| Feature_clause_list Feature_clause
		{list_push($2);}
	;

Feature_clause:
	TE_FEATURE {fclause_pos = current_location->end_position;} Clients {list_init();} Feature_declaration_list
		{
		$$ = list_new(CONSTRUCT_LIST_AS);
		$$ = ($$ == NULL)?NULL:create_fclause_as($3,$$,fclause_pos);
		}
	;


Clients: /* empty */	
			{$$ = NULL;}
	|	 Client_list
			{
			$$ = create_node1(CLIENT_AS,$1);
			}
	;

Client_list:			TE_LCURLY TE_RCURLY
							{	list_init();
								list_push(create_id("none"));
								$$ = list_new(CONSTRUCT_LIST_AS);
							}
	|					TE_LCURLY {list_init();} Class_list TE_RCURLY
							{$$ = list_new(CONSTRUCT_LIST_AS);}
	;

Class_list:				Identifier
							{
							list_push($1);
							}
	|					Class_list TE_COMMA Identifier
							{
							list_push($3);
							}
	;

Feature_declaration_list:	/* empty */
	|						Feature_declaration_list Feature_declaration
								{list_push($2);}
	;
ASemi:	/* empty */
	|	TE_SEMICOLON
	;

Feature_declaration:
	{list_init();} New_feature_list {$$ = list_new(CONSTRUCT_LIST_AS);} Declaration_body ASemi
		{
		$$ = create_feature_as($<node>3,$4,click_list_start($<value>2),current_location->start_position);
		click_list_set ($$, $<value>2);
		}
	;

New_feature_list:
	New_feature
		{
		$$ = $<value>1;
		list_push(click_list_elem($$));
		}
	| New_feature_list TE_COMMA New_feature
		{
		$$ = $<value>1;
		list_push(click_list_elem($<value>3));
		}
	;

New_feature:
	Feature_name_mark Feature_name
		{
		$$ = $<value>2;
		}
	;

Feature_name_mark:
		{
		is_frozen = FALSE;
		}
	| TE_FROZEN
		{
		is_frozen = TRUE;
		}
	;

Feature_name:
	Pushing_id
		{
		$$ = $<value>1;
		click_list_set (create_feature_name(FEAT_NAME_ID_AS,click_list_elem($$),is_frozen), $$);
		}
	| Infix
		{
		$$ = $<value>1;
		}
	| Prefix
		{
		$$ = $<value>1;
		}
	;

Infix:
	TE_INFIX Infix_operator
		{
		$$ = $<value>2;
		click_list_set (create_feature_name(INFIX_AS,click_list_elem($$),is_frozen), $$);
		}
	;


Prefix:
	TE_PREFIX Prefix_operator
		{
		$$ = $<value>2;
		click_list_set (create_feature_name(PREFIX_AS,click_list_elem($$),is_frozen), $$);
		}
	;

Infix_operator:
	Manifest_string
		{
		extern int is_infix(char *s);

		$$ = click_list_push ();
		click_list_set ($1, $$);

		if (0 == is_infix(token_str))	/* Check infixed declaration */
			yyerror((char *) 0);
		}
	;

Prefix_operator:
	Manifest_string
		{
		extern int is_prefix(char *s);

		$$ = click_list_push ();
		click_list_set ($1, $$);

		if (0 == is_prefix(token_str))	/* Check prefixed declaration */
			yyerror((char *) 0);
		}
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
	}
	;


Constant_or_routine:	/* empty */
							{$$.cr_node = NULL; $$.cr_type = CR_EMPTY;}
	|					TE_IS Feature_value
							{$$.cr_node = $2.cr_node;$$.cr_type = $2.cr_type;}
	;

Feature_value:			Manifest_constant
					{$$.cr_node = create_node1(CONSTANT_AS,create_node1(VALUE_AS,$1));$$.cr_type = CR_CONSTANT;}
	|					TE_UNIQUE
					{$$.cr_node = create_node1(CONSTANT_AS,create_node1(VALUE_AS,create_node(UNIQUE_AS)));$$.cr_type = CR_CONSTANT;}
	|					Routine
							{$$.cr_node = $1;$$.cr_type = CR_ROUTINE;}
	;


/*
 * inheritance
 */

Inheritance:
	{$$ = NULL;}
	| TE_INHERIT {list_init();} Parent_list 
		{
		$$ = list_new(CONSTRUCT_LIST_AS);
		}
	| TE_INHERIT ASemi
		{ $$ = NULL;}
	;

Parent_list:
    Parent ASemi
		{list_push($1);}
 	| Parent_list Parent ASemi
		{list_push($2);} 
	;

Parent: 
	 Pushing_id Actual_generics
		{
		rn_ast = create_node2(CLASS_TYPE_AS,click_list_elem($<value>1),$2);
		$$ = create_node6(PARENT_AS,rn_ast,NULL,NULL,NULL,NULL,NULL);
		click_list_set (rn_ast, $<value>1);
		}
	| Pushing_id Actual_generics TE_END
		{
		inherit_context = 1;
		rn_ast = create_node2(CLASS_TYPE_AS,click_list_elem($<value>1),$2);
		$$ = create_node6(PARENT_AS,rn_ast,NULL,NULL,NULL,NULL,NULL);
		click_list_set (rn_ast, $<value>1);
		}
	| Pushing_id Actual_generics Rename New_exports Undefine Redefine Select TE_END
		{
		inherit_context = ($3==NULL)&&($4==NULL)&&($5==NULL)&&($6==NULL)&&($7==NULL);
		rn_ast = create_node2(CLASS_TYPE_AS,click_list_elem($<value>1),$2);
		$$ = create_node6(PARENT_AS,rn_ast,$3,$4,$5,$6,$7);
		click_list_set (rn_ast, $<value>1);
		}
	;

Actual_generics:
	{$$ = NULL;}
	| Existing_generics
		{$$ = $1;}
	;

Rename:
		{$$ = NULL;}
	| TE_RENAME
		{$$ = NULL;}
	| TE_RENAME {list_init();} Rename_list
		{$$ = list_new(CONSTRUCT_LIST_AS);}
	;

Rename_list:
	Rename_pair
		{list_push($1);}
	| Rename_list TE_COMMA Rename_pair
		{list_push($3);}
	;

Rename_pair:
	Feature_name TE_AS Feature_name
		{
		$$ = create_node2(RENAME_AS,click_list_elem($<value>1),click_list_elem($<value>3));
		click_list_set (click_list_elem($<value>3), $<value>1);
		}
	;

New_exports:	 /* empty */
					{$$ = NULL;}
	| 			TE_EXPORT {list_init();} New_export_list
					{$$ = list_new(CONSTRUCT_LIST_AS);}
	|			TE_EXPORT ASemi
					{$$ = NULL;}
	;

New_export_list: 
    New_export_item ASemi
		{list_push($1);}
	| New_export_list New_export_item ASemi
		{list_push($2);}
	;

New_export_item: Client_list Feature_set
		{	$$ = create_node1(CLIENT_AS,$1);
			$$ = create_node2(EXPORT_ITEM_AS,$$,$2);
		}
	;

Feature_set:
	TE_ALL			
		{$$ = create_node(ALL_AS);}
	| {list_init();} Feature_list
		{$$ = create_node1 (FEATURE_LIST_AS,list_new(CONSTRUCT_LIST_AS));}
	;

Feature_list:
	Feature_name
		{list_push(click_list_elem($<value>1));}
	| Feature_list TE_COMMA Feature_name
		{list_push(click_list_elem($<value>3));}
	;

Undefine:
		{$$ = NULL;}
	| TE_UNDEFINE
		{$$ = NULL;}
	| TE_UNDEFINE {list_init();} Feature_list
		{$$ = list_new(CONSTRUCT_LIST_AS);}
	;

Redefine:
		{$$ = NULL;}
	| TE_REDEFINE
		{$$ = NULL;}
	| TE_REDEFINE {list_init();} Feature_list
		{$$ = list_new(CONSTRUCT_LIST_AS);}
	;

Select:
		{$$ = NULL;}
	| TE_SELECT
		{$$ = NULL;}
	| TE_SELECT {list_init();} Feature_list
		{$$ = list_new(CONSTRUCT_LIST_AS);}
	;

/*
 * feature declaration
 */

Formal_arguments:		/* empty */
							{$$ = NULL;}
	|					TE_LPARAN TE_RPARAN
							{yyerror((char *)0);}
	|					TE_LPARAN {list_init();} Entity_declaration_list TE_RPARAN
							{$$ = list_new(CONSTRUCT_LIST_AS);}
	;

Entity_declaration_list:	/* empty */
	|						Entity_declaration_list Entity_declaration_group
								{list_push($2);}
	;

Entity_declaration_group:	{list_init();} Identifier_list {$$ = list_new(CONSTRUCT_LIST_AS);} TE_COLON Type ASemi
								{$$ = create_node2(TYPE_DEC_AS,$<node>3,$5);}
	;

Identifier_list: 			Identifier
								{list_push($1);}
	|						Identifier_list TE_COMMA Identifier
								{list_push($3);}
	;

Strip_identifier_list:		/* empty */
	|						Identifier_list
	;

Type_mark:					/* empty */
								{$$ = NULL;}
	|						TE_COLON Type
								{$$ = $2;}
	;


Routine:					Obsolete {fbody_pos = current_location->start_position;} 
							Precondition Local_declarations
							Routine_body Postcondition Rescue TE_END
								{$$ = create_routine_as($1,fbody_pos,$3,$4,$5,$6,$7);}
	;

Routine_body: 				Internal
								{$$ = $1;}
	|						External
								{$$ = $1;}
	|						TE_DEFERRED
								{$$ = create_node(DEFERRED_AS);}
	;

External:					TE_EXTERNAL External_language External_name
								{$$ = create_node2(EXTERNAL_AS,$2,$3);}
	;

External_language:			{SET_POS(current_location);} Non_empty_string
								{$$ = create_node1(EXTERNAL_LANG_AS, $2);}
	;

External_name:				/* empty */
								{$$ = NULL;}
	|						TE_ALIAS Non_empty_string
								{$$ = $2;}
	;

Internal:					TE_DO {list_init();} Compound
								{$$ = create_node1(DO_AS,list_new(CONSTRUCT_LIST_AS));}
	|						TE_ONCE {list_init();} Compound
								{$$ =
create_node1(ONCE_AS,list_new(CONSTRUCT_LIST_AS));}
	;


Local_declarations:			/* empty */
								{$$ = NULL;}
	|						TE_LOCAL {list_init();} Entity_declaration_list
								{$$ = list_new(CONSTRUCT_LIST_AS);}
	;

Compound:					Instructionl Set_position Instruction1 Opt_Semi
								{list_push($3);}
	|						/* empty */ Opt_Semi
	;
Opt_Semi:					Opt_Semi TE_SEMICOLON
	|						/* empty */
	;
Instructionl:				Instructionl Set_position Instruction1 Opt_Semi
								{list_push($3);}
	|						/* empty */ Opt_Semi
	;
Instruction1:
							Creation
								{$$ = $1;}
	|						Call
								{$$ = $1;}
	|						Assignment
								{$$ = $1;}
	|						Reverse_assignment
								{$$ = $1;}
	|						Conditional
								{$$ = $1;}
	|						Multi_branch
								{$$ = $1;}
	|						Loop
								{$$ = $1;}
	|						Debug
								{$$ = $1;}
	|						Check
								{$$ = $1;}
	|						Retry
								{$$ = $1;}
	;

Precondition:				/* empty */
								{$$ = NULL;}
	|						TE_REQUIRE {id_level = ASSERT_LEVEL;} Assertion
								{	id_level = NORMAL_LEVEL;
									$$ = create_node1(REQUIRE_AS,$3);
								}
	|						TE_REQUIRE TE_ELSE {id_level = ASSERT_LEVEL;} Assertion
								{	id_level = NORMAL_LEVEL;
									$$ = create_node1(REQUIRE_ELSE_AS,$4);
								}
	;

Postcondition:				/* empty */
								{$$ = NULL;}
	|						TE_ENSURE {id_level = ASSERT_LEVEL;} Assertion
								{	id_level = NORMAL_LEVEL;
									$$ = create_node1(ENSURE_AS,$3);
								}
	|						TE_ENSURE TE_THEN {id_level = ASSERT_LEVEL;} Assertion
								{	id_level = NORMAL_LEVEL;
									$$ = create_node1(ENSURE_THEN_AS,$4);
								}
	;


Assertion:					{list_init();} Assertion_list 
								{$$ = list_new(CONSTRUCT_LIST_AS);}
	;

Assertion_list:				/* empty */
	|						Assertion_list_non_empty
	;
Assertion_list_non_empty:	Set_position Assertion_clause ASemi
								{list_push($2);}
	|						Assertion_list_non_empty Set_position Assertion_clause ASemi
								{list_push($3);}
	;

Assertion_clause: 			Expression
								{
									$<node>$ = create_node2(TAGGED_AS,NULL,$1);
								}
	|						Identifier TE_COLON Expression
								{
									$<node>$ = create_node2(TAGGED_AS,$1,$3);
								}
	|						Identifier TE_COLON 
								{ $$ = NULL;}
	;

/*
 * Type
 */


Type:
	Pushing_id
		{
		$$ = create_type_class(click_list_elem($<value>1),NULL);
		click_list_set ($$, $<value>1);
		}
	| Pushing_id Existing_generics
		{
		$$ = create_type_class(click_list_elem($<value>1),$2);
		click_list_set ($$, $<value>1);
		}
	| TE_EXPANDED Pushing_id
		{
		$$ = create_exp_class_type(click_list_elem($<value>2),NULL);
		click_list_set ($$, $<value>2);
		}
	| TE_EXPANDED Pushing_id Existing_generics
		{
		$$ = create_exp_class_type(click_list_elem($<value>2),$3);
		click_list_set ($$, $<value>2);
		}
	| TE_SEPARATE Pushing_id
		{
		$$ = create_separate_class_type(click_list_elem($<value>2),NULL);
		click_list_set ($$, $<value>2);
		}
	| TE_SEPARATE Pushing_id Existing_generics
		{
		$$ = create_separate_class_type(click_list_elem($<value>2),$3);
		click_list_set ($$, $<value>2);
		}
	| TE_BIT Integer_constant
		{
		$$ = create_node1(BITS_AS,$2);
		}
	| TE_BIT Identifier
		{
		$$ = create_node1(BITS_SYMBOL_AS,$2);
		}
	| TE_LIKE Identifier
		{
		$$ = create_node1(LIKE_ID_AS, $2);
		}
	| TE_LIKE TE_CURRENT
		{
		$$ = create_node(LIKE_CUR_AS);
		}
	;

Class_type:
    Pushing_id
        {
        $$ = create_type_class(click_list_elem($<value>1),NULL);
        click_list_set ($$, $<value>1);
        }
    | Pushing_id Existing_generics
        {
        $$ = create_type_class(click_list_elem($<value>1),$2);
        click_list_set ($$, $<value>1);
        }
	;

Existing_generics:
	TE_LSQURE TE_RSQURE
		{$$ = NULL;}
	| TE_LSQURE {list_init();} Type_list TE_RSQURE
		{
		$$ = list_new(CONSTRUCT_LIST_AS);
		}
	;
		
Type_list:
	Type
		{list_push($1);}
	| Type_list TE_COMMA Type
		{list_push($3);}
	;

/*
 * Formal generics
 */

Formal_generics:
		{
		$$ = NULL;
		}
	| TE_LSQURE {list_init();} Formal_generic_list TE_RSQURE
		{
		$$ = list_new(CONSTRUCT_LIST_AS);
		}
	;

Formal_generic_list:
	/* empty */
	| Formal_generic
		{list_push($1);}
	| Formal_generic_list TE_COMMA Formal_generic
		{list_push($3);}
	;

Formal_generic:
	TE_ID {strcpy(generic_name, token_str);} Constraint Creation_constraint
		{generic_inc(); $$ = create_generic(generic_name, $3, $4);}
    ;

Constraint:
	/* empty */
	{$$ = NULL;}
    | TE_CONSTRAIN Class_type 
		{$$ = $2;}
    ;

Creation_constraint:
	/* empty */
	{ $$ = NULL;}
	| TE_CREATION {list_init ();} Feature_list
		{$$ = create_node2 (CREATE_AS, NULL, list_new (CONSTRUCT_LIST_AS));}	
	;

/*
 * Instructions
 */

Conditional:				{$<loc>$ = current_location;} TE_IF Expression TE_THEN {list_init();} Compound {$$ = list_new(CONSTRUCT_LIST_AS);} Elsif Else_part TE_END
								{SET_POS($<loc>1); $$ = create_node4(IF_AS,$3,$<node>7,$8,$9);}
	;

Elsif:						/* empty */
								{$$ = NULL;}
	|						{list_init();} Elsif_list 
								{$$ = list_new(CONSTRUCT_LIST_AS);}
	;

Elsif_list:					Elsif_part
								{list_push($1);}
	|						Elsif_list Elsif_part
								{list_push($2);}
	;

Elsif_part:					TE_ELSEIF Expression TE_THEN {list_init();} Compound
								{$$ = create_node2(ELSIF_AS,$2,list_new(CONSTRUCT_LIST_AS));}
	;

Inspect_default:            /* empty */
                                {$$ = NULL;}
    |                       TE_ELSE {list_init();} Compound
                                {$$ = inspect_else();}
    ;
 
Else_part:					/* empty */
								{$$ = NULL;}
	|						TE_ELSE {list_init();} Compound 
								{$$ = list_new(CONSTRUCT_LIST_AS);}
	;

Multi_branch:				{$<loc>$ = current_location;} TE_INSPECT
							Expression {list_init();} When_part_list {$$ = list_new(CONSTRUCT_LIST_AS);}
							Inspect_default TE_END
								{SET_POS($<loc>1); $$ = create_node3(INSPECT_AS,$3,$<node>6,$7);}
	;

/*
When_part_list:				When_part
								{list_push($1);}
	|						When_part_list When_part
								{list_push($2);}
	;
*/

When_part_list:				/* empty */
	|						When_part When_part_list
								{list_push($1);}
	;

When_part:					TE_WHEN {list_init();} Choices {$$ = list_new(CONSTRUCT_LIST_AS);} TE_THEN {list_init();} Compound
								{$$ = create_node2(CASE_AS,$<node>4,list_new(CONSTRUCT_LIST_AS));}
	;

Choices:					Choice
								{list_push($1);}
	|						Choices TE_COMMA Choice
								{list_push($3);}
	;

Choice:						Integer_constant
				{$$ = create_node2(INTERVAL_AS,$1,NULL);}
	|						Character_constant
				{$$ = create_node2(INTERVAL_AS,$1,NULL);}
	|						Identifier
				{$$ = create_node2(INTERVAL_AS,$1,NULL);}
	|						Integer_constant TE_DOTDOT Integer_constant
				{$$ = create_node2(INTERVAL_AS,$1,$3);}
	|						Integer_constant TE_DOTDOT Identifier
				{$$ = create_node2(INTERVAL_AS,$1,$3);}
	|						Identifier TE_DOTDOT Integer_constant
				{$$ = create_node2(INTERVAL_AS,$1,$3);}
	|						Identifier TE_DOTDOT Identifier
				{$$ = create_node2(INTERVAL_AS,$1,$3);}
	|						Character_constant TE_DOTDOT Character_constant
				{$$ = create_node2(INTERVAL_AS,$1,$3);}
	|						Identifier TE_DOTDOT Character_constant
				{$$ = create_node2(INTERVAL_AS,$1,$3);}
	|						Character_constant TE_DOTDOT Identifier
				{$$ = create_node2(INTERVAL_AS,$1,$3);}
	;

Loop:						{$<loc>$ = current_location;} TE_FROM {list_init();} Compound {$$ = list_new(CONSTRUCT_LIST_AS);} Invariant Variant TE_UNTIL Expression TE_LOOP {list_init();} Compound TE_END
								{SET_POS($<loc>1); $$ = create_node5(LOOP_AS,$<node>5,$6,$7,$9,list_new(CONSTRUCT_LIST_AS));}
	;

Invariant:					/* empty */
								{$$ = NULL;}
	|						TE_INVARIANT Assertion
								{$$ = $2;}
	;

Class_invariant:
		{$$ = NULL;}
	| TE_INVARIANT {id_level = INVARIANT_LEVEL;} Assertion
		{
		id_level = NORMAL_LEVEL;
		$$ = create_node1(INVARIANT_AS,$3);
		}
	;
					

Variant:					/* empty */
								{$$ = NULL;}
	|						TE_VARIANT Identifier TE_COLON Expression
								{$$ = create_node2(VARIANT_AS,$2,$4);}
	|						TE_VARIANT Expression
								{$$ = create_node2(VARIANT_AS,NULL,$2);}
	;

Debug:						{$<loc>$ = current_location; } TE_DEBUG Debug_keys {list_init();} Compound TE_END 
								{SET_POS($<loc>1); $$ = create_node2(DEBUG_AS,$3,list_new(CONSTRUCT_LIST_AS));}
	;

Debug_keys:					/* empty */
								{$$ = NULL;}
	|						TE_LPARAN TE_RPARAN
								{$$ = NULL;}
	|						TE_LPARAN {list_init();} Debug_key_list TE_RPARAN
								{$$ = list_new(CONSTRUCT_LIST_AS);}
	;

Debug_key_list:				Non_empty_string
								{list_push($1);}
	|						Debug_key_list TE_COMMA Non_empty_string
								{list_push($3);}
	;
							
Retry:						TE_RETRY
								{$$ = create_node(RETRY_AS);}
	;

Rescue:						/* empty */
								{$$ = NULL;}
	|						TE_RESCUE {list_init();} Compound 
								{$$ = rescue_instr();}
	;
/*
Assignment:					Set_position Identifier TE_ASSIGN Expression
								{$$ = create_node2(ASSIGN_AS,create_node2(ACCESS_ID_AS,$2,NULL),$4);}
	|						Set_position TE_RESULT TE_ASSIGN Expression
								{$$ = create_node2(ASSIGN_AS,create_node(RESULT_AS),$4);}
	;

Reverse_assignment:			Set_position Identifier TE_ACCEPT Expression
								{$$ = create_node2(REVERSE_AS,create_node2(ACCESS_ID_AS,$2,NULL),$4);}
	|						Set_position TE_RESULT TE_ACCEPT Expression
								{$$ = create_node2(REVERSE_AS,create_node(RESULT_AS),$4);}
	;
*/

Assignment:                 Identifier TE_ASSIGN Expression
                                {$$ = create_node2(ASSIGN_AS,create_node2(ACCESS_ID_AS,$1,NULL),$3);}
    |                       TE_RESULT TE_ASSIGN Expression
                                {$$ = create_node2(ASSIGN_AS,create_node(RESULT_AS),$3);}
    ;

Reverse_assignment:         Identifier TE_ACCEPT Expression
                                {$$ = create_node2(REVERSE_AS,create_node2(ACCESS_ID_AS,$1,NULL),$3);}
    |                       TE_RESULT TE_ACCEPT Expression
                                {$$ = create_node2(REVERSE_AS,create_node(RESULT_AS),$3);}
    ;


Creators:					/* empty */
								{$$ = NULL;}
	|						{list_init();} Creation_clause_list
								{$$ = list_new(CONSTRUCT_LIST_AS);}
	;

Creation_clause_list:		Creation_clause
								{list_push($1);}
	|						Creation_clause_list Creation_clause
								{list_push($2);}
	;

Creation_clause:			TE_CREATION
								{$$ = create_node2(CREATE_AS,NULL,NULL);}
	|						TE_CREATION Clients {list_init();} Feature_list
								{$$ = create_node2(CREATE_AS,$2,list_new(CONSTRUCT_LIST_AS));}
	|						TE_CREATION Client_list 
								{
									$$ = create_node1(CLIENT_AS,$2);
									$$ = create_node2(CREATE_AS,$$,NULL);
								}
	;

Creation:					TE_BANG Creation_type TE_BANG Creation_target Creation_call
								{$$ = create_node3(CREATION_AS,$2,$4,$5);}
	;

Creation_type:				/* empty */
								{$$ = NULL;}
	|						Type
								{$$ = $1;}
	;

Creation_target:			Identifier
								{$$ = create_node2(ACCESS_ID_AS,$1,NULL);}
	|						TE_RESULT
								{$$ = create_node(RESULT_AS);}
	;

Creation_call:				/* empty */
								{$$ = NULL;}
	|						TE_DOT Identifier Parameters
								{$$ = create_node2(ACCESS_INV_AS,$2,$3);}
	;

/*
 * Instruction call
 */
 
Call:						A_feature
								{$$ = create_node1(INSTR_CALL_AS,$1);}
	|						Call_on_result
								{$$ = create_node1(INSTR_CALL_AS,$1);}
	|						Call_on_feature
								{$$ = create_node1(INSTR_CALL_AS,$1);}
	|						Call_on_current
								{$$ = create_node1(INSTR_CALL_AS,$1);}
	|						Call_on_expression
								{$$ = create_node1(INSTR_CALL_AS,$1);}
	|						A_precursor
								{$$ = create_node1(INSTR_CALL_AS,$1);}
	|						Call_on_precursor
								{$$ = create_node1(INSTR_CALL_AS,$1);}
	;

Check:						{$<loc>$ = current_location; } TE_CHECK Assertion TE_END
								{SET_POS($<loc>1); $$ = create_node1(CHECK_AS,$3);}
	;

/*
 * expression
 */

Expression:					Expression_constant
								{yyerrok;$$ = create_node1(VALUE_AS,$1);}
	|						Manifest_array
								{yyerrok;$$ = create_node1(VALUE_AS,$1);}
	|						Feature_call
								{$$ = create_node1(EXPR_CALL_AS, $1);}
	|						TE_LPARAN Expression TE_RPARAN
								{$$ = create_node1(PARAN_AS, $2);}
	|						Expression TE_PLUS Expression
								{yyerrok;$$ = create_node2(BIN_PLUS_AS,$1,$3);}
	|						Expression TE_MINUS Expression
								{yyerrok;$$ = create_node2(BIN_MINUS_AS,$1,$3);}
	|						Expression TE_STAR Expression
								{yyerrok;$$ = create_node2(BIN_STAR_AS,$1,$3);}
	|						Expression TE_SLASH Expression
								{yyerrok;$$ = create_node2(BIN_SLASH_AS,$1,$3);}
	|						Expression TE_MOD Expression
								{yyerrok;$$ = create_node2(BIN_MOD_AS,$1,$3);}
	|						Expression TE_DIV Expression
								{yyerrok;$$ = create_node2(BIN_DIV_AS,$1,$3);}
	|						Expression TE_POWER Expression
								{yyerrok;$$ = create_node2(BIN_POWER_AS,$1,$3);}
	|						Expression TE_AND Expression
								{yyerrok;$$ = create_node2(BIN_AND_AS,$1,$3);}
	|						Expression TE_AND TE_THEN Expression %prec TE_AND
								{yyerrok;$$ = create_node2(BIN_AND_THEN_AS,$1,$4);}
	|						Expression TE_OR Expression
								{yyerrok;$$ = create_node2(BIN_OR_AS,$1,$3);}
	|						Expression TE_OR TE_ELSE Expression %prec TE_OR
								{yyerrok;$$ = create_node2(BIN_OR_ELSE_AS,$1,$4);}
	|						Expression TE_IMPLIES Expression
								{yyerrok;$$ = create_node2(BIN_IMPLIES_AS,$1,$3);}
	|						Expression TE_XOR Expression
								{yyerrok;$$ = create_node2(BIN_XOR_AS,$1,$3);}
	|						Expression TE_GE Expression
								{yyerrok;$$ = create_node2(BIN_GE_AS,$1,$3);}
	|						Expression TE_GT Expression
								{yyerrok;$$ = create_node2(BIN_GT_AS,$1,$3);}
	|						Expression TE_LE Expression
								{yyerrok;$$ = create_node2(BIN_LE_AS,$1,$3);}
	|						Expression TE_LT Expression
								{yyerrok;$$ = create_node2(BIN_LT_AS,$1,$3);}
	|						Expression TE_EQ Expression
								{yyerrok;$$ = create_node2(BIN_EQ_AS,$1,$3);}
	|						Expression TE_NE Expression
								{yyerrok;$$ = create_node2(BIN_NE_AS,$1,$3);}
	|						Expression Free_operator Expression %prec TE_FREE
								{	yyerrok;
									$$ = create_node3(BIN_FREE_AS,$1,$2,$3);}
	|						TE_MINUS Expression %prec TE_NOT
								{yyerrok;$$ = create_node1(UN_MINUS_AS,$2);}
	|						TE_PLUS Expression %prec TE_NOT
								{yyerrok;$$ = create_node1(UN_PLUS_AS,$2);}
	|						TE_NOT Expression
								{yyerrok;$$ = create_node1(UN_NOT_AS, $2);}
	|						TE_OLD Expression
								{yyerrok;$$ = create_node1(UN_OLD_AS,$2);}
	|						Free_operator Expression %prec TE_NOT
								{yyerrok;$$ = create_node2(UN_FREE_AS,$1,$2);}
	|						TE_STRIP {yyerrok;list_init();} TE_LPARAN Strip_identifier_list TE_RPARAN
								{yyerrok;$$ = create_node1(UN_STRIP_AS,list_new(CONSTRUCT_LIST_AS));}
	;

Actual_parameter:			Expression
								{$$ = $1;}
	|						TE_ADDRESS Feature_name
								{
								yyerrok;
								$$ = create_node1(ADDRESS_AS,click_list_elem($<value>2));
								}
	|						TE_ADDRESS TE_LPARAN Expression TE_RPARAN
								{
								yyerrok;
								$$ = create_node1(EXPR_ADDRESS_AS,$3);
								}
	|						TE_ADDRESS TE_CURRENT
								{yyerrok;$$ = create_node(ADDRESS_CURRENT_AS);}
	|						TE_ADDRESS TE_RESULT
								{yyerrok;$$ = create_node(ADDRESS_RESULT_AS);}
	;

Free_operator:				TE_FREE
								{$$ = create_id(token_str);}
	;

/*
 * expression call
 */

Feature_call:				Call_on_current
								{$$ = $1;}
	|						Call_on_result
								{$$ = $1;}
	|						Call_on_feature
								{$$ = $1;}
	|						TE_CURRENT
								{$$ = create_node(CURRENT_AS);}
	|						TE_RESULT
								{$$ = create_node(RESULT_AS);}
	|						A_feature
								{$$ = $1;}
	|						Call_on_expression
								{$$ = $1;}
	|						A_precursor
								{$$ = $1;}
	|						Call_on_precursor
								{$$ = $1;}
	;

Call_on_current:			TE_CURRENT TE_DOT Remote_call
								{$$ = create_node2(NESTED_AS,create_node(CURRENT_AS),$3);}
	;

Call_on_result:				TE_RESULT TE_DOT Remote_call
								{$$ = create_node2(NESTED_AS,create_node(RESULT_AS),$3);}
	;

Call_on_feature:			A_feature TE_DOT Remote_call
								{$$ = create_node2(NESTED_AS,$1,$3);}
	;

Call_on_expression:			TE_LPARAN Expression TE_RPARAN TE_DOT Remote_call
								{$$ = create_node2(NESTED_EXPR_AS,$2,$5);}
	;

Call_on_precursor:			A_precursor TE_DOT Remote_call
								{$$ = create_node2(NESTED_AS,$1,$3);}
	;

A_precursor:				TE_PRECURSOR Parameters
								{$$ = create_node2(PRECURSOR_AS,NULL,$2);}
	|						TE_LCURLY Pushing_id TE_RCURLY TE_PRECURSOR Parameters
								{
								$$ = create_node2(PRECURSOR_AS,click_list_elem ($<value>2),$5);
								click_list_set ($$, $<value>2);
								}
	|						TE_LCURLY TE_LCURLY Pushing_id TE_RCURLY TE_RCURLY TE_PRECURSOR Parameters
								{
								$$ = create_node2(PRECURSOR_AS,click_list_elem ($<value>3),$7);
								click_list_set ($$, $<value>3);
								}
	;

Remote_call:				Call_on_feature_access
								{$$ = $1;}
	|						Feature_access
								{$$ = $1;}
	;

Call_on_feature_access:		Feature_access TE_DOT Feature_access
								{$$ = create_node2(NESTED_AS,$1,$3);}
	|						Feature_access TE_DOT Call_on_feature_access
								{$$ = create_node2(NESTED_AS,$1,$3);}
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
						}
	;

Feature_access:				Identifier Parameters
								{$$ = create_node2(ACCESS_FEAT_AS,$1,$2);}
	;

Parameters:					/* empty */
								{$$ = NULL;}
	|						TE_LPARAN TE_RPARAN
								{$$ = NULL;}
	|						TE_LPARAN {list_init();} Parameter_list TE_RPARAN
								{$$ = list_new(CONSTRUCT_LIST_AS);}
	;

Parameter_list:				Actual_parameter
								{list_push($1);}
	|						Parameter_list TE_COMMA Actual_parameter
								{list_push($3);}
	;

Expression_list:			Expression
								{list_push($1);}
	|						Expression_list TE_COMMA Expression
								{list_push($3);}
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
				}
	;

Manifest_constant:		Boolean_constant
							{$$ = $1;}
	|					Character_constant
							{$$ = $1;}
	|					Integer_constant
							{$$ = $1;}
	|					Real_constant
							{$$ = $1;}
	|					Bit_constant
							{$$ = $1;}
	|					Manifest_string
							{$$ = $1;}
	;

Expression_constant:	Boolean_constant
							{$$ = $1;}
	|				   Character_constant
							{$$ = $1;}
	|				   TE_INTEGER
							{$$ = create_int(token_str,0);}
	|				   TE_REAL
							{$$ = create_real(token_str,0);}
	|				   Bit_constant
							{$$ = $1;}
	|				   Manifest_string
							{$$ = $1;}
	;

Boolean_constant:		TE_FALSE
							{$$ = create_bool(0);}
	|					TE_TRUE
							{$$ = create_bool(1);}
	;

Character_constant:		TE_CHAR
							{$$ = create_char(token_str);}
	;

Integer_constant:		Sign TE_INTEGER
							{$$ = create_int(token_str,$1);}
	;

Sign:					/* empty */
							{$$ = 0;}
	|					TE_PLUS
							{$$ = 0;}
	|					TE_MINUS
							{$$ = 1;}
	;

Real_constant:			Sign TE_REAL
							{$$ = create_real(token_str,$1);}
	;

Bit_constant:			TE_A_BIT
							{$$ = create_node1(BIT_CONST_AS,create_id(token_str));}
	;

Manifest_string:		TE_STRING
							{$$ = create_string(token_str);}
	|					EIF_ERROR6
							{$$ = create_string(token_str);}
	;

Non_empty_string:		TE_STRING
							{$$ = create_string(token_str);}
	;

Manifest_array:			TE_LARRAY {list_init();} Manifest_expression_list TE_RARRAY
							{$$ = create_node1(ARRAY_AS,list_new(CONSTRUCT_LIST_AS));}
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
