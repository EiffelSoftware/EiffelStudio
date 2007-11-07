
%{
indexing

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

%nonassoc	TE_ASSIGNMENT
%nonassoc	TE_DOTDOT
%left		TE_IMPLIES
%left		TE_OR
%left		TE_XOR
%left		TE_AND
-- Uncomment when Tilda_agent_call is removed.
--%left 		TE_TILDE TE_NOT_TILDE TE_NE TE_EQ TE_LT TE_GT TE_LE TE_GE
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

%token <ID_AS> TE_FREE TE_ID TE_TUPLE TE_A_BIT
%token TE_INTEGER
%token TE_REAL
%token <CHAR_AS>TE_CHAR

%token <SYMBOL_AS> 		TE_LSQURE TE_RSQURE
%token <SYMBOL_AS>		TE_ACCEPT TE_ADDRESS TE_ASSIGNMENT
%token <SYMBOL_AS> 		TE_CURLYTILDE
%token <SYMBOL_AS>		TE_LARRAY TE_RARRAY TE_RPARAN TE_LPARAN
%token <SYMBOL_AS>		TE_LCURLY TE_RCURLY
%token <SYMBOL_AS> 		TE_BANG TE_SEMICOLON
%token <SYMBOL_AS>		TE_COLON TE_COMMA
%token <SYMBOL_AS>		TE_CONSTRAIN TE_QUESTION
%token <SYMBOL_AS> 		TE_DOTDOT TE_DOT
%token <SYMBOL_AS> 		TE_TILDE TE_NOT_TILDE TE_EQ TE_LT TE_GT TE_LE TE_GE TE_NE
%token <SYMBOL_AS> 		TE_PLUS TE_MINUS TE_STAR TE_SLASH TE_POWER
%token <SYMBOL_AS> 		TE_DIV TE_MOD

%token <BOOL_AS> TE_FALSE TE_TRUE
%token <RESULT_AS> TE_RESULT
%token <RETRY_AS> TE_RETRY
%token <UNIQUE_AS> TE_UNIQUE
%token <CURRENT_AS> TE_CURRENT
%token <DEFERRED_AS> TE_DEFERRED
%token <VOID_AS> TE_VOID

%token <KEYWORD_AS> TE_END
%token <KEYWORD_AS> TE_FROZEN
%token <KEYWORD_AS> TE_PARTIAL_CLASS	
%token <KEYWORD_AS> TE_INFIX
%token <KEYWORD_AS> TE_CREATION
%token <KEYWORD_AS> TE_PRECURSOR
%token <KEYWORD_AS> TE_PREFIX

%token <KEYWORD_AS> TE_IS
%token <KEYWORD_AS> TE_AGENT TE_ALIAS TE_ALL TE_AND TE_AS
%token <KEYWORD_AS> TE_ASSIGN TE_BIT TE_CHECK TE_CLASS TE_CONVERT
%token <KEYWORD_AS> TE_CREATE TE_DEBUG TE_DO TE_ELSE TE_ELSEIF
%token <KEYWORD_AS> TE_ENSURE TE_EXPANDED TE_EXPORT TE_EXTERNAL TE_FEATURE
%token <KEYWORD_AS> TE_FROM TE_IF TE_IMPLIES TE_INDEXING TE_INHERIT
%token <KEYWORD_AS> TE_INSPECT TE_INVARIANT TE_LIKE TE_LOCAL
%token <KEYWORD_AS> TE_LOOP TE_NOT TE_OBSOLETE TE_OLD TE_ONCE
%token <KEYWORD_AS> TE_ONCE_STRING TE_OR TE_REDEFINE TE_REFERENCE TE_RENAME
%token <KEYWORD_AS> TE_REQUIRE TE_RESCUE TE_SELECT TE_SEPARATE TE_STRIP
%token <KEYWORD_AS> TE_THEN TE_UNDEFINE	TE_UNTIL TE_VARIANT TE_WHEN	
%token <KEYWORD_AS> TE_XOR

%token TE_STRING TE_EMPTY_STRING TE_VERBATIM_STRING	TE_EMPTY_VERBATIM_STRING
%token TE_STR_LT TE_STR_LE TE_STR_GT TE_STR_GE TE_STR_MINUS
%token TE_STR_PLUS TE_STR_STAR TE_STR_SLASH TE_STR_MOD
%token TE_STR_DIV TE_STR_POWER TE_STR_AND TE_STR_AND_THEN
%token TE_STR_IMPLIES TE_STR_OR TE_STR_OR_ELSE TE_STR_XOR
%token TE_STR_NOT TE_STR_FREE TE_STR_BRACKET

%type <SYMBOL_AS>ASemi
%type <KEYWORD_AS> Alias_mark Is_keyword
%type <ALIAS_TRIPLE>Alias
%type <PAIR[KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]> Else_part Rescue

%type <PAIR[KEYWORD_AS, ID_AS]> Assigner_mark_opt
%type <PAIR[KEYWORD_AS, STRING_AS]> External_name Obsolete
%type <IDENTIFIER_LIST>		Identifier_list Strip_identifier_list
%type <PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]]> Invariant
%type <AGENT_TARGET_TRIPLE> Agent_target

%type <ACCESS_AS>			A_feature Creation_target
%type <ACCESS_FEAT_AS>		Feature_access
%type <ACCESS_INV_AS>		Creation_call
%type <ARRAY_AS>			Manifest_array
%type <ASSIGN_AS>			Assignment
%type <ASSIGNER_CALL_AS>	Assigner_call
%type <ATOMIC_AS>			Index_value Manifest_constant Expression_constant
%type <BINARY_AS>			Qualified_binary_expression
%type <BIT_CONST_AS>		Bit_constant
%type <BODY_AS>				Declaration_body
%type <BOOL_AS>				Boolean_constant
%type <CALL_AS>				Call Remote_call Qualified_call
%type <CASE_AS>				When_part
%type <CHAR_AS>				Character_constant
%type <CHECK_AS>			Check
%type <KEYWORD_AS>			Class_mark
%type <CLIENT_AS>			Clients Feature_client_clause
%type <CONSTANT_AS>			Constant_attribute
%type <CONVERT_FEAT_AS>		Convert_feature
%type <CREATE_AS>			Creation_clause
%type <CREATION_AS>			Creation
%type <CREATION_EXPR_AS>	Creation_expression
%type <DEBUG_AS>			Debug
%type <ELSIF_AS>			Elseif_part
%type <ENSURE_AS>			Postcondition
%type <EXPORT_ITEM_AS>		New_export_item
%type <EXPR_AS>				Bracket_target Expression Factor Qualified_expression Qualified_factor Typed_expression
%type <EXTERNAL_AS>			External
%type <EXTERNAL_LANG_AS>	External_language
%type <FEATURE_AS>			Feature_declaration
%type <FEATURE_CLAUSE_AS>	Feature_clause
%type <FEATURE_SET_AS>		Feature_set
%type <FORMAL_AS>			Formal_parameter
%type <FORMAL_DEC_AS>		Formal_generic
%type <ID_AS>				Class_or_tuple_identifier Class_identifier Identifier_as_lower Free_operator Feature_name_for_call
%type <IF_AS>				Conditional
%type <INDEX_AS>			Index_clause Index_clause_impl
%type <INSPECT_AS>			Multi_branch
%type <INSTRUCTION_AS>		Instruction Instruction_impl
%type <INTEGER_AS>	Integer_constant Signed_integer Nosigned_integer Typed_integer Typed_nosigned_integer Typed_signed_integer
%type <INTERNAL_AS>			Internal
%type <INTERVAL_AS>			Choice
%type <INVARIANT_AS>		Class_invariant
%type <LOOP_AS>				Loop
%type <NESTED_AS>			Call_on_feature_access
%type <OPERAND_AS>			Delayed_actual
%type <PARENT_AS>			Parent Parent_clause
%type <PRECURSOR_AS>		A_precursor
%type <STATIC_ACCESS_AS>	A_static_call Old_a_static_call New_a_static_call
%type <REAL_AS>				Real_constant Signed_real Nosigned_real Typed_real Typed_nosigned_real Typed_signed_real
%type <RENAME_AS>			Rename_pair
%type <REQUIRE_AS>			Precondition
%type <REVERSE_AS>			Reverse_assignment
%type <ROUT_BODY_AS>		Routine_body
%type <ROUTINE_AS>			Routine Optional_attribute_or_routine
%type <ROUTINE_CREATION_AS>	Agent_call
%type <PAIR[ROUTINE_CREATION_AS, LOCATION_AS]> Tilda_agent_call
%type <STRING_AS>			Manifest_string Non_empty_string Default_manifest_string Typed_manifest_string Infix_operator Prefix_operator Alias_name
%type <TAGGED_AS>			Assertion_clause
%type <TUPLE_AS>			Manifest_tuple
%type <TYPE_AS>				Type Attached_type Non_class_type Typed Class_or_tuple_type Attached_class_type Class_type Tuple_type Type_no_id Constraint_type
%type <PAIR [SYMBOL_AS, TYPE_AS]> Type_mark
%type <CLASS_TYPE_AS>		Parent_class_type
%type <TYPE_DEC_AS>			Entity_declaration_group
%type <VARIANT_AS>			Variant
%type <FEATURE_NAME>		Infix Prefix Feature_name Extended_feature_name New_feature

%type <EIFFEL_LIST [ATOMIC_AS]>			Index_terms
%type <EIFFEL_LIST [CASE_AS]>			When_part_list_opt When_part_list
%type <CONVERT_FEAT_LIST_AS>			Convert_list Convert_clause
%type <EIFFEL_LIST [CREATE_AS]>			Creators Creation_clause_list
%type <EIFFEL_LIST [ELSIF_AS]>			Elseif_list Elseif_part_list
%type <EIFFEL_LIST [EXPORT_ITEM_AS]>	New_export_list
%type <EXPORT_CLAUSE_AS> 				New_exports New_exports_opt
%type <EIFFEL_LIST [EXPR_AS]>			Expression_list
%type <PARAMETER_LIST_AS> 	Parameters
%type <EIFFEL_LIST [FEATURE_AS]>		Feature_declaration_list
%type <EIFFEL_LIST [FEATURE_CLAUSE_AS]>	Features Feature_clause_list
%type <EIFFEL_LIST [FEATURE_NAME]>		Feature_list Feature_list_impl New_feature_list
%type <CREATION_CONSTRAIN_TRIPLE>	Creation_constraint
%type <UNDEFINE_CLAUSE_AS>	Undefine Undefine_opt
%type <REDEFINE_CLAUSE_AS> Redefine Redefine_opt
%type <SELECT_CLAUSE_AS>	Select Select_opt
%type <FORMAL_GENERIC_LIST_AS>		Formal_generics Formal_generic_list
%type <CLASS_LIST_AS>					Client_list Class_list

