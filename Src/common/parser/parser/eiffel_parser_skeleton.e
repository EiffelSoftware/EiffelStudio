indexing

	description: "Eiffel parser skeletons"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class EIFFEL_PARSER_SKELETON

inherit

	YY_NEW_PARSER_SKELETON
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
			reset
		end

	SHARED_PARSER_FILE_BUFFER
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
			id_level := Normal_level
			create counters.make (Initial_counters_capacity)
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

feature -- STatus report

	has_parsing_type: BOOLEAN is
			-- Has parsing type been specified?
		do
			Result := il_parser or type_parser or expression_parser or
				indexing_parser or entity_declaration_parser
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
			id_level := Normal_level
			has_externals := False
			once_manifest_string_count := 0
			counters.wipe_out
		end

feature -- Status report

	il_parser: BOOLEAN
			-- Is current Eiffel parser an IL Eiffel parser?

	type_parser: BOOLEAN
			-- Is current Eiffel parser a type parser?

	expression_parser: BOOLEAN
			-- Is current Eiffel parser an expression parser ?
			
	indexing_parser: BOOLEAN
			-- Is current Eiffel parser an indexing clause parser ?
	
	entity_declaration_parser: BOOLEAN
			-- Is current Eiffel parser a entity declaration parser ?
			
	has_externals: BOOLEAN
			-- Did last parse find external declarations?

