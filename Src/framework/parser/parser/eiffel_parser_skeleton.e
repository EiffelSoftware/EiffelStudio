indexing

	description: "Eiffel parser skeletons"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class EIFFEL_PARSER_SKELETON

inherit

	YY_PARSER_SKELETON
		rename
			parse as yyparse,
			make as make_parser_skeleton
		redefine
			report_error, clear_all
		end

	EIFFEL_SCANNER
		rename
			make as make_eiffel_scanner,
			make_with_factory as make_eiffel_scanner_with_factory
		redefine
			reset, report_one_error
		end

	SHARED_PARSER_FILE_BUFFER
		export {NONE} all end

	PREDEFINED_NAMES
		export {NONE} all end

feature {NONE} -- Initialization

	make is
			-- Create a new pure Eiffel parser.
		local
			l_factory: AST_FACTORY
		do
			create l_factory
			make_with_factory (l_factory)
		end

	make_with_factory (a_factory: AST_FACTORY) is
		require
			a_factory_not_void: a_factory /= Void
		do
			make_eiffel_scanner_with_factory (a_factory)
			make_parser_skeleton
			create suppliers.make
			create formal_parameters.make (Initial_formal_parameters_capacity)
			formal_parameters.compare_objects
			is_supplier_recorded := True
			create counters.make (Initial_counters_capacity)
			create counters2.make (Initial_counters_capacity)
			create last_rsqure.make (initial_counters_capacity)
			create feature_stack.make (1)
			add_feature_frame
		end

feature -- Parser type setting

	set_il_parser is
			-- Create a new IL Eiffel parser.
		require
			parsing_type_not_set: not has_parsing_type
		do
			il_parser := True
		ensure
			il_parser: il_parser
			parsing_type_set: has_parsing_type
		end

	set_type_parser is
			-- Create a new Eiffel type parser.
		require
			parsing_type_not_set: not has_parsing_type
		do
			type_parser := True
		ensure
			type_parser: type_parser
			parsing_type_set: has_parsing_type
		end

	set_expression_parser is
			-- Create a new Eiffel expression parser.
		require
			parsing_type_not_set: not has_parsing_type
		do
			expression_parser := True
		ensure
			expression_parser: expression_parser
			parsing_type_set: has_parsing_type
		end

	set_feature_parser is
			-- Create a new Eiffel feature parser.
		require
			parsing_type_not_set: not has_parsing_type
		do
			feature_parser := True
		ensure
			feature_parser: feature_parser
			parsing_type_set: has_parsing_type
		end

	set_indexing_parser is
			-- Create a new Eiffel indexing clause parser.
		require
			parsing_type_not_set: not has_parsing_type
		do
			indexing_parser := True
		ensure
			indexing_parser: indexing_parser
			parsing_type_set: has_parsing_type
		end

	set_invariant_parser is
			-- Create a new Eiffel invariant clause parser.
		require
			parsing_type_not_set: not has_parsing_type
		do
			invariant_parser := True
		ensure
			invariant_parser: invariant_parser
			parsing_type_set: has_parsing_type
		end

	set_entity_declaration_parser is
			-- Create a new Eiffel entity decalration parser.
		require
			parsing_type_not_set: not has_parsing_type
		do
			entity_declaration_parser := True
		ensure
			entity_declaration_parser: entity_declaration_parser
			parsing_type_set: has_parsing_type
		end

feature -- Status report [hide]

	has_parsing_type: BOOLEAN is
			-- Has parsing type been specified?
		do
			Result := il_parser or type_parser or expression_parser or
				indexing_parser or entity_declaration_parser or invariant_parser or
				feature_parser
		end

feature -- Initialization

	reset is
			-- Reset Parser before parsing next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor
			create suppliers.make
			formal_parameters.wipe_out
			feature_stack.wipe_out
			add_feature_frame
			is_supplier_recorded := True
			is_constraint_renaming := False
			once_manifest_string_count := 0
			object_test_locals := Void
			counters.wipe_out
			last_rsqure.wipe_out
			current_class := Void
		end

