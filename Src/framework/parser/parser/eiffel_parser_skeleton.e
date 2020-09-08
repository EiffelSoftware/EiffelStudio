note
	description: "Eiffel parser skeleton."

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

	SHARED_ENCODING_CONVERTER
		export {ANY} encoding_converter end

	SHARED_LOCALE
		export {NONE} all end

	INTERNAL_COMPILER_STRING_EXPORTER
		export {NONE} all end

feature {NONE} -- Initialization

	make
			-- Create a new pure Eiffel parser.
		do
			make_with_factory (create {AST_FACTORY})
		end

	make_with_factory (a_factory: AST_FACTORY)
		require
			a_factory_not_void: a_factory /= Void
		do
			create once_manifest_string_counters.make (initial_counters_capacity)
			create counters.make (Initial_counters_capacity)
			create counters2.make (Initial_counters_capacity)
			create last_rsqure.make (initial_counters_capacity)
			create feature_stack.make (1)
			create suppliers
			create formal_parameters.make (Initial_formal_parameters_capacity)

			create scopes.make (10)
			create scope_identifiers.make (10)

			make_parser_skeleton
			make_eiffel_scanner_with_factory (a_factory)

			formal_parameters.compare_objects
			is_supplier_recorded := True

			add_feature_frame
		end

feature -- Parser type setting

	set_il_parser
			-- Create a new IL Eiffel parser.
		require
			parsing_type_not_set: not has_parsing_type
		do
			il_parser := True
		ensure
			il_parser: il_parser
			parsing_type_set: has_parsing_type
		end

	set_type_parser
			-- Create a new Eiffel type parser.
		require
			parsing_type_not_set: not has_parsing_type
		do
			type_parser := True
		ensure
			type_parser: type_parser
			parsing_type_set: has_parsing_type
		end

	set_expression_parser
			-- Create a new Eiffel expression parser.
		require
			parsing_type_not_set: not has_parsing_type
		do
			expression_parser := True
		ensure
			expression_parser: expression_parser
			parsing_type_set: has_parsing_type
		end

	set_feature_parser
			-- Create a new Eiffel feature parser.
		require
			parsing_type_not_set: not has_parsing_type
		do
			feature_parser := True
		ensure
			feature_parser: feature_parser
			parsing_type_set: has_parsing_type
		end

	set_indexing_parser
			-- Create a new Eiffel indexing clause parser.
		require
			parsing_type_not_set: not has_parsing_type
		do
			indexing_parser := True
		ensure
			indexing_parser: indexing_parser
			parsing_type_set: has_parsing_type
		end

	set_invariant_parser
			-- Create a new Eiffel invariant clause parser.
		require
			parsing_type_not_set: not has_parsing_type
		do
			invariant_parser := True
		ensure
			invariant_parser: invariant_parser
			parsing_type_set: has_parsing_type
		end

	set_entity_declaration_parser
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

	has_parsing_type: BOOLEAN
			-- Has parsing type been specified?
		do
			Result := il_parser or type_parser or expression_parser or
				indexing_parser or entity_declaration_parser or invariant_parser or
				feature_parser
		end

feature -- Initialization

	reset
			-- Reset Parser before parsing next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor
			create suppliers
			feature_stack.wipe_out
			scopes.wipe_out
			scope_identifiers.wipe_out
			is_supplier_recorded := True
			is_constraint_renaming := False
			object_test_locals := Void
			counters.wipe_out
			counters2.wipe_out
			once_manifest_string_counters.wipe_out
			last_rsqure.wipe_out
			current_class := Void
			is_ignoring_attachment_marks := False
			is_frozen_class := False
			is_external_class := False
			is_partial_class := False
			is_deferred := False
			is_expanded := False
			is_once := False
			deferred_keyword := Void
			expanded_keyword := Void
			once_keyword := Void
			external_keyword := Void
			frozen_keyword := Void
				-- Add a frame for a top-level feature.
			add_feature_frame
		end

feature -- Status report

	is_constraint_renaming: BOOLEAN
			-- Is the parser parsing a constraint renaming?

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

	is_ignoring_attachment_marks: BOOLEAN
			-- Are we simply ignoring attachment marks while parsing?

	is_ignoring_variance_mark: BOOLEAN
			-- Are frozen/variant annotations kept in the parsed AST?
		do
				-- If the syntax is not provisional, we accept the
				-- frozen/variant annotations but won't record them.
			Result := syntax_version /= provisional_syntax
		end

	is_type_inference_supported: BOOLEAN
			-- Is type inference supported so that some type declarations are optional?
		do
			Result := True
		end