feature -- Parsing

	parse (a_file: KL_BINARY_INPUT_FILE) is
			-- Parse Eiffel class text from `a_file'.
			-- Make result available in appropriate result node.
			-- An exception is raised if a syntax error is found.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		do
			reset_nodes
			File_buffer.set_file (a_file)
			input_buffer := File_buffer
			yy_load_input_buffer
			filename := a_file.name
			yyparse
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
		do
			reset_nodes
			create input_buffer.make (a_string)
			yy_load_input_buffer
			yyparse
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

	indexing_node: INDEXING_CLAUSE_AS
			-- Indexing clause node of AST

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

feature -- Removal

	reset_nodes is
			-- Clean all top nodes.
		do
			root_node := Void
			type_node := Void
			expression_node := Void
			indexing_node := Void
			entity_declaration_node := Void
		ensure
			root_node_void: root_node = Void
			type_node_void: type_node = Void
			expression_node_void: expression_node = Void
			indexing_node_void: indexing_node = Void
			entity_declaration_node_void: entity_declaration_node = Void
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

	id_level: INTEGER
			-- Boolean for controlling the semantic
			-- action of rule `A_feature'

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

	is_separate: BOOLEAN
			-- Boolean mark for separate class

	is_frozen: BOOLEAN
			-- Boolean mark for frozen feature names

	initial_has_old_verbatim_strings_warning: BOOLEAN
			-- Value of `has_old_verbatim_strings_warning' when parser was started

	fclause_pos: LOCATION_AS
			-- To memorize the beginning of a feature clause

	fbody_pos: INTEGER
			-- To memorize the beginning of a feature body

	feature_indexes: INDEXING_CLAUSE_AS
			-- Indexing clause for an Eiffel feature.
			-- IL only

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

	add_counter is
			-- Register a new counter.
		do
			counters.force (0)
		ensure
			one_more: counters.count = old counters.count + 1
			value_zero: counter_value = 0
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

	counters: DS_ARRAYED_STACK [INTEGER]
			-- Counters currently in use by the parser
			-- to build lists of AST nodes with the right size.

feature {NONE} -- Actions

	new_class_description (n: ID_AS; n2: STRING_AS;
		is_d, is_e, is_s, is_fc, is_ex: BOOLEAN;
		first_ind, last_ind: INDEXING_CLAUSE_AS; g: EIFFEL_LIST [FORMAL_DEC_AS];
		p: EIFFEL_LIST [PARENT_AS]; c: EIFFEL_LIST [CREATE_AS]; co: EIFFEL_LIST [CONVERT_FEAT_AS];
		f: EIFFEL_LIST [FEATURE_CLAUSE_AS]; inv: INVARIANT_AS;
		s: SUPPLIERS_AS; o: STRING_AS; ed: LOCATION_AS): CLASS_AS is
			-- New CLASS AST node;
			-- Update the clickable list.
		local
			ext_name: STRING
		do
			if n2 /= Void then
				if not il_parser then
						-- Trigger a syntax error.
					raise_error
				else
					ext_name := n2.value
				end
			end
			Result := ast_factory.new_class_as (n, ext_name, is_d, is_e, is_s, is_fc, is_ex, first_ind,
				last_ind, g, p, c, co, f, inv, s, o, has_externals, ed)
		end

feature {NONE} -- ID factory

	new_none_id: ID_AS is
			-- New ID AST node for "NONE"
		do
			Result := ast_factory.new_filled_id_as (line, column, position, None_classname.count)
			if Result /= Void then
				Result.append (None_classname)
			end
		end

feature {NONE} -- String factory

	new_string (v: STRING): STRING_AS is
			-- New string AST node for `v'.
		require
			v_not_void: v /= Void
		do
			Result := ast_factory.new_string_as (v, line, column, position)
		end

	new_lt_string: STRING_AS is
			-- New string AST node for "<"
		do
			Result := new_string ("<")
		end

	new_le_string: STRING_AS is
			-- New string AST node for "<="
		do
			Result := new_string ("<=")
		end

	new_gt_string: STRING_AS is
			-- New string AST node for ">"
		do
			Result := new_string (">")
		end

	new_ge_string: STRING_AS is
			-- New string AST node for ">="
		do
			Result := new_string (">=")
		end

	new_minus_string: STRING_AS is
			-- New string AST node for "-"
		do
			Result := new_string ("-")
		end

	new_plus_string: STRING_AS is
			-- New string AST node for "+"
		do
			Result := new_string ("+")
		end

	new_star_string: STRING_AS is
			-- New string AST node for "*"
		do
			Result := new_string ("*")
		end

	new_slash_string: STRING_AS is
			-- New string AST node for "/"
		do
			Result := new_string ("/")
		end

	new_power_string: STRING_AS is
			-- New string AST node for "^"
		do
			Result := new_string ("^")
		end

	new_div_string: STRING_AS is
			-- New string AST node for "//"
		do
			Result := new_string ("//")
		end

	new_mod_string: STRING_AS is
			-- New string AST node for "\\"
		do
			Result := new_string ("\\")
		end

	new_and_string: STRING_AS is
			-- New string AST node for "and"
		do
			Result := new_string ("and")
		end

	new_and_then_string: STRING_AS is
			-- New string AST node for "and then"
		do
			Result := new_string ("and then")
		end

	new_implies_string: STRING_AS is
			-- New string AST node for "implies"
		do
			Result := new_string ("implies")
		end

	new_or_string: STRING_AS is
			-- New string AST node for "or"
		do
			Result := new_string ("or")
		end

	new_or_else_string: STRING_AS is
			-- New string AST node for "or else"
		do
			Result := new_string ("or else")
		end

	new_xor_string: STRING_AS is
			-- New string AST node for "xor"
		do
			Result := new_string ("xor")
		end

	new_not_string: STRING_AS is
			-- New string AST node for "not"
		do
			Result := new_string ("not")
		end

