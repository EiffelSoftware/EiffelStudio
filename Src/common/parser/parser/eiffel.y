%{
indexing

	description: "Eiffel parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_PARSER

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
%token		TE_COLON TE_COMMA TE_CREATION TE_LARRAY TE_RARRAY TE_RPARAN
%token		TE_LCURLY TE_RCURLY TE_LSQURE TE_RSQURE TE_CONSTRAIN
%token		TE_FALSE TE_TRUE TE_ACCEPT TE_ADDRESS TE_AS TE_ASSIGN
%token		TE_CHECK TE_CLASS TE_CURRENT TE_DEBUG TE_DEFERRED TE_DO
%token		TE_ELSE TE_ELSEIF TE_END TE_ENSURE TE_EXPANDED TE_EXPORT
%token		TE_EXTERNAL TE_FEATURE TE_FROM TE_FROZEN TE_IF TE_INDEXING
%token		TE_IN_END TE_INFIX TE_INHERIT TE_INSPECT TE_INVARIANT TE_IS
%token		TE_LIKE TE_LOCAL TE_LOOP TE_OBSOLETE TE_ONCE TE_PRECURSOR
%token		TE_PREFIX TE_REDEFINE TE_RENAME TE_REQUIRE TE_RESCUE
%token		TE_RESULT TE_RETRY TE_SELECT TE_SEPARATE
%token		TE_THEN TE_UNDEFINE TE_UNIQUE TE_UNTIL TE_VARIANT TE_WHEN
%token		TE_BOOLEAN_ID TE_CHARACTER_ID TE_DOUBLE_ID TE_INTEGER_ID
%token		TE_NONE_ID TE_POINTER_ID TE_REAL_ID
%token		EIF_ERROR2 EIF_ERROR3 EIF_ERROR4 EIF_ERROR5 EIF_ERROR6 EIF_ERROR7

%type <ACCESS_AS>			Creation_target A_feature
%type <ACCESS_FEAT_AS>		Feature_access
%type <ACCESS_INV_AS>		Creation_call
%type <ARRAY_AS>			Manifest_array
%type <ASSIGN_AS>			Assignment
%type <ATOMIC_AS>			Index_value Manifest_constant Expression_constant
%type <BIT_CONST_AS>		Bit_constant
%type <BODY_AS>				Declaration_body
%type <BOOL_AS>				Boolean_constant
%type <CALL_AS>				Remote_call Feature_call
%type <CASE_AS>				When_part
%type <CHAR_AS>				Character_constant
%type <CHECK_AS>			Check
%type <CLIENT_AS>			Clients
%type <CONTENT_AS>			Constant_or_routine Feature_value
%type <CREATE_AS>			Creation_clause
%type <CREATION_AS>			Creation
%type <CREATION_EXPR_AS>	Creation_expression
%type <DEBUG_AS>			Debug
%type <ELSIF_AS>			Elseif_part
%type <ENSURE_AS>			Postcondition
%type <EXPORT_ITEM_AS>		New_export_item
%type <EXPR_AS>				Expression Actual_parameter
%type <EXTERNAL_AS>			External
%type <EXTERNAL_LANG_AS>	External_language
%type <FEATURE_AS>			Feature_declaration
%type <FEATURE_CLAUSE_AS>	Feature_clause
%type <FEATURE_SET_AS>		Feature_set
%type <FORMAL_DEC_AS>		Formal_generic
%type <ID_AS>				Identifier Index Free_operator
%type <IF_AS>				Conditional
%type <INDEX_AS>			Index_clause
%type <INSPECT_AS>			Multi_branch
%type <INSTR_CALL_AS>		Call
%type <INSTRUCTION_AS>		Instruction Instruction_impl
%type <INTEGER_AS>			Integer_constant
%type <INTERNAL_AS>			Internal
%type <INTERVAL_AS>			Choice
%type <INVARIANT_AS>		Class_invariant
%type <LOOP_AS>				Loop
%type <NESTED_AS>			Call_on_feature_access Call_on_precursor
							Call_on_feature Call_on_result Call_on_current
%type <NESTED_EXPR_AS>		Call_on_expression
%type <PARENT_AS>			Parent Parent_clause
%type <PRECURSOR_AS>		A_precursor
%type <REAL_AS>				Real_constant
%type <RENAME_AS>			Rename_pair
%type <REQUIRE_AS>			Precondition
%type <RETRY_AS>			Retry
%type <REVERSE_AS>			Reverse_assignment
%type <ROUT_BODY_AS>		Routine_body
%type <ROUTINE_AS>			Routine
%type <ROUTINE_CREATION_AS>	Routine_creation
%type <STRING_AS>			Obsolete Manifest_string External_name Non_empty_string
%type <TAGGED_AS>			Assertion_clause Assertion_clause_impl
%type <TUPLE_AS>			Manifest_tuple
%type <TYPE>				Type Type_mark Class_type Constraint Creation_type
%type <TYPE_DEC_AS>			Entity_declaration_group
%type <VARIANT_AS>			Variant
%type <EIFFEL_LIST [ATOMIC_AS]>		Index_terms Index_terms_2n
%type <EIFFEL_LIST [CASE_AS]>		When_part_list_opt When_part_list_2n
%type <EIFFEL_LIST [CREATE_AS]>		Creators Creation_clause_list Creation_clause_list_2n
%type <EIFFEL_LIST [ELSIF_AS]>		Elseif_list_opt Elseif_list_2n
%type <EIFFEL_LIST [EXPORT_ITEM_AS]>	New_exports New_exports_opt New_export_list
									New_export_list_2n
%type <EIFFEL_LIST [EXPR_AS]>		Parameters Parameter_list Parameter_list_5n
									Expression_list_opt Expression_list_4n
%type <EIFFEL_LIST [FEATURE_AS]>	Feature_declaration_list_opt Feature_declaration_list_3n
%type <EIFFEL_LIST [FEATURE_CLAUSE_AS]>	Features Feature_clause_list
%type <EIFFEL_LIST [FEATURE_NAME]>	Feature_list Feature_list_3n Undefine Undefine_opt Redefine
									Redefine_opt Select Select_opt Creation_constraint
%type <EIFFEL_LIST [FORMAL_DEC_AS]>	Formal_generics Formal_generic_list_opt
									Formal_generic_list_2n
%type <EIFFEL_LIST [ID_AS]>			Client_list Class_list Class_list_2n Identifier_list
									Identifier_list_3n Strip_identifier_list
%type <EIFFEL_LIST [INDEX_AS]>		Indexing Index_list
%type <EIFFEL_LIST [INSTRUCTION_AS]>	Rescue Compound Instruction_list_5n Else_part
									Inspect_default
%type <EIFFEL_LIST [INTERVAL_AS]>	Choices Choices_2n
%type <EIFFEL_LIST [PARENT_AS]>		Inheritance Parent_list Parent_list_3n
%type <EIFFEL_LIST [RENAME_AS]>		Rename Rename_list Rename_list_3n
%type <EIFFEL_LIST [STRING_AS]>		Debug_keys Debug_key_list Debug_key_list_2n
%type <EIFFEL_LIST [TAGGED_AS]>		Assertion Assertion_list Assertion_list_3n Invariant
%type <EIFFEL_LIST [TYPE]>			Generics_opt Type_list Type_list_3n
%type <EIFFEL_LIST [TYPE_DEC_AS]>	Formal_arguments Entity_declaration_list_opt
									Entity_declaration_list_4n Local_declarations
%type <PAIR [ID_AS, CLICK_AST]>		Clickable_identifier Clickable_id Clickable_boolean
									Clickable_character Clickable_double Clickable_integer
									Clickable_none Clickable_pointer Clickable_real
%type <PAIR [FEATURE_NAME, CLICK_AST]>					Infix Prefix Feature_name New_feature
%type <PAIR [STRING_AS, CLICK_AST]>						Infix_operator Prefix_operator
%type <PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]>	New_feature_list New_feature_list_2n

%expect 69

%%


-- Root rule


Class_declaration:
		Indexing
		Header_mark
		TE_CLASS
		Clickable_identifier
		Formal_generics
		Obsolete
		Inheritance
		Creators
		Features
		Class_invariant
		TE_END
			{
				!! root_node.make ($4.first,
					is_deferred, is_expanded, is_separate,
					$1, $5, $7, $8, $9, $10, suppliers, $6, click_list,
					current_position.start_position)
				$4.second.set_node (root_node)
				yacc_error_code := 2
--!! f.make_open_append ("gibi.txt")
--f.put_string (filename)
--f.put_string ("     ")
--f.put_integer (click_list.count)
--f.new_line
--f.close
			}
	;

Clickable_identifier: Clickable_id
			{ $$ := $1 }
	|	Clickable_boolean
			{ $$ := $1 }
	|	Clickable_character
			{ $$ := $1 }
	|	Clickable_double
			{ $$ := $1 }
	|	Clickable_integer
			{ $$ := $1 }
	|	Clickable_none
			{ $$ := $1 }
	|	Clickable_pointer
			{ $$ := $1 }
	|	Clickable_real
			{ $$ := $1 }
	;