%type <INDEXING_CLAUSE_AS>			Indexing Index_list Dotnet_indexing
%type <EIFFEL_LIST [INSTRUCTION_AS]>	Compound Instruction_list
%type <EIFFEL_LIST [INTERVAL_AS]>		Choices
%type <EIFFEL_LIST [OPERAND_AS]>		Delayed_actual_list
%type <DELAYED_ACTUAL_LIST_AS>	Delayed_actuals
%type <PARENT_LIST_AS>					Inheritance Parent_list
%type <EIFFEL_LIST [RENAME_AS]>			Rename_list
%type <RENAME_CLAUSE_AS>				Rename 
%type <EIFFEL_LIST [STRING_AS]>			String_list
%type <DEBUG_KEY_LIST_AS>	Debug_keys
%type <EIFFEL_LIST [TAGGED_AS]>			Assertion Assertion_list
%type <TYPE_LIST_AS>	Generics Generics_opt Type_list Type_list_impl Actual_parameter_list
%type <TYPE_DEC_LIST_AS>		Entity_declaration_list Named_parameter_list 
%type <LOCAL_DEC_LIST_AS>	Local_declarations
%type <FORMAL_ARGU_DEC_LIST_AS> Formal_arguments Optional_formal_arguments
%type <CONSTRAINT_TRIPLE>	Constraint
%type <CONSTRAINT_LIST_AS> Multiple_constraint_list
%type <CONSTRAINING_TYPE_AS> Single_constraint

%expect 126

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
			}
	|	Identifier_as_lower Type
			{
				if not type_parser or expression_parser or feature_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				type_node := $2
			}
	|	TE_FEATURE Feature_declaration
			{
				if not feature_parser or type_parser or expression_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				feature_node := $2
			}
	|	TE_CHECK Expression
			{
				if not expression_parser or type_parser or feature_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				expression_node := $2
			}
	|	Indexing
			{
				if not indexing_parser or type_parser or expression_parser or feature_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				indexing_node := $1
			}
	|	TE_INVARIANT Class_invariant
			{
				if not invariant_parser or type_parser or expression_parser or feature_parser or indexing_parser or entity_declaration_parser then
					raise_error
				end
				invariant_node := $2
			}
	|	TE_LOCAL
			{
				if not entity_declaration_parser or type_parser or expression_parser or feature_parser or indexing_parser or invariant_parser then
					raise_error
				end
				entity_declaration_node := Void
			}
	|	TE_LOCAL Add_counter Entity_declaration_list Remove_counter
			{
				if not entity_declaration_parser or type_parser or expression_parser or feature_parser or indexing_parser or invariant_parser then
					raise_error
				end
				entity_declaration_node := $3
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
		{conforming_inheritance_flag := False; non_conforming_inheritance_flag := False } Inheritance {inheritance_end_position := position; conforming_inheritance_flag := True} Inheritance -- $8 $9 $10 $11
		Creators								-- $12
		Convert_clause							-- $13
		Features End_features_pos				-- $14 $15
		Class_invariant 						-- $16
		Indexing								-- $17
		TE_END									-- $18
			{
				if $6 /= Void then
					temp_string_as1 := $6.second
				else
					temp_string_as1 := Void
				end
				if $7 /= Void then
					temp_string_as2 := $7.second
				else
					temp_string_as2 := Void
				end
				
				root_node := new_class_description ($4, temp_string_as1,
					is_deferred, is_expanded, is_separate, is_frozen_class, is_external_class, is_partial_class,
					$1, $17, $5, $9, $11, $12, $13, $14, $16, suppliers, temp_string_as2, $18)
				if root_node /= Void then
					root_node.set_text_positions (
						formal_generics_end_position,
						inheritance_end_position,
						features_end_position)
						if $6 /= Void then
							root_node.set_alias_keyword ($6.first)
						end
						if $7 /= Void then
							root_node.set_obsolete_keyword ($7.first)
						end
						root_node.set_header_mark (frozen_keyword, expanded_keyword, deferred_keyword, separate_keyword, external_keyword)
						root_node.set_class_keyword ($3)
				end
			}
	;

End_features_pos: { features_end_position := position } ;
End_feature_clause_pos: { feature_clause_end_position := position };
-- Indexing


Indexing: -- Empty
			-- { $$ := Void }
	|	TE_INDEXING Add_indexing_counter Index_list Remove_counter
			{
				$$ := $3
				if $$ /= Void then
					$$.set_indexing_keyword ($1)
				end				
				set_has_old_verbatim_strings_warning (initial_has_old_verbatim_strings_warning)
			}
	|	TE_INDEXING
			--- { $$ := Void }
			{
				$$ := ast_factory.new_indexing_clause_as (0)
				if $$ /= Void then
					$$.set_indexing_keyword ($1)
				end
			}
	;

Dotnet_indexing: -- Empty
			-- { $$ := Void }
	|	TE_INDEXING TE_END
		---	{ $$ := Void }
		{
				$$ := ast_factory.new_indexing_clause_as (0)
				if $$ /= Void then
						$$.set_indexing_keyword ($1)
						$$.set_end_keyword ($2)
				end		
		}
	|	TE_INDEXING Add_indexing_counter Index_list Remove_counter TE_END
			{
				$$ := $3
				if $$ /= Void then
					if $1 /= Void then
						$$.set_indexing_keyword ($1)
					end
					if $5 /= Void then	
						$$.set_end_keyword ($5)
					end
				end				
				set_has_old_verbatim_strings_warning (initial_has_old_verbatim_strings_warning)
			}
	;

Index_list: Index_clause
			{
				$$ := ast_factory.new_indexing_clause_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
					$$.update_lookup ($1)
				end
			}
	|	Index_clause Increment_counter Index_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
					$$.update_lookup ($1)
				end
			}
	;

Index_clause: Add_counter Index_clause_impl Remove_counter
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
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
						once "Missing `Index' part of `Index_clause'."))
				end
			}
	;

Index_terms: Index_value
			{
				$$ := ast_factory.new_eiffel_list_atomic_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Index_value TE_COMMA Increment_counter Index_terms
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
					ast_factory.reverse_extend_separator ($$, $2)
				end
			}
	|	TE_SEMICOLON
			{
-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				$$ := ast_factory.new_eiffel_list_atomic_as (0)
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
			{
				is_deferred := False
				is_expanded := False
				is_separate := False

				deferred_keyword := Void
				expanded_keyword := Void
				separate_keyword := Void
			}
	|	TE_DEFERRED External_mark
			{
				is_frozen_class := False
				is_deferred := True
				is_expanded := False
				is_separate := False

				frozen_keyword := Void
				deferred_keyword := $1
				expanded_keyword := Void
				separate_keyword := Void
			}
	|	Frozen_mark TE_EXPANDED External_mark
			{
				is_deferred := False
				is_expanded := True
				is_separate := False
				
				deferred_keyword := Void
				expanded_keyword := $2
				separate_keyword := Void
			}
	|	Frozen_mark TE_SEPARATE External_mark
			{
				is_deferred := False
				is_expanded := False
				is_separate := True

				deferred_keyword := Void
				expanded_keyword := Void
				separate_keyword := $2
			}
	;

Frozen_mark: -- Empty
			{
				is_frozen_class := False
				frozen_keyword := Void
			}
	|	TE_FROZEN
			{
					-- I'm adding a few comments line
					-- here because otherwise the generated
					-- parser is very different from the
					-- previous one, since line numbers are
					-- emitted.
				is_frozen_class := True
				frozen_keyword := $1
			}
	;

External_mark: -- Empty
			{
				is_external_class := False
				external_keyword := Void
			}
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
			}
	| TE_PARTIAL_CLASS
		{
			$$ := $1;
			is_partial_class := true;
		}
	;

-- Obsolete


Obsolete: -- Empty
			-- { $$ := Void }
	|	TE_OBSOLETE Manifest_string
			{
				$$ := ast_factory.new_keyword_string_pair ($1, $2)
			}
	;


-- Features

Features: -- Empty
			-- { $$ := Void }
	|	Add_counter Feature_clause_list Remove_counter
			{
				$$ := $2
				if $$ /= Void and then $$.is_empty then
					$$ := Void
				end
			}
	;

Feature_clause_list: Feature_clause
			{
				$$ := ast_factory.new_eiffel_list_feature_clause_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Feature_clause Increment_counter Feature_clause_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
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
				fclause_pos := $1
				if $1 /= Void then
						-- Originally, it was 8, I changed it to 7, delete the following line when fully tested. (Jason)
					fclause_pos.set_position (line, column, position, 7)
				else
						-- Originally, it was 8, I changed it to 7 (Jason)
					fclause_pos := ast_factory.new_feature_keyword_as (line, column, position, 7, Current)
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
				$$ := ast_factory.new_class_list_as (1)
				if $$ /= Void then
					$$.reverse_extend (new_none_id)
					$$.set_lcurly_symbol ($1)
					$$.set_rcurly_symbol ($2)
				end
			}
	|	TE_LCURLY Add_counter Class_list Remove_counter TE_RCURLY
			{
				$$ := $3
				if $$ /= Void then
					$$.set_lcurly_symbol ($1)
					$$.set_rcurly_symbol ($5)
				end				
			}
	;

