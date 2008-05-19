indexing
	description: "Instance of an Eiffel feature: for every inherited feature there is%N%
		%an instance of FEATURE_I with its final name, the class name where it%N%
		%is written, the body id of its content and the routine table ids to%N%
		%which the feature is attached.%N%
		%Attribute `type' is the real type of the feature in the class where it%N%
		%is inherited (or written), that means there is no more anchored type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	version: "$Revision$"

deferred class FEATURE_I

inherit
	IDABLE

	SHARED_WORKBENCH

	SHARED_SERVER
		export
			{ANY} all
		end

	SHARED_INSTANTIATOR

	SHARED_ERROR_HANDLER

	SHARED_TYPES

	SHARED_EVALUATOR

	SHARED_TABLE

	SHARED_AST_CONTEXT

	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		end

	SHARED_PATTERN_TABLE

	SHARED_INST_CONTEXT

	SHARED_ID_TABLES
		export
			{ANY} Body_index_table, Original_body_index_table
		end

	SHARED_ARRAY_BYTE

	SHARED_EXEC_TABLE

	HASHABLE
		rename
			hash_code as feature_name_id
		end

	COMPILER_EXPORTER

	SHARED_NAMES_HEAP

	DEBUG_OUTPUT

	COMPARABLE
		undefine
			is_equal
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

	SHARED_IL_CASING
		export
			{NONE} all
		end

	SHARED_INLINE_AGENT_LOOKUP

feature -- Access

	feature_name: STRING is
			-- Final name of feature.
		require
			feature_name_id_set: feature_name_id > 0
		do
			Result := Names_heap.item (feature_name_id)
		ensure
			feature_name_not_void: Result /= Void
			feature_name_not_empty: not Result.is_empty
		end

	alias_name: STRING is
			-- Alias name of feature (if any).
		do
			if alias_name_id > 0 then
				Result := Names_heap.item (alias_name_id)
			end
		end

	assigner_name: STRING is
			-- Associated assigner name (if any).
		do
			if assigner_name_id /= 0 then
				Result := names_heap.item (assigner_name_id)
			end
		end

	feature_name_id: INTEGER
			-- Id of `feature_name' in `Names_heap' table.

	alias_name_id: INTEGER
			-- Id of `alias_name' in `Names_heap' table

	assigner_name_id: INTEGER is
			-- Id of `assigner_name' in `Names_heap' table
		do
				-- 0 (no assigner) by default
		ensure
			valid_result: Result /= 0 implies names_heap.valid_index (Result)
		end

	feature_id: INTEGER
			-- Feature id: first key in feature call hash table
			-- of a class: two features of different names have two
			-- different feature ids.

	written_in: INTEGER
			-- Class id where feature is written

	body_index: INTEGER
			-- Index of body id

	pattern_id: INTEGER
			-- Id of feature pattern

	rout_id_set: ROUT_ID_SET
			-- Routine table to which feature belongs to.

	export_status: EXPORT_I is
			-- Export status of feature
		do
			Result := internal_export_status
			if Result = Void then
				if (feature_flags & is_export_status_none_mask) = is_export_status_none_mask then
					Result := export_none_status
				else
					Result := export_all_status
				end
			end
		ensure
			export_status_not_void: export_status /= Void
		end

	origin_feature_id: INTEGER
			-- Feature ID of Current in associated CLASS_INTERFACE
			-- that defines it.
			-- Used for MSIL code generation only.

	origin_class_id: INTEGER
			-- Class ID of class defining Current in associated CLASS_INTERFACE
			-- that defines it.
			-- Used for MSIL code generation only.

	written_feature_id: INTEGER
			-- Feature ID of Current in associated CLASS_C of ID `written_in'
			-- that gives a body.
			-- Used for MSIL code generation only.

	frozen is_origin: BOOLEAN is
			-- Is feature an origin?
		do
			Result := feature_flags & is_origin_mask = is_origin_mask
		end

	frozen has_replicated_ast: BOOLEAN is
			-- Does feature have a replicated AST?
		do
			Result := feature_flags & has_replicated_ast_mask = has_replicated_ast_mask
		end

	frozen is_frozen: BOOLEAN is
			-- Is feature frozen?
		do
			Result := feature_flags & is_frozen_mask = is_frozen_mask
		end

	frozen is_empty: BOOLEAN is
			-- Is feature with an empty body?
		do
			Result := feature_flags & is_empty_mask = is_empty_mask
		end

	frozen is_infix: BOOLEAN is
			-- Is feature an infixed one ?
		do
			Result := feature_flags & is_infix_mask = is_infix_mask
		end

	frozen is_prefix: BOOLEAN is
			-- Is feature a prefixed one ?
		do
			Result := feature_flags & is_prefix_mask = is_prefix_mask
		end

	frozen is_bracket: BOOLEAN is
			-- Is feature a bracket one ?
		do
			Result := feature_flags & is_bracket_mask = is_bracket_mask
		end

	frozen is_binary: BOOLEAN is
			-- Is feature a binary one?
		do
			Result := feature_flags & is_binary_mask = is_binary_mask
		end

	frozen is_unary: BOOLEAN is
			-- Is feature an unary one?
		do
			Result := feature_flags & is_unary_mask = is_unary_mask
		end

	frozen has_convert_mark: BOOLEAN is
			-- Does binary feature have a convert mark?
		do
			Result := feature_flags & has_convert_mark_mask = has_convert_mark_mask
		end

	has_formal: BOOLEAN is
			-- Is formal type present in the feature signature at the top level?
			-- (Formals used as parameters of generic class types do not count.)
		local
			a: like arguments
			i, l_count: INTEGER
		do
				-- It is pretty important that we use `actual_type.is_formal' and not
				-- just `is_formal' because otherwise if you have `like x' and `x: G'
				-- then we would fail to detect that.
			if type.actual_type.is_formal then
				Result := True
			else
				a := arguments
				if a /= Void then
					from
						i := 1
						l_count := a.count
					until
						i > l_count
					loop
						if a [i].actual_type.is_formal then
							Result := True
							i := l_count
						end
						i := i + 1
					end
				end
			end
		end

	generic_fingerprint: STRING is
			-- Fingerprint of the feature signature that distinguishes
			-- between formal generic and non-formal-generic types.
		local
			digit: NATURAL_8
			a: like arguments
			i: NATURAL_8
			z: INTEGER
		do
			create Result.make_empty
				-- It is pretty important that we use `actual_type.is_formal' and not
				-- just `is_formal' because otherwise if you have `like x' and `x: G'
				-- then we would fail to detect that.
			if type.actual_type.is_formal then
				digit := 1
			end
			a := arguments
			if a /= Void then
				from
					i := 2
					a.start
				until
					a.after
				loop
					if a.item.actual_type.is_formal then
						digit := digit + i
					end
					i := i |<< 1
					if i >= 16 then
							-- Add a digit to the result.
						Result.append_character (digit.to_hex_character)
						if digit = 0 then
							z := z + 1
						else
							z := 0
						end
						digit := 0
						i := 1
					end
					a.forth
				end
			end
			if digit /= 0 then
				Result.append_character (digit.to_hex_character)
			elseif z > 0 then
					-- Remove trailing zeroes.
				Result.remove_tail (z)
			end
		end

	extension: EXTERNAL_EXT_I is
			-- Encapsulation of the external extension
		do
		end

	external_name: STRING is
			-- External name
		require
			external_name_id_set: external_name_id > 0
		do
			Result := Names_heap.item (external_name_id)
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end;

	external_name_id: INTEGER is
			-- External name of feature if any generation.
		do
			Result := private_external_name_id
			if Result = 0 then
				Result := feature_name_id
			end
		end

	is_inline_agent: BOOLEAN is
			-- is the feature an inline agent
		do
			Result := inline_agent_nr /= 0
		end

	enclosing_body_id: INTEGER
			-- The body id of the enclosing feature of an inline agent

	enclosing_feature: FEATURE_I is
			-- Gives the (real) feature in which this features is defined.
			-- If the feature has no enclosing feature, a reference to itself is returned.
		local
			l_written_class: CLASS_C
		do
			if is_inline_agent then
				l_written_class := written_class;
				Result := l_written_class.feature_of_body_index (enclosing_body_id)
				if Result = Void then
					Result := l_written_class.invariant_feature
				end
			else
				Result := Current
			end
		ensure
			Result /= Void and not Result.is_inline_agent
		end

	inline_agent_nr: INTEGER
		-- the number of this inline agent in the enclosing feature

	supports_step_in: BOOLEAN
		-- Is it possible to step into this feature or set breakpoints in it?
		do
			Result := not (enclosing_feature.is_invariant or else is_fake_inline_agent)
		end

feature -- Comparison

	infix "<" (other: FEATURE_I): BOOLEAN is
			-- Comparison of FEATURE_I based on their name.
		local
			l_name, l_other_name: like feature_name
		do
			l_name := feature_name
			l_other_name := other.feature_name
			if l_name = Void then
				Result := other.feature_name /= Void
			else
				Result := l_other_name /= Void and l_name < l_other_name
			end
		end

	is_same_alias (other: FEATURE_I): BOOLEAN is
			-- Does current have the same alias as `other'?
		require
			other_not_void: other /= Void
		do
			Result :=
				alias_name_id = other.alias_name_id and then
				has_convert_mark = other.has_convert_mark
		end

	is_same_assigner (other: FEATURE_I; tbl: FEATURE_TABLE): BOOLEAN is
			-- Does current have the same assigner command (if any) as `other'?
		require
			other_not_void: other /= Void
			tbl_not_void: tbl /= Void
		local
			assigner_command: FEATURE_I
			other_assigner_command: FEATURE_I
		do
				-- If either of the feature has no assigner command, we treat them as having
				-- the same assigner command
			if assigner_name_id = 0 or else other.assigner_name_id = 0 then
				Result := True
			else
				if written_in = system.current_class.class_id then
					assigner_command :=  tbl.item_id (assigner_name_id)
				else
					assigner_command := written_class.feature_named (assigner_name)
				end
				if assigner_command = Void then
						-- Assigner command is not found
					error_handler.insert_error (create {VFAC1}.make (system.current_class, Current))
				else
					assigner_command := tbl.feature_of_rout_id (assigner_command.rout_id_set.first)
					if other.written_in = system.current_class.class_id then
						other_assigner_command := tbl.item_id (other.assigner_name_id)
					else
						other_assigner_command := other.written_class.feature_named (other.assigner_name)
					end
					check
						other_assigner_command_not_void: other_assigner_command /= Void
					end
					other_assigner_command := tbl.feature_of_rout_id (other_assigner_command.rout_id_set.first)
					Result := assigner_command = other_assigner_command
				end
			end
		end

feature -- Debugger access

	number_of_breakpoint_slots: INTEGER is
			-- Number of breakpoint slots in feature (:::)
			-- It includes pre/postcondition (inner & herited)
			-- and rescue clause.
			--
			--|---------------------------------------------------------
			--| Note from Arnaud PICHERY [ aranud@mail.dotcom.fr ]     |
			--|---------------------------------------------------------
			--| If the feature inherits from one routine that has no   |
			--| precondition, the precondition for this routine will   |
			--| always be true and thus will not be generated by the   |
			--| compiler. So, we do not count the preconditions if one |
			--| of the inherited routines has an empty precondition    |
			--| clause.                                                |
			--|---------------------------------------------------------
		local
			l_body: like real_body
			l_routine: ROUTINE_AS
		do
			l_body := real_body

			if l_body /= Void then
				l_routine ?= l_body.content
				Result := l_routine.number_of_breakpoint_slots
			end
			Result := Result.max (1)
		end

	first_breakpoint_slot_index: INTEGER is
			-- Index of the first breakpoint-slot of the body
			-- Take into account inherited and inner assertions
		local
			l_body: like real_body
			l_routine: ROUTINE_AS
			l_internal: INTERNAL_AS
		do
			l_body := real_body
			if l_body /= Void then
				l_routine ?= l_body.content
				if l_routine /= Void then
					l_internal ?= l_routine.routine_body
					if l_internal /= Void then
						if l_internal.is_empty then
								--| in this case, the first bp of the body
								--| is the last breakable point
							Result := number_of_breakpoint_slots
						else
							Result := l_internal.first_breakpoint_slot_index
						end
					end
				end
			end
			Result := Result.max (1)
		end

feature -- Status

	to_melt_in (a_class: CLASS_C): BOOLEAN is
			-- Has current feature to be melted in class `a_class' ?
		require
			good_argument: a_class /= Void
		do
			Result := a_class.class_id = written_in or else (has_replicated_ast and then a_class.class_id = access_in)
		end

	to_generate_in (a_class: CLASS_C): BOOLEAN is
			-- Has current feature to be generated in class `a_class' ?
		require
			good_argument: a_class /= Void
		do
			Result := a_class.class_id = written_in or else (has_replicated_ast and then a_class.class_id = access_in)
		end

	frozen to_implement_in (a_class: CLASS_C): BOOLEAN is
			-- Does Current feature need to be exposed in interface
			-- used for IL generation?
		require
			a_class_not_void: a_class /= Void
		do
			Result := a_class.class_id = written_in
		end

feature -- Setting

	set_feature_id (i: INTEGER) is
			-- Assign `i' to `feature_id'
		do
			feature_id := i
		end

	set_body_index (i: INTEGER) is
			-- Assign `i' to `body_index'.
		do
			body_index := i
		end

	set_pattern_id (i: INTEGER) is
			-- Assign `i' to `pattern_id'.
		do
			pattern_id := i
		end

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
			-- `set_renamed_name' is needed for C external
			-- routines that can't be renamed.
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		local
			l_names_heap: like Names_heap
		do
			l_names_heap := Names_heap
			l_names_heap.put (s)
			feature_name_id := l_names_heap.found_item
		ensure
			feature_name_set: equal (feature_name, s)
		end

	set_feature_name_id (a_id: INTEGER; alias_id: INTEGER) is
			-- Assign `a_id' to `feature_name_id'.
		require
			valid_id: Names_heap.valid_index (a_id)
			valid_alias_id: Names_heap.valid_index (alias_id)
		do
			feature_name_id := a_id
			alias_name_id := alias_id
		ensure
			feature_name_id_set: feature_name_id = a_id
			alias_name_id_set: alias_name_id = alias_id
		end

	set_renamed_name_id (a_id: INTEGER; alias_id: INTEGER) is
			-- Assign `a_id' to `feature_name_id'.
		require
			valid_id: Names_heap.valid_index (a_id)
			valid_alias_id: Names_heap.valid_index (alias_id)
		do
			feature_name_id := a_id
			alias_name_id := alias_id
		ensure
			feature_name_id_set: feature_name_id = a_id
			alias_name_id_set: alias_name_id = alias_id
		end

	set_written_in (a_class_id: like written_in) is
			-- Assign `a_class_id' to `written_in'.
		require
			a_class_id_not_void: a_class_id > 0
		do
			written_in := a_class_id
		ensure
			written_in_set: written_in = a_class_id
		end

	set_written_feature_id (a_feature_id: like written_feature_id) is
			-- Assign `a_feature_id' to `written_feature_id'.
		require
			valid_feature_id: a_feature_id >= 0
		do
			written_feature_id := a_feature_id
		ensure
			written_feature_id_set: written_feature_id = a_feature_id
		end

	set_origin_feature_id (a_feature_id: like origin_feature_id) is
			-- Assign `a_feature_id' to `origin_feature_id'.
		require
			valid_feature_id: a_feature_id >= 0
		do
			origin_feature_id := a_feature_id
		ensure
			origin_feature_id_set: origin_feature_id = a_feature_id
		end

	set_origin_class_id (a_class_id: like origin_class_id) is
			-- Assign `a_class_id' to `origin_class_id'.
		require
			valid_feature_id: a_class_id >= 0
		do
			origin_class_id := a_class_id
		ensure
			origin_class_id_set: origin_class_id = a_class_id
		end

	set_export_status (e: EXPORT_I) is
			-- Assign `e' to `export_status'.
		require
			e_not_void: e /= Void
		do
			if e.is_all or e.is_none then
				internal_export_status := Void
				feature_flags := feature_flags.set_bit_with_mask (e.is_none, is_export_status_none_mask)
			else
				internal_export_status := e
			end
		ensure
			export_status_set: export_status.same_as (e)
		end

	frozen set_is_origin (b: BOOLEAN) is
			-- Assign `b' to `is_origin'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_origin_mask)
		ensure
			is_origin_set: is_origin = b
		end

	frozen set_has_replicated_ast (b: BOOLEAN) is
			-- Assign `b' to `has_replicated_ast'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, has_replicated_ast_mask)
		ensure
			is_origin_set: has_replicated_ast = b
		end

	frozen set_is_empty (b : BOOLEAN) is
			-- Set `is_empty' to `b'
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_empty_mask)
		ensure
			is_empty_set: is_empty = b
		end

	frozen set_is_frozen (b: BOOLEAN) is
			-- Assign `b' to `is_frozen'.
			--|Note: nothing to do with melted/frozen features
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_frozen_mask)
		ensure
			is_frozen_set: is_frozen = b
		end

	frozen set_is_infix (b: BOOLEAN) is
			-- Assign `b' to `is_infix'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_infix_mask)
		ensure
			is_infix_set: is_infix = b
		end

	frozen set_is_prefix (b: BOOLEAN) is
			-- Assign `b' to `is_prefix'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_prefix_mask)
		ensure
			is_prefix_set: is_prefix = b
		end

	frozen set_is_bracket (b: BOOLEAN) is
			-- Assign `b' to `is_bracket'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_bracket_mask)
		ensure
			is_bracket_set: is_bracket = b
		end

	frozen set_is_binary (b: BOOLEAN) is
			-- Assign `b' to `is_binary'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_binary_mask)
		ensure
			is_binary_set: is_binary = b
		end

	frozen set_is_unary (b: BOOLEAN) is
			-- Assign `b' to `is_unary'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_unary_mask)
		ensure
			is_unary_set: is_unary = b
		end

	frozen set_has_convert_mark (b: BOOLEAN) is
			-- Assign `b' to `has_convert_mark'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, has_convert_mark_mask)
		ensure
			has_convert_mark_set: has_convert_mark = b
		end

	frozen set_is_require_else (b: BOOLEAN) is
			-- Assign `b' to `is_require_else'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_require_else_mask)
		ensure
			is_require_else_set: is_require_else = b
		end

	frozen set_is_ensure_then (b: BOOLEAN) is
			-- Assign `b' to `is_ensure_then'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_ensure_then_mask)
		ensure
			is_ensure_then_set: is_ensure_then = b
		end

	frozen set_is_fake_inline_agent (b: BOOLEAN) is
			-- Assign `b' to `is_fake_inline_agent'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_fake_inline_agent_mask)
		ensure
			is_fake_inline_agent_set: is_fake_inline_agent = b
		end

	frozen set_has_rescue_clause (b: BOOLEAN) is
			-- Assign `b' to `has_rescue_clause'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, has_rescue_clause_mask)
		ensure
			has_rescue_clause_set: has_rescue_clause = b
		end

	set_has_property (v: BOOLEAN) is
			-- Set `has_property' to `v'.
		do
			feature_flags := feature_flags.set_bit_with_mask (v, has_property_mask)
		ensure
			has_property_set: has_property = v
		end

	set_has_property_getter (v: BOOLEAN) is
			-- Set `has_property_getter' to `v'.
		do
			feature_flags := feature_flags.set_bit_with_mask (v, has_property_getter_mask)
		ensure
			has_property_getter_set: has_property_getter = v
		end

	set_has_property_setter (v: BOOLEAN) is
			-- Set `has_property_setter' to `v'.
		do
			feature_flags := feature_flags.set_bit_with_mask (v, has_property_setter_mask)
		ensure
			has_property_setter_set: has_property_setter = v
		end

	set_rout_id_set (an_id_set: like rout_id_set) is
			-- Assign `an_id_set' to `rout_id_set'.
		require
			an_id_set_not_void: an_id_set /= Void
		do
			rout_id_set := an_id_set
		ensure
			rout_id_set: rout_id_set = an_id_set
		end

	set_private_external_name_id (n_id: like private_external_name_id) is
			-- Assign `n_id' to `private_external_name_id'.
		require
			valid_n: n_id > 0
		do
			private_external_name_id := n_id
		ensure
			private_external_name_set: private_external_name_id = n_id
		end

	generation_class_id: INTEGER is
			-- Id of class where feature has to be generated in
		do
			Result := written_in
		end

	duplicate: like Current is
			-- Clone
		do
			Result := twin
		end

	duplicate_arguments is
			-- Do a clone of arguments (for replication)
		do
			-- Do nothing
		end

	set_inline_agent (a_enclosing_body_id, a_inline_agent_nr: INTEGER) is
			-- Define this feature as an inline agent
		require
			enclosing_body_id_valid: a_enclosing_body_id > 0
			inline_agent_nr_valid: (is_fake_inline_agent implies a_inline_agent_nr = -1) and
									not is_fake_inline_agent implies a_inline_agent_nr > 0
		do
			inline_agent_nr := a_inline_agent_nr
			enclosing_body_id := a_enclosing_body_id
		end

