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

create
	make,
	make_with_factory
%}

%start		Eiffel_parser

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

%token <ID_AS> TE_FREE
%token		TE_ALIAS TE_ALL TE_INTEGER TE_CHAR TE_REAL TE_STRING
%token <ID_AS>		TE_ID TE_A_BIT
%token		TE_BANG TE_BIT TE_SEMICOLON TE_TILDE
%token		TE_COLON TE_COMMA TE_CREATE
%token <LOCATION_AS>	TE_CREATION
%token		TE_LARRAY TE_RARRAY TE_RPARAN
%token		TE_LCURLY TE_RCURLY TE_LSQURE TE_RSQURE TE_CONSTRAIN
%token <BOOL_AS> TE_FALSE TE_TRUE
%token		TE_ACCEPT TE_ADDRESS TE_AS TE_ASSIGN
%token		TE_CHECK TE_CLASS TE_CONVERT
%token <CURRENT_AS> TE_CURRENT
%token		TE_DEBUG
%token <DEFERRED_AS>	TE_DEFERRED
%token		TE_DO
%token		TE_ELSE TE_ELSEIF
%token <LOCATION_AS> TE_END
%token		TE_ENSURE TE_EXPANDED TE_EXPORT
%token		TE_EXTERNAL TE_FEATURE TE_FROM TE_FROZEN TE_IF TE_INDEXING
%token		TE_INFIX TE_INHERIT TE_INSPECT TE_INVARIANT TE_IS
%token		TE_LIKE TE_LOCAL TE_LOOP TE_OBSOLETE TE_ONCE TE_ONCE_STRING
%token <LOCATION_AS> TE_PRECURSOR
%token		TE_AGENT
%token		TE_PREFIX TE_REDEFINE TE_REFERENCE TE_RENAME TE_REQUIRE TE_RESCUE
%token <RESULT_AS>	TE_RESULT
%token <RETRY_AS>	TE_RETRY
%token		TE_SELECT TE_SEPARATE TE_THEN TE_UNDEFINE
%token <UNIQUE_AS>	TE_UNIQUE
%token		TE_UNTIL TE_VARIANT TE_WHEN TE_QUESTION TE_CURLYTILDE
%token		TE_EMPTY_STRING
%token		TE_VERBATIM_STRING TE_EMPTY_VERBATIM_STRING
%token <VOID_AS>	TE_VOID

%token		TE_STR_LT TE_STR_LE TE_STR_GT TE_STR_GE TE_STR_MINUS
%token		TE_STR_PLUS TE_STR_STAR TE_STR_SLASH TE_STR_MOD
%token		TE_STR_DIV TE_STR_POWER TE_STR_AND TE_STR_AND_THEN
%token		TE_STR_IMPLIES TE_STR_OR TE_STR_OR_ELSE TE_STR_XOR
%token		TE_STR_NOT TE_STR_FREE TE_STR_BRACKET

%type <ACCESS_AS>			Creation_target A_feature
%type <ACCESS_FEAT_AS>		Feature_access
%type <ACCESS_INV_AS>		Creation_call
%type <ARRAY_AS>			Manifest_array
%type <ASSIGN_AS>			Assignment
%type <ATOMIC_AS>			Index_value Manifest_constant Expression_constant
%type <BIT_CONST_AS>		Bit_constant
%type <BODY_AS>				Declaration_body
%type <BOOL_AS>				Boolean_constant
%type <CALL_AS>				Remote_call Expression_feature_call
%type <CASE_AS>				When_part
%type <CHAR_AS>				Character_constant
%type <CHECK_AS>			Check
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
%type <EXPR_AS>				Expression Factor Simple_factor Typed_expression
%type <EXTERNAL_AS>			External
%type <EXTERNAL_LANG_AS>	External_language
%type <FEATURE_AS>			Feature_declaration
%type <FEATURE_CLAUSE_AS>	Feature_clause
%type <FEATURE_SET_AS>		Feature_set
%type <FORMAL_AS>			Formal_parameter
%type <FORMAL_DEC_AS>		Formal_generic
%type <ID_AS>				Identifier_as_upper Identifier_as_lower Free_operator Feature_name_for_call
%type <IF_AS>				Conditional
%type <INDEX_AS>			Index_clause Index_clause_impl
%type <INSPECT_AS>			Multi_branch
%type <INSTR_CALL_AS>		Call
%type <INSTRUCTION_AS>		Instruction Instruction_impl
%type <INTEGER_AS>	Integer_constant Signed_integer Nosigned_integer Typed_integer Typed_nosigned_integer Typed_signed_integer
%type <INTERNAL_AS>			Internal
%type <INTERVAL_AS>			Choice
%type <INVARIANT_AS>		Class_invariant
%type <LOOP_AS>				Loop
%type <NESTED_AS>			Call_on_feature_access Call_on_precursor
							Call_on_feature Call_on_result Call_on_current Call_on_static Old_call_on_static New_call_on_static
%type <NESTED_EXPR_AS>		Call_on_expression
%type <OPERAND_AS>			Delayed_actual Agent_target
%type <PARENT_AS>			Parent Parent_clause
%type <PRECURSOR_AS>		A_precursor
%type <STATIC_ACCESS_AS>	A_static_call Old_a_static_call New_a_static_call
%type <REAL_AS>				Real_constant Signed_real Nosigned_real Typed_real Typed_nosigned_real Typed_signed_real
%type <RENAME_AS>			Rename_pair
%type <REQUIRE_AS>			Precondition
%type <REVERSE_AS>			Reverse_assignment
%type <ROUT_BODY_AS>		Routine_body
%type <ROUTINE_AS>			Routine
%type <ROUTINE_CREATION_AS>	Agent_call
%type <PAIR[ROUTINE_CREATION_AS, LOCATION_AS]> Tilda_agent_call
%type <STRING_AS>			Obsolete Manifest_string External_name Non_empty_string Default_manifest_string Typed_manifest_string Infix_operator Prefix_operator Alias Alias_name
%type <TAGGED_AS>			Assertion_clause
%type <TUPLE_AS>			Manifest_tuple
%type <TYPE_AS>				Type Class_type Creation_type Non_class_type Typed
%type <TYPE_DEC_AS>			Entity_declaration_group
%type <VARIANT_AS>			Variant
%type <FEATURE_NAME>		Infix Prefix Feature_name Extended_feature_name New_feature

%type <EIFFEL_LIST [ATOMIC_AS]>			Index_terms
%type <EIFFEL_LIST [CASE_AS]>			When_part_list_opt When_part_list
%type <EIFFEL_LIST [CONVERT_FEAT_AS]>	Convert_list Convert_clause
%type <EIFFEL_LIST [CREATE_AS]>			Creators Creation_clause_list
%type <EIFFEL_LIST [ELSIF_AS]>			Elseif_list Elseif_part_list
%type <EIFFEL_LIST [EXPORT_ITEM_AS]>	New_exports New_exports_opt New_export_list
%type <EIFFEL_LIST [EXPR_AS]>			Parameters Expression_list
%type <EIFFEL_LIST [FEATURE_AS]>		Feature_declaration_list
%type <EIFFEL_LIST [FEATURE_CLAUSE_AS]>	Features Feature_clause_list
%type <EIFFEL_LIST [FEATURE_NAME]>		Feature_list Feature_list_impl Undefine Undefine_opt
										Redefine
										Redefine_opt Select Select_opt Creation_constraint
										New_feature_list
