note
	description: "Representation of an Eiffel feature."

deferred class E_FEATURE

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

	INTERNAL_COMPILER_STRING_EXPORTER
		undefine
			is_equal
		end

feature -- Initialization

	make (n: like name_id; a: STRING; c: like has_convert_mark; i: INTEGER)
			-- Initialize feature with name `n' with
			-- identification `i'.
		require
			valid_n: n >= 0
			positive_i: i >= 0
		do
			name_id := n
			if a /= Void then
				add_alias (a)
			end
			has_convert_mark := c
			feature_id := i
		ensure
			name_id_set: name_id = n
			has_alias_name: a /= Void implies has_alias_named (a)
			feature_id_set: feature_id = i
		end

	make_with_aliases (n: like name_id; a_aliases: LIST [STRING]; c: like has_convert_mark; i: INTEGER)
			-- Initialize feature with name `n' with
			-- identification `i'.
		require
			valid_n: n >= 0
			positive_i: i >= 0
		do
			name_id := n
			if a_aliases /= Void then
				across
					a_aliases as ic
				loop
					add_alias (ic.item)
				end
			end
			has_convert_mark := c
			feature_id := i
		ensure
			name_id_set: name_id = n
			has_alias_name: a_aliases /= Void implies across a_aliases as ic all has_alias_named (ic.item) end
			feature_id_set: feature_id = i
		end

feature -- Status report

	is_valid: BOOLEAN
			-- Is current feature still valid?
		local
			cl_id: like associated_class_id
		do
			cl_id := associated_class_id
			if eiffel_system.valid_class_id (cl_id) and then eiffel_system.class_of_id (cl_id) /= Void then
				if cl_id = written_in then
					Result := True
				else
					cl_id := written_in
					Result := eiffel_system.valid_class_id (cl_id) and then eiffel_system.class_of_id (cl_id) /= Void
				end
			end
		end

	valid_body_index: BOOLEAN
			-- The use of this routine as precondition for real_body_id
			-- allows the enhancement of the external functions
			-- Indeed, if an external has to be encapsulated (macro, signature)
			-- an EXECUTION_UNIT is created instead of an EXT_EXECUTION_UNIT
		do
			Result := associated_class.has_types
			if Result then
				Result := (is_constant and is_once) or
					(not (is_attribute and then not is_attribute_with_body ) and then
					not is_constant and then not is_deferred and then not is_unique)
			end
		end;

