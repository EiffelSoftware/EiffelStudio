indexing
	description	: "Representation of an Eiffel feature."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date		: "$Date$";
	revision	: "$Revision$"

class E_FEATURE

inherit
	COMPARABLE

	SHARED_EIFFEL_PROJECT
		undefine
			is_equal
		end

	HASHABLE
		undefine
			is_equal
		end

	SHARED_SERVER
		undefine
			is_equal
		end

	COMPILER_EXPORTER
		undefine
			is_equal
		end

	SHARED_TEXT_ITEMS
		undefine
			is_equal
		end

	PREFIX_INFIX_NAMES
		undefine
			is_equal
		end

	SHARED_NAMES_HEAP
		undefine
			is_equal
		end

feature -- Initialization

	make (n: like name_id; a: like alias_name; c: like has_convert_mark; i: INTEGER) is
			-- Initialize feature with name `n' with
			-- identification `i'.
		require
			valid_n: n >= 0
			positive_i: i >= 0
		do
			name_id := n
			alias_name := a
			has_convert_mark := c
			feature_id := i
		ensure
			name_id_set: name_id = n
			alias_name_set: alias_name = a
			feature_id_set: feature_id = i
		end

feature -- Status report

	is_valid: BOOLEAN is
			-- Is current feature still valid?
		do
			Result := (associated_class_id > 0 and then eiffel_system.class_of_id (associated_class_id) /= Void) and then
				(written_in > 0 and then eiffel_system.class_of_id (written_in) /= Void)
		end

feature -- Properties

	name_id: INTEGER
			-- Name id in the names heap.

	name: STRING is
			-- Final name of the feature
		do
			Result := names_heap.item (name_id)
		end

	alias_name: STRING
			-- Alias name of the feature (if any)

	has_convert_mark: BOOLEAN
			-- Is convert mark specified for an operator alias?

	has_alias_name: BOOLEAN is
			-- Does current routine represent a routine with an alias?
		do
			Result := alias_name /= Void
		end

	assigner_name: STRING is
			-- Name of the assigner procedure (if any)
		do
				-- Void by default
		end

	feature_id: INTEGER;
			-- Unique identification for a feature in `associated_class_id'.

	written_feature_id: INTEGER
			-- Unique identification for a feature in `written_in'.

	written_in: INTEGER
			-- Class id where feature is written in

	body_index: INTEGER;
			-- Identification of the body
			-- (Two features can have the same body_index if
			-- they are shared through replication)

	rout_id_set: ROUT_ID_SET;
			-- Routine table to which the feature belongs to.

	export_status: EXPORT_I;
			-- Export status of the feature

	is_origin: BOOLEAN;
			-- Is feature an origin ?

	is_frozen: BOOLEAN;
			-- Is feature frozen ?
			-- Notes from Arnaud: it has nothing to do with
			-- melted/frozen feature but refers to the keyword
			-- frozen you can add before a feature name

	is_infix: BOOLEAN;
			-- Is feature an infixed one ?

	is_prefix: BOOLEAN;
			-- Is feature a prefixed one ?

	obsolete_message: STRING;
			-- Obsolete message
			-- (Void if Current is not obsolete)

	is_procedure: BOOLEAN is
			-- Is current feature a procedure ?
		do
			-- Do nothing
		end;

	is_function: BOOLEAN is
			-- Is current feature a function ?
		do
			-- Do nothing
		end;

	is_attribute: BOOLEAN is
			-- Is current feature an attribute ?
		do
			-- Do nothing
		end;

	is_constant: BOOLEAN is
			-- Is current feature a constant ?
		do
			-- Do nothing
		end;

	is_once: BOOLEAN is
			-- Is current feature a once one ?
		do
			-- Do nothing
		end;

	is_deferred: BOOLEAN is
			-- Is current feature a deferred one ?
		do
			-- Do nothing
		end;

	is_unique: BOOLEAN is
			-- Is current feature a unique constant ?
		do
			-- Do nothing
		end;

	is_external: BOOLEAN is
			-- Is current feature an external one ?
		do
			-- Do nothing
		end;

	has_return_value: BOOLEAN is
			-- Does current return a value?
		do
			Result := is_constant or is_attribute or is_function
		ensure
			validity: Result implies (is_constant or is_attribute or is_function)
		end

	is_il_external: BOOLEAN
			-- Is current feature an IL external one?

	is_obsolete: BOOLEAN is
			-- Is Current feature obsolete?
		do
			Result := obsolete_message /= Void
		end;

	has_precondition: BOOLEAN is
			-- Is feature declaring some preconditions ?
		do
			-- Do nothing
		end;

	has_postcondition: BOOLEAN is
			-- Is feature declaring some postconditions ?
		do
			-- Do nothing
		end;

	has_assertion: BOOLEAN is
			-- Is feature declaring some pre or post conditions ?
		do
			Result := has_postcondition or else has_precondition
		end;

	has_arguments: BOOLEAN is
 			-- Has current feature some formal arguments ?
		do
			Result := arguments /= Void
		end

	has_rescue_clause: BOOLEAN is
			-- Has rescue clause ?
		local
			f: like associated_feature_i
		do
			f := associated_feature_i
			if f /= Void then
				Result := f.has_rescue_clause
			end
		end

	arguments: E_FEATURE_ARGUMENTS is
			-- Argument types
		do
		end;

	argument_names: LIST [STRING] is
			-- Argument names
		do
		end;

	locals: EIFFEL_LIST [TYPE_DEC_AS] is
			-- Locals for current feature
		do
		end;

	object_test_locals: LIST [TUPLE [name: ID_AS; type: TYPE_AS]] is
			-- Object test locals mentioned in the routine
		do
		end

	argument_count: INTEGER is
			-- Number of arguments of the feature
		do
			if arguments /= Void then
				Result := arguments.count;
			end;
		end;

	type: TYPE_A is
			-- Feature type
		do
		end;

	is_inline_agent: BOOLEAN
			-- is the featuer an inline angent
		do
		end