%type <EIFFEL_LIST [FORMAL_DEC_AS]>		Formal_generics Formal_generic_list
%type <EIFFEL_LIST [ID_AS]>				Client_list Class_list 
%type <CONSTRUCT_LIST [INTEGER]>		Identifier_list Strip_identifier_list
%type <INDEXING_CLAUSE_AS>			Indexing Index_list Dotnet_indexing
%type <EIFFEL_LIST [INSTRUCTION_AS]>	Rescue Compound Instruction_list Else_part
%type <EIFFEL_LIST [INTERVAL_AS]>		Choices
%type <EIFFEL_LIST [OPERAND_AS]>		Delayed_actuals Delayed_actual_list
%type <EIFFEL_LIST [PARENT_AS]>			Inheritance Parent_list
%type <EIFFEL_LIST [RENAME_AS]>			Rename Rename_list
%type <EIFFEL_LIST [STRING_AS]>			Debug_keys String_list
%type <EIFFEL_LIST [TAGGED_AS]>			Assertion Assertion_list Invariant
%type <EIFFEL_LIST [TYPE_AS]>			Generics_opt Type_list Type_list_impl
%type <EIFFEL_LIST [TYPE_DEC_AS]>		Formal_arguments
										Entity_declaration_list Local_declarations

%type <PAIR [TYPE_AS, EIFFEL_LIST [FEATURE_NAME]]>	Constraint

%expect 98

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
				if type_parser or expression_parser or indexing_parser or entity_declaration_parser then
					raise_error
				end
			}
	|	Identifier_as_lower Type
			{
				if not type_parser or expression_parser or indexing_parser or entity_declaration_parser then
					raise_error
				end
				type_node := $2
			}
	|	TE_FEATURE Expression
			{
				if not expression_parser or type_parser or indexing_parser or entity_declaration_parser then
					raise_error
				end
				expression_node := $2
			}
	|	Indexing
			{
				if not indexing_parser or type_parser or expression_parser or entity_declaration_parser then
					raise_error
				end
				indexing_node := $1
			}
	|	TE_LOCAL { add_counter } Entity_declaration_list
			{
				if not entity_declaration_parser or type_parser or expression_parser or indexing_parser then
					raise_error
				end
				remove_counter
				entity_declaration_node := $3
			}
	;

Class_declaration:
		Indexing							-- $1
		Header_mark							-- $2
		TE_CLASS							-- $3
		Identifier_as_upper					-- $4
		Formal_generics						-- $5
		External_name						-- $6
		Obsolete							-- $7
		Inheritance	End_inheritance_pos		-- $8 $9
		Creators							-- $10
		Convert_clause						-- $11
		Features End_features_pos			-- $12 $13
		Class_invariant 					-- $14
		Indexing							-- $15
		TE_END								-- $16
			{
				root_node := new_class_description ($4, $6,
					is_deferred, is_expanded, is_separate, is_frozen_class, is_external_class,
					$1, $15, $5, $8, $10, $11, $12, $14, suppliers, $7, $16)
				if root_node /= Void then
					root_node.set_text_positions (
						formal_generics_end_position,
						inheritance_end_position,
						features_end_position)
				end
			}
	;

End_inheritance_pos: { inheritance_end_position := position } ;
End_features_pos: { features_end_position := position } ;

-- Indexing


Indexing: -- Empty
			-- { $$ := Void }
	|	TE_INDEXING
			{
				add_counter
				initial_has_old_verbatim_strings_warning := has_old_verbatim_strings_warning
				set_has_old_verbatim_strings_warning (false)
			}
		Index_list
			{
				$$ := $3
				remove_counter
				set_has_old_verbatim_strings_warning (initial_has_old_verbatim_strings_warning)
			}
	|	TE_INDEXING 
			-- { $$ := Void }
	;

Dotnet_indexing: -- Empty
			-- { $$ := Void }
	|	TE_INDEXING TE_END
		--	{ $$ := Void }
	|	TE_INDEXING
			{
				add_counter
				initial_has_old_verbatim_strings_warning := has_old_verbatim_strings_warning
				set_has_old_verbatim_strings_warning (false)
			}
		Index_list TE_END
			{
				$$ := $3
				remove_counter
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
	|	Index_clause { increment_counter } Index_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
					$$.update_lookup ($1)
				end
			}
	;

Index_clause: { add_counter } Index_clause_impl
		{
			$$ := $2
			remove_counter
		}
	;
			
Index_clause_impl: Identifier_as_lower TE_COLON Index_terms ASemi
			{
				$$ := ast_factory.new_index_as ($1, $3)
			}
	|	Index_terms ASemi
			{
				$$ := ast_factory.new_index_as (Void, $1)
				if has_syntax_warning and $1 /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make ($1.start_location.line,
						$1.start_location.column, filename,
						"Missing `Index' part of `Index_clause'."))
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
	|	Index_value { increment_counter } TE_COMMA Index_terms
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
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
	|	Creation_expression TE_END
			{ $$ := ast_factory.new_custom_attribute_as ($1, Void) }
	|	Creation_expression Manifest_tuple TE_END
			{ $$ := ast_factory.new_custom_attribute_as ($1, $2) }
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
					-- I'm adding a few comments line
					-- here because otherwise the generated
					-- parser is very different from the
					-- previous one, since line numbers are
					-- emitted.
				is_frozen_class := True
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
	|	{ add_counter } Feature_clause_list
			{
				$$ := $2
				if $$ /= Void and then $$.is_empty then
					$$ := Void
				end
				remove_counter
			}
	;