feature -- Properties

	name_id: INTEGER
			-- Name id in the names heap.

	name_32: STRING_32
			-- Final name of the feature.
			-- UTF-32 encoding.
		do
			Result := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (names_heap.item (name_id))
		end

	name_8: STRING_8
			-- Final name of the feature
			-- UTF-8 encoding
		do
			Result := name
		end

	aliases: detachable ARRAYED_LIST [TUPLE [alias_name: STRING; alias_name_32: STRING_32]]

	has_convert_mark: BOOLEAN
			-- Is convert mark specified for an operator alias?

	has_alias_name: BOOLEAN
			-- Does current routine represent a routine with an alias?
		do
			Result := attached aliases as lst and then not lst.is_empty
		end

	has_alias_named (a_name: STRING): BOOLEAN
		do
			if attached aliases as lst then
				across
					lst as c
				until
					Result
				loop
					if attached a_name.is_case_insensitive_equal (c.item.alias_name) then
						Result := True
					end
				end
			end
		end

	assigner_name_32: detachable STRING_32
			-- Name of the assigner procedure (if any)
		do
			if attached assigner_name as l_name then
				Result := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (l_name)
			end
		end

	feature_id: INTEGER
			-- Unique identification for a feature in `associated_class_id'.

	written_feature_id: INTEGER
			-- Unique identification for a feature in `written_in'.

	written_in: INTEGER
			-- Class id where feature is written in

	body_index: INTEGER
			-- Identification of the body
			-- (Two features can have the same body_index if
			-- they are shared through replication)

	rout_id_set: ROUT_ID_SET
			-- Routine table to which the feature belongs to.

	export_status: EXPORT_I
			-- Export status of the feature

	is_origin: BOOLEAN
			-- Is feature an origin ?

	is_frozen: BOOLEAN
			-- Is feature frozen ?
			-- Notes from Arnaud: it has nothing to do with
			-- melted/frozen feature but refers to the keyword
			-- frozen you can add before a feature name

	is_infix: BOOLEAN
			-- Is feature an infixed one ?

	is_prefix: BOOLEAN
			-- Is feature a prefixed one ?

	obsolete_message_32: detachable STRING_32
			-- Obsolete message
			-- (Void if Current is not obsolete)
		do
			if attached obsolete_message as l_m then
				Result := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (l_m)
			end
		end

	is_procedure: BOOLEAN
			-- Is current feature a procedure ?
		do
			-- Do nothing
		end

	is_function: BOOLEAN
			-- Is current feature a function ?
		do
			-- Do nothing
		end

	is_attribute: BOOLEAN
			-- Is current feature an attribute ?
		do
			-- Do nothing
		end

	is_attribute_with_body: BOOLEAN
			-- Is current feature an attribute with body?
		do
			-- Do nothing
		end

	is_class: BOOLEAN
			-- Is current feature a class one, i.e. can be called on a class type rather than on object?

	is_ghost: BOOLEAN
			-- Is current feature a ghost one, i.e. cannot be used for execution?

	is_constant: BOOLEAN
			-- Is current feature a constant ?
		do
			-- Do nothing
		end

	is_once: BOOLEAN
			-- Is current feature a once one ?
		do
			-- Do nothing
		end

	is_process_or_thread_relative_once: BOOLEAN
		do
			Result := is_once and not is_object_relative_once
		end

	is_object_relative_once: BOOLEAN
		do
		end

	is_deferred: BOOLEAN
			-- Is current feature a deferred one ?
		do
			-- Do nothing
		end;

	is_unique: BOOLEAN
			-- Is current feature a unique constant ?
		do
			-- Do nothing
		end;

	is_external: BOOLEAN
			-- Is current feature an external one ?
		do
			-- Do nothing
		end;

	has_return_value: BOOLEAN
			-- Does current return a value?
		do
			Result := is_constant or is_attribute or is_function
		ensure
			validity: Result implies (is_constant or is_attribute or is_function)
		end

	is_il_external: BOOLEAN
			-- Is current feature an IL external one?

	is_obsolete: BOOLEAN
			-- Is Current feature obsolete?
		do
			Result := obsolete_message /= Void
		end;

	has_precondition: BOOLEAN
			-- Is feature declaring some preconditions ?
		do
			-- Do nothing
		end;

	has_postcondition: BOOLEAN
			-- Is feature declaring some postconditions ?
		do
			-- Do nothing
		end;

	has_assertion: BOOLEAN
			-- Is feature declaring some pre or post conditions ?
		do
			Result := has_postcondition or else has_precondition
		end;

	has_arguments: BOOLEAN
 			-- Has current feature some formal arguments ?
		do
			Result := arguments /= Void
		end

	has_rescue_clause: BOOLEAN
			-- Has rescue clause ?
		local
			f: like associated_feature_i
		do
			f := associated_feature_i
			if f /= Void then
				Result := f.has_rescue_clause
			end
		end

	arguments: E_FEATURE_ARGUMENTS
			-- Argument types
		do
		end;

	argument_names: LIST [STRING]
			-- Argument names
		do
		end;

	locals: EIFFEL_LIST [LIST_DEC_AS]
			-- Locals for current feature
		do
		end

	locals_count: INTEGER
			-- Count of local variables
		do
			if attached locals as lst then
				across
					lst as l
				loop
					if
						attached l.item as l_dec and then
						attached l_dec.id_list as l_id_list
					then
						Result := Result + l_id_list.count
					end
				end
			end
		end

	object_test_locals: LIST [TUPLE [name: ID_AS; type: TYPE_AS]]
			-- Object test locals mentioned in the routine
		do
		end

	argument_count: INTEGER
			-- Number of arguments of the feature
		do
			if attached arguments as l_args then
				Result := l_args.count
			end;
		end;

	type: TYPE_A
			-- Feature type
		do
		end;

	is_inline_agent: BOOLEAN
			-- is the feature an inline angent?
		do
		end

	is_invariant: BOOLEAN
			-- Is this feature the invariant feature of its eiffel class ?
		do
		end