feature -- Access

	written_feature: E_FEATURE is
			-- Associated feature of Current in the context of the class in which
			-- current feature is written.
		local
			l_class: like written_class
		do
			l_class := written_class
			if l_class /= Void and then l_class.has_feature_table then
				if body_index /= 0 then
					Result := l_class.feature_with_body_index (body_index)
				elseif written_feature_id /= 0 then
						-- Most likely a pure external routine without body index.
					Result := l_class.feature_with_feature_id (written_feature_id)
				end
			end
		end

	ancestor_version (an_ancestor: CLASS_C): E_FEATURE is
			-- Feature in `an_ancestor' of which `Current' is derived.
			-- `Void' if not present in that class.
		require
			an_ancestor_not_void: an_ancestor /= Void
		local
			n, nb: INTEGER
			ris: ROUT_ID_SET
			rout_id: INTEGER
		do
			if an_ancestor.is_valid and then an_ancestor.has_feature_table then
				ris := rout_id_set
				if ris /= Void then
					from
						n := ris.lower
						nb := ris.count
					until
						n > nb or else Result /= Void
					loop
						rout_id := ris.item (n)
						if rout_id > 0 then
							Result := an_ancestor.feature_with_rout_id (rout_id)
						end
						n := n + 1
					end
				end
			end
		end

	precursors: ARRAYED_LIST [CLASS_C] is
			-- Precursor definition of written in classes
			-- of current feature defined in `from_c'
		local
			f: FEATURE_I;
			inh_info: INH_ASSERT_INFO;
			i, nb: INTEGER;
			assert_id_set: ASSERT_ID_SET;
			e_class: CLASS_C
		do
			f := associated_feature_i;
			if f /= Void then
				assert_id_set := f.assert_id_set;
				if assert_id_set /= Void then
					nb := assert_id_set.count;
					create Result.make (nb);
					from
						i := 1
					until
						i > nb
					loop
						inh_info := assert_id_set.item (i);
						e_class := Eiffel_system.class_of_id (inh_info.written_in);
						if e_class /= Void then
							--| On the off chance that this information
							--| is not upto date hence the check with void
							Result.extend (e_class)
						end;
						i := i + 1
					end
				end
			end
		end;

	is_debuggable: BOOLEAN is
			-- Is feature debuggable?
		local
			cl: CLASS_C
		do
			if
				(body_index /= 0) and then
				(not is_attribute) and then
				(not is_constant) and then
				(not is_deferred) and then
				(not is_unique)
			then
				cl := written_class
				Result := cl /= Void and then cl.is_debuggable
			end
		ensure
			debuggable_if: Result implies
				(body_index /= 0) and then
				(not is_attribute) and then
				(not is_constant) and then
				(not is_deferred) and then
				(not is_unique) and then
				(written_class /= Void and then written_class.is_debuggable)
		end;

	text (a_text_formatter: TEXT_FORMATTER): BOOLEAN is
			-- Text of the feature.
			-- Void if unreadable file
		local
			class_text: STRING;
			start_position, end_position: INTEGER;
			body_as: FEATURE_AS;
			rout_as: ROUTINE_AS
			c: like written_class;
		do
			c := written_class;
			class_text := c.text;
			if class_text /= Void then
				if {l_name: !STRING_GENERAL} name then
						-- Attempt to locate a feature using the same name as Current
					body_as := c.ast.feature_of_name (l_name, False)
				end
				if body_as = Void then
						-- Fall back and use the old implementation
					body_as := ast
				end

					-- Extract positional information
				start_position := body_as.start_position
				rout_as ?= body_as.body.content
				if rout_as = Void then
						-- `body_as.end_position' excludes feature comments
						-- Let's use take the text up-to the next syntax construct
					end_position := body_as.next_position - 1
				else
					end_position := body_as.end_position
				end

				if c /= associated_class then
						-- From a different class
					a_text_formatter.add ("-- Version inherited from class: ");
					a_text_formatter.add_classi (c.lace_class, c.name_in_upper);
					a_text_formatter.add_new_line;
				end
				a_text_formatter.add_new_line;

				a_text_formatter.add_indent;
				if
					class_text.count >= end_position and
					start_position < end_position
				then
					class_text := class_text.substring
								(start_position, end_position);
					a_text_formatter.add_feature (Current, class_text)
				end;
				a_text_formatter.add_new_line;
			else
				Result := true
			end
		end;

	associated_class: CLASS_C is
			-- Class where the feature was evaluated in
		do
			check
				valid_class: associated_class_id /= 0
			end;
			Result := Eiffel_system.class_of_id (associated_class_id);
		end;

	written_class: CLASS_C is
			-- Class where the feature is written in
		require
			good_written_in: written_in /= 0;
		do
			Result := Eiffel_system.class_of_id (written_in);
		end;

	is_compiled: BOOLEAN is
			-- Has the feature been compiled?
			-- (Has been compiled if passed degree 4)
		do
			Result := body_index /= 0 or else written_class.is_true_external
		end;

	is_exported_to (client: CLASS_C): BOOLEAN is
			-- Is current feature exported to class `client' ?
		require
			good_argument: client /= Void;
			has_export_status: export_status /= Void;
		do
			Result := export_status.is_exported_to (client);
		end;

	ast: FEATURE_AS is
			-- Associated AST structure for feature
		local
			class_ast: CLASS_AS;
			bid: INTEGER
			l_feature_names: EIFFEL_LIST [FEATURE_NAME]
		do
			bid := body_id_for_ast;
			if bid > 0 then
					-- Server in the temporary server first to get the latest version of the AST.
				Result := body_server.item (bid)
			end
			if Result = Void then
				class_ast := tmp_ast_server.item (written_in)
				if class_ast /= Void then
					Result := class_ast.feature_with_name (name_id)
				end
			end

			if Result = Void then
					-- In this case we must certainly be handling a dotnet feature and we need
					-- to create an empty AST otherwise we cannot pick and drop it.
				create l_feature_names.make (1)
				l_feature_names.extend (create {FEAT_NAME_ID_AS}.initialize (
					create {ID_AS}.initialize (name)))
				if is_frozen then
					l_feature_names.last.set_frozen_keyword (create {KEYWORD_AS}.make_null)
				end
				create Result.initialize (l_feature_names, create {BODY_AS}.initialize (Void, Void, Void, Void, Void, Void, Void, Void), Void, 0, 0)
			end
		end;

	hash_code: INTEGER is
			-- Hash code
		do
			Result := name_id
		end;

	callees (a_flag: NATURAL_16): LINKED_LIST [TUPLE [class_c: CLASS_C; feature_name: STRING]] is
			-- Callees of feature in `associated_class'
			-- from client class `su_class'.
		require
			valid_flags: a_flag = 0 or
				a_flag = {DEPEND_UNIT}.is_in_assignment_flag or
				a_flag = {DEPEND_UNIT}.is_in_check_flag or
				a_flag = {DEPEND_UNIT}.is_in_creation_flag or
				a_flag = {DEPEND_UNIT}.is_in_ensure_flag or
				a_flag = {DEPEND_UNIT}.is_in_invariant_flag or
				a_flag = {DEPEND_UNIT}.is_in_require_flag
		local
			dep: CLASS_DEPENDANCE
			fdep: FEATURE_DEPENDANCE
			l_depend_unit: DEPEND_UNIT
			l_system: like eiffel_system
			l_class_c: CLASS_C
			l_e_feature: E_FEATURE
		do
			create Result.make
			l_system := eiffel_system
			if Depend_server.has (written_class.class_id) then
				dep := Depend_server.item (written_class.class_id)
				from
					fdep := dep.item (body_index)
					fdep.start
				until
					fdep.after
				loop
					l_depend_unit := fdep.item
					if l_depend_unit.rout_id /= 0 then
						if a_flag = 0 or else l_depend_unit.internal_flags.bit_xor (a_flag) = 0 then
							l_class_c := l_system.class_of_id (l_depend_unit.class_id)
							if l_class_c /= Void then
								l_e_feature := l_class_c.feature_with_rout_id (l_depend_unit.rout_id)
									-- We ignore inline agents because what they called are already
									-- propagated to the enclosing feature.
								if l_e_feature /= Void and then not l_e_feature.is_inline_agent then
									Result.extend ([l_class_c, l_e_feature.name])
								end
							end
						end
					end
					fdep.forth
				end
			end
			if Result.is_empty then
				Result := Void
			end
		ensure
			valid_result: Result /= Void implies not Result.is_empty
		end

	callers (cl_class: CLASS_C; a_flag: NATURAL_16): SORTED_TWO_WAY_LIST [STRING] is
			-- Callers for feature from `associated_class'
			-- to client class `cl_class'
		require
			valid_cl_class: associated_class.clients.has (cl_class)
			valid_flags: a_flag = 0 or
				a_flag = {DEPEND_UNIT}.is_in_assignment_flag or
				a_flag = {DEPEND_UNIT}.is_in_check_flag or
				a_flag = {DEPEND_UNIT}.is_in_creation_flag or
				a_flag = {DEPEND_UNIT}.is_in_ensure_flag or
				a_flag = {DEPEND_UNIT}.is_in_invariant_flag or
				a_flag = {DEPEND_UNIT}.is_in_require_flag
		local
			dep: CLASS_DEPENDANCE;
			fdep: FEATURE_DEPENDANCE;
			current_d, l_depend_unit: DEPEND_UNIT;
			l_found: BOOLEAN
		do
			create Result.make
			dep := Depend_server.item (cl_class.class_id)
				-- No need to set the `flags' here since we do an explicit comparison.
			create current_d.make (associated_class.class_id,associated_feature_i)
			from
				-- Loop through the features of each client
				-- of current_class.
				dep.start
			until
				dep.after
			loop
				fdep := dep.item_for_iteration
				from
					l_found := False
					fdep.start
				until
					l_found or fdep.after
				loop
					l_depend_unit := fdep.item
					l_found := l_depend_unit.same_as (current_d) and then
						l_depend_unit.internal_flags & a_flag = a_flag
					fdep.forth
				end
				if l_found then
					Result.put_front (fdep.feature_name)
				end
				dep.forth
			end
			if Result.is_empty then
				Result := Void
			else
				Result.sort
			end
		ensure
			valid_result: Result /= Void implies not Result.is_empty
					and then Result.sorted
		end

	updated_version: E_FEATURE is
			-- Updated version of feature after a compilation
			-- (First it checks if the `associated_class' is valid and
			-- retrieves the feature using `name' from the
			-- `associated_class' feature table)
		local
			class_c: CLASS_C
		do
				--| We try first to get the class on which the feature was previously
				--| defined. In the case, where the class has been removed from the
				--| system, there is no `associated_class' and we should no go any
				--| further.
			class_c := associated_class
			if
				class_c /= Void and then class_c.is_valid
				and then class_c.has_feature_table
			then
				Result := class_c.feature_with_name (name)
			end
		end

	number_of_breakpoint_slots: INTEGER is
			-- Number of breakpoint slots in the feature (:::)
			-- It includes the pre/postcondition (inner & herited)
			-- and the rescue clause.
		local
			f: FEATURE_I
		do
			f := associated_feature_i
			if f /= Void then
				Result := f.number_of_breakpoint_slots
			end
		end

	first_breakpoint_slot_index: INTEGER is
			-- Index of the first breakpoin-slot of the body
			-- Take into account inherited and inner assertions
		local
			f: FEATURE_I
		do
			f := associated_feature_i
			if f /= Void then
				Result := f.first_breakpoint_slot_index
			end
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := name < other.name
		end

	same_as (other: E_FEATURE): BOOLEAN is
		require
			other_not_void: other /= Void
		do
				-- We say two features are the same if they are defined from the same location.
			Result := associated_class_id = other.associated_class_id and
				body_index = other.body_index and
				feature_id = other.feature_id and
				written_in = other.written_in and
				written_feature_id = other.written_feature_id
		end

feature -- Output

	append_signature (a_text_formatter: TEXT_FORMATTER) is
			-- Append the signature of current feature in `a_text_formatter'
		require
			non_void_st: a_text_formatter /= Void
		do
			append_full_name (a_text_formatter)
			append_just_signature (a_text_formatter)
		end

	append_just_signature (a_text_formatter: TEXT_FORMATTER) is
			-- Append just signature of feature in `a_text_formatter'.
		require
			st_not_void: a_text_formatter /= Void
		do
			append_arguments (a_text_formatter)
			append_just_type (a_text_formatter)
		end

	append_arguments (a_text_formatter: TEXT_FORMATTER) is
			-- Append just arguments to `a_text_formatter'.
		require
			st_not_void: a_text_formatter /= Void
		local
			args: like arguments
			orig_type, cur_type: TYPE_A
			same: BOOLEAN
		do
			args := arguments
			if args /= Void then
				a_text_formatter.add_space
				a_text_formatter.process_symbol_text (Ti_l_parenthesis)
				from
					args.start
				until
					args.after
				loop
					orig_type := args.item
					a_text_formatter.add_local (args.argument_names.i_th (args.index))
					same := True
					from args.forth until not same or else args.after loop
						cur_type := args.item
						if cur_type.same_type (orig_type) and then cur_type.is_equivalent (orig_type) then
							a_text_formatter.process_symbol_text (Ti_comma)
							a_text_formatter.add_space
							a_text_formatter.add_local (args.argument_names.i_th (args.index))
							args.forth
						else
							same := False
						end
					end
					a_text_formatter.process_symbol_text (Ti_colon)
					a_text_formatter.add_space
					orig_type.ext_append_to (a_text_formatter, associated_class)
					if not args.after then
						a_text_formatter.process_symbol_text (Ti_semi_colon)
						a_text_formatter.add_space
					end
				end
				a_text_formatter.process_symbol_text (Ti_r_parenthesis)
			end
		end

	append_just_type (a_text_formatter: TEXT_FORMATTER) is
			-- Append type of the feature to `a_text_formatter'.
		require
			valid_st: a_text_formatter /= Void
		do
			if not is_procedure then
				a_text_formatter.process_symbol_text (Ti_colon)
				a_text_formatter.add_space
				type.ext_append_to (a_text_formatter, associated_class)
			end
		end

	append_name (a_text_formatter: TEXT_FORMATTER) is
			-- Append the name of the feature in `a_text_formatter'
		require
			valid_st: a_text_formatter /= Void
		local
			l_name: STRING
		do
			if is_infix then
				a_text_formatter.process_keyword_text (Ti_infix_keyword, Void)
				a_text_formatter.add_space
				a_text_formatter.process_symbol_text (Ti_double_quote)
				a_text_formatter.process_operator_text (extract_symbol_from_infix (name), Current)
				a_text_formatter.process_symbol_text (Ti_double_quote)
			elseif is_prefix then
				a_text_formatter.process_keyword_text (Ti_prefix_keyword, Void)
				a_text_formatter.add_space
				a_text_formatter.process_symbol_text (Ti_double_quote)
				a_text_formatter.process_operator_text (extract_symbol_from_prefix (name), Current)
				a_text_formatter.process_symbol_text (Ti_double_quote)
			else
				l_name := name.as_lower
				if is_once or else is_constant then
					l_name.put ((l_name @ 1).upper, 1)
				end
				a_text_formatter.add_feature (Current, l_name)
			end
		end

	append_full_name (a_text_formatter: TEXT_FORMATTER) is
			-- Append name of the feature in `a_text_formatter' in its complete form
			-- (with infix and prefix keywords and alias names if any).
		require
			valid_st: a_text_formatter /= Void
		local
			a: like alias_name
		do
			append_name (a_text_formatter)
			if not is_infix and then not is_prefix then
				a := alias_name
				if a /= Void then
					a_text_formatter.add_space
					a_text_formatter.process_keyword_text (Ti_alias_keyword, Void)
					a_text_formatter.add_space
					a_text_formatter.process_symbol_text (Ti_double_quote)
					a_text_formatter.process_operator_text (extract_alias_name (a), Current)
					a_text_formatter.process_symbol_text (Ti_double_quote)
				end
			end
			if has_convert_mark then
				a_text_formatter.add_space
				a_text_formatter.process_keyword_text (ti_convert_keyword, Void)
			end
		end

	infix_symbol : STRING is
			--
		require
			is_infix: is_infix
		do
			Result := extract_symbol_from_infix (name)
		ensure
			infix_symbol_not_void: Result /= Void
		end

	prefix_symbol : STRING is
			--
		require
			is_infix: is_prefix
		do
			Result := extract_symbol_from_prefix (name)
		ensure
			prefix_symbol_not_void: Result /= Void
		end

	alias_symbol: STRING is
		require
			is_alias: has_alias_name
		do
			Result := extract_alias_name (alias_name)
		ensure
			alias_symbol_not_void: Result /= Void
		end

feature -- Output

	feature_signature: STRING is
			-- Signature of Current feature
		do
			create Result.make (50)
			Result.append (name)
			append_arguments_to (Result)
		end

	append_arguments_to (s: STRING) is
			-- Append arguments to `s'.
		require
			s_not_void: s /= Void
		local
			args: like arguments
		do
			args := arguments
			if args /= Void then
				s.append (" (")
				from
					args.start
				until
					args.after
				loop
					s.append (args.argument_names.i_th (args.index))
					s.append (": ")
					s.append (args.item.dump)
					args.forth
					if not args.after then
						s.append ("; ")
					end
				end
				s.append (")")
			end
		end

	valid_body_index: BOOLEAN is
			-- The use of this routine as precondition for real_body_id
			-- allows the enhancement of the external functions
			-- Indeed, if an external has to be encapsulated (macro, signature)
			-- an EXECUTION_UNIT is created instead of an EXT_EXECUTION_UNIT
		do
			Result := associated_class.has_types
			if Result then
				Result := (is_constant and is_once) or
					(not is_attribute and then
					not is_constant and then not is_deferred and then not is_unique)
			end
		end;