feature {NONE} -- Type factory

	new_class_type (an_id: ID_AS; generics: EIFFEL_LIST [TYPE_AS]; is_exp, is_sep: BOOLEAN): TYPE_AS is
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
				if none_classname.is_equal (class_name) then
					if generics /= Void then
						report_basic_generic_type_error
					end
					Result := ast_factory.new_none_type_as
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
									formal_type.is_expanded)
								l_new_formal.set_position (formal_type.position)
								Result := l_new_formal
									-- Jump out of the loop.
								formal_parameters.finish
							end
							formal_parameters.forth
						end
					end
					if Result = Void then
							-- It is a common class type.
						class_type := ast_factory.new_class_type_as (class_name, generics, is_exp, is_sep)
							-- Put the supplier in `suppliers'.
						suppliers.insert_supplier_id (class_name)
						Result := class_type
					end
				end
			end
		end

feature {NONE} -- Basic type factory

	new_integer_value (is_signed: BOOLEAN; sign_symbol: CHARACTER; a_type: TYPE_AS; buffer: STRING): INTEGER_AS is
			-- Create a new integer constant value
		require
			buffer_not_void: buffer /= Void
		local
			l_type: TYPE_A
		do
			if a_type /= Void then
				l_type := a_type.actual_type
			end
			if l_type /= Void then
				if not l_type.is_integer and not l_type.is_natural then
					report_invalid_type_for_integer_error (a_type, buffer)
				end
			end
			if buffer.is_integer then
				if is_signed then
					Result := ast_factory.new_integer_as (l_type, sign_symbol = '-', buffer)
				else
					Result := ast_factory.new_integer_as (l_type, False, buffer)
				end
			elseif
				buffer.item (1) = '0' and then
				buffer.item (2).lower = 'x'
			then
				if is_signed then
					Result := ast_factory.new_integer_hexa_as (l_type, sign_symbol, buffer)
				else
					Result := ast_factory.new_integer_hexa_as (l_type, '%U', buffer)
				end
			else
				if is_signed and sign_symbol = '-' then
						-- Add `-' for a better reporting.
					buffer.precede ('-')
				end
				report_integer_too_large_error (buffer)
					-- Dummy code (for error recovery) follows:
				Result := ast_factory.new_integer_as (l_type, False, "0")
			end
			if not Result.is_initialized then
				report_integer_too_large_error (buffer)
			end
			Result.set_position (line, column, position, buffer.count)
		end

	new_real_value (is_signed: BOOLEAN; sign_symbol: CHARACTER; a_type: TYPE_AS; buffer: STRING): REAL_AS is
			-- Create a new real constant value.
		require
			buffer_not_void: buffer /= Void
		local
			l_type: TYPE_A
		do
			if a_type /= Void then
				l_type := a_type.actual_type
			end
			if l_type /= Void then
				if not l_type.is_real_32 and not l_type.is_real_64 then
					report_invalid_type_for_real_error (a_type, buffer)
				end
			end
			if is_signed and sign_symbol = '-' then
				buffer.precede ('-')
			end
			Result := ast_factory.new_real_as (l_type, buffer)
			Result.set_position (line, column, position, buffer.count)
		end
		
feature {NONE} -- Error handling

	report_basic_generic_type_error is
			-- Basic types cannot have generic devivation.
		local
			an_error: BASIC_GEN_TYPE_ERR
		do
			create an_error.make (line, column, filename, "", False)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error
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
					"%" is not a valid type for real constant %"" + a_real + "%"", False)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error
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
					"%" is not a valid type for integer constant %"" + an_int + "%"", False)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error
		end

	report_integer_too_large_error (an_int: STRING) is
			-- `an_int', although only made up of digits, doesn't fit
			-- in an INTEGER (i.e. greater than maximum_integer_value).
		require
			an_int_not_void: an_int /= Void
		local
			an_error: SYNTAX_ERROR
		do
			fixme ("Change plain syntax error to Integer_too_large error when the corresponding validity rule is available.")
			create an_error.make (line, column, filename, "", False)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error
		end

	report_integer_too_small_error (an_int: STRING) is
			-- `an_int', although only made up of digits, doesn't fit
			-- in an INTEGER (i.e. less than minimum_integer_value).
		require
			an_int_not_void: an_int /= Void
		local
			an_error: SYNTAX_ERROR
		do
			fixme ("Change plain syntax error to Integer_too_small error when the corresponding validity rule is available.")
			create an_error.make (line, column, filename, "", False)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error
		end

	report_error (a_message: STRING) is
			-- A syntax error has been detected.
			-- Print error message.
		local
			an_error: SYNTAX_ERROR
		do
			create an_error.make (line, column, filename, "", False)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error
		end

feature {NONE} -- Constants

	Integer_8_classname: STRING is "INTEGER_8"
	Integer_16_classname: STRING is "INTEGER_16"
	Integer_classname: STRING is "INTEGER"
	Integer_64_classname: STRING is "INTEGER_64"
	Boolean_classname: STRING is "BOOLEAN"
	Character_classname: STRING is "CHARACTER"
	Wide_char_classname: STRING is "WIDE_CHARACTER"
	Double_classname: STRING is "DOUBLE"
	None_classname: STRING is "NONE"
	Pointer_classname: STRING is "POINTER"
	Real_classname: STRING is "REAL"

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

end -- class EIFFEL_PARSER_SKELETON


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