Class_list: Class_or_tuple_identifier
			{
				$$ := ast_factory.new_class_list_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
					suppliers.insert_light_supplier_id ($1)
				end
			}
	|	Class_or_tuple_identifier TE_COMMA Increment_counter Class_list
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
					suppliers.insert_light_supplier_id ($1)
					ast_factory.reverse_extend_separator ($$, $2)
				end
			}
	;

Feature_declaration_list: Feature_declaration
			{
				$$ := ast_factory.new_eiffel_list_feature_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Feature_declaration Increment_counter Feature_declaration_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

ASemi: -- Empty
	|	TE_SEMICOLON { $$ := $1 }
	;

Feature_declaration: Add_counter New_feature_list Remove_counter Declaration_body Optional_semicolons
			{
				$$ := ast_factory.new_feature_as ($2, $4, feature_indexes, position)
				feature_indexes := Void
			}
	;

New_feature_list: New_feature
			{
				$$ := ast_factory.new_eiffel_list_feature_name (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	New_feature TE_COMMA Increment_counter New_feature_list
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
					ast_factory.reverse_extend_separator ($$, $2)
				end
			}
	;

New_feature: Extended_feature_name
			{ $$ := $1 }
	|	TE_FROZEN Extended_feature_name
			{
				$$ := $2
				if $$ /= Void then
					$$.set_frozen_keyword ($1)
				end
			}
	;

Extended_feature_name: Feature_name
			{ $$ := $1 }
	|	Identifier_as_lower Alias
			{
				if $2 /= Void then
					$$ := ast_factory.new_feature_name_alias_as ($1, $2.alias_name, has_convert_mark, $2.alias_keyword, $2.convert_keyword)
				else
					$$ := ast_factory.new_feature_name_alias_as ($1, Void, has_convert_mark, Void, Void)
				end
				
			}
	;

Feature_name: Identifier_as_lower
			{ $$ := ast_factory.new_feature_name_id_as ($1) }
	|	Infix
			{ $$ := $1 }
	|	Prefix
			{ $$ := $1 }
	;

Infix: TE_INFIX Infix_operator
			{ $$ := ast_factory.new_infix_as ($2, $1) }
	;


Prefix: TE_PREFIX Prefix_operator
			{ $$ := ast_factory.new_prefix_as ($2, $1) }
	;

Alias: TE_ALIAS Alias_name Alias_mark
			{
				$$ := ast_factory.new_alias_triple ($1, $2, $3)
			}
	;

Alias_name: Infix_operator
			{ $$ := $1 }
	|	TE_STR_NOT
			{
				$$ := ast_factory.new_string_as ("not", line, column, position, 5, token_buffer2)
			}
	|	TE_STR_BRACKET
			{
				$$ := ast_factory.new_string_as ("[]", line, column, position, 4, token_buffer2)
			}
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
			{ $$ := $1 }
	;

Declaration_body: TE_COLON Type Assigner_mark_opt Dotnet_indexing
			{
					-- Attribute case
				if $3 = Void then
					$$ := ast_factory.new_body_as (Void, $2, Void, Void, $1, Void, Void, $4)
				else
					$$ := ast_factory.new_body_as (Void, $2, $3.second, Void, $1, Void, $3.first, $4)
				end				
				feature_indexes := $4
			}
	|       TE_COLON Type Assigner_mark_opt TE_EQ Constant_attribute Dotnet_indexing
			{
					-- Constant case
				if $3 = Void then
					$$ := ast_factory.new_body_as (Void, $2, Void, $5, $1, $4, Void, $6)
				else
					$$ := ast_factory.new_body_as (Void, $2, $3.second, $5, $1, $4, $3.first, $6)
				end
				
				feature_indexes := $6
			}
	|	TE_COLON Type Assigner_mark_opt TE_IS Constant_attribute Dotnet_indexing
			{
					-- Constant case
				if $3 = Void then
					$$ := ast_factory.new_body_as (Void, $2, Void, $5, $1, $4, Void, $6)
				else
					$$ := ast_factory.new_body_as (Void, $2, $3.second, $5, $1, $4, $3.first, $6)
				end
				
				feature_indexes := $6
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
				if $3 = Void then
					$$ := ast_factory.new_body_as (Void, $2, Void, $6, $1, $4, Void, $5)
				else
					$$ := ast_factory.new_body_as (Void, $2, $3.second, $6, $1, $4, $3.first, $5)
				end
				
				feature_indexes := $5
		}
	|	TE_COLON Type Assigner_mark_opt Indexing Routine
			{
					-- Function without arguments
				if $3 = Void then
					$$ := ast_factory.new_body_as (Void, $2, Void, $5, $1, Void, Void, $4)
				else
					$$ := ast_factory.new_body_as (Void, $2, $3.second, $5, $1, Void, $3.first, $4)
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
				if $4 = Void then
					$$ := ast_factory.new_body_as ($1, $3, Void, $7, $2, $5, Void, $6)
				else
					$$ := ast_factory.new_body_as ($1, $3, $4.second, $7, $2, $5, $4.first, $6)
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
				$$ := ast_factory.new_assigner_mark_as ($1, $2)
			}
	;

Constant_attribute: Manifest_constant
			{ $$ := ast_factory.new_constant_as ($1) }
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
						Error_handler.insert_warning (
							create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
							once "Use `inherit ANY' or do not specify an empty inherit clause"))
					end
					$$ := ast_factory.new_eiffel_list_parent_as (0)
					if $$ /= Void then
						$$.set_inheritance_tokens ($1, Void, Void, Void)
					end
				else
						-- Raise error as conforming inheritance has already been specified
					if non_conforming_inheritance_flag then
						report_one_error (create {SYNTAX_ERROR}.make (token_line ($1), token_column ($1), filename, "Conforming inheritance clause must come before non conforming inheritance clause", False))
					else
						report_one_error (create {SYNTAX_ERROR}.make (token_line ($1), token_column ($1), filename, "Only one conforming inheritance clause allowed per class", False))
					end
				end
			}
	|	TE_INHERIT  Add_counter Parent_list Remove_counter
			{
				if not conforming_inheritance_flag then
						-- Conforming inheritance
					$$ := $3
					if $$ /= Void then
						$$.set_inheritance_tokens ($1, Void, Void, Void)
					end
				else
						-- Raise error as conforming inheritance has already been specified
					if non_conforming_inheritance_flag then
						report_one_error (create {SYNTAX_ERROR}.make (token_line ($1), token_column ($1), filename, "Conforming inheritance clause must come before non conforming inheritance clause", False))
					else
						report_one_error (create {SYNTAX_ERROR}.make (token_line ($1), token_column ($1), filename, "Only one conforming inheritance clause allowed per class", False))
					end
				end
			}
	|	TE_INHERIT TE_LCURLY Class_identifier TE_RCURLY
			{
					-- Non conforming inheritance
				
				if not non_conforming_inheritance_flag then
						-- Check to make sure Class_identifier is 'NONE'
						-- An error will be thrown if TYPE_AS is not of type NONE_TYPE_AS
					ast_factory.validate_non_conforming_inheritance_type (Current, new_class_type ($3, Void, Void))
				else
						-- Raise error as non conforming inheritance has already been specified
					report_one_error (create {SYNTAX_ERROR}.make (token_line ($1), token_column ($1), filename, "Only one non-conforming inheritance clause allowed per class", False))
				end
			}
		Add_counter Parent_list Remove_counter
			{
				$$ := $7
				if $$ /= Void then
					$$.set_inheritance_tokens ($1, $2, $3, $4)
				end
				
					-- Set flag so that no more inheritance clauses can be added as non-conforming is always the last one.
				non_conforming_inheritance_flag := True
			}
			
	;
			
