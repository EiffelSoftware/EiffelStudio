%{
indexing

	description: "Eiffel parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_PARSER

inherit

	EIFFEL_PARSER_SKELETON

	SHARED_NAMES_HEAP

creation

	make, make_il_parser

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
%type <CLIENT_AS>			Clients Feature_client_clause
%type <CONTENT_AS>			Constant_or_routine Feature_value
%type <CREATE_AS>			Creation_clause
%type <CREATION_AS>			Creation
%type <CREATION_EXPR_AS>	Creation_expression
%type <DEBUG_AS>			Debug
%type <ELSIF_AS>			Elseif_part
%type <ENSURE_AS>			Postcondition
%type <EXPORT_ITEM_AS>		New_export_item
%type <EXPR_AS>				Expression
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
%type <INTEGER_CONSTANT>	Integer_constant
%type <INTERNAL_AS>			Internal
%type <INTERVAL_AS>			Choice
%type <INVARIANT_AS>		Class_invariant
%type <LOOP_AS>				Loop
%type <NESTED_AS>			Call_on_feature_access Call_on_precursor
							Call_on_feature Call_on_result Call_on_current Call_on_static
%type <NESTED_EXPR_AS>		Call_on_expression
%type <OPERAND_AS>			Delayed_actual
%type <PARENT_AS>			Parent Parent_clause
%type <PRECURSOR_AS>		A_precursor
%type <STATIC_ACCESS_AS>	A_static_call A_static_constant_call
%type <REAL_AS>				Real_constant
%type <RENAME_AS>			Rename_pair
%type <REQUIRE_AS>			Precondition
%type <RETRY_AS>			Retry
%type <REVERSE_AS>			Reverse_assignment
%type <ROUT_BODY_AS>		Routine_body
%type <ROUTINE_AS>			Routine
%type <ROUTINE_CREATION_AS>	Agent_call
%type <STRING_AS>			Obsolete Manifest_string External_name Non_empty_string
%type <TAGGED_AS>			Assertion_clause Assertion_clause_impl
%type <TUPLE_AS>			Manifest_tuple
%type <TYPE>				Type Type_mark Class_type Creation_type Non_class_type
%type <TYPE_DEC_AS>			Entity_declaration_group Local_entity_declaration_group
%type <VARIANT_AS>			Variant

%type <EIFFEL_LIST [ATOMIC_AS]>			Index_terms
%type <EIFFEL_LIST [CASE_AS]>			When_part_list_opt When_part_list
%type <EIFFEL_LIST [CREATE_AS]>			Creators Creation_clause_list
%type <EIFFEL_LIST [ELSIF_AS]>			Elseif_list_opt Elseif_list
%type <EIFFEL_LIST [EXPORT_ITEM_AS]>	New_exports New_exports_opt New_export_list
%type <EIFFEL_LIST [EXPR_AS]>			Parameters Parameter_list Expression_list_opt Expression_list
%type <EIFFEL_LIST [FEATURE_AS]>		Feature_declaration_list
%type <EIFFEL_LIST [FEATURE_CLAUSE_AS]>	Features Feature_clause_list
%type <EIFFEL_LIST [FEATURE_NAME]>		Feature_list Undefine Undefine_opt Redefine
										Redefine_opt Select Select_opt Creation_constraint
%type <EIFFEL_LIST [FORMAL_DEC_AS]>		Formal_generics Formal_generic_list_opt Formal_generic_list
%type <EIFFEL_LIST [ID_AS]>				Client_list Class_list 
%type <ARRAYED_LIST [INTEGER]>			Identifier_list Strip_identifier_list
%type <INDEXING_CLAUSE_AS>			Indexing Index_list Dotnet_indexing_opt Dotnet_indexing
%type <EIFFEL_LIST [INSTRUCTION_AS]>	Rescue Compound Instruction_list Else_part
										Inspect_default
%type <EIFFEL_LIST [INTERVAL_AS]>		Choices
%type <EIFFEL_LIST [OPERAND_AS]>		Delayed_actuals Delayed_actual_list
%type <EIFFEL_LIST [PARENT_AS]>			Inheritance Parent_list
%type <EIFFEL_LIST [RENAME_AS]>			Rename Rename_list
%type <EIFFEL_LIST [STRING_AS]>			Debug_keys Debug_key_list
%type <EIFFEL_LIST [TAGGED_AS]>			Assertion Assertion_list Invariant
%type <EIFFEL_LIST [TYPE]>				Generics_opt Type_list
%type <EIFFEL_LIST [TYPE_DEC_AS]>		Formal_arguments Entity_declaration_list_opt
										Entity_declaration_list Local_declarations
										Local_entity_declaration_list_opt
										Local_entity_declaration_list

%type <PAIR [ID_AS, CLICK_AST]>			Clickable_identifier Clickable_id Clickable_boolean
										Clickable_character Clickable_double Clickable_integer
										Clickable_integer_8 Clickable_integer_16
										Clickable_integer_64 Clickable_wide_char
										Clickable_none Clickable_pointer Clickable_real
%type <PAIR [FEATURE_NAME, CLICK_AST]>					Infix Prefix Feature_name New_feature
%type <PAIR [STRING_AS, CLICK_AST]>						Infix_operator Prefix_operator
%type <PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]>	New_feature_list
%type <PAIR [TYPE, EIFFEL_LIST [FEATURE_NAME]]>	Constraint

%type <TOKEN_LOCATION>		Position

%expect 196

%%


-- Root rule


Class_declaration:
		Indexing							-- $1
		Header_mark							-- $2
		TE_CLASS							-- $3
		Clickable_identifier				-- $4
		Formal_generics						-- $5
		External_name						-- $6
		Obsolete							-- $7
		Inheritance Position				-- $8 $9
		Creators							-- $10
		Features Position					-- $11 $12
		Class_invariant Position			-- $13 $14
		Indexing							-- $15
		Class_end							-- $16
			{
				root_node := new_class_description ($4, $6,
					is_deferred, is_expanded, is_separate, is_frozen_class, is_external_class,
					$1, $15, $5, $8, $10, $11, $13, suppliers, $7, click_list
				)

				if real_class_end_position = 0 then
					root_node.set_text_positions (
						start_position,
						$12.start_position,
						$9.start_position,
						formal_generics_start_position,
						formal_generics_end_position,
						$14.start_position
					)
				else
					root_node.set_text_positions (
						real_class_end_position,
						real_class_end_position,
						real_class_end_position,
						formal_generics_start_position,
						formal_generics_end_position,
						real_class_end_position
					)
				end
			}
	;

Class_end: TE_END
			{
				if inherit_context then
					inherit_context := False
					real_class_end_position := 0
				end
			}
	;

Clickable_identifier: Clickable_id
			{ $$ := $1 }
	|	Clickable_boolean
			{ $$ := $1 }
	|	Clickable_wide_char
			{ $$ := $1 }
	|	Clickable_character
			{ $$ := $1 }
	|	Clickable_double
			{ $$ := $1 }
	|	Clickable_integer_8
			{ $$ := $1 }
	|	Clickable_integer_16
			{ $$ := $1 }
	|	Clickable_integer
			{ $$ := $1 }
	|	Clickable_integer_64
			{ $$ := $1 }
	|	Clickable_none
			{ $$ := $1 }
	|	Clickable_pointer
			{ $$ := $1 }
	|	Clickable_real
			{ $$ := $1 }
	;

