%{
indexing

	description: "Lace parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class LACE_PARSER

inherit

	LACE_PARSER_SKELETON

creation

	make

%}

%start Ace_or_Properties

%token LAC_ADAPT LAC_ALL LAC_AS LAC_ASSEMBLY LAC_ASSERTION LAC_CHECK LAC_CLUSTER
%token LAC_COLON LAC_COMMA LAC_CREATION LAC_DEBUG LAC_DEFAULT LAC_DISABLED_DEBUG
%token LAC_END LAC_ENSURE LAC_EXCLUDE LAC_DEPEND LAC_EXPORT LAC_EXTERNAL
%token LAC_GENERATE LAC_IDENTIFIER LAC_IGNORE LAC_INCLUDE
%token LAC_INVARIANT LAC_LEFT_PARAM LAC_LOOP LAC_NO
%token LAC_OPTIMIZE LAC_OPTION LAC_PRECOMPILED LAC_RENAME LAC_REQUIRE
%token LAC_RIGHT_PARAM LAC_ROOT LAC_SEMICOLON LAC_STRING LAC_SYSTEM
%token LAC_TRACE LAC_USE LAC_VISIBLE LAC_YES LAC_LIBRARY

%type <ACE_SD>				Ace
%type <CLAS_VISI_SD>		Class_visibility
%type <CLUST_PROP_SD>		Cluster_properties
%type <CLUST_ADAPT_SD>		Cluster_adapt_clause
%type <CLUSTER_SD>			Cluster_clause
%type <ASSEMBLY_SD>			Assembly
%type <D_OPTION_SD>			D_option_clause
%type <ID_SD>				Name External_name Use Use_opt Parent_tag System Cluster_mark
							Creation_procedure
--%type <LANG_GEN_SD>			Language_generation
%type <LANG_TRIB_SD>		Language_contrib
%type <LANGUAGE_NAME_SD>	Language_name
%type <O_OPTION_SD>			O_option_clause
%type <OPT_VAL_SD>			Option_mark Option_value Standard_value Class_value
%type <OPTION_SD>			Option_name
%type <ROOT_SD>				Root
%type <TWO_NAME_SD>			External_rename_pair Class_rename_pair
--%type <YES_OR_NO_SD>		Generate_option Generate_option_value
%type <DEPEND_SD>			Depend_pair

%type <LACE_LIST [CLAS_VISI_SD]>	Class_visi_list Visible Visible_opt
%type <LACE_LIST [CLUST_ADAPT_SD]>	Name_adapt Name_adapt_opt Cluster_adapt_list
%type <LACE_LIST [CLUSTER_SD]>		Clusters Cluster_clause_list
%type <LACE_LIST [ASSEMBLY_SD]>		Assemblies Assembly_list
%type <LACE_LIST [D_OPTION_SD]>		D_option_clause_list Defaults Defaults_opt
%type <LACE_LIST [ID_SD]>			Feature_name_list Export_restriction Export_restriction_opt
									Creation_restriction Creation_restriction_opt Target_list
									Class_name_list File_list
%type <LACE_LIST [FILE_NAME_SD]>	Exclude Exclude_opt Exclude_file_list Include
									Include_opt Include_file_list
--%type <LACE_LIST [LANG_GEN_SD]>		Generation Language_gen_list
%type <LACE_LIST [LANG_TRIB_SD]>	Externals Language_contrib_list
%type <LACE_LIST [O_OPTION_SD]>		O_option_clause_list Options Options_opt
%type <LACE_LIST [TWO_NAME_SD]>		External_rename_list External_rename External_rename_opt
									Class_rename_list
%type <LACE_LIST [DEPEND_SD]>		Depend_list Depend

%type <PAIR [ID_SD, CLICK_AST]>		Clickable_name


%expect 2

%%


Ace_or_Properties: Ace
			{ ast := $1 }
	|	Cluster_properties
			{ ast := $1 }
	;

Ace: System Root Defaults_opt Clusters Assemblies Externals Generation LAC_END
			{ create $$.initialize ($1, $2, $3, $4, $5, $6, click_list) }
	;

