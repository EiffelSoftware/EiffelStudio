%{
note

	description: "Eiffel parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_PARSER

inherit

	EIFFEL_PARSER_SKELETON

create
	make,
	make_with_factory
%}

%start		Eiffel_parser

%nonassoc	TE_ASSIGNMENT TE_REPEAT_OPEN TE_REPEAT_CLOSE
%left		TE_FORALL TE_EXISTS
%nonassoc	TE_DOTDOT
%left		TE_IMPLIES TE_FREE_IMPLIES
%left		TE_OR TE_FREE_OR TE_FREE_OR_ELSE
%left		TE_XOR TE_FREE_XOR
%left		TE_AND TE_FREE_AND TE_FREE_AND_THEN
%left 		TE_TILDE TE_NOT_TILDE TE_NE TE_EQ TE_LT TE_GT TE_LE TE_GE
%left		TE_PLUS TE_MINUS
%left		TE_STAR TE_SLASH TE_MOD TE_DIV
%right		TE_POWER
%left		TE_FREE
%right		TE_NOT TE_FREE_NOT
%nonassoc	TE_STRIP
%left		TE_OLD
%left		TE_DOT
%right		TE_LPARAN TE_BLOCK_OPEN

%token <detachable ID_AS> TE_FREE TE_FREE_AND TE_FREE_AND_THEN TE_FREE_IMPLIES TE_FREE_NOT TE_FREE_OR TE_FREE_OR_ELSE TE_FREE_XOR TE_ID TE_TUPLE
%token TE_INTEGER
%token TE_REAL
%token <detachable CHAR_AS>		TE_CHAR

%token <detachable SYMBOL_AS> 		TE_LSQURE TE_RSQURE
%token <detachable SYMBOL_AS>		TE_ACCEPT TE_ADDRESS TE_ASSIGNMENT
%token <detachable SYMBOL_AS>		TE_LARRAY TE_RARRAY TE_RPARAN TE_LPARAN
%token <detachable SYMBOL_AS>		TE_LCURLY TE_RCURLY
%token <detachable SYMBOL_AS> 		TE_SEMICOLON
%token <detachable SYMBOL_AS>		TE_COLON TE_COMMA TE_BAR
%token <detachable SYMBOL_AS>		TE_CONSTRAIN TE_QUESTION
%token <detachable SYMBOL_AS> 		TE_DOTDOT TE_DOT
%token <detachable SYMBOL_AS> 		TE_TILDE TE_NOT_TILDE TE_EQ TE_LT TE_GT TE_LE TE_GE TE_NE
%token <detachable SYMBOL_AS> 		TE_PLUS TE_MINUS TE_STAR TE_SLASH TE_POWER
%token <detachable SYMBOL_AS> 		TE_DIV TE_MOD
	-- Special type for symbols that are either symbols or free operators.
%token <detachable like {AST_FACTORY}.symbol_id_type as symbol_id>		TE_FORALL TE_EXISTS TE_REPEAT_OPEN TE_REPEAT_CLOSE TE_BLOCK_OPEN TE_BLOCK_CLOSE

%token <detachable BOOL_AS> TE_FALSE TE_TRUE
%token <detachable RESULT_AS> TE_RESULT
%token <detachable RETRY_AS> TE_RETRY
%token <detachable UNIQUE_AS> TE_UNIQUE
%token <detachable CURRENT_AS> TE_CURRENT
%token <detachable DEFERRED_AS> TE_DEFERRED
%token <detachable VOID_AS> TE_VOID

%token <detachable KEYWORD_AS> TE_END
%token <detachable KEYWORD_AS> TE_FROZEN
%token <detachable KEYWORD_AS> TE_PARTIAL_CLASS	
%token <detachable KEYWORD_AS> TE_CREATION
%token <detachable KEYWORD_AS> TE_PRECURSOR

%token <detachable KEYWORD_AS> TE_AGENT TE_ALIAS TE_ALL TE_AND TE_AS
%token <detachable KEYWORD_AS> TE_CHECK TE_CLASS TE_CONVERT
%token <detachable KEYWORD_AS> TE_CREATE TE_DEBUG TE_DO TE_ELSE TE_ELSEIF
%token <detachable KEYWORD_AS> TE_ENSURE TE_EXPANDED TE_EXPORT TE_EXTERNAL TE_FEATURE
%token <detachable KEYWORD_AS> TE_FROM TE_IF TE_IMPLIES TE_INHERIT
%token <detachable KEYWORD_AS> TE_INSPECT TE_INVARIANT TE_LIKE TE_LOCAL
%token <detachable KEYWORD_AS> TE_LOOP TE_NOT TE_OBSOLETE TE_OLD TE_ONCE
%token <detachable KEYWORD_AS> TE_ONCE_STRING TE_OR TE_REDEFINE TE_REFERENCE TE_RENAME
%token <detachable KEYWORD_AS> TE_REQUIRE TE_RESCUE TE_SELECT TE_SEPARATE TE_STRIP
%token <detachable KEYWORD_AS> TE_THEN TE_UNDEFINE	TE_UNTIL TE_VARIANT TE_WHEN	
%token <detachable KEYWORD_AS> TE_XOR
-- Special type for keywords that are either keyword or identifier
%token <detachable TUPLE [keyword: detachable KEYWORD_AS; id: detachable ID_AS; line, column: INTEGER; filename: READABLE_STRING_GENERAL] as keyword_id> TE_ACROSS TE_ASSIGN TE_ATTRIBUTE TE_ATTACHED TE_DETACHABLE TE_INDEXING TE_IS TE_NOTE TE_SOME

%token <detachable STRING_AS> TE_STRING TE_EMPTY_STRING TE_VERBATIM_STRING	TE_EMPTY_VERBATIM_STRING
%token <detachable STRING_AS> TE_STR_LT TE_STR_LE TE_STR_GT TE_STR_GE TE_STR_MINUS
%token <detachable STRING_AS> TE_STR_PLUS TE_STR_STAR TE_STR_SLASH TE_STR_MOD
%token <detachable STRING_AS> TE_STR_DIV TE_STR_POWER TE_STR_AND TE_STR_AND_THEN
%token <detachable STRING_AS> TE_STR_IMPLIES TE_STR_OR TE_STR_OR_ELSE TE_STR_XOR
%token <detachable STRING_AS> TE_STR_NOT TE_STR_FREE TE_STR_BRACKET TE_STR_PARENTHESES

%type <detachable SYMBOL_AS>ASemi
%type <detachable KEYWORD_AS> Alias_mark Is_keyword
%type <detachable ALIAS_NAME_INFO>Alias
%type <detachable CONSTRUCT_LIST [ALIAS_NAME_INFO]> Alias_list
%type <detachable PAIR[KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]> Rescue

%type <detachable PAIR[KEYWORD_AS, ID_AS]> Assigner_mark_opt
%type <detachable PAIR[KEYWORD_AS, STRING_AS]> External_name Obsolete
%type <detachable IDENTIFIER_LIST>		Identifier_list Strip_identifier_list
%type <detachable PAIR [KEYWORD_AS, detachable EIFFEL_LIST [TAGGED_AS]]> Invariant
%type <detachable PAIR [KEYWORD_AS, EXPR_AS]>	Exit_condition_opt 
%type <detachable AGENT_TARGET_TRIPLE> Agent_target

%type <detachable ACCESS_AS>			A_feature Creation_target
%type <detachable ACCESS_FEAT_AS>		Feature_access
%type <detachable ACCESS_INV_AS>		Creation_call
%type <detachable ARRAY_AS>			Manifest_array
%type <detachable ASSIGN_AS>			Assignment
%type <detachable ATOMIC_AS>			Index_value Manifest_constant Expression_constant Manifest_value
%type <detachable BINARY_AS>			Qualified_binary_expression
%type <detachable BODY_AS>				Declaration_body
%type <detachable BOOL_AS>				Boolean_constant
%type <BOOLEAN>					Creation_region
%type <detachable CALL_AS>				Call
%type <detachable CASE_AS>				When_part
%type <detachable CASE_EXPRESSION_AS>				When_expression_part
%type <detachable CHAR_AS>				Character_constant
%type <detachable CHECK_AS>			Check
%type <detachable KEYWORD_AS>			Class_mark
%type <detachable CLIENT_AS>			Clients Feature_client_clause
%type <detachable CONSTANT_AS>			Constant_attribute
%type <detachable CONVERT_FEAT_AS>		Convert_feature
%type <detachable CREATE_AS>			Creation_clause
%type <detachable CREATION_AS>			Creation
%type <detachable CREATION_EXPR_AS>	Creation_expression
%type <detachable DEBUG_AS>			Debug
%type <detachable ELSIF_AS>			Elseif_part
%type <detachable ELSIF_EXPRESSION_AS>		Elseif_part_expression
%type <detachable ENSURE_AS>			Postcondition
%type <detachable EXPORT_ITEM_AS>		New_export_item
%type <detachable EXPR_AS>				Bracket_target Expression Factor Qualified_factor Typed_expression Actual_parameter 
%type <detachable BRACKET_AS>			Bracket_expression Call_bracket_expression
%type <detachable EXTERNAL_AS>			External
%type <detachable EXTERNAL_LANG_AS>	External_language
%type <detachable FEATURE_AS>			Feature_declaration
%type <detachable FEATURE_CLAUSE_AS>	Feature_clause
%type <detachable FEATURE_SET_AS>		Feature_set
%type <detachable FORMAL_AS>			Formal_parameter
%type <detachable FORMAL_DEC_AS>		Formal_generic
%type <detachable GUARD_AS>			Guard
%type <detachable ID_AS>				Class_or_tuple_identifier Class_identifier Tuple_identifier Identifier_as_lower Free_operator 
%type <detachable IF_AS>				Conditional
%type <detachable IF_EXPRESSION_AS>			Conditional_expression
%type <detachable INDEX_AS>			Index_clause Index_clause_impl Note_entry Note_entry_impl
%type <detachable INSPECT_AS>			Multi_branch
%type <detachable INSPECT_EXPRESSION_AS>		Multi_branch_expression
%type <detachable INSTRUCTION_AS>		Instruction Instruction_impl
%type <detachable INTEGER_AS>	Integer_constant Signed_integer Nosigned_integer Typed_integer Typed_nosigned_integer Typed_signed_integer
%type <detachable INTERNAL_AS>			Internal
%type <detachable INTERVAL_AS>			Choice
%type <detachable INVARIANT_AS>		Class_invariant
%type <detachable LOOP_EXPR_AS>			Loop_expression
%type <detachable LOOP_AS>				Loop_instruction
%type <detachable NAMED_EXPRESSION_AS>		Separate_argument
%type <detachable NESTED_EXPR_AS>		Qualified_call
%type <detachable OPERAND_AS>			Delayed_actual
%type <detachable PARENT_AS>			Parent Parent_clause
%type <detachable PRECURSOR_AS>		A_precursor
%type <detachable STATIC_ACCESS_AS>	A_static_call Old_a_static_call New_a_static_call
%type <detachable REAL_AS>				Real_constant Signed_real Nosigned_real Typed_real Typed_nosigned_real Typed_signed_real
%type <detachable RENAME_AS>			Rename_pair
%type <detachable REQUIRE_AS>			Precondition
%type <detachable REVERSE_AS>			Reverse_assignment
%type <detachable ROUT_BODY_AS>		Routine_body
%type <detachable ROUTINE_AS>			Routine
%type <detachable ROUTINE_CREATION_AS>	Agent
%type <detachable STRING_AS>			Manifest_string Non_empty_string Default_manifest_string Typed_manifest_string Infix_operator Alias_name
%type <detachable SEPARATE_INSTRUCTION_AS>	Separate_instruction
%type <detachable TAGGED_AS>			Assertion_clause
%type <detachable TUPLE_AS>			Manifest_tuple
%type <detachable TYPE_AS>				Type Anchored_type Typed Class_or_tuple_type Unmarked_class_type Unmarked_tuple_type Unmarked_anchored_type Unmarked_class_or_tuple_type Unmarked_unqualified_anchored_type Constraint_type
%type <detachable TYPE_AS>				Obsolete_type
%type <detachable QUALIFIED_ANCHORED_TYPE_AS>	Unmarked_qualified_anchored_type
%type <detachable CLASS_TYPE_AS>		Parent_class_type
%type <detachable TYPE_DEC_AS>			Entity_declaration_group
%type <detachable LIST_DEC_AS>			Local_declaration_group
%type <detachable VARIANT_AS>			Variant Variant_opt
%type <detachable FEATURE_NAME>			Feature_name Extended_feature_name New_feature

%type <detachable EIFFEL_LIST [ATOMIC_AS]>			Index_terms Note_values
%type <detachable EIFFEL_LIST [CASE_AS]>			When_part_list_opt When_part_list
%type <detachable EIFFEL_LIST [CASE_EXPRESSION_AS]>			When_expression_part_list_opt When_expression_part_list
%type <detachable CONVERT_FEAT_LIST_AS>			Convert_list Convert_clause
%type <detachable EIFFEL_LIST [CREATE_AS]>			Creators Creation_clause_list
%type <detachable EIFFEL_LIST [ELSIF_AS]>			Elseif_list Elseif_part_list
%type <detachable EIFFEL_LIST [ELSIF_EXPRESSION_AS]>			Elseif_list_expression Elseif_part_list_expression
%type <detachable EIFFEL_LIST [EXPORT_ITEM_AS]>	New_export_list
%type <detachable EXPORT_CLAUSE_AS> 				New_exports New_exports_opt
%type <detachable EIFFEL_LIST [EXPR_AS]>			Expression_list Parameter_list
%type <detachable PARAMETER_LIST_AS> 	Parameters
%type <detachable EIFFEL_LIST [FEATURE_AS]>		Feature_declaration_list
%type <detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]>	Features Feature_clause_list
%type <detachable EIFFEL_LIST [FEATURE_NAME]>		Feature_list Feature_list_impl New_feature_list
%type <detachable EIFFEL_LIST [FEAT_NAME_ID_AS]>		Creation_list Creation_list_impl
%type <detachable EIFFEL_LIST [NAMED_EXPRESSION_AS]>	Separate_argument_list
%type <detachable CREATION_CONSTRAIN_TRIPLE>	Creation_constraint
%type <detachable UNDEFINE_CLAUSE_AS>	Undefine Undefine_opt
%type <detachable REDEFINE_CLAUSE_AS> Redefine Redefine_opt
%type <detachable SELECT_CLAUSE_AS>	Select Select_opt
%type <detachable FORMAL_GENERIC_LIST_AS>		Formal_generics Formal_generic_list
%type <detachable CLASS_LIST_AS>					Client_list Class_list

%type <detachable INDEXING_CLAUSE_AS>			Indexing Index_list Note_list Dotnet_indexing
%type <detachable ITERATION_AS>			Iteration
%type <detachable EIFFEL_LIST [INSTRUCTION_AS]>	Compound Instruction_list
%type <detachable EIFFEL_LIST [INTERVAL_AS]>		Choices
%type <detachable EIFFEL_LIST [OPERAND_AS]>		Delayed_actual_list
%type <detachable DELAYED_ACTUAL_LIST_AS>	Delayed_actuals
%type <detachable PARENT_LIST_AS>					Inheritance Parent_list
%type <detachable EIFFEL_LIST [RENAME_AS]>			Rename_list
%type <detachable RENAME_CLAUSE_AS>				Rename 
%type <detachable EIFFEL_LIST [STRING_AS]>			String_list
%type <detachable KEY_LIST_AS>			Key_list
%type <detachable EIFFEL_LIST [TAGGED_AS]>			Assertion Assertion_list
%type <detachable TYPE_LIST_AS>	Generics Generics_opt Type_list Type_list_impl Actual_parameter_list
%type <detachable TYPE_DEC_LIST_AS>		Entity_declaration_list Named_parameter_list
%type <detachable LIST_DEC_LIST_AS>	Local_declaration_list
%type <detachable LOCAL_DEC_LIST_AS>	Local_declarations
%type <detachable FORMAL_ARGU_DEC_LIST_AS> Formal_arguments Optional_formal_arguments
%type <detachable CONSTRAINT_TRIPLE>	Constraint
%type <detachable CONSTRAINT_LIST_AS> Multiple_constraint_list
%type <detachable CONSTRAINING_TYPE_AS> Single_constraint