feature -- Parsing (Unknown encoding)

	parse (a_file: KL_BINARY_INPUT_FILE)
			-- Parse Eiffel class text from `a_file'.
			-- Make result available in appropriate result node.
			-- An exception is raised if a syntax error is found.
			--
			-- Encoding detection priority:
			-- 1. Detect BOM from `a_file', use the detected encoding.
			-- 2. Default to ASCII (ISO-8859-1) encoding.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		do
			parse_class_from_file (a_file, Void, Void)
		end

	parse_class (a_class: ABSTRACT_CLASS_C)
			-- Parse class `a_class'
			-- Make result available in appropriate result node.
			-- An exception is raised if a syntax error is found.
			--
			-- Encoding detection priority:
			-- 1. Detect BOM from text of `a_class', use the detected encoding.
			-- 2. Use the encoding specified in the context of `a_class' (.ecf)
			-- 3. Default to ASCII (ISO-8859-1) encoding.
		require
			a_class_not_void: a_class /= Void
			a_class_has_text: a_class.has_text
		do
			filename := a_class.file_name
			if attached a_class.text as l_class_text then
				parse_from_utf8_string (l_class_text, a_class)
			else
				reset_nodes
			end
			detected_encoding := a_class.encoding
			detected_bom := a_class.bom
		end

	parse_class_from_string (a_string: STRING; a_class: detachable ABSTRACT_CLASS_C; a_encoding: detachable ENCODING)
			-- Parse Eiffel class text from `a_string'.
			-- Make result available in appropriate result node.
			-- An exception is raised if a syntax error is found.
			--
			-- Encoding detection priority:
			-- 1. If `a_encoding' is attached, use it as the encoding of `a_file'
			-- 2. Detect BOM from `a_string', use the detected encoding.
			-- 3. Use the encoding specified in the context of `a_class' (.ecf)
			-- 4. Default to ASCII (ISO-8859-1) encoding.
		require
			a_string_not_void: a_string /= Void
		local
			l_ast_factory: like ast_factory
			l_input_buffer: detachable like input_buffer
		do
			reset_nodes

			if attached a_encoding then
				l_input_buffer := encoding_converter.input_buffer_from_string_of_encoding (a_string, a_encoding)
				detected_encoding := a_encoding
				detected_bom := Void
			else
				l_input_buffer := encoding_converter.input_buffer_from_string (a_string, a_class)
				detected_encoding := encoding_converter.detected_encoding
				detected_bom := encoding_converter.last_bom
			end
			if attached a_class then
				a_class.set_encoding_and_bom (detected_encoding, detected_bom)
			end
					-- Only if we can get a buffer can we parse, otherwise it is an error
			if attached l_input_buffer then
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
				current_class := a_class
				yyparse
				match_list := l_ast_factory.match_list
			else
				abort
			end
			reset
		rescue
			reset
		end

	parse_class_from_file (a_file: KL_BINARY_INPUT_FILE; a_class: detachable ABSTRACT_CLASS_C; a_encoding: detachable ENCODING)
			-- Parse Eiffel class text from `a_file'.
			-- Make result available in appropriate result node.
			-- An exception is raised if a syntax error is found.
			--
			-- Encoding detection priority:
			-- 1. If `a_encoding' is attached, use it as the encoding of `a_file'
			-- 2. Detect BOM from `a_file', use the detected encoding.
			-- 3. Use the encoding specified in the context of `a_class' (.ecf)
			-- 4. Default to ASCII (ISO-8859-1) encoding.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		local
			l_ast_factory: like ast_factory
			l_input_buffer: detachable YY_BUFFER
		do
			reset_nodes
			if attached a_encoding then
				l_input_buffer := encoding_converter.input_buffer_from_file_of_encoding (a_file, a_encoding)
				detected_encoding := a_encoding
				detected_bom := Void
			else
				l_input_buffer := encoding_converter.input_buffer_from_file (a_file, a_class)
				detected_encoding := encoding_converter.detected_encoding
				detected_bom := encoding_converter.last_bom
			end
			if attached a_class then
				a_class.set_encoding_and_bom (detected_encoding, detected_bom)
			end
			if l_input_buffer /= Void then
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
			else
				abort
			end
			reset
		rescue
			reset
		end