Clickable_id: TE_ID
			{
				!! id_as.make (token_buffer)
				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! $$
				$$.set_first (id_as)
				$$.set_second (clickable)
			}
	;

Clickable_boolean: TE_BOOLEAN_ID
			{
				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! $$
				$$.set_first (Boolean_id_as)
				$$.set_second (clickable)
			}
	;

Clickable_character: TE_CHARACTER_ID
			{
				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! $$
				$$.set_first (Character_id_as)
				$$.set_second (clickable)
			}
	;

Clickable_double: TE_DOUBLE_ID
			{
				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! $$
				$$.set_first (Double_id_as)
				$$.set_second (clickable)
			}
	;

Clickable_integer: TE_INTEGER_ID
			{
				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! $$
				$$.set_first (Integer_id_as)
				$$.set_second (clickable)
			}
	;

Clickable_none: TE_NONE_ID
			{
				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! $$
				$$.set_first (None_id_as)
				$$.set_second (clickable)
			}
	;

Clickable_pointer: TE_POINTER_ID
			{
				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! $$
				$$.set_first (Pointer_id_as)
				$$.set_second (clickable)
			}
	;

Clickable_real: TE_REAL_ID
			{
				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! $$
				$$.set_first (Real_id_as)
				$$.set_second (clickable)
			}
	;


-- Indexing


Indexing: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 5
			}
	|	TE_INDEXING Index_list
			{
				$$ := $2
				yacc_error_code := 7
			}
	|	TE_INDEXING 
			{
				$$ := Void
				yacc_error_code := 8
			}
	;

Index_list: Index_clause
			{
				!! $$.make (Initial_index_list_size)
				$$.extend ($1)
				yacc_error_code := 9
			}
	|	Index_list Index_clause
			{
				$$ := $1
				$$.extend ($2)
				yacc_error_code := 10
			}
	;

Index_clause: Index Index_terms ASemi
			{
				!! $$.make ($1, $2)
				yacc_error_code := 12
			}
	;

Index: Identifier TE_COLON
			{ $$ := $1 }
	|	-- /* empty */
			{
				$$ := Void
				yacc_error_code := 14
			}
	;

Index_terms: Index_value
			{
				!! $$.make (1)
				$$.extend ($1)
				yacc_error_code := 15
			}
	|	Index_terms_2n
			{ $$ := $1 }
	|	TE_SEMICOLON
			{
-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				!! $$.make (0)
			}
	;

Index_terms_2n: Index_value TE_COMMA Index_value
			{
				!! $$.make (Initial_index_terms_size)
				$$.extend ($1)
				$$.extend ($3)
			}
	|	Index_terms_2n TE_COMMA Index_value
			{
				$$ := $1
				$$.extend ($3)
				yacc_error_code := 16
			}
	;

Index_value: Identifier
			{ $$ := $1 }
	|	Manifest_constant
			{ $$ := $1 }
	;


-- Header mark


Header_mark: -- /* empty */
			{
				is_deferred := False
				is_expanded := False
				is_separate := False
				yacc_error_code := 19
			}
	|	TE_DEFERRED
			{
				is_deferred := True
				is_expanded := False
				is_separate := False
				yacc_error_code := 20
			}
	|	TE_EXPANDED
			{
				is_deferred := False
				is_expanded := True
				is_separate := False
				yacc_error_code := 21
			}
	|	TE_SEPARATE
			{
				is_deferred := False
				is_expanded := False
				is_separate := True
				yacc_error_code := 22
			}
	;


-- Obsolete


Obsolete: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 23
			}
	|	TE_OBSOLETE Manifest_string
			{
				$$ := $2
				yacc_error_code := 24
			}
	;


-- Features
 

Features: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 25
			}
	|	Feature_clause_list
			{
				$$ := $1
				if $$.empty then
					$$ := Void
				end
				yacc_error_code := 27
			}
	;

Feature_clause_list: Feature_clause
			{
				!! $$.make (Initial_feature_clause_list_size)
				if $1 /= Void then
					$$.extend ($1)
				end
				yacc_error_code := 28
			}
	|	Feature_clause_list Feature_clause
			{
				$$ := $1
				if $2 /= Void then
					$$.extend ($2)
				end
				yacc_error_code := 29
			}
	;

Feature_clause: TE_FEATURE
			{
				inherit_context := False
				fclause_pos := current_position.end_position
				yacc_error_code := 30
			}
		Clients Feature_declaration_list_opt
			{
				if $4 = Void then
					$$ := Void
				else
					!! $$.make ($3, $4, fclause_pos)
				end
				yacc_error_code := 32
			}
	;

Clients: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 33
			}
	|	Client_list
			{
				!! $$.make ($1)
				yacc_error_code:= 34
			}
	;

Client_list: TE_LCURLY TE_RCURLY
			{
				!! $$.make (1)
!! id_as.make ("none")
$$.extend (id_as)
--				dollar_list ($$).extend (create {ID_AS}.make ("none"))
				yacc_error_code := 35
			}
	|	TE_LCURLY Class_list TE_RCURLY
			{
				$$ := $2
				yacc_error_code := 37
			}
	|	TE_LCURLY error
			{
				yacc_error_code := 9999
				print ("error 9999%N")
				report_error ("")
			}
	|	TE_LCURLY Class_list error
			{
				yacc_error_code := 8888
				print ("error 88888%N")
				report_error ("")
			}
	;

Class_list: Identifier
			{
				!! $$.make (1)
				$$.extend ($1)
				yacc_error_code := 38
			}
	|	Class_list_2n
			{ $$ := $1 }
	;

Class_list_2n: Identifier TE_COMMA Identifier
			{
				!! $$.make (Initial_class_list_size)
				$$.extend ($1)
				$$.extend ($3)
			}
	|	Class_list_2n TE_COMMA Identifier
			{
				$$ := $1
				$$.extend ($3)
				yacc_error_code := 39
			}
	|	Identifier TE_COMMA error
			{
				yacc_error_code := 77777
				print ("error 77777%N")
				report_error ("")
			}
	|	Class_list_2n TE_COMMA error
			{
				yacc_error_code := 66666
				print ("error 6666%N")
				report_error ("")
			}
	;

Feature_declaration_list_opt: -- /* empty */
			{
				$$ := Void
			}
	|	Feature_declaration
			{
				!! $$.make (1)
				$$.extend ($1)
			}
	|	Feature_declaration Feature_declaration
			{
				!! $$.make (2)
				$$.extend ($1)
				$$.extend ($2)
			}
	|	Feature_declaration_list_3n
			{ $$ := $1 }
	;

Feature_declaration_list_3n: Feature_declaration Feature_declaration Feature_declaration
			{
				!! $$.make (Initial_feature_declaration_list_size)
				$$.extend ($1)
				$$.extend ($2)
				$$.extend ($3)
			}
	|	Feature_declaration_list_3n Feature_declaration
			{
				$$ := $1
				$$.extend ($2)
				yacc_error_code := 40
			}
	;

ASemi: -- /* empty */
	|	TE_SEMICOLON
	;

Feature_declaration: New_feature_list Declaration_body ASemi
			{
				!! $$.make ($1.first, $2, $1.second.start_position, current_position.start_position)
				$1.second.set_node ($$)
			}
	;

New_feature_list: New_feature
			{
				!! feature_name_list.make (1)
				feature_name_list.extend ($1.first)
				!! $$
				$$.set_first (feature_name_list)
				$$.set_second ($1.second)
			}
	|	New_feature_list_2n
			{ $$ := $1 }
	;

New_feature_list_2n: New_feature TE_COMMA New_feature
			{
				!! feature_name_list.make (Initial_new_feature_list_size)
				feature_name_list.extend ($1.first)
				feature_name_list.extend ($3.first)
				!! $$
				$$.set_first (feature_name_list)
				$$.set_second ($1.second)
			}
	|	New_feature_list_2n TE_COMMA New_feature
			{
				$$ := $1
				$$.first.extend ($3.first)
			}
	;

New_feature: Feature_name_mark Feature_name
			{
				$$ := $2
				yacc_error_code := 46
			}
	;

Feature_name_mark: -- /* empty */
			{
				is_frozen := False
				yacc_error_code := 47
			}
	|	TE_FROZEN
			{
				is_frozen := True
				yacc_error_code := 48
			}
	;

Feature_name: Clickable_identifier
			{
				!FEAT_NAME_ID_AS! feature_name.make ($1.first, is_frozen)
				$1.second.set_node (feature_name)
				!! $$
				$$.set_first (feature_name)
				$$.set_second ($1.second)
			}
	|	Infix
			{ $$ := $1 }
	|	Prefix
			{ $$ := $1 }
	;

Infix: TE_INFIX Infix_operator
			{
				!INFIX_AS! feature_name.make ($2.first, is_frozen)
				$2.second.set_node (feature_name)
				!! $$
				$$.set_first (feature_name)
				$$.set_second ($2.second)
			}
	;