%expect 425

%%

--###################################################################
--# Root rule actually divided in 4 different parsers:
--# 1 - parsing Eiffel classes
--# 2 - parsing Eiffel types (differentiated by reading first a
--#     random Identifier
--# 3 - parsing Eiffel expression (differentiated by reading first
--#     the TE_FEATURE token)
--# 4 - parsing Eiffel indexing clause (needed for reading
--#     `indexing.txt' file used to describe a cluster)
--# 5 - parsing Eiffel entity declaration list (to get correct type for
--#     locals or arguments or attributes.
--###################################################################
Eiffel_parser:
		Class_declaration
			{
				if type_parser or expression_parser or feature_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				formal_parameters.wipe_out
			}
	|	Identifier_as_lower Type
			{
				if not type_parser or expression_parser or feature_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				type_node := $2
				formal_parameters.wipe_out
			}
	|	TE_FEATURE Feature_declaration
			{
				if not feature_parser or type_parser or expression_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				feature_node := $2
				formal_parameters.wipe_out
			}
	|	TE_CHECK Expression
			{
				if not expression_parser or type_parser or feature_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				expression_node := $2
				formal_parameters.wipe_out
			}
	|	Indexing
			{
				if not indexing_parser or type_parser or expression_parser or feature_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				indexing_node := $1
				formal_parameters.wipe_out
			}
	|	TE_INVARIANT Class_invariant
			{
				if not invariant_parser or type_parser or expression_parser or feature_parser or indexing_parser or entity_declaration_parser then
					raise_error
				end
				invariant_node := $2
				formal_parameters.wipe_out
			}
	|	TE_LOCAL
			{
				if not entity_declaration_parser or type_parser or expression_parser or feature_parser or indexing_parser or invariant_parser then
					raise_error
				end
				entity_declaration_node := Void
				formal_parameters.wipe_out
			}
	|	TE_LOCAL Add_counter Local_declaration_list Remove_counter
			{
				if not entity_declaration_parser or type_parser or expression_parser or feature_parser or indexing_parser or invariant_parser then
					raise_error
				end
				entity_declaration_node := $3
				formal_parameters.wipe_out
			}
	;

Class_declaration:
		Indexing								-- $1
		Header_mark								-- $2
		Class_mark							-- $3
		Class_or_tuple_identifier				-- $4
		Formal_generics							-- $5
		External_name							-- $6
		Obsolete								-- $7
		{conforming_inheritance_flag := False; non_conforming_inheritance_flag := False } Inheritance {set_conforming_inheritance_end_positions; conforming_inheritance_flag := True} Inheritance {set_non_conforming_inheritance_end_positions} -- $8 $9 $10 $11 $12
		Creators								-- $13
		Convert_clause							-- $14
		Features End_features_pos				-- $15 $16
		Class_invariant 						-- $17
		Indexing								-- $18
		TE_END									-- $19
			{
				if attached $6 as l_external then
					temp_string_as1 := l_external.second
				else
					temp_string_as1 := Void
				end
				if attached $7 as l_obsolete then
					temp_string_as2 := l_obsolete.second
				else
					temp_string_as2 := Void
				end
				
				root_node := new_class_description ($4, temp_string_as1,
					is_deferred, is_expanded, is_frozen_class, is_external_class, is_partial_class, is_once,
					$1, $18, $5, $9, $11, $13, $14, $15, $17, suppliers, temp_string_as2, $19)
				if attached root_node as l_root_node then
					l_root_node.set_text_positions (
						formal_generics_end_position,
						conforming_inheritance_end_position,
						non_conforming_inheritance_end_position,
						features_end_position,
						formal_generics_character_end_position,
						conforming_inheritance_character_end_position,
						non_conforming_inheritance_character_end_position,
						features_character_end_position
					)
					if attached $6 as l_external then
						l_root_node.set_alias_keyword (l_external.first)
					end
					if attached $7 as l_obsolete then
						l_root_node.set_obsolete_keyword (l_obsolete.first)
					end
					l_root_node.set_header_mark (frozen_keyword, expanded_keyword, deferred_keyword, once_keyword, external_keyword)
					l_root_node.set_class_keyword ($3)
				end
			}
	;

End_features_pos: { set_features_end_positions } ;
End_feature_clause_pos: { set_feature_clause_end_positions };
-- Indexing


Indexing: -- Empty
			-- { $$ := Void }
	|	TE_INDEXING Add_indexing_counter Index_list Remove_counter
			{
				if attached $3 as l_list then
					$$ := l_list
					l_list.set_indexing_keyword (extract_keyword ($1))
				end				
			}
	|	TE_INDEXING
			{
				if attached ast_factory.new_indexing_clause_as (0) as l_list then
					$$ := l_list
					l_list.set_indexing_keyword (extract_keyword ($1))
				end
			}
	|	TE_NOTE Add_indexing_counter Note_list Remove_counter
			{
				if attached $3 as l_list then
					$$ := l_list
					l_list.set_indexing_keyword (extract_keyword ($1))
				end				
			}
	|	TE_NOTE
			{
				if attached ast_factory.new_indexing_clause_as (0) as l_list then
					$$ := l_list
					l_list.set_indexing_keyword (extract_keyword ($1))
				end
			}
	;

Dotnet_indexing: -- Empty
			-- { $$ := Void }
	|	TE_INDEXING TE_END
		{
				if attached ast_factory.new_indexing_clause_as (0) as l_list then
						$$ := l_list
						l_list.set_indexing_keyword (extract_keyword ($1))
						l_list.set_end_keyword ($2)
				end		
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($2), token_column ($2), filename,
						once "Missing `attribute' keyword before `end' keyword."))
				end
		}
	|	TE_INDEXING Add_indexing_counter Index_list Remove_counter TE_END
			{
				if attached $3 as l_list then
					$$ := l_list
					if attached $1 as l_indexing then
						l_list.set_indexing_keyword (extract_keyword (l_indexing))
					end
					if attached $5 as l_end then
						l_list.set_end_keyword (l_end)
					end
				end				
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($5), token_column ($5), filename,
						once "Missing `attribute' keyword before `end' keyword."))
				end
			}
	;