feature -- Parsing (Known encoding)

	parse_from_ascii_string (a_string: STRING; a_class: ABSTRACT_CLASS_C)
			-- Parse Eiffel class text in ASCII (ISO-8859-1) `a_string'.
			-- Make result available in appropriate result node.
			-- An exception is raised if a syntax error is found.
		require
			a_string_not_void: a_string /= Void
		local
			l_ast_factory: like ast_factory
			l_input_buffer: YY_BUFFER
		do
			reset_nodes

			l_input_buffer := encoding_converter.input_buffer_from_ascii_string (a_string)
			input_buffer := l_input_buffer
			detected_encoding := encoding_converter.detected_encoding
			detected_bom := encoding_converter.last_bom
			if attached a_class then
				a_class.set_encoding_and_bom (detected_encoding, detected_bom)
			end

				-- Abstracted from 'yy_load_input_buffer' to reuse local
			yy_set_content (l_input_buffer.content)
			yy_end := l_input_buffer.index
			yy_start := yy_end
			yy_line := l_input_buffer.line
			yy_column := l_input_buffer.column
			yy_position := l_input_buffer.position

			l_ast_factory := ast_factory
			l_ast_factory.create_match_list (initial_match_list_size)
			current_class := a_class
			yyparse
			match_list := l_ast_factory.match_list
			reset
		rescue
			reset
		end

	parse_from_utf8_string (a_string: STRING_8; a_class: detachable ABSTRACT_CLASS_C)
			-- Parse Eiffel class text in UTF-8 `a_string'.
			-- Make result available in appropriate result node.
			-- An exception is raised if a syntax error is found.
		require
			a_string_not_void: a_string /= Void
		local
			l_ast_factory: like ast_factory
			l_input_buffer: YY_UNICODE_BUFFER
		do
			reset_nodes

			create l_input_buffer.make_from_utf8_string (a_string)
			input_buffer := l_input_buffer

			detected_encoding := utf8
			detected_bom := Void
			if attached a_class then
				a_class.set_encoding_and_bom (detected_encoding, detected_bom)
			end

				-- Abstracted from 'yy_load_input_buffer' to reuse local
			yy_set_content (l_input_buffer.content)
			yy_end := l_input_buffer.index
			yy_start := yy_end
			yy_line := l_input_buffer.line
			yy_column := l_input_buffer.column
			yy_position := l_input_buffer.position

			l_ast_factory := ast_factory
			l_ast_factory.create_match_list (initial_match_list_size)
			current_class := a_class
			yyparse
			match_list := l_ast_factory.match_list
			reset
		rescue
			reset
		end

	parse_from_string_32 (a_string: STRING_32; a_class: detachable ABSTRACT_CLASS_C)
			-- Parse Eiffel class text in `a_string'. `a_string' is in UTF-32.
			-- Make result available in appropriate result node.
			-- An exception is raised if a syntax error is found.
		require
			a_string_not_void: a_string /= Void
		do
			parse_from_utf8_string (encoding_converter.utf32_to_utf8 (a_string), a_class)
			detected_encoding := utf32
			detected_bom := Void
		end

feature -- Access: result nodes

	root_node: detachable CLASS_AS
			-- Root node of AST

	type_node: detachable TYPE_AS
			-- Type node of AST

	expression_node: detachable EXPR_AS
			-- Expression node of AST

	feature_node: detachable FEATURE_AS
			-- Feature node of AST

	indexing_node: detachable INDEXING_CLAUSE_AS
			-- Indexing clause node of AST

	invariant_node: detachable INVARIANT_AS
			-- Invariant node of AST

	entity_declaration_node: detachable EIFFEL_LIST [LIST_DEC_AS]
			-- Local clause node of AST

feature -- Access

	suppliers: SUPPLIERS_AS
			-- Suppliers of class being parsed

	formal_parameters: ARRAYED_LIST [FORMAL_AS]
			-- Name of formal generic parameters
			-- of class being parsed

	formal_generics_end_position: INTEGER
			-- End of formal generics, if present

	conforming_inheritance_end_position: INTEGER
			-- End of conforming inheritance clause

	non_conforming_inheritance_end_position: INTEGER
			-- End of non-conforming inheritance clause

	features_end_position: INTEGER
			-- End of feature clauses

	invariant_end_position: INTEGER
			-- End of invariant

	feature_clause_end_position: INTEGER
			-- End of a feature clause

	formal_generics_character_end_position: INTEGER
			-- Character end of formal generics, if present

	conforming_inheritance_character_end_position: INTEGER
			-- Character end of conforming inheritance clause

	non_conforming_inheritance_character_end_position: INTEGER
			-- Character end of non-conforming inheritance clause

	features_character_end_position: INTEGER
			-- Character end of feature clauses

	invariant_character_end_position: INTEGER
			-- Character end of invariant

	feature_clause_character_end_position: INTEGER
			-- Character end of a feature clause

feature -- Status Change

	set_formal_generics_end_positions (a_reset: BOOLEAN)
			-- Set formal generics end positions.
		do
			if a_reset then
				formal_generics_end_position := 0
				formal_generics_character_end_position := 0
			else
				formal_generics_end_position := position
				formal_generics_character_end_position := character_position
			end
		end

	set_conforming_inheritance_end_positions
			-- Set conforming inheritance end positions
		do
			conforming_inheritance_end_position := position
			conforming_inheritance_character_end_position := character_position
		end

	set_non_conforming_inheritance_end_positions
			-- Set non conforming inheritance end positions
		do
			non_conforming_inheritance_end_position := position
			non_conforming_inheritance_character_end_position := character_position
		end

	set_features_end_positions
			-- Set features end positions
		do
			features_end_position := position
			features_character_end_position := character_position
		end

	set_invariant_end_positions
			-- Set invariant end positions
		do
			invariant_end_position := position
			invariant_character_end_position := character_position
		end

	set_feature_clause_end_positions
			-- Set feature clause end positions
		do
			feature_clause_end_position := position
			feature_clause_character_end_position := character_position
		end