Parent_list: Parent
			{
				$$ := ast_factory.new_eiffel_list_parent_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Parent Increment_counter Parent_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

Parent: Parent_clause ASemi
			{ $$ := $1 }
	;

Parent_class_type: Class_identifier Generics_opt
			{ $$ := ast_factory.new_class_type_as ($1, $2, Void) }
	;

Parent_clause: Parent_class_type
			{
				$$ := ast_factory.new_parent_as ($1, Void, Void, Void, Void, Void, Void)
			}
	|	Parent_class_type Select TE_END
			{
				$$ := ast_factory.new_parent_as ($1, Void, Void, Void, Void, $2, $3)
			}
	|	Parent_class_type Redefine Select_opt TE_END
			{
				$$ := ast_factory.new_parent_as ($1, Void, Void, Void, $2, $3, $4)
			}
	|	Parent_class_type Undefine Redefine_opt Select_opt TE_END
			{
				$$ := ast_factory.new_parent_as ($1, Void, Void, $2, $3, $4, $5)
			}
	|	Parent_class_type New_exports Undefine_opt Redefine_opt Select_opt TE_END
			{
				$$ := ast_factory.new_parent_as ($1, Void, $2, $3, $4, $5, $6)
			}
	|	Parent_class_type Rename New_exports_opt Undefine_opt Redefine_opt Select_opt TE_END
			{
				$$ := ast_factory.new_parent_as ($1, $2, $3, $4, $5, $6, $7)
			}
	;

Rename: TE_RENAME
			{
				$$ := ast_factory.new_rename_clause_as (Void, $1)
				if is_constraint_renaming then
					report_one_error (
						create {SYNTAX_ERROR}.make (token_line ($1), token_column ($1), filename,
						"Empty rename clause.", False))
				else
					error_handler.insert_warning (
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
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Rename_pair TE_COMMA Increment_counter Rename_list
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
					ast_factory.reverse_extend_separator ($$, $2)
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
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	New_export_item Increment_counter New_export_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

New_export_item: Client_list Feature_set ASemi
			{
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
			$$ := $3
			if $$ /= Void then
				$$.set_convert_keyword ($1)
			end
		}
	;

Convert_list: Convert_feature
		{
			$$ := ast_factory.new_eiffel_list_convert (counter_value + 1)
			if $$ /= Void and $1 /= Void then
				$$.reverse_extend ($1)
			end
		}
	|	Convert_feature TE_COMMA Increment_counter Convert_list
		{	
			$$ := $4
			if $$ /= Void and $1 /= Void then
				$$.reverse_extend ($1)
				ast_factory.reverse_extend_separator ($$, $2)
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

Feature_list: Add_counter Feature_list_impl Remove_counter
		{ $$ := $2 }
	;

Feature_list_impl: Feature_name
			{
				$$ := ast_factory.new_eiffel_list_feature_name (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Feature_name TE_COMMA Increment_counter Feature_list_impl
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
					ast_factory.reverse_extend_separator ($$, $2)
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
			-- { $$ := Void }
	|	Select
			{ $$ := $1 }
	;

Select: TE_SELECT
			--- { $$ := Void }
		{
			$$ := ast_factory.new_select_clause_as (Void, $1)
		}
	|	TE_SELECT Feature_list
			{
				$$ := ast_factory.new_select_clause_as ($2, $1)
			}
	;


-- Feature declaration


Formal_arguments:	TE_LPARAN TE_RPARAN
			{ $$ := ast_factory.new_formal_argu_dec_list_as (Void, $1, $2) }
	|	TE_LPARAN Add_counter Entity_declaration_list Remove_counter TE_RPARAN
			{ $$ := ast_factory.new_formal_argu_dec_list_as ($3, $1, $5) }
	;
  
Entity_declaration_list: Entity_declaration_group
			{
				$$ := ast_factory.new_eiffel_list_type_dec_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Entity_declaration_group Increment_counter Entity_declaration_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

Entity_declaration_group: Add_counter Identifier_list Remove_counter TE_COLON Type ASemi
			{ $$ := ast_factory.new_type_dec_as ($2, $5, $4) }
	;

Identifier_list: Identifier_as_lower
			{
				$$ := ast_factory.new_identifier_list (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1.name_id)
					ast_factory.reverse_extend_identifier ($$.id_list, $1)
				end
			}
	|	Identifier_as_lower TE_COMMA Increment_counter Identifier_list 
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1.name_id)
					ast_factory.reverse_extend_identifier ($$.id_list, $1)
					ast_factory.reverse_extend_separator ($$.id_list, $2)
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
			{	set_fbody_pos (position) }
		Precondition
		Local_declarations
		Routine_body
		Postcondition
		Rescue
		TE_END
			{
				if $1 /= Void then
					temp_string_as1 := $1.second
					temp_keyword_as := $1.first
				else
					temp_string_as1 := Void
					temp_keyword_as := Void
				end
				if $7 /= Void then
					$$ := ast_factory.new_routine_as (temp_string_as1, $3, $4, $5, $6, $7.second, $8, once_manifest_string_count, fbody_pos, temp_keyword_as, $7.first, object_test_locals)
				else
					$$ := ast_factory.new_routine_as (temp_string_as1, $3, $4, $5, $6, Void, $8, once_manifest_string_count, fbody_pos, temp_keyword_as, Void, object_test_locals)
				end
				once_manifest_string_count := 0
				object_test_locals := Void
			}
	;

Routine_body: Internal
			{ $$ := $1 }
	|	External
			{ $$ := $1 }
	|	TE_DEFERRED
			{ $$ := $1 }
	;

External: TE_EXTERNAL
			{
					-- To avoid warnings for manifest string used to represent external data.
				initial_has_old_verbatim_strings_warning := has_old_verbatim_strings_warning
				set_has_old_verbatim_strings_warning (false)
			}
		External_language External_name
			{
				if $3 /= Void and then $3.is_built_in then
					if $4 /= Void then 
						$$ := ast_factory.new_built_in_as ($3, $4.second, $1, $4.first)
					else
						$$ := ast_factory.new_built_in_as ($3, Void, $1, Void)
					end
				elseif $4 /= Void then
					$$ := ast_factory.new_external_as ($3, $4.second, $1, $4.first)
				else
					$$ := ast_factory.new_external_as ($3, Void, $1, Void)
				end
				set_has_old_verbatim_strings_warning (initial_has_old_verbatim_strings_warning)
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
	|	TE_ONCE Compound
			{ $$ := ast_factory.new_once_as ($2, $1) }
	;

Local_declarations: -- Empty
			-- { $$ := Void }
	|	TE_LOCAL
			{ $$ := ast_factory.new_local_dec_list_as (ast_factory.new_eiffel_list_type_dec_as (0), $1) }
	|	TE_LOCAL Add_counter Entity_declaration_list Remove_counter
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
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Instruction Increment_counter Instruction_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

Instruction: Instruction_impl Optional_semicolons
			{
				$$ := $1 
				if $$ /= Void then
					$$.set_line_pragma (last_line_pragma)
				end
			}
	;

Optional_semicolons: -- Empty
	| Optional_semicolons TE_SEMICOLON
	;

Instruction_impl: Creation
			{ $$ := $1 }
	|	Expression
			{
					-- Call production should be used instead,
					-- but this complicates the grammar.
				if has_type then
					report_one_error (create {SYNTAX_ERROR}.make (token_line ($1), token_column ($1),
						filename, "Expression cannot be used as an instruction", False))
				elseif $1 /= Void then
					$$ := new_call_instruction_from_expression ($1)
				end
			}
	|	Assigner_call
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
	|	TE_RETRY
			{ $$ := $1 }
	;

Precondition: -- Empty
			-- { $$ := Void }
	|	TE_REQUIRE
			{ set_id_level (Assert_level) }
		Assertion
			{
				set_id_level (Normal_level)
				$$ := ast_factory.new_require_as ($3, $1)
			}
	|	TE_REQUIRE TE_ELSE
			{ set_id_level (Assert_level) }
		Assertion
			{
				set_id_level (Normal_level)
				$$ := ast_factory.new_require_else_as ($4, $1, $2)
			}
	;

Postcondition: -- Empty
			-- { $$ := Void }
	|	TE_ENSURE
			{ set_id_level (Assert_level) }
		Assertion
			{
				set_id_level (Normal_level)
				$$ := ast_factory.new_ensure_as ($3, $1)
			}
	|	TE_ENSURE TE_THEN
			{ set_id_level (Assert_level) }
		Assertion
			{
				set_id_level (Normal_level)
				$$ := ast_factory.new_ensure_then_as ($4, $1, $2)
			}
	;

Assertion: -- Empty
			-- { $$ := Void }
	|	Add_counter Assertion_list Remove_counter
			{
				$$ := $2
				if $$ /= Void and then $$.is_empty then
					$$ := Void
				end
			}
	;

Assertion_list: Assertion_clause
			{
					-- Special list treatment here as we do not want Void
					-- element in `Assertion_list'.
				if $1 /= Void then
					$$ := ast_factory.new_eiffel_list_tagged_as (counter_value + 1)
					if $$ /= Void then
						$$.reverse_extend ($1)
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
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

Assertion_clause: Expression ASemi
			{ $$ := ast_factory.new_tagged_as (Void, $1, Void) }
	|	Identifier_as_lower TE_COLON Expression ASemi
			{ $$ := ast_factory.new_tagged_as ($1, $3, $2) }
	|	Identifier_as_lower TE_COLON ASemi
			--- { $$ := Void }
		{
			-- Always create an object here for roundtrip parser.
			-- This "fake" assertion will be filtered out later.
			$$ := ast_factory.new_tagged_as ($1, Void, $2)
		}
	;


-- Type


Type: Class_or_tuple_type
			{ $$ := $1 }
	|	Non_class_type
			{ $$ := $1 }
	;
	
Attached_type: Attached_class_type
			{ $$ := $1 }
	|	Tuple_type
			{ $$ := $1 }
	|	Non_class_type
			{ $$ := $1 }
	;
	
Type_no_id: 
		Class_identifier Generics
			{ $$ := new_class_type ($1, $2, Void) }
	|	Tuple_type
			{ $$ := $1 }
	|	Non_class_type
			{ $$ := $1 }
	;
	
Non_class_type: TE_EXPANDED Attached_class_type
			{
				$$ := $2
				ast_factory.set_expanded_class_type ($$, True, $1)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
						once "Make an expanded version of the base class associated with this type."))
				end
			}
	|	TE_SEPARATE Class_or_tuple_type
			{
				last_class_type ?= $2
				if last_class_type /= Void then
					last_class_type.set_is_separate (True, $1)
					last_class_type := Void
				end
				$$ := $2
			}
	|	TE_BIT Integer_constant
			{ $$ := ast_factory.new_bits_as ($2, $1) }
	|	TE_BIT Identifier_as_lower
			{ $$ := ast_factory.new_bits_symbol_as ($2, $1) }
	|	TE_LIKE Identifier_as_lower
			{ $$ := ast_factory.new_like_id_as ($2, $1, Void) }
	|	TE_BANG TE_LIKE Identifier_as_lower
			{ $$ := ast_factory.new_like_id_as ($3, $2, $1) }
	|	TE_QUESTION TE_LIKE Identifier_as_lower
			{ $$ := ast_factory.new_like_id_as ($3, $2, $1) }
	|	TE_LIKE TE_CURRENT
			{ $$ := ast_factory.new_like_current_as ($2, $1, Void) }
	|	TE_BANG TE_LIKE TE_CURRENT
			{ $$ := ast_factory.new_like_current_as ($3, $2, $1) }
	|	TE_QUESTION TE_LIKE TE_CURRENT
			{ $$ := ast_factory.new_like_current_as ($3, $2, $1) }
	;

Class_or_tuple_type: Class_type
			{ $$ := $1 }
	| Tuple_type
			{ $$ := $1 }
	;

Attached_class_type: Class_identifier Generics_opt
			{ $$ := new_class_type ($1, $2, Void) }
	;

Class_type: Attached_class_type
			{ $$ := $1 }
	| TE_BANG Class_identifier Generics_opt
			{ $$ := new_class_type ($2, $3, $1) }
	| TE_QUESTION Class_identifier Generics_opt
			{ $$ := new_class_type ($2, $3, $1) }
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
				$$ := $2
				if $$ /= Void then
					$$.set_positions ($1, $3)
				end
			}
	|	TE_LSQURE TE_RSQURE
			{
				$$ := ast_factory.new_eiffel_list_type (0)
				if $$ /= Void then
					$$.set_positions ($1, $2)
				end	
			}
	;

Type_list: Add_counter Type_list_impl Remove_counter
		{ $$ := $2 }
	;

Type_list_impl: Type
			{
				$$ := ast_factory.new_eiffel_list_type (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Type TE_COMMA Increment_counter Type_list_impl
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
					ast_factory.reverse_extend_separator ($$, $2)
				end
			}
	;

Tuple_type: TE_TUPLE
			{ $$ := ast_factory.new_class_type_as ($1, Void, Void) }
	|	TE_TUPLE Add_counter Add_counter2 TE_LSQURE TE_RSQURE
			{
			  	last_type_list := ast_factory.new_eiffel_list_type (0)
				if last_type_list /= Void then
					last_type_list.set_positions ($4, $5)
				end
				$$ := ast_factory.new_class_type_as ($1, last_type_list, Void)
				last_type_list := Void
				remove_counter
				remove_counter2
			}
	|	TE_TUPLE Add_counter Add_counter2 TE_LSQURE Actual_parameter_list
			{
				if $5 /= Void then
					$5.set_positions ($4, last_rsqure.item)
				end
				$$ := ast_factory.new_class_type_as ($1, $5, Void)
				last_rsqure.remove
				remove_counter
				remove_counter2
			}
	|	TE_TUPLE Add_counter Add_counter2 TE_LSQURE Named_parameter_list
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
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
				last_rsqure.force ($2)
			}
	|	TE_ID TE_COMMA Increment_counter Actual_parameter_list		
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$1.to_upper		
					$$.reverse_extend (new_class_type ($1, Void, Void))
					ast_factory.reverse_extend_separator ($$, $2)
				end
			}
	|	Type_no_id TE_COMMA Increment_counter Actual_Parameter_List
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
					ast_factory.reverse_extend_separator ($$, $2)
				end
			}
	;
	
Named_parameter_list: TE_ID TE_COLON Type TE_RSQURE
			{
				$$ := ast_factory.new_eiffel_list_type_dec_as (counter2_value + 1)
				last_identifier_list := ast_factory.new_identifier_list (counter_value + 1)
				
				if $$ /= Void and last_identifier_list /= Void and $1 /= Void then
					$1.to_lower		
					last_identifier_list.reverse_extend ($1.name_id)
					ast_factory.reverse_extend_identifier (last_identifier_list.id_list, $1)
					$$.reverse_extend (ast_factory.new_type_dec_as (last_identifier_list, $3, $2))
				end
				last_identifier_list := Void     
				last_rsqure.force ($4)
			}
	|	TE_ID TE_COMMA Increment_counter Named_parameter_list

			{
				$$ := $4
				if $$ /= Void and then not $$.is_empty then
					last_identifier_list := $$.reversed_first.id_list
					if last_identifier_list /= Void then
						$1.to_lower		
						last_identifier_list.reverse_extend ($1.name_id)
						ast_factory.reverse_extend_identifier (last_identifier_list.id_list, $1)
						ast_factory.reverse_extend_separator (last_identifier_list.id_list, $2)
					end
					last_identifier_list := Void     
				end
			}
	|	TE_ID TE_COLON Type ASemi Increment_counter2 Add_counter Named_parameter_list
			{
				remove_counter
				$$ := $7
				last_identifier_list := ast_factory.new_identifier_list (counter_value + 1)
				
				if $$ /= Void and $1 /= Void and $3 /= Void and last_identifier_list /= Void then
					$1.to_lower		
					last_identifier_list.reverse_extend ($1.name_id)
					ast_factory.reverse_extend_identifier (last_identifier_list.id_list, $1)
					$$.reverse_extend (ast_factory.new_type_dec_as (last_identifier_list, $3, $2))
				end
				last_identifier_list := Void
			}
	;
			

-- Formal generics

Formal_generics:
			{
				-- $$ := Void
				formal_generics_end_position := 0
			}
	|	TE_LSQURE TE_RSQURE
			{
				formal_generics_end_position := position
				$$ := ast_factory.new_eiffel_list_formal_dec_as (0)
				if $$ /= Void then
					$$.set_squre_symbols ($1, $2)
				end
			}
	|	TE_LSQURE Add_counter Disable_supplier_recording Formal_generic_list Enable_supplier_recording Remove_counter TE_RSQURE
			{
				formal_generics_end_position := position
				$$ := $4
				if $$ /= Void then
					$$.transform_class_types_to_formals_and_record_suppliers (ast_factory, suppliers, formal_parameters)
					$$.set_squre_symbols ($1, $7)
				end
			}
	;

Formal_generic_list: Formal_generic
			{
				$$ := ast_factory.new_eiffel_list_formal_dec_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Formal_generic TE_COMMA Increment_counter Formal_generic_list
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
					ast_factory.reverse_extend_separator ($$, $2)
				end
			}
	;

Formal_parameter: TE_REFERENCE Class_identifier
			{
				if $2 /= Void and then none_class_name_id = $2.name_id then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$2' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					$$ := ast_factory.new_formal_as ($2, True, False, $1)
				end
			}
	| TE_EXPANDED Class_identifier
			{
				if $2 /= Void and then none_class_name_id = $2.name_id then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$2' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					$$ := ast_factory.new_formal_as ($2, False, True, $1)
				end
			}

	|	Class_identifier
			{
				if $1 /= Void and then none_class_name_id = $1.name_id then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$1' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					$$ := ast_factory.new_formal_as ($1, False, False, Void)
				end
			}
	;

Formal_generic: Formal_parameter
			{
				if $1 /= Void then
						-- Needs to be done here, in case current formal is used in
						-- Constraint.
					formal_parameters.extend ($1)
					$1.set_position (formal_parameters.count)
				end
			}
			Constraint
			{
				if $3 /= Void then
					if $3.creation_constrain /= Void then
						$$ := ast_factory.new_formal_dec_as ($1, $3.type, $3.creation_constrain.feature_list, $3.constrain_symbol, $3.creation_constrain.create_keyword, $3.creation_constrain.end_keyword)
					else
						$$ := ast_factory.new_formal_dec_as ($1, $3.type, Void, $3.constrain_symbol, Void, Void)				
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
				if $2 /= Void then
					constraining_type_list := ast_factory.new_eiffel_list_constraining_type_as (1)
					constraining_type_list.reverse_extend ($2)
				else
					constraining_type_list := Void
				end

				$$ := ast_factory.new_constraint_triple ($1, constraining_type_list, $3)
			}
	|	TE_CONSTRAIN TE_LCURLY Add_counter Multiple_constraint_list Remove_counter TE_RCURLY Creation_constraint
			{
				$$ := ast_factory.new_constraint_triple ($1, $4, $7)
			}
	;

Single_constraint: -- Empty
			-- { $$ := Void }
	| Constraint_type {is_constraint_renaming := True} Rename  {is_constraint_renaming := False}  TE_END
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
			{ $$ := $1 }
	|	TE_LIKE Identifier_as_lower
			{
				report_one_error (ast_factory.new_vtgc1_error (token_line ($1), token_column ($1), filename, $2, Void))
			}
	|	TE_LIKE TE_CURRENT
			{
				report_one_error (ast_factory.new_vtgc1_error (token_line ($1), token_column ($1), filename, Void, $2))
			}
	;

Multiple_constraint_list:	Single_constraint
			{
					-- Special list treatment here as we do not want Void
					-- element in `Assertion_list'.
				if $1 /= Void then
					$$ := ast_factory.new_eiffel_list_constraining_type_as (counter_value + 1)
					if $$ /= Void then
						$$.reverse_extend ($1)
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
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
					ast_factory.reverse_extend_separator ($$, $2)
				end
			}
	;

Creation_constraint: -- Empty
			-- { $$ := Void }
	|	TE_CREATE Feature_list TE_END
			{
				$$ := ast_factory.new_creation_constrain_triple ($2, $1, $3)
			}
	;


-- Instructions


Conditional: TE_IF Expression TE_THEN Compound TE_END
			{ $$ := ast_factory.new_if_as ($2, $4, Void, Void, $5, $1, $3, Void) }
	|	TE_IF Expression TE_THEN Compound Else_part TE_END
			{
				if $5 /= Void then
					$$ := ast_factory.new_if_as ($2, $4, Void, $5.second, $6, $1, $3, $5.first)
				else
					$$ := ast_factory.new_if_as ($2, $4, Void, Void, $6, $1, $3, Void)

				end
			}
	|	TE_IF Expression TE_THEN Compound Elseif_list TE_END
			{ $$ := ast_factory.new_if_as ($2, $4, $5, Void, $6, $1, $3, Void) }
	|	TE_IF Expression TE_THEN Compound Elseif_list Else_part TE_END
			{
				if $6 /= Void then
					$$ := ast_factory.new_if_as ($2, $4, $5, $6.second, $7, $1, $3, $6.first)
				else
					$$ := ast_factory.new_if_as ($2, $4, $5, Void, $7, $1, $3, Void)
				end
			}
	;

Elseif_list: Add_counter Elseif_part_list Remove_counter
		{ $$ := $2 }
	;

Elseif_part_list: Elseif_part
			{
				$$ := ast_factory.new_eiffel_list_elseif_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Elseif_part Increment_counter Elseif_part_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

Elseif_part: TE_ELSEIF Expression TE_THEN Compound
			{ $$ := ast_factory.new_elseif_as ($2, $4, $1, $3) }
	;

Else_part: TE_ELSE Compound
			{ $$ := ast_factory.new_keyword_instruction_list_pair ($1, $2) }
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
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	When_part Increment_counter When_part_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

When_part: TE_WHEN Add_counter Choices Remove_counter TE_THEN Compound
			{ $$ := ast_factory.new_case_as ($3, $6, $1, $5) }
	;

Choices: Choice
			{
				$$ := ast_factory.new_eiffel_list_interval_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Choice TE_COMMA Increment_counter Choices
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
					ast_factory.reverse_extend_separator ($$, $2)
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

Loop: TE_FROM Compound Invariant Variant TE_UNTIL Expression TE_LOOP Compound TE_END
			{
				if $3 /= Void then
					$$ := ast_factory.new_loop_as ($2, $3.second, $4, $6, $8, $9, $1, $3.first, $5, $7)
				else
					$$ := ast_factory.new_loop_as ($2, Void, $4, $6, $8, $9, $1, Void, $5, $7)
				end
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
				$$ := ast_factory.new_invariant_as ($3, once_manifest_string_count, $1, object_test_locals)
				once_manifest_string_count := 0
				object_test_locals := Void
			}
	;

Variant: -- Empty
			-- { $$ := Void }
	|	TE_VARIANT Identifier_as_lower TE_COLON Expression
			{ $$ := ast_factory.new_variant_as ($2, $4, $1, $3) }
	|	TE_VARIANT Expression
			{ $$ := ast_factory.new_variant_as (Void, $2, $1, Void) }
	;

Debug: TE_DEBUG Debug_keys Compound TE_END
			{ $$ := ast_factory.new_debug_as ($2, $3, $1, $4) }
	;

Debug_keys: -- Empty
			-- { $$ := Void }
	|	TE_LPARAN TE_RPARAN
		{ $$ := ast_factory.new_debug_key_list_as (Void, $1, $2) }
	|	TE_LPARAN Add_counter String_list Remove_counter TE_RPARAN
			{ $$ := ast_factory.new_debug_key_list_as ($3, $1, $5) }
	;

String_list: Non_empty_string
			{
				$$ := ast_factory.new_eiffel_list_string_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Non_empty_string TE_COMMA Increment_counter String_list
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
					ast_factory.reverse_extend_separator ($$, $2)
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

Qualified_expression:
		Qualified_binary_expression
			{ $$ := $1 }
	|	Qualified_factor
			{ $$ := $1 }
	|	Qualified_call
			{ $$ := ast_factory.new_expr_call_as ($1) }
	|	A_static_call
			{ $$ := $1 }
	;

Assigner_call: Qualified_expression TE_ASSIGNMENT Expression
			{ $$ := ast_factory.new_assigner_call_as ($1, $3, $2) }
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
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Creation_clause Increment_counter Creation_clause_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
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
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
						once "Use keyword `create' instead."))
				end
			}
	|	TE_CREATION Clients Feature_list
			{
				$$ := ast_factory.new_create_as ($2, $3, $1)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
						once "Use keyword `create' instead."))
				end
			}
	|	TE_CREATION Client_list
			{
				$$ := ast_factory.new_create_as (ast_factory.new_client_as ($2), Void, $1)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
						once "Use keyword `create' instead."))
				end
			}
	;

Agent_call: 
		TE_AGENT Optional_formal_arguments Type_mark {add_feature_frame} Optional_attribute_or_routine {remove_feature_frame} Delayed_actuals
		{
			if $3 /= Void then
				last_type := $3.second
				last_symbol := $3.first
			else
				last_type := Void
				last_symbol := Void
			end
			
			$$ := ast_factory.new_inline_agent_creation_as (
				ast_factory.new_body_as ($2, last_type, Void, $5, last_symbol, Void, Void, Void), $7, $1)
		}
	|	
		TE_AGENT Feature_name_for_call Delayed_actuals
		{
			$$ := ast_factory.new_agent_routine_creation_as (
				Void, $2, $3, False, $1, Void)
		}
	|	
		TE_AGENT Agent_target TE_DOT Feature_name_for_call Delayed_actuals
		{
			if $2 /= Void then
				$$ := ast_factory.new_agent_routine_creation_as ($2.operand, $4, $5, True, $1, $3)
				if $$ /= Void then
					$$.set_lparan_symbol ($2.lparan_symbol)
					$$.set_rparan_symbol ($2.rparan_symbol)
				end
			else
				$$ := ast_factory.new_agent_routine_creation_as (Void, $4, $5, True, $1, $3)
			end
		}
	|	Tilda_agent_call
		{
			if $1 /= Void then
				$$ := $1.first
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (token_line ($1.first), token_column ($1.first),
						filename, once "Use keyword `agent' instead."))
				end
			end
		}
	;
	
Optional_formal_arguments:
	|	Formal_arguments
		{
			$$ := $1
		}
	;
	
Type_mark:
	|	TE_COLON Type
		{
			create $$.make ($1, $2)
		}
	;

Optional_attribute_or_routine:
		Routine
		{
			$$ := $1
		}
	;

--Note: Manu 02/07/2004: we need to expand `Agent_target' otherwise it causes some
-- Reduce/Reduce conflict. `Tilda_agent_call' should be written as:
--Tilda_agent_call:	TE_TILDE Identifier_as_lower Delayed_actuals
--		{ $$ := ast_factory.new_old_routine_creation_as ($2, ast_factory.new_operand_as (Void, Void, Void), $2, $3, False) }
--	|	Agent_targt TE_TILDE Identifier_as_lower Delayed_actuals
--		{ $$ := ast_factory.new_old_routine_creation_as ($3, $1, $3, $4, True) }
--	;
Tilda_agent_call: TE_TILDE Identifier_as_lower Delayed_actuals
		{
			$$ := ast_factory.new_old_routine_creation_as ($2, Void, $2, $3, False, $1)
		}
	|	Identifier_as_lower TE_TILDE Identifier_as_lower Delayed_actuals
		{
			$$ := ast_factory.new_old_routine_creation_as ($1, ast_factory.new_operand_as (Void, ast_factory.new_access_id_as ($1, Void), Void), $3, $4, True, $2)
		}
	|	TE_LPARAN Expression TE_RPARAN TE_TILDE Identifier_as_lower Delayed_actuals
		{
			$$ := ast_factory.new_old_routine_creation_as ($2, ast_factory.new_operand_as (Void, Void, $2), $5, $6, True, $4)
			if $$ /= Void and then $$.first /= Void	then
				$$.first.set_lparan_symbol ($1)
				$$.first.set_rparan_symbol ($3)
			end
		}
	|	TE_RESULT TE_TILDE Identifier_as_lower Delayed_actuals
		{
			$$ := ast_factory.new_old_routine_creation_as ($3, ast_factory.new_operand_as (Void, $1, Void), $3, $4, True, $2)
		}
	|	TE_CURRENT TE_TILDE Identifier_as_lower Delayed_actuals
		{
			$$ := ast_factory.new_old_routine_creation_as ($3, ast_factory.new_operand_as (Void, $1, Void), $3, $4, True, $2)
		}
	|	TE_LCURLY Type TE_CURLYTILDE Identifier_as_lower Delayed_actuals
		{
			if $2 /= Void then
				$2.set_lcurly_symbol ($1)
			end
			$$ := ast_factory.new_old_routine_creation_as ($2, ast_factory.new_operand_as ($2, Void, Void), $4, $5, True, $3)
		}
	|	TE_QUESTION TE_TILDE Identifier_as_lower Delayed_actuals
		{
			temp_operand_as := ast_factory.new_operand_as (Void, Void, Void)
			if temp_operand_as /= Void then
				temp_operand_as.set_question_mark_symbol ($1)
			end
			$$ := ast_factory.new_old_routine_creation_as ($3, temp_operand_as, $3, $4, True, $2)
		}
	;

Agent_target: Identifier_as_lower
		{ $$ := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, ast_factory.new_access_id_as ($1, Void), Void)) }
	|	TE_LPARAN Add_counter Add_counter Expression Remove_counter Remove_counter TE_RPARAN
		{ $$ := ast_factory.new_agent_target_triple ($1, $7, ast_factory.new_operand_as (Void, Void, $4)) }	
	|	TE_RESULT
		{ $$ := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, $1, Void)) }
	|	TE_CURRENT
		{ $$ := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, $1, Void)) }
	|	Typed
		{ $$ := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as ($1, Void, Void))}
	|	TE_QUESTION
		{
			temp_operand_as := ast_factory.new_operand_as (Void, Void, Void)
			if temp_operand_as /= Void then
				temp_operand_as.set_question_mark_symbol ($1)
			end
			$$ := ast_factory.new_agent_target_triple (Void, Void, temp_operand_as)
		}
	;