Index_list: Index_clause
			{
				$$ := ast_factory.new_indexing_clause_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Index_clause Increment_counter Index_list
			{
				$$ := $3
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	;

Note_list: Note_entry
			{
				$$ := ast_factory.new_indexing_clause_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Note_entry ASemi Increment_counter Note_list
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	;

Index_clause: Add_counter Index_clause_impl Remove_counter
		{ $$ := $2 }
	;
			
Note_entry: Add_counter Note_entry_impl Remove_counter
		{ $$ := $2 }
	;
			
Index_clause_impl: Identifier_as_lower TE_COLON Index_terms ASemi
			{
				$$ := ast_factory.new_index_as ($1, $3, $2)
			}
	|	Index_terms ASemi
			{
				$$ := ast_factory.new_index_as (Void, $1, Void)
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
						once "Missing `Index' part of `Index_clause'."))
				end
			}
	;

Note_entry_impl: Identifier_as_lower TE_COLON Note_values
			{
				$$ := ast_factory.new_index_as ($1, $3, $2)
			}
	;

Index_terms: Index_value
			{
				$$ := ast_factory.new_eiffel_list_atomic_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Index_value TE_COMMA Increment_counter Index_terms
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	|	TE_SEMICOLON
			{
-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				$$ := ast_factory.new_eiffel_list_atomic_as (0)
			}
	;

Note_values: Index_value
			{
				$$ := ast_factory.new_eiffel_list_atomic_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Index_value TE_COMMA Increment_counter Note_values
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	;

Index_value: Identifier_as_lower
			{ $$ := $1 }
	|	Manifest_constant
			{ $$ := $1 }
	|	Disable_supplier_recording_only_for_classic Creation_expression TE_END Enable_supplier_recording_only_for_classic
			{ $$ := ast_factory.new_custom_attribute_as ($2, Void, $3) }
	|	Disable_supplier_recording_only_for_classic Creation_expression Manifest_tuple TE_END Enable_supplier_recording_only_for_classic
			{ $$ := ast_factory.new_custom_attribute_as ($2, $3, $4) }
	;

Disable_supplier_recording:
		{
			is_supplier_recorded := False
		}	
	;

Enable_supplier_recording:
		{
			is_supplier_recorded := True
		}	
	;

Disable_supplier_recording_only_for_classic:
		{
			if not il_parser then
				is_supplier_recorded := False
			end
		}	
	;

Enable_supplier_recording_only_for_classic:
		{
			if not il_parser then
				is_supplier_recorded := True
			end
		}	
	;

Header_mark: Frozen_mark External_mark
	|	TE_DEFERRED External_mark
			{
				is_deferred := True
				deferred_keyword := $1
			}
	|	Frozen_mark TE_EXPANDED External_mark
			{
				is_expanded := True
				expanded_keyword := $2
			}
	|	Frozen_mark TE_ONCE External_mark
			{
				is_once := True
				once_keyword := $2
			}
	;

Frozen_mark: -- Empty
	|	TE_FROZEN
			{
				is_frozen_class := True
				frozen_keyword := $1
			}
	;

External_mark: -- Empty
	|	TE_EXTERNAL
			{
				if il_parser then
					is_external_class := True
					external_keyword := $1
				else
						-- Trigger a syntax error.
					raise_error
				end
			}
	;
	
Class_mark: TE_CLASS
		{
			$$ := $1;
			is_partial_class := false;
			formal_parameters.wipe_out
		}
	| TE_PARTIAL_CLASS
		{
			$$ := $1;
			is_partial_class := true;
			formal_parameters.wipe_out
		}
	;

-- Obsolete


Obsolete: -- Empty
			-- { $$ := Void }
	|	TE_OBSOLETE Default_manifest_string
			{
				$$ := ast_factory.new_keyword_string_pair ($1, $2)
			}
	;


-- Features

Features: -- Empty
			-- { $$ := Void }
	|	Add_counter Feature_clause_list Remove_counter
			{
				if attached $2 as l_list then
					if l_list.is_empty then
						$$ := Void
					else
						$$ := l_list
					end
				end
			}
	;

Feature_clause_list: Feature_clause
			{
				$$ := ast_factory.new_eiffel_list_feature_clause_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Feature_clause Increment_counter Feature_clause_list
			{
				$$ := $3
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	;

Feature_clause: Feature_client_clause End_feature_clause_pos
			{ $$ := ast_factory.new_feature_clause_as ($1,
				ast_factory.new_eiffel_list_feature_as (0), fclause_pos, feature_clause_end_position) }
	|	Feature_client_clause Add_counter Feature_declaration_list Remove_counter End_feature_clause_pos
			{ $$ := ast_factory.new_feature_clause_as ($1, $3, fclause_pos, feature_clause_end_position) }
	;

Feature_client_clause: TE_FEATURE
			{
				if attached $1 as l_keyword then
						-- Originally, it was 8, I changed it to 7, delete the following line when fully tested. (Jason)
					l_keyword.set_position (line, column, position, 7, character_column, character_position, 7)
					fclause_pos := l_keyword
				else
						-- Originally, it was 8, I changed it to 7 (Jason)
					fclause_pos := ast_factory.new_feature_keyword_as (line, column, position, 7, character_column, character_position, 7, Current)
				end
				
			}
		Clients
			{ $$ := $3 }
	;

Clients: -- Empty
			-- { $$ := Void }
	|	Client_list
			{ $$ := ast_factory.new_client_as ($1) }
	;

Client_list: TE_LCURLY TE_RCURLY
			{
				
					-- Per ECMA, this should be rejected. For now we only raise
					-- a warning. And on the compiler side, we will simply consider as {NONE}.
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
							once "Empty Client_list is not allowed and will be assumed to be {NONE}."))
				end
				$$ := ast_factory.new_class_list_as (1)
				if attached $$ as l_list and then attached new_none_id as l_none_id then
					l_list.reverse_extend (l_none_id)
					l_list.set_lcurly_symbol ($1)
					l_list.set_rcurly_symbol ($2)
				end
			}
	|	TE_LCURLY Add_counter Class_list Remove_counter TE_RCURLY
			{
				if attached $3 as l_list then
					$$ := l_list
					l_list.set_lcurly_symbol ($1)
					l_list.set_rcurly_symbol ($5)
				end				
			}
	;

Class_list: Class_or_tuple_identifier
			{
				$$ := ast_factory.new_class_list_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
					suppliers.insert_light_supplier_id (l_val)
				end
			}
	|	Class_or_tuple_identifier TE_COMMA Increment_counter Class_list
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
					suppliers.insert_light_supplier_id (l_val)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	;

Feature_declaration_list: Feature_declaration
			{
				$$ := ast_factory.new_eiffel_list_feature_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Feature_declaration Increment_counter Feature_declaration_list
			{
				$$ := $3
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	;

ASemi: -- Empty
	|	TE_SEMICOLON { $$ := $1 }
	;

Feature_declaration: Add_counter New_feature_list Remove_counter {enter_scope} Declaration_body {leave_scope} Optional_semicolons
			{
				$$ := ast_factory.new_feature_as ($2, $5, feature_indexes, position)
				if has_syntax_warning then
					if attached feature_indexes as fi and then fi.has_global_once then
						if attached fi.once_status_index_as as fi_tok then
							report_one_warning (
								create {SYNTAX_WARNING}.make (token_line (fi_tok), token_column (fi_tok), filename,
								once "Specifying once_status in indexing note is Obsolete, please use once (%"PROCESS%")."))
						else
							check indexes_has_once_status_index: False end
						end
					end
				end
				if 
					attached ($$) as l_feature_as and then 
					attached l_feature_as.once_as as l_once_as
				then
					if l_once_as.has_key_conflict ($$) then
						report_one_error (ast_factory.new_vvok1_error (token_line (l_once_as), token_column (l_once_as), filename, $$))
					elseif l_once_as.has_invalid_key ($$) then
						if attached l_once_as.invalid_key ($$) as l_once_invalid_key then
							report_one_error (ast_factory.new_vvok2_error (token_line (l_once_invalid_key), token_column (l_once_invalid_key), filename, $$))
						else
							report_one_error (ast_factory.new_vvok2_error (token_line (l_once_as), token_column (l_once_as), filename, $$))
						end
					end
				end

				feature_indexes := Void
			}
	;

New_feature_list: New_feature
			{
				$$ := ast_factory.new_eiffel_list_feature_name (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	New_feature TE_COMMA Increment_counter New_feature_list
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	;

New_feature: Extended_feature_name
			{ $$ := $1 }
	|	TE_FROZEN Extended_feature_name
			{
				if attached $2 as l_name then
					$$ := l_name
					l_name.set_frozen_keyword ($1)
				end
			}
	;

Extended_feature_name: Feature_name
			{ $$ := $1 }
	|	Identifier_as_lower Add_counter Alias_list Remove_counter Alias_mark
			{
				if attached $3 as l_aliases and then not l_aliases.is_empty then
					$$ := ast_factory.new_feature_name_alias_as ($1, l_aliases, $5)
				end
			}
	;

Feature_name: Identifier_as_lower
			{ $$ := ast_factory.new_feature_name_id_as ($1) }
	;

Alias_list: Alias
			{
				$$ := ast_factory.new_alias_list (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.extend (l_val)
				end
			}
	|	Alias Increment_counter Alias_list
			{
				$$ := $3
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.put_front (l_val)
				end
			}
	;

Alias: TE_ALIAS Alias_name
			{
				$$ := ast_factory.new_alias_name_info ($1, $2)
			}
	;

Alias_name: Infix_operator
			{ $$ := $1 }
	|	TE_STR_NOT
			{ $$ := $1 }
	|	TE_STR_BRACKET
			{ $$ := $1 }
	|	TE_STR_PARENTHESES
			{ $$ := $1 }
	;

Alias_mark: -- Empty
			{ has_convert_mark := False }
	|	TE_CONVERT
			{ has_convert_mark := True
				$$ := $1
			}
	;

Is_keyword: -- Empty
			{ $$ := Void }
	| TE_IS
			{
				$$ := extract_keyword ($1)
				report_deprecated_use_of_keyword_is ($$)
			}
	;

Declaration_body: TE_COLON Type Assigner_mark_opt Dotnet_indexing
			{
					-- Attribute case
				if attached $3 as l_assigner_mark then
					$$ := ast_factory.new_body_as (Void, $2, l_assigner_mark.second, Void, $1, Void, l_assigner_mark.first, $4)
				else
					$$ := ast_factory.new_body_as (Void, $2, Void, Void, $1, Void, Void, $4)
				end				
				feature_indexes := $4
			}
	|       TE_COLON Type Assigner_mark_opt TE_EQ Constant_attribute Dotnet_indexing
			{
					-- Constant case
				if attached $3 as l_assigner_mark then
					$$ := ast_factory.new_body_as (Void, $2, l_assigner_mark.second, $5, $1, $4, l_assigner_mark.first, $6)
				else
					$$ := ast_factory.new_body_as (Void, $2, Void, $5, $1, $4, Void, $6)
				end
				
				feature_indexes := $6
			}
	|	TE_COLON Type Assigner_mark_opt TE_IS Constant_attribute Dotnet_indexing
			{
					-- Constant case
				if attached $3 as l_assigner_mark then
					$$ := ast_factory.new_body_as (Void, $2, l_assigner_mark.second, $5, $1, extract_keyword ($4), l_assigner_mark.first, $6)
				else
					$$ := ast_factory.new_body_as (Void, $2, Void, $5, $1, extract_keyword ($4), Void, $6)
				end
				feature_indexes := $6
				report_deprecated_use_of_keyword_is (extract_keyword ($4))
			}
	|	Is_keyword Indexing Routine
			{
					-- procedure without arguments		
				$$ := ast_factory.new_body_as (Void, Void, Void, $3, Void, $1, Void, $2)
				feature_indexes := $2
			}
	|	TE_COLON Type Assigner_mark_opt TE_IS Indexing Routine
		{
					-- Function without arguments
				if attached $3 as l_assigner_mark then
					$$ := ast_factory.new_body_as (Void, $2, l_assigner_mark.second, $6, $1, extract_keyword ($4), l_assigner_mark.first, $5)
				else
					$$ := ast_factory.new_body_as (Void, $2, Void, $6, $1, extract_keyword ($4), Void, $5)
				end
				feature_indexes := $5
				report_deprecated_use_of_keyword_is (extract_keyword ($4))
		}
	|	TE_COLON Type Assigner_mark_opt Indexing Routine
			{
					-- Function without arguments
				if attached $3 as l_assigner_mark then
					$$ := ast_factory.new_body_as (Void, $2, l_assigner_mark.second, $5, $1, Void, l_assigner_mark.first, $4)
				else
					$$ := ast_factory.new_body_as (Void, $2, Void, $5, $1, Void, Void, $4)
				end
				
				feature_indexes := $4
			}
	|	Formal_arguments Is_keyword Indexing Routine
			{
					-- procedure with arguments
				$$ := ast_factory.new_body_as ($1, Void, Void, $4, Void, $2, Void, $3)
				feature_indexes := $3
			}
	|	Formal_arguments TE_COLON Type Assigner_mark_opt Is_keyword Indexing Routine
			{
					-- Function with arguments
				if attached $4 as l_assigner_mark then
					$$ := ast_factory.new_body_as ($1, $3, l_assigner_mark.second, $7, $2, $5, l_assigner_mark.first, $6)
				else
					$$ := ast_factory.new_body_as ($1, $3, Void, $7, $2, $5, Void, $6)
				end				
				feature_indexes := $6
			}
	;

Assigner_mark_opt: -- Empty
			{
				$$ := ast_factory.new_assigner_mark_as (Void, Void)
			}
	|	TE_ASSIGN Identifier_as_lower
			{
				$$ := ast_factory.new_assigner_mark_as (extract_keyword ($1), $2)
			}
	;

Constant_attribute: Manifest_value
			{
				$$ := ast_factory.new_constant_as ($1) 
			}
	|	TE_UNIQUE
			{ $$ := ast_factory.new_constant_as ($1) }
	;

-- Inheritance

Inheritance: -- Empty
			{ $$ := Void }
	|	TE_INHERIT ASemi
			{
				if not conforming_inheritance_flag then
						-- Conforming inheritance
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
							once "Use `inherit ANY' or do not specify an empty inherit clause"))
					end
					$$ := ast_factory.new_eiffel_list_parent_as (0)
					if attached $$ as l_inheritance then
						l_inheritance.set_inheritance_tokens ($1, Void, Void, Void)
					end
				else
						-- Raise error as conforming inheritance has already been specified
					if non_conforming_inheritance_flag then
						report_one_error (create {SYNTAX_ERROR}.make (token_line ($1), token_column ($1), filename, "Conforming inheritance clause must come before non conforming inheritance clause"))
					else
						report_one_error (create {SYNTAX_ERROR}.make (token_line ($1), token_column ($1), filename, "Only one conforming inheritance clause allowed per class"))
					end
				end
			}
	|	TE_INHERIT Add_counter Parent_list Remove_counter
			{
				if not conforming_inheritance_flag then
						-- Conforming inheritance
					$$ := $3
					if attached $$ as l_inheritance then
						l_inheritance.set_inheritance_tokens ($1, Void, Void, Void)
					end
				else
						-- Raise error as conforming inheritance has already been specified
					if non_conforming_inheritance_flag then
						report_one_error (create {SYNTAX_ERROR}.make (token_line ($1), token_column ($1), filename, "Conforming inheritance clause must come before non conforming inheritance clause"))
					else
						report_one_error (create {SYNTAX_ERROR}.make (token_line ($1), token_column ($1), filename, "Only one conforming inheritance clause allowed per class"))
					end
				end
			}
	|	TE_INHERIT TE_LCURLY Class_identifier TE_RCURLY
			{
					-- Non conforming inheritance
				
				if not non_conforming_inheritance_flag then
						-- Check to make sure Class_identifier is 'NONE'
						-- An error will be thrown if TYPE_AS is not of type NONE_TYPE_AS
					ast_factory.validate_non_conforming_inheritance_type (Current, new_class_type ($3, Void))

						-- Set flag so that no more inheritance clauses can be added as non-conforming is always the last one.
					non_conforming_inheritance_flag := True
				else
						-- Raise error as non conforming inheritance has already been specified
					report_one_error (create {SYNTAX_ERROR}.make (token_line ($1), token_column ($1), filename, "Only one non-conforming inheritance clause allowed per class"))
				end
			}
		Add_counter Parent_list Remove_counter
			{
				$$ := $7
				if attached $$ as l_inheritance then
					l_inheritance.set_inheritance_tokens ($1, $2, $3, $4)
				end
			}
			
	;
			
Parent_list: Parent
			{
				$$ := ast_factory.new_eiffel_list_parent_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Parent Increment_counter Parent_list
			{
				$$ := $3
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	;

Parent: Parent_clause ASemi
			{ $$ := $1 }
	;

Parent_class_type: Class_identifier Generics_opt
			{ $$ := ast_factory.new_class_type_as ($1, $2) }
	;

Parent_clause: Parent_class_type
			{ $$ := ast_factory.new_parent_as ($1, Void, Void, Void, Void, Void, Void) }
	|	Parent_class_type Select TE_END
			{ $$ := ast_factory.new_parent_as ($1, Void, Void, Void, Void, $2, $3) }
	|	Parent_class_type Redefine Select_opt TE_END
			{ $$ := ast_factory.new_parent_as ($1, Void, Void, Void, $2, $3, $4) }
	|	Parent_class_type Undefine Redefine_opt Select_opt TE_END
			{ $$ := ast_factory.new_parent_as ($1, Void, Void, $2, $3, $4, $5) }
	|	Parent_class_type New_exports Undefine_opt Redefine_opt Select_opt TE_END
			{ $$ := ast_factory.new_parent_as ($1, Void, $2, $3, $4, $5, $6) }
	|	Parent_class_type Rename New_exports_opt Undefine_opt Redefine_opt Select_opt TE_END
			{ $$ := ast_factory.new_parent_as ($1, $2, $3, $4, $5, $6, $7) }
	;

Rename: TE_RENAME
			{
				$$ := ast_factory.new_rename_clause_as (Void, $1)
				if is_constraint_renaming then
					report_one_error (
						create {SYNTAX_ERROR}.make (token_line ($1), token_column ($1), filename,
						"Empty rename clause."))
				else
					report_one_warning (
							create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
							"Remove empty rename clauses."))
				end
			}
	|	TE_RENAME Add_counter Rename_list Remove_counter
			{ $$ := ast_factory.new_rename_clause_as ($3, $1) }
	;

Rename_list: Rename_pair
			{
				$$ := ast_factory.new_eiffel_list_rename_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Rename_pair TE_COMMA Increment_counter Rename_list
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	;

Rename_pair: Feature_name TE_AS Extended_feature_name
			{ $$ := ast_factory.new_rename_as ($1, $3, $2) }
	;

New_exports_opt: -- Empty
			-- { $$ := Void }
	|	New_exports
			{ $$ := $1 }
	;

New_exports: TE_EXPORT Add_counter New_export_list Remove_counter
			{ $$ := ast_factory.new_export_clause_as ($3, $1) }
	|	TE_EXPORT ASemi
			{ $$ := ast_factory.new_export_clause_as (Void, $1) }
	;

New_export_list: New_export_item
			{
				$$ := ast_factory.new_eiffel_list_export_item_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	New_export_item Increment_counter New_export_list
			{
				$$ := $3
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	;

New_export_item: Client_list Feature_set ASemi
			{
				if $2 = Void then
						-- Per ECMA, this should be rejected. For now we only raise
						-- a warning. And on the compiler side, we will simply ignore them altogether.
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
								once "Empty Feature_set is not allowed and will be discarded."))
					end
				end
				$$ := ast_factory.new_export_item_as (ast_factory.new_client_as ($1), $2)
			}
	;

Feature_set: -- Empty
			-- { $$ := Void }
	|	TE_ALL
			{ $$ := ast_factory.new_all_as ($1) }
	|	Feature_list
			{ $$ := ast_factory.new_feature_list_as ($1) }
	;

Convert_clause: -- Empty
			-- { $$ := Void }
	|	TE_CONVERT Add_counter Convert_list Remove_counter
		{
			if attached $3 as l_list then
				$$ := l_list
				l_list.set_convert_keyword ($1)
			end
		}
	;

Convert_list: Convert_feature
		{
			$$ := ast_factory.new_eiffel_list_convert (counter_value + 1)
			if attached $$ as l_list and then attached $1 as l_val then
				l_list.reverse_extend (l_val)
			end
		}
	|	Convert_feature TE_COMMA Increment_counter Convert_list
		{	
			$$ := $4
			if attached $$ as l_list and then attached $1 as l_val then
				l_list.reverse_extend (l_val)
				ast_factory.reverse_extend_separator (l_list, $2)
			end
		}
	;


Convert_feature: Feature_name TE_LPARAN TE_LCURLY Type_list TE_RCURLY TE_RPARAN
		{
				-- True because this is a conversion feature used as a creation
				-- procedure in current class.
			$$ := ast_factory.new_convert_feat_as (True, $1, $4, $2, $6, Void, $3, $5)
		}
	|	Feature_name TE_COLON TE_LCURLY Type_list TE_RCURLY
		{
				-- False because this is not a conversion feature used as a creation
				-- procedure.
			$$ := ast_factory.new_convert_feat_as (False, $1, $4, Void, Void, $2, $3, $5)
		}
	;

Creation_list: Add_counter Creation_list_impl Remove_counter
		{ $$ := $2 }
	;

Creation_list_impl: Identifier_as_lower
			{
				$$ := ast_factory.new_eiffel_list_feature_name_id (counter_value + 1)
				if
					attached $$ as l_list and then
					attached $1 as l_val and then
					attached ast_factory.new_feature_name_id_as (l_val) as l_id
				then
					l_list.reverse_extend (l_id)
				end
			}
	|	Identifier_as_lower TE_COMMA Increment_counter Creation_list_impl
			{
				$$ := $4
				if
					attached $$ as l_list and then
					attached $1 as l_val and then
					attached ast_factory.new_feature_name_id_as (l_val) as l_id
				then
					l_list.reverse_extend (l_id)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	;

Feature_list: Add_counter Feature_list_impl Remove_counter
		{ $$ := $2 }
	;

Feature_list_impl: Feature_name
			{
				$$ := ast_factory.new_eiffel_list_feature_name (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Feature_name TE_COMMA Increment_counter Feature_list_impl
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	;

Undefine_opt: -- Empty
			-- { $$ := Void }
	|	Undefine
			{ $$ := $1 }
	;

Undefine: TE_UNDEFINE
			--- { $$ := Void }
			{
				$$ := ast_factory.new_undefine_clause_as (Void, $1)
			}
	|	TE_UNDEFINE Feature_list
			{
				$$ := ast_factory.new_undefine_clause_as ($2, $1)
			}
	;

Redefine_opt: -- Empty
			-- { $$ := Void }
	|	Redefine
			{ $$ := $1 }
	;

Redefine: TE_REDEFINE
			--- { $$ := Void }
			{
				$$ := ast_factory.new_redefine_clause_as (Void, $1)
			}
	|	TE_REDEFINE Feature_list
			{
				$$ := ast_factory.new_redefine_clause_as ($2, $1)				
			}
	;

Select_opt: -- Empty
		--	{ $$ := Void }
	|	Select
			{ $$ := $1 }
	;

Select: TE_SELECT
			--- { $$ := Void }
			{
				if non_conforming_inheritance_flag then
					report_one_error (create {SYNTAX_ERROR}.make (token_line ($1), token_column ($1),
						filename, "Non-conforming inheritance may not use select clause"))
				end
				$$ := ast_factory.new_select_clause_as (Void, $1)
			}
	|	TE_SELECT Feature_list
			{
				if non_conforming_inheritance_flag and attached $1 as l_keyword then
					report_one_error (create {SYNTAX_ERROR}.make (token_line ($1), token_column ($1),
						filename, "Non-conforming inheritance may not use select clause"))
				end
				$$ := ast_factory.new_select_clause_as ($2, $1)
			}
	;


-- Feature declaration


Formal_arguments:	TE_LPARAN TE_RPARAN
			{
					-- Per ECMA, this should be rejected. For now we only raise
					-- a warning. And on the compiler side, we will simply ignore them altogether.
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
						once "Empty formal argument list is not allowed"))
				end
				$$ := ast_factory.new_formal_argu_dec_list_as (Void, $1, $2)
			}
	|	TE_LPARAN Add_counter Entity_declaration_list Remove_counter TE_RPARAN
			{ $$ := ast_factory.new_formal_argu_dec_list_as ($3, $1, $5) }
	;

Entity_declaration_list: Entity_declaration_group
			{
				$$ := ast_factory.new_eiffel_list_type_dec_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Entity_declaration_group Increment_counter Entity_declaration_list
			{
				$$ := $3
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	;

Entity_declaration_group: Add_counter Identifier_list Remove_counter TE_COLON Type ASemi
			{
				$$ := ast_factory.new_type_dec_as ($2, $5, $4)
				if attached $2 as list and then attached list.id_list as identifiers then
					add_scope_arguments (identifiers)
				end
			}
	;

Local_declaration_list: Local_declaration_group
			{
				$$ := ast_factory.new_eiffel_list_list_dec_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Local_declaration_group Increment_counter Local_declaration_list
			{
				$$ := $3
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	;

Local_declaration_group:
		Add_counter Identifier_list Remove_counter ASemi
			{ 
				if not is_type_inference_supported then
					raise_error
				end
				$$ := ast_factory.new_list_dec_as ($2)
				if attached $2 as list and then attached list.id_list as identifiers then
					add_scope_locals (identifiers)
				end
			}
	|	Add_counter Identifier_list Remove_counter TE_COLON Type ASemi
			{
				$$ := ast_factory.new_type_dec_as ($2, $5, $4)
				if attached $2 as list and then attached list.id_list as identifiers then
					add_scope_locals (identifiers)
				end
			}
	;

Identifier_list: Identifier_as_lower
			{
				$$ := ast_factory.new_identifier_list (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_val)
				end
			}
	|	Identifier_as_lower TE_COMMA Increment_counter Identifier_list 
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_val)
					ast_factory.reverse_extend_identifier_separator (l_list, $2)
				end
			}
	;

Strip_identifier_list: -- Empty
			{ $$ := ast_factory.new_identifier_list (0) }
	|	Add_counter Identifier_list Remove_counter
			{ $$ := $2 }
	;

Routine:
		Obsolete
			{
				set_fbody_pos (position)
			}
		Precondition
			{
					 -- Start a scope for local variables.
				enter_scope
			}
		Local_declarations
		Routine_body
		Postcondition
		Rescue
		TE_END
			{
				if attached $1 as l_pair then
					temp_string_as1 := l_pair.second
					temp_keyword_as := l_pair.first
				else
					temp_string_as1 := Void
					temp_keyword_as := Void
				end
				if attached $8 as l_rescue then
					$$ := ast_factory.new_routine_as (temp_string_as1, $3, $5, $6, $7, l_rescue.second, $9, once_manifest_string_counter_value, fbody_pos, temp_keyword_as, l_rescue.first, object_test_locals, has_non_object_call, has_non_object_call_in_assertion, has_unqualified_call_in_assertion)
				else
					$$ := ast_factory.new_routine_as (temp_string_as1, $3, $5, $6, $7, Void, $9, once_manifest_string_counter_value, fbody_pos, temp_keyword_as, Void, object_test_locals, has_non_object_call, has_non_object_call_in_assertion, has_unqualified_call_in_assertion)
				end
				reset_feature_frame
				object_test_locals := Void
				leave_scope -- For local variables.
			}
	;

Routine_body: Internal
			{ $$ := $1 }
	|	External
			{ $$ := $1 }
	|	TE_DEFERRED
			{ $$ := $1 }
	;

External: TE_EXTERNAL External_language External_name
			{
				if attached $2 as l_language and then l_language.is_built_in then
					if attached $3 as l_name then 
						$$ := ast_factory.new_built_in_as (l_language, l_name.second, $1, l_name.first)
					else
						$$ := ast_factory.new_built_in_as (l_language, Void, $1, Void)
					end
				elseif attached $3 as l_name then
					$$ := ast_factory.new_external_as ($2, l_name.second, $1, l_name.first)
				else
					$$ := ast_factory.new_external_as ($2, Void, $1, Void)
				end
			}
	;

External_language:
		Non_empty_string
			{ $$ := ast_factory.new_external_lang_as ($1) }
	;

External_name: -- Empty
			-- { $$ := Void }
	|	TE_ALIAS Default_manifest_string
			{
				$$ := ast_factory.new_keyword_string_pair ($1, $2)
			}
	;

Internal: TE_DO Compound
			{ $$ := ast_factory.new_do_as ($2, $1) }
	|	TE_ONCE Key_list Compound
			{ $$ := ast_factory.new_once_as ($1, $2, $3) }
	|	TE_ATTRIBUTE Compound
			{ $$ := ast_factory.new_attribute_as ($2, extract_keyword ($1)) }
	;

Local_declarations: -- Empty
			-- { $$ := Void }
	|	TE_LOCAL
			{ $$ := ast_factory.new_local_dec_list_as (ast_factory.new_eiffel_list_type_dec_as (0), $1) }
	|	TE_LOCAL Add_counter Local_declaration_list Remove_counter
			{ $$ := ast_factory.new_local_dec_list_as ($3, $1) }
	;

Compound: Optional_semicolons
			-- { $$ := Void }
	|	Optional_semicolons Add_counter Instruction_list Remove_counter
			{ $$ := $3 }
	;

Instruction_list: Instruction
			{
				$$ := ast_factory.new_eiffel_list_instruction_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Instruction Increment_counter Instruction_list
			{
				$$ := $3
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	;

Instruction: Instruction_impl Optional_semicolons
			{
				if attached $1 as l_instructions then
					$$ := l_instructions
					l_instructions.set_line_pragma (last_line_pragma)
				end
			}
	;

Optional_semicolons: -- Empty
	| Optional_semicolons TE_SEMICOLON
	;

Instruction_impl: Creation
			{ $$ := $1 }
	|	Call
			{ $$ := ast_factory.new_instr_call_as ($1) }
	|	Qualified_call TE_ASSIGNMENT Expression
			{ $$ := ast_factory.new_assigner_call_as (ast_factory.new_expr_call_as ($1), $3, $2) }
	|	A_static_call TE_ASSIGNMENT Expression
			{ $$ := ast_factory.new_assigner_call_as ($1, $3, $2) }
	|	Bracket_expression TE_ASSIGNMENT Expression
			{ $$ := ast_factory.new_assigner_call_as ($1, $3, $2) }
	|	Call_bracket_expression TE_ASSIGNMENT Expression
			{ $$ := ast_factory.new_assigner_call_as ($1, $3, $2) }
	|	Assignment
			{ $$ := $1 }
	|	Reverse_assignment
			{ $$ := $1 }
	|	Conditional
			{ $$ := $1 }
	|	Loop_instruction
			{ $$ := $1 }
	|	Multi_branch
			{ $$ := $1 }
	|	Debug
			{ $$ := $1 }
	|	Check
			{ $$ := $1 }
	|	Guard
			{ $$ := $1 }
	|	Separate_instruction
			{ $$ := $1 }
	|	TE_RETRY
			{ $$ := $1 }
	;

Precondition: -- Empty
			-- { $$ := Void }
	|	TE_REQUIRE
			{ set_id_level (Precondition_level) }
		Assertion
			{
				set_id_level (Normal_level)
				$$ := ast_factory.new_require_as ($3, $1)
			}
	|	TE_REQUIRE TE_ELSE
			{ set_id_level (Precondition_level) }
		Assertion
			{
				set_id_level (Normal_level)
				$$ := ast_factory.new_require_else_as ($4, $1, $2)
			}
	;

Postcondition: -- Empty
			-- { $$ := Void }
	|	TE_ENSURE
			{ set_id_level (Postcondition_level) }
		Assertion
			{
				set_id_level (Normal_level)
				$$ := ast_factory.new_ensure_as ($3, is_class_feature, $1)
			}
	|	TE_ENSURE TE_THEN
			{ set_id_level (Postcondition_level) }
		Assertion
			{
				set_id_level (Normal_level)
				$$ := ast_factory.new_ensure_then_as ($4, is_class_feature, $1, $2)
			}
	;

Assertion: -- Empty
			-- { $$ := Void }
	|	Add_counter Assertion_list Remove_counter
			{
				if attached $2 as l_list then
					if l_list.is_empty then
						$$ := Void
					else
						$$ := l_list
					end
				end
			}
	;

Assertion_list: Assertion_clause
			{
					-- Special list treatment here as we do not want Void
					-- element in `Assertion_list'.
				if attached $1 as l_val then
					$$ := ast_factory.new_eiffel_list_tagged_as (counter_value + 1)
					if attached $$ as l_list then
						l_list.reverse_extend (l_val)
					end
				else
					$$ := ast_factory.new_eiffel_list_tagged_as (counter_value)
				end
			}
	|	Assertion_clause
			{
					-- Only increment counter when clause is not Void.
				if $1 /= Void then
					increment_counter
				end
			}
		Assertion_list
			{
				$$ := $3
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	;

Assertion_clause:
		Expression ASemi
			{ $$ := ast_factory.new_tagged_as (Void, $1, Void, Void) }
	|	TE_CLASS ASemi
			{
				if id_level = Postcondition_level then
					$$ := ast_factory.new_tagged_as (Void, Void, $1, Void)
					set_is_class_feature (True)
				else
					raise_error
				end
			}
	|	Identifier_as_lower TE_COLON Expression ASemi
			{ $$ := ast_factory.new_tagged_as ($1, $3, Void, $2) }
	|	Identifier_as_lower TE_COLON TE_CLASS ASemi
			{
				if id_level = Postcondition_level then
					$$ := ast_factory.new_tagged_as ($1, Void, $3, $2)
					set_is_class_feature (True)
				else
					raise_error
				end
			}
	|	Identifier_as_lower TE_COLON ASemi
		{
				-- Always create an object here for roundtrip parser.
				-- This "fake" assertion will be filtered out later.
			$$ := ast_factory.new_tagged_as ($1, Void, Void, $2)
		}
	;

-- Type
-- Note that only `Type' should be used in other constructs. If something else is used, please make
-- sure to put a note (e.g. 'Class_or_tuple_type' being used in 'Constraint_type'.

Type: Class_or_tuple_type
			{ $$ := $1 }
	|	Anchored_type
			{ $$ := $1 }
	|	Obsolete_type
			{ $$ := $1 }
	;

-- This is also used in 'Constraint_type' as constraint only support a subset of possible types.
Class_or_tuple_type:
	Unmarked_class_or_tuple_type
			{ $$ := $1 }
	| TE_DETACHABLE Unmarked_class_or_tuple_type
			{
				$$ := $2
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($1), False, True)
				end
			}
	| TE_ATTACHED Unmarked_class_or_tuple_type
			{
				$$ := $2
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($1), True, False)
				end
			}
	| TE_FROZEN Unmarked_class_or_tuple_type
			{
				$$ := $2
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, True, False)
				end
			}
	| TE_VARIANT Unmarked_class_or_tuple_type
			{
				$$ := $2
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, False, True)
				end
			}
	| TE_SEPARATE Unmarked_class_or_tuple_type
			{
				$$ := $2
				if attached $$ as l_type then
					l_type.set_separate_mark ($1)
				end
			}
	| TE_DETACHABLE TE_SEPARATE Unmarked_class_or_tuple_type
			{
				$$ := $3
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($1), False, True)
				end
				if attached $$ as l_type then
					l_type.set_separate_mark ($2)
				end
			}
	| TE_ATTACHED TE_SEPARATE Unmarked_class_or_tuple_type
			{
				$$ := $3
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($1), True, False)
				end
				if attached $$ as l_type then
					l_type.set_separate_mark ($2)
				end
			}
	| TE_FROZEN TE_DETACHABLE Unmarked_class_or_tuple_type
			{
				$$ := $3
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, True, False)
				end
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($2), False, True)
				end
			}
	| TE_FROZEN TE_ATTACHED Unmarked_class_or_tuple_type
			{
				$$ := $3
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, True, False)
				end
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($2), True, False)
				end
			}
	| TE_FROZEN TE_SEPARATE Unmarked_class_or_tuple_type
			{
				$$ := $3
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, True, False)
				end
				if attached $$ as l_type then
					l_type.set_separate_mark ($2)
				end
			}
	| TE_FROZEN TE_DETACHABLE TE_SEPARATE Unmarked_class_or_tuple_type
			{
				$$ := $4
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, True, False)
				end
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($2), False, True)
				end
				if attached $$ as l_type then
					l_type.set_separate_mark ($3)
				end
			}
	| TE_FROZEN TE_ATTACHED TE_SEPARATE Unmarked_class_or_tuple_type
			{
				$$ := $4
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, True, False)
				end
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($2), True, False)
				end
				if attached $$ as l_type then
					l_type.set_separate_mark ($3)
				end
			}
	| TE_VARIANT TE_DETACHABLE Unmarked_class_or_tuple_type
			{
				$$ := $3
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, False, True)
				end
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($2), False, True)
				end
			}
	| TE_VARIANT TE_ATTACHED Unmarked_class_or_tuple_type
			{
				$$ := $3
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, False, True)
				end
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($2), True, False)
				end
			}
	| TE_VARIANT TE_SEPARATE Unmarked_class_or_tuple_type
			{
				$$ := $3
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, False, True)
				end
				if attached $$ as l_type then
					l_type.set_separate_mark ($2)
				end
			}
	| TE_VARIANT TE_DETACHABLE TE_SEPARATE Unmarked_class_or_tuple_type
			{
				$$ := $4
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, False, True)
				end
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($2), False, True)
				end
				if attached $$ as l_type then
					l_type.set_separate_mark ($3)
				end
			}
	| TE_VARIANT TE_ATTACHED TE_SEPARATE Unmarked_class_or_tuple_type
			{
				$$ := $4
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, False, True)
				end
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($2), True, False)
				end
				if attached $$ as l_type then
					l_type.set_separate_mark ($3)
				end
			}
	;