feature -- Implementation

	real_body_id: INTEGER is
			-- Real body id at compilation time.
		require
			valid_body_index: valid_body_index
		local
			f: FEATURE_I
		do
			f := associated_feature_i
				-- `f' can be Void when there is an error
				-- and user wants to get a flat view
			if f /= Void then
				Result := f.real_body_id (f.written_class.types.first)
			end
		end

feature {E_FEATURE} -- Implementation

	associated_class_id: INTEGER
            -- Class id where the feature was evaluated in

feature -- Implementation

	associated_feature_i: FEATURE_I is
			-- Assocated feature_i
		do
			Result := associated_class.feature_named (name)
		end;

	body_id_for_ast: INTEGER
			-- Body id that should be used for retrieving the ast (by feature ast)
		do
			Result := body_index
		end

feature {FEATURE_I} -- Setting

	set_written_in (i: INTEGER) is
			-- Set `written_in' to `i'.
		do
			written_in := i;
		end;

	set_associated_class_id (i: INTEGER) is
			-- Set `associated_class_id' to `i'.
		do
			associated_class_id := i
		end;

	set_body_index (i: INTEGER) is
			-- Assign `i' to `body_index'.
		do
			body_index := i;
		end;

	set_is_origin (b: BOOLEAN) is
			-- Assign `b' to `is_origin'.
		do
			is_origin := b;
		end;

	set_export_status (e: EXPORT_I) is
			-- Assign `e' to `export_status'.
		do
			export_status := e;
		end;

	set_is_frozen (b: BOOLEAN) is
			-- Assign `b' to `is_frozen'.
		do
			is_frozen := b;
		end;

	set_is_infix (b: BOOLEAN) is
			-- Assign `b' to `is_infix'.
		do
			is_infix := b;
		end;

	set_is_prefix (b: BOOLEAN) is
			-- Assign `b' to `is_prefix'.
		do
			is_prefix := b;
		end;

	set_rout_id_set (set: like rout_id_set) is
			-- Assign `set' to `rout_id_set'.
		do
			rout_id_set := set;
		end;

	set_is_il_external (v: like is_il_external) is
			-- Set `is_il_external' to `v'.
		do
			is_il_external := v
		ensure
			is_il_external_set: is_il_external = v
		end

	set_written_feature_id (v: like written_feature_id) is
			-- Set `written_feature_id' with `v'.
		require
			v_non_negative: v >= 0
		do
			written_feature_id := v
		ensure
			written_feature_id_set: written_feature_id = v
		end

invariant
	associated_class_not_void: is_valid implies associated_class /= Void
	written_class_not_void: is_valid implies written_class /= Void

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class E_FEATURE