Delayed_actuals: -- Empty
			-- { $$ := Void }
	|	TE_LPARAN TE_RPARAN
			{ $$ := ast_factory.new_delayed_actual_list_as (Void, $1, $2) }
	|	TE_LPARAN Add_counter Delayed_actual_list Remove_counter TE_RPARAN
			{ $$ := ast_factory.new_delayed_actual_list_as ($3, $1, $5) }
	;

Delayed_actual_list: Delayed_actual
			{
				$$ := ast_factory.new_eiffel_list_operand_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Delayed_actual TE_COMMA Increment_counter Delayed_actual_list
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
					ast_factory.reverse_extend_separator ($$, $2)
				end
			}
	;

Delayed_actual: TE_QUESTION
			{ $$ := ast_factory.new_operand_as (Void, Void, Void)
				if $$ /= Void then
					$$.set_question_mark_symbol ($1)
				end
			}
-- Manu: 01/19/2005: Due to syntax ambiguity we cannot have `Typed' only
-- as there will be no way to distinguish it from a Manifest type expression.
-- To preserve this feature in case it is needed by some of our customers
-- we have invented the new syntax ? Typed.
	|	Typed TE_QUESTION
			{ $$ := ast_factory.new_operand_as ($1, Void, Void)
				if $$ /= Void then
					$$.set_question_mark_symbol ($2)
				end
			}
	|	Expression
			{ $$ := ast_factory.new_operand_as (Void, Void, $1) }
	;

Creation: TE_BANG TE_BANG Creation_target Creation_call
			{
				$$ := ast_factory.new_bang_creation_as (Void, $3, $4, $1, $2)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1),
						filename, "Use keyword `create' instead."))
				end
			}
	|	TE_BANG Attached_type TE_BANG Creation_target Creation_call
			{
				$$ := ast_factory.new_bang_creation_as ($2, $4, $5, $1, $3)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1),
						filename, "Use keyword `create' instead."))
				end
			}
	|	TE_CREATE Creation_target Creation_call
			{ $$ := ast_factory.new_create_creation_as (Void, $2, $3, $1) }
	|	TE_CREATE Typed Creation_target Creation_call
			{ $$ := ast_factory.new_create_creation_as ($2, $3, $4, $1) }
	;