Unmarked_class_or_tuple_type: Unmarked_class_type
			{ $$ := $1 }
	| Unmarked_tuple_type
			{ $$ := $1 }
	;

Unmarked_class_type: Class_identifier Generics_opt
			{ $$ := new_class_type ($1, $2) }
	;

-- This is also used in 'Constraint_type' to report a more meaningful error.
Anchored_type:	Unmarked_anchored_type
			{ $$ := $1 }
	|	TE_ATTACHED Unmarked_anchored_type
			{
				$$ := $2
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($1), True, False)
				end
			}
	|	TE_DETACHABLE Unmarked_anchored_type
			{
				$$ := $2
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($1), False, True)
				end
			}
	|	TE_FROZEN Unmarked_anchored_type
			{
				$$ := $2
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, True, False)
				end
			}
	|	TE_VARIANT Unmarked_anchored_type
			{
				$$ := $2
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, False, True)
				end
			}
	|	TE_SEPARATE Unmarked_anchored_type
			{
				$$ := $2
				if attached $$ as l_type then
					l_type.set_separate_mark ($1)
				end
			}
	|	TE_ATTACHED TE_SEPARATE Unmarked_anchored_type
			{
				$$ := $3
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($1), True, False)
				end
				if attached $$ as l_type then
					l_type.set_separate_mark ($2)
				end
			}
	|	TE_DETACHABLE TE_SEPARATE Unmarked_anchored_type
			{
				$$ := $3
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($1), False, True)
				end
				if attached $$ as l_type then
					l_type.set_separate_mark ($2)
				end
			}
	|	TE_FROZEN TE_ATTACHED Unmarked_anchored_type
			{
				$$ := $3
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, True, False)
				end
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($2), True, False)
				end
			}
	|	TE_FROZEN TE_DETACHABLE Unmarked_anchored_type
			{
				$$ := $3
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, True, False)
				end
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($2), False, True)
				end
			}
	|	TE_FROZEN TE_SEPARATE Unmarked_anchored_type
			{
				$$ := $3
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, True, False)
				end
				if attached $$ as l_type then
					l_type.set_separate_mark ($2)
				end
			}
	|	TE_FROZEN TE_ATTACHED TE_SEPARATE Unmarked_anchored_type
			{
				$$ := $4
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, True, False)
				end
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($2), True, False)
				end
				if attached $$ as l_type then
					l_type.set_separate_mark ($3)
				end
			}
	|	TE_FROZEN TE_DETACHABLE TE_SEPARATE Unmarked_anchored_type
			{
				$$ := $4
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, True, False)
				end
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($2), False, True)
				end
				if attached $$ as l_type then
					l_type.set_separate_mark ($3)
				end
			}
	|	TE_VARIANT TE_ATTACHED Unmarked_anchored_type
			{
				$$ := $3
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, False, True)
				end
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($2), True, False)
				end
			}
	|	TE_VARIANT TE_DETACHABLE Unmarked_anchored_type
			{
				$$ := $3
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, False, True)
				end
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($2), False, True)
				end
			}
	|	TE_VARIANT TE_SEPARATE Unmarked_anchored_type
			{
				$$ := $3
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, False, True)
				end
				if attached $$ as l_type then
					l_type.set_separate_mark ($2)
				end
			}
	|	TE_VARIANT TE_ATTACHED TE_SEPARATE Unmarked_anchored_type
			{
				$$ := $4
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, False, True)
				end
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($2), True, False)
				end
				if attached $$ as l_type then
					l_type.set_separate_mark ($3)
				end
			}
	|	TE_VARIANT TE_DETACHABLE TE_SEPARATE Unmarked_anchored_type
			{
				$$ := $4
				if not is_ignoring_variance_mark and then attached $$ as l_type then
					l_type.set_variance_mark ($1, False, True)
				end
				if not is_ignoring_attachment_marks and then attached $$ as l_type then
					l_type.set_attachment_mark (extract_keyword ($2), False, True)
				end
				if attached $$ as l_type then
					l_type.set_separate_mark ($3)
				end
			}
	;

Unmarked_anchored_type:
		Unmarked_unqualified_anchored_type
			{ $$ := $1 }
	|	Unmarked_qualified_anchored_type
			{ $$ := $1 }
	;


Unmarked_unqualified_anchored_type:
		TE_LIKE Identifier_as_lower
			{ $$ := ast_factory.new_like_id_as ($2, $1) }
	|	TE_LIKE TE_CURRENT
			{ $$ := ast_factory.new_like_current_as ($2, $1) }
	;