feature -- Removal

	reset_nodes
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

	wipe_out
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

	clear_all
			-- Clear temporary objects so that they can be collected
			-- by the garbage collector. (This routine is called by
			-- `parse' before exiting.)
		do
		end

feature -- Settings

	set_is_ignoring_attachment_marks (v: like is_ignoring_attachment_marks)
			-- Set `is_ignoring_attachment_marks' to `v'.
		do
			is_ignoring_attachment_marks := v
		ensure
			is_ignoring_attachment_marks_set: is_ignoring_attachment_marks = v
		end

feature -- Modification

	insert_supplier (name: STRING; location: detachable LOCATION_AS)
			-- Insert supplier of the given `name' at the given `location'.
		require
			name_attached: name /= Void
		local
			id: ID_AS
		do
				-- Similar to `new_class_type' the suppliers are not recorded
				-- if the given `location' is Void.
			if location /= Void then
				create id.initialize (name)
				id.set_position (location.line, location.column, location.position, location.location_count,
					location.character_column, location.character_position, location.character_count)
				suppliers.insert_supplier_id (id)
			end
		end

feature {NONE} -- Scopes

	scope_identifiers: ARRAYED_STACK [TUPLE [identifier: like {ID_AS}.name_id; identifier_kind: NATURAL_8]]
			-- Identifiers with scopes placed according to their nesting with associated kind:
			-- • formal argument;
			-- • local variable;
			-- • object test local;
			-- • iteration cursor;
			-- • separate variable.

	scopes: ARRAYED_STACK [like {ARRAYED_STACK [TUPLE]}.count]
			-- The number of elements in `scope_identifiers` before entering current scope.

	scope_kind_argument: NATURAL_8 = 1
			-- Scope kind for a formal argument.

	scope_kind_local: NATURAL_8 = 2
			-- Scope kind for a local variable.

	scope_kind_test: NATURAL_8 = 3
			-- Scope kind for an object test local.

	scope_kind_iteration: NATURAL_8 = 4
			-- Scope kind for an iteration cursor.

	scope_kind_separate: NATURAL_8 = 5
			-- Scope kind for a separate variable.

	enter_scope
			-- Enter a new scope of identifiers.
		do
			scopes.put (scope_identifiers.count)
		ensure
			is_scope_added: scopes.count = old scopes.count + 1
			is_scope_nested: scopes.item >= old if scopes.is_empty then 0 else scopes.item end
			is_scope_consistent: scopes.item = scope_identifiers.count
		end

	leave_scope
			-- Leave the current scope of identifiers.
		require
			has_scopes: not scopes.is_empty
			is_scope_consistent: scopes.item <= scope_identifiers.count
		local
			count: like scopes.item
		do
			from
				scopes.remove
				count := scope_identifiers.count - if scopes.is_empty then 0 else scopes.item end
			invariant
				count = scope_identifiers.count - if scopes.is_empty then 0 else scopes.item end
			until
				count <= 0
			loop
				scope_identifiers.remove
				count := count - 1
			end
		ensure
			is_scope_removed: scopes.count + 1 = old scopes.count
			is_scope_consistent: scope_identifiers.count = if scopes.is_empty then 0 else scopes.item end
		end

	add_scope_arguments (identifiers: ARRAYED_LIST [like {ID_AS}.name_id])
			-- Add scopes of formal arguments `ids`.
		do
			across
				identifiers as identifier
			loop
				scope_identifiers.put (identifier.item, scope_kind_argument)
			end
		end

	add_scope_locals (identifiers: ARRAYED_LIST [like {ID_AS}.name_id])
			-- Add scopes of local variables `ids`.
		do
			across
				identifiers as identifier
			loop
				scope_identifiers.put (identifier.item, scope_kind_local)
			end
		end

	add_scope_iteration (identifier: detachable ID_AS)
			-- Add a scope of an iteration cursor `identifier`.
		do
			if attached identifier then
				scope_identifiers.put (identifier.name_id, scope_kind_iteration)
			end
		end

	add_scope_separate (identifier: detachable ID_AS)
			-- Add a scope of a separate variable `identifier`.
		do
			if attached identifier then
				scope_identifiers.put (identifier.name_id, scope_kind_separate)
			end
		end

	add_scope_test (identifier: detachable ID_AS)
			-- Add a scope of an object test local `identifier`.
		do
			if attached identifier then
				scope_identifiers.put (identifier.name_id, scope_kind_test)
			end
		end

feature {NONE} -- Feature status

	is_class_feature: BOOLEAN
			-- Is current feature a class feature, i.e. has a class postcondition?
		require
			not feature_stack.is_empty
		do
			Result := feature_stack.item.is_class
		end

	has_non_object_call: BOOLEAN
			-- Is there a non-object call in the current feature?
		require
			not feature_stack.is_empty
		do
			Result := feature_stack.item.has_non_object_call
		end

	has_non_object_call_in_assertion: BOOLEAN
			-- Is there a non-object call in the current feature precondition or postcondition?
		require
			not feature_stack.is_empty
		do
			Result := feature_stack.item.has_non_object_call_in_assertion
		end

	has_unqualified_call_in_assertion: BOOLEAN
			-- Is there an unqualified object call in the current feature precondition or postcondition?
		require
			not feature_stack.is_empty
		do
			Result := feature_stack.item.has_unqualified_call_in_assertion
		end

feature {NONE} -- Feature status modification

	set_is_class_feature (value: BOOLEAN)
			-- Set `is_class_feature` to `value`.
		require
			not feature_stack.is_empty
		do
			feature_stack.item.is_class := value
		ensure
			is_class_feature_set: is_class_feature = value
		end

	set_has_non_object_call (value: BOOLEAN)
			-- Set `has_non_object_call` to `value`.
		require
			not feature_stack.is_empty
		do
			feature_stack.item.has_non_object_call := value
		ensure
			has_non_object_call_set: has_non_object_call = value
		end

	set_has_non_object_call_in_assertion (value: BOOLEAN)
			-- Set `has_non_object_call_in_assertion` to `value`.
		require
			not feature_stack.is_empty
		do
			feature_stack.item.has_non_object_call_in_assertion := value
		ensure
			has_non_object_call_in_assertion_set: has_non_object_call_in_assertion = value
		end

	set_has_unqualified_call_in_assertion (value: BOOLEAN)
			-- Set `has_unqualified_call_in_assertion` to `value`.
		require
			not feature_stack.is_empty
		do
			feature_stack.item.has_unqualified_call_in_assertion := value
		ensure
			has_unqualified_call_in_assertion_set: has_unqualified_call_in_assertion = value
		end

feature {NONE} -- Implementation

	id_level: INTEGER
			-- Boolean for controlling the semantic action of rule `A_feature'.
		require
			not feature_stack.is_empty
		do
			Result := feature_stack.item.id_level
		ensure
			is_valid_id_level: is_valid_id_level (Result)
		end

	set_id_level (a_id_level: INTEGER)
			-- Set the current id_level to `a_id_level'.
		require
			not feature_stack.is_empty
			is_valid_id_level: is_valid_id_level (a_id_level)
		do
			feature_stack.item.id_level := a_id_level
		ensure
			id_level_set: id_level = a_id_level
		end

	fbody_pos: INTEGER
			-- To memorize the beginning of a feature body
		require
			not feature_stack.is_empty
		do
			Result := feature_stack.item.fbody_pos
		end

	set_fbody_pos (a_fbody_pos: INTEGER)
		require
			not feature_stack.is_empty
		do
			feature_stack.item.fbody_pos := a_fbody_pos
		end

	feature_stack: ARRAYED_STACK [TUPLE [id_level, fbody_pos: INTEGER;
			is_class: BOOLEAN;
			has_non_object_call: BOOLEAN;
			has_non_object_call_in_assertion: BOOLEAN;
			has_unqualified_call_in_assertion: BOOLEAN
		]]
			-- id_level and fbody_pos are needed per feature body. Since there are inline agents
			-- we need a stack of them. It may be, that there is no feature at all when its used
			-- for an invariant. We never remove the first element of the stack.

	add_feature_frame
			-- Add a new frame to process a feature.
		do
			feature_stack.force ([Normal_level, 0, False, False, False, False])
			add_once_manifest_string_counter
		ensure
			feature_stack_allocated: feature_stack.count = old feature_stack.count + 1
			default_id_level: id_level = normal_level
			default_fbody_pos: fbody_pos = 0
			default_is_class_feature: not is_class_feature
			default_has_non_object_call: not has_non_object_call
			default_has_non_object_call_in_assertion: not has_non_object_call_in_assertion
			default_has_unqualified_call_in_assertion: not has_unqualified_call_in_assertion
			once_manifest_string_counters_allocated: once_manifest_string_counters.count = old once_manifest_string_counters.count + 1
			default_once_manifest_string_counter_value: once_manifest_string_counter_value = 0
		end

	remove_feature_frame
			-- Add a frame to process a feature.
		require
			feature_stack.count > 1
			once_manifest_string_counters.count > 1
		do
			feature_stack.remove
			remove_once_manifest_string_counter
		ensure
			feature_stack_descreased: feature_stack.count = old feature_stack.count - 1
			once_manifest_string_counters_descreased: once_manifest_string_counters.count = old once_manifest_string_counters.count - 1
		end

	reset_feature_frame
			-- Reset a top-level frame to the default state.
			-- This has to be done before processing a new top-level feature.
		require
			feature_stack_allocated: not feature_stack.is_empty
			default_id_level: id_level = normal_level
			once_manifest_string_counters_allocated: not once_manifest_string_counters.is_empty
		do
			once_manifest_string_counters.replace (0)
			set_is_class_feature (False)
			set_has_non_object_call (False)
			set_has_non_object_call_in_assertion (False)
			set_has_unqualified_call_in_assertion (False)
		ensure
			feature_stack_unchanged: feature_stack.count = old feature_stack.count
			default_is_class_feature: not is_class_feature
			default_has_non_object_call: not has_non_object_call
			default_has_non_object_call_in_assertion: not has_non_object_call_in_assertion
			default_has_unqualified_call_in_assertion: not has_unqualified_call_in_assertion
			once_manifest_string_counters_unchanged: once_manifest_string_counters.count = old once_manifest_string_counters.count
			default_once_manifest_string_counter_value: once_manifest_string_counter_value = 0
		end

	is_deferred: BOOLEAN
			-- Boolean mark for deferred class

	is_expanded: BOOLEAN
			-- Boolean mark for expanded class

	is_once: BOOLEAN
			-- Boolean mark for once class

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

	has_convert_mark: BOOLEAN
			-- Boolean mark for alias names with convert mark

	conforming_inheritance_flag: BOOLEAN
			-- Flag for declaring when conforming inheritance has been added.

	non_conforming_inheritance_flag: BOOLEAN
			-- Flag for declaring when non conforming inheritance has been added.

	fclause_pos: detachable KEYWORD_AS
			-- To memorize the beginning of a feature clause

	feature_indexes: detachable INDEXING_CLAUSE_AS
			-- Indexing clause for an Eiffel feature.
			-- IL only

	frozen_keyword,
	expanded_keyword,
	deferred_keyword,
	once_keyword,
	external_keyword: detachable KEYWORD_AS
			-- Keywords that may appear in header mark of a class

	last_rsqure: ARRAYED_STACK [detachable SYMBOL_AS]
			-- Stack of ']'s used for parsing named tuples

	object_test_locals: detachable ARRAYED_LIST [TUPLE [name: ID_AS; type: TYPE_AS]]
			-- List of object test locals found
			-- in the current feature declaration

	insert_object_test_locals (a_item: TUPLE [ID_AS, TYPE_AS])
			-- Insert `a_item' in `object_test_locals'.
		local
			l_locals: like object_test_locals
		do
			l_locals := object_test_locals
			if l_locals = Void then
				create l_locals.make (1)
				object_test_locals := l_locals
			end
			l_locals.extend (a_item)
		end

feature {NONE} -- Counters

	counter_value: INTEGER
			-- Value of the last counter registered
		require
			counters_not_empty: not counters.is_empty
		do
			Result := counters.item
		ensure
			value_positive: Result >= 0
		end

	counter2_value: INTEGER
			-- Value of the last counter registered
		require
			counters2_not_empty: not counters2.is_empty
		do
			Result := counters2.item
		ensure
			value_positive: Result >= 0
		end

	once_manifest_string_counter_value: INTEGER
			-- Value of the last counter registered
		require
			once_manifest_string_counters_not_empty: not once_manifest_string_counters.is_empty
		do
			Result := once_manifest_string_counters.item
		ensure
			value_positive: Result >= 0
		end

	add_counter
			-- Register a new counter.
		do
			counters.force (0)
		ensure
			one_more: counters.count = old counters.count + 1
			value_zero: counter_value = 0
		end

	add_counter2
			-- Register a new counter.
		do
			counters2.force (0)
		ensure
			one_more: counters2.count = old counters2.count + 1
			value_zero: counter2_value = 0
		end

	add_once_manifest_string_counter
			-- Register a new once manifest string counter
		do
			once_manifest_string_counters.force (0)
		ensure
			one_more: once_manifest_string_counters.count = old once_manifest_string_counters.count + 1
			value_zero: once_manifest_string_counter_value = 0
		end

	remove_counter
			-- Unregister last registered counter.
		require
			counters_not_empty: not counters.is_empty
		do
			counters.remove
		ensure
			one_less: counters.count = old counters.count - 1
		end

	remove_counter2
			-- Unregister last registered counter.
		require
			counters2_not_empty: not counters2.is_empty
		do
			counters2.remove
		ensure
			one_less: counters2.count = old counters2.count - 1
		end

	remove_once_manifest_string_counter
			-- Unregister last registered counter.
		require
			once_manifest_string_counters_not_empty: not once_manifest_string_counters.is_empty
		do
			once_manifest_string_counters.remove
		ensure
			one_less: once_manifest_string_counters.count = old once_manifest_string_counters.count - 1
		end

	increment_counter
			-- Increment `counter_value'.
		require
			counters_not_empty: not counters.is_empty
		do
			counters.replace (counters.item + 1)
		ensure
			same_counters_count: counters.count = old counters.count
			one_more: counter_value = old counter_value + 1
		end

	increment_counter2
			-- Increment `counter2_value'.
		require
			counters2_not_empty: not counters2.is_empty
		do
			counters2.replace (counters2.item + 1)
		ensure
			same_counters2_count: counters2.count = old counters2.count
			one_more: counter2_value = old counter2_value + 1
		end

	increment_once_manifest_string_counter
			-- Increment `once_manifest_string_counter_value'.
		require
			once_manifest_string_counters_not_empty: not once_manifest_string_counters.is_empty
		do
			once_manifest_string_counters.replace (once_manifest_string_counters.item + 1)
		ensure
			same_once_manifest_string_counters_count: once_manifest_string_counters.count = old once_manifest_string_counters.count
			one_more: once_manifest_string_counter_value = old once_manifest_string_counter_value + 1
		end

	counters: ARRAYED_STACK [INTEGER]
			-- Counters currently in use by the parser
			-- to build lists of AST nodes with the right size.

	counters2: ARRAYED_STACK [INTEGER]
			-- Counters used for parsing tuples

	once_manifest_string_counters: ARRAYED_STACK [INTEGER]
			-- Counters used for once manifest string.

feature {NONE} -- Actions

	new_class_description (n: detachable ID_AS; n2: detachable STRING_AS;
		is_d, is_e, is_fc, is_ex, is_par, is_o: BOOLEAN;
		first_ind, last_ind: detachable INDEXING_CLAUSE_AS; g: detachable EIFFEL_LIST [FORMAL_DEC_AS];
		a_parent_list_1: detachable PARENT_LIST_AS; a_parent_list_2: detachable PARENT_LIST_AS; c: detachable EIFFEL_LIST [CREATE_AS]; co: detachable CONVERT_FEAT_LIST_AS;
		f: detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]; inv: detachable INVARIANT_AS;
		s: detachable SUPPLIERS_AS; o: detachable STRING_AS; ed: detachable KEYWORD_AS): detachable CLASS_AS
			-- New CLASS AST node;
			-- Update the clickable list.
		local
			ext_name: detachable STRING_AS
			l_conforming_parents, l_non_conforming_parents: detachable PARENT_LIST_AS
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

			Result := ast_factory.new_class_as (n, ext_name, is_d, is_e, is_fc, is_ex, is_par, is_o, first_ind,
				last_ind, g, l_conforming_parents, l_non_conforming_parents, c, co, f, inv, s, o, ed)
		end

	extract_keyword (a_keyword_id: like last_keyword_id_value): detachable KEYWORD_AS
			-- Extract `keyword' entry if present. Void otherwise.
		do
			if a_keyword_id /= Void then
				Result := a_keyword_id.keyword
			end
		end

	extract_id (a_keyword_id: like last_keyword_id_value): detachable ID_AS
			-- Extract `id' entry if present. Void otherwise.
		do
			if a_keyword_id /= Void then
				Result := a_keyword_id.id
					-- Report syntax error when we are compiling for ECMA.
				if syntax_version = ecma_syntax or else syntax_version = provisional_syntax then
					report_one_error (create {SYNTAX_ERROR}.make (a_keyword_id.line, a_keyword_id.column, a_keyword_id.filename,
						"Using keyword as identifier."))
				elseif has_syntax_warning then
					report_one_warning (create {SYNTAX_WARNING}.make (a_keyword_id.line, a_keyword_id.column, a_keyword_id.filename,
						"Using keyword as identifier."))
				end
			end
		end

	extract_symbol (v: like last_symbol_id_value): detachable SYMBOL_AS
			-- Extract symbol entry from `v` if present. Void otherwise.
		do
			if attached v then
				Result := v.symbol
			end
		end

	extract_id_from_symbol (v: like last_symbol_id_value): detachable ID_AS
			-- Extract ID entry from `v` if present. Void otherwise.
		do
			if attached v then
				Result := v.id
			end
		end

	check_object_test_expression (a_expr: detachable EXPR_AS)
			-- Check if `a_expr' is a valid expression for an object test.
		do
			if a_expr /= Void and then not a_expr.is_detachable_expression then
				report_one_error (create {SYNTAX_ERROR}.make (token_line (a_expr), token_column (a_expr), filename,
					"Expression used in object test should be `Detachable_expression'."))
			end
		end

feature {NONE} -- ID factory

	new_none_id: detachable NONE_ID_AS
			-- New ID AST node for "NONE"
		do
			Result := ast_factory.new_filled_none_id_as (line, column, position, 4, character_column, character_position, 4)
		end

feature {NONE} -- Type factory

	is_supplier_recorded: BOOLEAN
			-- Are suppliers recorded in `suppliers'?

	new_class_type (an_id: detachable ID_AS; generics: detachable TYPE_LIST_AS): detachable TYPE_AS
			-- New class type (Take care of formal generics);
			-- Update the clickable list and register the resulting
			-- type as a supplier of the class being parsed.
		local
			class_name: ID_AS
			formal_type, l_new_formal: detachable FORMAL_AS
		do
			if an_id /= Void then
				class_name := an_id

				if {PREDEFINED_NAMES}.none_class_name_id = class_name.name_id then
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
									formal_type.is_expanded, formal_type.has_frozen_mark, Void)
								if l_new_formal /= Void then
									l_new_formal.set_position (formal_type.position)
								end
								Result := l_new_formal
									-- Jump out of the loop.
								formal_parameters.finish
							end
							formal_parameters.forth
						end
					end
					if Result = Void then
							-- It is a common class type.
						Result := ast_factory.new_class_type_as (class_name, generics)
						if is_supplier_recorded then
								-- Put the supplier in `suppliers'.
							suppliers.insert_supplier_id (class_name)
						end
					end
				end
			end
		end

feature {AST_FACTORY} -- Error handling

	report_basic_generic_type_error
			-- Basic types cannot have generic devivation.
		do
			report_one_error (create {BASIC_GEN_TYPE_ERR}.make (line, column, filename, ""))
		end

	report_one_error (a_error: ERROR)
			-- An error was reported.
		do
			Precursor (a_error)
				-- To avoid reporting more than one error for the same syntax error
				-- we simply abort the parsing.
			abort
		end

	report_error (a_message: STRING)
			-- A syntax error has been detected.
			-- Print error message.
		do
			report_one_error (create {SYNTAX_ERROR}.make (line, column, filename, ""))
		end

	report_deprecated_use_of_keyword_is (token: detachable KEYWORD_AS)
			-- Report that the use of the keyword "is" corresponding to `token` is deprecated.
		local
			l: like line
			c: like column
		do
			if has_syntax_warning and then syntax_version /= obsolete_syntax then
				if attached token then
					l := token_line (token)
					c := token_column (token)
				else
					l := line
					c := column
				end
				report_one_warning
					(create {SYNTAX_WARNING}.make (l, c, filename,
						{UTF_CONVERTER}.string_32_to_utf_8_string_8
							(locale.translation_in_context (once "Deprecated use of keyword `is`.", once "parser.eiffel.warning"))))
			end
		end

feature{NONE} -- Roundtrip

	temp_string_as1: detachable STRING_AS
	temp_string_as2: detachable STRING_AS
	temp_keyword_as: detachable KEYWORD_AS
	temp_address_current_as: detachable ADDRESS_CURRENT_AS
	temp_address_result_as: detachable ADDRESS_RESULT_AS

feature {NONE} -- Status report

	is_valid_id_level (l: like id_level): BOOLEAN
			-- Is ID level `l` valid?
		do
			inspect l
			when
				Normal_level,
				Precondition_level,
				Postcondition_level,
				Invariant_level
			then
				Result := True
			else
					-- Result := False
			end
		ensure
			definition: Result =
				(<<Normal_level, Precondition_level, Postcondition_level, Invariant_level>>).has (l)
		end

feature {NONE} -- Constants

	Initial_counters_capacity: INTEGER = 20
			-- Initial capacity for `counters'

	Initial_formal_parameters_capacity: INTEGER = 8
				-- Initial capacity for `formal_parameters'
				-- (See `eif_rtlimits.h')

	Normal_level: INTEGER = 0
	Precondition_level: INTEGER = 1
	Postcondition_level: INTEGER = 2
	Invariant_level: INTEGER = 3

invariant

	suppliers_not_void: suppliers /= Void
	formal_parameters_not_void: formal_parameters /= Void
	valid_id_level: is_valid_id_level (id_level)
	is_external_class_not_set: not il_parser implies not is_external_class
	is_partial_class_not_set: not il_parser implies not is_partial_class
	once_manifest_string_counters_not_empty: not once_manifest_string_counters.is_empty

note
	ca_ignore:
		"CA011", "CA011: too many arguments",
		"CA033", "CA033: very long class"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

