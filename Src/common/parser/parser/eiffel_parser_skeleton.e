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
			make as make_parser_skeleton
		redefine
			report_error, clear_all
		end

	EIFFEL_SCANNER
		rename
			make as make_eiffel_scanner
		redefine
			reset
		end

	SHARED_PARSER_FILE_BUFFER
		export {NONE} all end

	AST_FACTORY
		export {NONE} all end

feature {NONE} -- Initialization

	make is
			-- Create a new pure Eiffel parser.
		do
			make_eiffel_scanner
			make_parser_skeleton
			!! click_list.make (Initial_click_list_capacity)
			!! suppliers.make
			!! formal_parameters.make (Initial_formal_parameters_capacity)
			formal_parameters.compare_objects
			id_level := Normal_level
		end

	make_il_parser is
			-- Create a new IL Eiffel parser.
		do
			il_parser := True
			make
		end

feature -- Initialization

	reset is
			-- Reset Parser before parsing next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor
			!! click_list.make (Initial_click_list_capacity)
			!! suppliers.make
			formal_parameters.wipe_out
			id_level := Normal_level
			real_class_end_position := 0
		end

feature -- Status report

	il_parser: BOOLEAN
			-- Is current Eiffel parser an IL Eiffel parser?

feature -- Parsing

	parse (a_file: IO_MEDIUM) is
			-- Parse Eiffel class text from `a_file'.
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
		rescue
			reset
		end

	parse_from_string (a_string: STRING) is
			-- Parse Eiffel class text in `a_string'.
			-- Make result available in `root_node'.
			-- An exception is raised if a syntax error is found.
		require
			a_string_not_void: a_string /= Void
		do
			root_node := Void
			create input_buffer.make (a_string)
			yy_load_input_buffer
			yyparse
			reset
		rescue
			reset
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

	click_list: CLICK_LIST
			-- List of clickable elements read so far

	real_class_end_position: INTEGER
			-- When `inherit_context' becomes `True', when an
			-- empty parent specification is encountered, the
			-- position is saved in this variable.
			-- If this was the last token, this position is used
			-- for the insertion positions in `root_node'.

	formal_generics_start_position: INTEGER
			-- Start of formal generics, if present.

	formal_generics_end_position: INTEGER
			-- End of formal generics, if present.

feature -- Setting

	set_position (l: TOKEN_LOCATION) is
			-- Set `yacc_position' and `yacc_line_number'.
		require
			l_not_void: l /= Void
		do
			yacc_position := l.start_position
			yacc_line_number := l.line_number
		end

feature -- Removal

	wipe_out is
			-- Release unused objects to garbage collector.
		do
			root_node := Void
			clear_stacks
		ensure
			root_node_void: root_node = Void
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

	fclause_pos: INTEGER
			-- To memorize the beginning of a feature clause

	fbody_pos: INTEGER
			-- To memorize the beginning of a feature body

	feature_indexes: INDEXING_CLAUSE_AS
			-- Indexing clause for an Eiffel feature.
			-- IL only