Prefix: TE_PREFIX Prefix_operator
			{
				!PREFIX_AS! feature_name.make ($2.first, is_frozen)
				$2.second.set_node (feature_name)
				!! $$
				$$.set_first (feature_name)
				$$.set_second ($2.second)
			}
	;

Infix_operator: Manifest_string
			{
				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! $$
				$$.set_first ($1)
				$$.set_second (clickable)

-- TO DO
--				if not is_infix (token_buffer) then
--						-- Check infixed declaration.
--					report_error ("")
--				end
				yacc_error_code := 54
			}
	;

Prefix_operator: Manifest_string
			{
				!! clickable.make (dummy_clickable_as, current_position.start_position, current_position.end_position)
				click_list.extend (clickable)
				!! $$
				$$.set_first ($1)
				$$.set_second (clickable)

-- TO DO
--				if not is_prefix (token_buffer) then
--						-- Check prefixed declaration.
--					report_error ("")
--				end
				yacc_error_code := 55
			}
	;

Declaration_body: Formal_arguments Type_mark Constant_or_routine
			{
				!! $$.make ($1, $2, $3)
					-- Validity test for feature declaration
				if 
						-- Either arguments or type or body
					(($1 = Void) and ($2 = Void) and ($3 = Void))
				or
						-- constant implies no argument but type
					((dollar_constant_as ($3) /= Void) and (($1 /= Void) or ($2 = Void)))
				or
						-- arguments implies non-void routine
					(($1 /= Void) and ((dollar_routine_as ($3) = Void) or ($3 = Void)))
				then
					report_error ("")
				end
				yacc_error_code := 56
			}
	;


Constant_or_routine: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 57
			}
	|	TE_IS Feature_value
			{
				$$ := $2
				yacc_error_code := 58
			}
	;

Feature_value: Manifest_constant
			{
!! value_as.make ($1)
!CONSTANT_AS! $$.make (value_as)
--				!CONSTANT_AS! $$.make (create {VALUE_AS} .make (dollar_atomic_as ($1)))
				yacc_error_code := 59
			}
	|	TE_UNIQUE
			{
!! unique_as.make
!! value_as.make (unique_as)
!CONSTANT_AS! $$.make (value_as)
--				!CONSTANT_AS! $$.make (create {VALUE_AS} .make (create {UNIQUE_AS} .make))
				yacc_error_code := 60
			}
	|	Routine
			{ $$ := $1 }
	;


-- Inheritance


Inheritance: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 62
			}
	|	TE_INHERIT Parent_list
			{
				$$ := $2
				yacc_error_code := 64
			}
	|	TE_INHERIT ASemi
			{
				$$ := Void
				yacc_error_code := 65
			}
	;

Parent_list: Parent
			{
				!! $$.make (1)
				$$.extend ($1)
				yacc_error_code := 66
			}
	| Parent Parent
			{
				!! $$.make (2)
				$$.extend ($1)
				$$.extend ($2)
			}
	| Parent_list_3n
			{ $$ := $1 }
	;

Parent_list_3n: Parent Parent Parent
			{
				!! $$.make (Initial_parent_list_size)
				$$.extend ($1)
				$$.extend ($2)
				$$.extend ($3)
			}
	|	Parent_list_3n Parent
			{
				$$ := $1
				$$.extend ($2)
				yacc_error_code := 67
			} 
	;

Parent: Parent_clause
			{ $$ := $1 }
	|	Parent_clause TE_SEMICOLON
			{
				$$ := $1
				inherit_context := False
			}
	;

Parent_clause: Clickable_identifier Generics_opt
			{
				inherit_context := False
				!! class_type_as.make ($1.first, $2)
				$1.second.set_node (class_type_as)
				!! $$.make (class_type_as, Void, Void, Void, Void, Void)
				yacc_error_code := 68
			}
	|	Clickable_identifier Generics_opt Rename New_exports_opt Undefine_opt Redefine_opt Select_opt TE_END
			{
				inherit_context := False
				!! class_type_as.make ($1.first, $2)
				$1.second.set_node (class_type_as)
				!! $$.make (class_type_as, $3, $4, $5, $6, $7)
			}
	|	Clickable_identifier Generics_opt New_exports Undefine_opt Redefine_opt Select_opt TE_END
			{
				inherit_context := False
				!! class_type_as.make ($1.first, $2)
				$1.second.set_node (class_type_as)
				!! $$.make (class_type_as, Void, $3, $4, $5, $6)
			}
	|	Clickable_identifier Generics_opt Undefine Redefine_opt Select_opt TE_END
			{
				inherit_context := False
				!! class_type_as.make ($1.first, $2)
				$1.second.set_node (class_type_as)
				!! $$.make (class_type_as, Void, Void, $3, $4, $5)
			}
	|	Clickable_identifier Generics_opt Redefine Select_opt TE_END
			{
				inherit_context := False
				!! class_type_as.make ($1.first, $2)
				$1.second.set_node (class_type_as)
				!! $$.make (class_type_as, Void, Void, Void, $3, $4)
			}
	|	Clickable_identifier Generics_opt Select TE_END
			{
				inherit_context := False
				!! class_type_as.make ($1.first, $2)
				$1.second.set_node (class_type_as)
				!! $$.make (class_type_as, Void, Void, Void, Void, $3)
			}
	|	Clickable_identifier Generics_opt TE_END
			{
				inherit_context := True
				!! class_type_as.make ($1.first, $2)
				$1.second.set_node (class_type_as)
				!! $$.make (class_type_as, Void, Void, Void, Void, Void)
			}
	;

Rename: TE_RENAME
			{
				$$ := Void
				yacc_error_code := 74
			}
	|	TE_RENAME Rename_list
			{
				$$ := $2
				yacc_error_code := 76
			}
	;

Rename_list: Rename_pair
			{
				!! $$.make (1)
				$$.extend ($1)
				yacc_error_code := 77
			}
	|	Rename_pair TE_COMMA Rename_pair
			{
				!! $$.make (2)
				$$.extend ($1)
				$$.extend ($3)
			}
	|	Rename_list_3n
			{ $$ := $1 }
	;

Rename_list_3n: Rename_pair TE_COMMA Rename_pair TE_COMMA Rename_pair
			{
				!! $$.make (Initial_rename_list_size)
				$$.extend ($1)
				$$.extend ($3)
				$$.extend ($5)
			}
	|	Rename_list_3n TE_COMMA Rename_pair
			{
				$$ := $1
				$$.extend ($3)
				yacc_error_code := 78
			}
	;

Rename_pair: Feature_name TE_AS Feature_name
			{
				!! $$.make ($1.first, $3.first)
				$1.second.set_node ($3.first)
				yacc_error_code := 79
			}
	;

New_exports_opt: -- /* empty */
			{
				$$  := Void
				yacc_error_code := 80
			}
	|	New_exports
			{ $$ := $1 }
	;

New_exports: TE_EXPORT New_export_list
			{
				$$ := $2
				yacc_error_code := 82
			}
	|	TE_EXPORT ASemi
			{
				$$ := Void
				yacc_error_code := 83
			}
	;

New_export_list: New_export_item
			{
				!! $$.make (1)
				$$.extend ($1)
				yacc_error_code := 84
			}
	|	New_export_list_2n
			{ $$ := $1 }
	;

New_export_list_2n: New_export_item New_export_item
			{
				!! $$.make (Initial_new_export_list_size)
				$$.extend ($1)
				$$.extend ($2)
			}
	|	New_export_list_2n New_export_item
			{
				$$ := $1
				$$.extend ($2)
				yacc_error_code := 85
			}
	;

New_export_item: Client_list Feature_set ASemi
			{
!! client_as.make ($1)
!! $$.make (client_as, $2)
--				!EXPORT_ITEM_AS! $$.make (create {CLIENT_AS} .make (dollar_eiffel_list_id_as ($1)),
--					dollar_feature_set_as ($2))
				yacc_error_code := 86
			}
	;

Feature_set: TE_ALL
			{
				!ALL_AS! $$.make
				yacc_error_code := 87
			}
	|	Feature_list
			{
				!FEATURE_LIST_AS! $$.make ($1)
			}
	;

Feature_list: Feature_name
			{
				!! $$.make (1)
				$$.extend ($1.first)
				yacc_error_code := 90
			}
	|	Feature_name TE_COMMA Feature_name
			{
				!! $$.make (2)
				$$.extend ($1.first)
				$$.extend ($3.first)
			}
	|	Feature_list_3n
			{ $$ := $1 }
	;

Feature_list_3n: Feature_name TE_COMMA Feature_name TE_COMMA Feature_name
			{
				!! $$.make (Initial_feature_list_size)
				$$.extend ($1.first)
				$$.extend ($3.first)
				$$.extend ($5.first)
			}
	|	Feature_list_3n TE_COMMA Feature_name
			{
				$$ := $1
				$$.extend ($3.first)
				yacc_error_code := 91
			}
	;

Undefine_opt: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 92
			}
	|	Undefine
			{ $$ := $1 }
	;