Creation_expression: TE_CREATE Typed Creation_call
			{ $$ := ast_factory.new_create_creation_expr_as ($2, $3, $1) }
	|	TE_BANG Attached_type TE_BANG Creation_call
			{
				$$ := ast_factory.new_bang_creation_expr_as ($2, $4, $1, $3)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1),
						filename, "Use keyword `create' instead."))
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

Check: TE_CHECK Assertion TE_END
			{ $$ := ast_factory.new_check_as ($2, $1, $3) }
	;


-- Expression

Typed: TE_LCURLY Type TE_RCURLY
			{ $$ := $2
				if $$ /= Void then
					$$.set_lcurly_symbol ($1)
					$$.set_rcurly_symbol ($3)
				end
			}
	;

Expression:
		Nosigned_integer
			{ $$ := $1; has_type := True }
	|	Nosigned_real
			{ $$ := $1; has_type := True }
	|	Factor
			{ $$ := $1 }
	|	Typed_expression
			{ $$ := $1; has_type := True }
-- To uncomment when Tilda_agent_call are really removed from parser
--	|	Expression TE_TILDE Expression
--			{ $$ := ast_factory.new_bin_tilde_as ($1, $3, $2); has_type := True }
--	|	Expression TE_NOT_TILDE Expression
--			{ $$ := ast_factory.new_bin_not_tilde_as ($1, $3, $2); has_type := True }
	|	Expression TE_EQ Expression
			{ $$ := ast_factory.new_bin_eq_as ($1, $3, $2); has_type := True }
	|	Expression TE_NE Expression
			{ $$ := ast_factory.new_bin_ne_as ($1, $3, $2); has_type := True }
	|	Qualified_binary_expression
			{ $$ := $1; has_type := True }
	|	TE_LCURLY TE_ID TE_COLON Type TE_RCURLY Expression %prec TE_NOT
			{
				$$ := ast_factory.new_object_test_as ($1, $2, $4, $6);
				has_type := True
				if object_test_locals = Void then
					create object_test_locals.make (1)
				end
				object_test_locals.extend ([$2, $4])
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
	|	Expression TE_AND TE_THEN Expression %prec TE_AND
			{ $$ := ast_factory.new_bin_and_then_as ($1, $4, $2, $3) }
	|	Expression TE_OR Expression
			{ $$ := ast_factory.new_bin_or_as ($1, $3, $2) }
	|	Expression TE_OR TE_ELSE Expression %prec TE_OR
			{ $$ := ast_factory.new_bin_or_else_as ($1, $4,$2, $3) }
	|	Expression TE_IMPLIES Expression
			{ $$ := ast_factory.new_bin_implies_as ($1, $3, $2) }
	|	Expression TE_XOR Expression
			{ $$ := ast_factory.new_bin_xor_as ($1, $3, $2) }
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
			{ $$ := $1; has_type := True }
	|	Manifest_array
			{ $$ := $1; has_type := True }
	|	Agent_call
			{ $$ := $1; has_type := False }
	|	TE_OLD Expression
			{ $$ := ast_factory.new_un_old_as ($2, $1); has_type := True }
	|	TE_STRIP TE_LPARAN Strip_identifier_list TE_RPARAN
			{
				$$ := ast_factory.new_un_strip_as ($3, $1, $2, $4); has_type := True
			}
	|	TE_ADDRESS Feature_name
			{ $$ := ast_factory.new_address_as ($2, $1); has_type := True }
	|	TE_ADDRESS TE_LPARAN Expression TE_RPARAN
			{
				$$ := ast_factory.new_expr_address_as ($3, $1, $2, $4); has_type := True
			}
	|	TE_ADDRESS TE_CURRENT
			{
				$$ := ast_factory.new_address_current_as ($2, $1); has_type := True
			}
	|	TE_ADDRESS TE_RESULT
			{
				$$ := ast_factory.new_address_result_as ($2, $1); has_type := True
			}
	|	Bracket_target
			{ $$ := $1 }
	|	Qualified_factor
			{ $$ := $1; has_type := True }
	;

Qualified_factor:
		Bracket_target TE_LSQURE Add_counter Expression_list Remove_counter TE_RSQURE
			{ $$ := ast_factory.new_bracket_as ($1, $4, $2, $6) }
	|	TE_MINUS Factor
			{ $$ := ast_factory.new_un_minus_as ($2, $1) }
	|	TE_PLUS Factor
			{ $$ := ast_factory.new_un_plus_as ($2, $1) }
	|	TE_NOT Expression
			{ $$ := ast_factory.new_un_not_as ($2, $1) }
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
				if $1 /= Void then
					$1.to_lower
				end
				$$ := $1
			}
	;