feature {NONE} -- Actions

	add_to_assertion_list (a_list: LIST [TAGGED_AS]; an_assertion: TAGGED_AS) is
			-- Add `an_assertion' at end of `a_list' if not void.
		require
			a_list_not_void: a_list /= Void
		do
			if an_assertion /= Void then
				a_list.extend (an_assertion)
			end
		end

	add_to_feature_clause_list (a_list: LIST [FEATURE_CLAUSE_AS]; a_clause: FEATURE_CLAUSE_AS) is
			-- Add `a_clause' at end of `a_list' if not void.
		require
			a_list_not_void: a_list /= Void
		do
			if a_clause /= Void then
				a_list.extend (a_clause)
			end
		end

	new_class_description (n: PAIR [ID_AS, CLICK_AST]; n2: STRING_AS;
		is_d, is_e, is_s, is_fc, is_ex: BOOLEAN;
		first_ind, last_ind: INDEXING_CLAUSE_AS; g: EIFFEL_LIST [FORMAL_DEC_AS];
		p: EIFFEL_LIST [PARENT_AS]; c: EIFFEL_LIST [CREATE_AS];
		f: EIFFEL_LIST [FEATURE_CLAUSE_AS]; inv: INVARIANT_AS;
		s: SUPPLIERS_AS; o: STRING_AS; cl: CLICK_LIST): CLASS_AS is
			-- New CLASS AST node;
			-- Update the clickable list.
		require
			n_not_void: n /= Void
			class_name_not_void: n.first /= Void
			click_ast_not_void: n.second /= Void
			s_not_void: s /= Void
			cl_not_void: cl /= Void
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
			Result := new_class_as (n.first, ext_name, is_d, is_e, is_s, is_fc, is_ex, first_ind, last_ind, g, p, c, f, inv, s, o, cl)
			n.second.set_node (Result)
		ensure
			class_description_not_void: Result /= Void
			class_name_set: Result.class_name = n.first
			external_class_name_set: (n2 /= Void and then Result.external_class_name = n2.value)
							or else (Result.external_class_name = Void)
			is_deferred_set: Result.is_deferred = is_d
			is_expanded_set: Result.is_expanded = is_e
			is_separate_set: Result.is_separate = is_s
			is_frozen_set: Result.is_frozen = is_fc
			is_external_set: Result.is_external = is_ex
			first_indexes_set: Result.top_indexes = first_ind
			last_indexes_set: Result.bottom_indexes = last_ind
			generics_set: Result.generics = g
			parents_set: Result.parents = p
			creators_set: Result.creators = c
			features_set: Result.features = f
			empty_invariant_part: Result.invariant_part = Void implies inv = Void or else inv.assertion_list = Void
			invariant_part_set: Result.invariant_part /= Void implies Result.invariant_part = inv
			suppliers_set: Result.suppliers = s
			obsolete_message_set: Result.obsolete_message = o
			click_list_set: Result.click_list = cl
			click_ast_updated: n.second.node = Result
		end

	new_declaration_body (args: EIFFEL_LIST [TYPE_DEC_AS]; type: TYPE; content: CONTENT_AS): BODY_AS is
			-- New declaration body AST node;
			-- Report syntax error if necessary
		local
			constant_as: CONSTANT_AS
			routine_as: ROUTINE_AS
		do
			Result := new_body_as (args, type, content)
				-- Validity test for feature declaration:
			constant_as ?= content
			routine_as ?= content
			if args = Void and type = Void and content = Void then
					-- Either arguments or type or body
				raise_error
			elseif constant_as /= Void and (args /= Void or type = Void) then
					-- constant implies no argument but type
				raise_error
			elseif args /= Void and (routine_as = Void or content = Void) then
					-- arguments implies non-void routine
				raise_error
			end
		ensure
			body_not_void: Result /= Void
			arguments_set: Result.arguments = args
			type_set: Result.type = type
			content_set: Result.content = content
		end

	new_feature_declaration (f: PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST]; b: BODY_AS; i: INDEXING_CLAUSE_AS ): FEATURE_AS is
			-- New FEATURE AST node;
			-- Update the clickable list.
		require
			f_not_void: f /= Void
			feature_names_not_void: f.first /= Void
			feature_names_not_empty: not f.first.is_empty
			click_ast_not_void: f.second /= Void
			can_have_indexing_clause: i /= Void implies f.first.count = 1
		local
			click_ast: CLICK_AST
		do
			click_ast := f.second
			Result := new_feature_as (f.first, b, i, click_ast.start_position, current_position.start_position)
			click_ast.set_node (Result)
		ensure
			feature_declaration_not_void: Result /= Void
			feature_names_set: Result.feature_names = f.first
			body_set: Result.body = b
			indexes_set: Result.indexes = i
			click_ast_updated: f.second.node = Result
		end

	new_parent_clause (n: PAIR [ID_AS, CLICK_AST]; g: EIFFEL_LIST [TYPE];
		rn: EIFFEL_LIST [RENAME_AS]; e: EIFFEL_LIST [EXPORT_ITEM_AS];
		u: EIFFEL_LIST [FEATURE_NAME]; rd: EIFFEL_LIST [FEATURE_NAME];
		s: EIFFEL_LIST [FEATURE_NAME]): PARENT_AS is
			-- New PARENT AST node;
			-- Update the clickable list.
		require
			n_not_void: n /= Void
			type_name_not_void: n.first /= Void
			click_ast_not_void: n.second /= Void
		local
			class_type: CLASS_TYPE_AS
		do
			class_type := new_class_type_as (n.first, g)
			n.second.set_node (class_type)
			Result := new_parent_as (class_type, rn, e, u, rd, s)
		ensure
			parent_clause_not_void: Result /= Void
			renaming_set: Result.renaming = rn
			exports_set: Result.exports = e
			undefining_set: Result.undefining = u
			redefininig_set: Result.redefining = rd
			selecting_set: Result.selecting = s
		end

	new_precursor (n: PAIR [ID_AS, CLICK_AST]; args: EIFFEL_LIST [EXPR_AS]): PRECURSOR_AS is
			-- New precursor AST node;
			-- Update the clickable list.
		require
			n_not_void: n /= Void
			class_name_not_void: n.first /= Void
			click_ast_not_void: n.second /= Void
		do
			Result := new_precursor_as (n.first, args)
			n.second.set_node (Result)
		ensure
			precursor_not_void: Result /= Void
			parent_name_set: Result.parent_name = n.first
			parameters_set: Result.parameters = args
			click_ast_updated: n.second.node = Result
		end

	new_rename_pair (o, n: PAIR [FEATURE_NAME, CLICK_AST]): RENAME_AS is
			-- New RENAME_PAIR AST node;
			-- Update the clickable list.
		require
			o_not_void: o /= Void
			old_name_not_void: o.first /= Void
			old_click_ast_not_void: o.second /= Void
			n_not_void: n /= Void
			new_name_not_void: n.first /= Void
			new_click_ast_not_void: n.second /= Void
		do
			Result := new_rename_as (o.first, n.first)
			o.second.set_node (n.first)
		ensure
			rename_pair_not_void: Result /= Void
			old_name_set: Result.old_name = o.first
			new_name_set: Result.new_name = n.first
		end

