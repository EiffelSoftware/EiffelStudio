indexing

	description: "Eiffel parser skeletons"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class EIFFEL_PARSER_SKELETON

inherit

	YY_PARSER_SKELETON [ANY]
		rename
			parse as yyparse,
			make as make_parser_skeleton,
			report_error as report_syntax_error
		redefine
			report_syntax_error
		end

	EIFFEL_SCANNER
		rename
			make as make_eiffel_scanner
		redefine
			reset, fatal_error
		end

feature {NONE} -- Initialization

	make is
			-- Create a new Eiffel parser.
		do
			make_eiffel_scanner
			make_parser_skeleton
			!! click_list.make (100) -- Gobo
			!! suppliers.make
			!! formal_parameters.make (Initial_formal_parameters_capacity)
			formal_parameters.compare_objects
		end

feature -- Initialization

	reset is
			-- Reset Parser before parsing next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor
			!! click_list.make (100) -- Gobo
			!! suppliers.make
			formal_parameters.wipe_out
		end

feature -- Parsing

	parse (a_file: IO_MEDIUM) is
			-- Parser Eiffel class text from `a_file'.
			-- Make result available in `root_node'.
			-- An exception is raised if a syntax error is found.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		do
			root_node := Void
			File_buffer.set_file (a_file)
			input_buffer := File_buffer
			yy_load_input_buffer
			filename := a_file.name
			yyparse
			reset
			if error_count /= 0 then
				Error_handler.raise_error
			end
		end

feature -- Access

	yacc_position: INTEGER
			-- Position recorded in AST

	yacc_line_number: INTEGER
			-- Line number recorded in AST

	root_node: CLASS_AS
			-- Root node of AST

	suppliers: SUPPLIERS_AS
			-- Suppliers of class being parsed

	formal_parameters: ARRAYED_LIST [ID_AS]
			-- Name of formal generic parameters
			-- of class being parsed

feature -- Clickable

	click_list: CLICK_LIST
			-- List of clickable elements read so far

feature -- Setting

	set_position (l: TOKEN_LOCATION) is
			-- Set `yacc_position' and `yacc_line_number'.
		require
			l_not_void: l /= Void
		do
			yacc_position := l.start_position
			yacc_line_number := l.line_number
		end

