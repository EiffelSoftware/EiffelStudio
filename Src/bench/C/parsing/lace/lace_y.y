
/* "$Id$" */


%{
#include "lace_c.h"
#undef NULL
#define NULL (char *) 0
%}

%union {
	char *node;
	int  value;
}

%start Ace_or_Properties;

%token LAC_ADAPT;
%token LAC_ALL;
%token LAC_AS;
%token LAC_ASSERTION
%token LAC_C;
%token LAC_CHECK;
%token LAC_CLUSTER;
%token LAC_COLUMN;
%token LAC_COMMA;
%token LAC_COMMENT;
%token LAC_CREATION;
%token LAC_DEBUG;
%token LAC_DEFAULT;
%token LAC_END;
%token LAC_ENSURE;
%token LAC_EXCLUDE;
%token LAC_EXECUTABLE;
%token LAC_EXPORT;
%token LAC_EXTERNAL;
%token LAC_GENERATE;
%token LAC_IDENTIFIER;
%token LAC_IGNORE;
%token LAC_INCLUDE;
%token LAC_INVARIANT;
%token LAC_LEFT_PARAM;
%token LAC_LOOP;
%token LAC_MAKE;
%token LAC_NO;
%token LAC_OBJECT;
%token LAC_OPTIMIZE;
%token LAC_OPTION;
%token LAC_RENAME;
%token LAC_REQUIRE;
%token LAC_RIGHT_PARAM;
%token LAC_ROOT;
%token LAC_SEMICOLON;
%token LAC_STRING;
%token LAC_SYSTEM;
%token LAC_TRACE;
%token LAC_USE;
%token LAC_VISIBLE;
%token LAC_YES;
%token LAC_WHITE;

/* Error tokens */
%token LAC_ERROR2
%token LAC_ERROR3
%token LAC_ERROR4
%token LAC_ERROR6
%token LAC_ERROR7

%type <node>			Ace System Root Cluster_mark Creation_procedure Clusters
						Cluster_clause Cluster_tag Use Include
						Exclude File_clause Name_adapt Cluster_adapt_clause
						Cluster_ignore Cluster_rename_clause Class_rename_pair
						Defaults Options D_option_clause O_option_clause Target_list
						Name_star Option_mark Option_value Standard_value Class_value
						Externals Language_contrib Language_name Generation
						Language_generation Generate_option Generate_option_value
						Visible Class_visi_list Class_visibility
						Creation_restriction Export_restriction External_rename
						ExternaL_rename_pair Name Ace Cluster_properties
						Option_name External_name

%%

Ace_or_Properties:		Ace
							{rn_ast = $1;}
						| Cluster_properties LAC_END
							{rn_ast = $1;}
						;

Ace                     : System Root Defaults Clusters Externals Generation LAC_END
							{
							$$ = create_node7 (ACE_SD,$1,$2,$3,$4,$5,$6,click_list_new());
							}
                        ;

System                  : LAC_SYSTEM {click_list_init();} Name
							{$$ = $3;}
                        ;

Root                    : LAC_ROOT Name {$<value>$ = click_list_push ();}
						Cluster_mark Creation_procedure
							{
							$$ = create_node3 (ROOT_SD,$2,$4,$5);
							click_list_set ($$, $<value>3);
							}
                        ;

Cluster_mark            : /* empty */
                            {$$ = NULL;}
						| LAC_LEFT_PARAM Name LAC_RIGHT_PARAM
							{$$ = $2;}
                        ;

Creation_procedure        : /* empty */
							{$$ = NULL;}
                        | LAC_COLUMN Name
							{$$ = $2;}
                        ;

Clusters                : /* empty */
							{$$ = NULL;}
                        | LAC_CLUSTER {list_init();} Cluster_clause_list
							{$$ = list_new(CONSTRUCT_LIST_SD);}
                        ;

Cluster_clause_list     : Cluster_clause
							{list_push($1);}
                        | Cluster_clause_list LAC_SEMICOLON Cluster_clause
							{list_push($3);}
                        ;