Unmarked_qualified_anchored_type:
		Unmarked_unqualified_anchored_type TE_DOT Identifier_as_lower
			{ $$ := ast_factory.new_qualified_anchored_type ($1, $2, $3) }
	|	TE_LIKE Typed TE_DOT Identifier_as_lower
			{ $$ := ast_factory.new_qualified_anchored_type_with_type ($1, $2, $3, $4) }
	|	Unmarked_qualified_anchored_type TE_DOT Identifier_as_lower
			{
				$$ := $1
				if attached $$ as q and attached $3 as l_id then
					q.extend ($2, l_id)
				end
			}
	;

-- 'Obsolete_type' represent types that we used to accept but will disallow in the future.
Obsolete_type: TE_EXPANDED Unmarked_class_type
			{
				$$ := $2
				ast_factory.set_expanded_class_type ($$, True, $1)
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
						once "Make an expanded version of the base class associated with this type."))
				end
			}
	;

Generics_opt: -- Empty
			-- { $$ := Void }
	|	Generics 
			{
				$$ := $1
			}
	;

Generics:	TE_LSQURE Type_list TE_RSQURE
			{
				if attached $2 as l_list then
					$$ := l_list
					l_list.set_positions ($1, $3)
				end
			}
	|	TE_LSQURE TE_RSQURE
			{
					-- Per ECMA, this should be rejected. For now we only raise
					-- a warning. And on the compiler side, we will simply ignore them altogether.
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
							once "Empty Type_list is not allowed and will be discarded."))
				end
				if attached ast_factory.new_eiffel_list_type (0) as l_list then
					$$ := l_list
					l_list.set_positions ($1, $2)
				end	
			}
	;

Type_list: Add_counter Type_list_impl Remove_counter
		{ $$ := $2 }
	;

Type_list_impl: Type
			{
				$$ := ast_factory.new_eiffel_list_type (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Type TE_COMMA Increment_counter Type_list_impl
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	;

Unmarked_tuple_type: Tuple_identifier
			{ $$ := ast_factory.new_class_type_as ($1, Void) }
	|	Tuple_identifier Add_counter Add_counter2 TE_LSQURE TE_RSQURE
			{
					-- Per ECMA, this should be rejected. For now we only raise
					-- a warning. And on the compiler side, we will simply ignore them altogether.
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($4), token_column ($4), filename,
							once "Empty Type_list is not allowed and will be discarded."))
				end
				if attached ast_factory.new_eiffel_list_type (0) as l_type_list then
					l_type_list.set_positions ($4, $5)
					$$ := ast_factory.new_class_type_as ($1, l_type_list)
				else
					$$ := ast_factory.new_class_type_as ($1, Void)
  				end
				remove_counter
				remove_counter2
			}
	|	Tuple_identifier Add_counter Add_counter2 TE_LSQURE Actual_parameter_list
			{
				if attached $5 as l_list then
					l_list.set_positions ($4, last_rsqure.item)
				end
				$$ := ast_factory.new_class_type_as ($1, $5)
				last_rsqure.remove
				remove_counter
				remove_counter2
			}
	|	Tuple_identifier Add_counter Add_counter2 TE_LSQURE Named_parameter_list
			{
				$$ := ast_factory.new_named_tuple_type_as (
					$1, ast_factory.new_formal_argu_dec_list_as ($5, $4, last_rsqure.item))
				last_rsqure.remove
				remove_counter
				remove_counter2
			}
	;

Actual_parameter_list:	Type TE_RSQURE				
			{
				$$ := ast_factory.new_eiffel_list_type (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
				last_rsqure.force ($2)
			}
	|	TE_ID TE_COMMA Increment_counter Actual_parameter_list		
			{
				$$ := $4
				if
					attached $$ as l_list and then attached $1 as l_val and then
					attached new_class_type (l_val, Void) as l_class_type
				then
					l_val.to_upper		
					l_list.reverse_extend (l_class_type)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	|	Type TE_COMMA Increment_counter Actual_Parameter_List
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	;
	
Named_parameter_list: TE_ID TE_COLON Type TE_RSQURE
			{
				$$ := ast_factory.new_eiffel_list_type_dec_as (counter2_value + 1)
				if
					attached $$ as l_named_list and then attached $1 as l_name and then
					attached ast_factory.new_identifier_list (counter_value + 1) as l_list and then
					attached ast_factory.new_type_dec_as (l_list, $3, $2) as l_type_dec_as
				then
					l_name.to_lower		
					l_list.reverse_extend (l_name.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_name)
					l_named_list.reverse_extend (l_type_dec_as)
				end
				last_rsqure.force ($4)
			}
	|	TE_ID TE_COMMA Increment_counter Named_parameter_list

			{
				$$ := $4
				if
					attached $$ as l_named_list and then not l_named_list.is_empty and then
					attached $1 as l_name and then
					attached l_named_list.reversed_first.id_list as l_list
				then
					l_name.to_lower		
					l_list.reverse_extend (l_name.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_name)
					ast_factory.reverse_extend_identifier_separator (l_list, $2)
				end
			}
	|	TE_ID TE_COLON Type ASemi Increment_counter2 Add_counter Named_parameter_list
			{
				remove_counter
				$$ := $7
				if
					attached $$ as l_named_list and then attached $1 as l_name and then $3 /= Void and then
					attached ast_factory.new_identifier_list (counter_value + 1) as l_list and then
					attached ast_factory.new_type_dec_as (l_list, $3, $2) as l_type_dec_as
				then
					l_name.to_lower		
					l_list.reverse_extend (l_name.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_name)
					l_named_list.reverse_extend (l_type_dec_as)
				end
			}
	;
			

-- Formal generics

Formal_generics:
			{
				-- $$ := Void
				set_formal_generics_end_positions (True)
			}
	|	TE_LSQURE TE_RSQURE
			{
					-- Per ECMA, this should be rejected. For now we only raise
					-- a warning. And on the compiler side, we will simply ignore them altogether.
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
							once "Empty Formal_generic_list is not allowed and will be discarded."))
				end
				set_formal_generics_end_positions (True)
				$$ := ast_factory.new_eiffel_list_formal_dec_as (0)
				if attached $$ as l_formals then
					l_formals.set_squre_symbols ($1, $2)
				end
				if
					is_once and then
					attached (create {SYNTAX_ERROR}.make (token_line ($1), token_column ($1), filename,
						locale.translation_in_context ("A once class may not have formal generic parameters.", "compiler.parser"))) as e
				then
					e.set_associated_class (current_class)
					error_handler.insert_error (e)
				end
			}
	|	TE_LSQURE Add_counter Disable_supplier_recording Formal_generic_list Enable_supplier_recording Remove_counter TE_RSQURE
			{
				set_formal_generics_end_positions (False)
				$$ := $4
				if attached $$ as l_formals then
					l_formals.transform_class_types_to_formals_and_record_suppliers (ast_factory, suppliers, formal_parameters)
					l_formals.set_squre_symbols ($1, $7)
				end
				if
					is_once and then
					attached (create {SYNTAX_ERROR}.make (token_line ($1), token_column ($1), filename,
						locale.translation_in_context ("A once class may not have formal generic parameters.", "compiler.parser"))) as e
				then
					e.set_associated_class (current_class)
					error_handler.insert_error (e)
				end
			}
	;