Feature_clause_list: Feature_clause
			{
				$$ := ast_factory.new_eiffel_list_feature_clause_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Feature_clause { increment_counter } Feature_clause_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

Feature_clause: Feature_client_clause
			{ $$ := ast_factory.new_feature_clause_as ($1,
				ast_factory.new_eiffel_list_feature_as (0), fclause_pos) }
	|	Feature_client_clause { add_counter } Feature_declaration_list
			{
				$$ := ast_factory.new_feature_clause_as ($1, $3, fclause_pos)
				remove_counter
			}
	;

Feature_client_clause: TE_FEATURE
			{
				fclause_pos := ast_factory.new_location_as (line, column, position, 8)
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
				$$ := ast_factory.new_eiffel_list_id_as (1)
				if $$ /= Void then
					$$.reverse_extend (new_none_id)
				end
			}
	|	TE_LCURLY { add_counter } Class_list TE_RCURLY
			{
				$$ := $3
				remove_counter
			}
	;

Class_list: Identifier_as_upper
			{
				$$ := ast_factory.new_eiffel_list_id_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Identifier_as_upper { increment_counter } TE_COMMA Class_list
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
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
	|	Feature_declaration { increment_counter} Feature_declaration_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

ASemi: -- Empty
	|	TE_SEMICOLON
	;

Feature_declaration: { add_counter } New_feature_list { remove_counter } Declaration_body Optional_semicolons
			{
					-- Generate a syntax error when `feature_indexes' is not
					-- Void and it applies to synonyms of the current feature
					-- declaration.
				if
					(il_parser and feature_indexes /= Void and
					($2 /= Void and then $2.count /= 1))
				then
					raise_error
				end
				$$ := ast_factory.new_feature_as ($2, $4, feature_indexes)
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
	|	New_feature { increment_counter } TE_COMMA New_feature_list
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

New_feature: Feature_name_mark Extended_feature_name
			{ $$ := $2 }
	;

Feature_name_mark: -- Empty
			{ is_frozen := False }
	|	TE_FROZEN
			{ is_frozen := True }
	;

Extended_feature_name: Feature_name
			{ $$ := $1 }
	|	Identifier_as_lower Alias
			{ $$ := ast_factory.new_feature_name_alias_as ($1, $2, is_frozen, has_convert_mark) }
	;

Feature_name: Identifier_as_lower
			{ $$ := ast_factory.new_feature_name_id_as ($1, is_frozen) }
	|	Infix
			{ $$ := $1 }
	|	Prefix
			{ $$ := $1 }
	;

Infix: TE_INFIX Infix_operator
			{ $$ := ast_factory.new_infix_as ($2, is_frozen) }
	;


Prefix: TE_PREFIX Prefix_operator
			{ $$ := ast_factory.new_prefix_as ($2, is_frozen) }
	;

Alias: TE_ALIAS Alias_name Alias_mark
			{
				$$ := $2
			}
	;

Alias_name: Infix_operator
			{ $$ := $1 }
	|	TE_STR_NOT
			{ $$ := new_not_string }
	|	TE_STR_BRACKET
			{ $$ := new_bracket_string }
	;

Alias_mark: -- Empty
			{ has_convert_mark := False }
	|	TE_CONVERT
			{ has_convert_mark := True }
	;

Declaration_body: TE_COLON Type Dotnet_indexing
			{
					-- Attribute case
				$$ := ast_factory.new_body_as (Void, $2, Void)
				feature_indexes := $3
			}
	|	TE_COLON Type TE_IS Constant_attribute Dotnet_indexing
			{
					-- Constant case
				$$ := ast_factory.new_body_as (Void, $2, $4)
				feature_indexes := $5
			}
	|	TE_IS Indexing Routine
			{
					-- procedure without arguments
				$$ := ast_factory.new_body_as (Void, Void, $3)
				feature_indexes := $2
			}
	|	TE_COLON Type TE_IS Indexing Routine
			{
					-- Function without arguments
				$$ := ast_factory.new_body_as (Void, $2, $5)
				feature_indexes := $4
			}
	|	Formal_arguments TE_IS Indexing Routine
			{
					-- procedure with arguments
				$$ := ast_factory.new_body_as ($1, Void, $4)
				feature_indexes := $3
			}
	|	Formal_arguments TE_COLON Type TE_IS Indexing Routine
			{
					-- Function with arguments
				$$ := ast_factory.new_body_as ($1, $3, $6)
				feature_indexes := $5
			}
	;

Constant_attribute: Manifest_constant
			{ $$ := ast_factory.new_constant_as ($1) }
	|	TE_UNIQUE Dotnet_indexing
			{ $$ := ast_factory.new_constant_as ($1) }
	;

-- Inheritance


Inheritance: -- Empty
			-- { $$ := Void }
	|	TE_INHERIT ASemi
			{
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
						"Use `inherit ANY' or do not specify an empty inherit clause"))
				end
				$$ := Void
			}
	|	TE_INHERIT { add_counter } Parent_list
			{
				$$ := $3
				remove_counter
			}
	;

Parent_list: Parent
			{
				$$ := ast_factory.new_eiffel_list_parent_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Parent { increment_counter } Parent_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			} 
	;

Parent: Parent_clause
			{
				$$ := $1
			}
	|	Parent_clause TE_SEMICOLON
			{
				$$ := $1
			}
	;

Parent_clause: Identifier_as_upper Generics_opt
			{
				$$ := ast_factory.new_parent_as (ast_factory.new_class_type_as ($1, $2, False, False), Void, Void, Void, Void, Void, Void)
			}
	|	Identifier_as_upper Generics_opt Rename New_exports_opt Undefine_opt Redefine_opt Select_opt TE_END
			{
				$$ := ast_factory.new_parent_as (ast_factory.new_class_type_as ($1, $2, False, False), $3, $4, $5, $6, $7, $8)
			}
	|	Identifier_as_upper Generics_opt New_exports Undefine_opt Redefine_opt Select_opt TE_END
			{
				$$ := ast_factory.new_parent_as (ast_factory.new_class_type_as ($1, $2, False, False), Void, $3, $4, $5, $6, $7)
			}
	|	Identifier_as_upper Generics_opt Undefine Redefine_opt Select_opt TE_END
			{
				$$ := ast_factory.new_parent_as (ast_factory.new_class_type_as ($1, $2, False, False), Void, Void, $3, $4, $5, $6)
			}
	|	Identifier_as_upper Generics_opt Redefine Select_opt TE_END
			{
				$$ := ast_factory.new_parent_as (ast_factory.new_class_type_as ($1, $2, False, False), Void, Void, Void, $3, $4, $5)
			}
	|	Identifier_as_upper Generics_opt Select TE_END
			{
				$$ := ast_factory.new_parent_as (ast_factory.new_class_type_as ($1, $2, False, False), Void, Void, Void, Void, $3, $4)
			}
	;

Rename: TE_RENAME
			-- { $$ := Void }
	|	TE_RENAME { add_counter } Rename_list
			{
				$$ := $3
				remove_counter
			}
	;

Rename_list: Rename_pair
			{
				$$ := ast_factory.new_eiffel_list_rename_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Rename_pair { increment_counter } TE_COMMA Rename_list
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

Rename_pair: Feature_name TE_AS Feature_name
			{ $$ := ast_factory.new_rename_as ($1, $3) }
	;

New_exports_opt: -- Empty
			-- { $$  := Void }
	|	New_exports
			{ $$ := $1 }
	;

New_exports: TE_EXPORT { add_counter } New_export_list
			{
				if $3 /= Void and then $3.is_empty then
					$$ := Void
				else
					$$ := $3
				end
				remove_counter
			}
	|	TE_EXPORT ASemi
			-- { $$ := Void }
	;

New_export_list: New_export_item
			{
				$$ := ast_factory.new_eiffel_list_export_item_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	New_export_item { increment_counter } New_export_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

New_export_item: Client_list Feature_set ASemi
			{
				if $2 /= Void then
					$$ := ast_factory.new_export_item_as (ast_factory.new_client_as ($1), $2)
				end
			}
	;

Feature_set: -- Empty
			-- { $$ := Void }
	|	TE_ALL
			{ $$ := ast_factory.new_all_as }
	|	Feature_list
			{ $$ := ast_factory.new_feature_list_as ($1) }
	;

Convert_clause: -- Empty
			  -- { $$ := Void }
	|	TE_CONVERT { add_counter } Convert_list
		{
			$$ := $3
			remove_counter
		}
	;

Convert_list: Convert_feature
		{
			$$ := ast_factory.new_eiffel_list_convert (counter_value + 1)
			if $$ /= Void and $1 /= Void then
				$$.reverse_extend ($1)
			end
		}
	|	Convert_feature { increment_counter } TE_COMMA Convert_list
		{	
			$$ := $4
			if $$ /= Void and $1 /= Void then
				$$.reverse_extend ($1)
			end
		}
	;


Convert_feature: Feature_name TE_LPARAN TE_LCURLY Type_list TE_RCURLY TE_RPARAN
		{
				-- True because this is a conversion feature used as a creation
				-- procedure in current class.
			$$ := ast_factory.new_convert_feat_as (True, $1, $4)
		}
	|	Feature_name TE_COLON TE_LCURLY Type_list TE_RCURLY
		{
				-- False because this is not a conversion feature used as a creation
				-- procedure.
			$$ := ast_factory.new_convert_feat_as (False, $1, $4)
		}
	;

Feature_list: { add_counter } Feature_list_impl
		{
			$$ := $2
			remove_counter
		}
	;

Feature_list_impl: Feature_name
			{
				$$ := ast_factory.new_eiffel_list_feature_name (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Feature_name { increment_counter } TE_COMMA Feature_list_impl
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
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


Formal_arguments:	TE_LPARAN TE_RPARAN
		--	{ $$ := Void }
	|	TE_LPARAN { add_counter } Entity_declaration_list TE_RPARAN
			{
				$$ := $3
				remove_counter
			}
	;

Entity_declaration_list: Entity_declaration_group
			{
				$$ := ast_factory.new_eiffel_list_type_dec_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Entity_declaration_group { increment_counter } Entity_declaration_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

Entity_declaration_group: { add_counter } Identifier_list { remove_counter } TE_COLON Type ASemi
			{ $$ := ast_factory.new_type_dec_as ($2, $5) }
	;

Identifier_list: Identifier_as_lower
			{
				$$ := ast_factory.new_identifier_list (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					Names_heap.put ($1)
					$$.reverse_extend (Names_heap.found_item)
				end
			}
	|	Identifier_as_lower { increment_counter } TE_COMMA Identifier_list
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					Names_heap.put ($1)
					$$.reverse_extend (Names_heap.found_item)
				end
			}
	;

Strip_identifier_list: -- Empty
			{ $$ := ast_factory.new_identifier_list (0) }
	|	{ add_counter } Identifier_list
			{
				$$ := $2
				remove_counter
			}
	;

Routine:
		Obsolete
			{ fbody_pos := position } 
		Precondition
		Local_declarations
		Routine_body
		Postcondition
		Rescue
		TE_END
			{
				$$ := ast_factory.new_routine_as ($1, $3, $4, $5, $6, $7, fbody_pos,
					$8, once_manifest_string_count)
				once_manifest_string_count := 0
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
				$$ := ast_factory.new_external_as ($2, $3)
				has_externals := True
			}
	;

External_language:
		Non_empty_string
			{ $$ := ast_factory.new_external_lang_as ($1) }
	;

External_name: -- Empty
			-- { $$ := Void }
	|	TE_ALIAS Non_empty_string
			{ $$ := $2 }
	;

Internal: TE_DO Compound
			{ $$ := ast_factory.new_do_as ($2) }
	|	TE_ONCE Compound
			{ $$ := ast_factory.new_once_as ($2) }
	;

Local_declarations: -- Empty
			-- { $$ := Void }
	|	TE_LOCAL
			{ $$ := ast_factory.new_eiffel_list_type_dec_as (0) }
	|	TE_LOCAL { add_counter } Entity_declaration_list
			{
				$$ := $3
				remove_counter
			}
	;

Compound: Optional_semicolons
			-- { $$ := Void }
	|	Optional_semicolons { add_counter } Instruction_list
			{
				$$ := $3
				remove_counter
			}
	;

Instruction_list: Instruction
			{
				$$ := ast_factory.new_eiffel_list_instruction_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Instruction { increment_counter } Instruction_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

Instruction: Instruction_impl Optional_semicolons
			{ $$ := $1 }
	;

Optional_semicolons: -- Empty
	|	Optional_semicolons TE_SEMICOLON
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
	|	TE_RETRY
			{ $$ := $1 }
	;

Precondition: -- Empty
			-- { $$ := Void }
	|	TE_REQUIRE
			{ id_level := Assert_level }
		Assertion
			{
				id_level := Normal_level
				$$ := ast_factory.new_require_as ($3)
			}
	|	TE_REQUIRE TE_ELSE
			{ id_level := Assert_level }
		Assertion
			{
				id_level := Normal_level
				$$ := ast_factory.new_require_else_as ($4)
			}
	;

Postcondition: -- Empty
			-- { $$ := Void }
	|	TE_ENSURE
			{ id_level := Assert_level }
		Assertion
			{
				id_level := Normal_level
				$$ := ast_factory.new_ensure_as ($3)
			}
	|	TE_ENSURE TE_THEN
			{ id_level := Assert_level }
		Assertion
			{
				id_level := Normal_level
				$$ := ast_factory.new_ensure_then_as ($4)
			}
	;

Assertion: -- Empty
			-- { $$ := Void }
	|	{ add_counter } Assertion_list
			{
				$$ := $2
				if $$ /= Void and then $$.is_empty then
					$$ := Void
				end
				remove_counter
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
			{ $$ := ast_factory.new_tagged_as (Void, $1) }
	|	Identifier_as_lower TE_COLON Expression ASemi
			{ $$ := ast_factory.new_tagged_as ($1, $3) }
	|	Identifier_as_lower TE_COLON ASemi
			-- { $$ := Void }
	;


-- Type


Type: Class_type
			{ $$ := $1 }
	|	Non_class_type
			{ $$ := $1 }
	;

Non_class_type: TE_EXPANDED Identifier_as_upper Generics_opt
			{
				$$ := new_class_type ($2, $3, True, False)
				if has_syntax_warning and $2 /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make ($2.line, $2.column, filename,
						"Make an expanded version of the base class associated with this type."))
				end
			}
	|	TE_SEPARATE Identifier_as_upper Generics_opt
			{ $$ := new_class_type ($2, $3, False, True) }
	|	TE_BIT Integer_constant
			{ $$ := ast_factory.new_bits_as ($2) }
	|	TE_BIT Identifier_as_lower
			{ $$ := ast_factory.new_bits_symbol_as ($2) }
	|	TE_LIKE Identifier_as_lower
			{ $$ := ast_factory.new_like_id_as ($2) }
	|	TE_LIKE TE_CURRENT
			{ $$ := ast_factory.new_like_current_as ($2) }
	;

Class_type: Identifier_as_upper Generics_opt
			{ $$ := new_class_type ($1, $2, False, False) }
	;

Generics_opt: -- Empty
			-- { $$ := Void }
	|	TE_LSQURE TE_RSQURE
			-- { $$ := Void }
	|	TE_LSQURE Type_list TE_RSQURE
			{ $$ := $2 }
	;

Type_list: { add_counter } Type_list_impl
		 {
		 	$$ := $2
			remove_counter
		}
	;

Type_list_impl: Type
			{
				$$ := ast_factory.new_eiffel_list_type (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Type { increment_counter } TE_COMMA Type_list_impl
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
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
				 -- $$ := Void
			}
	|	TE_LSQURE { add_counter } Formal_generic_list TE_RSQURE
			{
				formal_generics_end_position := position
				$$ := $3
				remove_counter
			}
	;

Formal_generic_list: Formal_generic
			{
				$$ := ast_factory.new_eiffel_list_formal_dec_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Formal_generic { increment_counter } TE_COMMA Formal_generic_list
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

Formal_parameter: TE_REFERENCE TE_ID 
			{
				if equal (None_classname, $2) then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$2' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					if not case_sensitive and $2 /= Void then
						$2.to_upper
					end
					$$ := ast_factory.new_formal_as ($2, True, False)
				end
			}
	| TE_EXPANDED TE_ID 
			{
				if equal (None_classname, $2) then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$2' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					if not case_sensitive and $2 /= Void then
						$2.to_upper
					end
					$$ := ast_factory.new_formal_as ($2, False, True)
				end
			}

	|	TE_ID
			{
				if equal (None_classname, $1) then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$1' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					if not case_sensitive and $1 /= Void then
						$1.to_upper
					end
					$$ := ast_factory.new_formal_as ($1, False, False)
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
					$$ := ast_factory.new_formal_dec_as ($1, $3.first, $3.second)
				else
					$$ := ast_factory.new_formal_dec_as ($1, Void, Void)
				end
			}
	;

Constraint: -- Empty
			-- { $$ := Void }
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
 

Conditional: TE_IF Expression TE_THEN Compound TE_END
			{ $$ := ast_factory.new_if_as ($2, $4, Void, Void, $5) }
	|	TE_IF Expression TE_THEN Compound Else_part TE_END
			{ $$ := ast_factory.new_if_as ($2, $4, Void, $5, $6) }
	|	TE_IF Expression TE_THEN Compound Elseif_list TE_END
			{ $$ := ast_factory.new_if_as ($2, $4, $5, Void, $6) }
	|	TE_IF Expression TE_THEN Compound Elseif_list Else_part TE_END
			{ $$ := ast_factory.new_if_as ($2, $4, $5, $6, $7) }
	;

Elseif_list: { add_counter } Elseif_part_list
		{
			$$ := $2
			remove_counter
		}
	;

Elseif_part_list: Elseif_part
			{
				$$ := ast_factory.new_eiffel_list_elseif_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Elseif_part { increment_counter } Elseif_part_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

Elseif_part: TE_ELSEIF Expression TE_THEN Compound
			{ $$ := ast_factory.new_elseif_as ($2, $4) }
	;

Else_part: TE_ELSE Compound 
			{ $$ := $2 }
	;

Multi_branch: TE_INSPECT Expression When_part_list_opt TE_END
			{ $$ := ast_factory.new_inspect_as ($2, $3, Void, $4) }
	|	TE_INSPECT Expression When_part_list_opt TE_ELSE Compound TE_END
			{
				if $5 /= Void then
					$$ := ast_factory.new_inspect_as ($2, $3, $5, $6)
				else
					$$ := ast_factory.new_inspect_as ($2, $3,
						ast_factory.new_eiffel_list_instruction_as (0), $6)
				end
			}
	;

When_part_list_opt: -- Empty
			-- { $$ := Void }
	|	{ add_counter } When_part_list
			{
				$$ := $2
				remove_counter
			}
	;

When_part_list: When_part
			{
				$$ := ast_factory.new_eiffel_list_case_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	When_part { increment_counter } When_part_list
			{
				$$ := $3
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

When_part: TE_WHEN { add_counter } Choices { remove_counter } TE_THEN Compound
			{ $$ := ast_factory.new_case_as ($3, $6) }
	;

Choices: Choice
			{
				$$ := ast_factory.new_eiffel_list_interval_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Choice { increment_counter } TE_COMMA Choices
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

Choice: Integer_constant
			{ $$ := ast_factory.new_interval_as ($1, Void) }
	|	Integer_constant TE_DOTDOT Integer_constant
			{ $$ := ast_factory.new_interval_as ($1, $3) }
	|	Character_constant
			{ $$ := ast_factory.new_interval_as ($1, Void) }
	|	Character_constant TE_DOTDOT Character_constant
			{ $$ := ast_factory.new_interval_as ($1, $3) }
	|	Identifier_as_lower
			{ $$ := ast_factory.new_interval_as ($1, Void) }
	|	Identifier_as_lower TE_DOTDOT Identifier_as_lower
			{ $$ := ast_factory.new_interval_as ($1, $3) }
	|	Identifier_as_lower TE_DOTDOT Integer_constant
			{ $$ := ast_factory.new_interval_as ($1, $3) }
	|	Integer_constant TE_DOTDOT Identifier_as_lower
			{ $$ := ast_factory.new_interval_as ($1, $3) }
	|	Identifier_as_lower TE_DOTDOT Character_constant
			{ $$ := ast_factory.new_interval_as ($1, $3) }
	|	Character_constant TE_DOTDOT Identifier_as_lower
			{ $$ := ast_factory.new_interval_as ($1, $3) }
	|	A_static_call
			{ $$ := ast_factory.new_interval_as ($1, Void) }
	|	A_static_call TE_DOTDOT Identifier_as_lower
			{ $$ := ast_factory.new_interval_as ($1, $3) }
	|	Identifier_as_lower TE_DOTDOT A_static_call
			{ $$ := ast_factory.new_interval_as ($1, $3) }
	|	A_static_call TE_DOTDOT A_static_call
			{ $$ := ast_factory.new_interval_as ($1, $3) }
	|	A_static_call TE_DOTDOT Integer_constant
			{ $$ := ast_factory.new_interval_as ($1, $3) }
	|	Integer_constant TE_DOTDOT A_static_call
			{ $$ := ast_factory.new_interval_as ($1, $3) }
	|	A_static_call TE_DOTDOT Character_constant
			{ $$ := ast_factory.new_interval_as ($1, $3) }
	|	Character_constant TE_DOTDOT A_static_call
			{ $$ := ast_factory.new_interval_as ($1, $3) }

	;

Loop: TE_FROM Compound Invariant Variant TE_UNTIL Expression TE_LOOP Compound TE_END
			{
				$$ := ast_factory.new_loop_as ($2, $3, $4, $6, $8, $9)
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
				$$ := ast_factory.new_invariant_as ($3, once_manifest_string_count)
				once_manifest_string_count := 0
			}
	;

Variant: -- Empty
			-- { $$ := Void }
	|	TE_VARIANT Identifier_as_lower TE_COLON Expression
			{ $$ := ast_factory.new_variant_as ($2, $4) }
	|	TE_VARIANT Expression
			{ $$ := ast_factory.new_variant_as (Void, $2) }
	;

Debug: TE_DEBUG Debug_keys Compound TE_END 
			{ $$ := ast_factory.new_debug_as ($2, $3, $4) }
	;

Debug_keys: -- Empty
			-- { $$ := Void }
	|	TE_LPARAN TE_RPARAN
			-- { $$ := Void }
	|	TE_LPARAN { add_counter } String_list TE_RPARAN
			{
				$$ := $3
				remove_counter
			}
	;

String_list: Non_empty_string
			{
				$$ := ast_factory.new_eiffel_list_string_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Non_empty_string { increment_counter } TE_COMMA String_list
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

Rescue: -- Empty
			-- { $$ := Void }
	|	TE_RESCUE Compound 
			{
				$$ := $2
				if $$ = Void then
					$$ := ast_factory.new_eiffel_list_instruction_as (0)
				end
			}
	;

Assignment: Identifier_as_lower TE_ASSIGN Expression
			{ $$ := ast_factory.new_assign_as (ast_factory.new_access_id_as ($1, Void), $3) }
	|	TE_RESULT TE_ASSIGN Expression
			{ $$ := ast_factory.new_assign_as ($1, $3) }
    ;

Reverse_assignment: Identifier_as_lower TE_ACCEPT Expression
			{ $$ := ast_factory.new_reverse_as (ast_factory.new_access_id_as ($1, Void), $3) }
	|	TE_RESULT TE_ACCEPT Expression
			{ $$ := ast_factory.new_reverse_as ($1, $3) }
    ;

Creators: -- Empty
			-- { $$ := Void }
	|	{ add_counter } Creation_clause_list
			{
				$$ := $2
				remove_counter
			}
	;

Creation_clause_list: Creation_clause
			{
				$$ := ast_factory.new_eiffel_list_create_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Creation_clause { increment_counter } Creation_clause_list
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
				$$ := ast_factory.new_create_as (Void, Void)
			}
	|	TE_CREATE Clients Feature_list
			{
				$$ := ast_factory.new_create_as ($2, $3)
			}
	|	TE_CREATE Client_list 
			{
				$$ := ast_factory.new_create_as (ast_factory.new_client_as ($2), Void)
			}
	|	 TE_CREATION
			{
				$$ := ast_factory.new_create_as (Void, Void)
				if has_syntax_warning and $1 /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make ($1.line, $1.column, filename,
						"Use keyword `create' instead."))
				end
			}
	|	TE_CREATION Clients Feature_list
			{
				$$ := ast_factory.new_create_as ($2, $3)
				if has_syntax_warning and $1 /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make ($1.line, $1.column, filename,
						"Use keyword `create' instead."))
				end
			}
	|	TE_CREATION Client_list 
			{
				$$ := ast_factory.new_create_as (ast_factory.new_client_as ($2), Void)
				if has_syntax_warning and $1 /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make ($1.line, $1.column, filename,
						"Use keyword `create' instead."))
				end
			}
	;

Agent_call: TE_AGENT Feature_name_for_call Delayed_actuals
		{
			$$ := ast_factory.new_routine_creation_as (
				ast_factory.new_operand_as (Void, Void, Void), $2, $3, False)
		}
	|	TE_AGENT Agent_target TE_DOT Feature_name_for_call Delayed_actuals
		{
			$$ := ast_factory.new_routine_creation_as ($2, $4, $5, True)
		}
	|	Tilda_agent_call
		{
			if $1 /= Void then
				$$ := $1.first
				if has_syntax_warning and $1.second /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make ($1.second.line,
						$1.second.column, filename, "Use keyword `agent' instead."))
				end
			end
		}
	;

--Note: Manu 02/07/2004: we need to expand `Agent_target' otherwise it causes some
-- Reduce/Reduce conflict. `Tilda_agent_call' should be written as:
--Tilda_agent_call:	TE_TILDE Identifier_as_lower Delayed_actuals
--		{ $$ := ast_factory.new_old_routine_creation_as ($2, ast_factory.new_operand_as (Void, Void, Void), $2, $3, False) }
--	|	Agent_target TE_TILDE Identifier_as_lower Delayed_actuals
--		{ $$ := ast_factory.new_old_routine_creation_as ($3, $1, $3, $4, True) }
--	;
Tilda_agent_call: TE_TILDE Identifier_as_lower Delayed_actuals
		{ $$ := ast_factory.new_old_routine_creation_as ($2, ast_factory.new_operand_as (Void, Void, Void), $2, $3, False) }
	|	Identifier_as_lower TE_TILDE Identifier_as_lower Delayed_actuals
		{ $$ := ast_factory.new_old_routine_creation_as ($1, ast_factory.new_operand_as (Void, ast_factory.new_access_id_as ($1, Void), Void), $3, $4, True) }
	|	TE_LPARAN Expression TE_RPARAN TE_TILDE Identifier_as_lower Delayed_actuals
		{ $$ := ast_factory.new_old_routine_creation_as ($2, ast_factory.new_operand_as (Void, Void, $2), $5, $6, True) }
	|	TE_RESULT TE_TILDE Identifier_as_lower Delayed_actuals
		{ $$ := ast_factory.new_old_routine_creation_as ($3, ast_factory.new_operand_as (Void, $1, Void), $3, $4, True) }
	|	TE_CURRENT TE_TILDE Identifier_as_lower Delayed_actuals
		{ $$ := ast_factory.new_old_routine_creation_as ($3, ast_factory.new_operand_as (Void, $1, Void), $3, $4, True) }
	|	TE_LCURLY Type TE_CURLYTILDE Identifier_as_lower Delayed_actuals
		{ $$ := ast_factory.new_old_routine_creation_as ($2, ast_factory.new_operand_as ($2, Void, Void), $4, $5, True) }
	|	TE_QUESTION TE_TILDE Identifier_as_lower Delayed_actuals
		{ $$ := ast_factory.new_old_routine_creation_as ($3, ast_factory.new_operand_as (Void, Void, Void), $3, $4, True) }
	;

Agent_target: Identifier_as_lower
		{ $$ := ast_factory.new_operand_as (Void, ast_factory.new_access_id_as ($1, Void), Void) }
	|	TE_LPARAN Expression TE_RPARAN
		{ $$ := ast_factory.new_operand_as (Void, Void, $2) }	
	|	TE_RESULT
		{ $$ := ast_factory.new_operand_as (Void, $1, Void) }
	|	TE_CURRENT
		{ $$ := ast_factory.new_operand_as (Void, $1, Void) }
	|	Typed
		{ $$ := ast_factory.new_operand_as ($1, Void, Void)}
	|	TE_QUESTION
		{ $$ := Void }
	;

Delayed_actuals: -- Empty
			-- { $$ := Void }
	|	TE_LPARAN TE_RPARAN
			-- { $$ := Void }
	|	TE_LPARAN { add_counter } Delayed_actual_list TE_RPARAN
			{
				$$ := $3
				remove_counter
			}
	;

Delayed_actual_list: Delayed_actual
			{
				$$ := ast_factory.new_eiffel_list_operand_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Delayed_actual { increment_counter } TE_COMMA Delayed_actual_list
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

Delayed_actual: TE_QUESTION
			{ $$ := ast_factory.new_operand_as (Void, Void, Void) }
-- Manu: 01/19/2005: Due to syntax ambiguity we cannot have `Typed' only
-- as there will be no way to distinguish it from a Manifest type expression.
-- To preserve this feature in case it is needed by some of our customers
-- we have invented the new syntax ? Typed.
	|	Typed TE_QUESTION
			{ $$ := ast_factory.new_operand_as ($1, Void, Void) }
	|	Expression
			{ $$ := ast_factory.new_operand_as (Void, Void, $1) }
	;

Creation: TE_BANG Creation_type TE_BANG Creation_target Creation_call
			{
				$$ := ast_factory.new_creation_as ($2, $4, $5)
				if has_syntax_warning and $4 /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make ($4.start_location.line,
						$4.start_location.column, filename, "Use keyword `create' instead."))
				end
			}
	|	TE_CREATE Creation_target Creation_call
			{ $$ := ast_factory.new_creation_as (Void, $2, $3) }
	|	TE_CREATE Typed Creation_target Creation_call
			{ $$ := ast_factory.new_creation_as ($2, $3, $4) }
	;

Creation_expression: TE_CREATE Typed Creation_call
			{ $$ := ast_factory.new_creation_expr_as ($2, $3) }
	|	TE_BANG Type TE_BANG Creation_call
			{
				$$ := ast_factory.new_creation_expr_as ($2, $4)
				if has_syntax_warning and $2 /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make ($2.start_location.line,
						$2.start_location.column, filename, "Use keyword `create' instead."))
				end
			}
	;

Creation_type: -- Empty
			-- { $$ := Void }
	|	Type
			{ $$ := $1 }
	;

Creation_target: Identifier_as_lower
			{ $$ := ast_factory.new_access_id_as ($1, Void) }
	|	TE_RESULT
			{ $$ := $1 }
	;

Creation_call: -- Empty
			-- { $$ := Void }
	|	TE_DOT Identifier_as_lower Parameters
			{ $$ := ast_factory.new_access_inv_as ($2, $3) }
	;


-- Instruction call

 
Call: A_feature
			{ $$ := ast_factory.new_instr_call_as ($1) }
	|	Call_on_result
			{ $$ := ast_factory.new_instr_call_as ($1) }
	|	Call_on_feature
			{ $$ := ast_factory.new_instr_call_as ($1) }
	|	Call_on_current
			{ $$ := ast_factory.new_instr_call_as ($1) }
	|	Call_on_expression
			{ $$ := ast_factory.new_instr_call_as ($1) }
	|	A_precursor
			{ $$ := ast_factory.new_instr_call_as ($1) }
	|	Call_on_precursor
			{ $$ := ast_factory.new_instr_call_as ($1) }
	|	A_static_call
			{ $$ := ast_factory.new_instr_call_as ($1) }
	|	Call_on_static
			{ $$ := ast_factory.new_instr_call_as ($1) }
	;

Check: TE_CHECK Assertion TE_END
			{ $$ := ast_factory.new_check_as ($2, $3) }
	;


-- Expression

Typed: TE_LCURLY Type TE_RCURLY
			{ $$ := $2 }
	;

Expression:
		Nosigned_integer
			{ $$ := $1 }
	|	Nosigned_real
			{ $$ := $1 }
	|	Factor
			{ $$ := $1 }
	|	Typed_expression
			{ $$ := $1 }
	|	Expression TE_PLUS Expression
			{ $$ := ast_factory.new_bin_plus_as ($1, $3) }
	|	Expression TE_MINUS Expression
			{ $$ := ast_factory.new_bin_minus_as ($1, $3) }
	|	Expression TE_STAR Expression
			{ $$ := ast_factory.new_bin_star_as ($1, $3) }
	|	Expression TE_SLASH Expression
			{ $$ := ast_factory.new_bin_slash_as ($1, $3) }
	|	Expression TE_MOD Expression
			{ $$ := ast_factory.new_bin_mod_as ($1, $3) }
	|	Expression TE_DIV Expression
			{ $$ := ast_factory.new_bin_div_as ($1, $3) }
	|	Expression TE_POWER Expression
			{ $$ := ast_factory.new_bin_power_as ($1, $3) }
	|	Expression TE_AND Expression
			{ $$ := ast_factory.new_bin_and_as ($1, $3) }
	|	Expression TE_AND TE_THEN Expression %prec TE_AND
			{ $$ := ast_factory.new_bin_and_then_as ($1, $4) }
	|	Expression TE_OR Expression
			{ $$ := ast_factory.new_bin_or_as ($1, $3) }
	|	Expression TE_OR TE_ELSE Expression %prec TE_OR
			{ $$ := ast_factory.new_bin_or_else_as ($1, $4) }
	|	Expression TE_IMPLIES Expression
			{ $$ := ast_factory.new_bin_implies_as ($1, $3) }
	|	Expression TE_XOR Expression
			{ $$ := ast_factory.new_bin_xor_as ($1, $3) }
	|	Expression TE_GE Expression
			{ $$ := ast_factory.new_bin_ge_as ($1, $3) }
	|	Expression TE_GT Expression
			{ $$ := ast_factory.new_bin_gt_as ($1, $3) }
	|	Expression TE_LE Expression
			{ $$ := ast_factory.new_bin_le_as ($1, $3) }
	|	Expression TE_LT Expression
			{ $$ := ast_factory.new_bin_lt_as ($1, $3) }
	|	Expression TE_EQ Expression
			{ $$ := ast_factory.new_bin_eq_as ($1, $3) }
	|	Expression TE_NE Expression
			{ $$ := ast_factory.new_bin_ne_as ($1, $3) }
	|	Expression Free_operator Expression %prec TE_FREE
			{ $$ := ast_factory.new_bin_free_as ($1, $2, $3) }
	;

Factor:
		Expression_constant
			{ $$ := $1 }
	|	Simple_factor
			{ $$ := $1}
	;

Simple_factor:	TE_VOID
			{ $$ := $1 }
	|	Manifest_array
			{ $$ := $1 }
	|	Manifest_tuple
			{ $$ := $1 }
	|	Expression_feature_call
			{ $$ := ast_factory.new_expr_call_as ($1) }
	|	Agent_call
			{ $$ := $1 }
	|	New_call_on_static
			{ $$ := ast_factory.new_expr_call_as ($1) }
	|	New_a_static_call
			{ $$ := ast_factory.new_expr_call_as ($1) }
	|	TE_LPARAN Expression TE_RPARAN
			{ $$ := ast_factory.new_paran_as ($2) }
	|	TE_MINUS Factor
			{ $$ := ast_factory.new_un_minus_as ($2) }
	|	TE_PLUS Factor
			{ $$ := ast_factory.new_un_plus_as ($2) }
	|	TE_NOT Expression
			{ $$ := ast_factory.new_un_not_as ($2) }
	|	TE_OLD Expression
			{ $$ := ast_factory.new_un_old_as ($2) }
	|	Free_operator Expression %prec TE_NOT
			{ $$ := ast_factory.new_un_free_as ($1, $2) }
	|	TE_STRIP TE_LPARAN Strip_identifier_list TE_RPARAN
			{ $$ := ast_factory.new_un_strip_as ($3) }
	|	TE_ADDRESS Feature_name
			{ $$ := ast_factory.new_address_as ($2) }
	|	TE_ADDRESS TE_LPARAN Expression TE_RPARAN
			{ $$ := ast_factory.new_expr_address_as ($3) }
	|	TE_ADDRESS TE_CURRENT
			{ $$ := ast_factory.new_address_current_as ($2) }
	|	TE_ADDRESS TE_RESULT
			{ $$ := ast_factory.new_address_result_as ($2) }
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
				if not case_sensitive and $1 /= Void then
					$1.to_lower
				end
				$$ := $1
			}
	;


-- Expression call
Expression_feature_call: Call_on_current
			{ $$ := $1 }
	|	Call_on_result
			{ $$ := $1 }
	|	Call_on_feature
			{ $$ := $1 }
	|	TE_CURRENT
			{ $$ := $1 }
	|	TE_RESULT
			{ $$ := $1 }
	|	A_feature
			{ $$ := $1 }
	|	Call_on_expression
			{ $$ := $1 }
	|	A_precursor
			{ $$ := $1 }
	|	Call_on_precursor
			{ $$ := $1 }
	|	Old_a_static_call
			{ $$ := $1 }
	|	Old_call_on_static
			{ $$ := $1 }
	|	Creation_expression
			{ $$ := $1 }
	;

Call_on_current: TE_CURRENT TE_DOT Remote_call
			{ $$ := ast_factory.new_nested_as ($1, $3) }
	;

Call_on_result: TE_RESULT TE_DOT Remote_call
			{ $$ := ast_factory.new_nested_as ($1, $3) }
	;

Call_on_feature: A_feature TE_DOT Remote_call
			{ $$ := ast_factory.new_nested_as ($1, $3) }
	;

Call_on_expression: TE_LPARAN Expression TE_RPARAN TE_DOT Remote_call
			{ $$ := ast_factory.new_nested_expr_as ($2, $5) }
	;

Call_on_precursor: A_precursor TE_DOT Remote_call
			{ $$ := ast_factory.new_nested_as ($1, $3) }
	;

A_precursor: TE_PRECURSOR Parameters
			{ $$ := ast_factory.new_precursor_as ($1, Void, $2) }
	|	TE_PRECURSOR TE_LCURLY Identifier_as_upper TE_RCURLY Parameters
			{ $$ := ast_factory.new_precursor_as ($1, ast_factory.new_class_type_as ($3, Void, False, False), $5) }
	;

Call_on_static: New_call_on_static
			{ $$ := $1 }
	|	Old_call_on_static
			{ $$ := $1 }
	;
			  
New_call_on_static: New_a_static_call TE_DOT Remote_call
			{ $$ := ast_factory.new_nested_as ($1, $3) }
	;

Old_call_on_static: Old_a_static_call TE_DOT Remote_call
		{ $$ := ast_factory.new_nested_as ($1, $3) }
	;

A_static_call: New_a_static_call
			{ $$ := $1 }
	|	Old_a_static_call
			{ $$ := $1 }
	;

New_a_static_call:
		Typed TE_DOT Identifier_as_lower Parameters
			{ $$ := ast_factory.new_static_access_as ($1, $3, $4); }
	;

Old_a_static_call:
		TE_FEATURE Typed TE_DOT Identifier_as_lower Parameters
			{
				$$ := ast_factory.new_static_access_as ($2, $4, $5);
				if has_syntax_warning and $2 /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make ($2.start_location.line,
							$2.start_location.column, filename, "Remove the `feature' keyword."))
				end
			}
	;

Remote_call: Call_on_feature_access
			{ $$ := $1 }
	|	Feature_access
			{ $$ := $1 }
	;

Call_on_feature_access: Feature_access TE_DOT Feature_access
			{ $$ := ast_factory.new_nested_as ($1, $3) }
	|	Feature_access TE_DOT Call_on_feature_access
			{ $$ := ast_factory.new_nested_as ($1, $3) }
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
					$$ := ast_factory.new_access_inv_as ($1, $2)
				end
			}
	;

Feature_access: Feature_name_for_call Parameters
			{ $$ := ast_factory.new_access_feat_as ($1, $2) }
	;

Parameters: -- Empty
			-- { $$ := Void }
	|	TE_LPARAN TE_RPARAN
			-- { $$ := Void }
	|	TE_LPARAN { add_counter } Expression_list TE_RPARAN
			{
				$$ := $3
				remove_counter
			}
	;

Expression_list: Expression
			{
				$$ := ast_factory.new_eiffel_list_expr_as (counter_value + 1)
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	|	Expression { increment_counter } TE_COMMA Expression_list
			{
				$$ := $4
				if $$ /= Void and $1 /= Void then
					$$.reverse_extend ($1)
				end
			}
	;

Identifier_as_upper: TE_ID
			{
				if not case_sensitive and $1 /= Void then
					$1.to_upper
				end
				$$ := $1
			}
	;

Identifier_as_lower: TE_ID
			{
				if not case_sensitive and $1 /= Void then
					$1.to_lower
				end
				$$ := $1
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
				$$ := ast_factory.new_character_as (token_buffer.item (1), line, column, position)
			}
	|	Typed TE_CHAR
			{
				check is_character: not token_buffer.is_empty end
				fixme ("We should handle `Type' instead of ignoring it.")
				$$ := ast_factory.new_character_as (token_buffer.item (1), line, column, position)
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
			{ $$ := new_integer_value ('+', Void, token_buffer) }
	|	TE_MINUS TE_INTEGER
			{ $$ := new_integer_value ('-', Void, token_buffer) }
	;

Nosigned_integer: TE_INTEGER
			{ $$ := new_integer_value ('%U', Void, token_buffer) }
	;

Typed_integer: Typed_nosigned_integer
			{ $$ := $1 }
	|	Typed_signed_integer
			{ $$ := $1 }
	;

Typed_nosigned_integer: Typed TE_INTEGER
			{ $$ := new_integer_value ('%U', $1, token_buffer) }
	;

Typed_signed_integer:	Typed TE_PLUS TE_INTEGER
			{ $$ := new_integer_value ('+', $1, token_buffer) }
	|	Typed TE_MINUS TE_INTEGER
			{ $$ := new_integer_value ('-', $1, token_buffer) }
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
			{ $$ := new_real_value (False, '%U', Void, token_buffer) }
	;

Signed_real: TE_PLUS TE_REAL
			{ $$ := new_real_value (True, '+', Void, token_buffer) }
	|	TE_MINUS TE_REAL
			{ $$ := new_real_value (True, '-', Void, token_buffer) }
	;

Typed_real: Typed_nosigned_real
			{ $$ := $1 }
	|	Typed_signed_real
			{ $$ := $1 }
	;

Typed_nosigned_real: Typed TE_REAL
			{ $$ := new_real_value (False, '%U', $1, token_buffer) }
	;

Typed_signed_real: Typed TE_PLUS TE_REAL
			{ $$ := new_real_value (True, '+', $1, token_buffer) }
	|	Typed TE_MINUS TE_REAL
			{ $$ := new_real_value (True, '-', $1, token_buffer) }
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
			{ $$ := ast_factory.new_string_as ("", line, column, position) }
	|	TE_EMPTY_VERBATIM_STRING
			{ $$ := ast_factory.new_verbatim_string_as ("", verbatim_marker.substring (2, verbatim_marker.count), not has_old_verbatim_strings and then verbatim_marker.item (1) = ']', line, column, position) }
	;

Typed_manifest_string: TE_RCURLY Type TE_RCURLY Default_manifest_string
			{
				fixme ("We should handle `Type' instead of ignoring it.")
				$$ := $4
			}
	;

Non_empty_string: TE_STRING
			{ $$ := new_string (cloned_string (token_buffer)) }
	|	TE_VERBATIM_STRING
			{ $$ := ast_factory.new_verbatim_string_as (cloned_string (token_buffer), verbatim_marker.substring (2, verbatim_marker.count), not has_old_verbatim_strings and then verbatim_marker.item (1) = ']', line, column, position) }
	|	TE_STR_LT
			{ $$ := new_lt_string }
	|	TE_STR_LE
			{ $$ := new_le_string }
	|	TE_STR_GT
			{ $$ := new_gt_string }
	|	TE_STR_GE
			{ $$ := new_ge_string }
	|	TE_STR_MINUS
			{ $$ := new_minus_string }
	|	TE_STR_PLUS
			{ $$ := new_plus_string }
	|	TE_STR_STAR
			{ $$ := new_star_string }
	|	TE_STR_SLASH
			{ $$ := new_slash_string }
	|	TE_STR_MOD
			{ $$ := new_mod_string }
	|	TE_STR_DIV
			{ $$ := new_div_string }
	|	TE_STR_POWER
			{ $$ := new_power_string }
	|	TE_STR_BRACKET
			{ $$ := new_bracket_string }
	|	TE_STR_AND
			{ $$ := new_string (cloned_string (token_buffer)) }
	|	TE_STR_AND_THEN
			{ $$ := new_string (cloned_string (token_buffer)) }
	|	TE_STR_IMPLIES
			{ $$ := new_string (cloned_string (token_buffer)) }
	|	TE_STR_OR
			{ $$ := new_string (cloned_string (token_buffer)) }
	|	TE_STR_OR_ELSE
			{ $$ := new_string (cloned_string (token_buffer)) }
	|	TE_STR_XOR
			{ $$ := new_string (cloned_string (token_buffer)) }
	|	TE_STR_NOT
			{ $$ := new_string (cloned_string (token_buffer)) }
	|	TE_STR_FREE
			{ $$ := new_string (cloned_string (token_buffer)) }
	;

Prefix_operator: TE_STR_MINUS
			{ $$ := new_minus_string }
	|	TE_STR_PLUS
			{ $$ := new_plus_string }
	|	TE_STR_NOT
			{ $$ := new_not_string }
	|	TE_STR_FREE
			{ $$ := new_string (cloned_lower_string (token_buffer)) }
	;

Infix_operator: TE_STR_LT
			{ $$ := new_lt_string }
	|	TE_STR_LE
			{ $$ := new_le_string }
	|	TE_STR_GT
			{ $$ := new_gt_string }
	|	TE_STR_GE
			{ $$ := new_ge_string }
	|	TE_STR_MINUS
			{ $$ := new_minus_string }
	|	TE_STR_PLUS
			{ $$ := new_plus_string }
	|	TE_STR_STAR
			{ $$ := new_star_string }
	|	TE_STR_SLASH
			{ $$ := new_slash_string }
	|	TE_STR_MOD
			{ $$ := new_mod_string }
	|	TE_STR_DIV
			{ $$ := new_div_string }
	|	TE_STR_POWER
			{ $$ := new_power_string }
	|	TE_STR_AND
			{ $$ := new_and_string }
	|	TE_STR_AND_THEN
			{ $$ := new_and_then_string }
	|	TE_STR_IMPLIES
			{ $$ := new_implies_string }
	|	TE_STR_OR
			{ $$ := new_or_string }
	|	TE_STR_OR_ELSE
			{ $$ := new_or_else_string }
	|	TE_STR_XOR
			{ $$ := new_xor_string }
	|	TE_STR_FREE
			{ $$ := new_string (cloned_lower_string (token_buffer)) }
	;

Manifest_array: TE_LARRAY TE_RARRAY
			{ $$ := ast_factory.new_array_as (ast_factory.new_eiffel_list_expr_as (0)) }
	|	TE_LARRAY { add_counter } Expression_list TE_RARRAY
			{
				$$ := ast_factory.new_array_as ($3)
				remove_counter
			}
	;

Manifest_tuple: TE_LSQURE TE_RSQURE
			{ $$ := ast_factory.new_tuple_as (ast_factory.new_eiffel_list_expr_as (0)) }
	|	TE_LSQURE { add_counter } Expression_list TE_RSQURE
			{
				$$ := ast_factory.new_tuple_as ($3)
				remove_counter
			}
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