-- Expression call

Qualified_call:
		TE_CURRENT TE_DOT Remote_call
			{ $$ := ast_factory.new_nested_as ($1, $3, $2) }
	|	TE_RESULT TE_DOT Remote_call
			{ $$ := ast_factory.new_nested_as ($1, $3, $2) }
	|	A_feature TE_DOT Remote_call
			{ $$ := ast_factory.new_nested_as ($1, $3, $2) }
	|	TE_LPARAN Expression TE_RPARAN TE_DOT Remote_call
			{ $$ := ast_factory.new_nested_expr_as ($2, $5, $4, $1, $3) }
	|	Bracket_target TE_LSQURE Add_counter Expression_list Remove_counter TE_RSQURE TE_DOT Remote_call
			{ $$ := ast_factory.new_nested_expr_as (ast_factory.new_bracket_as ($1, $4, $2, $6), $8, $7, Void, Void) }
	|	A_precursor TE_DOT Remote_call
			{ $$ := ast_factory.new_nested_as ($1, $3, $2) }
	|	A_static_call TE_DOT Remote_call
			{ $$ := ast_factory.new_nested_as ($1, $3, $2) }
	;

A_precursor: TE_PRECURSOR Parameters
			{ $$ := ast_factory.new_precursor_as ($1, Void, $2) }
	|	TE_PRECURSOR TE_LCURLY Class_identifier TE_RCURLY Parameters
			{
				temp_class_type_as := ast_factory.new_class_type_as ($3, Void, Void)
				if temp_class_type_as /= Void then
					temp_class_type_as.set_lcurly_symbol ($2)
					temp_class_type_as.set_rcurly_symbol ($4)
				end
				$$ := ast_factory.new_precursor_as ($1, temp_class_type_as, $5)
			}
	;

A_static_call: New_a_static_call
			{ $$ := $1 }
	|	Old_a_static_call
			{ $$ := $1 }
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
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1),
							filename, once "Remove the `feature' keyword."))
				end
			}
	;

Remote_call: Call_on_feature_access
			{ $$ := $1 }
	|	Feature_access
			{ $$ := $1 }
	;

Call_on_feature_access: Feature_access TE_DOT Feature_access
			{ $$ := ast_factory.new_nested_as ($1, $3, $2) }
	|	Feature_access TE_DOT Call_on_feature_access
			{ $$ := ast_factory.new_nested_as ($1, $3, $2) }
	;

Feature_name_for_call: Identifier_as_lower
			{ $$ := $1}
	|	Infix
			{
				if $1 /= Void then
					$$ := $1.internal_name
				end
			}
	|	Prefix
			{
				if $1 /= Void then
					$$ := $1.internal_name
				end
			}
	;

A_feature: Feature_name_for_call Parameters
			{
				inspect id_level
				when Normal_level then
					$$ := ast_factory.new_access_id_as ($1, $2)
				when Assert_level then
					$$ := ast_factory.new_access_assert_as ($1, $2)
				when Invariant_level then
					$$ := ast_factory.new_access_inv_as ($1, $2, Void)
				end
			}
	;

Feature_access: Feature_name_for_call Parameters
			{ $$ := ast_factory.new_access_feat_as ($1, $2) }
	;

Bracket_target:
		Expression_constant
			{ $$ := $1; has_type := True }
	|	Manifest_tuple
			{ $$ := $1; has_type := True }
	|	TE_CURRENT
			{ $$ := ast_factory.new_expr_call_as ($1); has_type := True }
	|	TE_RESULT
			{ $$ := ast_factory.new_expr_call_as ($1); has_type := True }
	|	Call
			{ $$ := ast_factory.new_expr_call_as ($1); has_type := False }
	|	Creation_expression
			{ $$ := ast_factory.new_expr_call_as ($1); has_type := True }
	|	TE_LPARAN Expression TE_RPARAN
			{ $$ := ast_factory.new_paran_as ($2, $1, $3); has_type := True }
	;

Parameters: -- Empty
			-- { $$ := Void }
	|	TE_LPARAN TE_RPARAN
			{ $$ := ast_factory.new_parameter_list_as (Void, $1, $2) }
	|	TE_LPARAN Add_counter Expression_list Remove_counter TE_RPARAN
			{ $$ := ast_factory.new_parameter_list_as ($3, $1, $5) }
	;

Expression_list: Expression
			{
				$$ := ast_factory.new_eiffel_list_expr_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Expression TE_COMMA Increment_counter Expression_list
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
					ast_factory.reverse_extend_separator ($$, $2)
				end
			}
	;

Class_or_tuple_identifier: TE_TUPLE
			{
				if $1 /= Void then
					$1.to_upper
				end
				$$ := $1
			}
	|	Class_identifier
			{
				$$ := $1;
			}
	;

Class_identifier: TE_ID
			{
				if $1 /= Void then
					$1.to_upper		
				end
				$$ := $1
			}
	|	TE_ASSIGN
			{
					-- Keyword used as identifier
				process_id_as_with_existing_stub (last_keyword_as_id_index)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
							once "Use of `assign', possibly a new keyword in future definition of `Eiffel'."))
				end

				if last_id_as_value /= Void then
					last_id_as_value.to_upper
				end
				$$ := last_id_as_value
			}
	;