Formal_generic_list: Formal_generic
			{
				$$ := ast_factory.new_eiffel_list_formal_dec_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Formal_generic TE_COMMA Increment_counter Formal_generic_list
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	;

Formal_parameter: TE_REFERENCE Class_identifier
			{
				if attached $2 as l_id and then {PREDEFINED_NAMES}.none_class_name_id = l_id.name_id then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$2' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					$$ := ast_factory.new_formal_as ($2, True, False, False, $1)
				end
			}
	| TE_EXPANDED Class_identifier
			{
				if attached $2 as l_id and then {PREDEFINED_NAMES}.none_class_name_id = l_id.name_id then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$2' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					$$ := ast_factory.new_formal_as ($2, False, True, False, $1)
				end
			}

	| TE_FROZEN Class_identifier
			{
				if attached $2 as l_id and then {PREDEFINED_NAMES}.none_class_name_id = l_id.name_id then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$1' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					$$ := ast_factory.new_formal_as ($2, False, False, True, $1)
				end
			}

	|	Class_identifier
			{
				if attached $1 as l_id and then {PREDEFINED_NAMES}.none_class_name_id = l_id.name_id then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$1' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					$$ := ast_factory.new_formal_as ($1, False, False, False, Void)
				end
			}
	;

Formal_generic:
		Formal_parameter
			{
				if attached $1 as l_formal then
						-- Needs to be done here, in case current formal is used in
						-- Constraint.
					formal_parameters.extend (l_formal)
					l_formal.set_position (formal_parameters.count)
				end
			}
			Constraint
			{
				if attached $3 as l_constraint then
					if attached l_constraint.creation_constrain as l_creation_constraint then
						$$ := ast_factory.new_formal_dec_as ($1, l_constraint.type, l_creation_constraint.feature_list, l_constraint.constrain_symbol, l_creation_constraint.create_keyword, l_creation_constraint.end_keyword)
					else
						$$ := ast_factory.new_formal_dec_as ($1, l_constraint.type, Void, l_constraint.constrain_symbol, Void, Void)
					end					
				else
					$$ := ast_factory.new_formal_dec_as ($1, Void, Void, Void, Void, Void)
				end
			}
	;

Constraint: -- Empty
			-- { $$ := Void }
	|	TE_CONSTRAIN Single_constraint Creation_constraint
			{
					-- We do not want Void items in this list.
				if
					attached $2 as l_val and then
					attached ast_factory.new_eiffel_list_constraining_type_as (1) as l_list
				then
					l_list.reverse_extend (l_val)
					$$ := ast_factory.new_constraint_triple ($1, l_list, $3)
				else
					$$ := ast_factory.new_constraint_triple ($1, Void, $3)
				end

			}
	|	TE_CONSTRAIN TE_LCURLY Add_counter Multiple_constraint_list Remove_counter TE_RCURLY Creation_constraint
			{
				$$ := ast_factory.new_constraint_triple ($1, $4, $7)
			}
	;

Single_constraint:
	Constraint_type {is_constraint_renaming := True} Rename {is_constraint_renaming := False} TE_END
			{
				$$ := ast_factory.new_constraining_type ($1, $3, $5)
			}
	| Constraint_type
			{
				$$ := ast_factory.new_constraining_type ($1, Void, Void)
			}
	;

Constraint_type:
		Class_or_tuple_type
			{
				$$ := $1
				if attached $1 as l_type and then l_type.has_anchor then
					report_one_error (ast_factory.new_vtgc1_error (token_line (l_type), token_column (l_type), filename, l_type))
				end
			}
	|	Anchored_type
			{
				if attached $1 as l_type then
					report_one_error (ast_factory.new_vtgc1_error (token_line (l_type), token_column (l_type), filename, l_type))
				end
			}
	;

Multiple_constraint_list:	Single_constraint
			{
					-- Special list treatment here as we do not want Void
					-- element in `Assertion_list'.
				if attached $1 as l_val then
					$$ := ast_factory.new_eiffel_list_constraining_type_as (counter_value + 1)
					if attached $$ as l_list then
						l_list.reverse_extend (l_val)
					end
				else
					$$ := ast_factory.new_eiffel_list_constraining_type_as (counter_value)
				end
			}
	|	Single_constraint TE_COMMA
			{
					-- Only increment counter when clause is not Void.
				if $1 /= Void then
					increment_counter
				end
			}
		Multiple_constraint_list
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	;

Creation_constraint: -- Empty
			-- { $$ := Void }
	|	TE_CREATE Creation_list TE_END
			{
				$$ := ast_factory.new_creation_constrain_triple ($2, $1, $3)
			}
	;


-- Instructions

Conditional:
		TE_IF Expression TE_THEN Compound TE_END
			{ $$ := ast_factory.new_if_as ($2, $4, Void, Void, $5, $1, $3, Void) }
	|	TE_IF Expression TE_THEN Compound TE_ELSE Compound TE_END
			{ $$ := ast_factory.new_if_as ($2, $4, Void, $6, $7, $1, $3, $5) }
	|	TE_IF Expression TE_THEN Compound Elseif_list TE_END
			{ $$ := ast_factory.new_if_as ($2, $4, $5, Void, $6, $1, $3, Void) }
	|	TE_IF Expression TE_THEN Compound Elseif_list TE_ELSE Compound TE_END
			{ $$ := ast_factory.new_if_as ($2, $4, $5, $7, $8, $1, $3, $6) }
	;

Elseif_list: Add_counter Elseif_part_list Remove_counter
		{ $$ := $2 }
	;

Elseif_part_list: Elseif_part
			{
				$$ := ast_factory.new_eiffel_list_elseif_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Elseif_part Increment_counter Elseif_part_list
			{
				$$ := $3
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	;

Elseif_part: TE_ELSEIF Expression TE_THEN Compound
			{ $$ := ast_factory.new_elseif_as ($2, $4, $1, $3) }
	;

Multi_branch: TE_INSPECT Expression When_part_list_opt TE_END
			{ $$ := ast_factory.new_inspect_as ($2, $3, Void, $4, $1, Void) }
	|	TE_INSPECT Expression When_part_list_opt TE_ELSE Compound TE_END
			{
				if $5 /= Void then
					$$ := ast_factory.new_inspect_as ($2, $3, $5, $6, $1, $4)
				else
					$$ := ast_factory.new_inspect_as ($2, $3,
						ast_factory.new_eiffel_list_instruction_as (0), $6, $1, $4)
				end
			}
	;

When_part_list_opt: -- Empty
			-- { $$ := Void }
	|	Add_counter When_part_list Remove_counter
			{ $$ := $2 }
	;

When_part_list: When_part
			{
				$$ := ast_factory.new_eiffel_list_case_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	When_part Increment_counter When_part_list
			{
				$$ := $3
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	;

When_part: TE_WHEN Add_counter Choices Remove_counter TE_THEN Compound
			{ $$ := ast_factory.new_case_as ($3, $6, $1, $5) }
	;

Choices: Choice
			{
				$$ := ast_factory.new_eiffel_list_interval_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Choice TE_COMMA Increment_counter Choices
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	;

Choice: Integer_constant
			{ $$ := ast_factory.new_interval_as ($1, Void, Void) }
	|	Integer_constant TE_DOTDOT Integer_constant
			{ $$ := ast_factory.new_interval_as ($1, $3, $2) }
	|	Character_constant
			{ $$ := ast_factory.new_interval_as ($1, Void, Void) }
	|	Character_constant TE_DOTDOT Character_constant
			{ $$ := ast_factory.new_interval_as ($1, $3, $2) }
	|	Identifier_as_lower
			{ $$ := ast_factory.new_interval_as ($1, Void, Void) }
	|	Identifier_as_lower TE_DOTDOT Identifier_as_lower
			{ $$ := ast_factory.new_interval_as ($1, $3, $2) }
	|	Identifier_as_lower TE_DOTDOT Integer_constant
			{ $$ := ast_factory.new_interval_as ($1, $3, $2) }
	|	Integer_constant TE_DOTDOT Identifier_as_lower
			{ $$ := ast_factory.new_interval_as ($1, $3, $2) }
	|	Identifier_as_lower TE_DOTDOT Character_constant
			{ $$ := ast_factory.new_interval_as ($1, $3, $2) }
	|	Character_constant TE_DOTDOT Identifier_as_lower
			{ $$ := ast_factory.new_interval_as ($1, $3, $2) }
	|	A_static_call
			{ $$ := ast_factory.new_interval_as ($1, Void, Void) }
	|	A_static_call TE_DOTDOT Identifier_as_lower
			{ $$ := ast_factory.new_interval_as ($1, $3, $2) }
	|	Identifier_as_lower TE_DOTDOT A_static_call
			{ $$ := ast_factory.new_interval_as ($1, $3, $2) }
	|	A_static_call TE_DOTDOT A_static_call
			{ $$ := ast_factory.new_interval_as ($1, $3, $2) }
	|	A_static_call TE_DOTDOT Integer_constant
			{ $$ := ast_factory.new_interval_as ($1, $3, $2) }
	|	Integer_constant TE_DOTDOT A_static_call
			{ $$ := ast_factory.new_interval_as ($1, $3, $2) }
	|	A_static_call TE_DOTDOT Character_constant
			{ $$ := ast_factory.new_interval_as ($1, $3, $2) }
	|	Character_constant TE_DOTDOT A_static_call
			{ $$ := ast_factory.new_interval_as ($1, $3, $2) }

	;

Loop_instruction:
	TE_FROM Compound Invariant Variant TE_UNTIL Expression TE_LOOP Compound TE_END
			{
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($4), token_column ($4), filename,
						once "Loop variant should appear just before the end keyword of the loop."))
				end
				if attached $3 as l_invariant_pair then
					$$ := ast_factory.new_loop_as (Void, $2, l_invariant_pair.second, $4, $6, $8, $9, $1, l_invariant_pair.first, $5, $7, Void, Void)
				else
					$$ := ast_factory.new_loop_as (Void, $2, Void, $4, $6, $8, $9, $1, Void, $5, $7, Void, Void)
				end
			}
	| TE_FROM Compound Invariant TE_UNTIL Expression TE_LOOP Compound Variant_opt TE_END
			{
				if attached $3 as l_invariant_pair then
					$$ := ast_factory.new_loop_as (Void, $2, l_invariant_pair.second, $8, $5, $7, $9, $1, l_invariant_pair.first, $4, $6, Void, Void)
				else
					$$ := ast_factory.new_loop_as (Void, $2, Void, $8, $5, $7, $9, $1, Void, $4, $6, Void, Void)
				end
			}
	| Iteration TE_FROM Compound Invariant Exit_condition_opt TE_LOOP Compound Variant_opt TE_END
			{
				if attached $4 as l_invariant_pair then
					if attached $5 as l_until_pair then
						$$ := ast_factory.new_loop_as ($1, $3, l_invariant_pair.second, $8, l_until_pair.second, $7, $9, $2, l_invariant_pair.first, l_until_pair.first, $6, Void, Void)
					else
						$$ := ast_factory.new_loop_as ($1, $3, l_invariant_pair.second, $8, Void, $7, $9, $2, l_invariant_pair.first, Void, $6, Void, Void)
					end
				else
					if attached $5 as l_until_pair then
						$$ := ast_factory.new_loop_as ($1, $3, Void, $8, l_until_pair.second, $7, $9, $2, Void, l_until_pair.first, $6, Void, Void)
					else
						$$ := ast_factory.new_loop_as ($1, $3, Void, $8, Void, $7, $9, $2, Void, Void, $6, Void, Void)
					end
				end
				leave_scope
			}
	| Iteration Invariant Exit_condition_opt TE_LOOP Compound Variant_opt TE_END
			{
				if attached $2 as l_invariant_pair then
					if attached $3 as l_until_pair then
						$$ := ast_factory.new_loop_as ($1, Void, l_invariant_pair.second, $6, l_until_pair.second, $5, $7, Void, l_invariant_pair.first, l_until_pair.first, $4, Void, Void)
					else
						$$ := ast_factory.new_loop_as ($1, Void, l_invariant_pair.second, $6, Void, $5, $7, Void, l_invariant_pair.first, Void, $4, Void, Void)
					end
				else
					if attached $3 as l_until_pair then
						$$ := ast_factory.new_loop_as ($1, Void, Void, $6, l_until_pair.second, $5, $7, Void, Void, l_until_pair.first, $4, Void, Void)
					else
						$$ := ast_factory.new_loop_as ($1, Void, Void, $6, Void, $5, $7, Void, Void, Void, $4, Void, Void)
					end
				end
				leave_scope
			}
	| TE_REPEAT_OPEN Identifier_as_lower TE_COLON Expression TE_BAR {enter_scope; add_scope_iteration ($2)} Compound TE_REPEAT_CLOSE
			{
				$$ := ast_factory.new_loop_as (ast_factory.new_symbolic_iteration_as ($2, $3, $4, $5), Void, Void, Void, Void, $7, Void, Void, Void, Void, Void, extract_symbol ($1), extract_symbol ($8))
				leave_scope
			}
	;

Loop_expression:
	Iteration Invariant Exit_condition_opt TE_ALL Expression Variant_opt TE_END
			{
				if attached $2 as l_invariant_pair then
					if attached $3 as l_until_pair then
						$$ := ast_factory.new_loop_expr_as ($1, l_invariant_pair.first, l_invariant_pair.second, l_until_pair.first, l_until_pair.second, $4, Void, True, $5, $6, $7)
					else
						$$ := ast_factory.new_loop_expr_as ($1, l_invariant_pair.first, l_invariant_pair.second, Void, Void, $4, Void, True, $5, $6, $7)
					end
				else
					if attached $3 as l_until_pair then
						$$ := ast_factory.new_loop_expr_as ($1, Void, Void, l_until_pair.first, l_until_pair.second, $4, Void, True, $5, $6, $7)
					else
						$$ := ast_factory.new_loop_expr_as ($1, Void, Void, Void, Void, $4, Void, True, $5, $6, $7)
					end
				end
				leave_scope
			}
	| Iteration Invariant Exit_condition_opt TE_SOME Expression Variant_opt TE_END
			{
				if attached $2 as l_invariant_pair then
					if attached $3 as l_until_pair then
						$$ := ast_factory.new_loop_expr_as ($1, l_invariant_pair.first, l_invariant_pair.second, l_until_pair.first, l_until_pair.second, extract_keyword ($4), Void, False, $5, $6, $7)
					else
						$$ := ast_factory.new_loop_expr_as ($1, l_invariant_pair.first, l_invariant_pair.second, Void, Void, extract_keyword ($4), Void, False, $5, $6, $7)
					end
				else
					if attached $3 as l_until_pair then
						$$ := ast_factory.new_loop_expr_as ($1, Void, Void, l_until_pair.first, l_until_pair.second, extract_keyword ($4), Void, False, $5, $6, $7)
					else
						$$ := ast_factory.new_loop_expr_as ($1, Void, Void, Void, Void, extract_keyword ($4), Void, False, $5, $6, $7)
					end
				end
				leave_scope
			}
	| TE_FORALL Identifier_as_lower TE_COLON Expression TE_BAR {enter_scope; add_scope_iteration ($2)} Expression
			{
				insert_supplier ("ITERABLE", $2)
				insert_supplier ("ITERATION_CURSOR", $2)
				$$ := ast_factory.new_loop_expr_as
					(ast_factory.new_symbolic_iteration_as ($2, $3, $4, $5), Void, Void, Void, Void, Void, extract_symbol ($1), True, $7, Void, Void)
				leave_scope
			}
	| TE_EXISTS Identifier_as_lower TE_COLON Expression TE_BAR {enter_scope; add_scope_iteration ($2)} Expression
			{
				insert_supplier ("ITERABLE", $2)
				insert_supplier ("ITERATION_CURSOR", $2)
				$$ := ast_factory.new_loop_expr_as
					(ast_factory.new_symbolic_iteration_as ($2, $3, $4, $5), Void, Void, Void, Void, Void, extract_symbol ($1), False, $7, Void, Void)
				leave_scope
			}
	;                                

Iteration:
	TE_ACROSS Expression TE_AS Identifier_as_lower
			{
				insert_supplier ("ITERABLE", $4)
				insert_supplier ("ITERATION_CURSOR", $4)
				$$ := ast_factory.new_iteration_as (extract_keyword ($1), $2, $3, $4, False)
				enter_scope
				add_scope_iteration ($4)
			}
	| TE_ACROSS Expression TE_IS Identifier_as_lower
			{
				insert_supplier ("ITERABLE", $4)
				insert_supplier ("ITERATION_CURSOR", $4)
				$$ := ast_factory.new_iteration_as (extract_keyword ($1), $2, extract_keyword ($3), $4, True)
				enter_scope
				add_scope_iteration ($4)
			}
	;

Invariant: -- Empty
			-- { $$ := Void }
	|	TE_INVARIANT Assertion
			{ $$ := ast_factory.new_invariant_pair ($1, $2) }
	;

Class_invariant: -- Empty
			-- { $$ := Void }
	|	TE_INVARIANT
			{ set_id_level (Invariant_level) }
		Assertion
			{
				set_id_level (Normal_level)
				$$ := ast_factory.new_invariant_as ($3, once_manifest_string_counter_value, $1, object_test_locals)
				reset_feature_frame
				object_test_locals := Void
			}
	;

Exit_condition_opt: -- Empty
			-- { $$ := Void }
	| TE_UNTIL Expression
			{ $$ := ast_factory.new_exit_condition_pair ($1, $2) }
	;

Variant_opt: -- Empty
			-- { $$ := Void }
	| Variant
			{ $$ := $1 }
	;

Variant:
		TE_VARIANT Identifier_as_lower TE_COLON Expression
			{ $$ := ast_factory.new_variant_as ($2, $4, $1, $3) }
	|	TE_VARIANT Expression
			{ $$ := ast_factory.new_variant_as (Void, $2, $1, Void) }
	;

Debug: TE_DEBUG Key_list Compound TE_END
			{ $$ := ast_factory.new_debug_as ($2, $3, $1, $4) }
	;

Key_list: -- Empty
			-- { $$ := Void }
	|	TE_LPARAN TE_RPARAN
			{
					-- Per ECMA, this should be rejected. For now we only raise
					-- a warning. And on the compiler side, we will simply ignore them altogether.
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
						once "Empty key list is not allowed"))
				end
				$$ := ast_factory.new_key_list_as (Void, $1, $2)
			}
	|	TE_LPARAN Add_counter String_list Remove_counter TE_RPARAN
			{ $$ := ast_factory.new_key_list_as ($3, $1, $5) }
	;

String_list: Non_empty_string
			{
				$$ := ast_factory.new_eiffel_list_string_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Non_empty_string TE_COMMA Increment_counter String_list
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	;

Rescue: -- Empty
			-- { $$ := Void }
	|	TE_RESCUE Compound
			{
				if $2 = Void then
					$$ := ast_factory.new_keyword_instruction_list_pair ($1, ast_factory.new_eiffel_list_instruction_as (0))
				else
					$$ := ast_factory.new_keyword_instruction_list_pair ($1, $2)
				end
			}
	;

Assignment: Identifier_as_lower TE_ASSIGNMENT Expression
			{ $$ := ast_factory.new_assign_as (ast_factory.new_access_id_as ($1, Void), $3, $2) }
	|	TE_RESULT TE_ASSIGNMENT Expression
			{ $$ := ast_factory.new_assign_as ($1, $3, $2) }
	;

Reverse_assignment: Identifier_as_lower TE_ACCEPT Expression
			{ $$ := ast_factory.new_reverse_as (ast_factory.new_access_id_as ($1, Void), $3, $2) }
	|	TE_RESULT TE_ACCEPT Expression
			{ $$ := ast_factory.new_reverse_as ($1, $3, $2) }
	;

Creators: -- Empty
			-- { $$ := Void }
	|	Add_counter Creation_clause_list Remove_counter
			{ $$ := $2 }
	;

Creation_clause_list: Creation_clause
			{
				$$ := ast_factory.new_eiffel_list_create_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Creation_clause Increment_counter Creation_clause_list
			{
				$$ := $3
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	;

Creation_clause:
		TE_CREATE
			{
				$$ := ast_factory.new_create_as (Void, Void, $1)
			}
	|	TE_CREATE Clients Feature_list
			{
				$$ := ast_factory.new_create_as ($2, $3, $1)
			}
	|	TE_CREATE Client_list
			{
				$$ := ast_factory.new_create_as (ast_factory.new_client_as ($2), Void, $1)
			}
	|	TE_CREATION
			{
				$$ := ast_factory.new_create_as (Void, Void, $1)
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
						once "Use keyword `create' instead."))
				end
			}
	|	TE_CREATION Clients Feature_list
			{
				$$ := ast_factory.new_create_as ($2, $3, $1)
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
						once "Use keyword `create' instead."))
				end
			}
	|	TE_CREATION Client_list
			{
				$$ := ast_factory.new_create_as (ast_factory.new_client_as ($2), Void, $1)
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
						once "Use keyword `create' instead."))
				end
			}
	;

Agent:
		TE_AGENT Optional_formal_arguments {add_feature_frame} Routine {remove_feature_frame} Delayed_actuals
		{
			inspect id_level when Precondition_level, Postcondition_level then
				set_has_unqualified_call_in_assertion (True)
			else
				-- Nothing to do.
			end
			$$ := ast_factory.new_inline_agent_creation_as (
				ast_factory.new_body_as ($2, Void, Void, $4, Void, Void, Void, Void), $6, $1)
		}
	|	TE_AGENT Optional_formal_arguments TE_COLON Type {add_feature_frame} Routine {remove_feature_frame} Delayed_actuals
		{
			inspect id_level when Precondition_level, Postcondition_level then
				set_has_unqualified_call_in_assertion (True)
			else
				-- Nothing to do.
			end
			$$ := ast_factory.new_inline_agent_creation_as (
				ast_factory.new_body_as ($2, $4, Void, $6, $3, Void, Void, Void), $8, $1)
		}
	|	TE_AGENT Identifier_as_lower Delayed_actuals
		{
			inspect id_level when Precondition_level, Postcondition_level then
				set_has_unqualified_call_in_assertion (True)
			else
				-- Nothing to do.
			end
			$$ := ast_factory.new_agent_routine_creation_as (
				Void, $2, $3, False, $1, Void)
		}
	|	TE_AGENT Agent_target TE_DOT Identifier_as_lower Delayed_actuals
		{
			if attached $2 as l_target then
				$$ := ast_factory.new_agent_routine_creation_as (l_target.operand, $4, $5, True, $1, $3)
				if attached $$ as l_agent then
					l_agent.set_lparan_symbol (l_target.lparan_symbol)
					l_agent.set_rparan_symbol (l_target.rparan_symbol)
				end
			else
				$$ := ast_factory.new_agent_routine_creation_as (Void, $4, $5, True, $1, $3)
			end
		}
	;
	
Optional_formal_arguments: -- Empty
		-- { $$ := Void }
	|	Formal_arguments
		{
			$$ := $1
		}
	;
	
Agent_target: Identifier_as_lower
		{
			inspect id_level when Precondition_level, Postcondition_level then
				set_has_unqualified_call_in_assertion (True)
			else
				-- Nothing to do.
			end
			$$ := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, ast_factory.new_expr_call_as (ast_factory.new_access_id_as ($1, Void))))
		}
	|	TE_LPARAN Add_counter Add_counter Expression Remove_counter Remove_counter TE_RPARAN
		{ $$ := ast_factory.new_agent_target_triple ($1, $7, ast_factory.new_operand_as (Void, $4)) }	
	|	TE_RESULT
		{ $$ := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, $1)) }
	|	TE_CURRENT
		{
			inspect id_level when Precondition_level, Postcondition_level then
				set_has_unqualified_call_in_assertion (True)
			else
				-- Nothing to do.
			end
			$$ := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, $1))
		}
	|	Typed
		{ $$ := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as ($1, Void))}
	|	TE_QUESTION
		{
			if attached ast_factory.new_operand_as (Void, Void) as l_temp_operand_as then
				l_temp_operand_as.set_question_mark_symbol ($1)
				$$ := ast_factory.new_agent_target_triple (Void, Void, l_temp_operand_as)
			else
				$$ := ast_factory.new_agent_target_triple (Void, Void, Void)
			end
		}
	;

Delayed_actuals: -- Empty
			-- { $$ := Void }
	|	TE_LPARAN TE_RPARAN
			{
					-- Per ECMA, this should be rejected. For now we only raise
					-- a warning. And on the compiler side, we will simply ignore them altogether.
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
						once "Empty agent actual list is not allowed"))
				end
				$$ := ast_factory.new_delayed_actual_list_as (Void, $1, $2)
			}
	|	TE_LPARAN Add_counter Delayed_actual_list Remove_counter TE_RPARAN
			{ $$ := ast_factory.new_delayed_actual_list_as ($3, $1, $5) }
	;