System: LAC_SYSTEM Name
			{ $$ := $2 }
	;

Root: LAC_ROOT Clickable_name Cluster_mark Creation_procedure
			{
				create $$.initialize ($2.first, $3, $4)
				$2.second.set_node ($$)
			}
	;

Clickable_name: Name
			{ $$ := new_clickable_id ($1) }
	;

Cluster_mark: -- Empty
			-- { $$ := Void }
	|	LAC_LEFT_PARAM Name LAC_RIGHT_PARAM
			{ $$ := $2 }
	;

Creation_procedure: -- Empty
			-- { $$ := Void }
	|	LAC_COLON Name
			{ $$ := $2 }
	;

Clusters: LAC_CLUSTER Cluster_clause_list
			{ $$ := $2 }
	|	LAC_CLUSTER ASemi
			{ $$ := Void }
	;

Cluster_clause_list: Cluster_clause ASemi
			{
				create $$.make (10)
				$$.extend ($1)
			}
	|	Cluster_clause_list Cluster_clause ASemi
			{
				$$ := $1
				$$.extend ($2)
			}
	;

Cluster_clause: Name Parent_tag LAC_COLON Name
			{ create $$.initialize ($1, $2, $4, Void, False, False) }
	|	LAC_ALL Name Parent_tag LAC_COLON Name
			{ create $$.initialize ($2, $3, $5, Void, True, False) }
	|	LAC_LIBRARY Name Parent_tag LAC_COLON Name
			{ create $$.initialize ($2, $3, $5, Void, True, True) }
	|	Name Parent_tag LAC_COLON Name Cluster_properties LAC_END
			{ create $$.initialize ($1, $2, $4, $5, False, False) }
	|	LAC_ALL Name Parent_tag LAC_COLON Name Cluster_properties LAC_END
			{ create $$.initialize ($2, $3, $5, $6, True, False) }
	|	LAC_LIBRARY Name Parent_tag LAC_COLON Name Cluster_properties LAC_END
			{ create $$.initialize ($2, $3, $5, $6, True, True) }
	;

Parent_tag: -- Empty
			-- { $$ := Void }
	|	LAC_LEFT_PARAM Name LAC_RIGHT_PARAM
			{ $$ := $2 }
	;


Cluster_properties: Depend Use_opt Include_opt Exclude_opt Name_adapt_opt Defaults_opt Options_opt Visible_opt
			{ create $$.initialize ($1, $2, $3, $4, $5, $6, $7, $8) }
	|	Use Include_opt Exclude_opt Name_adapt_opt Defaults_opt Options_opt Visible_opt
			{ create $$.initialize (Void, $1, $2, $3, $4, $5, $6, $7) }
	|	Include Exclude_opt Name_adapt_opt Defaults_opt Options_opt Visible_opt
			{ create $$.initialize (Void, Void, $1, $2, $3, $4, $5, $6) }
	|	Exclude Name_adapt_opt Defaults_opt Options_opt Visible_opt
			{ create $$.initialize (Void, Void, Void, $1, $2, $3, $4, $5) }
	|	Name_adapt Defaults_opt Options_opt Visible_opt
			{ create $$.initialize (Void, Void, Void, Void, $1, $2, $3, $4) }
	|	Defaults Options_opt Visible_opt
			{ create $$.initialize (Void, Void, Void, Void, Void, $1, $2, $3) }
	|	Options Visible_opt
			{ create $$.initialize (Void, Void, Void, Void, Void, Void, $1, $2) }
	|	Visible
			{ create $$.initialize (Void, Void, Void, Void, Void, Void, Void, $1) }
	;

Depend: LAC_DEPEND Depend_list
			{ $$ := $2 }
	|
		LAC_DEPEND ASemi
			-- { $$ := Void }
	;

Depend_list: Depend_pair ASemi
			{
				create $$.make (10)
				$$.extend ($1)
			}
	|
		Depend_list Depend_pair ASemi
			{
				$$ := $1
				$$.extend ($2)
			}		
	;