feature -- Status report

	is_constraint_renaming: BOOLEAN
			-- Is the parser parsing a constraint renaming?

	is_parsing_class_head: BOOLEAN
			-- Is the parser parsing a class hed?

	il_parser: BOOLEAN
			-- Is current Eiffel parser an IL Eiffel parser?

	type_parser: BOOLEAN
			-- Is current Eiffel parser a type parser?

	expression_parser: BOOLEAN
			-- Is current Eiffel parser an expression parser ?

	feature_parser: BOOLEAN
			-- Is `Current' a feature parser?

	indexing_parser: BOOLEAN
			-- Is current Eiffel parser an indexing clause parser ?

	invariant_parser: BOOLEAN
			-- Is current Eiffel parser an invariant clause parser ?

	entity_declaration_parser: BOOLEAN
			-- Is current Eiffel parser a entity declaration parser ?

feature -- Parsing

	parse (a_file: KL_BINARY_INPUT_FILE) is
			-- Parse Eiffel class text from `a_file'.
			-- Make result available in appropriate result node.
			-- An exception is raised if a syntax error is found.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		do
			parse_class (a_file, Void)
		end

	parse_class (a_file: KL_BINARY_INPUT_FILE; a_class: ABSTRACT_CLASS_C) is
			-- Parse Eiffel class text from `a_file'.
			-- Make result available in appropriate result node.
			-- An exception is raised if a syntax error is found.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		local
			l_ast_factory: like ast_factory
			l_input_buffer: YY_FILE_BUFFER
		do
			reset_nodes
			l_input_buffer := File_buffer
			l_input_buffer.set_file (a_file)
			input_buffer := l_input_buffer

				-- Abstracted from 'yy_load_input_buffer' to reuse local.
			yy_set_content (l_input_buffer.content)
			yy_end := l_input_buffer.index
			yy_start := yy_end
			yy_line := l_input_buffer.line
			yy_column := l_input_buffer.column
			yy_position := l_input_buffer.position

			filename := a_file.name
			l_ast_factory := ast_factory
			l_ast_factory.create_match_list (initial_match_list_size)
			current_class := a_class
			yyparse
			match_list := l_ast_factory.match_list
			reset
		rescue
			reset
		end

	parse_from_string (a_string: STRING) is
			-- Parse Eiffel class text in `a_string'.
			-- Make result available in appropriate result node.
			-- An exception is raised if a syntax error is found.
		require
			a_string_not_void: a_string /= Void
		local
			l_ast_factory: like ast_factory
			l_input_buffer: YY_BUFFER
		do
			reset_nodes

			create l_input_buffer.make (a_string)
			input_buffer := l_input_buffer

				-- Abstracted from 'yy_load_input_buffer' to reuse local
			yy_set_content (l_input_buffer.content)
			yy_end := l_input_buffer.index
			yy_start := yy_end
			yy_line := l_input_buffer.line
			yy_column := l_input_buffer.column
			yy_position := l_input_buffer.position

			l_ast_factory := ast_factory
			l_ast_factory.create_match_list (initial_match_list_size)
			yyparse
			match_list := l_ast_factory.match_list
			reset
		rescue
			reset
		end

feature -- Access: result nodes

	root_node: CLASS_AS
			-- Root node of AST

	type_node: TYPE_AS
			-- Type node of AST

	expression_node: EXPR_AS
			-- Expression node of AST

	feature_node: FEATURE_AS
			-- Feature node of AST

	indexing_node: INDEXING_CLAUSE_AS
			-- Indexing clause node of AST

	invariant_node: INVARIANT_AS
			-- Invariant node of AST

	entity_declaration_node: EIFFEL_LIST [TYPE_DEC_AS]
			-- Local clause node of AST

feature -- Access

	suppliers: SUPPLIERS_AS
			-- Suppliers of class being parsed

	formal_parameters: ARRAYED_LIST [FORMAL_AS]
			-- Name of formal generic parameters
			-- of class being parsed

	formal_generics_end_position: INTEGER
			-- End of formal generics, if present

	inheritance_end_position: INTEGER
			-- End of inheritance clause

	features_end_position: INTEGER
			-- End of feature clauses

	invariant_end_position: INTEGER
			-- End of invariant

	once_manifest_string_count: INTEGER
			-- Number of once manifest strings in current feature declaration
			-- or in an invariant

	object_test_locals: ARRAYED_LIST [TUPLE [ID_AS, TYPE_AS]]
			-- List of object test locals found
			-- in the current feature declaration

	feature_clause_end_position: INTEGER
			-- End of a feature clause