feature -- Incrementality

	equiv (other: FEATURE_I): BOOLEAN is
			-- Incrementality test on instance of FEATURE_I during
			-- second pass.
		require
			good_argument: other /= Void
		do
			Result := written_in = other.written_in
				and then rout_id_set.same_as (other.rout_id_set)
				and then is_origin = other.is_origin
				and then is_frozen = other.is_frozen
				and then is_deferred = other.is_deferred
				and then is_external = other.is_external
				and then export_status.same_as (other.export_status)
				and then same_signature (other)
				and then has_precondition = other.has_precondition
				and then has_postcondition = other.has_postcondition
				and then is_once = other.is_once
				and then is_process_relative = other.is_process_relative
				and then is_constant = other.is_constant
				and then alias_name_id = other.alias_name_id
				and then has_convert_mark = other.has_convert_mark
				and then assigner_name_id = other.assigner_name_id
				and then has_property = other.has_property
				and then (has_property implies property_name.is_equal (other.property_name))
				and then has_property_getter = other.has_property_getter
				and then has_property_setter = other.has_property_setter
debug ("ACTIVITY")
	if not Result then
			io.error.put_boolean (written_in = other.written_in) io.error.put_new_line;
			io.error.put_boolean (rout_id_set.same_as (other.rout_id_set)) io.error.put_new_line;
			io.error.put_boolean (is_origin = other.is_origin) io.error.put_new_line;
			io.error.put_boolean (is_frozen = other.is_frozen) io.error.put_new_line;
			io.error.put_boolean (is_deferred = other.is_deferred) io.error.put_new_line;
			io.error.put_boolean (is_external = other.is_external) io.error.put_new_line;
			io.error.put_boolean (export_status.same_as (other.export_status)) io.error.put_new_line;
			io.error.put_boolean (same_signature (other)) io.error.put_new_line;
			io.error.put_boolean (has_precondition = other.has_precondition) io.error.put_new_line;
			io.error.put_boolean (has_postcondition = other.has_postcondition) io.error.put_new_line;
			io.error.put_boolean (is_once = other.is_once) io.error.put_new_line;
	end