Cluster_clause          : /* empty */
							{$$ = NULL;}
/* Recude/Reduce conflict here */
                        | Cluster_tag Name
							{$$ = create_node3 (CLUSTER_SD,$1,$2,NULL);}
                        | Cluster_tag Name LAC_END
							{$$ = create_node3 (CLUSTER_SD,$1,$2,NULL);}
                        | Cluster_tag Name Cluster_properties LAC_END
							{$$ = create_node3 (CLUSTER_SD,$1,$2,$3);}
                        ;

Cluster_tag             : Name LAC_COLUMN
							{$$ = $1;}
                        ;

Cluster_properties  	: Use Include Exclude Name_adapt Defaults Options Visible 
							{$$ = create_node7 (CLUST_PROP_SD,$1,$2,$3,$4,$5,$6,$7);}
                        ;

Use                     : /* empty */
							{$$ = NULL;}
                        | LAC_USE Name
							{$$ = $2;}
                        ;

Include                 : /* empty */
							{$$ = NULL;}
						| LAC_INCLUDE {$$ = NULL;}
                        | LAC_INCLUDE {list_init();} Include_file_list
							{$$ = list_new(CONSTRUCT_LIST_SD);}
                        ;

Exclude                 : /* empty */
							{$$ = NULL;}
						| LAC_EXCLUDE {$$ = NULL;}
                        | LAC_EXCLUDE {list_init();} Exclude_file_list
							{$$ = list_new(CONSTRUCT_LIST_SD);}
                        ;

Include_file_list		: Name
							{list_push(create_node1(INCLUDE_SD,$1));}
						|	Include_file_list LAC_SEMICOLON Name
							{list_push(create_node1(INCLUDE_SD,$3));}
						;

Exclude_file_list		: Name
							{list_push(create_node1(EXCLUDE_SD,$1));}
						|   Exclude_file_list LAC_SEMICOLON Name
							{list_push(create_node1(EXCLUDE_SD,$3));}
						;

File_list               : File_clause
							{list_push($1);}
                        | File_list LAC_SEMICOLON File_clause
							{list_push($3);}
                        ;

File_clause             : Name
							{$$ = $1;}
                        ;

Name_adapt              : /* empty */
							{$$ = NULL;}
                        | LAC_ADAPT {list_init();} Cluster_adapt_list
							{$$ = list_new(CONSTRUCT_LIST_SD);}
                        ;

Cluster_adapt_list      : Cluster_adapt_clause
							{list_push($1);}
                        | Cluster_adapt_list LAC_SEMICOLON Cluster_adapt_clause
							{list_push($3);}
                        ;

Cluster_adapt_clause    : /* empty */
							{$$ = NULL;}
                        | Cluster_ignore
							{$$ = create_node1 (CLUST_IGN_SD,$1);}
                        | Cluster_rename_clause
							{$$ = create_node2 (CLUST_REN_SD,$1,list_new(CONSTRUCT_LIST_SD));}
                        ;

Cluster_ignore          : Name LAC_COLUMN LAC_IGNORE
							{$$ = $1;}
                        ;

Cluster_rename_clause   : Name LAC_COLUMN LAC_RENAME {list_init();} Class_rename_list
							{$$ = $1;}
                        ;

Class_rename_list       : Class_rename_pair
							{list_push($1);}
                        | Class_rename_list LAC_COMMA Class_rename_pair
							{list_push($3);}
                        ;

Class_rename_pair		: Name LAC_AS Name
							{$$ = create_node2 (TWO_NAME_SD,$1,$3);}
                        ;

Defaults                : /* empty */
							{$$ = NULL;}
                        | LAC_DEFAULT {list_init();} D_option_clause_list
							{$$ = list_new(CONSTRUCT_LIST_SD);}
                        ;

Options                 : /* empty */
							{$$ = NULL;}
                        | LAC_OPTION {list_init();} O_option_clause_list
							{$$ = list_new(CONSTRUCT_LIST_SD);}
                        ;