Undefine: TE_UNDEFINE
			{
				$$ := Void
				yacc_error_code := 93
			}
	|	TE_UNDEFINE Feature_list
			{
				$$ := $2
				yacc_error_code := 95
			}
	;

Redefine_opt: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 96
			}
	|	Redefine
			{ $$ := $1 }
	;

Redefine: TE_REDEFINE
			{
				$$ := Void
				yacc_error_code := 97
			}
	|	TE_REDEFINE Feature_list
			{
				$$ := $2
				yacc_error_code := 99
			}
	;

Select_opt: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 100
			}
	|	Select
			{ $$ := $1 }
	;

Select: TE_SELECT
			{
				$$ := Void
				yacc_error_code := 101
			}
	|	TE_SELECT Feature_list
			{
				$$ := $2
				yacc_error_code := 103
			}
	;


-- Feature declaration


Formal_arguments: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 104
			}
--	|	TE_LPARAN TE_RPARAN
--			{
--				report_error ("")
--				yacc_error_code := 105
--			}
	|	TE_LPARAN Entity_declaration_list_opt TE_RPARAN
			{
				$$ := $2
				yacc_error_code := 107
			}
	;

Entity_declaration_list_opt: -- /* empty */
			{
				$$ := Void
			}
	|	Entity_declaration_group
			{
				!! $$.make (1)
				$$.extend ($1)
			}
	|	Entity_declaration_group Entity_declaration_group
			{
				!! $$.make (2)
				$$.extend ($1)
				$$.extend ($2)
			}
	|	Entity_declaration_group Entity_declaration_group Entity_declaration_group
			{
				!! $$.make (3)
				$$.extend ($1)
				$$.extend ($2)
				$$.extend ($3)
			}
	|	Entity_declaration_list_4n
			{ $$ := $1 }
	;

Entity_declaration_list_4n: Entity_declaration_group Entity_declaration_group Entity_declaration_group Entity_declaration_group
			{
				!! $$.make (Initial_entity_declaration_list_size)
				$$.extend ($1)
				$$.extend ($2)
				$$.extend ($3)
				$$.extend ($4)
			}
	|	Entity_declaration_list_4n Entity_declaration_group
			{
				$$ := $1
				$$.extend ($2)
				yacc_error_code := 108
			}
	;

Entity_declaration_group: Identifier_list TE_COLON Type ASemi
			{
				!! $$.make ($1, $3)
				yacc_error_code := 111
			}
	;

Identifier_list: Identifier
			{
				!! $$.make (1)
				$$.extend ($1)
				yacc_error_code := 112
			}
	|	Identifier TE_COMMA Identifier
			{
				!! $$.make (2)
				$$.extend ($1)
				$$.extend ($3)
			}
	|	Identifier_list_3n
			{ $$ := $1 }
	;

Identifier_list_3n: Identifier TE_COMMA Identifier TE_COMMA Identifier
			{
				!! $$.make (Initial_identifier_list_size)
				$$.extend ($1)
				$$.extend ($3)
				$$.extend ($5)
			}
	|	Identifier_list_3n TE_COMMA Identifier
			{
				$$ := $1
				$$.extend ($3)
				yacc_error_code := 113
			}
	;

Strip_identifier_list: -- /* empty */
			{
				!! $$.make (0)
			}
	|	Identifier_list
			{ $$ := $1 }
	;

Type_mark: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 114
			}
	|	TE_COLON Type
			{
				$$ := $2
				yacc_error_code := 115
			}
	;


Routine: Obsolete
			{
				fbody_pos := current_position.start_position
				yacc_error_code := 116
			} 
		Precondition Local_declarations
		Routine_body Postcondition Rescue TE_END
			{
				!! $$.make ($1, $3, $4, $5, $6, $7, fbody_pos)
				yacc_error_code := 117
			}
	;

Routine_body: Internal
			{ $$ := $1 }
	|	External
			{ $$ := $1 }
	|	TE_DEFERRED
			{
				!DEFERRED_AS! $$.make
				yacc_error_code := 120
			}
	;

External: TE_EXTERNAL External_language External_name
			{
				!! $$.make ($2, $3)
				yacc_error_code := 121
			}
	;

External_language:
			{
				set_position (current_position)
				yacc_error_code := 122
			}
		Non_empty_string
			{
				!! $$.make ($2, yacc_position)
				yacc_error_code := 123
			}
	;

External_name: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 124
			}
	|	TE_ALIAS Non_empty_string
			{
				$$ := $2
				yacc_error_code := 125
			}
	;

Internal: TE_DO Compound
			{
				!DO_AS! $$.make ($2)
				yacc_error_code := 127
			}
	|	TE_ONCE Compound
			{
				!ONCE_AS! $$.make ($2)
				yacc_error_code := 129
			}
	;

Local_declarations: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 130
			}
	|	TE_LOCAL Entity_declaration_list_opt
			{
				$$ := $2
				yacc_error_code := 132
			}
	;

Compound: Opt_Semi
			{
				$$ := Void
			}
	|	Opt_Semi Instruction
			{
				!! $$.make (1)
				$$.extend ($2)
			}
	|	Opt_Semi Instruction Instruction
			{
				!! $$.make (2)
				$$.extend ($2)
				$$.extend ($3)
			}
	|	Opt_Semi Instruction Instruction Instruction
			{
				!! $$.make (3)
				$$.extend ($2)
				$$.extend ($3)
				$$.extend ($4)
			}
	|	Opt_Semi Instruction Instruction Instruction Instruction
			{
				!! $$.make (4)
				$$.extend ($2)
				$$.extend ($3)
				$$.extend ($4)
				$$.extend ($5)
			}
	|	Opt_Semi Instruction_list_5n
			{
				$$ := $2
			}
	;

Instruction_list_5n: Instruction Instruction Instruction Instruction Instruction
			{
				!! $$.make (Initial_compound_size)
				$$.extend ($1)
				$$.extend ($2)
				$$.extend ($3)
				$$.extend ($4)
				$$.extend ($5)
			}
	|	Instruction_list_5n Instruction
			{
				$$ := $1
				$$.extend ($2)
			}
	;

Instruction: Set_position Instruction_impl Opt_Semi
			{
				$$ := $2
			}
	;

Opt_Semi: -- /* empty */
	|	Opt_Semi TE_SEMICOLON
	;

Instruction_impl: Creation
			{ $$ := $1 }
	|	Call
			{ $$ := $1 }
	|	Assignment
			{ $$ := $1 }
	|	Reverse_assignment
			{ $$ := $1 }
	|	Conditional
			{ $$ := $1 }
	|	Multi_branch
			{ $$ := $1 }
	|	Loop
			{ $$ := $1 }
	|	Debug
			{ $$ := $1 }
	|	Check
			{ $$ := $1 }
	|	Retry
			{ $$ := $1 }
	;

Precondition: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 145
			}
	|	TE_REQUIRE
			{
				id_level := Assert_level
				yacc_error_code := 146
			}
		Assertion
			{
				id_level := Normal_level
				!! $$.make ($3)
				yacc_error_code := 147
			}
	|	TE_REQUIRE TE_ELSE
			{
				id_level := Assert_level
				yacc_error_code := 148
			}
		Assertion
			{
				id_level := Normal_level
				!REQUIRE_ELSE_AS! $$.make ($4)
				yacc_error_code := 149
			}
	;

Postcondition: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 150
			}
	|	TE_ENSURE
			{
				id_level := Assert_level
				yacc_error_code := 151
			}
		Assertion
			{
				id_level := Normal_level
				!! $$.make ($3)
				yacc_error_code := 152
			}
	|	TE_ENSURE TE_THEN
			{
				id_level := Assert_level
				yacc_error_code := 153
			}
		Assertion
			{
				id_level := Normal_level
				!ENSURE_THEN_AS! $$.make ($4)
				yacc_error_code := 154
			}
	;

Assertion: -- /* empty */
			{
				$$ := Void
			}
	|	Assertion_list
			{
				$$ := $1
				if $$ /= Void and then $$.empty then
					$$ := Void
				end
			}
	;

Assertion_list: Assertion_clause
			{
				if $1 /= Void then
					!! $$.make (1)
					$$.extend ($1)
				end
				yacc_error_code := 157
			}
	|	Assertion_clause Assertion_clause
			{
				if $1 /= Void then
					if $2 /= Void then
						!! $$.make (2)
						$$.extend ($1)
						$$.extend ($2)
					else
						!! $$.make (1)
						$$.extend ($1)
					end
				elseif $2 /= Void then
					!! $$.make (1)
					$$.extend ($2)
				end
			}
	|	Assertion_list_3n
			{ $$ := $1 }
	;

Assertion_list_3n: Assertion_clause Assertion_clause Assertion_clause
			{
				!! $$.make (Initial_assertion_list_size)
				if $1 /= Void then
					$$.extend ($1)
				end
				if $2 /= Void then
					$$.extend ($2)
				end
				if $3 /= Void then
					$$.extend ($3)
				end
			}
	|	Assertion_list_3n Assertion_clause
			{
				$$ := $1
				if $2 /= Void then
					$$.extend ($2)
				end
				yacc_error_code := 158
			}
	;