feature -- Element change

	add_alias (a: STRING_8)
		local
			lst: like aliases
		do
			lst := aliases
			if lst = Void then
				create lst.make (1)
				aliases := lst
			end
			lst.force ([a, {UTF_CONVERTER}.utf_8_string_8_to_string_32 (a)])
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Properties

	name: STRING
			-- Final name of the feature
		do
			Result := names_heap.item (name_id)
		end

	assigner_name: STRING
			-- Name of the assigner procedure (if any)
		do
				-- Void by default
		end

	obsolete_message: STRING;
			-- Obsolete message
			-- (Void if Current is not obsolete)

feature -- Access

	written_feature: E_FEATURE
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

	ancestor_version (an_ancestor: CLASS_C): E_FEATURE
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

	precursors: ARRAYED_LIST [CLASS_C]
			-- Precursor definition of written in classes
			-- of current feature defined in `from_c'
		local
			i, nb: INTEGER
		do
			if
				attached associated_feature_i as f and then
				attached f.assert_id_set as assert_id_set
			then
				nb := assert_id_set.count
				create Result.make (nb)
				from
					i := 1
				until
					i > nb
				loop
					if attached Eiffel_system.class_of_id (assert_id_set.item (i).written_in) as e_class then
						--| On the off chance that this information
						--| is not upto date hence the check with void
						Result.extend (e_class)
					end
					i := i + 1
				end
			end
		end

	is_debuggable: BOOLEAN
			-- Is feature debuggable?
			--| Protecting code by return False when exception occurred
			--| See bug#16186
		require
			is_valid: is_valid
		local
			rescued: BOOLEAN
		do
			if rescued then
					--| See why this occurs
				Result := False
			elseif
				body_index /= 0 and then
				not is_constant and then
				not is_deferred and then
				not is_unique and then
				not (is_attribute and not is_attribute_with_body) and then
				attached written_class as c
			then
				Result := c.is_debuggable
			end
		ensure
			debuggable_if: Result implies
				body_index /= 0 and then
				not is_constant and then
				not is_deferred and then
				not is_unique and then
				not (is_attribute and not is_attribute_with_body) and then
				attached written_class as c and then
				c.is_debuggable
		rescue
			rescued := True
			retry
		end

	text (a_text_formatter: TEXT_FORMATTER): BOOLEAN
			-- Process text of the feature.
			-- True if successfully proceed.
		local
			class_text: STRING
			start_position, end_position: INTEGER
			body_as: FEATURE_AS
			c: like written_class
		do
			c := written_class
			class_text := c.text
			if class_text /= Void then
				if attached name as l_name then
						-- Attempt to locate a feature using the same name as Current
					body_as := c.ast.feature_of_name (l_name, False)
				end
				if body_as = Void then
						-- Fall back and use the old implementation
					body_as := ast
				end

					-- Extract positional information
				start_position := body_as.start_position
				if attached {ROUTINE_AS} body_as.body.content then
					end_position := body_as.end_position
				else
						-- `body_as.end_position' excludes feature comments
						-- Let's use take the text up-to the next syntax construct
					end_position := body_as.next_position - 1
				end

				if c /= associated_class then
						-- From a different class
					a_text_formatter.add ("-- Version inherited from class: ")
					a_text_formatter.add_classi (c.lace_class, c.name_in_upper)
					a_text_formatter.add_new_line
				end
				a_text_formatter.add_new_line

				a_text_formatter.add_indent
				if
					class_text.count >= end_position and
					start_position < end_position
				then
					class_text := class_text.substring (start_position, end_position)
					a_text_formatter.add_feature (Current, {UTF_CONVERTER}.utf_8_string_8_to_string_32 (class_text))
				end
				a_text_formatter.add_new_line
			else
				Result := true
			end
		end

	associated_class: CLASS_C
			-- Class where the feature was evaluated in
		require
			is_valid: is_valid
		do
			check
				valid_class: associated_class_id /= 0
			end
			Result := Eiffel_system.class_of_id (associated_class_id)
		end

	written_class: CLASS_C
			-- Class where the feature is written in
		require
			good_written_in: written_in /= 0
			is_valid: is_valid
		do
			Result := Eiffel_system.class_of_id (written_in)
		end

	is_compiled: BOOLEAN
			-- Has the feature been compiled?
			-- (Has been compiled if passed degree 4)
		do
			Result := body_index /= 0 or else written_class.is_true_external
		end;

	is_exported_to (client: CLASS_C): BOOLEAN
			-- Is current feature exported to class `client' ?
		require
			good_argument: client /= Void;
			has_export_status: export_status /= Void;
		do
			Result := export_status.is_exported_to (client);
		end;

	ast: FEATURE_AS
			-- Associated AST structure for feature
		local
			bid: INTEGER
			l_feature_names: EIFFEL_LIST [FEATURE_NAME]
			has_error: BOOLEAN
			indexes: INDEXING_CLAUSE_AS
			index_list: EIFFEL_LIST [ATOMIC_AS]
		do
			if not has_error then
				bid := body_id_for_ast;
				if bid > 0 then
						-- Server in the temporary server first to get the latest version of the AST.
					Result := body_server.item (written_in, bid)
				end
			end

			if Result = Void then
					-- In this case we must certainly be handling a dotnet feature or the AST cannot be loaded due to corruption
					-- and we need to create an empty AST otherwise we cannot pick and drop it.
				create l_feature_names.make (1)
				l_feature_names.extend (create {FEAT_NAME_ID_AS}.initialize (
					create {ID_AS}.initialize (name)))
				if is_frozen then
					l_feature_names.last.set_frozen_keyword (create {KEYWORD_AS}.make_null)
				end
				if has_error then
					create index_list.make (1)
					index_list.extend (create {STRING_AS}.initialize ("Cannot load feature.", 0, 0, 0, 0, 0, 0, 0))
					create indexes.make (1)
					indexes.extend (create {INDEX_AS}.initialize (create {ID_AS}.initialize ("error"), index_list, Void))
				end
				create Result.initialize (l_feature_names, create {BODY_AS}.initialize (Void, Void, Void, Void, Void, Void, Void, Void), indexes, 0, 0)
			end
		rescue
			if not has_error then
					-- There is an error loading the feature. It is masked to avoid a crash (bug#13874).
				has_error := True
				retry
			end
		end

	hash_code: INTEGER
			-- Hash code
		do
			Result := name_id
		end;

	callees_32 (a_flag: NATURAL_16): LINKED_LIST [TUPLE [class_c: CLASS_C; feature_name: STRING_32]]
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
			l_depend_unit: DEPEND_UNIT
			l_system: like eiffel_system
		do
			create Result.make
			if
				Depend_server.has (written_class.class_id) and then
					-- It is possible detached when compilation is not finished. See bug#11409.
				attached Depend_server.item (written_class.class_id).item (body_index) as fdep
			then
				l_system := eiffel_system
				across
					fdep as d
				loop
					l_depend_unit := d.item
					if
						l_depend_unit.rout_id /= 0 and then
						(a_flag = 0 or else l_depend_unit.internal_flags.bit_xor (a_flag) = 0) and then
						attached l_system.class_of_id (l_depend_unit.class_id) as l_class_c and then
						attached l_class_c.feature_with_rout_id (l_depend_unit.rout_id) as l_e_feature and then
						not l_e_feature.is_inline_agent
					then
							-- We ignore inline agents because what they called are already
							-- propagated to the enclosing feature.
						Result.extend ([l_class_c, l_e_feature.name_32])
					end
				end
			end
			if Result.is_empty then
				Result := Void
			end
		ensure
			valid_result: Result /= Void implies not Result.is_empty
		end

	callers_32 (cl_class: CLASS_C; a_flag: NATURAL_16): SORTED_TWO_WAY_LIST [STRING_32]
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
			fdep: FEATURE_DEPENDANCE
			current_d, l_depend_unit: DEPEND_UNIT
			l_found: BOOLEAN
		do
			create Result.make
				-- No need to set the `flags' here since we do an explicit comparison.
			create current_d.make (associated_class.class_id, associated_feature_i)
				-- Loop through the features of each client
				-- of current_class.
			across
				Depend_server.item (cl_class.class_id) as d
			loop
				fdep := d.item
				across
					fdep as f
				from
					l_found := False
				until
					l_found
				loop
					l_depend_unit := f.item
					l_found := l_depend_unit.same_as (current_d) and then
						l_depend_unit.internal_flags & a_flag = a_flag
				end
				if l_found then
					Result.put_front (fdep.feature_name_32)
				end
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

	updated_version: E_FEATURE
			-- Updated version of feature after a compilation
			-- (First it checks if the `associated_class' is valid and
			-- retrieves the feature using `name' from the
			-- `associated_class' feature table)
		require
			is_valid: is_valid
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

	number_of_breakpoint_slots: INTEGER
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

	first_breakpoint_slot_index: INTEGER
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

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Access

	callees (a_flag: NATURAL_16): LINKED_LIST [TUPLE [class_c: CLASS_C; feature_name: STRING]]
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
			l_depend_unit: DEPEND_UNIT
			l_system: like eiffel_system
		do
			create Result.make
			if
				Depend_server.has (written_class.class_id) and then
					-- It is possible detached when compilation is not finished. See bug#11409.
				attached Depend_server.item (written_class.class_id).item (body_index) as fdep
			then
				l_system := eiffel_system
				across
					fdep as d
				loop
					l_depend_unit := d.item
					if
						l_depend_unit.rout_id /= 0 and then
						(a_flag = 0 or else l_depend_unit.internal_flags.bit_xor (a_flag) = 0) and then
						attached l_system.class_of_id (l_depend_unit.class_id) as l_class_c and then
						attached l_class_c.feature_with_rout_id (l_depend_unit.rout_id) as l_e_feature and then
						not l_e_feature.is_inline_agent
					then
							-- We ignore inline agents because what they called are already
							-- propagated to the enclosing feature.
						Result.extend ([l_class_c, l_e_feature.name])
					end
				end
			end
			if Result.is_empty then
				Result := Void
			end
		ensure
			valid_result: Result /= Void implies not Result.is_empty
		end

	callers (cl_class: CLASS_C; a_flag: NATURAL_16): SORTED_TWO_WAY_LIST [STRING]
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
			fdep: FEATURE_DEPENDANCE
			current_d, l_depend_unit: DEPEND_UNIT
			l_found: BOOLEAN
		do
			create Result.make
				-- No need to set the `flags' here since we do an explicit comparison.
			create current_d.make (associated_class.class_id,associated_feature_i)
				-- Loop through the features of each client of current_class.
			across
				Depend_server.item (cl_class.class_id) as d
			loop
				fdep := d.item
				across
					fdep as f
				from
					l_found := False
				until
					l_found
				loop
					l_depend_unit := f.item
					l_found := l_depend_unit.same_as (current_d) and then
						l_depend_unit.internal_flags & a_flag = a_flag
				end
				if l_found then
					Result.put_front (fdep.feature_name)
				end
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

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
		do
			Result := name < other.name
		end

	same_as (other: E_FEATURE): BOOLEAN
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

	append_signature (a_text_formatter: TEXT_FORMATTER)
			-- Append the signature of current feature in `a_text_formatter'
		require
			non_void_st: a_text_formatter /= Void
		do
			append_full_name (a_text_formatter)
			append_just_signature (a_text_formatter)
		end

	append_just_signature (a_text_formatter: TEXT_FORMATTER)
			-- Append just signature of feature in `a_text_formatter'.
		require
			st_not_void: a_text_formatter /= Void
		do
			append_arguments (a_text_formatter)
			append_just_type (a_text_formatter)
		end

	append_arguments (a_text_formatter: TEXT_FORMATTER)
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

	append_just_type (a_text_formatter: TEXT_FORMATTER)
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

	append_name (a_text_formatter: TEXT_FORMATTER)
			-- Append the name of the feature in `a_text_formatter'
		require
			valid_st: a_text_formatter /= Void
		local
			l_name: STRING_32
		do
			l_name := name_32.as_lower
			if is_once or else is_constant then
					-- TODO: Use `{CHARACTER_32}.to_title` when it is available.
				l_name [1] := l_name [1].as_upper
			end
			a_text_formatter.add_feature (Current, l_name)
		end

	append_full_name (a_text_formatter: TEXT_FORMATTER)
			-- Append name of the feature in `a_text_formatter' in its complete form
			-- (with infix and prefix keywords and alias names if any).
		require
			valid_st: a_text_formatter /= Void
		do
			append_name (a_text_formatter)
			if attached aliases as lst then
				across
					lst as ic
				loop
					a_text_formatter.add_space
					a_text_formatter.process_keyword_text (Ti_alias_keyword, Void)
					a_text_formatter.add_space
					a_text_formatter.process_symbol_text (Ti_double_quote)
					a_text_formatter.process_operator_text (extract_alias_name_32 (ic.item.alias_name_32), Current)
					a_text_formatter.process_symbol_text (Ti_double_quote)
				end
			end
			if has_convert_mark then
				a_text_formatter.add_space
				a_text_formatter.process_keyword_text (Ti_convert_keyword, Void)
			end
		end

feature -- Output: signature

	feature_signature_32: STRING_32
			-- Signature of Current feature.
		do
			if attached feature_signature as l_s then
				Result := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (l_s)
			end
		end

	append_arguments_to (s: STRING)
			-- Append arguments to `s'.
		require
			s_not_void: s /= Void
		do
			if attached arguments as args then
				s.append (" (")
				across
					args as a
				loop
					s.append (args.argument_names [a.target_index])
					s.append (": ")
					s.append (a.item.dump)
					if not a.is_last then
						s.append ("; ")
					end
				end
				s.append (")")
			end
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Output: signature

	feature_signature: STRING
			-- Signature of Current feature
		do
			create Result.make (50)
			Result.append (name)
			append_arguments_to (Result)
		end

feature -- Implementation

	real_body_id: INTEGER
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
				Result := f.real_body_index (f.written_class.types.first)
			end
		end

	associated_feature_i: FEATURE_I
			-- Assocated feature_i
		do
			if is_invariant then
				Result := associated_class.invariant_feature
			else
				Result := associated_class.feature_named (name)
			end
		end;

	body_id_for_ast: INTEGER
			-- Body id that should be used for retrieving the ast (by feature ast)
		do
			Result := body_index
		end

feature {E_FEATURE} -- Implementation

	associated_class_id: INTEGER
            -- Class id where the feature was evaluated in

feature {FEATURE_I} -- Setting

	set_written_in (i: INTEGER)
			-- Set `written_in' to `i'.
		do
			written_in := i;
		end;

	set_associated_class_id (i: INTEGER)
			-- Set `associated_class_id' to `i'.
		do
			associated_class_id := i
		end;

	set_body_index (i: INTEGER)
			-- Assign `i' to `body_index'.
		do
			body_index := i;
		end;

	set_class (value: BOOLEAN)
			-- Set `is_class` to `value`.
		do
			is_class := value
		ensure
			is_class_set: is_class = value
		end

	set_ghost (value: BOOLEAN)
			-- Set `is_ghost` to `value`.
		do
			is_ghost := value
		ensure
			is_ghost_set: is_ghost = value
		end

	set_is_origin (b: BOOLEAN)
			-- Assign `b' to `is_origin'.
		do
			is_origin := b;
		end;

	set_export_status (e: EXPORT_I)
			-- Assign `e' to `export_status'.
		do
			export_status := e;
		end;

	set_is_frozen (b: BOOLEAN)
			-- Assign `b' to `is_frozen'.
		do
			is_frozen := b;
		end;

	set_is_infix (b: BOOLEAN)
			-- Assign `b' to `is_infix'.
		do
			is_infix := b;
		end;

	set_is_prefix (b: BOOLEAN)
			-- Assign `b' to `is_prefix'.
		do
			is_prefix := b;
		end;

	set_rout_id_set (set: like rout_id_set)
			-- Assign `set' to `rout_id_set'.
		do
			rout_id_set := set;
		end;

	set_is_il_external (v: like is_il_external)
			-- Set `is_il_external' to `v'.
		do
			is_il_external := v
		ensure
			is_il_external_set: is_il_external = v
		end

	set_written_feature_id (v: like written_feature_id)
			-- Set `written_feature_id' with `v'.
		require
			v_non_negative: v >= 0
		do
			written_feature_id := v
		ensure
			written_feature_id_set: written_feature_id = v
		end

	set_obsolete_message (s: STRING)
			-- Assign `s' to `obsolete_message'
		do
			obsolete_message := s;
		end

invariant
	associated_class_not_void: is_valid implies associated_class /= Void
	written_class_not_void: is_valid implies written_class /= Void

note
	ca_ignore: "CA033", "CA033: very large class"
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