D_option_clause_list    : D_option_clause
							{list_push($1);}
                        | D_option_clause_list LAC_SEMICOLON D_option_clause
							{list_push($3);}
                        ;

D_option_clause         : /* empty */
							{$$ = NULL;}
                        | Option_name Option_mark
							{$$ = create_node2 (D_OPTION_SD,$1,$2);}
                        ;

Option_name				:	LAC_ASSERTION
							{$$ = create_node(ASSERTION_SD);}
						| LAC_DEBUG
							{$$ = create_node(DEBUG_SD);}
						| LAC_OPTIMIZE
							{$$ = create_node(OPTIMIZE_SD);}
						| LAC_TRACE
							{$$ = create_node(TRACE_SD);}
						| Name
							{$$ = create_node1(FREE_OPTION_SD,$1);}
						;

O_option_clause_list    : O_option_clause
							{list_push($1);}
                        | O_option_clause_list LAC_SEMICOLON O_option_clause
							{list_push($3);}
                        ;

O_option_clause         : /* empty */
							{$$ = NULL;}
                        | Option_name Option_mark Target_list
							{$$ = create_node3 (O_OPTION_SD,$1,$2,$3);}
                        ;

Target_list             : /* empty */
							{$$ = NULL;}
                        | LAC_COLUMN Name
								{list_init(); list_push ($2);}
							Class_name_list
								{$$ = list_new(CONSTRUCT_LIST_SD);}
                        ;

Class_name_list         : Name_star
							{list_push($1);}
                        | Class_name_list LAC_COMMA Name_star
							{list_push($3);}
                        ;

Name_star               : /* empty */
							{$$ = NULL;}
                        | Name
							{$$ = $1;}
                        ;

Option_mark             : /* empty */
							{$$ = NULL;}
                        | LAC_LEFT_PARAM Option_value LAC_RIGHT_PARAM
							{$$ = $2;}
                        ;

Option_value            : Standard_value
							{$$ = $1;}
                        | Class_value
							{$$ = $1;}
                        | Name
							{$$ = create_node1 (NAME_SD,$1);}
                        ;

Standard_value          : LAC_YES
							{$$ = create_node1(YES_SD,lace_id("yes",start_position,end_position));}
                        | LAC_NO
							{$$ = create_node1(NO_SD,lace_id("no",start_position,end_position));}
                        | LAC_ALL
							{$$ = create_node1(ALL_SD,lace_id("all",start_position,end_position));}
                        ;

Class_value             : LAC_REQUIRE
							{$$ = create_node1(REQUIRE_SD,lace_id("require",start_position,end_position));}
                        | LAC_ENSURE
							{$$ = create_node1(ENSURE_SD,lace_id("ensure",start_position,end_position));}
                        | LAC_INVARIANT
							{$$ = create_node1(INVARIANT_SD,lace_id("invariant",start_position,end_position));}
                        | LAC_LOOP
							{$$ = create_node1(LOOP_SD,lace_id("loop",start_position,end_position));}
                        | LAC_CHECK
							{$$ = create_node1(CHECK_SD,lace_id("check",start_position,end_position));}
                        ;

Externals               : /* empty */
							{$$ = NULL;}
						| LAC_EXTERNAL {list_init();} Language_contrib_list
							{$$ = list_new(CONSTRUCT_LIST_SD);}
                        ;

Language_contrib_list   : Language_contrib
							{list_push($1);}
                        | Language_contrib_list LAC_SEMICOLON Language_contrib
							{list_push($3);}
                        ;

Language_contrib        : /* empty */
							{$$ = NULL;}
                        | Language_name LAC_COLUMN {list_init();} File_list
							{$$ = create_node2 (LANG_TRIB_SD,$1,list_new(CONSTRUCT_LIST_SD));}
                        ;