Delayed_actual_list: Delayed_actual
			{
				$$ := ast_factory.new_eiffel_list_operand_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Delayed_actual TE_COMMA Increment_counter Delayed_actual_list
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	;

Delayed_actual: TE_QUESTION
			{ $$ := ast_factory.new_operand_as (Void, Void)
				if attached $$ as l_actual then
					l_actual.set_question_mark_symbol ($1)
				end
			}
-- Manu: 01/19/2005: Due to syntax ambiguity we cannot have 'Typed' only
-- as there will be no way to distinguish it from a Manifest type expression.
-- To preserve this feature in case it is needed by some of our customers
-- we have invented the new syntax Typed ?.
	|	Typed TE_QUESTION
			{ $$ := ast_factory.new_operand_as ($1, Void)
				if attached $$ as l_actual then
					l_actual.set_question_mark_symbol ($2)
				end
			}
	|	Expression
			{ $$ := ast_factory.new_operand_as (Void, $1) }
	;

Creation:	TE_CREATE Creation_region Creation_target Creation_call
			{ $$ := ast_factory.new_creation_as ($2, Void, $3, $4, $1) }
	|	TE_CREATE Creation_region Typed Creation_target Creation_call
			{ $$ := ast_factory.new_creation_as ($2, $3, $4, $5, $1) }
	;

Creation_expression: TE_CREATE Creation_region Typed Creation_call
			{ $$ := ast_factory.new_creation_expr_as ($2, $3, $4, $1) }
	;

Creation_region: -- Empty
			{ $$ := True }
	|	TE_LT Class_identifier TE_GT
			{ 
				$$ := True
				if attached $2 as l_id then
					if {PREDEFINED_NAMES}.none_class_name_id = l_id.name_id then
						$$ := False
					else
						report_one_error (create {SYNTAX_ERROR}.make (token_line ($2), token_column ($2), filename, "Passive regions should use type specifier %"NONE%"."))
					end
				end
			}
	;

Creation_target: Identifier_as_lower
			{ $$ := ast_factory.new_access_id_as ($1, Void) }
	|	TE_RESULT
			{ $$ := $1 }
	;

Creation_call: -- Empty
			-- { $$ := Void }
	|	TE_DOT Identifier_as_lower Parameters
			{ $$ := ast_factory.new_access_inv_as ($2, $3, $1) }
	;


-- Instruction call

Call: A_feature
			{ $$ := $1 }
	|	A_precursor
			{ $$ := $1 }
	|	A_static_call
			{ $$ := $1 }
	|	Qualified_call
			{ $$ := $1 }
	;

-- Check instruction

Check: TE_CHECK Assertion TE_END
			{ $$ := ast_factory.new_check_as ($2, $1, $3) }
	;

Guard: TE_CHECK Assertion TE_THEN Compound TE_END
			{ $$ := ast_factory.new_guard_as ($1, $2, $3, $4, $5) }
	;

-- Separate instruction

Separate_instruction: TE_SEPARATE {enter_scope} Add_counter Separate_argument_list Remove_counter TE_DO Compound TE_END
			{
				$$ := ast_factory.new_separate_instruction_as ($1, $4, $6, $7, $8)
				leave_scope
			}
	;

Separate_argument: Expression TE_AS Identifier_as_lower
			{
				$$ := ast_factory.new_named_expression_as ($1, $2, $3)
				add_scope_separate ($3)
			}
	;

Separate_argument_list: Separate_argument
			{
				$$ := ast_factory.new_eiffel_list_named_expression_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Separate_argument TE_COMMA Increment_counter Separate_argument_list
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	;

-- Expression

Typed: TE_LCURLY Type TE_RCURLY
			{ $$ := $2
				if attached $$ as l_type then
					l_type.set_lcurly_symbol ($1)
					l_type.set_rcurly_symbol ($3)
				end
			}
	;

Expression:
		Nosigned_integer
			{ $$ := $1 }
	|	Nosigned_real
			{ $$ := $1 }
	|	Factor
			{ $$ := $1 }
	|	Expression TE_TILDE Expression
			{ $$ := ast_factory.new_bin_tilde_as ($1, $3, $2) }
	|	Expression TE_NOT_TILDE Expression
			{ $$ := ast_factory.new_bin_not_tilde_as ($1, $3, $2) }
	|	Expression TE_EQ Expression
			{ $$ := ast_factory.new_bin_eq_as ($1, $3, $2) }
	|	Expression TE_NE Expression
			{ $$ := ast_factory.new_bin_ne_as ($1, $3, $2) }
	|	Qualified_binary_expression
			{ $$ := $1 }
		-- The following rules adds many shift reduce/conflicts (309 vs 151 without them).
	|	TE_ATTACHED Expression %prec TE_NOT
			{
				check_object_test_expression ($2)
				$$ := ast_factory.new_object_test_as (extract_keyword ($1), Void, $2, Void, Void)
			}
	|	TE_ATTACHED Expression TE_AS Identifier_as_lower
			{
				check_object_test_expression ($2)
				$$ := ast_factory.new_object_test_as (extract_keyword ($1), Void, $2, $3, $4)
				add_scope_test ($4)
			}
	|	TE_ATTACHED TE_LCURLY Type TE_RCURLY Expression %prec TE_NOT
			{
				if attached $3 as l_type then
					l_type.set_lcurly_symbol ($2)
					l_type.set_rcurly_symbol ($4)
				end
				$$ := ast_factory.new_object_test_as (extract_keyword ($1), $3, $5, Void, Void)
			}
	|	TE_ATTACHED TE_LCURLY Type TE_RCURLY Expression TE_AS Identifier_as_lower
			{
				if attached $3 as l_type then
					l_type.set_lcurly_symbol ($2)
					l_type.set_rcurly_symbol ($4)
				end
				$$ := ast_factory.new_object_test_as (extract_keyword ($1), $3, $5, $6, $7)
				if attached $7 as l_name and attached $3 as l_type then
					insert_object_test_locals ([l_name, l_type])
				end
				add_scope_test ($7)
			}
	|	TE_LCURLY Identifier_as_lower TE_COLON Type TE_RCURLY Expression %prec TE_NOT
			{
				$$ := ast_factory.new_old_syntax_object_test_as ($1, $2, $4, $6)
				if attached $2 as l_name and attached $4 as l_type then
					insert_object_test_locals ([l_name, l_type])
				end
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1),
							filename, once "Use the new syntax for object test `attached {T} exp as x'."))

				end
			}
	;

Qualified_binary_expression:
		Expression TE_PLUS Expression
			{ $$ := ast_factory.new_bin_plus_as ($1, $3, $2) }
	|	Expression TE_MINUS Expression
			{ $$ := ast_factory.new_bin_minus_as ($1, $3, $2) }
	|	Expression TE_STAR Expression
			{ $$ := ast_factory.new_bin_star_as ($1, $3, $2) }
	|	Expression TE_SLASH Expression
			{ $$ := ast_factory.new_bin_slash_as ($1, $3, $2) }
	|	Expression TE_MOD Expression
			{ $$ := ast_factory.new_bin_mod_as ($1, $3, $2) }
	|	Expression TE_DIV Expression
			{ $$ := ast_factory.new_bin_div_as ($1, $3, $2) }
	|	Expression TE_POWER Expression
			{ $$ := ast_factory.new_bin_power_as ($1, $3, $2) }
	|	Expression TE_AND Expression
			{ $$ := ast_factory.new_bin_and_as ($1, $3, $2) }
	|	Expression TE_FREE_AND Expression
			{ $$ := ast_factory.new_bin_free_as ($1, $2, $3) }
	|	Expression TE_AND TE_THEN Expression %prec TE_AND
			{ $$ := ast_factory.new_bin_and_then_as ($1, $4, $2, $3) }
	|	Expression TE_FREE_AND_THEN Expression
			{ $$ := ast_factory.new_bin_free_as ($1, $2, $3) }
	|	Expression TE_OR Expression
			{ $$ := ast_factory.new_bin_or_as ($1, $3, $2) }
	|	Expression TE_FREE_OR Expression
			{ $$ := ast_factory.new_bin_free_as ($1, $2, $3) }
	|	Expression TE_OR TE_ELSE Expression %prec TE_OR
			{ $$ := ast_factory.new_bin_or_else_as ($1, $4,$2, $3) }
	|	Expression TE_FREE_OR_ELSE Expression
			{ $$ := ast_factory.new_bin_free_as ($1, $2, $3) }
	|	Expression TE_IMPLIES Expression
			{ $$ := ast_factory.new_bin_implies_as ($1, $3, $2) }
	|	Expression TE_FREE_IMPLIES Expression
			{ $$ := ast_factory.new_bin_free_as ($1, $2, $3) }
	|	Expression TE_XOR Expression
			{ $$ := ast_factory.new_bin_xor_as ($1, $3, $2) }
	|	Expression TE_FREE_XOR Expression
			{ $$ := ast_factory.new_bin_free_as ($1, $2, $3) }
	|	Expression TE_GE Expression
			{ $$ := ast_factory.new_bin_ge_as ($1, $3, $2) }
	|	Expression TE_GT Expression
			{ $$ := ast_factory.new_bin_gt_as ($1, $3, $2) }
	|	Expression TE_LE Expression
			{ $$ := ast_factory.new_bin_le_as ($1, $3, $2) }
	|	Expression TE_LT Expression
			{ $$ := ast_factory.new_bin_lt_as ($1, $3, $2) }
	|	Expression Free_operator Expression %prec TE_FREE
			{ $$ := ast_factory.new_bin_free_as ($1, $2, $3) }
	;

Factor: TE_VOID
			{ $$ := $1 }
	|	Manifest_array
			{ $$ := $1 }
	|	Agent
			{ $$ := $1 }
	|	TE_OLD Expression
			{ $$ := ast_factory.new_un_old_as ($2, $1) }
	|	TE_STRIP TE_LPARAN Strip_identifier_list TE_RPARAN
			{ $$ := ast_factory.new_un_strip_as ($3, $1, $2, $4) }
	|	TE_ADDRESS Feature_name
			{
				inspect id_level when Precondition_level, Postcondition_level then
					set_has_unqualified_call_in_assertion (True)
				else
					-- Nothing to do.
				end
				$$ := ast_factory.new_address_as ($2, $1)
			}
	|	TE_ADDRESS TE_CURRENT
			{
				inspect id_level when Precondition_level, Postcondition_level then
					set_has_unqualified_call_in_assertion (True)
				else
					-- Nothing to do.
				end
				$$ := ast_factory.new_address_current_as ($2, $1)
			}
	|	TE_ADDRESS TE_RESULT
			{ $$ := ast_factory.new_address_result_as ($2, $1) }
	|	Bracket_target
			{ $$ := $1 }
	|	Call
			{ $$ := ast_factory.new_expr_call_as ($1) }
	|	Qualified_factor
			{ $$ := $1 }
	|	Conditional_expression
			{ $$ := $1 }
	|	Multi_branch_expression
			{ $$ := $1 }
	;

Qualified_factor:
		Bracket_expression 
			{ $$ := $1 }
	|	Call_bracket_expression 
			{ $$ := $1 }
	|	TE_MINUS Factor
			{ $$ := ast_factory.new_un_minus_as ($2, $1) }
	|	TE_PLUS Factor
			{ $$ := ast_factory.new_un_plus_as ($2, $1) }
	|	TE_NOT Expression
			{ $$ := ast_factory.new_un_not_as ($2, $1) }
	|	TE_FREE_NOT Expression
			{ $$ := ast_factory.new_un_free_as ($1, $2) }
	|	Free_operator Expression %prec TE_NOT
			{ $$ := ast_factory.new_un_free_as ($1, $2) }
	;

Typed_expression:	Typed			
			{ $$ := ast_factory.new_type_expr_as ($1) }
	|	Typed_nosigned_integer
			{ $$ := $1 }
	|	Typed_nosigned_real
			{ $$ := $1 }
	;

Free_operator: TE_FREE
			{
				if attached $1 as l_free then
					l_free.to_lower
				end
				$$ := $1
			}
	;

-- Bracket expression
Bracket_expression:
	  	Bracket_target TE_LSQURE Add_counter Expression_list Remove_counter TE_RSQURE
			{ $$ := ast_factory.new_bracket_as ($1, $4, $2, $6) }
	| 	Bracket_expression TE_LSQURE Add_counter Expression_list Remove_counter TE_RSQURE
			{ $$ := ast_factory.new_bracket_as ($1, $4, $2, $6) }
	;      

Call_bracket_expression:
		Call TE_LSQURE Add_counter Expression_list Remove_counter TE_RSQURE
			{ $$ := ast_factory.new_bracket_as (ast_factory.new_expr_call_as ($1), $4, $2, $6) }
	| 	Call_bracket_expression TE_LSQURE Add_counter Expression_list Remove_counter TE_RSQURE
			{ $$ := ast_factory.new_bracket_as ($1, $4, $2, $6) }
	;      

-- Expression call

Qualified_call:
		Qualified_call TE_DOT Feature_access
			{ $$ := ast_factory.new_nested_expr_as (ast_factory.new_expr_call_as ($1), $3, $2) }
	|	TE_CURRENT TE_DOT Feature_access
			{
				inspect id_level when Precondition_level, Postcondition_level then
					set_has_unqualified_call_in_assertion (True)
				else
					-- Nothing to do.
				end
				$$ := ast_factory.new_nested_expr_as ($1, $3, $2)
			}
	|	TE_RESULT TE_DOT Feature_access
			{ $$ := ast_factory.new_nested_expr_as ($1, $3, $2) }
	|	TE_LPARAN Expression TE_RPARAN TE_DOT Feature_access
			{ $$ := ast_factory.new_nested_expr_as (ast_factory.new_paran_as ($2, $1, $3), $5, $4) }
	|	A_feature TE_DOT Feature_access
			{ $$ := ast_factory.new_nested_expr_as (ast_factory.new_expr_call_as ($1), $3, $2) }
	|	A_precursor TE_DOT Feature_access
			{ $$ := ast_factory.new_nested_expr_as (ast_factory.new_expr_call_as ($1), $3, $2) }
	|	A_static_call TE_DOT Feature_access
			{ $$ := ast_factory.new_nested_expr_as ($1, $3, $2) }
	|	Bracket_expression TE_DOT Feature_access
			{ $$ := ast_factory.new_nested_expr_as ($1, $3, $2) }
	|	Call_bracket_expression TE_DOT Feature_access
			{ $$ := ast_factory.new_nested_expr_as ($1, $3, $2) }
	;

A_precursor: TE_PRECURSOR Parameters
			{
				inspect id_level when Precondition_level, Postcondition_level then
					set_has_unqualified_call_in_assertion (True)
				else
					-- Nothing to do.
				end
				$$ := ast_factory.new_precursor_as ($1, Void, $2)
			}
	|	TE_PRECURSOR TE_LCURLY Class_identifier TE_RCURLY Parameters
			{
				inspect id_level when Precondition_level, Postcondition_level then
					set_has_unqualified_call_in_assertion (True)
				else
					-- Nothing to do.
				end
				if attached ast_factory.new_class_type_as ($3, Void) as l_temp_class_type_as then
					l_temp_class_type_as.set_lcurly_symbol ($2)
					l_temp_class_type_as.set_rcurly_symbol ($4)
					$$ := ast_factory.new_precursor_as ($1, l_temp_class_type_as, $5)
				else
					$$ := ast_factory.new_precursor_as ($1, Void, $5)
				end
			}
	;

A_static_call: New_a_static_call
			{
				inspect id_level
				when Precondition_level, Postcondition_level then
					set_has_non_object_call_in_assertion (True)
				else
					set_has_non_object_call (True)
				end
				$$ := $1
			}
	|	Old_a_static_call
			{
				inspect id_level
				when Precondition_level, Postcondition_level then
					set_has_non_object_call_in_assertion (True)
				else
					set_has_non_object_call (True)
				end
				$$ := $1
			}
	;

New_a_static_call:
		Typed TE_DOT Identifier_as_lower Parameters
			{ $$ := ast_factory.new_static_access_as ($1, $3, $4, Void, $2); }
	;

Old_a_static_call:
		TE_FEATURE Typed TE_DOT Identifier_as_lower Parameters
			{
				$$ := ast_factory.new_static_access_as ($2, $4, $5, $1, $3);
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1),
							filename, once "Remove the `feature' keyword."))
				end
			}
	;

A_feature: Identifier_as_lower Parameters
			{
				inspect id_level
				when Normal_level then
					$$ := ast_factory.new_access_id_as ($1, $2)
				when Precondition_level, Postcondition_level then
					set_has_unqualified_call_in_assertion (True)
					$$ := ast_factory.new_access_assert_as ($1, $2)
				when Invariant_level then
					$$ := ast_factory.new_access_inv_as ($1, $2, Void)
				end
			}
	;