feature

	id_level: INTEGER
			-- Boolean for controlling the semantic
			-- action of rule `A_feature'

	Normal_level: INTEGER is 0
	Assert_level: INTEGER is 1
	Invariant_level: INTEGER is 2

	is_deferred: BOOLEAN
			-- Boolean mark for deferred class
	is_expanded: BOOLEAN
			-- Boolean mark for expanded class
	is_separate: BOOLEAN
			-- Boolean mark for separate class
	is_frozen: BOOLEAN
			-- Boolean mark for frozen feature names

	fclause_pos: INTEGER
			-- To memorize the beginning of a feature clause

	fbody_pos: INTEGER
			-- To memorize the beginning of a feature body

feature {NONE} -- Implementation

--	eiffel_list_buffer: EIFFEL_LIST_BUFFER

	File_buffer: YY_FILE_BUFFER is
			-- Input file buffer
		once
			!! Result.make_with_size (io.input, 50000)
		ensure
			file_buffer_not_void: Result /= Void
		end

feature {NONE} -- Constants

	Initial_formal_parameters_capacity: INTEGER is 8
				-- Initial capacity for `formal_parameters'
				-- (See `eif_rtlimits.h')

	Integer_id_as: ID_AS is
			-- ID AST node for "INTEGER"
		do
			!! Result.make ("integer")
		ensure
			id_as_not_void: Result /= Void
		end

	Boolean_id_as: ID_AS is
			-- ID AST node for "BOOLEAN"
		do
			!! Result.make ("boolean")
		ensure
			id_as_not_void: Result /= Void
		end

	Character_id_as: ID_AS is
			-- ID AST node for "CHARACTER"
		do
			!! Result.make ("character")
		ensure
			id_as_not_void: Result /= Void
		end

	Real_id_as: ID_AS is
			-- ID AST node for "REAL"
		do
			!! Result.make ("real")
		ensure
			id_as_not_void: Result /= Void
		end

	Double_id_as: ID_AS is
			-- ID AST node for "DOUBLE"
		do
			!! Result.make ("double")
		ensure
			id_as_not_void: Result /= Void
		end

	Pointer_id_as: ID_AS is
			-- ID AST node for "POINTER"
		do
			!! Result.make ("pointer")
		ensure
			id_as_not_void: Result /= Void
		end

	None_id_as: ID_AS is
			-- ID AST node for "NONE"
		do
			!! Result.make ("none")
		ensure
			id_as_not_void: Result /= Void
		end

	Boolean_type_as: BOOL_TYPE_AS is
			-- Type AST node for "BOOLEAN"
		do
			!! Result.make
		ensure
			type_as_not_void: Result /= Void
		end

	Character_type_as: CHAR_TYPE_AS is
			-- Type AST node for "CHARACTER"
		do
			!! Result.make
		ensure
			type_as_not_void: Result /= Void
		end

	Double_type_as: DOUBLE_TYPE_AS is
			-- Type AST node for "DOUBLE"
		do
			!! Result.make
		ensure
			type_as_not_void: Result /= Void
		end

	Integer_type_as: INT_TYPE_AS is
			-- Type AST node for "INTEGER"
		do
			!! Result.make
		ensure
			type_as_not_void: Result /= Void
		end

	None_type_as: NONE_TYPE_AS is
			-- Type AST node for "NONE"
		do
			!! Result.make
		ensure
			type_as_not_void: Result /= Void
		end

	Pointer_type_as: POINTER_TYPE_AS is
			-- Type AST node for "POINTER"
		do
			!! Result.make
		ensure
			type_as_not_void: Result /= Void
		end

	Real_type_as: REAL_TYPE_AS is
			-- Type AST node for "REAL"
		do
			!! Result.make
		ensure
			type_as_not_void: Result /= Void
		end

	dummy_clickable_as: CLICKABLE_AST is
			-- Dummy CLICKABLE_AST used to temporarily
			-- fill `node' in CLICK_AST
		once
			!INT_TYPE_AS! Result.make
		ensure
			dummy_clicable_as_not_void: Result /= Void
		end

feature {NONE} -- Factory

	new_class_type (an_id: ID_AS; generics: EIFFEL_LIST [TYPE]): CLICKABLE_AST is
			-- New class type;
			-- Take care of formal generics
		require
			an_id_not_void: an_id /= Void
		local
			i: INTEGER
			an_error: BASIC_GEN_TYPE_ERR
		do
			if generics = Void then
				from formal_parameters.start until formal_parameters.after loop
					i := i + 1
					if an_id.is_equal (formal_parameters.item) then
						!FORMAL_AS! Result.make (i)
							-- Jump out of the loop.
						formal_parameters.finish
					end
					formal_parameters.forth
				end
			end
			if Result = Void then
					-- It is a common class type.
				!CLASS_TYPE_AS! Result.make (an_id, generics)
					-- Put the supplier in `suppliers'.
				suppliers.insert_supplier_id (an_id)
			end
		ensure
			class_type_not_void: Result /= Void
		end

	new_boolean_type (is_generic: BOOLEAN): BOOL_TYPE_AS is
			-- Boolean class type
		local
			an_error: BASIC_GEN_TYPE_ERR
		do
			if is_generic then
				!! an_error.make (current_position.start_position, current_position.end_position, filename, yacc_error_code, "")
				Error_handler.insert_error (an_error)
				Error_handler.raise_error
			else
				Result := Boolean_type_as
			end
		ensure
			type_not_void: Result /= Void
		end

	new_character_type (is_generic: BOOLEAN): CHAR_TYPE_AS is
			-- Character class type
		local
			an_error: BASIC_GEN_TYPE_ERR
		do
			if is_generic then
				!! an_error.make (current_position.start_position, current_position.end_position, filename, yacc_error_code, "")
				Error_handler.insert_error (an_error)
				Error_handler.raise_error
			else
				Result := Character_type_as
			end
		ensure
			type_not_void: Result /= Void
		end

	new_double_type (is_generic: BOOLEAN): DOUBLE_TYPE_AS is
			-- Double class type
		local
			an_error: BASIC_GEN_TYPE_ERR
		do
			if is_generic then
				!! an_error.make (current_position.start_position, current_position.end_position, filename, yacc_error_code, "")
				Error_handler.insert_error (an_error)
				Error_handler.raise_error
			else
				Result := Double_type_as
			end
		ensure
			type_not_void: Result /= Void
		end

	new_integer_type (is_generic: BOOLEAN): INT_TYPE_AS is
			-- Integer class type
		local
			an_error: BASIC_GEN_TYPE_ERR
		do
			if is_generic then
				!! an_error.make (current_position.start_position, current_position.end_position, filename, yacc_error_code, "")
				Error_handler.insert_error (an_error)
				Error_handler.raise_error
			else
				Result := Integer_type_as
			end
		ensure
			type_not_void: Result /= Void
		end

	new_none_type (is_generic: BOOLEAN): NONE_TYPE_AS is
			-- None class type
		local
			an_error: BASIC_GEN_TYPE_ERR
		do
			if is_generic then
				!! an_error.make (current_position.start_position, current_position.end_position, filename, yacc_error_code, "")
				Error_handler.insert_error (an_error)
				Error_handler.raise_error
			else
				Result := None_type_as
			end
		ensure
			type_not_void: Result /= Void
		end

	new_pointer_type (is_generic: BOOLEAN): POINTER_TYPE_AS is
			-- Pointer class type
		local
			an_error: BASIC_GEN_TYPE_ERR
		do
			if is_generic then
				!! an_error.make (current_position.start_position, current_position.end_position, filename, yacc_error_code, "")
				Error_handler.insert_error (an_error)
				Error_handler.raise_error
			else
				Result := Pointer_type_as
			end
		ensure
			type_not_void: Result /= Void
		end

	new_real_type (is_generic: BOOLEAN): REAL_TYPE_AS is
			-- Real class type
		local
			an_error: BASIC_GEN_TYPE_ERR
		do
			if is_generic then
				!! an_error.make (current_position.start_position, current_position.end_position, filename, yacc_error_code, "")
				Error_handler.insert_error (an_error)
				Error_handler.raise_error
			else
				Result := Real_type_as
			end
		ensure
			type_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	list_append_2 (l: ANY; a1, a2: ANY) is
		local
			a_list: LIST [ANY]
		do
			a_list ?= l
			a_list.extend (a1)
			a_list.extend (a2)
		end

	list_append_3 (l: ANY; a1, a2, a3: ANY) is
		local
			a_list: LIST [ANY]
		do
			a_list ?= l
			a_list.extend (a1)
			a_list.extend (a2)
			a_list.extend (a3)
		end

	list_append_4 (l: ANY; a1, a2, a3, a4: ANY) is
		local
			a_list: LIST [ANY]
		do
			a_list ?= l
			a_list.extend (a1)
			a_list.extend (a2)
			a_list.extend (a3)
			a_list.extend (a4)
		end

	list_append_5 (l: ANY; a1, a2, a3, a4, a5: ANY) is
		local
			a_list: LIST [ANY]
		do
			a_list ?= l
			a_list.extend (a1)
			a_list.extend (a2)
			a_list.extend (a3)
			a_list.extend (a4)
			a_list.extend (a5)
		end

feature {NONE} -- Conversion

	dollar_position (val: ANY): TOKEN_LOCATION is
		do
			Result ?= val
		end

	dollar_list (val: ANY): LIST [ANY] is
		do
			Result ?= val
		end

	dollar_eiffel_list_expr_as (val: ANY): EIFFEL_LIST [EXPR_AS] is
		do
			Result ?= val
		end

	dollar_eiffel_list_feature_as (val: ANY): EIFFEL_LIST [FEATURE_AS] is
		do
			Result ?= val
		end

	dollar_id_as (val: ANY): ID_AS is
		do
			Result ?= val
		end

	dollar_access_as (val: ANY): ACCESS_AS is
		do
			Result ?= val
		end

	dollar_call_as (val: ANY): CALL_AS is
		do
			Result ?= val
		end

	dollar_expr_as (val: ANY): EXPR_AS is
		do
			Result ?= val
		end

	dollar_string_as (val: ANY): STRING_AS is
		do
			Result ?= val
		end

	dollar_feature_name (val: ANY): FEATURE_NAME is
		do
			Result ?= val
		end

	dollar_eiffel_list_tagged_as (val: ANY): EIFFEL_LIST [TAGGED_AS] is
		do
			Result ?= val
		end

	dollar_eiffel_list_id_as (val: ANY): EIFFEL_LIST [ID_AS] is
		do
			Result ?= val
		end

	dollar_atomic_as (val: ANY): ATOMIC_AS is
		do
			Result ?= val
		end

	dollar_type (val: ANY): TYPE is
		do
			Result ?= val
		end

	dollar_access_inv_as (val: ANY): ACCESS_INV_AS is
		do
			Result ?= val
		end

	dollar_eiffel_list_feature_name (val: ANY): EIFFEL_LIST [FEATURE_NAME] is
		do
			Result ?= val
		end

	dollar_client_as (val: ANY): CLIENT_AS is
		do
			Result ?= val
		end

	dollar_eiffel_list_create_as (val: ANY): EIFFEL_LIST [CREATE_AS] is
		do
			Result ?= val
		end

	dollar_eiffel_list_instruction_as (val: ANY): EIFFEL_LIST [INSTRUCTION_AS] is
		do
			Result ?= val
		end

	dollar_eiffel_list_string_as (val: ANY): EIFFEL_LIST [STRING_AS] is
		do
			Result ?= val
		end

	dollar_variant_as (val: ANY): VARIANT_AS is
		do
			Result ?= val
		end

	dollar_eiffel_list_interval_as (val: ANY): EIFFEL_LIST [INTERVAL_AS] is
		do
			Result ?= val
		end

	dollar_eiffel_list_case_as (val: ANY): EIFFEL_LIST [CASE_AS] is
		do
			Result ?= val
		end

	dollar_eiffel_list_elsif_as (val: ANY): EIFFEL_LIST [ELSIF_AS] is
		do
			Result ?= val
		end

	dollar_eiffel_list_formal_dec_as (val: ANY): EIFFEL_LIST [FORMAL_DEC_AS] is
		do
			Result ?= val
		end

	dollar_eiffel_list_type (val: ANY): EIFFEL_LIST [TYPE] is
		do
			Result ?= val
		end

	dollar_integer_as (val: ANY): INTEGER_AS is
		do
			Result ?= val
		end

	dollar_eiffel_list_type_dec_as (val: ANY): EIFFEL_LIST [TYPE_DEC_AS] is
		do
			Result ?= val
		end

	dollar_external_lang_as (val: ANY): EXTERNAL_LANG_AS is
		do
			Result ?= val
		end

	dollar_require_as (val: ANY): REQUIRE_AS is
		do
			Result ?= val
		end

	dollar_ensure_as (val: ANY): ENSURE_AS is
		do
			Result ?= val
		end

	dollar_rout_body_as (val: ANY): ROUT_BODY_AS is
		do
			Result ?= val
		end

	dollar_feature_set_as (val: ANY): FEATURE_SET_AS is
		do
			Result ?= val
		end

	dollar_eiffel_list_export_item_as (val: ANY): EIFFEL_LIST [EXPORT_ITEM_AS] is
		do
			Result ?= val
		end

	dollar_eiffel_list_rename_as (val: ANY): EIFFEL_LIST [RENAME_AS] is
		do
			Result ?= val
		end

	dollar_eiffel_list_parent_as (val: ANY): EIFFEL_LIST [PARENT_AS] is
		do
			Result ?= val
		end

	dollar_routine_as (val: ANY): ROUTINE_AS is
		do
			Result ?= val
		end

	dollar_constant_as (val: ANY): CONSTANT_AS is
		do
			Result ?= val
		end

	dollar_content_as (val: ANY): CONTENT_AS is
		do
			Result ?= val
		end

	dollar_body_as (val: ANY): BODY_AS is
		do
			Result ?= val
		end

	dollar_list_feature_clause_as (val: ANY): LIST [FEATURE_CLAUSE_AS] is
		do
			Result ?= val
		end

	dollar_eiffel_list_feature_clause_as (val: ANY): EIFFEL_LIST [FEATURE_CLAUSE_AS] is
		do
			Result ?= val
		end

	dollar_eiffel_list_index_as (val: ANY): EIFFEL_LIST [INDEX_AS] is
		do
			Result ?= val
		end

	dollar_invariant_as (val: ANY): INVARIANT_AS is
		do
			Result ?= val
		end

	dollar_eiffel_list_atomic_as (val: ANY): EIFFEL_LIST [ATOMIC_AS] is
		do
			Result ?= val
		end

feature {NONE} -- Error handling

	fatal_error (a_message: STRING) is
			-- A fatal error occurred.
			-- Log `a_message' and raise an exception.
		do
			report_error (a_message)
		end

	report_syntax_error (a_message: STRING) is
			-- A syntax error has been detected.
			-- Print error message.
		do
			report_error (a_message)
		end

invariant

	click_list_not_void: click_list /= Void
	suppliers_not_void: suppliers /= Void
	formal_parameters_not_void: formal_parameters /= Void
	no_void_formal_parameter: not formal_parameters.has (Void)

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