Language_name           : LAC_C
							{$$ =
		create_node1(C_NAME_SD,lace_id("c",start_position,end_position));}
						| LAC_MAKE
							{$$ =
		create_node1(MAKE_NAME_SD,lace_id("make",start_position,end_position));}
						| LAC_OBJECT
							{$$ =
		create_node1(OBJECT_NAME_SD,lace_id("object",start_position,end_position));}
						| LAC_EXECUTABLE
							{$$ =
		create_node1(EXECUTABLE_NAME_SD,lace_id("executable",start_position,end_position));}
                        | Name
							{$$ = create_node1(LANGUAGE_NAME_SD,$1);}
                        ;

Generation              : /* empty */
							{$$ = NULL;}
						| LAC_GENERATE {list_init();} Language_gen_list
							{$$ = list_new(CONSTRUCT_LIST_SD);}
                        ;

Language_gen_list       : Language_generation
							{list_push($1);}
                        | Language_gen_list LAC_SEMICOLON Language_generation
							{list_push($3);}
                        ;

Language_generation     : /* empty */
							{$$ = NULL;}
                        | Language_name Generate_option LAC_COLUMN Name
							{$$ = create_node3 (LANG_GEN_SD,$1,$2,$4);}
                        ;

Generate_option         : /* empty */
							{$$ = NULL;}
                        | LAC_LEFT_PARAM Generate_option_value LAC_RIGHT_PARAM
							{$$ = $2;}
                        ;

Generate_option_value   : LAC_YES
							{$$ = create_node (YES_SD);}
                        | LAC_NO
							{$$ = create_node (NO_SD);}
                        ;

Visible                 : /* empty */
							{$$ = NULL;}
                        | LAC_VISIBLE {list_init();} Class_visi_list
							{$$ = list_new(CONSTRUCT_LIST_SD);}
                        ;

Class_visi_list         : Class_visibility
							{list_push($1);}
                        | Class_visi_list LAC_SEMICOLON Class_visibility
							{list_push($3);}
                        ;

Class_visibility        : /* empty */
							{$$ = NULL;}
                        | Name
							{$$ = create_node5 (CLAS_VISI_SD,$1,NULL,NULL,NULL,NULL);}
                        | Name LAC_END
							{$$ = create_node5 (CLAS_VISI_SD,$1,NULL,NULL,NULL,NULL);}
						| Name External_name Creation_restriction Export_restriction External_rename LAC_END
							{$$ = create_node5 (CLAS_VISI_SD,$1,$2,$3,$4,$5);}
                        ;

External_name			: /* empty */
							{$$ = NULL;}
						| LAC_AS Name
							{$$ = $2;}
						;

Creation_restriction    : /* empty */
							{$$ = NULL;}
                        | LAC_CREATION {list_init();} Feature_name_list
							{$$ = list_new(CONSTRUCT_LIST_SD);}
                        ;

Export_restriction      : /* empty */
							{$$ = NULL;}
                        | LAC_EXPORT {list_init();} Feature_name_list
							{$$ = list_new(CONSTRUCT_LIST_SD);}
                        ;

Feature_name_list       : Name_star
							{list_push($1);}
                        | Feature_name_list LAC_COMMA Name_star
							{list_push($3);}
                        ;

External_rename         : /* empty */
							{$$ = NULL;}
                        | LAC_RENAME {list_init();} External_rename_list
							{$$ = list_new(CONSTRUCT_LIST_SD);}
                        ;

External_rename_list    : ExternaL_rename_pair
							{list_push($1);}
                        | External_rename_list LAC_COMMA ExternaL_rename_pair
							{list_push($3);}
                        ;

ExternaL_rename_pair    : /* empty */
							{$$ = NULL;}
                        | Name LAC_AS Name
							{$$ = create_node2 (TWO_NAME_SD,$1,$3);}
                        ;

Name                    : LAC_IDENTIFIER
							{$$ = lace_id (token_str,start_position,end_position);}
                        | LAC_STRING
							{$$ = lace_id (token_str,start_position,end_position);}
                        ;

%%

yywrap()
{
    return 1;
}