end
			if Result then
				if assert_id_set /= Void then
					Result := assert_id_set.same_as (other.assert_id_set)
				else
					Result := (other.assert_id_set = Void)
				end
			end

			if Result and then rout_id_set.first = System.default_rescue_rout_id then
				-- This is the default rescue feature.
				-- Test whether emptiness of body has changed.
				Result := (is_empty = other.is_empty)
			end

			if Result and then rout_id_set.first = System.default_create_rout_id then
				-- This is the default create feature.
				-- Test whether emptiness of body has changed.
				Result := (is_empty = other.is_empty)
			end

debug ("ACTIVITY")
	if not Result then
		io.error.put_string ("%T%T")
		io.error.put_string (feature_name)
		io.error.put_string (" is not equiv%N")
	end
end
		end

	select_table_equiv (other: FEATURE_I): BOOLEAN is
			-- Incrementality of select table
		require
			good_argument: other /= Void

		do
			Result := written_in = other.written_in
						and then rout_id_set.same_as (other.rout_id_set)
						and then is_origin = other.is_origin
						and then body_index = other.body_index
						and then type.is_safe_equivalent (other.type)
		end

	is_valid: BOOLEAN is
			-- Is feature still valid?
			-- Incrementality: The types of arguments and/or result
			-- are still defined in system
		do
			Result := type.is_valid
			if Result and then has_arguments then
				Result := arguments.is_valid
			end
		end

	same_class_type (other: FEATURE_I): BOOLEAN is
			-- Has `other' same resulting type than Current ?
		require
			good_argument: other /= Void
			same_names: other.feature_name_id = feature_name_id
		do
			Result := type.same_as (other.type)
		end

	same_interface (other: FEATURE_I): BOOLEAN is
			-- Has `other' same interface than Current ?
			-- [Semnatic for second pass is `old_feat.same_interface (new)']
		require
			good_argument: other /= Void
--			export_statuses_exist: not (export_status = Void
--										or else	other.export_status = Void)
		do
				-- Still an attribute
			Result := is_attribute = other.is_attribute

				-- Same alias
			if Result then
				Result := alias_name_id = other.alias_name_id
				if Result then
					Result := has_convert_mark = other.has_convert_mark
				end
			end

				-- Same assigner procedure
			if Result then
				Result := assigner_name_id = other.assigner_name_id
			end

				-- Same return type
			Result := Result and then type.same_as (other.type)
--						and then export_status.equiv (other.export_status)

				-- Same arguments if any
			if Result then
				if argument_count = 0 then
					Result := other.argument_count = 0
				else
					Result := argument_count = other.argument_count
							and then arguments.same_interface (other.arguments)
				end
			end

				-- Still a once
			Result := Result and then is_once = other.is_once
		end

feature -- creation of default rescue clause

	create_default_rescue (def_resc_name_id: INTEGER) is
			-- Create default_rescue clause if necessary
		require
			valid_feature_name_id : def_resc_name_id > 0
		local
			my_body : like body
		do
			if
				not (is_attribute or is_constant or
				is_external or is_deferred)
			then
				my_body := body
				if (my_body /= Void) then
					my_body.create_default_rescue (def_resc_name_id)
				end
			end
		end

feature -- Type id

	written_type (class_type: CLASS_TYPE): CLASS_TYPE is
			-- Written type of feature in context of
			-- type `class_type'.
		require
			good_argument: class_type /= Void
			conformance: class_type.associated_class.conform_to (written_class)
		do
			Result := written_class.meta_type (class_type)
		end

feature -- Conveniences

	assert_id_set: ASSERT_ID_SET is
			-- Assertions to which procedure belongs to
			-- (To be redefined in PROCEDURE_I).
		do
			-- Do nothing
		end

	is_obsolete: BOOLEAN is
			-- Is Current feature obsolete?
		do
			Result := obsolete_message /= Void
		end

	obsolete_message: STRING is
			-- Obsolete message
			-- (Void if Current is not obsolete)
		do
			-- Do nothing
		end

	has_arguments: BOOLEAN is
			-- Has current feature some formal arguments ?
		do
			Result := arguments /= Void
		end

	is_replicated: BOOLEAN is
			-- Is Current feature conceptually replicated?
		do
			-- Do nothing
		end

	is_routine: BOOLEAN is
			-- Is current feature a routine ?
		do
			-- Do nothing
		end

	is_function: BOOLEAN is
			-- Is current feature a function ?
		do
			-- Do nothing
		end

	is_type_feature: BOOLEAN is
			-- Is current an instance of TYPE_FEATURE_I?
		do
			-- Do nothing
		end

	is_attribute: BOOLEAN is
			-- Is current feature an attribute ?
		do
			-- Do nothing
		end

	is_constant: BOOLEAN is
			-- Is current feature a constant ?
		do
			-- Do nothing
		end

	is_once: BOOLEAN is
			-- Is current feature a once one ?
		do
			-- Do nothing
		end

	is_do: BOOLEAN is
			-- Is current feature a do one ?
		do
			-- Do nothing
		end

	is_deferred: BOOLEAN is
			-- Is current feature a deferred one ?
		do
			-- Do nothing
		end

	is_unique: BOOLEAN is
			-- Is current feature a unique constant ?
		do
			-- Do nothing
		end

	is_external: BOOLEAN is
			-- Is current feature an external one ?
		do
			-- Do nothing
		end

	has_return_value: BOOLEAN is
			-- Does current return a value?
		do
			Result := is_constant or is_attribute or is_function
		ensure
			validity: Result implies (is_constant or is_attribute or is_function)
		end

	frozen is_il_external: BOOLEAN is
			-- Is current feature a C external one?
		local
			ext: IL_EXTENSION_I
			l_const: CONSTANT_I
		do
			ext ?= extension
			Result := ext /= Void
			if not Result then
				l_const ?= Current
				if l_const /= Void then
					Result := l_const.written_class.is_external
				end
			end
		ensure
			not_is_c_external: Result implies not is_c_external
		end

	frozen is_c_external: BOOLEAN is
			-- Is current feature a C external one?
		local
			ext: EXTERNAL_EXT_I
		do
			ext := extension
			Result := ext /= Void and then not ext.is_il
		ensure
			not_is_il_external: Result implies not is_il_external
		end

	is_process_relative: BOOLEAN is
			-- Is feature process-wide (rather than thread-local)?
			-- (Usually applies to once routines.)
		do
			-- False by default
		end

	has_static_access: BOOLEAN is
			-- Can Current be access in a static manner?
		local
			l_ext: IL_EXTENSION_I
		do
			Result := is_constant
			if not Result then
				if System.il_generation then
					l_ext ?= extension
						 -- Static access only if it is a C external (l_ext = Void)
						 -- or if IL external does not need an object.
					Result :=
						(l_ext = Void and (is_external and not has_assertion)) or
						(l_ext /= Void and then not l_ext.need_current (l_ext.type))
				else
					Result := is_external and not has_assertion
				end
			end
		end

	frozen has_precondition: BOOLEAN is
			-- Is feature declaring some preconditions ?
		do
			Result := feature_flags & has_precondition_mask = has_precondition_mask
		end

	frozen has_postcondition: BOOLEAN is
			-- Is feature declaring some postconditions ?
		do
			Result := feature_flags & has_postcondition_mask = has_postcondition_mask
		end

	has_assertion: BOOLEAN is
			-- Is feature declaring some pre or post conditions ?
		do
			Result := has_postcondition or else has_precondition
		end

	frozen is_require_else: BOOLEAN is
			-- Is precondition block of feature a redefined one ?
		do
			Result := feature_flags & is_require_else_mask = is_require_else_mask
		end

	frozen is_ensure_then: BOOLEAN is
			-- Is postcondition block of feature a redefined one ?
		do
			Result := feature_flags & is_ensure_then_mask = is_ensure_then_mask
		end

	frozen is_fake_inline_agent: BOOLEAN is
			-- Is postcondition block of feature a redefined one ?
		do
			Result := feature_flags & is_fake_inline_agent_mask = is_fake_inline_agent_mask
		end

	frozen has_rescue_clause: BOOLEAN is
			-- Has rescue clause ?
		do
			Result := feature_flags & has_rescue_clause_mask = has_rescue_clause_mask
		end

	is_invariant: BOOLEAN is
			-- Is this feature the invariant feature of its eiffel class ?
		do
			Result := False
		end

	can_be_encapsulated: BOOLEAN is
			-- Is current feature a feature that can be encapsulated?
			-- Eg: attribute or constant.
		do
		end

	redefinable: BOOLEAN is
			-- Is feature redefinable ?
		do
			Result := not is_frozen
		end

	undefinable: BOOLEAN is
			-- Is feature undefinable ?
		do
			Result := redefinable
		end

	has_property: BOOLEAN is
			-- Does feature have an associated property?
		do
			Result := feature_flags & has_property_mask = has_property_mask
		end

	has_property_getter: BOOLEAN is
			-- Does feature have an associated property getter?
		do
			Result := feature_flags & has_property_getter_mask = has_property_getter_mask
		end

	has_property_setter: BOOLEAN is
			-- Does feature have an associated property setter?
		do
			Result := feature_flags & has_property_setter_mask = has_property_setter_mask
		end

	property_name: STRING is
			-- IL property name.
		do
			if byte_server.has (body_index) then
				Result := byte_server.item (body_index).property_name
			end
			if Result = Void or else Result.is_empty then
					-- Explicit property name is not specified
				Result := il_casing.pascal_casing (system.dotnet_naming_convention, feature_name, {IL_CASING_CONVERSION}.lower_case)
			end
		ensure
			result_attached: Result /= Void
		end

	type: TYPE_A is
			-- Result type of feature
		do
			Result := void_type
		ensure
			type_not_void: Result /= Void
		end

	set_type (t: like type; a: like assigner_name_id) is
			-- Assign `t' to `type' and `a' to `assigner_name_id'.
		require
			valid_a: a /= 0 implies names_heap.valid_index (a)
		do
			-- Do nothing
		end

	arguments: FEAT_ARG is
			-- Argument types
		do
			-- No arguments
		end

	set_assert_id_set (set: like assert_id_set) is
			-- Assign `set' to assert_id_set.
		do
			-- Do nothing	
		end

	argument_count: INTEGER is
			-- Number of arguments of feature
		do
			if arguments /= Void then
				Result := arguments.count
			end
		end

	written_class: CLASS_C is
			-- Class where feature is written in
		require
			good_written_in: written_in /= 0
		do
			Result := System.class_of_id (written_in)
		ensure
			written_class_not_void: Result /= Void
		end

	access_class: CLASS_C is
			-- Class where current feature can be accessed
			-- through its routine id.
			-- Useful for replication
		require
			access_in_positive: access_in > 0
		do
			Result := System.class_of_id (access_in)
		ensure
			written_class_not_void: Result /= Void
		end

feature -- Export checking

--	has_special_export: BOOLEAN is
--			-- The export status is special, i.e. feature
--			-- is not exported to all other classes.
--			-- A call to this feature must be recorded specially
--			-- in dependances for incrementality purpose:
--			-- If hierarchy changes, call may be invalid.
--		require
--			has_export_status: export_status /= Void
--		do
--			Result := not export_status.is_all
--		end

	is_exported_for (client: CLASS_C): BOOLEAN is
			-- Is current feature exported to class `client' ?
		require
			good_argument: client /= Void
			has_export_status: export_status /= Void
		do
			Result := export_status.valid_for (client)
		end

	record_suppliers (feat_depend: FEATURE_DEPENDANCE) is
			-- Record suppliers ids in `feat_depend'
		require
			good_arg: feat_depend /= Void
		local
			type_a: TYPE_A
		do
				-- Create the supplier set for the feature
			type_a := type
			if type_a /= Void then
				if type_a.has_associated_class then
					feat_depend.add_supplier (type_a.associated_class)
				end
				type_a.update_dependance (feat_depend)
			end
			if has_arguments then
				from
					arguments.start
				until
					arguments.after
				loop
					type_a := arguments.item
					if type_a.has_associated_class then
						feat_depend.add_supplier (type_a.associated_class)
					end
					arguments.forth
				end
			end
		end

	suppliers: TWO_WAY_SORTED_SET [INTEGER] is
			-- Class ids of all suppliers of feature
		require
			has_dependance: depend_server.has (written_in)
		local
			class_dependance: CLASS_DEPENDANCE
		do
			class_dependance := depend_server.item (written_in)
			check
				class_dependance_not_void: class_dependance /= Void
			end
			Result := class_dependance.item (body_index).suppliers
		end

feature -- Check

	real_body: BODY_AS is
			-- Body of feature
		local
			feat_as: FEATURE_AS
			l_enclosing_feature: FEATURE_I
		do
			if not is_inline_agent then
				feat_as := body
				if feat_as /= Void then
					Result := feat_as.body
				end
			else
				if not is_fake_inline_agent then
					l_enclosing_feature := enclosing_feature
					if l_enclosing_feature.is_invariant then
						Result := inline_agent_lookup.lookup_inline_agent_of_invariant (
							inv_ast_server.item (written_in), inline_agent_nr)
					else
						Result := inline_agent_lookup.lookup_inline_agent_of_feature (
							l_enclosing_feature.body, inline_agent_nr)
					end
				end
			end
		end

	body: FEATURE_AS is
			-- Body of feature
		local
			class_ast: CLASS_AS
			bid: INTEGER
		do
			bid := body_index
			if bid > 0 then
				Result := body_server.item (bid)
			end
			if Result = Void then
					-- Means a degree 4 error has occurred so the
					-- best we can do is to search through the
					-- class ast and find the feature as
				class_ast := Tmp_ast_server.item (written_in)
				if class_ast /= Void then
					Result := class_ast.feature_with_name (feature_name_id)
				end
			end
		end

-- Note: `require else' can be used even if feature has no
-- precursor. There is no problem to raise an error in normal case,
-- only case  where we cannot do anything is when aliases are used
-- and one name references a feature with a predecessor and not
-- other one

-- Used to be called from `type_check':
--
--	check_assertions is
--			-- Raise an error if "require else" or "ensure then" is used
--			-- but feature has no ancestor
--		do
--		end

	check_local_names (a_body: BODY_AS) is
			-- Check conflicts between local names and feature names
			-- for an unchanged feature
		do
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for current feature.
		local
			byte_code: BYTE_CODE
		do
			if not is_attribute and then not is_external then
				byte_code := Byte_server.item (body_index)
				byte_context.set_byte_code (byte_code)
				byte_context.set_current_feature (Current)
				byte_code.generate_il
				byte_context.clear_feature_data
			end
		end

	custom_attributes: BYTE_LIST [BYTE_NODE] is
			-- Custom attributes of Current if any.
		local
			byte_code: BYTE_CODE
		do
			if not is_attribute and then not is_external and then not is_il_external then
				if Byte_server.has (body_index) then
					byte_code := Byte_server.item (body_index)
					Result := byte_code.custom_attributes
				end
			end
		end

	class_custom_attributes: BYTE_LIST [BYTE_NODE] is
			-- Class custom attributes of Current if any.
		local
			byte_code: BYTE_CODE
		do
			if not is_attribute and then not is_external and then not is_il_external then
				if Byte_server.has (body_index) then
					byte_code := Byte_server.item (body_index)
					Result := byte_code.class_custom_attributes
				end
			end
		end

	interface_custom_attributes: BYTE_LIST [BYTE_NODE] is
			-- Interface custom attributes of Current if any.
		local
			byte_code: BYTE_CODE
		do
			if not is_attribute and then not is_external and then not is_il_external then
				if Byte_server.has (body_index) then
					byte_code := Byte_server.item (body_index)
					Result := byte_code.interface_custom_attributes
				end
			end
		end

	property_custom_attributes: BYTE_LIST [BYTE_NODE] is
			-- Custom attributes of Current if any.
		do
			if Byte_server.has (body_index) then
				Result := Byte_server.item (body_index).property_custom_attributes
			end
		end

feature -- Byte code computation

	melt (exec: EXECUTION_UNIT) is
			-- Generate byte code for current feature
			-- [To be redefined in CONSTANT_I, ATTRIBUTE_I and in EXTERNAL_I].
		require
			good_argument: exec /= Void
		local
			byte_code: BYTE_CODE
			melted_feature: MELT_FEATURE
		do
			byte_code := Byte_server.item (body_index)

			byte_context.set_byte_code (byte_code)
			byte_context.set_current_feature (Current)

			Byte_array.clear
			byte_code.set_real_body_id (exec.real_body_id)
			byte_code.make_byte_code (Byte_array)
			byte_context.clear_feature_data

			melted_feature := Byte_array.melted_feature
			melted_feature.set_real_body_id (exec.real_body_id)

			if not System.freeze then
				Tmp_m_feature_server.put (melted_feature)
			end

			Execution_table.mark_melted (exec)
		end

feature -- Polymorphism

 	has_entry: BOOLEAN is
 			-- Has feature an associated polymorphic unit ?
 		do
 			Result := True
 		end

	new_poly_table (rout_id: INTEGER): POLY_TABLE [ENTRY] is
 			-- New polymorphic table
 		require
			positive_rout_id: rout_id > 0
			valid_rout_id: rout_id_set.has (rout_id)
 		do
 			if not is_attribute or else not Routine_id_counter.is_attribute (rout_id) then
 					-- This is a routine.
 					-- The seed is a routine as well.
 				create {ROUT_TABLE} Result.make (rout_id)
 			elseif system.seed_of_routine_id (rout_id).has_formal then
 					-- This is an attribute with a seed of a formal generic type.
 				create {GENERIC_ATTRIBUTE_TABLE} Result.make (rout_id)
 			else
 					-- This is an attribute with a seed that is not of a formal generic type.
 				create {ATTR_TABLE [ATTR_ENTRY]} Result.make (rout_id)
 			end
 		end

 	new_entry (rout_id: INTEGER): ENTRY is
 			-- New polymorphic unit
 		require
			rout_id_not_void: rout_id /= 0
		local
			r: like new_rout_entry
 		do
 			if is_attribute and then Routine_id_counter.is_attribute (rout_id) then
 				if has_formal or else byte_context.workbench_mode then
	 				r := new_rout_entry
	 				r.set_is_attribute
	 				Result := r
 				else
	 				Result := new_attr_entry
 				end
 			else
 				Result := new_rout_entry
 			end
 		end

 	new_rout_entry: ROUT_ENTRY is
 			-- New routine unit
 		do
 			create Result
 			Result.set_body_index (body_index)
 			Result.set_type_a (type.actual_type)

 			if has_replicated_ast then
 					-- If AST has been replicated, then we must use `access_in'
 					-- as this is the new written in value.
 				Result.set_access_in (access_in)
 				Result.set_written_in (written_in)
 			else
 				Result.set_written_in (written_in)
 				Result.set_access_in (written_in)
 			end

 			Result.set_pattern_id (pattern_id)
			Result.set_feature_id (feature_id)
			Result.set_is_deferred (is_deferred)
 		end

 	new_attr_entry: ATTR_ENTRY is
 			-- New attribute unit
 		require
 			is_attribute: is_attribute
 		do
 			create Result
 			Result.set_type_a (type.actual_type)
 			Result.set_feature_id (feature_id)
 		end

 	poly_equiv (other: FEATURE_I): BOOLEAN is
 			-- Is `other' equivalent to Current from polymorphic table
			-- implementation point of view ?
 		require
 			good_argument: other /= Void
 		local
 			is_attr: BOOLEAN
 		do
 			is_attr := is_attribute
 			Result := 	other.is_attribute = is_attr
 						and then
 						type.actual_type.same_as (other.type.actual_type)
 			if Result then
 				if is_attr then
 					Result := 	feature_id = other.feature_id
				else
	 				Result :=   written_in = other.written_in
 								and then body_index = other.body_index
 								and then pattern_id = other.pattern_id
 				end
 			end
 		end

feature -- Signature instantiation

	instantiate (parent_type: TYPE_A) is
			-- Instantiated signature in context of `parent_type'.
		require
			good_argument: parent_type /= Void
			is_solved: type.is_solved
		local
			i, nb: INTEGER
			old_type: TYPE_A
			l_arguments: like arguments
		do
				-- Instantiation of the type
			old_type := type
			set_type (old_type.instantiated_in (parent_type), assigner_name_id)
				-- Instantiation of the arguments
			from
				i := 1
				l_arguments := arguments
				if l_arguments /= Void then
					nb := l_arguments.count
				end
			until
				i > nb
			loop
				old_type := l_arguments.i_th (i)
				l_arguments.put_i_th (old_type.instantiated_in (parent_type), i)
				i := i + 1
			end
		end

	instantiation_in (descendant_type: TYPE_A) is
			-- Instantiated signature in context of `descendant_type'.
		require
			good_argument: descendant_type /= Void
			is_solved: type.is_solved
		local
			i, nb: INTEGER
			old_type: TYPE_A
			l_arguments: like arguments
			l_written_in: like written_in
		do
			l_written_in := written_in
				-- Instantiation of the type
			old_type := type
			set_type (old_type.instantiation_in (descendant_type, l_written_in), assigner_name_id)
				-- Instantiation of the arguments
			from
				i := 1
				l_arguments := arguments
				if l_arguments /= Void then
					nb := l_arguments.count
				end
			until
				i > nb
			loop
				old_type := l_arguments.i_th (i)
				l_arguments.put_i_th (old_type.instantiation_in (descendant_type, l_written_in), i)
				i := i + 1
			end
		end

feature -- Signature checking

	check_argument_names (feat_table: FEATURE_TABLE) is
			-- Check argument names
		require
			argument_names_exists: arguments.argument_names /= Void
			written_in_class: written_in = feat_table.feat_tbl_id
				-- The feature must be written in the associated class
				-- of `feat_table'.
		local
			args: like arguments
			arg_id: INTEGER
			vreg: VREG
			vrfa: VRFA
			vpir: VPIR1
			i, nb: INTEGER
		do
			from
				args := arguments
				i := 1
				nb := args.count
			until
				i > nb
			loop
				arg_id := args.item_id (i)
					-- Searching to find after the current item another one
					-- with the same name.
					-- We do `i + 1' for the start index because we need to go
					-- one step further (+ 1)
				if args.argument_position_id (arg_id, i + 1) /= 0 then
						-- Two arguments with the same name
					create vreg
					vreg.set_class (written_class)
					vreg.set_feature (Current)
					vreg.set_entity_name (Names_heap.item (arg_id))
					Error_handler.insert_error (vreg)
				end
				feat_table.search_id (arg_id)
				if feat_table.found then
						-- An argument name is a feature name of the feature
						-- table.
					create vrfa
					vrfa.set_class (written_class)
					vrfa.set_feature (Current)
					vrfa.set_other_feature (feat_table.found_item)
					Error_handler.insert_error (vrfa)
				end
				if context.is_name_used (arg_id) then
						-- An argument name is an argument name of an enclosing feature
					create vpir
					vpir.set_entity_name (arg_id)
					vpir.set_class (written_class)
					vpir.set_feature (Current)
					Error_handler.insert_error (vpir)
				end

				i := i + 1
			end
		end

	check_types (feat_table: FEATURE_TABLE) is
			-- Check type and arguments types. The objective is
			-- to deal with anchored types and genericity. All anchored
			-- types are interpreted here and generic parameter
			-- instantiated if possible.
		local
			solved_type: TYPE_A
			vffd5: VFFD5
			vffd6: VFFD6
			vffd7: VFFD7
			l_class: CLASS_C
		do
			l_class := feat_table.associated_class
			context.initialize (l_class, l_class.actual_type, feat_table)
			context.set_current_feature (Current)
				-- Not that the checks is only done for real `onces'. Constants
				-- have their checks done through VQMC.
			if type.has_like and then (is_once and not is_constant) then
					-- We have an anchored type.
					-- Check if the feature is not a once feature
				create vffd7
				vffd7.set_class (written_class)
				vffd7.set_feature_name (feature_name)
				Error_handler.insert_error (vffd7)
			end
				-- Process an actual type for the feature interpret
				-- anchored types.
			type_a_checker.init_with_feature_table (Current, feat_table, Void, error_handler)
			solved_type := type_a_checker.check_and_solved (type, Void)

			if solved_type /= Void then
				set_type (solved_type, assigner_name_id)
					-- Instantitate the feature type in the context of the
					-- actual type of the class associated to `feat_table'.

				if (is_once and not is_constant) and then solved_type.has_formal_generic then
						-- A once funtion cannot have a type with formal generics
					create vffd7
					vffd7.set_class (written_class)
					vffd7.set_feature_name (feature_name)
					Error_handler.insert_error (vffd7)
				end

				if
					is_infix and then
					((argument_count /= 1) or else (type.is_void))
				then
						-- Infixed features should have only one argument
						-- and must have a return type.
					create vffd6
					vffd6.set_class (written_class)
					vffd6.set_feature_name (feature_name)
					Error_handler.insert_error (vffd6)
				end
				if
					is_prefix and then
					((argument_count /= 0) or else (type.is_void))
				then
						-- Prefixed features shouldn't have any argument
						-- and must have a return type.
					create vffd5
					vffd5.set_class (written_class)
					vffd5.set_feature_name (feature_name)
					Error_handler.insert_error (vffd5)
				end

				if arguments /= Void then
						-- Check types of arguments
					arguments.check_types (feat_table, Current)
				end
			end
		end

	check_type_validity (a_context_class: CLASS_C) is
			-- Check type validity.
		require
			context_class_not_void: a_context_class /= Void
			context_initialized: context.current_class = a_context_class and context.current_feature = Current
		local
			l_type: TYPE_A
		do
			if a_context_class.changed then
					-- Generic types tracking
					-- This needs to be called for all features
				update_instantiator2 (a_context_class)
			end

			if a_context_class.class_id = written_in then
				l_type := type

					-- We only need to check the features that are actually defined in the current class
					-- as inherited features should already have been checked.
				type_a_checker.init_with_feature_table (
					Current, a_context_class.feature_table, Void, error_handler)
				if not l_type.is_void then
					type_a_checker.check_type_validity (l_type, Void)
					l_type.check_for_obsolete_class (a_context_class, Current)
				end
				if arguments /= Void then
						-- Check types of arguments
					arguments.check_type_validity (a_context_class, Current, type_a_checker)
				end
			end
		end

	check_expanded (class_c: CLASS_C) is
			-- Check expanded validity rules
		require
			class_c_not_void: class_c /= Void
			type /= Void
		local
			solved_type: TYPE_A
			vtec: VTEC
		do
debug ("CHECK_EXPANDED")
	io.error.put_string ("Check expanded of ")
	io.error.put_string (feature_name)
	io.error.put_new_line
end
			if class_c.class_id = written_in then
					-- Check validity of an expanded result type

					-- `set_type' has been called in `check_types' so
					-- the reverse assignment is valid.
				solved_type ?= type.actual_type
				if solved_type.has_expanded then
					if solved_type.expanded_deferred then
						create {VTEC1} vtec
					elseif not solved_type.valid_expanded_creation (class_c) then
						create {VTEC2} vtec
					elseif system.il_generation and then not solved_type.is_ancestor_valid then
							-- Expanded type cannot be based on a class with external ancestor.
						create {VTEC3} vtec
					end
					if vtec /= Void then
							-- Report error
						vtec.set_class (written_class)
						vtec.set_feature (Current)
						vtec.set_entity_name (feature_name)
						Error_handler.insert_error (vtec)
					end
				end
				if solved_type.has_generics then
					system.expanded_checker.check_actual_type (solved_type)
				end
				if arguments /= Void then
					arguments.check_expanded (class_c, Current)
				end
			end
		end

	check_signature (old_feature: FEATURE_I; tbl: FEATURE_TABLE) is
			-- Check signature conformance beetween Current
			-- and inherited feature in `inherit_info' from which Current
			-- is a redefinition.
		require
			old_feature_not_void: old_feature /= Void
			tbl_not_void: tbl /= Void
		local
			old_type, new_type: TYPE_A
			i, arg_count: INTEGER
			old_arguments: like arguments
			current_class: CLASS_C
			vdrd51: VDRD51
			vdrd52: VDRD52
			vdrd53: VDRD53
			vdrd6: VDRD6
			vdrd7: VDRD7
			ve02: VE02
			l_vtug: VTUG
		do
debug ("ACTIVITY")
	io.error.put_string ("Check signature of ")
	io.error.put_string (feature_name)
	io.error.put_new_line
end
			current_class := System.current_class

				-- Check if an attribute is redefined in an attribute
				-- of the same expandedness status
			if old_feature.is_attribute and then
				(not is_attribute or else
				old_feature.type.is_expanded /= type.is_expanded or else
				old_feature.type.is_reference /= type.is_reference)
			then
				create vdrd6
				vdrd6.init (old_feature, Current)
				Error_handler.insert_error (vdrd6)
			end

				-- Check if an effective feature is not redefined in a
				-- non-effective feature
			if (not old_feature.is_deferred) and then is_deferred then
				create vdrd7
				vdrd7.set_class (current_class)
				vdrd7.init (old_feature, Current)
				Error_handler.insert_error (vdrd7)
			end

			old_type ?= old_feature.type
			old_type := old_type.actual_argument_type (special_arguments).actual_type
				-- `new_type' is the actual type of the redefinition already
				-- instantiated
			new_type := type.actual_type
debug ("ACTIVITY")
	io.error.put_string ("Types:%N")
	if old_type /= Void then
		io.error.put_string ("old type:%N")
		io.error.put_string (old_type.dump)
		io.error.put_new_line
	end
	if new_type /= Void then
		io.error.put_string ("new type:%N")
		io.error.put_string (new_type.dump)
		io.error.put_new_line
	else
		io.error.put_string ("New type: VOID%Ntype:")
		io.error.put_string (type.dump)
		io.error.put_new_line
		io.error.put_string (type.out)
		io.error.put_new_line
	end
	io.error.put_new_line
end

			if not new_type.good_generics then
				l_vtug := new_type.error_generics
				l_vtug.set_class (current_class)
				l_vtug.set_feature (Current)
				error_handler.insert_error (l_vtug)
			elseif not new_type.conform_to (old_type) then
				create vdrd51
				vdrd51.init (old_feature, Current)
				Error_handler.insert_error (vdrd51)
			elseif is_attribute and then new_type.is_expanded /= old_type.is_expanded then
				create ve02
				ve02.init (old_feature, Current)
				Error_handler.insert_error (ve02)
			end

				-- Check the argument count
			if argument_count /= old_feature.argument_count then
				create vdrd52
				vdrd52.init (old_feature, Current)
				Error_handler.insert_error (vdrd52)
			else
					-- Check the argument conformance
				from
					i := 1
					arg_count := argument_count
					old_arguments := old_feature.arguments
				until
					i > arg_count
				loop
					old_type ?= old_arguments.i_th (i)
					old_type := old_type.actual_argument_type (special_arguments).actual_type
					new_type := arguments.i_th (i).actual_type
debug ("ACTIVITY")
	io.error.put_string ("Types:%N")
	if old_type /= Void then
		io.error.put_string ("old type:%N")
		io.error.put_string (old_type.dump)
		io.error.put_new_line
	end
	if new_type /= Void then
		io.error.put_string ("new type:%N")
		io.error.put_string (new_type.dump)
		io.error.put_new_line
	end
	io.error.put_new_line
end
					if not new_type.good_generics then
						l_vtug := new_type.error_generics
						l_vtug.set_class (current_class)
						l_vtug.set_feature (Current)
						error_handler.insert_error (l_vtug)
					elseif not new_type.conform_to (old_type) then
						create vdrd53
						vdrd53.init (old_feature, Current)
						Error_handler.insert_error (vdrd53)
					end

					i := i + 1
				end
			end
				-- Check aliases
			if not is_same_alias (old_feature) then
					-- Report that aliases are not the same
				Error_handler.insert_error (create {VDRD7_NEW}.make (system.current_class, Current, old_feature))
			end
				-- Check assigner procedure
			if not is_same_assigner (old_feature, tbl) then
					-- Report that assigner commands are not the same
				Error_handler.insert_error (create {VDRD8_NEW}.make (system.current_class, Current, old_feature))
			end
		end

	check_same_signature (old_feature: FEATURE_I) is
			-- Check signature equality beetween Current
			-- and inherited feature in `inherit_info' from which Current
			-- is a join.
		require
			good_argument: old_feature /= Void
			is_deferred
			old_feature.is_deferred
			old_feature_is_solved: old_feature.type.is_solved
		local
			old_type, new_type: TYPE_A
			i, arg_count: INTEGER
			old_arguments: like arguments
			vdjr: VDJR
			vdjr1: VDJR1
			vdjr2: VDJR2
		do
				-- Check the result type conformance
				-- `old_type' is the instantiated inherited type in the
				-- context of the class where the join takes place:
				-- i.e the class relative to `written_in'.
			old_type ?= old_feature.type
				-- `new_type' is the actual type of the join already
				-- instantiated
			new_type ?= type
			if not new_type.is_safe_equivalent (old_type) then
				create vdjr1
				vdjr1.init (old_feature, Current)
				vdjr1.set_type (new_type)
				vdjr1.set_old_type (old_type)
				Error_handler.insert_error (vdjr1)
			end

				-- Check the argument count
			if argument_count /= old_feature.argument_count then
				create vdjr
				vdjr.init (old_feature, Current)
				Error_handler.insert_error (vdjr)
			else

					-- Check the argument equality
				from
					i := 1
					arg_count := argument_count
					old_arguments := old_feature.arguments
				until
					i > arg_count
				loop
					old_type ?= old_arguments.i_th (i)
					new_type ?= arguments.i_th (i)
					if not new_type.is_safe_equivalent (old_type) then
						create vdjr2
						vdjr2.init (old_feature, Current)
						vdjr2.set_type (new_type)
						vdjr2.set_old_type (old_type)
						vdjr2.set_argument_number (i)
						Error_handler.insert_error (vdjr2)
					end
					i := i + 1
				end
			end
				-- Check aliases
			if not is_same_alias (old_feature) then
					-- Report that aliases are not the same
				Error_handler.insert_error (create {VDJR2_NEW}.make (system.current_class, Current, old_feature))
			end
		end

	special_arguments: ARRAY [TYPE_A] is
		local
			i, nb: INTEGER
		do
			from
				fixme ("we should resolve argument types early on in `init_arg' from PROCEDURE_I")
				nb := argument_count
				create Result.make (1, nb)
				i := 1
				nb := nb + 1
			until
				i = nb
			loop
				Result.put (arguments.i_th (i).actual_type, i)
				i := i + 1
			end
		end

	has_same_il_signature (a_parent_type, a_written_type: CL_TYPE_A; old_feature: FEATURE_I): BOOLEAN is
			-- Is current feature defined in `a_written_type' same as `old_feature'
			-- defined in `a_parent_type'?
		require
			a_parent_type_not_void: a_parent_type /= Void
			a_written_type_not_void: a_written_type /= Void
			old_feature_not_void: old_feature /= Void
			il_generation: System.il_generation
		local
			old_type, new_type: TYPE_A
			i, arg_count: INTEGER
			old_arguments: like arguments
		do
			old_type ?= old_feature.type
			old_type := old_type.actual_argument_type (special_arguments).
				instantiation_in (a_written_type, a_written_type.class_id).actual_type

			new_type := type.actual_type

				-- Check exact match of signature for IL generation.
			Result := old_type.same_as (new_type)

				-- Check the argument conformance
			from
				i := 1
				arg_count := argument_count
				old_arguments := old_feature.arguments
			until
				i > arg_count
			loop
				old_type ?= old_arguments.i_th (i)
				old_type := old_type.actual_argument_type (special_arguments).
					instantiation_in (a_written_type, a_written_type.class_id).actual_type

				new_type := arguments.i_th (i).actual_type
					-- Check exact match of signature for IL generation.
				Result := Result and then old_type.same_as (new_type)

				i := i + 1
			end
		end

	solve_types (feat_tbl: FEATURE_TABLE) is
			-- Evaluates signature types in context of `feat_tbl'.
			-- | Take care of possible anchored types
		do

			set_type
				(Result_evaluator.evaluated_type (type, feat_tbl, Current), assigner_name_id)
			if arguments /= Void then
				arguments.solve_types (feat_tbl, Current)
			end
		end

	same_signature (other: FEATURE_I): BOOLEAN is
			-- Has `other' same signature than Current ?
		require
			good_argument: other /= Void
			same_feature_names: feature_name_id = other.feature_name_id
		local
			i, nb: INTEGER
		do
			Result := type.is_safe_equivalent (other.type)
			from
				nb := argument_count
				Result := Result and then nb = other.argument_count
				nb := argument_count
				i := 1
			until
				i > nb or else not Result
			loop
				Result := arguments.i_th (i).is_safe_equivalent (other.arguments.i_th (i))
				i := i + 1
			end
		end

	argument_position (arg_id: INTEGER): INTEGER is
			-- Position of argument `arg_id' in list of arguments
			-- of current feature. 0 if none or not found.
		require
			arg_id_not_void: arg_id >= 0
		do
			if arguments /= Void then
				Result := arguments.argument_position_id (arg_id, 1)
			end
		end

	has_argument_name (arg_id: INTEGER): BOOLEAN is
			-- Has current feature an argument named `arg_id" ?
		require
			arg_id_positive: arg_id > 0
		do
			if arguments /= Void then
				Result := arguments.argument_position_id (arg_id, 1) /= 0
			end
		end

	property_setter_in (class_type: CLASS_TYPE): FEATURE_I is
			-- Find an associated property setter in `class_type'.
		require
			class_type_attached: class_type /= Void
		local
			f: FEATURE_I
		do
			if type.is_void then
				f := Current
			elseif assigner_name_id /= 0 then
				f := written_class.feature_table.item_id (assigner_name_id)
			else
				f := ancestor_property_setter_in (class_type.associated_class)
			end
			if f /= Void then
				Result := class_type.associated_class.feature_of_rout_id (f.rout_id_set.first)
			end
		ensure
			result_attached: (type.is_void or else assigner_name_id /= 0) implies Result /= Void
		end

	ancestor_property_setter_in (c: CLASS_C): FEATURE_I is
			-- Find an property setter routine in some ancestor class of the class `c'.
		require
			c_not_void: c /= Void
		local
			parent_classes: FIXED_LIST [CLASS_C]
			parent_class: CLASS_C
			routine_id: INTEGER
			c_id: like origin_class_id
			f_id: like origin_feature_id
		do
			if type.is_void then
				Result := c.feature_of_rout_id (rout_id_set.first)
			elseif assigner_name_id /= 0 then
				Result := written_class.feature_table.item_id (assigner_name_id)
			else
				c_id := origin_class_id
				if c_id = 0 then
					c_id := written_in
					f_id := feature_id
				else
					f_id := origin_feature_id
				end
				routine_id := system.class_of_id (c_id).feature_of_feature_id (f_id).rout_id_set.first
				parent_classes := c.parents_classes
				if parent_classes /= Void then
					from
						parent_classes.start
					until
						parent_classes.after or else Result /= Void
					loop
						parent_class := parent_classes.item
						Result := parent_class.feature_of_rout_id (routine_id)
						if Result /= Void then
							Result := Result.ancestor_property_setter_in (parent_class)
						end
						parent_classes.forth
					end
				end
			end
		ensure
			result_attached: (type.is_void or else assigner_name_id /= 0) implies Result /= Void
		end

	check_assigner (feature_table: FEATURE_TABLE) is
			-- Check if associated assigner is valid.
		require
			feature_table_not_void: feature_table /= Void
			has_assigner: assigner_name_id /= 0
		local
			assigner: FEATURE_I
			assigner_arguments: like arguments
			query_arguments: like arguments
			vfac: VFAC
		do
			if system.current_class.class_id = written_in then
					-- Lookup feature in `feature_table' as feature table in the current class is not set yet.
				assigner := feature_table.item_id (assigner_name_id)
			else
				assigner := feature_table.feature_of_rout_id
					(written_class.feature_named (assigner_name).rout_id_set.first)
			end
			if assigner = Void or else assigner.has_return_value then
				create {VFAC1} vfac.make (system.current_class, Current)
			elseif assigner.argument_count /= argument_count + 1 then
				create {VFAC2} vfac.make (system.current_class, Current)
			elseif not assigner.arguments.first.actual_type.same_as (type.actual_type) then
				create {VFAC3} vfac.make (system.current_class, Current)
			elseif argument_count > 0 then
				assigner_arguments := assigner.arguments
				query_arguments := arguments
				from
					assigner_arguments.start
						-- Skip first argument
					assigner_arguments.forth
					query_arguments.start
				until
					assigner_arguments.after
				loop
					if not assigner_arguments.item.actual_type.same_as (query_arguments.item.actual_type) then
						create {VFAC4} vfac.make (system.current_class, Current)
						assigner_arguments.finish
						query_arguments.finish
					end
					assigner_arguments.forth
					query_arguments.forth
				end
			end
			if vfac /= Void then
				if assigner /= Void then
					vfac.set_assigner (assigner.api_feature (system.current_class.class_id))
				end
				error_handler.insert_error (vfac)
			end
		end

feature -- Undefinition

	new_deferred: DEF_PROC_I is
			-- New deferred feature for undefinition
		require
			not is_deferred
			redefinable
		local
			ext: EXTERNAL_I
		do
			if is_function then
				create {DEF_FUNC_I} Result
			else
				create Result
			end
			Result.set_type (type, assigner_name_id)
			Result.set_arguments (arguments)
			Result.set_written_in (written_in)
			Result.set_origin_feature_id (origin_feature_id)
			Result.set_origin_class_id (origin_class_id)
			Result.set_rout_id_set (rout_id_set)
			Result.set_assert_id_set (assert_id_set)
			Result.set_is_infix (is_infix)
			Result.set_is_prefix (is_prefix)
			Result.set_is_frozen (is_frozen)
			Result.set_feature_name_id (feature_name_id, alias_name_id)
			Result.set_feature_id (feature_id)
			Result.set_pattern_id (pattern_id)
			Result.set_is_require_else (is_require_else)
			Result.set_is_ensure_then (is_ensure_then)
			Result.set_export_status (export_status)
			Result.set_body_index (body_index)
			Result.set_has_postcondition (has_postcondition)
			Result.set_has_precondition (has_precondition)
			Result.set_is_bracket (is_bracket)
			Result.set_is_binary (is_binary)
			Result.set_is_unary (is_unary)
			Result.set_has_convert_mark (has_convert_mark)
			Result.set_has_rescue_clause (has_rescue_clause)

			if is_external then
				ext ?= Current
				if ext.extension.is_il then
					Result.set_extension (ext.extension)
				end
			end
		ensure
			Result_exists: Result /= Void
			Result_is_deferred: Result.is_deferred
		end

	new_rout_id: INTEGER is
			-- New routine id
		do
			Result := Routine_id_counter.next_rout_id
		end

	Routine_id_counter: ROUTINE_COUNTER is
			-- Routine id counter
		once
			Result := System.routine_id_counter
		end

feature -- Replication

	code_id: INTEGER is
			-- Code id for inheritance analysis
		do
			Result := body_index
		end

	set_code_id (i: INTEGER) is
			-- Assign `i' to code_id.
		do
			-- Do nothing
		end

	set_access_in (i: INTEGER_32)
			-- Assign `i' to access_in
		do
			-- Do nothing
		end

	access_in: INTEGER is
			-- Id of class where current feature can be accessed
			-- through its routine id
			-- Useful for replication
		do
			Result := written_in
		end

	replicated (in: INTEGER): FEATURE_I is
			-- Replicated feature
		require
			in_not_void: in /= 0
		deferred
		ensure
			Result_exists: Result /= Void
			access_in_set: Result.access_in = in
		end

	new_code_id: INTEGER is
			-- New code id
		do
			Result := System.body_index_counter.next_id
		end

	selected: FEATURE_I is
			-- Selected feature (used for duplicating inherited features by resetting replication and selection status
		deferred
		ensure
			Result_exists: Result /= Void
			equivalent: Result.equiv (Current)
		end

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		require
			in_not_void: in /= 0
		deferred
		ensure
			Result_exists: Result /= Void
		end

	is_unselected: BOOLEAN is
			-- Is current feature an unselected one ?
		do
			-- Do nothing
		end

	transfer_to (other: FEATURE_I) is
			-- Transfer of datas from Current into `other'.
		require
			other_exists: other /= Void
		do
			other.set_export_status (export_status)
			other.set_feature_id (feature_id)
			other.set_feature_name_id (feature_name_id, alias_name_id)
			other.set_written_feature_id (written_feature_id)
			other.set_origin_feature_id (origin_feature_id)
			other.set_origin_class_id (origin_class_id)
			other.set_pattern_id (pattern_id)
			other.set_rout_id_set (rout_id_set)
			other.set_written_in (written_in)

				--| IEK: As an minor optimization the flags below internally
				--| could be set simply with 'other.set_feature_flags (feature_flags)'
				--| It would also prevents bugs when adding another flag and it doesn't
				--| get accounted for in this routine.
			other.set_is_frozen (is_frozen)
			other.set_is_infix (is_infix)
			other.set_is_prefix (is_prefix)
			other.set_is_origin (is_origin)
			other.set_is_bracket (is_bracket)
			other.set_is_binary (is_binary)
			other.set_is_unary (is_unary)
			other.set_has_convert_mark (has_convert_mark)
			other.set_body_index (body_index)
		end

	transfer_from (other: FEATURE_I) is
			-- Transfer of datas from `other' into `Current'.
		require
			other_exists: other /= Void
		do
				-- `export_status' needs to be set via `set_export_status'
			set_export_status (other.export_status)

			feature_id := other.feature_id
			feature_name_id := other.feature_name_id
			alias_name_id := other.alias_name_id
			written_feature_id := other.written_feature_id
			origin_feature_id := other.origin_feature_id
			origin_class_id := other.origin_class_id
			pattern_id := other.pattern_id
			rout_id_set := other.rout_id_set
			written_in := other.written_in
			body_index := other.body_index

				-- Set `feature_flags' directly from `other'.
			feature_flags := other.feature_flags
		end

feature -- Genericity

	update_instantiator2 (a_class: CLASS_C) is
			-- Look for generic/expanded types in result and arguments in order
			-- to update instantiator.
		require
			good_argument: a_class /= Void
			good_context: a_class.changed
		local
			i, arg_count: INTEGER
		do
			Instantiator.dispatch (type.actual_type, a_class)
			from
				i := 1
				arg_count := argument_count
			until
				i > arg_count
			loop
				Instantiator.dispatch (arguments.i_th (i).actual_type, a_class)
				i := i + 1
			end
		end

feature -- Pattern

	pattern: PATTERN is
			-- Feature pattern
		do
			create Result.make (type.meta_type)
			if argument_count > 0 then
				Result.set_argument_types (arguments.pattern_types)
			end
		end

	process_pattern is
			-- Process pattern of Current feature
		local
			p: PATTERN_TABLE
		do
			p := Pattern_table
			p.insert (generation_class_id, pattern)
			pattern_id := p.last_pattern_id
		end

feature -- Dead code removal

	used: BOOLEAN is
			-- Is feature used ?
		do
			if is_inline_agent then
				Result := enclosing_feature.used
			else
					-- In final mode dead code removal process is on.
					-- In workbench mode all features are considered
					-- used.
				Result := 	byte_context.workbench_mode
							or else
							System.is_used (Current)
			end
		end

feature -- Byte code access

	frozen access (access_type: TYPE_A; is_qualified: BOOLEAN): ACCESS_B is
			-- Byte code access for current feature
		require
			access_type_not_void: access_type /= Void
		do
			Result := access_for_feature (access_type, Void, is_qualified)
		ensure
			Result_exists: Result /= Void
		end

	frozen access_for_multi_constraint (access_type: TYPE_A; a_static_type: TYPE_A; is_qualified: BOOLEAN): ACCESS_B is
			-- Creates a byte code access for a multi constraint target.
			-- `a_static_type' is the type where the feature is from.
			-- It is NOT a static call that will be generated, but a dynamic one. It is only needed for W_bench.
		require
			access_type_not_void: access_type /= Void
		do
			Result := access (access_type, is_qualified)
			check Result /= Void end
			Result.set_multi_constraint_static (a_static_type)
		ensure
			Result_exists: Result /= Void
		end

	access_for_feature (access_type: TYPE_A; static_type: TYPE_A; is_qualified: BOOLEAN): ACCESS_B is
			-- Byte code access for current feature. Dynamic binding if
			-- `static_type' is Void, otherwise static binding on `static_type'.
		require
			access_type_not_void: access_type /= Void
		local
			is_in_op: BOOLEAN
			l_type: TYPE_A
		do
			if is_qualified then
					-- To fix eweasel test#term155 we remove all anchors from
					-- calls after the first dot in a call chain.
				l_type := access_type.deep_actual_type
			else
				l_type := access_type
			end
			is_in_op := written_in = System.function_class_id or else
						written_in = System.predicate_class_id or else
						written_in = System.procedure_class_id

			if is_in_op then
				if feature_name_id = {PREDEFINED_NAMES}.call_name_id then
					create {AGENT_CALL_B} Result.make (Current, l_type, static_type, False)
				elseif feature_name_id = {PREDEFINED_NAMES}.item_name_id then
					create {AGENT_CALL_B} Result.make (Current, l_type, static_type, True)
				end
			end

			if Result = Void then
				if written_in = System.any_id then
						-- Feature written in ANY.
					create {ANY_FEATURE_B} Result.make (Current, l_type, static_type)
				else
					create {FEATURE_B} Result.make (Current, l_type, static_type)
				end
			end
		ensure
			Result_exists: Result /= Void
		end

feature {NONE} -- log file

	add_in_log (class_type: CLASS_TYPE; encoded_name: STRING) is
		do
			System.used_features_log_file.add (class_type, feature_name, encoded_name)
		end

feature -- C code generation

	generate (class_type: CLASS_TYPE; buffer: GENERATION_BUFFER) is
			-- Generate feature written in `class_type' in `buffer'.
		require
			valid_buffer: buffer /= Void
			written_in_type: class_type.associated_class.class_id = generation_class_id or is_replicated
			not_deferred: not is_deferred
		local
			l_byte_code: BYTE_CODE
			tmp_body_index: INTEGER
			l_byte_context: like byte_context
		do
			if used then
					-- `generate' from BYTE_CODE will log the feature name
					-- and encoded name in `used_features_log_file' from SYSTEM_I
				generate_header (class_type, buffer)

				tmp_body_index := body_index
				l_byte_code := tmp_opt_byte_server.disk_item (tmp_body_index)
				if l_byte_code = Void then
					l_byte_code := byte_server.disk_item (tmp_body_index)
				end

					-- Generation of C code for an Eiffel feature written in
					-- the associated class of the current type.
				l_byte_context := byte_context

				if System.in_final_mode and then System.inlining_on then
						-- We need to set `{BYTE_CONTEXT}.byte_code', since it is used
						-- in `inlined_byte_code'.
					l_byte_context.set_byte_code (l_byte_code)
					l_byte_code := l_byte_code.inlined_byte_code
				end

					-- Generation of the C routine
				l_byte_context.set_byte_code (l_byte_code)
				l_byte_context.set_current_feature (Current)
				l_byte_code.analyze
				l_byte_code.set_real_body_id (real_body_id (class_type))
				l_byte_code.generate
				l_byte_context.clear_feature_data
			else
				System.removed_log_file.add (class_type, feature_name)
			end
		end

	generate_header (a_type: CLASS_TYPE; buffer: GENERATION_BUFFER) is
			-- Generate a header before body of feature
		require
			a_type_not_void: a_type /= Void
			valid_buffer: buffer /= Void
		do
			buffer.put_string ("%N/* {")
			buffer.put_string (a_type.associated_class.name)
			buffer.put_two_character ('}', '.')
			buffer.put_string (feature_name)
			buffer.put_string (" */")
		end

feature -- Debug purpose

	trace is
			-- Debug purpose
		do
			io.error.put_string ("feature name: ")
			io.error.put_string (feature_name)
			io.error.put_character (' ')
			rout_id_set.trace
			io.error.put_string (" {")
			io.error.put_string ("fid = ")
			io.error.put_integer (feature_id)
			io.error.put_string ("}");
			io.error.put_string (" {")
			io.error.put_string ("body_index = ")
			io.error.put_integer (body_index)
			io.error.put_string ("}");
			io.error.put_string (" {")
			io.error.put_string ("written in = ")
			io.error.put_string (written_class.name)
			io.error.put_string ("}");
			io.error.put_string (" {")
			io.error.put_string ("body_index = ")
			if body_index > 0 then
				io.error.put_integer (body_index)
			else
				io.error.put_integer (0)
			end
			io.error.put_new_line
		end

feature -- Debugging

	is_debuggable: BOOLEAN is
		local
			wc: CLASS_C
		do
			if (not is_external)
				and then (not is_attribute)
				and then (not is_constant)
				and then (not is_deferred)
				and then (not is_unique)
			then
				wc := written_class
				Result := (not wc.is_basic)
					and then (wc.has_types)
			end
		end

	real_body_id (class_type: CLASS_TYPE): INTEGER is
			-- Real body id at compilation time for `class_type'.
			-- This id might be obsolete after supermelting this feature.
			--| In latter case, new real body id is kept
			--| in DEBUGGABLE objects.
		require
			valid_body_id: valid_body_id
		do
			Result := execution_table.real_body_id (body_index, class_type)
		end

	valid_body_id: BOOLEAN is
			-- Use of this routine as precondition for real_body_id.
		do
			Result := ((not is_attribute)
						and then (not is_constant)
						and then (not is_deferred)
						and then (not is_unique)
						and then written_class.has_types)
				or else
					(is_constant and is_once)
		end

feature -- Api creation

	e_feature: E_FEATURE is
		do
			Result := api_feature (written_in)
		end

	api_feature (a_class_id: INTEGER): E_FEATURE is
			-- API representation of Current
		require
			a_class_id_positive: a_class_id > 0
		local
			e_routine: E_ROUTINE
		do
			Result := new_api_feature
			Result.set_written_feature_id (written_feature_id)
			Result.set_written_in (written_in)
			Result.set_associated_class_id (a_class_id)
			Result.set_body_index (body_index)
			Result.set_is_origin (is_origin)
			Result.set_export_status (export_status)
			Result.set_is_frozen (is_frozen)
			Result.set_is_infix (is_infix)
			Result.set_is_prefix (is_prefix)
			Result.set_rout_id_set (rout_id_set)
			Result.set_is_il_external (is_il_external)
			if is_inline_agent then
				e_routine ?= Result
				e_routine.set_enclosing_body_id (enclosing_body_id)
				e_routine.set_inline_agent_nr (inline_agent_nr)
			end
		end

feature {FEATURE_I} -- Implementation

	feature_flags: NATURAL_32
			-- Property of Current feature, i.e. frozen,
			-- infix, origin, prefix, selected...

	new_api_feature: E_FEATURE is
			-- API feature creation
		deferred
		ensure
			non_void_result: Result /= Void
		end

	is_frozen_mask: NATURAL_32 is 0x0001
	is_origin_mask: NATURAL_32 is 0x0002
	is_empty_mask: NATURAL_32 is 0x0004
	is_infix_mask: NATURAL_32 is 0x0008
	is_prefix_mask: NATURAL_32 is 0x0010
	is_require_else_mask: NATURAL_32 is 0x0020
	is_ensure_then_mask: NATURAL_32 is 0x0040
	has_precondition_mask: NATURAL_32 is 0x0080
	has_postcondition_mask: NATURAL_32 is 0x0100
	is_bracket_mask: NATURAL_32 is 0x0200
	is_binary_mask: NATURAL_32 is 0x0400
	is_unary_mask: NATURAL_32 is 0x0800
	has_convert_mark_mask: NATURAL_32 is 0x1000
	has_property_mask: NATURAL_32 is 0x2000
	has_property_getter_mask: NATURAL_32 is 0x4000
	has_property_setter_mask: NATURAL_32 is 0x8000
	is_fake_inline_agent_mask: NATURAL_32 is 0x10000
	has_rescue_clause_mask: NATURAL_32 is 0x20000
	is_export_status_none_mask: NATURAL_32 is 0x40000
	has_function_origin_mask: NATURAL_32 is 0x80000 -- Used in ATTRIBUTE_I
	has_replicated_ast_mask: NATURAL_32 is 0x100000
			-- Mask used for each feature property.

	internal_export_status: like export_status
			-- Internal export status object. When it is ANY or NONE
			-- it is Void to save some space, what help us distinguish
			-- is the `is_export_status_none_mask'.

	export_all_status: EXPORT_ALL_I is
		once
			create Result
		ensure
			export_all_status_not_void: Result /= Void
		end

	export_none_status: EXPORT_NONE_I is
		once
			create Result
		ensure
			export_none_status_not_void: Result /= Void
		end

feature {INHERIT_TABLE, FEATURE_I} -- Access

	private_external_name_id: INTEGER
			-- External name id of feature if any in IL generation.

	private_external_name: STRING is
			-- External name of feature if any in IL generation.
		require
			valid_private_external_name_id: private_external_name_id > 0
		do
			Result := Names_heap.item (private_external_name_id)
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

feature {NONE} -- Debug output

	debug_output: STRING is
			-- Textual representation of current feature for debugging.
		do
			Result := feature_name
			if Result = Void then
				Result := "Name not yet assigned"
			end
		end

invariant
	valid_enclosing_feature: is_inline_agent implies enclosing_body_id > 0
	valid_inline_agent_nr: is_inline_agent implies inline_agent_nr > 0

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end