Assertion_clause: Set_position Assertion_clause_impl ASemi
			{
				$$ := $2
			}
	;

Assertion_clause_impl: Expression
			{
				!! $$.make (Void, $1, yacc_position)
				yacc_error_code := 159
			}
	|	Identifier TE_COLON Expression
			{
				!! $$.make ($1, $3, yacc_position)
				yacc_error_code := 160
			}
	|	Identifier TE_COLON 
			{
				$$ := Void
				yacc_error_code := 161
			}
	;


-- Type


Type: Class_type
			{ $$ := $1 }
	|	TE_EXPANDED Clickable_identifier Generics_opt
			{
				id_as := $2.first
				!EXP_TYPE_AS! $$.make (id_as, $3)
--				$2.second.set_node ($$)
				suppliers.insert_supplier_id (id_as)
				yacc_error_code := 165
			}
	|	TE_SEPARATE Clickable_identifier Generics_opt
			{
				id_as := $2.first
				!SEPARATE_TYPE_AS! $$.make (id_as, $3)
--				$2.second.set_node ($$)
				suppliers.insert_supplier_id (id_as)
				yacc_error_code := 167
			}
	|	TE_BIT Integer_constant
			{
				!BITS_AS! $$.make ($2)
				yacc_error_code := 168
			}
	|	TE_BIT Identifier
			{
				!BITS_SYMBOL_AS! $$.make ($2)
				yacc_error_code := 169
			}
	|	TE_LIKE Identifier
			{
				!LIKE_ID_AS! $$.make ($2)
				yacc_error_code := 170
			}
	|	TE_LIKE TE_CURRENT
			{
				!LIKE_CUR_AS! $$.make
				yacc_error_code := 171
			}
	;

Class_type: Clickable_id Generics_opt
			{
				clickable := $1.second
				clickable.set_node (new_class_type ($1.first, $2))
				$$ ?= clickable.node
			}
	|	Clickable_boolean Generics_opt
			{
				clickable := $1.second
				clickable.set_node (new_boolean_type ($2 /= Void))
				$$ ?= clickable.node
			}
	|	Clickable_character Generics_opt
			{
				clickable := $1.second
				clickable.set_node (new_character_type ($2 /= Void))
				$$ ?= clickable.node
			}
	|	Clickable_double Generics_opt
			{
				clickable := $1.second
				clickable.set_node (new_double_type ($2 /= Void))
				$$ ?= clickable.node
			}
	|	Clickable_integer Generics_opt
			{
				clickable := $1.second
				clickable.set_node (new_integer_type ($2 /= Void))
				$$ ?= clickable.node
			}
	|	Clickable_none Generics_opt
			{
				clickable := $1.second
				clickable.set_node (new_none_type ($2 /= Void))
				$$ ?= clickable.node
			}
	|	Clickable_pointer Generics_opt
			{
				clickable := $1.second
				clickable.set_node (new_pointer_type ($2 /= Void))
				$$ ?= clickable.node
			}
	|	Clickable_real Generics_opt
			{
				clickable := $1.second
				clickable.set_node (new_real_type ($2 /= Void))
				$$ ?= clickable.node
			}
	;

Generics_opt: -- /* empty */
			{
				$$ := Void
			}
	|	TE_LSQURE TE_RSQURE
			{
				$$ := Void
				yacc_error_code := 174
			}
	|	TE_LSQURE Type_list TE_RSQURE
			{
				$$ := $2
				yacc_error_code := 176
			}
	;

Type_list: Type
			{
				!! $$.make (1)
				$$.extend ($1)
				yacc_error_code := 177
			}
	|	Type TE_COMMA Type
			{
				!! $$.make (2)
				$$.extend ($1)
				$$.extend ($3)
			}
	|	Type_list_3n
			{ $$ := $1 }
	;

Type_list_3n: Type TE_COMMA Type TE_COMMA Type
			{
				!! $$.make (Initial_type_list_size)
				$$.extend ($1)
				$$.extend ($3)
				$$.extend ($5)
			}
	|	Type_list_3n TE_COMMA Type
			{
				$$ := $1
				$$.extend ($3)
				yacc_error_code := 178
			}
	;


-- Formal generics


Formal_generics:
			{
				$$ := Void
				yacc_error_code := 179
			}
	|	TE_LSQURE Formal_generic_list_opt TE_RSQURE
			{
				$$ := $2
				yacc_error_code := 181
			}
	;

Formal_generic_list_opt: -- /* empty */
			{
				$$ := Void
			}
	|	Formal_generic
			{
				!! $$.make (1)
				$$.extend ($1)
				yacc_error_code := 182
			}
	|	Formal_generic_list_2n
			{ $$ := $1 }
	;

Formal_generic_list_2n: Formal_generic TE_COMMA Formal_generic
			{
				!! $$.make (Initial_formal_generic_list_size)
				$$.extend ($1)
				$$.extend ($3)
			}
	|	Formal_generic_list_2n TE_COMMA Formal_generic
			{
				$$ := $1
				$$.extend ($3)
				yacc_error_code := 183
			}
	;

Formal_generic:
		TE_ID
			{
!! id_as.make (token_buffer)
formal_parameters.extend (id_as)
--				formal_parameters.extend (create {ID_AS} .make (token_buffer))
				yacc_error_code := 184
			}
		Constraint Creation_constraint
			{
				check formal_exists: not formal_parameters.empty end
				!! $$.make (formal_parameters.last, $3, $4, formal_parameters.count)
				yacc_error_code := 185
			}
	;

Constraint: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 186
			}
	|	TE_CONSTRAIN Class_type 
			{
				$$ := $2
				yacc_error_code := 187
			}
	;

Creation_constraint: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 188
			}
	|	TE_CREATION Feature_list TE_END
			{
				$$ := $2
				yacc_error_code := 190
			}
	;


-- Instructions
 

Conditional: Position TE_IF Expression TE_THEN Compound Elseif_list_opt Else_part TE_END
			{
				set_position (dollar_position ($1))
				!! $$.make ($3, $5, $6, $7, yacc_position, yacc_line_number)
				yacc_error_code := 194
			}
	;

Elseif_list_opt: -- /* empty */
			{
				$$ := Void
			}
	|	Elseif_part
			{
				!! $$.make (1)
				$$.extend ($1)
			}
	|	Elseif_list_2n
			{ $$ := $1 }
	;

Elseif_list_2n: Elseif_part Elseif_part
			{
				!! $$.make (Initial_elseif_list_size)
				$$.extend ($1)
				$$.extend ($2)
				yacc_error_code := 198
			}
	|	Elseif_list_2n Elseif_part
			{
				$$ := $1
				$$.extend ($2)
				yacc_error_code := 199
			}
	;

Elseif_part: TE_ELSEIF Expression TE_THEN Compound
			{
				!! $$.make ($2, $4, yacc_line_number)
				yacc_error_code := 201
			}
	;

Inspect_default: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 202
			}
	|	TE_ELSE Compound
			{
				$$ := $2
				if $$ = Void then
					!! $$.make (0)
				end
				yacc_error_code := 204
			}
	;
 
Else_part: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 205
			}
	|	TE_ELSE Compound 
			{
				$$ := $2
				yacc_error_code := 207
			}
	;

Multi_branch: Position TE_INSPECT Expression When_part_list_opt Inspect_default TE_END
			{
				set_position (dollar_position ($1))
				!! $$.make ($3, $4, $5, yacc_position, yacc_line_number)
				yacc_error_code := 211
			}
	;

When_part_list_opt: -- /* empty */
			{
				$$ := Void
			}
	|	When_part
			{
				!! $$.make (1)
				$$.extend ($1)
			}
	|	When_part_list_2n
			{ $$ := $1 }
	;

When_part_list_2n: When_part When_part
			{
				!! $$.make (Initial_when_part_list_size)
				$$.extend ($1)
				$$.extend ($2)
			}
	|	When_part_list_2n When_part
			{
				$$ := $1
				$$.extend ($2)
				yacc_error_code := 214
			}
	;

When_part: TE_WHEN Choices TE_THEN Compound
			{
				!! $$.make ($2, $4, yacc_line_number)
				yacc_error_code := 218
			}
	;

Choices: Choice
			{
				!! $$.make (1)
				$$.extend ($1)
				yacc_error_code := 219
			}
	|	Choices_2n
			{ $$ := $1 }
	;

Choices_2n: Choice TE_COMMA Choice
			{
				!! $$.make (Initial_choices_size)
				$$.extend ($1)
				$$.extend ($3)
			}
	|	Choices_2n TE_COMMA Choice
			{
				$$ := $1
				$$.extend ($3)
				yacc_error_code := 220
			}
	;