Depend_pair: File_list LAC_COLON Name
			{ create $$.initialize ($1, $3) }
	;

Use_opt: -- Empty
			-- { $$ := Void }
	|
		Use
			{ $$ := $1 }
	;
		
Use: LAC_USE Name
			{ $$ := $2 }
	;

Include_opt: -- Empty
			-- { $$ := Void }
	|	Include
			{ $$ := $1 }
	;

Include: LAC_INCLUDE Include_file_list
			{ $$ := $2 }
	|	LAC_INCLUDE ASemi
			-- { $$ := Void }
	;

Exclude_opt: -- Empty
			-- { $$ := Void }
	|	Exclude
			{ $$ := $1 }
	;

Exclude: LAC_EXCLUDE Exclude_file_list
			{ $$ := $2 }
	|	LAC_EXCLUDE ASemi
			-- { $$ := Void }
	;

Include_file_list: Name ASemi
			{
				create $$.make (10)
				$$.extend (create {FILE_NAME_SD}.initialize ($1))
			}
	|	Include_file_list Name ASemi
			{
				$$ := $1
				$$.extend (create {FILE_NAME_SD}.initialize ($2))
			}
	;

Exclude_file_list: Name ASemi
			{
				create $$.make (10)
				$$.extend (create {FILE_NAME_SD}.initialize ($1))
			}
	|	Exclude_file_list Name ASemi
			{
				$$ := $1
				$$.extend (create {FILE_NAME_SD}.initialize ($2))
			}
	;

File_list: Name
			{
				create $$.make (10)
				$$.extend ($1)
			}
	|	File_list LAC_COMMA Name
			{
				$$ := $1
				$$.extend ($3)
			}
	;

Name_adapt_opt: -- Empty
			-- { $$ := Void }
	|	Name_adapt
			{ $$ := $1 }
	;

Name_adapt: LAC_ADAPT Cluster_adapt_list
			{ $$ := $2 }
	|	LAC_ADAPT ASemi
			-- { $$ := Void }
	;

Cluster_adapt_list: Cluster_adapt_clause ASemi
			{
				create $$.make (10)
				$$.extend ($1)
			}
	|	Cluster_adapt_list Cluster_adapt_clause ASemi
			{
				$$ := $1
				$$.extend ($2)
			}
	;

Cluster_adapt_clause: Name LAC_COLON LAC_IGNORE
			{ create {CLUST_IGN_SD} $$.initialize ($1) }
	|	Name LAC_COLON LAC_RENAME Class_rename_list
			{ create {CLUST_REN_SD} $$.initialize ($1, $4) }
	;

Class_rename_list: Class_rename_pair
			{
				create $$.make (10)
				$$.extend ($1)
			}
	|	Class_rename_list LAC_COMMA Class_rename_pair
			{
				$$ := $1
				$$.extend ($3)
			}
	;

Class_rename_pair: Name LAC_AS Name
			{ create $$.initialize ($1, $3) }
	;

Defaults_opt: -- Empty
			-- { $$ := Void }
	|	Defaults
			{$$ := $1 }
	;

Defaults: LAC_DEFAULT D_option_clause_list
			{ $$ := $2 }
	|	LAC_DEFAULT ASemi
			-- { $$ := Void }
	;

Options_opt: -- Empty
			-- { $$ := Void }
	|	Options
			{$$ := $1 }
	;

Options: LAC_OPTION O_option_clause_list
			{ $$ := $2 }
	|	LAC_OPTION ASemi
			-- { $$ := Void }
	;

D_option_clause_list: D_option_clause ASemi
			{
				create $$.make (10)
				$$.extend ($1)
			}
	|	D_option_clause_list D_option_clause ASemi
			{
				$$ := $1
				$$.extend ($2)
			}
	;

D_option_clause: LAC_PRECOMPILED Option_mark
			{ create {D_PRECOMPILED_SD} $$.initialize (Precompiled_keyword, $2, Void) }
	|	LAC_PRECOMPILED Option_mark LAC_END
			{ create {D_PRECOMPILED_SD} $$.initialize (Precompiled_keyword, $2, Void) }
	|	LAC_PRECOMPILED Option_mark External_rename LAC_END
			{ create {D_PRECOMPILED_SD} $$.initialize (Precompiled_keyword, $2, $3) }
	|	Option_name Option_mark
			{ create $$.initialize ($1, $2) }
	;