Feature_access: Identifier_as_lower Parameters
			{ $$ := ast_factory.new_access_feat_as ($1, $2) }
	;

Bracket_target:
		Expression_constant
			{ $$ := $1 }
	|	Typed_expression
			{ $$ := $1 }
	|	Manifest_tuple
			{ $$ := $1 }
	|	TE_CURRENT
			{
				inspect id_level when Precondition_level, Postcondition_level then
					set_has_unqualified_call_in_assertion (True)
				else
					-- Nothing to do.
				end
				$$ := $1
			}
	|	TE_RESULT
			{ $$ := $1 }
	|	TE_LPARAN Expression TE_RPARAN
			{ $$ := ast_factory.new_paran_as ($2, $1, $3) }
	|	Creation_expression
			{ $$ := $1 }
	|	Loop_expression
			{ $$ := $1 }
	;

Parameters: -- Empty
			-- { $$ := Void }
	|	TE_LPARAN TE_RPARAN
			{
					-- Per ECMA, this should be rejected. For now we only raise
					-- a warning. And on the compiler side, we will simply ignore them altogether.
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
						once "Empty parameter list are not allowed"))
				end
				$$ := ast_factory.new_parameter_list_as (Void, $1, $2)
			}
	|	TE_LPARAN Add_counter Parameter_list Remove_counter TE_RPARAN
			{ $$ := ast_factory.new_parameter_list_as ($3, $1, $5) }
	;

Actual_parameter: Expression
			{ $$ := $1 }
	|	TE_ADDRESS TE_LPARAN Expression TE_RPARAN
			{ $$ := ast_factory.new_expr_address_as ($3, $1, $2, $4) }
	;

Parameter_list: Actual_parameter
			{
				$$ := ast_factory.new_eiffel_list_expr_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Actual_parameter TE_COMMA Increment_counter Parameter_list
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	;

Expression_list: Expression
			{
				$$ := ast_factory.new_eiffel_list_expr_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Expression TE_COMMA Increment_counter Expression_list
			{
				$$ := $4
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, $2)
				end
			}
	;

Class_or_tuple_identifier: Tuple_identifier
			{
				$$ := $1
			}
	|	Class_identifier
			{
				$$ := $1;
			}
	;

Class_identifier: TE_ID
			{
				if attached $1 as l_id then
					l_id.to_upper		
					$$ := l_id
				end
			}
	|	TE_ACROSS
			{
					-- Keyword used as identifier
				$$ := extract_id ($1)
			}
	|	TE_ASSIGN
			{
					-- Keyword used as identifier
				$$ := extract_id ($1)
			}
	|	TE_ATTRIBUTE
			{
					-- Keyword used as identifier
				$$ := extract_id ($1)
			}
	|	TE_ATTACHED
			{
					-- Keyword used as identifier
				$$ := extract_id ($1)
			}
	|	TE_DETACHABLE
			{
					-- Keyword used as identifier
				$$ := extract_id ($1)
			}
	|	TE_SOME
			{
					-- Keyword used as identifier
				$$ := extract_id ($1)
			}
	;

Tuple_identifier: TE_TUPLE
			{
				if attached $1 as l_tuple then
					l_tuple.to_upper
					$$ := l_tuple
				end
			}
	;

Identifier_as_lower: TE_ID
			{
				if attached $1 as l_id then
					l_id.to_lower
					$$ := l_id
				end
			}
	|	TE_TUPLE
			{
				if attached $1 as l_tuple then
					l_tuple.to_lower
					$$ := l_tuple
				end
			}
	|	TE_ACROSS
			{
					-- Keyword used as identifier
				$$ := extract_id ($1)
			}
	|	TE_ASSIGN
			{
					-- Keyword used as identifier
				$$ := extract_id ($1)
			}
	|	TE_ATTACHED
			{
					-- Keyword used as identifier
				$$ := extract_id ($1)
			}
	|	TE_DETACHABLE
			{
					-- Keyword used as identifier
				$$ := extract_id ($1)
			}
	;

-- Conditional expression

Conditional_expression:
		TE_IF Expression TE_THEN Expression TE_ELSE Expression TE_END
			{ $$ := ast_factory.new_if_expression_as ($2, $4, Void, $6, $7, $1, $3, $5) }
	|	TE_IF Expression TE_THEN Expression Elseif_list_expression TE_ELSE Expression TE_END
			{ $$ := ast_factory.new_if_expression_as ($2, $4, $5, $7, $8, $1, $3, $6) }
	;

Elseif_list_expression: Add_counter Elseif_part_list_expression Remove_counter
		{ $$ := $2 }
	;

Elseif_part_list_expression: Elseif_part_expression
			{
				$$ := ast_factory.new_eiffel_list_elseif_expression_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	Elseif_part_expression Increment_counter Elseif_part_list_expression
			{
				$$ := $3
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	;

Elseif_part_expression: TE_ELSEIF Expression TE_THEN Expression
			{ $$ := ast_factory.new_elseif_expression_as ($2, $4, $1, $3) }
	;

-- Multi-branch expression

Multi_branch_expression: TE_INSPECT Expression When_expression_part_list_opt TE_END
			{ $$ := ast_factory.new_inspect_expression_as ($2, $3, Void, $4, $1, Void) }
	|	TE_INSPECT Expression When_expression_part_list_opt TE_ELSE Expression TE_END
			{ $$ := ast_factory.new_inspect_expression_as ($2, $3, $5, $6, $1, $4) }
	;

When_expression_part_list_opt: -- Empty
			-- { $$ := Void }
	|	Add_counter When_expression_part_list Remove_counter
			{ $$ := $2 }
	;

When_expression_part_list: When_expression_part
			{
				$$ := ast_factory.new_eiffel_list_case_expression_as (counter_value + 1)
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	|	When_expression_part Increment_counter When_expression_part_list
			{
				$$ := $3
				if attached $$ as l_list and then attached $1 as l_val then
					l_list.reverse_extend (l_val)
				end
			}
	;

When_expression_part: TE_WHEN Add_counter Choices Remove_counter TE_THEN Expression
			{ $$ := ast_factory.new_case_expression_as ($3, $6, $1, $5) }
	;


-- Constant value without any type qualifier.
Manifest_value: Boolean_constant
			{ $$ := $1 }
	|	TE_CHAR
			{ $$ := $1 }
	|	Signed_integer
			{ $$ := $1 }
	|	Nosigned_integer
			{ $$ := $1 }
	|	Signed_real
			{ $$ := $1 }
	|	Nosigned_real
			{ $$ := $1 }
	|	Default_manifest_string
			{ $$ := $1 }
	;

-- Constant with optional type qualifier.
Manifest_constant: Boolean_constant
			{ $$ := $1 }
	|	Character_constant
			{ $$ := $1 }
	|	Integer_constant
			{ $$ := $1 }
	|	Real_constant
			{ $$ := $1 }
	|	Manifest_string
			{ $$ := $1 }
	;

-- It contains all constants except the Integer/Real one without a sign mark.
Expression_constant:
		Boolean_constant
			{ $$ := $1 }
	|	Signed_integer
			{ $$ := $1 }
	|	Typed_signed_integer
			{ $$ := $1 }
	|	Signed_real
			{ $$ := $1 }
	|	Typed_signed_real
			{ $$ := $1 }
	|	Character_constant
			{ $$ := $1 }
	|	Manifest_string
			{ $$ := $1 }
	|	TE_ONCE_STRING Manifest_string
			{
				if attached $2 as l_string then
					l_string.set_is_once_string (True)
					l_string.set_once_string_keyword ($1)
				end
				increment_once_manifest_string_counter
				$$ := $2
			}
	;

Boolean_constant: TE_FALSE
			{ $$ := $1 }
	|	TE_TRUE
			{ $$ := $1 }
	;

Character_constant: TE_CHAR
			{ $$ := $1 }
	|	Typed TE_CHAR
			{
				$$ := ast_factory.new_typed_char_as ($1, $2)
			}
	;

--###################################################################
--# Integer constants
--###################################################################
Integer_constant:
		Signed_integer
			{ $$ := $1 }
	|	Nosigned_integer
			{ $$ := $1 }
	|	Typed_integer
			{ $$ := $1 }
	;

Signed_integer: TE_PLUS TE_INTEGER
			{
				$$ := ast_factory.new_integer_value (Current, '+', Void, token_buffer, $1)
			}
	|	TE_MINUS TE_INTEGER
			{
				$$ := ast_factory.new_integer_value (Current, '-', Void, token_buffer, $1)
			}
	;

Nosigned_integer: TE_INTEGER
			{
				$$ := ast_factory.new_integer_value (Current, '%U', Void, token_buffer, Void)
			}
	;

Typed_integer: Typed_nosigned_integer
			{ $$ := $1 }
	|	Typed_signed_integer
			{ $$ := $1 }
	;

Typed_nosigned_integer: Typed TE_INTEGER
			{
				$$ := ast_factory.new_integer_value (Current, '%U', $1, token_buffer, Void)
			}
	;

Typed_signed_integer:	Typed TE_PLUS TE_INTEGER
			{
				$$ := ast_factory.new_integer_value (Current, '+', $1, token_buffer, $2)
			}
	|	Typed TE_MINUS TE_INTEGER
			{
				$$ := ast_factory.new_integer_value (Current, '-', $1, token_buffer, $2)
			}
	;

--###################################################################
--# Real constants
--###################################################################
Real_constant: Signed_real
			{ $$ := $1 }
	|	Nosigned_real
			{ $$ := $1 }
	|	Typed_real
			{ $$ := $1 }
	;

Nosigned_real: TE_REAL
			{
				$$ := ast_factory.new_real_value (Current, False, '%U', Void, token_buffer, Void)
			}
	;

Signed_real: TE_PLUS TE_REAL
			{
				$$ := ast_factory.new_real_value (Current, True, '+', Void, token_buffer, $1)
			}
	|	TE_MINUS TE_REAL
			{
				$$ := ast_factory.new_real_value (Current, True, '-', Void, token_buffer, $1)
			}
	;

Typed_real: Typed_nosigned_real
			{ $$ := $1 }
	|	Typed_signed_real
			{ $$ := $1 }
	;

Typed_nosigned_real: Typed TE_REAL
			{
				$$ := ast_factory.new_real_value (Current, False, '%U', $1, token_buffer, Void)
			}
	;

Typed_signed_real: Typed TE_PLUS TE_REAL
			{
				$$ := ast_factory.new_real_value (Current, True, '+', $1, token_buffer, $2)
			}
	|	Typed TE_MINUS TE_REAL
			{
				$$ := ast_factory.new_real_value (Current, True, '-', $1, token_buffer, $2)
			}
	;

--###################################################################
--# Manifest string constants
--###################################################################
Manifest_string: Default_manifest_string
			{ $$ := $1 }
	|	Typed_manifest_string
			{ $$ := $1 }
	;

Default_manifest_string: Non_empty_string
			{ $$ := $1 }
	|	TE_EMPTY_STRING
			{ $$ := $1 }
	|	TE_EMPTY_VERBATIM_STRING
			{ $$ := $1 }
	;

Typed_manifest_string: Typed Default_manifest_string
			{
				$$ := $2
				if attached $$ as l_string then
					l_string.set_type ($1)
				end
			}
	;

Non_empty_string: TE_STRING
			{ $$ := $1 }
	|	TE_VERBATIM_STRING
			{ $$ := $1 }
	|	TE_STR_LT
			{ $$ := $1 }
	|	TE_STR_LE
			{ $$ := $1 }
	|	TE_STR_GT
			{ $$ := $1 }
	|	TE_STR_GE
			{ $$ := $1 }
	|	TE_STR_MINUS
			{ $$ := $1 }
	|	TE_STR_PLUS
			{ $$ := $1 }
	|	TE_STR_STAR
			{ $$ := $1 }
	|	TE_STR_SLASH
			{ $$ := $1 }
	|	TE_STR_MOD
			{ $$ := $1 }
	|	TE_STR_DIV
			{ $$ := $1 }
	|	TE_STR_POWER
			{ $$ := $1 }
	|	TE_STR_BRACKET
			{ $$ := $1 }
	|	TE_STR_PARENTHESES
			{ $$ := $1 }
	|	TE_STR_AND
			{ $$ := $1 }
	|	TE_STR_AND_THEN
			{ $$ := $1 }
	|	TE_STR_IMPLIES
			{ $$ := $1 }
	|	TE_STR_OR
			{ $$ := $1 }
	|	TE_STR_OR_ELSE
			{ $$ := $1 }
	|	TE_STR_XOR
			{ $$ := $1 }
	|	TE_STR_NOT
			{ $$ := $1 }
	|	TE_STR_FREE
			{ $$ := $1 }
	;


Infix_operator: TE_STR_LT
			{ $$ := $1 }
	|	TE_STR_LE
			{ $$ := $1 }
	|	TE_STR_GT
			{ $$ := $1 }
	|	TE_STR_GE
			{ $$ := $1 }
	|	TE_STR_MINUS
			{ $$ := $1 }
	|	TE_STR_PLUS
			{ $$ := $1 }
	|	TE_STR_STAR
			{ $$ := $1 }
	|	TE_STR_SLASH
			{ $$ := $1 }
	|	TE_STR_MOD
			{ $$ := $1 }
	|	TE_STR_DIV
			{ $$ := $1 }
	|	TE_STR_POWER
			{ $$ := $1 }
	|	TE_STR_AND
			{
					-- Alias names should always be taken in their lower case version
				if attached $1 as l_str_and then
					l_str_and.value_to_lower
					$$ := l_str_and
				end
			}
	|	TE_STR_AND_THEN
			{
					-- Alias names should always be taken in their lower case version
				if attached $1 as l_str_and_then then
					l_str_and_then.value_to_lower
					$$ := l_str_and_then
				end
			}
	|	TE_STR_IMPLIES
			{
					-- Alias names should always be taken in their lower case version
				if attached $1 as l_str_implies then 
					l_str_implies.value_to_lower
					$$ := l_str_implies
				end
			}
	|	TE_STR_OR
			{
					-- Alias names should always be taken in their lower case version
				if attached $1 as l_str_or then
					l_str_or.value_to_lower
					$$ := l_str_or
				end
			}
	|	TE_STR_OR_ELSE
			{
					-- Alias names should always be taken in their lower case version
				if attached $1 as l_str_or_else then
					l_str_or_else.value_to_lower
					$$ := l_str_or_else
				end
			}
	|	TE_STR_XOR
			{
					-- Alias names should always be taken in their lower case version
				if attached $1 as l_str_xor then
					l_str_xor.value_to_lower
					$$ := l_str_xor
				end
			}
	|	TE_STR_FREE
			{
					-- Alias names should always be taken in their lower case version
				if attached $1 as l_str_free then
					l_str_free.value_to_lower
					$$ := l_str_free
				end
			}
	;

Manifest_array:
	TE_LARRAY TE_RARRAY
			{ $$ := ast_factory.new_array_as (ast_factory.new_eiffel_list_expr_as (0), $1, $2) }
	|	Typed TE_LARRAY TE_RARRAY
			{
				$$ := ast_factory.new_array_as (ast_factory.new_eiffel_list_expr_as (0), $2, $3)
				if attached $$ as a then
					a.set_type ($1)
				end
			}
	|	TE_LARRAY Add_counter Expression_list Remove_counter TE_RARRAY
			{ $$ := ast_factory.new_array_as ($3, $1, $5) }
	|	Typed TE_LARRAY Add_counter Expression_list Remove_counter TE_RARRAY
			{
				$$ := ast_factory.new_array_as ($4, $2, $6)
				if attached $$ as a then
					a.set_type ($1)
				end
			}
	;

Manifest_tuple: TE_LSQURE TE_RSQURE
			{ $$ := ast_factory.new_tuple_as (ast_factory.new_eiffel_list_expr_as (0), $1, $2) }
	|	TE_LSQURE Add_counter Expression_list Remove_counter TE_RSQURE
			{ $$ := ast_factory.new_tuple_as ($3, $1, $5) }
	;

Add_indexing_counter:
			{
				add_counter
			}
	;

Add_counter: { add_counter }
	;

Add_counter2: { add_counter2 }
	;
	
Increment_counter: { increment_counter }
	;
	
Increment_counter2: { increment_counter2 }
	;

Remove_counter: { remove_counter }
	;


%%

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