Choice: Integer_constant
			{
				!! $$.make ($1, Void)
				yacc_error_code := 221
			}
	|	Character_constant
			{
				!! $$.make ($1, Void)
				yacc_error_code := 222
			}
	|	Identifier
			{
				!! $$.make ($1, Void)
				yacc_error_code := 223
			}
	|	Integer_constant TE_DOTDOT Integer_constant
			{
				!! $$.make ($1, $3)
				yacc_error_code := 224
			}
	|	Integer_constant TE_DOTDOT Identifier
			{
				!! $$.make ($1, $3)
				yacc_error_code := 225
			}
	|	Identifier TE_DOTDOT Integer_constant
			{
				!! $$.make ($1, $3)
				yacc_error_code := 226
			}
	|	Identifier TE_DOTDOT Identifier
			{
				!! $$.make ($1, $3)
				yacc_error_code := 227
			}
	|	Character_constant TE_DOTDOT Character_constant
			{
				!! $$.make ($1, $3)
				yacc_error_code := 228
			}
	|	Identifier TE_DOTDOT Character_constant
			{
				!! $$.make ($1, $3)
				yacc_error_code := 229
			}
	|	Character_constant TE_DOTDOT Identifier
			{
				!! $$.make ($1, $3)
				yacc_error_code := 230
			}
	;

Loop: Position TE_FROM Compound Invariant Variant TE_UNTIL Expression TE_LOOP Compound TE_END
			{
				set_position (dollar_position ($1))
				!! $$.make ($3, $4, $5, $7, $9, yacc_position, yacc_line_number)
				yacc_error_code := 235
			}
	;

Invariant: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 236
			}
	|	TE_INVARIANT Assertion
			{
				$$ := $2
				yacc_error_code := 237
			}
	;

Class_invariant: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 238
			}
	|	TE_INVARIANT
			{
				inherit_context := False
				id_level := Invariant_level
				yacc_error_code := 239
			}
		Assertion
			{
				id_level := Normal_level
				!! $$.make ($3)
				yacc_error_code := 240
			}
	;

Variant: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 241
			}
	|	TE_VARIANT Identifier TE_COLON Expression
			{
				!! $$.make ($2, $4, yacc_position)
				yacc_error_code := 242
			}
	|	TE_VARIANT Expression
			{
				!! $$.make (Void, $2, yacc_position)
				yacc_error_code := 243
			}
	;

Debug: Position TE_DEBUG Debug_keys Compound TE_END 
			{
				set_position (dollar_position ($1))
				!! $$.make ($3, $4, yacc_position, yacc_line_number)
				yacc_error_code := 246
			}
	;

Debug_keys: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 247
			}
	|	TE_LPARAN TE_RPARAN
			{
				$$ := Void
				yacc_error_code := 248
			}
	|	TE_LPARAN Debug_key_list TE_RPARAN
			{
				$$ := $2
				yacc_error_code := 250
			}
	;

Debug_key_list: Non_empty_string
			{
				!! $$.make (1)
				$$.extend ($1)
				yacc_error_code := 251
			}
	|	Debug_key_list_2n
			{ $$ := $1 }
	;

Debug_key_list_2n: Non_empty_string TE_COMMA Non_empty_string
			{
				!! $$.make (Initial_debug_key_list_size)
				$$.extend ($1)
				$$.extend ($3)
			}
	|	Debug_key_list_2n TE_COMMA Non_empty_string
			{
				$$ := $1
				$$.extend ($3)
				yacc_error_code := 252
			}
	;

Retry: TE_RETRY
			{
				!! $$.make (yacc_line_number)
				yacc_error_code := 253
			}
	;

Rescue: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 254
			}
	|	TE_RESCUE Compound 
			{
				$$ := $2
				if $$ = Void then
					!! $$.make (0)
				end
				yacc_error_code := 256
			}
	;

Assignment: Identifier TE_ASSIGN Expression
			{
!ACCESS_ID_AS! access_as.make ($1, Void)
!! $$.make (access_as, $3, yacc_position, yacc_line_number)
--				!ASSIGN_AS! $$.make (create {ACCESS_ID_AS} .make (dollar_id_as ($1), Void), dollar_expr_as ($3), yacc_position, yacc_line_number)
				yacc_error_code := 261
			}
	|	TE_RESULT TE_ASSIGN Expression
			{
!RESULT_AS! access_as.make
!! $$.make (access_as, $3, yacc_position, yacc_line_number)
--				!ASSIGN_AS! $$.make (create {RESULT_AS} .make , dollar_expr_as ($3), yacc_position, yacc_line_number)
				yacc_error_code := 262
			}
    ;

Reverse_assignment: Identifier TE_ACCEPT Expression
			{
!ACCESS_ID_AS! access_as.make ($1, Void)
!! $$.make (access_as, $3, yacc_position, yacc_line_number)
--				!REVERSE_AS! $$.make (create {ACCESS_ID_AS} .make (dollar_id_as ($1), Void), dollar_expr_as ($3), yacc_position, yacc_line_number)
				yacc_error_code := 263
			}
	|	TE_RESULT TE_ACCEPT Expression
			{
!RESULT_AS! access_as.make
!! $$.make (access_as, $3, yacc_position, yacc_line_number)
--				!REVERSE_AS! $$.make (create {RESULT_AS} .make, dollar_expr_as ($3), yacc_position, yacc_line_number)
				yacc_error_code := 264
			}
    ;

Creators: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 265
			}
	|	Creation_clause_list
			{ $$ := $1 }
	;

Creation_clause_list: Creation_clause
			{
				!! $$.make (1)
				$$.extend ($1)
				yacc_error_code := 268
			}
	|	Creation_clause_list_2n
			{ $$ := $1 }
	;

Creation_clause_list_2n: Creation_clause Creation_clause
			{
				!! $$.make (Initial_creation_clause_list_size)
				$$.extend ($1)
				$$.extend ($2)
			}
	|	Creation_clause_list_2n Creation_clause
			{
				$$ := $1
				$$.extend ($2)
				yacc_error_code := 269
			}
	;

Creation_clause: TE_CREATION
			{
				inherit_context := False
				!! $$.make (Void, Void)
				yacc_error_code := 270
			}
	|	TE_CREATION Clients Feature_list
			{
				inherit_context := False
				!! $$.make ($2, $3)
				yacc_error_code := 272
			}
	|	TE_CREATION Client_list 
			{
				inherit_context := False
!! client_as.make ($2)
!! $$.make (client_as, Void)
--				!CREATE_AS! $$.make (create {CLIENT_AS} .make (dollar_eiffel_list_id_as ($2)), Void)
				yacc_error_code := 273
			}
	;

Routine_creation: TE_TILDE TE_LCURLY Type TE_RCURLY Feature_name Parameters
			{
				!! $$.make ($3, $5.first, $6, nb_tilde)
			}
	|	TE_TILDE Feature_name Parameters
			{
				!! $$.make (Void, $2.first, $3, nb_tilde)
			}
	;

Creation: TE_BANG Creation_type TE_BANG Creation_target Creation_call
			{
				!! $$.make ($2, $4, $5, yacc_position, yacc_line_number)
				yacc_error_code := 274
			}
	|	TE_CREATION Creation_target Creation_call
			{
				!! $$.make (Void, $2, $3, yacc_position, yacc_line_number)
				yacc_error_code := 274
			}
	|	TE_CREATION TE_LCURLY Type TE_RCURLY Creation_target Creation_call
			{
				!! $$.make ($3, $5, $6, yacc_position, yacc_line_number)
				yacc_error_code := 274
			}
	;

Creation_expression: TE_CREATION TE_LCURLY Type TE_RCURLY Creation_call
			{
				!! $$.make ($3, $5)
			}
	|	TE_BANG Type TE_BANG Creation_call
			{
				!! $$.make ($2, $4)
			}
	;

Creation_type: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 275
			}
	|	Type
			{ $$ := $1 }
	;

Creation_target: Identifier
			{
				!ACCESS_ID_AS! $$.make ($1, Void)
				yacc_error_code := 277
			}
	|	TE_RESULT
			{
				!RESULT_AS! $$.make
				yacc_error_code := 278
			}
	;

Creation_call: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 279
			}
	|	TE_DOT Identifier Parameters
			{
				!! $$.make ($2, $3)
				yacc_error_code := 280
			}
	;


-- Instruction call

 
Call: A_feature
			{
				!! $$.make ($1, yacc_position, yacc_line_number)
				yacc_error_code := 281
			}
	|	Call_on_result
			{
				!! $$.make ($1, yacc_position, yacc_line_number)
				yacc_error_code := 282
			}
	|	Call_on_feature
			{
				!! $$.make ($1, yacc_position, yacc_line_number)
				yacc_error_code := 283
			}
	|	Call_on_current
			{
				!! $$.make ($1, yacc_position, yacc_line_number)
				yacc_error_code := 284
			}
	|	Call_on_expression
			{
				!! $$.make ($1, yacc_position, yacc_line_number)
				yacc_error_code := 285
			}
	|	A_precursor
			{
				!! $$.make ($1, yacc_position, yacc_line_number)
				yacc_error_code := 286
			}
	|	Call_on_precursor
			{
				!! $$.make ($1, yacc_position, yacc_line_number)
				yacc_error_code := 287
			}
	;