Option_name: LAC_ASSERTION
			{ $$ := Assertion_keyword }
	|	LAC_DEBUG
			{ $$ := Debug_keyword }
	|	LAC_DISABLED_DEBUG
			{ $$ := Disabled_debug_keyword }
	|	LAC_OPTIMIZE
			{ $$ := Optimize_keyword }
	|	LAC_TRACE
			{ $$ := Trace_keyword }
	|	Name
			{
				create {FREE_OPTION_SD} $$.initialize ($1)
				if not $$.is_valid then
					raise_error
				end
			}
	;

O_option_clause_list: O_option_clause ASemi
			{
				create $$.make (10)
				$$.extend ($1)
			}
	|	O_option_clause_list O_option_clause ASemi
			{
				$$ := $1
				$$.extend ($2)
			}
	;

O_option_clause: Option_name Option_mark Target_list
			{ create $$.initialize ($1, $2, $3) }
	;

Target_list: -- Empty
			-- { $$ := Void }
	|	LAC_COLON Class_name_list
			{ $$ := $2 }
	;

Class_name_list: Name
			{
				create $$.make (10)
				$$.extend ($1)
			}
	|	Class_name_list LAC_COMMA Name
			{
				$$ := $1
				$$.extend ($3)
			}
	;

Option_mark: -- Empty
			-- { $$ := Void }
	|	LAC_LEFT_PARAM Option_value LAC_RIGHT_PARAM
			{ $$ := $2 }
	;

Option_value: Standard_value
			{ $$ := $1 }
	|	Class_value
			{ $$ := $1 }
	|	Name
			{ create $$.make ($1) }
	;

Standard_value: LAC_YES
			{ $$ := Yes_keyword }
	|	LAC_NO
			{ $$ := No_keyword }
	|	LAC_ALL
			{ $$ := All_keyword }
	;

Class_value: LAC_REQUIRE
			{ $$ := Require_keyword }
	|	LAC_ENSURE
			{ $$ := Ensure_keyword }
	|	LAC_INVARIANT
			{ $$ := Invariant_keyword }
	|	LAC_LOOP
			{ $$ := Loop_keyword }
	|	LAC_CHECK
			{ $$ := Check_keyword }
	;

Assemblies:	-- Empty
		-- {$$ := Void }
	|	LAC_ASSEMBLY Assembly_list
			{ $$ := $2 }
	|	LAC_ASSEMBLY ASemi
		-- { $$ := Void }
	;

Assembly_list: Assembly ASemi
			{
				create $$.make (5)
				$$.extend ($1)
			}
	|	Assembly_list Assembly ASemi
			{
				$$ := $1
				$$.extend ($2)
			}
	;

Assembly: Name LAC_COLON Name
			{
					-- name: "assembly_name"
				create $$.initialize ($1, $3, Void, Void, Void)
			}
	|	Name LAC_COLON Name LAC_COMMA Name LAC_COMMA Name LAC_COMMA Name
			{
					-- name: "assembly_name", "version", "culture", "public_key_token"
				create $$.initialize ($1, $3, $5, $7, $9)
			}
	;

Externals: -- Empty
			-- { $$ := Void }
	|	LAC_EXTERNAL Language_contrib_list
			{ $$ := $2 }
	|	LAC_EXTERNAL ASemi
			-- { $$ := Void }
	;

Language_contrib_list: Language_contrib ASemi
			{
				create $$.make (10)
				$$.extend ($1)
			}
	|	Language_contrib_list Language_contrib ASemi
			{
				$$ := $1
				$$.extend ($2)
			}
	;

Language_contrib: Language_name LAC_COLON File_list
			{ create $$.initialize ($1, $3) }
	;

Language_name:
		Name
			{ create $$.initialize ($1) }
	;
 