Clickable_id: TE_ID
			{ $$ := new_clickable_id (new_id_as (token_buffer)) }
	;

Clickable_boolean: TE_BOOLEAN_ID
			{ $$ := new_clickable_id (new_boolean_id_as) }
	;

Clickable_character: TE_CHARACTER_ID
			{ $$ := new_clickable_id (new_character_id_as (False)) }
	;

Clickable_wide_char: TE_WIDE_CHAR_ID
			{ $$ := new_clickable_id (new_character_id_as (True)) }
	;

Clickable_double: TE_DOUBLE_ID
			{ $$ := new_clickable_id (new_double_id_as) }
	;

Clickable_integer_8: TE_INTEGER_8_ID
			{ $$ := new_clickable_id (new_integer_id_as (8)) }
	;

Clickable_integer_16: TE_INTEGER_16_ID
			{ $$ := new_clickable_id (new_integer_id_as (16)) }
	;

Clickable_integer: TE_INTEGER_ID
			{ $$ := new_clickable_id (new_integer_id_as (32)) }
	;

Clickable_integer_64: TE_INTEGER_64_ID
			{ $$ := new_clickable_id (new_integer_id_as (64)) }
	;

Clickable_none: TE_NONE_ID
			{ $$ := new_clickable_id (new_none_id_as) }
	;

Clickable_pointer: TE_POINTER_ID
			{ $$ := new_clickable_id (new_pointer_id_as) }
	;

Clickable_real: TE_REAL_ID
			{ $$ := new_clickable_id (new_real_id_as) }
	;


-- Indexing


Indexing: -- Empty
			-- { $$ := Void }
	|	TE_INDEXING Index_list
			{ $$ := $2 }
	|	TE_INDEXING 
			-- { $$ := Void }
	;

Dotnet_indexing_opt: -- Empty
			-- { $$ := Void }
	| TE_INDEXING Index_list
			{ $$ := $2 }
	| TE_INDEXING
			{ $$ := Void }
	;

Dotnet_indexing: -- Empty
			-- { $$ := Void }
	| TE_INDEXING Index_list TE_END
			{ $$ := $2 }
	| TE_INDEXING TE_END
			{ $$ := Void }
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
	|	Creation_expression TE_END
			{
				create {CUSTOM_ATTRIBUTE_AS} $$.initialize ($1)
			}
	;


-- Header mark


Header_mark: Frozen_mark External_mark
			{
				is_deferred := False
				is_expanded := False
				is_separate := False
			}
	|	TE_DEFERRED External_mark
			{
				is_frozen_class := False
				is_deferred := True
				is_expanded := False
				is_separate := False
			}
	|	Frozen_mark TE_EXPANDED External_mark
			{
				is_deferred := False
				is_expanded := True
				is_separate := False
			}
	|	Frozen_mark TE_SEPARATE External_mark
			{
				is_deferred := False
				is_expanded := False
				is_separate := True
			}
	;

Frozen_mark: -- Empty
			{
				is_frozen_class := False
			}
	|	TE_FROZEN
			{
				if il_parser then
					is_frozen_class := True
				else
						-- Trigger a syntax error.
					raise_error
				end
			}
	;

External_mark: -- Empty
			{
				is_external_class := False
			}
	|	TE_EXTERNAL
			{
				if il_parser then
					is_external_class := True
				else
						-- Trigger a syntax error.
					raise_error
				end
			}
	;


-- Obsolete


Obsolete: -- Empty
			-- { $$ := Void }
	|	TE_OBSOLETE Manifest_string
			{ $$ := $2 }
	;


-- Features

Features: -- Empty
			-- { $$ := Void }
	|	Feature_clause_list
			{
				$$ := $1
				if $$.is_empty then
					$$ := Void
				end
			}
	;

Feature_clause_list: Feature_clause
			{
				$$ := new_eiffel_list_feature_clause_as (Initial_feature_clause_list_size)
				add_to_feature_clause_list ($$, $1)
			}
	|	Feature_clause_list Feature_clause
			{
				$$ := $1
				add_to_feature_clause_list ($$, $2)
			}
	;

Feature_clause: Feature_client_clause
			{ $$ := new_feature_clause_as (Void, new_eiffel_list_feature_as (0), fclause_pos) }
	|	Feature_client_clause Feature_declaration_list
			{ $$ := new_feature_clause_as ($1, $2, fclause_pos) }
	;

Feature_client_clause: TE_FEATURE
			{
				inherit_context := False
				fclause_pos := current_position.end_position
			}
		Clients
			{ $$ := $3 }
	;

Clients: -- Empty
			-- { $$ := Void }
	|	Client_list
			{ $$ := new_client_as ($1) }
	;

Client_list: TE_LCURLY TE_RCURLY
			{
				$$ := new_eiffel_list_id_as (1)
				$$.extend (new_none_id_as)
			}
	|	TE_LCURLY Class_list TE_RCURLY
			{ $$ := $2 }
	;

Class_list: Clickable_identifier
			{
				$$ := new_eiffel_list_id_as (Initial_class_list_size)
				$$.extend ($1.first)
				$1.second.set_node (new_class_type_as ($1.first, Void))
			}
	|	Class_list TE_COMMA Clickable_identifier
			{
				$$ := $1
				$$.extend ($3.first)
				$3.second.set_node (new_class_type_as ($3.first, Void))
			}
	;

Feature_declaration_list: Feature_declaration
			{
				$$ := new_eiffel_list_feature_as (Initial_feature_declaration_list_size)
				$$.extend ($1)
			}
	|	Feature_declaration_list Feature_declaration
			{
				$$ := $1
				$$.extend ($2)
			}
	;

ASemi: -- Empty
	|	TE_SEMICOLON
	;

Optional_semicolons: -- Empty
	|	Optional_semicolons TE_SEMICOLON
	;