Check: Position TE_CHECK Assertion TE_END
			{
				set_position (dollar_position ($1))
				!! $$.make ($3, yacc_position, yacc_line_number)
				yacc_error_code := 289
			}
	;


-- Expression
 
Expression: Expression_constant
			{
				recover
				!VALUE_AS! $$.make ($1)
				yacc_error_code := 290
			}
	|	Manifest_array
			{
				recover
				!VALUE_AS! $$.make ($1)
				yacc_error_code := 291
			}
	|	Manifest_tuple
			{
				recover
				!VALUE_AS! $$.make ($1)
				yacc_error_code := 291
			}
	|	Feature_call
			{
				!EXPR_CALL_AS! $$.make ($1)
				yacc_error_code := 292
			}
	|	Routine_creation
	|	TE_LPARAN Expression TE_RPARAN
			{
				!PARAN_AS! $$.make ($2)
				yacc_error_code := 293
			}
	|	Expression TE_PLUS Expression
			{
				recover
				!BIN_PLUS_AS! $$.make ($1, $3)
				yacc_error_code := 294
			}
	|	Expression TE_MINUS Expression
			{
				recover
				!BIN_MINUS_AS! $$.make ($1, $3)
				yacc_error_code := 295
			}
	|	Expression TE_STAR Expression
			{
				recover
				!BIN_STAR_AS! $$.make ($1, $3)
				yacc_error_code := 296
			}
	|	Expression TE_SLASH Expression
			{
				recover
				!BIN_SLASH_AS! $$.make ($1, $3)
				yacc_error_code := 297
			}
	|	Expression TE_MOD Expression
			{
				recover
				!BIN_MOD_AS! $$.make ($1, $3)
				yacc_error_code := 298
			}
	|	Expression TE_DIV Expression
			{
				recover
				!BIN_DIV_AS! $$.make ($1, $3)
				yacc_error_code := 299
			}
	|	Expression TE_POWER Expression
			{
				recover
				!BIN_POWER_AS! $$.make ($1, $3)
				yacc_error_code := 300
			}
	|	Expression TE_AND Expression
			{
				recover
				!BIN_AND_AS! $$.make ($1, $3)
				yacc_error_code := 301
			}
	|	Expression TE_AND TE_THEN Expression %prec TE_AND
			{
				recover
				!BIN_AND_THEN_AS! $$.make ($1, $4)
				yacc_error_code := 302
			}
	|	Expression TE_OR Expression
			{
				recover
				!BIN_OR_AS! $$.make ($1, $3)
				yacc_error_code := 303
			}
	|	Expression TE_OR TE_ELSE Expression %prec TE_OR
			{
				recover
				!BIN_OR_ELSE_AS! $$.make ($1, $4)
				yacc_error_code := 304
			}
	|	Expression TE_IMPLIES Expression
			{
				recover
				!BIN_IMPLIES_AS! $$.make ($1, $3)
				yacc_error_code := 304
			}
	|	Expression TE_XOR Expression
			{
				recover
				!BIN_XOR_AS! $$.make ($1, $3)
				yacc_error_code := 305
			}
	|	Expression TE_GE Expression
			{
				recover
				!BIN_GE_AS! $$.make ($1, $3)
				yacc_error_code := 306
			}
	|	Expression TE_GT Expression
			{
				recover
				!BIN_GT_AS! $$.make ($1, $3)
				yacc_error_code := 307
			}
	|	Expression TE_LE Expression
			{
				recover
				!BIN_LE_AS! $$.make ($1, $3)
				yacc_error_code := 308
			}
	|	Expression TE_LT Expression
			{
				recover
				!BIN_LT_AS! $$.make ($1, $3)
				yacc_error_code := 309
			}
	|	Expression TE_EQ Expression
			{
				recover
				!BIN_EQ_AS! $$.make ($1, $3)
				yacc_error_code := 310
			}
	|	Expression TE_NE Expression
			{
				recover
				!BIN_NE_AS! $$.make ($1, $3)
				yacc_error_code := 311
			}
	|	Expression Free_operator Expression %prec TE_FREE
			{
				recover
				!BIN_FREE_AS! $$.make ($1, $2, $3)
				yacc_error_code := 312
			}
	|	TE_MINUS Expression %prec TE_NOT
			{
				recover
				!UN_MINUS_AS! $$.make ($2)
				yacc_error_code := 313
			}
	|	TE_PLUS Expression %prec TE_NOT
			{
				recover
				!UN_PLUS_AS! $$.make ($2)
				yacc_error_code := 314
			}
	|	TE_NOT Expression
			{
				recover
				!UN_NOT_AS! $$.make ($2)
				yacc_error_code := 315
			}
	|	TE_OLD Expression
			{
				recover
				!UN_OLD_AS! $$.make ($2)
				yacc_error_code := 316
			}
	|	Free_operator Expression %prec TE_NOT
			{
				recover
				!UN_FREE_AS! $$.make ($1, $2)
				yacc_error_code := 317
			}
	|	TE_STRIP TE_LPARAN Strip_identifier_list TE_RPARAN
			{
				recover
				!UN_STRIP_AS! $$.make ($3)
				yacc_error_code := 319
			}
	;

Actual_parameter: Expression
			{ $$ := $1 }
	|	TE_ADDRESS Feature_name
			{
				recover
				!ADDRESS_AS! $$.make ($2.first)
				yacc_error_code := 321
			}
	|	TE_ADDRESS TE_LPARAN Expression TE_RPARAN
			{
				recover
				!EXPR_ADDRESS_AS! $$.make ($3)
				yacc_error_code := 322
			}
	|	TE_ADDRESS TE_CURRENT
			{
				recover
				!ADDRESS_CURRENT_AS! $$.make
				yacc_error_code := 323
			}
	|	TE_ADDRESS TE_RESULT
			{
				recover
				!ADDRESS_RESULT_AS! $$.make
				yacc_error_code := 324
			}
	;

Free_operator: TE_FREE
			{
				!! $$.make (token_buffer)
				yacc_error_code := 325
			}
	;


-- Expression call


Feature_call: Call_on_current
			{ $$ := $1 }
	|	Call_on_result
			{ $$ := $1 }
	|	Call_on_feature
			{ $$ := $1 }
	|	TE_CURRENT
			{
				!CURRENT_AS! $$.make
				yacc_error_code := 329
			}
	|	TE_RESULT
			{
				!RESULT_AS! $$.make
				yacc_error_code := 330
			}
	|	A_feature
			{ $$ := $1 }
	|	Call_on_expression
			{ $$ := $1 }
	|	A_precursor
			{ $$ := $1 }
	|	Call_on_precursor
			{ $$ := $1 }
	|	Creation_expression
			{ $$ := $1 }
	;

Call_on_current: TE_CURRENT TE_DOT Remote_call
			{
!CURRENT_AS! access_as.make
!! $$.make (access_as, $3)
--				!NESTED_AS! $$.make (create {CURRENT_AS} .make, dollar_call_as ($3))
				yacc_error_code := 335
			}
	;

Call_on_result: TE_RESULT TE_DOT Remote_call
			{
!RESULT_AS! access_as.make
!! $$.make (access_as, $3)
--				!NESTED_AS! $$.make (create {RESULT_AS} .make, dollar_call_as ($3))
				yacc_error_code := 336
			}
	;

Call_on_feature: A_feature TE_DOT Remote_call
			{
				!! $$.make ($1, $3)
				yacc_error_code := 337
			}
	;

Call_on_expression: TE_LPARAN Expression TE_RPARAN TE_DOT Remote_call
			{
				!! $$.make ($2, $5)
				yacc_error_code := 338
			}
	;

Call_on_precursor: A_precursor TE_DOT Remote_call
			{
				!! $$.make ($1, $3)
				yacc_error_code := 339
			}
	;

A_precursor: TE_PRECURSOR Parameters
			{
				!! $$.make (Void, $2)
				yacc_error_code := 340
			}
	|	TE_LCURLY Clickable_identifier TE_RCURLY TE_PRECURSOR Parameters
			{
				!! $$.make ($2.first, $5)
				$2.second.set_node ($$)
				yacc_error_code := 341
			}
	|	TE_LCURLY TE_LCURLY Clickable_identifier TE_RCURLY TE_RCURLY TE_PRECURSOR Parameters
			{
				!! $$.make ($3.first, $7)
				$3.second.set_node ($$)
				yacc_error_code := 342
			}
	|	TE_PRECURSOR TE_LCURLY Clickable_identifier TE_RCURLY Parameters
			{
				!! $$.make ($3.first, $5)
				$3.second.set_node ($$)
				yacc_error_code := 341
			}
	;

Remote_call: Call_on_feature_access
			{ $$ := $1 }
	|	Feature_access
			{ $$ := $1 }
	;

Call_on_feature_access: Feature_access TE_DOT Feature_access
			{
				!! $$.make ($1, $3)
				yacc_error_code := 345
			}
	|	Feature_access TE_DOT Call_on_feature_access
			{
				!! $$.make ($1, $3)
				yacc_error_code := 346
			}
	;