Generation: -- Empty
	-- { $$ := Void }
	|	LAC_GENERATE Language_gen_list
--		{ $$ := $2 }
	|	LAC_GENERATE ASemi
--		{ $$ := Void }
	;
	
Language_gen_list: Language_generation ASemi
	{
--		create $$.make (10)
--		$$.extend ($1)
	}
	|	Language_gen_list Language_generation ASemi
	{
--		$$ := $1
--		$$.extend ($2)
	}
	;
	
Language_generation: Language_name Generate_option LAC_COLON Name
--		{ create $$.initiliaze ($1, $2, $4) }
	;
	
Generate_option: -- Empty
	-- { $$ := Void }
	|	LAC_LEFT_PARAM Generate_option_value LAC_RIGHT_PARAM
--		{ $$ := $2 }
	;
	
Generate_option_value: LAC_YES
--		{ $$ := Yes_keyword }
	|	LAC_NO
--		{ $$ := No_keyword } 
	;

Visible_opt: -- Empty
			-- { $$ := Void }
	|	Visible
			{ $$ := $1 }
	;

Visible: LAC_VISIBLE Class_visi_list
			{ $$ := $2 }
	|	LAC_VISIBLE ASemi
			-- { $$ := Void }
	;

Class_visi_list: Class_visibility ASemi
			{
				create $$.make (10)
				$$.extend ($1)
			}
	|	Class_visi_list Class_visibility ASemi
			{
				$$ := $1
				$$.extend ($2)
			}
	;

Class_visibility: Name
			{ create $$.initialize ($1, Void, Void, Void, Void) }
	|	Name LAC_END
			{ create $$.initialize ($1, Void, Void, Void, Void) }
	|	Name External_rename LAC_END
			{ create $$.initialize ($1, Void, Void, Void, $2) }
	|	Name Export_restriction External_rename_opt LAC_END
			{ create $$.initialize ($1, Void, Void, $2, $3) }
	|	Name Creation_restriction Export_restriction_opt External_rename_opt LAC_END
			{ create $$.initialize ($1, Void, $2, $3, $4) }
	|	Name External_name Creation_restriction_opt Export_restriction_opt External_rename_opt LAC_END
			{ create $$.initialize ($1, $2, $3, $4, $5) }
	;

External_name: LAC_AS Name
			{ $$ := $2 }
	;

Creation_restriction_opt: -- Empty
			-- { $$ := Void }
	|	Creation_restriction
			{ $$ := $1 }
	;

Creation_restriction: LAC_CREATION Feature_name_list
			{ $$ := $2 }
	;

Export_restriction_opt: -- Empty
			-- { $$ := Void }
	|	Export_restriction
			{ $$ := $1 }
	;

Export_restriction: LAC_EXPORT Feature_name_list
			{ $$ := $2 }
	;

Feature_name_list: -- Empty
			-- { $$ := Void }
	|	Name
			{
				create $$.make (10)
				$$.extend ($1)
			}
	|	Feature_name_list LAC_COMMA Name
			{
				$$ := $1
				$$.extend ($3)
			}
	;

External_rename_opt: -- Empty
			-- { $$ := Void }
	|	External_rename
			{ $$ := $1 }
	;

External_rename: LAC_RENAME External_rename_list
			{ $$ := $2 }
	;

External_rename_list: External_rename_pair
			{
				create $$.make (10)
				$$.extend ($1)
			}
	|	External_rename_list LAC_COMMA External_rename_pair
			{
				$$ := $1
				$$.extend ($3)
			}
	;

External_rename_pair: -- Empty
			-- { $$ := Void }
	|	Name LAC_AS Name
			{ create $$.initialize ($1, $3) }
	;

Name: LAC_IDENTIFIER
			{ $$ := new_id_sd (token_buffer, False) }
	|	LAC_STRING
			{ $$ := new_id_sd (token_buffer, True) }
	;

ASemi: -- Empty
	|	LAC_SEMICOLON
	;

%%

end -- class LACE_PARSER


--|----------------------------------------------------------------
--| Copyright (C) 1992-1999, Interactive Software Engineering Inc.
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