feature -- Removal

	reset_nodes is
			-- Clean all top nodes.
		do
			root_node := Void
			type_node := Void
			expression_node := Void
			indexing_node := Void
			entity_declaration_node := Void
			object_test_locals := Void
			match_list := Void
		ensure
			root_node_void: root_node = Void
			type_node_void: type_node = Void
			expression_node_void: expression_node = Void
			indexing_node_void: indexing_node = Void
			entity_declaration_node_void: entity_declaration_node = Void
			object_test_locals_void: object_test_locals = Void
			match_list_void: match_list = Void
		end

	wipe_out is
			-- Release unused objects to garbage collector.
		do
			reset_nodes
			clear_stacks
		ensure
			root_node_void: root_node = Void
			type_node_void: type_node = Void
			expression_node_void: expression_node = Void
			indexing_node_void: indexing_node = Void
			entity_declaration_node_void: entity_declaration_node = Void
		end

	clear_all is
			-- Clear temporary objects so that they can be collected
			-- by the garbage collector. (This routine is called by
			-- `parse' before exiting.)
		do
		end

feature {NONE} -- Implementation

	set_is_parsing_class_head (a_flag_value: BOOLEAN)
			-- Set is_parsing_class_head to `a_flag_value'.
		do
			is_parsing_class_head := a_flag_value
		ensure
			is_parsing_class_head_is_set: is_parsing_class_head = a_flag_value
		end

	id_level: INTEGER is
			-- Boolean for controlling the semantic
			-- action of rule `A_feature'
		require
			not feature_stack.is_empty
		do
			Result := feature_stack.item.id_level
		end

	set_id_level (a_id_level: INTEGER) is
			-- Sets the current id_level to `a_id_level'
		require
			not feature_stack.is_empty
		do
			feature_stack.item.id_level := a_id_level
		end

	fbody_pos: INTEGER is
			-- To memorize the beginning of a feature body
		require
			not feature_stack.is_empty
		do
			Result := feature_stack.item.fbody_pos
		end

	set_fbody_pos (a_fbody_pos: INTEGER) is
		require
			not feature_stack.is_empty
		do
			feature_stack.item.fbody_pos := a_fbody_pos
		end

	feature_stack: DS_ARRAYED_STACK [TUPLE [id_level, fbody_pos: INTEGER]]
			-- id_level and fbody_pos are needed per feature body. Since there are inline agents
			-- we need a stack of them. It may be, that there is no feature at all when its used
			-- for an invariant. We never remove the first element of the stack.

	add_feature_frame is
		do
			feature_stack.force ([Normal_level, 0])
		end

	remove_feature_frame
		require
			feature_stack.count > 1
		do
			feature_stack.remove
		end

	is_deferred: BOOLEAN
			-- Boolean mark for deferred class

	is_expanded: BOOLEAN
			-- Boolean mark for expanded class

	is_frozen_class: BOOLEAN
			-- Boolean mark for sealed/frozen class, ie not
			-- inheritable by other classes.

	is_external_class: BOOLEAN
			-- Boolean mark for class that should not be generated
			-- by Eiffel compiler since they are already generated
			-- within runtime environment.

	is_partial_class: BOOLEAN
			-- Boolean mark for class whose definition if spread
			-- amongst multiple files.

	is_separate: BOOLEAN
			-- Boolean mark for separate class

	has_convert_mark: BOOLEAN
			-- Boolean mark for alias names with convert mark

	conforming_inheritance_flag: BOOLEAN
			-- Flag for declaring when conforming inheritance has been added.

	non_conforming_inheritance_flag: BOOLEAN
			-- Flag for declaring when non conforming inheritance has been added.

	has_type: BOOLEAN
			-- Is expression undoubtly typed?

	initial_has_old_verbatim_strings_warning: BOOLEAN
			-- Value of `has_old_verbatim_strings_warning' when parser was started

	fclause_pos: KEYWORD_AS
			-- To memorize the beginning of a feature clause

	feature_indexes: INDEXING_CLAUSE_AS
			-- Indexing clause for an Eiffel feature.
			-- IL only

	frozen_keyword,
	expanded_keyword,
	deferred_keyword,
	separate_keyword,
	external_keyword: KEYWORD_AS
			-- Keywords that may appear in header mark of a class

	ast_location: LOCATION_AS
			-- Temp location

	constraining_type_list: CONSTRAINT_LIST_AS
			-- Temp list of constraining types.

	last_class_type: CLASS_TYPE_AS
			-- Temporary local in semantic actions when
			-- performing assignment attempts.

	last_identifier_list: IDENTIFIER_LIST
			-- Temporary locals in semantic actions.

	last_type_list: TYPE_LIST_AS
			-- Temporary locals in semantic actions.

	last_type: TYPE_AS
			-- Temporary locals in semantic actions.

	last_symbol: SYMBOL_AS
			-- Temporary locals in semantic actions.

	last_rsqure: DS_ARRAYED_STACK [SYMBOL_AS]
			-- Stack of ']'s used for parsing named tuples

feature {NONE} -- Counters

	counter_value: INTEGER is
			-- Value of the last counter registered
		require
			counters_not_empty: not counters.is_empty
		do
			Result := counters.item
		ensure
			value_positive: Result >= 0
		end

	counter2_value: INTEGER is
			-- Value of the last counter registered
		require
			counters2_not_empty: not counters2.is_empty
		do
			Result := counters2.item
		ensure
			value_positive: Result >= 0
		end

	add_counter is
			-- Register a new counter.
		do
			counters.force (0)
		ensure
			one_more: counters.count = old counters.count + 1
			value_zero: counter_value = 0
		end

	add_counter2 is
			-- Register a new counter.
		do
			counters2.force (0)
		ensure
			one_more: counters2.count = old counters2.count + 1
			value_zero: counter2_value = 0
		end

	remove_counter is
			-- Unregister last registered counter.
		require
			counters_not_empty: not counters.is_empty
		do
			counters.remove
		ensure
			one_less: counters.count = old counters.count - 1
		end

	remove_counter2 is
			-- Unregister last registered counter.
		require
			counters2_not_empty: not counters2.is_empty
		do
			counters2.remove
		ensure
			one_less: counters2.count = old counters2.count - 1
		end

	increment_counter is
			-- Increment `counter_value'.
		require
			counters_not_empty: not counters.is_empty
		local
			a_value: INTEGER
		do
			a_value := counters.item
			counters.replace (a_value + 1)
		ensure
			same_counters_count: counters.count = old counters.count
			one_more: counter_value = old counter_value + 1
		end

	increment_counter2 is
			-- Increment `counter_value'.
		require
			counters2_not_empty: not counters2.is_empty
		local
			a_value: INTEGER
		do
			a_value := counters2.item
			counters2.replace (a_value + 1)
		ensure
			same_counters2_count: counters2.count = old counters2.count
			one_more: counter2_value = old counter2_value + 1
		end

	counters: DS_ARRAYED_STACK [INTEGER]
			-- Counters currently in use by the parser
			-- to build lists of AST nodes with the right size.

	counters2: DS_ARRAYED_STACK [INTEGER]
			-- Counters used for parsing tuples

feature {NONE} -- Actions

	new_class_description (n: ID_AS; n2: STRING_AS;
		is_d, is_e, is_s, is_fc, is_ex, is_par: BOOLEAN;
		first_ind, last_ind: INDEXING_CLAUSE_AS; g: EIFFEL_LIST [FORMAL_DEC_AS];
		a_parent_list_1: PARENT_LIST_AS; a_parent_list_2: PARENT_LIST_AS; c: EIFFEL_LIST [CREATE_AS]; co: CONVERT_FEAT_LIST_AS;
		f: EIFFEL_LIST [FEATURE_CLAUSE_AS]; inv: INVARIANT_AS;
		s: SUPPLIERS_AS; o: STRING_AS; ed: KEYWORD_AS): CLASS_AS is
			-- New CLASS AST node;
			-- Update the clickable list.
		local
			ext_name: STRING_AS
			l_conforming_parents, l_non_conforming_parents: PARENT_LIST_AS
		do
			if n2 /= Void then
				if not il_parser then
						-- Trigger a syntax error.
					raise_error
				else
					ext_name := n2
				end
			end

			if non_conforming_inheritance_flag and then a_parent_list_2 = Void then
					-- No conforming inheritance has been specified, so `a_parent_list_1' is non-conforming
				l_conforming_parents := Void
				l_non_conforming_parents := a_parent_list_1
			else
				l_conforming_parents := a_parent_list_1
				l_non_conforming_parents := a_parent_list_2
			end

			Result := ast_factory.new_class_as (n, ext_name, is_d, is_e, is_s, is_fc, is_ex, is_par, first_ind,
				last_ind, g, l_conforming_parents, l_non_conforming_parents, c, co, f, inv, s, o, ed)
		end

feature {NONE} -- ID factory

	new_none_id: NONE_ID_AS is
			-- New ID AST node for "NONE"
		do
			Result := ast_factory.new_filled_none_id_as (line, column, position, 4)
		end

feature {NONE} -- Type factory

	is_supplier_recorded: BOOLEAN
			-- Are suppliers recorded in `suppliers'?

	new_class_type (an_id: ID_AS; generics: TYPE_LIST_AS; attachment_mark: SYMBOL_AS): TYPE_AS is
			-- New class type (Take care of formal generics);
			-- Update the clickable list and register the resulting
			-- type as a supplier of the class being parsed.
		local
			class_name: ID_AS
			formal_type, l_new_formal: FORMAL_AS
			class_type: CLASS_TYPE_AS
		do
			if an_id /= Void then
				class_name := an_id

				if none_class_name_id = class_name.name_id then
					if generics /= Void then
						report_basic_generic_type_error
					end
					Result := ast_factory.new_none_type_as (an_id)
				else
					if generics = Void then
						from
							formal_parameters.start
						until
							formal_parameters.after
						loop
							formal_type := formal_parameters.item
							if class_name.is_equal (formal_type.name) then
									-- Shouldn't we just remove the formal type
									-- name from the clickable list instead? (ericb)
								l_new_formal := ast_factory.new_formal_as (an_id, formal_type.is_reference,
									formal_type.is_expanded, Void)
								l_new_formal.set_position (formal_type.position)
								l_new_formal.set_attachment_mark (attachment_mark)
								Result := l_new_formal
									-- Jump out of the loop.
								formal_parameters.finish
							end
							formal_parameters.forth
						end
					end
					if Result = Void then
							-- It is a common class type.
						class_type := ast_factory.new_class_type_as (class_name, generics, attachment_mark)
						if is_supplier_recorded then
								-- Put the supplier in `suppliers'.
							suppliers.insert_supplier_id (class_name)
						end
						Result := class_type
					end
				end
			end
		end

feature {NONE} -- Instruction factory

	new_call_instruction_from_expression (e: EXPR_AS): INSTR_CALL_AS is
			-- Check if expression `e' represents a call
			-- and create a call instruction from it if this is the case.
			-- Report syntax error otherwise.
		local
			expr_call: EXPR_CALL_AS
			call: CALL_AS
			leaf: LEAF_AS
			creation_expr: CREATION_EXPR_AS
		do
			expr_call ?= e
			if expr_call /= Void then
					-- This is a call. Let's check if it is a normal feature call.
				call ?= expr_call.call
				leaf ?= call
				creation_expr ?= call
				if leaf /= Void or else creation_expr /= Void then
						-- This is not a normal feature call.
					call := Void
				end
			end
			if call = Void then
					-- Report error.
				report_one_error (create {SYNTAX_ERROR}.make (line, column, filename, "Expression cannot be used as an instruction"))
			else
					-- Make a call instruction.
				Result := ast_factory.new_instr_call_as (call)
			end
		end

feature {AST_FACTORY} -- Error handling

	report_basic_generic_type_error is
			-- Basic types cannot have generic devivation.
		local
			an_error: BASIC_GEN_TYPE_ERR
		do
			create an_error.make (line, column, filename, "")
			report_one_error (an_error)
		end

	report_invalid_type_for_real_error (a_type: TYPE_AS; a_real: STRING) is
			-- Error when an incorrect type `a_type' is specified for a real constant `a_real'.
		require
			a_type_not_void: a_type /= Void
			a_real_not_void: a_real /= Void
		local
			an_error: SYNTAX_ERROR
		do
			create an_error.make (line, column, filename,
				"Specified type %"" + a_type.dump +
					"%" is not a valid type for real constant %"" + a_real + "%"")
			report_one_error (an_error)
		end

	report_invalid_type_for_integer_error (a_type: TYPE_AS; an_int: STRING) is
			-- Error when an incorrect type `a_type' is specified for a real constant `a_real'.
		require
			a_type_not_void: a_type /= Void
			an_int_not_void: an_int /= Void
		local
			an_error: SYNTAX_ERROR
		do
			create an_error.make (line, column, filename,
				"Specified type %"" + a_type.dump +
					"%" is not a valid type for integer constant %"" + an_int + "%"")
			report_one_error (an_error)
		end

	report_integer_too_large_error (a_type: TYPE_AS; an_int: STRING) is
			-- `an_int', although only made up of digits, doesn't fit
			-- in an INTEGER (i.e. greater than maximum_integer_value).
		require
			an_int_not_void: an_int /= Void
		local
			an_error: SYNTAX_ERROR
			l_message: STRING
		do
			fixme ("Change plain syntax error to Integer_too_large error when the corresponding validity rule is available.")
			if a_type /= Void then
				l_message := "Integer value " + an_int + " is too large for " + a_type.dump + "."
			else
				l_message := "Integer value " + an_int + " is too large for any integer type."
			end
			create an_error.make (line, column, filename, l_message)
			report_one_error (an_error)
		end

	report_integer_too_small_error (a_type: TYPE_AS; an_int: STRING) is
			-- `an_int', although only made up of digits, doesn't fit
			-- in an INTEGER (i.e. less than minimum_integer_value).
		require
			an_int_not_void: an_int /= Void
		local
			an_error: SYNTAX_ERROR
			l_message: STRING
		do
			fixme ("Change plain syntax error to Integer_too_small error when the corresponding validity rule is available.")
			if a_type /= Void then
				l_message := "Integer value " + an_int + " is too small for " + a_type.dump + "."
			else
				l_message := "Integer value " + an_int + " is too small for any integer type."
			end
			create an_error.make (line, column, filename, l_message)
			report_one_error (an_error)
		end

	report_character_code_too_large_error (a_code: STRING) is
			-- Integer encoded by `a_code' is too large to fit into a CHARACTER_32
		require
			a_code_not_void: a_code /= Void
		local
			l_message: STRING
			an_error: BAD_CHARACTER
		do
			l_message := "Character code " + a_code + " is too large for CHARACTER_32."
			create an_error.make (line, column, filename, l_message)
			report_one_error (an_error)
		end

	report_one_error (a_error: ERROR) is
			-- An error was reported.
		do
			Precursor (a_error)
				-- To avoid reporting more than one error for the same syntax error
				-- we simply abort the parsing.
			abort
		end

	report_error (a_message: STRING) is
			-- A syntax error has been detected.
			-- Print error message.
		do
			report_one_error (create {SYNTAX_ERROR}.make (line, column, filename, ""))
		end

feature{NONE} -- Roundtrip

	temp_string_as1: STRING_AS
	temp_string_as2: STRING_AS
	temp_keyword_as: KEYWORD_AS
	temp_class_type_as: CLASS_TYPE_AS
	temp_operand_as: OPERAND_AS
	temp_address_current_as: ADDRESS_CURRENT_AS
	temp_address_result_as: ADDRESS_RESULT_AS

feature {NONE} -- Constants

	Initial_counters_capacity: INTEGER is 20
			-- Initial capacity for `counters'

	Initial_formal_parameters_capacity: INTEGER is 8
				-- Initial capacity for `formal_parameters'
				-- (See `eif_rtlimits.h')

	Normal_level: INTEGER is 0
	Assert_level: INTEGER is 1
	Invariant_level: INTEGER is 2

invariant

	suppliers_not_void: suppliers /= Void
	formal_parameters_not_void: formal_parameters /= Void
	no_void_formal_parameter: not formal_parameters.has (Void)
	valid_id_level: (id_level = Normal_level) or
		(id_level = Assert_level) or (id_level = Invariant_level)
	is_external_class_not_set: not il_parser implies not is_external_class
	is_partial_class_not_set: not il_parser implies not is_partial_class

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

end -- class EIFFEL_PARSER_SKELETON