A_feature: Identifier Parameters
			{
				inspect id_level
				when Normal_level then
					!ACCESS_ID_AS! $$.make ($1, $2)
				when Assert_level then
					!ACCESS_ASSERT_AS! $$.make ($1, $2)
				when Invariant_level then
					!ACCESS_INV_AS! $$.make ($1, $2)
				else
					-- ??
				end
				yacc_error_code := 347
			}
	;

Feature_access: Identifier Parameters
			{
				!! $$.make ($1, $2)
				yacc_error_code := 348
			}
	;

Parameters: -- /* empty */
			{
				$$ := Void
				yacc_error_code := 349
			}
	|	TE_LPARAN TE_RPARAN
			{
				$$ := Void
				yacc_error_code := 350
			}
	|	TE_LPARAN Parameter_list TE_RPARAN
			{
				$$ := $2
				yacc_error_code := 352
			}
	;

Parameter_list: Actual_parameter
			{
				!! $$.make (1)
				$$.extend ($1)
				yacc_error_code := 353
			}
	|	Actual_parameter TE_COMMA Actual_parameter
			{
				!! $$.make (2)
				$$.extend ($1)
				$$.extend ($3)
			}
	|	Actual_parameter TE_COMMA Actual_parameter TE_COMMA Actual_parameter
			{
				!! $$.make (3)
				$$.extend ($1)
				$$.extend ($3)
				$$.extend ($5)
			}
	|	Actual_parameter TE_COMMA Actual_parameter TE_COMMA Actual_parameter TE_COMMA Actual_parameter
			{
				!! $$.make (4)
				$$.extend ($1)
				$$.extend ($3)
				$$.extend ($5)
				$$.extend ($7)
			}
	|	Parameter_list_5n
			{ $$ := $1 }
	;


Parameter_list_5n: Actual_parameter TE_COMMA Actual_parameter TE_COMMA Actual_parameter TE_COMMA Actual_parameter TE_COMMA Actual_parameter
			{
				!! $$.make (Initial_parameter_list_size)
				$$.extend ($1)
				$$.extend ($3)
				$$.extend ($5)
				$$.extend ($7)
				$$.extend ($9)
			}
	|	Parameter_list_5n TE_COMMA Actual_parameter
			{
				$$ := $1
				$$.extend ($3)
				yacc_error_code := 354
			}
	;

Expression_list_opt: -- /* empty */
			{
				!! $$.make (0)
			}
	|	Expression
			{
				!! $$.make (1)
				$$.extend ($1)
				yacc_error_code := 355
			}
	|	Expression TE_COMMA Expression
			{
				!! $$.make (2)
				$$.extend ($1)
				$$.extend ($3)
			}
	|	Expression TE_COMMA Expression TE_COMMA Expression
			{
				!! $$.make (3)
				$$.extend ($1)
				$$.extend ($3)
				$$.extend ($5)
			}
	|	Expression_list_4n
			{ $$ := $1 }
	;

Expression_list_4n: Expression TE_COMMA Expression TE_COMMA Expression TE_COMMA Expression
			{
				!! $$.make (Initial_expression_list_size)
				$$.extend ($1)
				$$.extend ($3)
				$$.extend ($5)
				$$.extend ($7)
			}
	|	Expression_list_4n TE_COMMA Expression
			{
				$$ := $1
				$$.extend ($3)
				yacc_error_code := 356
			}
	;


-- Miscellaneous
 

Identifier: TE_ID
			{
				!! $$.make (token_buffer)
				yacc_error_code := 357
			}
	|	TE_BOOLEAN_ID
			{
				$$ := Boolean_id_as
			}
	|	TE_CHARACTER_ID
			{
				$$ := Character_id_as
			}
	|	TE_DOUBLE_ID
			{
				$$ := Double_id_as
			}
	|	TE_INTEGER_ID
			{
				$$ := Integer_id_as
			}
	|	TE_NONE_ID
			{
				$$ := None_id_as
			}
	|	TE_POINTER_ID
			{
				$$ := Pointer_id_as
			}
	|	TE_REAL_ID
			{
				$$ := Real_id_as
			}
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

Expression_constant: Boolean_constant
			{ $$ := $1 }
	|	Character_constant
			{ $$ := $1 }
	|	TE_INTEGER
			{
				if token_buffer.is_integer then
					!INTEGER_AS! $$.make (token_buffer.to_integer)
				else
-- TO DO!
				end
				yacc_error_code := 366
			}
	|	TE_REAL
			{
				!REAL_AS! $$.make (cloned_string (token_buffer))
				yacc_error_code := 367
			}
	|	Bit_constant
			{ $$ := $1 }
	|	Manifest_string
			{ $$ := $1 }
	;

Boolean_constant: TE_FALSE
			{
				!! $$.make (False)
				yacc_error_code := 370
			}
	|	TE_TRUE
			{
				!! $$.make (True)
				yacc_error_code := 371
			}
	;

Character_constant: TE_CHAR
			{
				check is_character: not token_buffer.empty end
				!! $$.make (token_buffer.item (1))
				yacc_error_code := 372
			}
	;

Integer_constant: TE_INTEGER
			{
				if token_buffer.is_integer then
					!! $$.make (token_buffer.to_integer)
				else
-- TO DO!
				end
				yacc_error_code := 373
			}
	|	TE_PLUS TE_INTEGER
			{
				if token_buffer.is_integer then
					!! $$.make (token_buffer.to_integer)
				else
-- TO DO!
				end
				yacc_error_code := 373
			}
	|	TE_MINUS TE_INTEGER
			{
				if token_buffer.is_integer then
					!! $$.make (- token_buffer.to_integer)
				else
-- TO DO!
				end
				yacc_error_code := 373
			}
	;

Real_constant: TE_REAL
			{
				!! $$.make (cloned_string (token_buffer))
				yacc_error_code := 377
			}
	|	TE_PLUS TE_REAL
			{
				!! $$.make (cloned_string (token_buffer))
				yacc_error_code := 377
			}
	|	TE_MINUS TE_REAL
			{
				token_buffer.precede ('-')
				!! $$.make (cloned_string (token_buffer))
				yacc_error_code := 377
			}
	;

Bit_constant: TE_A_BIT
			{
!! id_as.make (token_buffer)
!! $$.make (id_as)
--				!BIT_CONST_AS! $$.make (create {ID_AS} .make (token_buffer))
				yacc_error_code := 378
			}
	;

Manifest_string: TE_STRING
			{
				!! $$.make (cloned_string (token_buffer))
				yacc_error_code := 379
			}
	|	EIF_ERROR6
			{
				!! $$.make (cloned_string (token_buffer))
				yacc_error_code := 380
			}
	;

Non_empty_string: TE_STRING
			{
				!! $$.make (cloned_string (token_buffer))
				yacc_error_code := 381
			}
	;

Manifest_array: TE_LARRAY Expression_list_opt TE_RARRAY
			{
				!! $$.make ($2)
				yacc_error_code := 383
			}
	;

Manifest_tuple: TE_LSQURE Expression_list_opt TE_RSQURE
			{
				!! $$.make ($2)
				yacc_error_code := 383
			}
	;

Set_position: -- /* empty */
			{
				set_position (current_position)
				$$ := current_position
			}
	;

Position: -- /* empty */
			{
				$$ := current_position
			}
	;

%%

feature {NONE} -- Local variables

	id_as: ID_AS
	clickable: CLICK_AST
	clickable_as: CLICKABLE_AST
	class_type_as: CLASS_TYPE_AS
	feature_name: FEATURE_NAME
	feature_name_list: EIFFEL_LIST [FEATURE_NAME]

access_as: ACCESS_AS
value_as: VALUE_AS
unique_as: UNIQUE_AS
client_as: CLIENT_AS

f: PLAIN_TEXT_FILE

	Initial_assertion_list_size: INTEGER is 8
	Initial_choices_size: INTEGER is 2
	Initial_class_list_size: INTEGER is 4
	Initial_compound_size: INTEGER is 25
	Initial_creation_clause_list_size: INTEGER is 2
	Initial_debug_key_list_size: INTEGER is 2
	Initial_elseif_list_size: INTEGER is 5
	Initial_entity_declaration_list_size: INTEGER is 10
	Initial_expression_list_size: INTEGER is 8
	Initial_feature_clause_list_size: INTEGER is 10
	Initial_feature_declaration_list_size: INTEGER is 20
	Initial_feature_list_size: INTEGER is 11
	Initial_formal_generic_list_size: INTEGER is 4
	Initial_identifier_list_size: INTEGER is 6
	Initial_index_list_size: INTEGER is 10
	Initial_index_terms_size: INTEGER is 5
	Initial_new_export_list_size: INTEGER is 3
	Initial_new_feature_list_size: INTEGER is 4
	Initial_parameter_list_size: INTEGER is 9
	Initial_parent_list_size: INTEGER is 10
	Initial_rename_list_size: INTEGER is 10
	Initial_type_list_size: INTEGER is 4
	Initial_when_part_list_size: INTEGER is 3
			-- Initial capacity for lists

end -- class EIFFEL_PARSER


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