feature {NONE} -- ID factory

	new_integer_id_as (n: INTEGER): ID_AS is
			-- New ID AST node for "INTEGER" of `n' bits.
		do
			inspect n
			when 8 then Result := new_id_as (Integer_8_classname)
			when 16 then Result := new_id_as (Integer_16_classname)
			when 32 then Result := new_id_as (Integer_classname)
			when 64 then Result := new_id_as (Integer_64_classname)
			end
		ensure
			id_as_not_void: Result /= Void
		end

	new_boolean_id_as: ID_AS is
			-- New ID AST node for "BOOLEAN"
		do
			Result := new_id_as (Boolean_classname)
		ensure
			id_as_not_void: Result /= Void
		end

	new_character_id_as (is_wide: BOOLEAN): ID_AS is
			-- New ID AST node for "CHARACTER"
		do
			if is_wide then
				Result := new_id_as (Wide_char_classname)
			else
				Result := new_id_as (Character_classname)
			end
		ensure
			id_as_not_void: Result /= Void
		end

	new_real_id_as: ID_AS is
			-- New ID AST node for "REAL"
		do
			Result := new_id_as (Real_classname)
		ensure
			id_as_not_void: Result /= Void
		end

	new_double_id_as: ID_AS is
			-- New ID AST node for "DOUBLE"
		do
			Result := new_id_as (Double_classname)
		ensure
			id_as_not_void: Result /= Void
		end

	new_pointer_id_as: ID_AS is
			-- New ID AST node for "POINTER"
		do
			Result := new_id_as (Pointer_classname)
		ensure
			id_as_not_void: Result /= Void
		end

	new_none_id_as: ID_AS is
			-- New ID AST node for "NONE"
		do
			Result := new_id_as (None_classname)
		ensure
			id_as_not_void: Result /= Void
		end

feature {NONE} -- String factory

	new_lt_string_as: STRING_AS is
			-- New string AST node for "<"
		do
			Result := new_string_as ("<")
		ensure
			string_as_not_void: Result /= Void
		end

	new_le_string_as: STRING_AS is
			-- New string AST node for "<="
		do
			Result := new_string_as ("<=")
		ensure
			string_as_not_void: Result /= Void
		end

	new_gt_string_as: STRING_AS is
			-- New string AST node for ">"
		do
			Result := new_string_as (">")
		ensure
			string_as_not_void: Result /= Void
		end

	new_ge_string_as: STRING_AS is
			-- New string AST node for ">="
		do
			Result := new_string_as (">=")
		ensure
			string_as_not_void: Result /= Void
		end

	new_minus_string_as: STRING_AS is
			-- New string AST node for "-"
		do
			Result := new_string_as ("-")
		ensure
			string_as_not_void: Result /= Void
		end

	new_plus_string_as: STRING_AS is
			-- New string AST node for "+"
		do
			Result := new_string_as ("+")
		ensure
			string_as_not_void: Result /= Void
		end

	new_star_string_as: STRING_AS is
			-- New string AST node for "*"
		do
			Result := new_string_as ("*")
		ensure
			string_as_not_void: Result /= Void
		end

	new_slash_string_as: STRING_AS is
			-- New string AST node for "/"
		do
			Result := new_string_as ("/")
		ensure
			string_as_not_void: Result /= Void
		end

	new_power_string_as: STRING_AS is
			-- New string AST node for "^"
		do
			Result := new_string_as ("^")
		ensure
			string_as_not_void: Result /= Void
		end

	new_div_string_as: STRING_AS is
			-- New string AST node for "//"
		do
			Result := new_string_as ("//")
		ensure
			string_as_not_void: Result /= Void
		end

	new_mod_string_as: STRING_AS is
			-- New string AST node for "\\"
		do
			Result := new_string_as ("\\")
		ensure
			string_as_not_void: Result /= Void
		end

	new_and_string_as: STRING_AS is
			-- New string AST node for "and"
		do
			Result := new_string_as ("and")
		ensure
			string_as_not_void: Result /= Void
		end

	new_and_then_string_as: STRING_AS is
			-- New string AST node for "and then"
		do
			Result := new_string_as ("and then")
		ensure
			string_as_not_void: Result /= Void
		end

	new_implies_string_as: STRING_AS is
			-- New string AST node for "implies"
		do
			Result := new_string_as ("implies")
		ensure
			string_as_not_void: Result /= Void
		end

	new_or_string_as: STRING_AS is
			-- New string AST node for "or"
		do
			Result := new_string_as ("or")
		ensure
			string_as_not_void: Result /= Void
		end

	new_or_else_string_as: STRING_AS is
			-- New string AST node for "or else"
		do
			Result := new_string_as ("or else")
		ensure
			string_as_not_void: Result /= Void
		end

	new_xor_string_as: STRING_AS is
			-- New string AST node for "xor"
		do
			Result := new_string_as ("xor")
		ensure
			string_as_not_void: Result /= Void
		end

	new_not_string_as: STRING_AS is
			-- New string AST node for "not"
		do
			Result := new_string_as ("not")
		ensure
			string_as_not_void: Result /= Void
		end

	new_empty_string_as: STRING_AS is
			-- New string AST node for ""
		do
			Result := new_string_as ("")
		ensure
			string_as_not_void: Result /= Void
		end

	new_empty_verbatim_string_as (marker: STRING): VERBATIM_STRING_AS is
			-- New verbatim string AST node for ""
		require
			marker_not_void: marker /= Void
		do
			Result := new_verbatim_string_as ("", marker)
		ensure
			verbatim_string_as_not_void: Result /= Void
		end

feature {NONE} -- Clickable factory

	new_clickable_id (an_id: ID_AS): PAIR [ID_AS, CLICK_AST] is
			-- New clickable node for `an_id';
			-- Register it in `click_list'
		require
			an_id_not_void: an_id /= Void
		local
			click_ast: CLICK_AST
		do
			click_ast := new_click_ast (Dummy_clickable_as, current_position.start_position, current_position.end_position)
			click_list.extend (click_ast)
			!! Result
			Result.set_first (an_id)
			Result.set_second (click_ast)
		ensure
			clickable_id_not_void: Result /= Void
			id_set: Result.first = an_id
			click_ast_not_void: Result.second /= Void
		end

	new_clickable_string (a_string: STRING_AS): PAIR [STRING_AS, CLICK_AST] is
			-- New clickable node for `a_string';
			-- Register it in `click_list'
		require
			a_string_not_void: a_string /= Void
		local
			click_ast: CLICK_AST
		do
			click_ast := new_click_ast (Dummy_clickable_as, current_position.start_position, current_position.end_position)
			click_list.extend (click_ast)
			!! Result
			Result.set_first (a_string)
			Result.set_second (click_ast)
		ensure
			clickable_id_not_void: Result /= Void
			string_set: Result.first = a_string
			click_ast_not_void: Result.second /= Void
		end

	new_clickable_feature_name (ci: PAIR [ID_AS, CLICK_AST]): PAIR [FEATURE_NAME, CLICK_AST] is
			-- New clickable feature_name
		require
			ci_not_void: ci /= Void
			id_not_void: ci.first /= Void
			click_ast_not_void: ci.second /= Void
		local
			feature_name: FEATURE_NAME
			click_ast: CLICK_AST
		do
			click_ast := ci.second
			feature_name := new_feature_name_id_as (ci.first, is_frozen)
			click_ast.set_node (feature_name)
			!! Result
			Result.set_first (feature_name)
			Result.set_second (click_ast)
		ensure
			clickable_feature_name_not_void: Result /= Void
			feature_name_not_void: Result.first /= Void
			click_ast_not_void: Result.second /= Void
		end

	new_clickable_infix (cs: PAIR [STRING_AS, CLICK_AST]): PAIR [FEATURE_NAME, CLICK_AST] is
			-- New clickable infix feature_name
		require
			cs_not_void: cs /= Void
			string_not_void: cs.first /= Void
			click_ast_not_void: cs.second /= Void
		local
			feature_name: FEATURE_NAME
			click_ast: CLICK_AST
		do
			click_ast := cs.second
			feature_name := new_infix_as (cs.first, is_frozen)
			click_ast.set_node (feature_name)
			!! Result
			Result.set_first (feature_name)
			Result.set_second (click_ast)
		ensure
			clickable_feature_name_not_void: Result /= Void
			feature_name_not_void: Result.first /= Void
			click_ast_not_void: Result.second /= Void
		end

	new_clickable_prefix (cs: PAIR [STRING_AS, CLICK_AST]): PAIR [FEATURE_NAME, CLICK_AST] is
			-- New clickable prefix feature_name
		require
			cs_not_void: cs /= Void
			string_not_void: cs.first /= Void
			click_ast_not_void: cs.second /= Void
		local
			feature_name: FEATURE_NAME
			click_ast: CLICK_AST
		do
			click_ast := cs.second
			feature_name := new_prefix_as (cs.first, is_frozen)
			click_ast.set_node (feature_name)
			!! Result
			Result.set_first (feature_name)
			Result.set_second (click_ast)
		ensure
			clickable_feature_name_not_void: Result /= Void
			feature_name_not_void: Result.first /= Void
			click_ast_not_void: Result.second /= Void
		end

	new_clickable_feature_name_list (fn: PAIR [FEATURE_NAME, CLICK_AST]; n: INTEGER): PAIR [EIFFEL_LIST [FEATURE_NAME], CLICK_AST] is
			-- New clickable feature_name list
		require
			fn_not_void: fn /= Void
			feature_name_not_void: fn.first /= Void
			click_ast_not_void: fn.second /= Void
			n_positive: n >= 0
		local
			feature_name_list: EIFFEL_LIST [FEATURE_NAME]
		do
			feature_name_list := new_eiffel_list_feature_name (n)
			feature_name_list.extend (fn.first)
			!! Result
			Result.set_first (feature_name_list)
			Result.set_second (fn.second)
		ensure
			clickable_feature_name_list_not_void: Result /= Void
			feature_name_list_not_void: Result.first /= Void
			feature_name_added: Result.first.has (fn.first)
			click_ast_set: Result.second = fn.second
		end

feature {NONE} -- Type factory

	new_class_type (ci: PAIR [ID_AS, CLICK_AST]; generics: EIFFEL_LIST [TYPE]): TYPE is
			-- New class type (Take care of formal generics);
			-- Update the clickable list and register the resulting
			-- type as a supplier of the class being parsed.
		require
			ci_not_void: ci /= Void
			class_name_not_void: ci.first /= Void
			click_ast_not_void: ci.second /= Void
		local
			i: INTEGER
			class_name: ID_AS
			click_ast: CLICK_AST
			formal_type: FORMAL_AS
			class_type: CLASS_TYPE_AS
		do
			class_name := ci.first
			click_ast := ci.second
			if generics = Void then
				from formal_parameters.start until formal_parameters.after loop
					i := i + 1
					if class_name.is_equal (formal_parameters.item) then
						formal_type := new_formal_as (i)
							-- Shouldn't we just remove the formal type
							-- name from the clickable list instead? (ericb)
						click_ast.set_node (formal_type)
						Result := formal_type
							-- Jump out of the loop.
						formal_parameters.finish
					end
					formal_parameters.forth
				end
			end
			if Result = Void then
					-- It is a common class type.
				class_type := new_class_type_as (class_name, generics)
					-- Put the supplier in `suppliers'.
				suppliers.insert_supplier_id (class_name)
				click_ast.set_node (class_type)
				Result := class_type
			end
		ensure
			type_not_void: Result /= Void
		end

	new_expanded_type (ci: PAIR [ID_AS, CLICK_AST]; generics: EIFFEL_LIST [TYPE]): EXP_TYPE_AS is
			-- New expanded class type;
			-- Update the clickable list and register the resulting
			-- type as a supplier of the class being parsed.
		require
			ci_not_void: ci /= Void
			class_name_not_void: ci.first /= Void
			click_ast_not_void: ci.second /= Void
		local
			class_name: ID_AS
		do
			class_name := ci.first
			Result := new_expanded_type_as (class_name, generics)
			ci.second.set_node (Result)
			suppliers.insert_supplier_id (class_name)
		ensure
			expanded_type_not_void: Result /= Void
			class_name_set: Result.class_name = ci.first
			generics_set: Result.generics = generics
			click_ast_updated: ci.second.node = Result
		end

	new_separate_type (ci: PAIR [ID_AS, CLICK_AST]; generics: EIFFEL_LIST [TYPE]): SEPARATE_TYPE_AS is
			-- New separate class type;
			-- Update the clickable list and register the resulting
			-- type as a supplier of the class being parsed.
		require
			ci_not_void: ci /= Void
			class_name_not_void: ci.first /= Void
			click_ast_not_void: ci.second /= Void
		local
			class_name: ID_AS
		do
			class_name := ci.first
			Result := new_separate_type_as (class_name, generics)
			ci.second.set_node (Result)
			suppliers.insert_supplier_id (class_name)
		ensure
			separate_type_not_void: Result /= Void
			class_name_set: Result.class_name = ci.first
			generics_set: Result.generics = generics
			click_ast_updated: ci.second.node = Result
		end

	new_boolean_type (click_ast: CLICK_AST; is_generic: BOOLEAN): BOOL_TYPE_AS is
			-- New boolean class type;
			-- Update the clickable list and report
			-- error if `is_generic' is true.
		require
			click_ast_not_void: click_ast /= Void
		do
			if is_generic then
				report_basic_generic_type_error
			end
			Result := new_boolean_type_as
			click_ast.set_node (Result)
		ensure
			type_not_void: Result /= Void
			click_ast_updated: click_ast.node = Result
		end

	new_character_type (click_ast: CLICK_AST; is_generic, is_wide: BOOLEAN): CHAR_TYPE_AS is
			-- New character class type;
			-- Update the clickable list and report
			-- error if `is_generic' is true.
		require
			click_ast_not_void: click_ast /= Void
		do
			if is_generic then
				report_basic_generic_type_error
			end
			Result := new_character_type_as (is_wide)
			click_ast.set_node (Result)
		ensure
			type_not_void: Result /= Void
			click_ast_updated: click_ast.node = Result
		end

	new_double_type (click_ast: CLICK_AST; is_generic: BOOLEAN): DOUBLE_TYPE_AS is
			-- New double class type;
			-- Update the clickable list and report
			-- error if `is_generic' is true.
		require
			click_ast_not_void: click_ast /= Void
		do
			if is_generic then
				report_basic_generic_type_error
			end
			Result := new_double_type_as
			click_ast.set_node (Result)
		ensure
			type_not_void: Result /= Void
			click_ast_updated: click_ast.node = Result
		end

	new_integer_type (click_ast: CLICK_AST; is_generic: BOOLEAN; n: INTEGER): INT_TYPE_AS is
			-- New integer class type;
			-- Update the clickable list and report
			-- error if `is_generic' is true.
		require
			click_ast_not_void: click_ast /= Void
			valid_n: n = 8 or n = 16 or n = 32 or n = 64
		do
			if is_generic then
				report_basic_generic_type_error
			end
			Result := new_integer_type_as (n)
			click_ast.set_node (Result)
		ensure
			type_not_void: Result /= Void
			click_ast_updated: click_ast.node = Result
		end

	new_none_type (click_ast: CLICK_AST; is_generic: BOOLEAN): NONE_TYPE_AS is
			-- New none class type;
			-- Update the clickable list and report
			-- error if `is_generic' is true.
		require
			click_ast_not_void: click_ast /= Void
		do
			if is_generic then
				report_basic_generic_type_error
			end
			Result := new_none_type_as
			click_ast.set_node (Result)
		ensure
			type_not_void: Result /= Void
			click_ast_updated: click_ast.node = Result
		end

	new_pointer_type (click_ast: CLICK_AST; is_generic: BOOLEAN): POINTER_TYPE_AS is
			-- New pointer class type;
			-- Update the clickable list and report
			-- error if `is_generic' is true.
		require
			click_ast_not_void: click_ast /= Void
		do
			if is_generic then
				report_basic_generic_type_error
			end
			Result := new_pointer_type_as
			click_ast.set_node (Result)
		ensure
			type_not_void: Result /= Void
			click_ast_updated: click_ast.node = Result
		end

	new_real_type (click_ast: CLICK_AST; is_generic: BOOLEAN): REAL_TYPE_AS is
			-- New real class type;
			-- Update the clickable list and report
			-- error if `is_generic' is true.
		require
			click_ast_not_void: click_ast /= Void
		do
			if is_generic then
				report_basic_generic_type_error
			end
			Result := new_real_type_as
			click_ast.set_node (Result)
		ensure
			type_not_void: Result /= Void
			click_ast_updated: click_ast.node = Result
		end

feature {NONE} -- Error handling

	report_basic_generic_type_error is
			-- Basic types cannot have generic devivation.
		local
			an_error: BASIC_GEN_TYPE_ERR
		do
			!! an_error.make (current_position.start_position, current_position.end_position, filename, 0, "", False)
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
			!! an_error.make (current_position.start_position, current_position.end_position, filename, 0, "", False)
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
			!! an_error.make (current_position.start_position, current_position.end_position, filename, 0, "", False)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error
		end

	report_error (a_message: STRING) is
			-- A syntax error has been detected.
			-- Print error message.
		local
			an_error: SYNTAX_ERROR
		do
			!! an_error.make (current_position.start_position, current_position.end_position, filename, 0, "", False)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error
		end

feature {NONE} -- Constants

	Dummy_clickable_as: CLICKABLE_AST is
			-- Dummy CLICKABLE_AST used to temporarily
			-- fill `node' in CLICK_AST
		once
			Result := new_integer_type_as (32)
		ensure
			dummy_clicable_as_not_void: Result /= Void
		end

	Integer_8_classname: STRING is "integer_8"
	Integer_16_classname: STRING is "integer_16"
	Integer_classname: STRING is "integer"
	Integer_64_classname: STRING is "integer_64"
	Boolean_classname: STRING is "boolean"
	Character_classname: STRING is "character"
	Wide_char_classname: STRING is "wide_character"
	Double_classname: STRING is "double"
	None_classname: STRING is "none"
	Pointer_classname: STRING is "pointer"
	Real_classname: STRING is "real"

	Initial_formal_parameters_capacity: INTEGER is 8
				-- Initial capacity for `formal_parameters'
				-- (See `eif_rtlimits.h')

	Initial_click_list_capacity: INTEGER is 100
				-- Initial capacity for `click_list'

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
	Initial_operand_list_size: INTEGER is 8
	Initial_parameter_list_size: INTEGER is 9
	Initial_parent_list_size: INTEGER is 10
	Initial_rename_list_size: INTEGER is 10
	Initial_type_list_size: INTEGER is 4
	Initial_when_part_list_size: INTEGER is 3
			-- Initial capacity for lists

	Normal_level: INTEGER is 0
	Assert_level: INTEGER is 1
	Invariant_level: INTEGER is 2

invariant

	click_list_not_void: click_list /= Void
	suppliers_not_void: suppliers /= Void
	formal_parameters_not_void: formal_parameters /= Void
	no_void_formal_parameter: not formal_parameters.has (Void)
	valid_id_level: (id_level = Normal_level) or
		(id_level = Assert_level) or (id_level = Invariant_level)
	is_frozen_class_not_set: not il_parser implies not is_frozen_class
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