Feature_declaration: New_feature_list Declaration_body Optional_semicolons
			{
					-- Generate a syntax error when `feature_indexes' is not
					-- Void and it applies to synonyms of the current feature
					-- declaration.
				if (il_parser and feature_indexes /= Void and $1.first.count /= 1) then
					raise_error
				end
				$$ := new_feature_declaration ($1, $2, feature_indexes)
				feature_indexes := Void
			}
	;

New_feature_list: New_feature
			{ $$ := new_clickable_feature_name_list ($1, Initial_new_feature_list_size) }
	|	New_feature_list TE_COMMA New_feature
			{
				$$ := $1
				$$.first.extend ($3.first)
			}
	;

New_feature: Feature_name_mark Feature_name
			{ $$ := $2 }
	;

Feature_name_mark: -- Empty
			{ is_frozen := False }
	|	TE_FROZEN
			{ is_frozen := True }
	;

Feature_name: Clickable_identifier
			{ $$ := new_clickable_feature_name ($1) }
	|	Infix
			{ $$ := $1 }
	|	Prefix
			{ $$ := $1 }
	;

Infix: TE_INFIX Infix_operator
			{ $$ := new_clickable_infix ($2) }
	;


Prefix: TE_PREFIX Prefix_operator
			{ $$ := new_clickable_prefix ($2) }
	;

Declaration_body: Formal_arguments Type_mark Constant_or_routine
			{ $$ := new_declaration_body ($1, $2, $3) }
	;

Constant_or_routine: Dotnet_indexing
			{ feature_indexes := $1 }
	|	TE_IS Feature_value
			{ $$ := $2 }
	;

Feature_value: Manifest_constant Dotnet_indexing
			{
				$$ := new_constant_as (new_value_as ($1))
				feature_indexes := $2
			}
	|	TE_UNIQUE Dotnet_indexing
			{
				$$ := new_constant_as (new_value_as (new_unique_as))
				feature_indexes := $2
			}
	|	Dotnet_indexing_opt Routine
			{
				$$ := $2
				feature_indexes := $1
			}
	;


-- Inheritance


Inheritance: -- Empty
			-- { $$ := Void }
	|	TE_INHERIT Parent_list
			{ $$ := $2 }
	|	TE_INHERIT ASemi
			{ $$ := new_eiffel_list_parent_as (0) }
	;

Parent_list: Parent
			{
				$$ := new_eiffel_list_parent_as (Initial_parent_list_size)
				$$.extend ($1)
			}
	|	Parent_list Parent
			{
				$$ := $1
				$$.extend ($2)
			} 
	;

Parent: Position Parent_clause
			{
				$$ := $2
				$2.set_text_positions ($1.start_position)
			}
	|	Position Parent_clause TE_SEMICOLON
			{
				inherit_context := False
				$$ := $2
				$2.set_text_positions ($1.start_position)
			}
	;

Parent_clause: Clickable_identifier Generics_opt
			{
				inherit_context := False
				$$ := new_parent_clause ($1, $2, Void, Void, Void, Void, Void)
			}
	|	Clickable_identifier Generics_opt Rename New_exports_opt Undefine_opt Redefine_opt Select_opt TE_END
			{
				inherit_context := False
				$$ := new_parent_clause ($1, $2, $3, $4, $5, $6, $7)
			}
	|	Clickable_identifier Generics_opt New_exports Undefine_opt Redefine_opt Select_opt TE_END
			{
				inherit_context := False
				$$ := new_parent_clause ($1, $2, Void, $3, $4, $5, $6)
			}
	|	Clickable_identifier Generics_opt Undefine Redefine_opt Select_opt TE_END
			{
				inherit_context := False
				$$ := new_parent_clause ($1, $2, Void, Void, $3, $4, $5)
			}
	|	Clickable_identifier Generics_opt Redefine Select_opt TE_END
			{
				inherit_context := False
				$$ := new_parent_clause ($1, $2, Void, Void, Void, $3, $4)
			}
	|	Clickable_identifier Generics_opt Select TE_END
			{
				inherit_context := False
				$$ := new_parent_clause ($1, $2, Void, Void, Void, Void, $3)
			}
	|	Clickable_identifier Generics_opt TE_END
			{
				inherit_context := True
				real_class_end_position := end_position - 3
				$$ := new_parent_clause ($1, $2, Void, Void, Void, Void, Void)
			}
	;

Rename: TE_RENAME
			-- { $$ := Void }
	|	TE_RENAME Rename_list
			{ $$ := $2 }
	;

Rename_list: Rename_pair
			{
				$$ := new_eiffel_list_rename_as (Initial_rename_list_size)
				$$.extend ($1)
			}
	|	Rename_list TE_COMMA Rename_pair
			{
				$$ := $1
				$$.extend ($3)
			}
	;

Rename_pair: Feature_name TE_AS Feature_name
			{ $$ := new_rename_pair ($1, $3) }
	;

New_exports_opt: -- Empty
			-- { $$  := Void }
	|	New_exports
			{ $$ := $1 }
	;

New_exports: TE_EXPORT New_export_list
			{ $$ := $2 }
	|	TE_EXPORT ASemi
			-- { $$ := Void }
	;

New_export_list: New_export_item
			{
				$$ := new_eiffel_list_export_item_as (Initial_new_export_list_size)
				$$.extend ($1)
			}
	|	New_export_list New_export_item
			{
				$$ := $1
				$$.extend ($2)
			}
	;

New_export_item: Client_list Feature_set ASemi
			{ $$ := new_export_item_as (new_client_as ($1), $2) }
	;

Feature_set: TE_ALL
			{ $$ := new_all_as }
	|	Feature_list
			{ $$ := new_feature_list_as ($1) }
	;

Feature_list: Feature_name
			{
				$$ := new_eiffel_list_feature_name (Initial_feature_list_size)
				$$.extend ($1.first)
			}
	|	Feature_list TE_COMMA Feature_name
			{
				$$ := $1
				$$.extend ($3.first)
			}
	;

Undefine_opt: -- Empty
			-- { $$ := Void }
	|	Undefine
			{ $$ := $1 }
	;

Undefine: TE_UNDEFINE
			-- { $$ := Void }
	|	TE_UNDEFINE Feature_list
			{ $$ := $2 }
	;

Redefine_opt: -- Empty
			-- { $$ := Void }
	|	Redefine
			{ $$ := $1 }
	;

Redefine: TE_REDEFINE
			-- { $$ := Void }
	|	TE_REDEFINE Feature_list
			{ $$ := $2 }
	;

Select_opt: -- Empty
			-- { $$ := Void }
	|	Select
			{ $$ := $1 }
	;

Select: TE_SELECT
			-- { $$ := Void }
	|	TE_SELECT Feature_list
			{ $$ := $2 }
	;


-- Feature declaration


Formal_arguments: -- Empty
			-- { $$ := Void }
	|	TE_LPARAN Entity_declaration_list_opt TE_RPARAN
			{ $$ := $2 }
	;

Entity_declaration_list_opt: -- Empty
			-- { $$ := Void }
	|	Entity_declaration_list
			{ $$ := $1 }
	;

Entity_declaration_list: Entity_declaration_group
			{
				$$ := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				$$.extend ($1)
			}
	|	Entity_declaration_list Entity_declaration_group
			{
				$$ := $1
				$$.extend ($2)
			}
	;

Entity_declaration_group: Identifier_list TE_COLON Parameter_passing_type Type ASemi
			{ $$ := new_type_dec_as ($1, $4) }
	;

Parameter_passing_type: -- Empty
	|	TE_LSQURE Identifier TE_RSQURE
			{
				if il_parser then
						-- Trigger a syntax error.
					raise_error
				end
			}
	;

Local_entity_declaration_list_opt: -- Empty
			-- { $$ := Void }
	|	Local_entity_declaration_list
			{ $$ := $1 }
	;

Local_entity_declaration_list: Local_entity_declaration_group
			{
				$$ := new_eiffel_list_type_dec_as (Initial_entity_declaration_list_size)
				$$.extend ($1)
			}
	|	Local_entity_declaration_list Local_entity_declaration_group
			{
				$$ := $1
				$$.extend ($2)
			}
	;

Local_entity_declaration_group: Identifier_list TE_COLON Type ASemi
			{ $$ := new_type_dec_as ($1, $3) }
	;

Identifier_list: Identifier
			{
				create $$.make (Initial_identifier_list_size)
				Names_heap.put ($1)
				$$.extend (Names_heap.found_item)
			}
	|	Identifier_list TE_COMMA Identifier
			{
				$$ := $1
				Names_heap.put ($3)
				$$.extend (Names_heap.found_item)
			}
	;

Strip_identifier_list: -- Empty
			{ create $$.make (0) }
	|	Identifier_list
			{ $$ := $1 }
	;

Type_mark: -- Empty
			-- { $$ := Void }
	|	TE_COLON Type
			{ $$ := $2 }
	;

Routine:
		Obsolete
			{ fbody_pos := current_position.start_position } 
		Precondition
		Local_declarations
		Routine_body
		Postcondition
		Rescue
		TE_END
			{ $$ := new_routine_as ($1, $3, $4, $5, $6, $7, fbody_pos) }
	;

Routine_body: Internal
			{ $$ := $1 }
	|	External
			{ $$ := $1 }
	|	TE_DEFERRED
			{ $$ := new_deferred_as }
	;

External: TE_EXTERNAL External_language External_name
			{ $$ := new_external_as ($2, $3) }
	;

External_language:
			{ set_position (current_position) }
		Non_empty_string
			{ $$ := new_external_lang_as ($2, yacc_position) }
	;

External_name: -- Empty
			-- { $$ := Void }
	|	TE_ALIAS Non_empty_string
			{ $$ := $2 }
	;

Internal: TE_DO Compound
			{ $$ := new_do_as ($2) }
	|	TE_ONCE Compound
			{ $$ := new_once_as ($2) }
	;

Local_declarations: -- Empty
			-- { $$ := Void }
	|	TE_LOCAL Local_entity_declaration_list_opt
			{ $$ := $2 }
	;

Compound: Opt_Semi
			-- { $$ := Void }
	|	Opt_Semi Instruction_list
			{ $$ := $2 }
	;

Instruction_list: Instruction
			{
				$$ := new_eiffel_list_instruction_as (Initial_compound_size)
				$$.extend ($1)
			}
	|	Instruction_list Instruction
			{
				$$ := $1
				$$.extend ($2)
			}
	;

Instruction: Set_position Instruction_impl Opt_Semi
			{ $$ := $2 }
	;

Opt_Semi: -- Empty
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

Precondition: -- Empty
			-- { $$ := Void }
	|	TE_REQUIRE
			{ id_level := Assert_level }
		Assertion
			{
				id_level := Normal_level
				$$ := new_require_as ($3)
			}
	|	TE_REQUIRE TE_ELSE
			{ id_level := Assert_level }
		Assertion
			{
				id_level := Normal_level
				$$ := new_require_else_as ($4)
			}
	;

Postcondition: -- Empty
			-- { $$ := Void }
	|	TE_ENSURE
			{ id_level := Assert_level }
		Assertion
			{
				id_level := Normal_level
				$$ := new_ensure_as ($3)
			}
	|	TE_ENSURE TE_THEN
			{ id_level := Assert_level }
		Assertion
			{
				id_level := Normal_level
				$$ := new_ensure_then_as ($4)
			}
	;

Assertion: -- Empty
			-- { $$ := Void }
	|	Assertion_list
			{
				$$ := $1
				if $$.is_empty then
					$$ := Void
				end
			}
	;

Assertion_list: Assertion_clause
			{
				$$ := new_eiffel_list_tagged_as (Initial_assertion_list_size)
				add_to_assertion_list ($$, $1)
			}
	|	Assertion_list Assertion_clause
			{
				$$ := $1
				add_to_assertion_list ($$, $2)
			}
	;

Assertion_clause: Set_position Assertion_clause_impl ASemi
			{ $$ := $2 }
	;

Assertion_clause_impl: Expression
			{ $$ := new_tagged_as (Void, $1, yacc_position, yacc_line_number) }
	|	Identifier TE_COLON Expression
			{ $$ := new_tagged_as ($1, $3, yacc_position, yacc_line_number) }
	|	Identifier TE_COLON 
			-- { $$ := Void }
	;


-- Type


Type: Class_type
			{ $$ := $1 }
	|	Non_class_type
			{ $$ := $1 }
	;

Non_class_type: TE_EXPANDED Clickable_identifier Generics_opt
			{ $$ := new_expanded_type ($2, $3) }
	|	TE_SEPARATE Clickable_identifier Generics_opt
			{ $$ := new_separate_type ($2, $3) }
	|	TE_BIT Integer_constant
			{ $$ := new_bits_as ($2) }
	|	TE_BIT Identifier
			{ $$ := new_bits_symbol_as ($2) }
	|	TE_LIKE Identifier
			{ $$ := new_like_id_as ($2) }
	|	TE_LIKE TE_CURRENT
			{ $$ := new_like_current_as }
	;

Class_type: Clickable_id Generics_opt
			{ $$ := new_class_type ($1, $2) }
	|	Clickable_boolean Generics_opt
			{ $$ := new_boolean_type ($1.second, $2 /= Void) }
	|	Clickable_character Generics_opt
			{ $$ := new_character_type ($1.second, $2 /= Void, False) }
	|	Clickable_wide_char Generics_opt
			{ $$ := new_character_type ($1.second, $2 /= Void, True) }
	|	Clickable_double Generics_opt
			{ $$ := new_double_type ($1.second, $2 /= Void) }
	|	Clickable_integer_8 Generics_opt
			{ $$ := new_integer_type ($1.second, $2 /= Void, 8) }
	|	Clickable_integer_16 Generics_opt
			{ $$ := new_integer_type ($1.second, $2 /= Void, 16) }
	|	Clickable_integer Generics_opt
			{ $$ := new_integer_type ($1.second, $2 /= Void, 32) }
	|	Clickable_integer_64 Generics_opt
			{ $$ := new_integer_type ($1.second, $2 /= Void, 64) }
	|	Clickable_none Generics_opt
			{ $$ := new_none_type ($1.second, $2 /= Void) }
	|	Clickable_pointer Generics_opt
			{ $$ := new_pointer_type ($1.second, $2 /= Void) }
	|	Clickable_real Generics_opt
			{ $$ := new_real_type ($1.second, $2 /= Void) }
	;

Generics_opt: -- Empty
			-- { $$ := Void }
	|	TE_LSQURE TE_RSQURE
			-- { $$ := Void }
	|	TE_LSQURE Type_list TE_RSQURE
			{ $$ := $2 }
	;

Type_list: Type
			{
				$$ := new_eiffel_list_type (Initial_type_list_size)
				$$.extend ($1)
			}
	|	Type_list TE_COMMA Type
			{
				$$ := $1
				$$.extend ($3)
			}
	;


-- Formal generics


Formal_generics:
			{
				-- $$ := Void
				formal_generics_start_position := start_position
				formal_generics_end_position := 0
			}
	|	Position TE_LSQURE Formal_generic_list_opt TE_RSQURE
			{
				$$ := $3
				formal_generics_start_position := $1.start_position
				formal_generics_end_position := start_position
			}
	;

Formal_generic_list_opt: -- Empty
			-- { $$ := Void }
	|	Formal_generic_list
			{ $$ := $1 }
	;

Formal_generic_list: Formal_generic
			{
				$$ := new_eiffel_list_formal_dec_as (Initial_formal_generic_list_size)
				$$.extend ($1)
			}
	|	Formal_generic_list TE_COMMA Formal_generic
			{
				$$ := $1
				$$.extend ($3)
			}
	;

Formal_generic:
		TE_ID
			{ formal_parameters.extend (new_id_as (token_buffer)) }
		Constraint
			{
				check formal_exists: not formal_parameters.is_empty end
				$$ := new_formal_dec_as (formal_parameters.last, $3.first, $3.second, formal_parameters.count)
			}
	;

Constraint: -- Empty
			{ create $$ }
	|	TE_CONSTRAIN Class_type Creation_constraint
			{
				create $$
				$$.set_first ($2)
				$$.set_second ($3)
			}
	;

Creation_constraint: -- Empty
			-- { $$ := Void }
	|	TE_CREATE Feature_list TE_END
			{ $$ := $2 }
	;


-- Instructions
 

Conditional: Position TE_IF Expression TE_THEN Compound Elseif_list_opt Else_part TE_END
			{
				set_position ($1)
				$$ := new_if_as ($3, $5, $6, $7, yacc_position, yacc_line_number)
			}
	;

Elseif_list_opt: -- Empty
			-- { $$ := Void }
	|	Elseif_list
			{ $$ := $1 }
	;

Elseif_list: Elseif_part
			{
				$$ := new_eiffel_list_elseif_as (Initial_elseif_list_size)
				$$.extend ($1)
			}
	|	Elseif_list Elseif_part
			{
				$$ := $1
				$$.extend ($2)
			}
	;

Elseif_part: TE_ELSEIF Expression TE_THEN Compound
			{ $$ := new_elseif_as ($2, $4, yacc_line_number) }
	;

Else_part: -- Empty
			-- { $$ := Void }
	|	TE_ELSE Compound 
			{ $$ := $2 }
	;

Multi_branch: Position TE_INSPECT Expression When_part_list_opt Inspect_default TE_END
			{
				set_position ($1)
				$$ := new_inspect_as ($3, $4, $5, yacc_position, yacc_line_number)
			}
	;

When_part_list_opt: -- Empty
			-- { $$ := Void }
	|	When_part_list
			{ $$ := $1 }
	;

When_part_list: When_part
			{
				$$ := new_eiffel_list_case_as (Initial_when_part_list_size)
				$$.extend ($1)
			}
	|	When_part_list When_part
			{
				$$ := $1
				$$.extend ($2)
			}
	;

When_part: TE_WHEN Choices TE_THEN Compound
			{ $$ := new_case_as ($2, $4, yacc_line_number) }
	;

Choices: Choice
			{
				$$ := new_eiffel_list_interval_as (Initial_choices_size)
				$$.extend ($1)
			}
	|	Choices TE_COMMA Choice
			{
				$$ := $1
				$$.extend ($3)
			}
	;

Choice: Integer_constant
			{ $$ := new_interval_as ($1, Void) }
	|	Integer_constant TE_DOTDOT Integer_constant
			{ $$ := new_interval_as ($1, $3) }
	|	Character_constant
			{ $$ := new_interval_as ($1, Void) }
	|	Character_constant TE_DOTDOT Character_constant
			{ $$ := new_interval_as ($1, $3) }
	|	Identifier
			{ $$ := new_interval_as ($1, Void) }
	|	Identifier TE_DOTDOT Identifier
			{ $$ := new_interval_as ($1, $3) }
	|	Identifier TE_DOTDOT Integer_constant
			{ $$ := new_interval_as ($1, $3) }
	|	Integer_constant TE_DOTDOT Identifier
			{ $$ := new_interval_as ($1, $3) }
	|	Identifier TE_DOTDOT Character_constant
			{ $$ := new_interval_as ($1, $3) }
	|	Character_constant TE_DOTDOT Identifier
			{ $$ := new_interval_as ($1, $3) }
	|	A_static_constant_call
			{ $$ := new_interval_as ($1, Void) }
	|	A_static_constant_call TE_DOTDOT Identifier
			{ $$ := new_interval_as ($1, $3) }
	|	Identifier TE_DOTDOT A_static_constant_call
			{ $$ := new_interval_as ($1, $3) }
	|	A_static_constant_call TE_DOTDOT A_static_constant_call
			{ $$ := new_interval_as ($1, $3) }
	|	A_static_constant_call TE_DOTDOT Integer_constant
			{ $$ := new_interval_as ($1, $3) }
	|	Integer_constant TE_DOTDOT A_static_constant_call
			{ $$ := new_interval_as ($1, $3) }
	|	A_static_constant_call TE_DOTDOT Character_constant
			{ $$ := new_interval_as ($1, $3) }
	|	Character_constant TE_DOTDOT A_static_constant_call
			{ $$ := new_interval_as ($1, $3) }

	;

Inspect_default: -- Empty
			-- { $$ := Void }
	|	TE_ELSE Compound
			{
				$$ := $2
				if $$ = Void then
					$$ := new_eiffel_list_instruction_as (0)
				end
			}
	;
 
Loop: Position TE_FROM Compound Invariant Variant TE_UNTIL Expression TE_LOOP Compound TE_END
			{
				set_position ($1)
				$$ := new_loop_as ($3, $4, $5, $7, $9, yacc_position, yacc_line_number)
			}
	;

Invariant: -- Empty
			-- { $$ := Void }
	|	TE_INVARIANT Assertion
			{ $$ := $2 }
	;

Class_invariant: -- Empty
			-- { $$ := Void }
	|	TE_INVARIANT
			{ id_level := Invariant_level }
		Assertion
			{
				id_level := Normal_level
				inherit_context := False
				$$ := new_invariant_as ($3)
			}
	;

Variant: -- Empty
			-- { $$ := Void }
	|	TE_VARIANT Identifier TE_COLON Expression
			{ $$ := new_variant_as ($2, $4, yacc_position, yacc_line_number) }
	|	TE_VARIANT Expression
			{ $$ := new_variant_as (Void, $2, yacc_position, yacc_line_number) }
	;

Debug: Position TE_DEBUG Debug_keys Compound TE_END 
			{
				set_position ($1)
				$$ := new_debug_as ($3, $4, yacc_position, yacc_line_number)
			}
	;

Debug_keys: -- Empty
			-- { $$ := Void }
	|	TE_LPARAN TE_RPARAN
			-- { $$ := Void }
	|	TE_LPARAN Debug_key_list TE_RPARAN
			{ $$ := $2 }
	;

Debug_key_list: Non_empty_string
			{
				$$ := new_eiffel_list_string_as (Initial_debug_key_list_size)
				$$.extend ($1)
			}
	|	Debug_key_list TE_COMMA Non_empty_string
			{
				$$ := $1
				$$.extend ($3)
			}
	;

Retry: TE_RETRY
			{ $$ := new_retry_as (yacc_line_number) }
	;

Rescue: -- Empty
			-- { $$ := Void }
	|	TE_RESCUE Compound 
			{
				$$ := $2
				if $$ = Void then
					$$ := new_eiffel_list_instruction_as (0)
				end
			}
	;

Assignment: Identifier TE_ASSIGN Expression
			{ $$ := new_assign_as (new_access_id_as ($1, Void), $3, yacc_position, yacc_line_number) }
	|	TE_RESULT TE_ASSIGN Expression
			{ $$ := new_assign_as (new_result_as, $3, yacc_position, yacc_line_number) }
    ;

Reverse_assignment: Identifier TE_ACCEPT Expression
			{ $$ := new_reverse_as (new_access_id_as ($1, Void), $3, yacc_position, yacc_line_number) }
	|	TE_RESULT TE_ACCEPT Expression
			{ $$ := new_reverse_as (new_result_as, $3, yacc_position, yacc_line_number) }
    ;

Creators: -- Empty
			-- { $$ := Void }
	|	Creation_clause_list
			{ $$ := $1 }
	;

Creation_clause_list: Creation_clause
			{
				$$ := new_eiffel_list_create_as (Initial_creation_clause_list_size)
				$$.extend ($1)
			}
	|	Creation_clause_list Creation_clause
			{
				$$ := $1
				$$.extend ($2)
			}
	;

Creation_clause:
		TE_CREATE
			{
				inherit_context := False
				$$ := new_create_as (Void, Void)
			}
	|	TE_CREATE Clients Feature_list
			{
				inherit_context := False
				$$ := new_create_as ($2, $3)
			}
	|	TE_CREATE Client_list 
			{
				inherit_context := False
				$$ := new_create_as (new_client_as ($2), Void)
			}
	|	 TE_CREATION
			{
				inherit_context := False
				$$ := new_create_as (Void, Void)
			}
	|	TE_CREATION Clients Feature_list
			{
				inherit_context := False
				$$ := new_create_as ($2, $3)
			}
	|	TE_CREATION Client_list 
			{
				inherit_context := False
				$$ := new_create_as (new_client_as ($2), Void)
			}
	;

Agent_call:
		TE_AGENT TE_RESULT TE_DOT Identifier Delayed_actuals
		{ $$ := new_routine_creation_as (new_result_operand_as (Void, Void, Void), $4, $5) }
	|	TE_AGENT TE_CURRENT TE_DOT Identifier Delayed_actuals
		{ $$ := new_routine_creation_as (new_operand_as (Void, Void, Void), $4, $5) }
	|	TE_AGENT Identifier TE_DOT Identifier Delayed_actuals
		{ $$ := new_routine_creation_as (new_operand_as (Void, $2, Void), $4, $5) }
	|	TE_AGENT TE_LPARAN Expression TE_RPARAN TE_DOT Identifier Delayed_actuals
		{ $$ := new_routine_creation_as (new_operand_as (Void, Void, $3), $6, $7) }
	|	TE_AGENT TE_LCURLY Type TE_RCURLY TE_DOT Identifier Delayed_actuals
		{ $$ := new_routine_creation_as (new_operand_as ($3, Void, Void), $6, $7) }
	|	TE_AGENT TE_QUESTION TE_DOT Identifier Delayed_actuals
		{ $$ := new_routine_creation_as (Void, $4, $5) }
	|	TE_AGENT Identifier Delayed_actuals
		{ $$ := new_routine_creation_as (new_operand_as (Void, Void, Void), $2, $3) }
	|	TE_RESULT TE_TILDE Identifier Delayed_actuals
		{ $$ := new_routine_creation_as (new_result_operand_as (Void, Void, Void), $3, $4) }
	|	TE_CURRENT TE_TILDE Identifier Delayed_actuals
		{ $$ := new_routine_creation_as (new_operand_as (Void, Void, Void), $3, $4) }
	|	Identifier TE_TILDE Identifier Delayed_actuals
		{ $$ := new_routine_creation_as (new_operand_as (Void, $1, Void), $3, $4) }
	|	TE_LPARAN Expression TE_RPARAN TE_TILDE Identifier Delayed_actuals
		{ $$ := new_routine_creation_As (new_operand_as (Void, Void, $2), $5, $6) }
	|	TE_LCURLY Type TE_CURLYTILDE Identifier Delayed_actuals
		{ $$ := new_routine_creation_as (new_operand_as ($2, Void, Void), $4, $5) }
	|	TE_QUESTION TE_TILDE Identifier Delayed_actuals
		{ $$ := new_routine_creation_as (Void, $3, $4) }
	|	TE_TILDE Identifier Delayed_actuals
		{ $$ := new_routine_creation_as (new_operand_as (Void, Void, Void), $2, $3) }
	;

Delayed_actuals: -- Empty
			-- { $$ := Void }
	|	TE_LPARAN Delayed_actual_list TE_RPARAN
			{ $$ := $2 }
	;

Delayed_actual_list: Delayed_actual
			{
				$$ := new_eiffel_list_operand_as (Initial_operand_list_size)
				$$.extend ($1)
			}
	|	Delayed_actual_list TE_COMMA Delayed_actual
			{
				$$ := $1
				$$.extend ($3)
			}
	;

Delayed_actual: TE_QUESTION
			{ $$ := new_operand_as (Void, Void, Void) }
	|	Expression
			{ $$ := new_operand_as (Void, Void, $1) }
	|	TE_LCURLY Clickable_id Generics_opt TE_RCURLY
			{ $$ := new_operand_as (new_class_type ($2, $3), Void, Void) }
	|	TE_LCURLY Clickable_boolean Generics_opt TE_RCURLY
			{ $$ := new_operand_as (new_boolean_type ($2.second, $3 /= Void), Void, Void) }
	|	TE_LCURLY Clickable_character Generics_opt TE_RCURLY
			{ $$ := new_operand_as (new_character_type ($2.second, $3 /= Void, False), Void, Void) }
	|	TE_LCURLY Clickable_wide_char Generics_opt TE_RCURLY
			{ $$ := new_operand_as (new_character_type ($2.second, $3 /= Void, True), Void, Void) }
	|	TE_LCURLY Clickable_double Generics_opt TE_RCURLY
			{ $$ := new_operand_as (new_double_type ($2.second, $3 /= Void), Void, Void) }
	|	TE_LCURLY Clickable_integer_8 Generics_opt TE_RCURLY
			{ $$ := new_operand_as (new_integer_type ($2.second, $3 /= Void, 8), Void, Void) }
	|	TE_LCURLY Clickable_integer_16 Generics_opt TE_RCURLY
			{ $$ := new_operand_as (new_integer_type ($2.second, $3 /= Void, 16), Void, Void) }
	|	TE_LCURLY Clickable_integer Generics_opt TE_RCURLY
			{ $$ := new_operand_as (new_integer_type ($2.second, $3 /= Void, 32), Void, Void) }
	|	TE_LCURLY Clickable_integer_64 Generics_opt TE_RCURLY
			{ $$ := new_operand_as (new_integer_type ($2.second, $3 /= Void, 64), Void, Void) }
	|	TE_LCURLY Clickable_none Generics_opt TE_RCURLY
			{ $$ := new_operand_as (new_none_type ($2.second, $3 /= Void), Void, Void) }
	|	TE_LCURLY Clickable_pointer Generics_opt TE_RCURLY
			{ $$ := new_operand_as (new_pointer_type ($2.second, $3 /= Void), Void, Void) }
	|	TE_LCURLY Clickable_real Generics_opt TE_RCURLY
			{ $$ := new_operand_as (new_real_type ($2.second, $3 /= Void), Void, Void) }
	|	TE_LCURLY Non_class_type TE_RCURLY
			{ $$ := new_operand_as ($2, Void, Void) }
	;

Creation: TE_BANG Creation_type TE_BANG Creation_target Creation_call
			{ $$ := new_creation_as ($2, $4, $5, yacc_position, yacc_line_number) }
	|	TE_CREATE Creation_target Creation_call
			{ $$ := new_creation_as (Void, $2, $3, yacc_position, yacc_line_number) }
	|	TE_CREATE TE_LCURLY Type TE_RCURLY Creation_target Creation_call
			{ $$ := new_creation_as ($3, $5, $6, yacc_position, yacc_line_number) }
	;

Creation_expression: TE_CREATE TE_LCURLY Type TE_RCURLY Creation_call
			{ $$ := new_creation_expr_as ($3, $5, yacc_position, yacc_line_number) }
	|	TE_BANG Type TE_BANG Creation_call
			{ $$ := new_creation_expr_as ($2, $4, yacc_position, yacc_line_number) }
	;

Creation_type: -- Empty
			-- { $$ := Void }
	|	Type
			{ $$ := $1 }
	;

Creation_target: Identifier
			{ $$ := new_access_id_as ($1, Void) }
	|	TE_RESULT
			{ $$ := new_result_as }
	;

Creation_call: -- Empty
			-- { $$ := Void }
	|	TE_DOT Identifier Parameters
			{ $$ := new_access_inv_as ($2, $3) }
	;


-- Instruction call

 
Call: A_feature
			{ $$ := new_instr_call_as ($1, yacc_position, yacc_line_number) }
	|	Call_on_result
			{ $$ := new_instr_call_as ($1, yacc_position, yacc_line_number) }
	|	Call_on_feature
			{ $$ := new_instr_call_as ($1, yacc_position, yacc_line_number) }
	|	Call_on_current
			{ $$ := new_instr_call_as ($1, yacc_position, yacc_line_number) }
	|	Call_on_expression
			{ $$ := new_instr_call_as ($1, yacc_position, yacc_line_number) }
	|	A_precursor
			{ $$ := new_instr_call_as ($1, yacc_position, yacc_line_number) }
	|	Call_on_precursor
			{ $$ := new_instr_call_as ($1, yacc_position, yacc_line_number) }
	|	A_static_call
			{ $$ := new_instr_call_as ($1, yacc_position, yacc_line_number) }
	|	Call_on_static
			{ $$ := new_instr_call_as ($1, yacc_position, yacc_line_number) }
	;

Check: Position TE_CHECK Assertion TE_END
			{
				set_position ($1)
				$$ := new_check_as ($3, yacc_position, yacc_line_number)
			}
	;


-- Expression
 

Expression: Expression_constant
			{ $$ := new_value_as ($1) }
	|	Manifest_array
			{ $$ := new_value_as ($1) }
	|	Manifest_tuple
			{ $$ := new_value_as ($1) }
	|	Feature_call
			{ $$ := new_expr_call_as ($1) }
	|	Agent_call
			{ $$ := $1 }
	|	TE_LPARAN Expression TE_RPARAN
			{ $$ := new_paran_as ($2) }
	|	Expression TE_PLUS Expression
			{ $$ := new_bin_plus_as ($1, $3) }
	|	Expression TE_MINUS Expression
			{ $$ := new_bin_minus_as ($1, $3) }
	|	Expression TE_STAR Expression
			{ $$ := new_bin_star_as ($1, $3) }
	|	Expression TE_SLASH Expression
			{ $$ := new_bin_slash_as ($1, $3) }
	|	Expression TE_MOD Expression
			{ $$ := new_bin_mod_as ($1, $3) }
	|	Expression TE_DIV Expression
			{ $$ := new_bin_div_as ($1, $3) }
	|	Expression TE_POWER Expression
			{ $$ := new_bin_power_as ($1, $3) }
	|	Expression TE_AND Expression
			{ $$ := new_bin_and_as ($1, $3) }
	|	Expression TE_AND TE_THEN Expression %prec TE_AND
			{ $$ := new_bin_and_then_as ($1, $4) }
	|	Expression TE_OR Expression
			{ $$ := new_bin_or_as ($1, $3) }
	|	Expression TE_OR TE_ELSE Expression %prec TE_OR
			{ $$ := new_bin_or_else_as ($1, $4) }
	|	Expression TE_IMPLIES Expression
			{ $$ := new_bin_implies_as ($1, $3) }
	|	Expression TE_XOR Expression
			{ $$ := new_bin_xor_as ($1, $3) }
	|	Expression TE_GE Expression
			{ $$ := new_bin_ge_as ($1, $3) }
	|	Expression TE_GT Expression
			{ $$ := new_bin_gt_as ($1, $3) }
	|	Expression TE_LE Expression
			{ $$ := new_bin_le_as ($1, $3) }
	|	Expression TE_LT Expression
			{ $$ := new_bin_lt_as ($1, $3) }
	|	Expression TE_EQ Expression
			{ $$ := new_bin_eq_as ($1, $3) }
	|	Expression TE_NE Expression
			{ $$ := new_bin_ne_as ($1, $3) }
	|	Expression Free_operator Expression %prec TE_FREE
			{ $$ := new_bin_free_as ($1, $2, $3) }
	|	TE_MINUS Expression %prec TE_NOT
			{ $$ := new_un_minus_as ($2) }
	|	TE_PLUS Expression %prec TE_NOT
			{ $$ := new_un_plus_as ($2) }
	|	TE_NOT Expression
			{ $$ := new_un_not_as ($2) }
	|	TE_OLD Expression
			{ $$ := new_un_old_as ($2) }
	|	Free_operator Expression %prec TE_NOT
			{ $$ := new_un_free_as ($1, $2) }
	|	TE_STRIP TE_LPARAN Strip_identifier_list TE_RPARAN
			{ $$ := new_un_strip_as ($3) }
	|	TE_ADDRESS Feature_name
			{ $$ := new_address_as ($2.first) }
	|	TE_ADDRESS TE_LPARAN Expression TE_RPARAN
			{ $$ := new_expr_address_as ($3) }
	|	TE_ADDRESS TE_CURRENT
			{ $$ := new_address_current_as }
	|	TE_ADDRESS TE_RESULT
			{ $$ := new_address_result_as }
	;

Free_operator: TE_FREE
			{ $$ := new_id_as (token_buffer) }
	;


-- Expression call


Feature_call: Call_on_current
			{ $$ := $1 }
	|	Call_on_result
			{ $$ := $1 }
	|	Call_on_feature
			{ $$ := $1 }
	|	TE_CURRENT
			{ $$ := new_current_as }
	|	TE_RESULT
			{ $$ := new_result_as }
	|	A_feature
			{ $$ := $1 }
	|	Call_on_expression
			{ $$ := $1 }
	|	A_precursor
			{ $$ := $1 }
	|	Call_on_precursor
			{ $$ := $1 }
	|	A_static_call
			{ $$ := $1 }
	|	Call_on_static
			{ $$ := $1 }
	|	Creation_expression
			{ $$ := $1 }
	;

Call_on_current: TE_CURRENT TE_DOT Remote_call
			{ $$ := new_nested_as (new_current_as, $3) }
	;

Call_on_result: TE_RESULT TE_DOT Remote_call
			{ $$ := new_nested_as (new_result_as, $3) }
	;

Call_on_feature: A_feature TE_DOT Remote_call
			{ $$ := new_nested_as ($1, $3) }
	;

Call_on_expression: TE_LPARAN Expression TE_RPARAN TE_DOT Remote_call
			{ $$ := new_nested_expr_as ($2, $5) }
	;

Call_on_precursor: A_precursor TE_DOT Remote_call
			{ $$ := new_nested_as ($1, $3) }
	;

A_precursor: TE_PRECURSOR Parameters
			{ $$ := new_precursor_as (Void, $2) }
	|	TE_LCURLY TE_LCURLY Clickable_identifier TE_RCURLY TE_RCURLY TE_PRECURSOR Parameters
			{ $$ := new_precursor ($3, $7) }
	|	TE_PRECURSOR TE_LCURLY Clickable_identifier TE_RCURLY Parameters
			{ $$ := new_precursor ($3, $5) }
	|	TE_LCURLY Clickable_id TE_RCURLY TE_PRECURSOR Parameters
			{ $$ := new_precursor ($2, $5) }
	|	TE_LCURLY Clickable_boolean TE_RCURLY TE_PRECURSOR Parameters
			{ $$ := new_precursor ($2, $5) }
	|	TE_LCURLY Clickable_character TE_RCURLY TE_PRECURSOR Parameters
			{ $$ := new_precursor ($2, $5) }
	|	TE_LCURLY Clickable_double TE_RCURLY TE_PRECURSOR Parameters
			{ $$ := new_precursor ($2, $5) }
	|	TE_LCURLY Clickable_integer_8 TE_RCURLY TE_PRECURSOR Parameters
			{ $$ := new_precursor ($2, $5) }
	|	TE_LCURLY Clickable_integer_16 TE_RCURLY TE_PRECURSOR Parameters
			{ $$ := new_precursor ($2, $5) }
	|	TE_LCURLY Clickable_integer TE_RCURLY TE_PRECURSOR Parameters
			{ $$ := new_precursor ($2, $5) }
	|	TE_LCURLY Clickable_integer_64 TE_RCURLY TE_PRECURSOR Parameters
			{ $$ := new_precursor ($2, $5) }
	|	TE_LCURLY Clickable_none TE_RCURLY TE_PRECURSOR Parameters
			{ $$ := new_precursor ($2, $5) }
	|	TE_LCURLY Clickable_pointer TE_RCURLY TE_PRECURSOR Parameters
			{ $$ := new_precursor ($2, $5) }
	|	TE_LCURLY Clickable_real TE_RCURLY TE_PRECURSOR Parameters
			{ $$ := new_precursor ($2, $5) }
	;

Call_on_static: A_static_call TE_DOT Remote_call
		{ $$ := new_nested_as ($1, $3) }
	;

A_static_call:
		TE_FEATURE TE_LCURLY Clickable_identifier TE_RCURLY TE_DOT Identifier Parameters
			{
				$$ := new_static_access_as (new_class_type ($3, Void), $6, $7);
			}
	;

A_static_constant_call:
		TE_FEATURE TE_LCURLY Clickable_identifier TE_RCURLY TE_DOT Identifier
			{
				$$ := new_static_access_as (new_class_type ($3, Void), $6, Void);
			}
	;


Remote_call: Call_on_feature_access
			{ $$ := $1 }
	|	Feature_access
			{ $$ := $1 }
	;

Call_on_feature_access: Feature_access TE_DOT Feature_access
			{ $$ := new_nested_as ($1, $3) }
	|	Feature_access TE_DOT Call_on_feature_access
			{ $$ := new_nested_as ($1, $3) }
	;

A_feature: Identifier Parameters
			{
				inspect id_level
				when Normal_level then
					$$ := new_access_id_as ($1, $2)
				when Assert_level then
					$$ := new_access_assert_as ($1, $2)
				when Invariant_level then
					$$ := new_access_inv_as ($1, $2)
				end
			}
	;

Feature_access: Identifier Parameters
			{ $$ := new_access_feat_as ($1, $2) }
	;

Parameters: -- Empty
			-- { $$ := Void }
	|	TE_LPARAN TE_RPARAN
			-- { $$ := Void }
	|	TE_LPARAN Parameter_list TE_RPARAN
			{ $$ := $2 }
	;

Parameter_list: Expression
			{
				$$ := new_eiffel_list_expr_as (Initial_parameter_list_size)
				$$.extend ($1)
			}
	|	Parameter_list TE_COMMA Expression
			{
				$$ := $1
				$$.extend ($3)
			}
	;

Expression_list_opt: -- Empty
			{ $$ := new_eiffel_list_expr_as (0) }
	|	Expression_list
			{ $$ := $1 }
	;

Expression_list: Expression
			{
				$$ := new_eiffel_list_expr_as (Initial_expression_list_size)
				$$.extend ($1)
			}
	|	Expression_list TE_COMMA Expression
			{
				$$ := $1
				$$.extend ($3)
			}
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

Expression_constant: Boolean_constant
			{ $$ := $1 }
	|	Character_constant
			{ $$ := $1 }
	|	TE_INTEGER
			{
				if token_buffer.is_integer then
					$$ := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					$$ := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					$$ := new_integer_as (False, "0")
				end
			}
	|	TE_REAL
			{ $$ := new_real_as (cloned_string (token_buffer)) }
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
					$$ := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					$$ := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					$$ := new_integer_as (False, "0")
				end
			}
	|	TE_PLUS TE_INTEGER
			{
				if token_buffer.is_integer then
					$$ := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					$$ := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					$$ := new_integer_as (False, "0")
				end
			}
	|	TE_MINUS TE_INTEGER
			{
				if token_buffer.is_integer then
					$$ := new_integer_as (True, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					$$ := new_integer_as_from_hexa (token_buffer)	
				else
					token_buffer.precede ('-')
					report_integer_too_small_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					$$ := new_integer_as (False, "0")
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

Prefix_operator: TE_STR_MINUS
			{ $$ := new_clickable_string (new_minus_string_as) }
	|	TE_STR_PLUS
			{ $$ := new_clickable_string (new_plus_string_as) }
	|	TE_STR_NOT
			{ $$ := new_clickable_string (new_not_string_as) }
	|	TE_STR_FREE
			{ $$ := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) }
	;

Infix_operator: TE_STR_LT
			{ $$ := new_clickable_string (new_lt_string_as) }
	|	TE_STR_LE
			{ $$ := new_clickable_string (new_le_string_as) }
	|	TE_STR_GT
			{ $$ := new_clickable_string (new_gt_string_as) }
	|	TE_STR_GE
			{ $$ := new_clickable_string (new_ge_string_as) }
	|	TE_STR_MINUS
			{ $$ := new_clickable_string (new_minus_string_as) }
	|	TE_STR_PLUS
			{ $$ := new_clickable_string (new_plus_string_as) }
	|	TE_STR_STAR
			{ $$ := new_clickable_string (new_star_string_as) }
	|	TE_STR_SLASH
			{ $$ := new_clickable_string (new_slash_string_as) }
	|	TE_STR_MOD
			{ $$ := new_clickable_string (new_mod_string_as) }
	|	TE_STR_DIV
			{ $$ := new_clickable_string (new_div_string_as) }
	|	TE_STR_POWER
			{ $$ := new_clickable_string (new_power_string_as) }
	|	TE_STR_AND
			{ $$ := new_clickable_string (new_and_string_as) }
	|	TE_STR_AND_THEN
			{ $$ := new_clickable_string (new_and_then_string_as) }
	|	TE_STR_IMPLIES
			{ $$ := new_clickable_string (new_implies_string_as) }
	|	TE_STR_OR
			{ $$ := new_clickable_string (new_or_string_as) }
	|	TE_STR_OR_ELSE
			{ $$ := new_clickable_string (new_or_else_string_as) }
	|	TE_STR_XOR
			{ $$ := new_clickable_string (new_xor_string_as) }
	|	TE_STR_FREE
			{ $$ := new_clickable_string (new_string_as (cloned_lower_string (token_buffer))) }
	;

Manifest_array: TE_LARRAY Expression_list_opt TE_RARRAY
			{ $$ := new_array_as ($2) }
	;

Manifest_tuple: TE_LSQURE Expression_list_opt TE_RSQURE
			{ $$ := new_tuple_as ($2) }
	;

Set_position: -- Empty
			{ set_position (current_position) }
	;

Position: -- Empty
			{ $$ := clone (current_position) }
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