Identifier_as_lower: TE_ID
			{
				if $1 /= Void then
					$1.to_lower
				end
				$$ := $1
			}
	|	TE_TUPLE
			{
				if $1 /= Void then
					$1.to_lower
				end
				$$ := $1
			}
	|	TE_ASSIGN
			{
					-- Keyword used as identifier
				process_id_as_with_existing_stub (last_keyword_as_id_index)
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (token_line ($1), token_column ($1), filename,
							once "Use of `assign', possibly a new keyword in future definition of `Eiffel'."))
				end
				if last_id_as_value /= Void then
					last_id_as_value.to_lower
				end
				$$ := last_id_as_value
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
	|	Bit_constant
			{ $$ := $1 }
	|	Manifest_string
			{ $$ := $1 }
	|	TE_ONCE_STRING Manifest_string
			{
				if $2 /= Void then
					$2.set_is_once_string (True)
					$2.set_once_string_keyword ($1)
				end
				once_manifest_string_count := once_manifest_string_count + 1
				$$ := $2
			}
	;

Boolean_constant: TE_FALSE
			{ $$ := $1 }
	|	TE_TRUE
			{ $$ := $1 }
	;

Character_constant: TE_CHAR
			{
				check is_character: not token_buffer.is_empty end
				
				$$ := ast_factory.new_character_value (Current, Void, token_buffer, token_buffer2)

			}
	|	Typed TE_CHAR
			{
				check is_character: not token_buffer.is_empty end
				fixme (once "We should handle `Type' instead of ignoring it.")

				$$ := ast_factory.new_character_value (Current, $1, token_buffer, token_buffer2)
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
--# Bit constants
--###################################################################
Bit_constant: TE_A_BIT
			{ $$ := ast_factory.new_bit_const_as ($1) }
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
			{
				$$ := ast_factory.new_string_as ("", line, column, string_position, position + text_count - string_position, token_buffer2)
			}
	|	TE_EMPTY_VERBATIM_STRING
			{
				$$ := ast_factory.new_verbatim_string_as ("", verbatim_marker.substring (2, verbatim_marker.count), not has_old_verbatim_strings and then verbatim_marker.item (1) = ']', line, column, string_position, position + text_count - string_position, token_buffer2)
			}
	;

Typed_manifest_string: TE_RCURLY Type TE_RCURLY Default_manifest_string
			{
				fixme (once "We should handle `Type' instead of ignoring it.")
				$$ := $4
				if $2 /= Void then
					$2.set_lcurly_symbol ($1)
					$2.set_rcurly_symbol ($3)
				end
				if $$ /= Void then
					$$.set_type ($2)
				end
			}
	;

Non_empty_string: TE_STRING
			{
				$$ := ast_factory.new_string_as (cloned_string (token_buffer), line, column, string_position, position + text_count - string_position, token_buffer2)
			}
	|	TE_VERBATIM_STRING
			{
				$$ := ast_factory.new_verbatim_string_as (cloned_string (token_buffer), verbatim_marker.substring (2, verbatim_marker.count), not has_old_verbatim_strings and then verbatim_marker.item (1) = ']', line, column, string_position, position + text_count - string_position, token_buffer2)
			}
	|	TE_STR_LT
			{
				$$ := ast_factory.new_string_as ("<", line, column, position, 3, token_buffer2)
			}
	|	TE_STR_LE
			{
				$$ := ast_factory.new_string_as ("<=", line, column, position, 4, token_buffer2)
			}
	|	TE_STR_GT
			{
				$$ := ast_factory.new_string_as (">", line, column, position, 3, token_buffer2)
			}
	|	TE_STR_GE
			{
				$$ := ast_factory.new_string_as (">=", line, column, position, 4, token_buffer2)
			}
	|	TE_STR_MINUS
			{
				$$ := ast_factory.new_string_as ("-", line, column, position, 3, token_buffer2)
			}
	|	TE_STR_PLUS
			{
				$$ := ast_factory.new_string_as ("+", line, column, position, 3, token_buffer2)
			}
	|	TE_STR_STAR
			{
				$$ := ast_factory.new_string_as ("*", line, column, position, 3, token_buffer2)
			}
	|	TE_STR_SLASH
			{
				$$ := ast_factory.new_string_as ("/", line, column, position, 3, token_buffer2)
			}
	|	TE_STR_MOD
			{
				$$ := ast_factory.new_string_as ("\\", line, column, position, 4, token_buffer2)
			}
	|	TE_STR_DIV
			{
				$$ := ast_factory.new_string_as ("//", line, column, position, 4, token_buffer2)
			}
	|	TE_STR_POWER
			{
				$$ := ast_factory.new_string_as ("^", line, column, position, 3, token_buffer2)
			}
	|	TE_STR_BRACKET
			{
				$$ := ast_factory.new_string_as ("[]", line, column, position, 4, token_buffer2)
			}
	|	TE_STR_AND
			{
				$$ := ast_factory.new_string_as (cloned_string (token_buffer), line, column, position, 5, token_buffer2)
			}
	|	TE_STR_AND_THEN
			{
				$$ := ast_factory.new_string_as (cloned_string (token_buffer), line, column, position, 10, token_buffer2)
			}
	|	TE_STR_IMPLIES
			{
				$$ := ast_factory.new_string_as (cloned_string (token_buffer), line, column, position, 9, token_buffer2)
			}
	|	TE_STR_OR
			{
				$$ := ast_factory.new_string_as (cloned_string (token_buffer), line, column, position, 4, token_buffer2)
			}
	|	TE_STR_OR_ELSE
			{
				$$ := ast_factory.new_string_as (cloned_string (token_buffer), line, column, position, 9, token_buffer2)
			}
	|	TE_STR_XOR
			{
				$$ := ast_factory.new_string_as (cloned_string (token_buffer), line, column, position, 5, token_buffer2)
			}
	|	TE_STR_NOT
			{
				$$ := ast_factory.new_string_as (cloned_string (token_buffer), line, column, position, 5, token_buffer2)
			}
	|	TE_STR_FREE
			{
				$$ := ast_factory.new_string_as (cloned_string (token_buffer), line, column, position, token_buffer.count + 2, token_buffer2)
			}
	;

Prefix_operator: TE_STR_MINUS
			{
				$$ := ast_factory.new_string_as ("-", line, column, position, 3, token_buffer2)
			}
	|	TE_STR_PLUS
			{
				$$ := ast_factory.new_string_as ("+", line, column, position, 3, token_buffer2)
			}
	|	TE_STR_NOT
			{
				$$ := ast_factory.new_string_as ("not", line, column, position, 5, token_buffer2)
			}
	|	TE_STR_FREE
			{
				$$ := ast_factory.new_string_as (cloned_lower_string (token_buffer), line, column, position, token_buffer.count + 2, token_buffer2)
			}
	;

Infix_operator: TE_STR_LT
			{
				$$ := ast_factory.new_string_as ("<", line, column, position, 3, token_buffer2)
			}
	|	TE_STR_LE
			{
				$$ := ast_factory.new_string_as ("<=", line, column, position, 4, token_buffer2)
			}
	|	TE_STR_GT
			{
				$$ := ast_factory.new_string_as (">", line, column, position, 3, token_buffer2)
			}
	|	TE_STR_GE
			{
				$$ := ast_factory.new_string_as (">=", line, column, position, 4, token_buffer2)
			}
	|	TE_STR_MINUS
			{
				$$ := ast_factory.new_string_as ("-", line, column, position, 3, token_buffer2)
			}
	|	TE_STR_PLUS
			{
				$$ := ast_factory.new_string_as ("+", line, column, position, 3, token_buffer2)
			}
	|	TE_STR_STAR
			{
				$$ := ast_factory.new_string_as ("*", line, column, position, 3, token_buffer2)
			}
	|	TE_STR_SLASH
			{
				$$ := ast_factory.new_string_as ("/", line, column, position, 3, token_buffer2)
			}
	|	TE_STR_MOD
			{
				$$ := ast_factory.new_string_as ("\\", line, column, position, 4, token_buffer2)
			}
	|	TE_STR_DIV
			{
				$$ := ast_factory.new_string_as ("//", line, column, position, 4, token_buffer2)
			}
	|	TE_STR_POWER
			{
				$$ := ast_factory.new_string_as ("^", line, column, position, 3, token_buffer2)
			}
	|	TE_STR_AND
			{
				$$ := ast_factory.new_string_as ("and", line, column, position, 5, token_buffer2)
			}
	|	TE_STR_AND_THEN
			{
				$$ := ast_factory.new_string_as ("and then", line, column, position, 10, token_buffer2)
			}
	|	TE_STR_IMPLIES
			{
				$$ := ast_factory.new_string_as ("implies", line, column, position, 9, token_buffer2)
			}
	|	TE_STR_OR
			{
				$$ := ast_factory.new_string_as ("or", line, column, position, 4, token_buffer2)
			}
	|	TE_STR_OR_ELSE
			{
				$$ := ast_factory.new_string_as ("or else", line, column, position, 9, token_buffer2)
			}
	|	TE_STR_XOR
			{
				$$ := ast_factory.new_string_as ("xor", line, column, position, 5, token_buffer2)
			}
	|	TE_STR_FREE
			{
				$$ := ast_factory.new_string_as (cloned_lower_string (token_buffer), line, column, position, token_buffer.count + 2, token_buffer2)
			}
				;

Manifest_array: TE_LARRAY TE_RARRAY
			{
				$$ := ast_factory.new_array_as (ast_factory.new_eiffel_list_expr_as (0), $1, $2)
			}
	|	TE_LARRAY Add_counter Expression_list Remove_counter TE_RARRAY
			{ $$ := ast_factory.new_array_as ($3, $1, $5) }
	;

Manifest_tuple: TE_LSQURE TE_RSQURE
			{ $$ := ast_factory.new_tuple_as (ast_factory.new_eiffel_list_expr_as (0), $1, $2) }
	|	TE_LSQURE Add_counter Expression_list Remove_counter TE_RSQURE
			{ $$ := ast_factory.new_tuple_as ($3, $1, $5) }
	;

Add_indexing_counter:
			{
				initial_has_old_verbatim_strings_warning := has_old_verbatim_strings_warning
				set_has_old_verbatim_strings_warning (false)
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

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EIFFEL_PARSER
