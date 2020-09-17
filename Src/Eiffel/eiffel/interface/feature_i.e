note
	description: "[
			Instance of an Eiffel feature.
			
			For every inherited feature there is an instance of FEATURE_I with its final name,
			the class name where it is written, the body id of its content and
			the routine table ids to which the feature is attached.
			
			Attribute `type` is the real type of the feature in the class where it
			is inherited (or written), that means there is no more anchored type.
		]"
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
	SHARED_ENCODING_CONVERTER
	INTERNAL_COMPILER_STRING_EXPORTER

	SHARED_DEGREES

feature -- Access

	feature_name_32: STRING_32
			-- Final name of feature.
		require
			feature_name_id_set: feature_name_id > 0
		do
			Result := encoding_converter.utf8_to_utf32 (feature_name)
		ensure
			feature_name_not_void: Result /= Void
			feature_name_not_empty: not Result.is_empty
		end

	alias_names_32: detachable ARRAYED_LIST [STRING_32]
			-- Alias name of feature (if any).
		do
			if attached alias_names as l_names then
				create Result.make (l_names.count)
				across
					l_names as ic
				loop
					Result.force (encoding_converter.utf8_to_utf32 (ic.item))
				end
			end
		end

	assigner_name: STRING
			-- Associated assigner name (if any).
		do
			if assigner_name_id /= 0 then
				Result := names_heap.item (assigner_name_id)
			end
		end

	feature_name_id: INTEGER
			-- Id of `feature_name' in `Names_heap' table.


	alias_name_ids: detachable SPECIAL [INTEGER]
			-- Ids of `alias_names` in `names_heap` table.

	has_alias: BOOLEAN
			-- Has alias name?
		do
			Result := attached alias_name_ids as a and then a.count > 0
		end

	has_alias_name_id (a_alias_name_id: INTEGER): BOOLEAN
		local
			i, n: like alias_name_ids.index_of
		do
			if attached alias_name_ids as a then
				from
					i := a.lower
					n := a.upper
				until
					i > n or else Result
				loop
					Result := a [i] = a_alias_name_id
					i := i + 1
				end
			end
		end

	assigner_name_id: INTEGER
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

	export_status: EXPORT_I
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

	immediate_export_status: EXPORT_I
			-- Export status of the feature declaration without taking inheritance into account.
			-- Use with care: the function is slow when the feature is selectively exported.
		local
			f: like feature_flags
		do
			f := feature_flags
			if f & is_immediate_export_status_all_mask /= 0 then
				Result := export_all_status
			elseif f & is_immediate_export_status_none_mask /= 0 then
				Result := export_none_status
			else
				if
					written_in /= 0 and then
					attached written_class.ast.features as cs
				then
						-- Retrieve the export status from the AST.
					across
						cs as c
					until
						attached Result
					loop
						if attached c.item.features as fs then
							across
								fs as h
							until
								attached Result
							loop
								if attached h.item.feature_with_name (feature_name_id) then
									Result := export_status_generator.feature_clause_export_status (system, written_class, c.item)
								end
							end
						end
					end
				end
				if not attached Result then
					Result := export_none_status
				end
			end
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
			-- Feature ID of Current in associated CLASS_C of ID `access_in'
			-- that gives a body.
			-- Used for MSIL code generation only.

	frozen is_origin: BOOLEAN
			-- Is feature an origin?
		do
			Result := feature_flags & is_origin_mask = is_origin_mask
		end

	frozen has_replicated_ast: BOOLEAN
			-- Does feature have a replicated AST?
		do
			Result := feature_flags & has_replicated_ast_mask = has_replicated_ast_mask
		end

	frozen is_selected: BOOLEAN
			-- Is feature from a selected branch?
		do
			Result := feature_flags & is_selected_mask = is_selected_mask
		end

	frozen is_replicated_directly: BOOLEAN
			-- Is feature directly replicated in class it is created in?
			-- This flag is needed to distinguish between newly replicated features
			-- and inherited replicated features as currently the is no way of
			-- 'selecting' the feature_i object and keeping the 'access_in' value.
		do
			Result := feature_flags & is_replicated_directly_mask = is_replicated_directly_mask
		end

	frozen from_non_conforming_parent: BOOLEAN
			-- Is feature inherited from a non-conforming parent?
		do
			Result := feature_flags & from_non_conforming_parent_mask = from_non_conforming_parent_mask
		end

	frozen is_frozen: BOOLEAN
			-- Is feature frozen?
		do
			Result := feature_flags & is_frozen_mask = is_frozen_mask
		end

	frozen is_empty: BOOLEAN
			-- Is feature with an empty body?
		do
			Result := feature_flags & is_empty_mask = is_empty_mask
		end

	frozen is_infix: BOOLEAN
			-- Is feature an infixed one ?
		do
			Result := feature_flags & is_infix_mask = is_infix_mask
		end

	frozen is_prefix: BOOLEAN
			-- Is feature a prefixed one ?
		do
			Result := feature_flags & is_prefix_mask = is_prefix_mask
		end

	frozen is_bracket: BOOLEAN
			-- Is feature a bracket one ?
		do
			Result := feature_flags & is_bracket_mask = is_bracket_mask
		end

	frozen is_parentheses: BOOLEAN
			-- Is feature a bracket one ?
		do
			Result := feature_flags & is_parentheses_mask = is_parentheses_mask
		end

	frozen is_binary: BOOLEAN
			-- Is feature a binary one?
		do
			Result := feature_flags & is_binary_mask = is_binary_mask
		end

	frozen is_unary: BOOLEAN
			-- Is feature an unary one?
		do
			Result := feature_flags & is_unary_mask = is_unary_mask
		end

	frozen has_convert_mark: BOOLEAN
			-- Does binary feature have a convert mark?
		do
			Result := feature_flags & has_convert_mark_mask = has_convert_mark_mask
		end

	frozen covariant_argument_checker_agent: PREDICATE [TYPE_A]
			-- Argument checker for `covariantly_redefined_features'
		once
				-- If all arguments are expanded or if they are a frozen class
				-- then it cannot be covariantly redefined
			Result := agent (v: TYPE_A): BOOLEAN
						do
							Result := v.is_expanded or (v.has_associated_class implies v.base_class.is_frozen)
						end
		end

	frozen covariantly_redefined_features (a_base_class: CLASS_C): HASH_TABLE [FEATURE_I, CLASS_C]
			-- Return all the covariantly redefined routines of Current
		require
			a_base_class_not_void: a_base_class /= Void
			conforming_class: a_base_class.conform_to (written_class)
		local
			l_descendants: ARRAYED_LIST [CLASS_C]
			l_feat: FEATURE_I
			l_rout_id: INTEGER
			l_covariant_features: like covariantly_redefined_features
			i: INTEGER
		do
			if argument_count > 0 then
					-- If all arguments are expanded or if they are a frozen class
					-- then it cannot be covariantly redefined
				l_descendants := a_base_class.direct_descendants
				i := l_descendants.count
				if
					i > 0 and then not arguments.for_all (covariant_argument_checker_agent)
				then
					from
						l_rout_id := rout_id_set.first
					until
						i = 0
					loop
						if l_descendants [i].conform_to (a_base_class) then
							l_feat := l_descendants [i].feature_of_rout_id (l_rout_id)
								-- It could be Void in case of a non-conforming descendants.
							if is_covariant_to (l_feat) then
								if Result = Void then
									create Result.make (3)
								end
								Result.put (l_feat, l_descendants [i])
							end
							l_covariant_features := l_feat.covariantly_redefined_features (l_descendants [i])
							if l_covariant_features /= Void and then not l_covariant_features.is_empty then
								if Result = Void then
									create Result.make (3)
								end
								Result.merge (l_covariant_features)
							end
						end
						i := i - 1
					end
				end
			end
		end

	frozen is_covariant_to (other: FEATURE_I): BOOLEAN
			-- Is `other' a covariant redefinition of Current?
		require
			other_not_void: other /= Void
			subset: other.rout_id_set.has (rout_id_set.first)
		local
			i: INTEGER
		do
			if other /= Current then
				from
					i := arguments.count
				until
					i = 0 or else Result
				loop
						-- This is not the best way to check for covariance since `is_equivalent' will
						-- return False on thing that are not covariantly redefined.
					Result := not arguments.i_th (i).conformance_type.is_safe_equivalent (other.arguments.i_th (i).conformance_type)
					i := i - 1
				end
			end
		end

	has_formal: BOOLEAN
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

	extension: EXTERNAL_EXT_I
			-- Encapsulation of the external extension
		do
		end

	external_name: STRING
			-- External name
		require
			external_name_id_set: external_name_id > 0
		do
			Result := Names_heap.item (external_name_id)
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
			ascii_compatible: ∀ c: Result ¦ c ≤ '%/0x7F/'
		end

	external_name_id: INTEGER
			-- External name of feature if any generation.
		do
			Result := private_external_name_id
			if Result = 0 then
				Result := feature_name_id
			end
		end

	is_inline_agent: BOOLEAN
			-- is the feature an inline agent
		do
			Result := inline_agent_nr /= 0
		end

	enclosing_body_id: INTEGER
			-- The body id of the enclosing feature of an inline agent

	enclosing_feature: FEATURE_I
			-- Gives the (real) feature in which this features is defined.
			-- If the feature has no enclosing feature, a reference to itself is returned.
		local
			l_access_class: CLASS_C
		do
			if is_inline_agent then
				if is_replicated_directly then
					l_access_class := access_class
				else
					l_access_class := written_class;
				end
				Result := l_access_class.feature_of_body_index (enclosing_body_id)
				if Result = Void then
					Result := l_access_class.invariant_feature
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

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Access

	feature_name: STRING
			-- Final name of feature.
		require
			feature_name_id_set: feature_name_id > 0
		do
			Result := Names_heap.item (feature_name_id)
		ensure
			feature_name_not_void: Result /= Void
			feature_name_not_empty: not Result.is_empty
		end

	alias_names: detachable LIST [detachable STRING]
		do
			if attached alias_name_ids as lst then
				create {ARRAYED_LIST [STRING]} Result.make (lst.count)
				across
					lst as ic
				loop
					if ic.item > 0 then
						Result.force (Names_heap.item (ic.item))
					else
						Result.force (Void)
					end
				end
			end
		end

feature -- Comparison

	is_less alias "<" (other: FEATURE_I): BOOLEAN
			-- Comparison of FEATURE_I based on their name.
		local
			l_name, l_other_name: like feature_name
		do
			l_name := feature_name
			l_other_name := other.feature_name
			if l_name = Void then
				Result := l_other_name /= Void
			else
				Result := l_other_name /= Void and then l_name < l_other_name
			end
		end

	is_same_alias (other: FEATURE_I): BOOLEAN
			-- Does current have the same alias as `other'?
		require
			other_not_void: other /= Void
		do
			Result :=
				same_aliases (other) and then
				has_convert_mark = other.has_convert_mark
		end

	is_same_assigner (other: FEATURE_I; tbl: FEATURE_TABLE): BOOLEAN
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
				if attached assigner_command then
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

	number_of_breakpoint_slots: INTEGER
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
		do
			if
				attached real_body as b and then
				attached {ROUTINE_AS} b.content as r
			then
				Result := r.number_of_breakpoint_slots
			end
			Result := Result.max (1)
		end

	first_breakpoint_slot_index: INTEGER
			-- Index of the first breakpoint-slot of the body
			-- Take into account inherited and inner assertions
		do
			if
				attached real_body as b and then
				attached {ROUTINE_AS} b.content as r and then
				attached {INTERNAL_AS} r.routine_body as i
			then
				if i.is_empty then
						--| in this case, the first bp of the body
						--| is the last breakable point
					Result := number_of_breakpoint_slots
				else
					Result := i.first_breakpoint_slot_index
				end
			end
			Result := Result.max (1)
		end

feature -- Status

	is_precondition_free: BOOLEAN
			-- Is feature precondition-free?
		local
			a: ASSERT_ID_SET
		do
			a := assert_id_set
			if a = Void then
					-- The feature is immediate, check only immediate precondition.
				Result := not has_precondition
			elseif a.has_precondition then
					-- There are inherited features that are not precondition-free.
				if
					has_precondition and then
						-- Current feature has precondition, that might be True.
					attached body as fb and then attached fb.body as b and then
					attached {ROUTINE_AS} b.content as r and then attached {BOOL_AS} r.precondition.assertions.first.expr as v
				then
						-- The precondition has the first expression in the form of a boolean constant.
						-- If it is true, the feature is precondition-free
					Result := v.value
				end
			else
					-- There are inherited precondition-free precursors.
				Result := True
			end
		end

	is_type_evaluation_delayed: BOOLEAN
			-- Is evaluation of type information associated with this feature delayed?
			-- (Usually this happens for types that cannot be evaluated immediately
			-- because they require information from other classes that have no type
			-- information yet.)
		do
			Result := feature_flags & is_type_evaluation_delayed_mask /= 0
		end

	to_melt_in (a_class: CLASS_C): BOOLEAN
			-- Has current feature to be melted in class `a_class' ?
		require
			good_argument: a_class /= Void
		do
			Result := a_class.class_id = written_in or else is_replicated_directly
		end

	to_generate_in (a_class: CLASS_C): BOOLEAN
			-- Has current feature to be generated in class `a_class' ?
		require
			good_argument: a_class /= Void
		do
			Result := a_class.class_id = written_in or else is_replicated_directly
		end

	frozen to_implement_in (a_class: CLASS_C): BOOLEAN
			-- Does Current feature need to be exposed in interface
			-- used for IL generation?
		require
			a_class_not_void: a_class /= Void
		do
			Result := a_class.class_id = written_in or else is_replicated_directly
		end

	is_ghost: BOOLEAN
			-- Is this a ghost feature, i.e. the one that should not be generated?
		do
			Result := feature_flags & is_ghost_mask /= 0
		end

feature -- Setting

	set_feature_id (i: INTEGER)
			-- Assign `i' to `feature_id'
		do
			feature_id := i
		end

	set_body_index (i: INTEGER)
			-- Assign `i' to `body_index'.
		do
			body_index := i
		end

	set_pattern_id (i: INTEGER)
			-- Assign `i' to `pattern_id'.
		do
			pattern_id := i
		end

	frozen set_feature_name_id (a_id: INTEGER; a_alias_ids: like alias_name_ids)
			-- Assign `a_id` to `feature_name_id` and set `alias_name_ids` according to `a_alias_id`.
		require
			valid_id: Names_heap.valid_index (a_id)
			valid_alias_id: attached a_alias_ids implies ∀ i: a_alias_ids ¦ names_heap.valid_index (i)
		do
			feature_name_id := a_id
			alias_name_ids := a_alias_ids
		ensure
			feature_name_id_set: feature_name_id = a_id
			a_alias_id_set: attached a_alias_ids implies ∀ i: a_alias_ids ¦ has_alias_name_id (i)
		end

	set_renamed_name_id (a_id: INTEGER; a_alias_id: like {RENAMING}.alias_name_id)
			-- Same as `set_feature_name_id` but redefined in `{EXTERNAL_I}`.
		require
			valid_id: Names_heap.valid_index (a_id)
			valid_alias_id: attached a_alias_id implies ∀ i: a_alias_id ¦ names_heap.valid_index (i)
		do
			set_feature_name_id (a_id, a_alias_id)
		ensure
			feature_name_id_set: feature_name_id = a_id
			a_alias_id_set: attached a_alias_id implies ∀ i: a_alias_id ¦ has_alias_name_id (i)
		end

	set_written_in (a_class_id: like written_in)
			-- Assign `a_class_id' to `access_in'.
		require
			a_class_id_not_void: a_class_id > 0
		do
			written_in := a_class_id
		ensure
			written_in_set: written_in = a_class_id
		end

	set_written_feature_id (a_feature_id: like written_feature_id)
			-- Assign `a_feature_id' to `written_feature_id'.
		require
			valid_feature_id: a_feature_id >= 0
		do
			written_feature_id := a_feature_id
		ensure
			written_feature_id_set: written_feature_id = a_feature_id
		end

	set_origin_feature_id (a_feature_id: like origin_feature_id)
			-- Assign `a_feature_id' to `origin_feature_id'.
		require
			valid_feature_id: a_feature_id >= 0
		do
			origin_feature_id := a_feature_id
		ensure
			origin_feature_id_set: origin_feature_id = a_feature_id
		end

	set_origin_class_id (a_class_id: like origin_class_id)
			-- Assign `a_class_id' to `origin_class_id'.
		require
			valid_feature_id: a_class_id >= 0
		do
			origin_class_id := a_class_id
		ensure
			origin_class_id_set: origin_class_id = a_class_id
		end

	set_export_status (e: EXPORT_I)
			-- Assign `e' to `export_status'.
			-- See also: `set_immediate_export_status`.
		require
			e_not_void: e /= Void
		do
				-- Reset export status flags.
			feature_flags := feature_flags & is_export_status_none_mask.bit_not
				-- Update export status flags.
			if e.is_all then
				internal_export_status := Void
			elseif e.is_none then
				internal_export_status := Void
				feature_flags := feature_flags | is_export_status_none_mask
			else
				internal_export_status := e
			end
		ensure
			export_status_set: export_status.same_as (e)
		end

	set_immediate_export_status (e, i: EXPORT_I)
			-- Assign export status `e` to `export_status` and record immedate export status `i` of the feature (if possible).
			-- See also: `set_export_status`.
		do
				-- Reset immediate export status flags.
			feature_flags := feature_flags &
				(is_immediate_export_status_none_mask |
				is_immediate_export_status_all_mask).bit_not
				-- Update immediate export status flags.
			if i.is_all then
				feature_flags := feature_flags | is_immediate_export_status_all_mask
			elseif i.is_none then
				feature_flags := feature_flags | is_immediate_export_status_none_mask
			end
			set_export_status (e)
		ensure
			export_status_set: export_status.same_as (e)
			immediate_export_status_set: immediate_export_status.same_as (i)
		end

	frozen set_is_origin (b: BOOLEAN)
			-- Assign `b' to `is_origin'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_origin_mask)
		ensure
			is_origin_set: is_origin = b
		end

	frozen set_is_selected (b: BOOLEAN)
			-- Assign `b' to `is_selected'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_selected_mask)
		ensure
			is_selected_set: is_selected = b
		end

	frozen set_has_replicated_ast (b: BOOLEAN)
			-- Assign `b' to `has_replicated_ast'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, has_replicated_ast_mask)
		ensure
			has_replicated_ast_set: has_replicated_ast = b
		end

	frozen set_is_replicated_directly (b: BOOLEAN)
			-- Assign `b' to `is_replicated_directly'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_replicated_directly_mask)
		ensure
			is_replicated_directly_set: is_replicated_directly = b
		end

	frozen set_from_non_conforming_parent (b: BOOLEAN)
			-- Assign `b' to `from_non_conforming_parent'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, from_non_conforming_parent_mask)
		ensure
			from_non_conforming_parent_set: from_non_conforming_parent = b
		end

	frozen set_is_empty (b : BOOLEAN)
			-- Set `is_empty' to `b'
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_empty_mask)
		ensure
			is_empty_set: is_empty = b
		end

	frozen set_is_frozen (b: BOOLEAN)
			-- Assign `b' to `is_frozen'.
			--|Note: nothing to do with melted/frozen features
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_frozen_mask)
		ensure
			is_frozen_set: is_frozen = b
		end

	frozen set_is_infix (b: BOOLEAN)
			-- Assign `b' to `is_infix'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_infix_mask)
		ensure
			is_infix_set: is_infix = b
		end

	frozen set_is_prefix (b: BOOLEAN)
			-- Assign `b' to `is_prefix'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_prefix_mask)
		ensure
			is_prefix_set: is_prefix = b
		end

	frozen set_is_bracket (b: BOOLEAN)
			-- Assign `b' to `is_bracket'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_bracket_mask)
		ensure
			is_bracket_set: is_bracket = b
		end

	frozen set_is_parentheses (b: BOOLEAN)
			-- Assign `b' to `is_parentheses'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_parentheses_mask)
		ensure
			is_parentheses_set: is_parentheses = b
		end

	frozen set_is_binary (b: BOOLEAN)
			-- Assign `b' to `is_binary'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_binary_mask)
		ensure
			is_binary_set: is_binary = b
		end

	frozen set_is_unary (b: BOOLEAN)
			-- Assign `b' to `is_unary'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_unary_mask)
		ensure
			is_unary_set: is_unary = b
		end

	frozen set_has_convert_mark (b: BOOLEAN)
			-- Assign `b' to `has_convert_mark'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, has_convert_mark_mask)
		ensure
			has_convert_mark_set: has_convert_mark = b
		end

	frozen set_is_require_else (b: BOOLEAN)
			-- Assign `b' to `is_require_else'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_require_else_mask)
		ensure
			is_require_else_set: is_require_else = b
		end

	frozen set_is_ensure_then (b: BOOLEAN)
			-- Assign `b' to `is_ensure_then'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_ensure_then_mask)
		ensure
			is_ensure_then_set: is_ensure_then = b
		end

	frozen set_has_precondition (b: BOOLEAN)
			-- Assign `b' to `has_precondition'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, has_precondition_mask)
		ensure
			has_precondition_set: has_precondition = b
		end

	frozen set_has_postcondition (b: BOOLEAN)
			-- Assign `b' to `has_postcondition'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, has_postcondition_mask)
		ensure
			has_postcondition_set: has_postcondition = b
		end

	frozen set_has_false_postcondition (b: BOOLEAN)
			-- Assign `b' to `has_false_postcondition'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, has_false_postcondition_mask)
		ensure
			is_failing_set: has_false_postcondition = b
		end

	frozen set_is_fake_inline_agent (b: BOOLEAN)
			-- Assign `b' to `is_fake_inline_agent'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, is_fake_inline_agent_mask)
		ensure
			is_fake_inline_agent_set: is_fake_inline_agent = b
		end

	frozen set_has_rescue_clause (b: BOOLEAN)
			-- Assign `b' to `has_rescue_clause'.
		do
			feature_flags := feature_flags.set_bit_with_mask (b, has_rescue_clause_mask)
		ensure
			has_rescue_clause_set: has_rescue_clause = b
		end

	set_has_property (v: BOOLEAN)
			-- Set `has_property' to `v'.
		do
			feature_flags := feature_flags.set_bit_with_mask (v, has_property_mask)
		ensure
			has_property_set: has_property = v
		end

	set_has_property_getter (v: BOOLEAN)
			-- Set `has_property_getter' to `v'.
		do
			feature_flags := feature_flags.set_bit_with_mask (v, has_property_getter_mask)
		ensure
			has_property_getter_set: has_property_getter = v
		end

	set_has_property_setter (v: BOOLEAN)
			-- Set `has_property_setter' to `v'.
		do
			feature_flags := feature_flags.set_bit_with_mask (v, has_property_setter_mask)
		ensure
			has_property_setter_set: has_property_setter = v
		end

	set_is_stable (v: BOOLEAN)
			-- Set `is_stable' to `v'.
		do
			feature_flags := feature_flags.set_bit_with_mask (v, is_stable_mask)
		ensure
			is_stable_set: is_stable = v
		end

	set_has_immediate_class_postcondition (v: BOOLEAN)
			-- Set `has_immediate_class_postcondition` to `v`.
		do
			feature_flags := feature_flags.set_bit_with_mask (v, has_class_postcondition_mask)
		ensure
			has_immediate_class_postcondition_set: has_immediate_class_postcondition = v
		end

	set_has_immediate_non_object_call (v: BOOLEAN)
			-- Set `has_immediate_non_object_call` to `v`.
		do
			feature_flags := feature_flags.set_bit_with_mask (v, has_non_object_call_mask)
		ensure
			has_immediate_non_object_call_set: has_immediate_non_object_call = v
		end

	set_has_immediate_non_object_call_in_assertion (v: BOOLEAN)
			-- Set `has_immediate_non_object_call_in_assertion` to `v`.
		do
			feature_flags := feature_flags.set_bit_with_mask (v, has_non_object_call_in_assertion_mask)
		ensure
			has_immediate_non_object_call_in_assertion_set: has_immediate_non_object_call_in_assertion = v
		end

	set_has_immediate_unqualified_call_in_assertion (v: BOOLEAN)
			-- Set `has_immediate_unqualified_call_in_assertion` to `v`.
		do
			feature_flags := feature_flags.set_bit_with_mask (v, has_unqualified_call_in_assertion_mask)
		ensure
			has_immediate_unqualified_call_in_assertion_set: has_immediate_unqualified_call_in_assertion = v
		end

	set_is_hidden_in_debugger_call_stack (v: BOOLEAN)
			-- Set `is_hidden_in_debugger_call_stack' to `v'.
		do
			feature_flags := feature_flags.set_bit_with_mask (v, is_hidden_in_debugger_call_stack_mask)
		ensure
			is_hidden_in_debugger_call_stack_set: is_hidden_in_debugger_call_stack = v
		end

	set_rout_id_set (an_id_set: like rout_id_set)
			-- Assign `an_id_set' to `rout_id_set'.
		require
			an_id_set_not_void: an_id_set /= Void
		do
			rout_id_set := an_id_set
		ensure
			rout_id_set: rout_id_set = an_id_set
		end

	set_private_external_name_id (n_id: like private_external_name_id)
			-- Assign `n_id' to `private_external_name_id'.
		require
			valid_n: n_id > 0
		do
			private_external_name_id := n_id
		ensure
			private_external_name_set: private_external_name_id = n_id
		end

	generation_class_id: INTEGER
			-- Id of class where feature has to be generated in
		do
			Result := written_in
		end

	duplicate: like Current
			-- Clone
		do
			Result := twin
		end

	duplicate_arguments
			-- Do a clone of arguments (for replication)
		do
			-- Do nothing
		end

	set_inline_agent (a_enclosing_body_id, a_inline_agent_nr: INTEGER)
			-- Define this feature as an inline agent
		require
			enclosing_body_id_valid: a_enclosing_body_id > 0
			inline_agent_nr_valid: (is_fake_inline_agent implies a_inline_agent_nr = -1) and
									not is_fake_inline_agent implies a_inline_agent_nr > 0
		do
			inline_agent_nr := a_inline_agent_nr
			enclosing_body_id := a_enclosing_body_id
		end

	set_is_type_evaluation_delayed (v: BOOLEAN)
			-- Set `is_type_evaluation_delayed' to `v'.
		do
			feature_flags := feature_flags.set_bit_with_mask (v, is_type_evaluation_delayed_mask)
		end

	set_is_ghost (v: BOOLEAN)
			-- Set `is_ghost' to `v'.
		do
			feature_flags := feature_flags.set_bit_with_mask (v, is_ghost_mask)
		ensure
			is_ghost_set: is_ghost = v
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Setting

	set_feature_name (s: STRING)
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

feature -- Incrementality

	same_aliases (other: FEATURE_I): BOOLEAN
			-- Does `Current` and `other` have same aliases?
		do
			Result := other.alias_name_ids ~ alias_name_ids
		end

	equiv (other: FEATURE_I): BOOLEAN
			-- Incrementality test on instance of FEATURE_I during
			-- second pass.
		require
			good_argument: other /= Void
		do
			Result := written_in = other.written_in
				and then body_index = other.body_index
				and then rout_id_set.same_as (other.rout_id_set)
				and then is_origin = other.is_origin
				and then is_frozen = other.is_frozen
				and then is_deferred = other.is_deferred
				and then is_external = other.is_external
				and then export_status.same_as (other.export_status)
				and then same_signature (other)
				and then has_precondition = other.has_precondition
				and then has_postcondition = other.has_postcondition
				and then has_false_postcondition = other.has_false_postcondition
				and then has_immediate_class_postcondition = other.has_immediate_class_postcondition
				and then is_once = other.is_once
				and then is_process_relative = other.is_process_relative
				and then is_object_relative_once = other.is_object_relative_once
				and then is_constant = other.is_constant
				and then is_stable = other.is_stable
				and then is_transient = other.is_transient
				and then same_aliases (other)
				and then has_convert_mark = other.has_convert_mark
				and then assigner_name_id = other.assigner_name_id
				and then has_property = other.has_property
				and then (has_property implies property_name.is_equal (other.property_name))
				and then has_property_getter = other.has_property_getter
				and then has_property_setter = other.has_property_setter
				and then is_ghost = other.is_ghost
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
			io.error.put_boolean (is_process_or_thread_relative_once = other.is_process_or_thread_relative_once) io.error.put_new_line;
	end
end
			if Result then
				if assert_id_set /= Void then
					Result := assert_id_set.same_as (other.assert_id_set)
				else
					Result := other.assert_id_set = Void
				end
			end

			if Result and then rout_id_set.first = System.default_rescue_rout_id then
				-- This is the default rescue feature.
				-- Test whether emptiness of body has changed.
				Result := is_empty = other.is_empty
			end

			if Result and then rout_id_set.first = System.default_create_rout_id then
				-- This is the default create feature.
				-- Test whether emptiness of body has changed.
				Result := is_empty = other.is_empty
			end

debug ("ACTIVITY")
	if not Result then
		io.error.put_string ("%T%T")
		io.error.put_string (feature_name)
		io.error.put_string (" is not equiv%N")
	end
end
		end

	select_table_equiv (other: FEATURE_I): BOOLEAN
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

	is_valid: BOOLEAN
			-- Is feature still valid?
			-- Incrementality: The types of arguments and/or result
			-- are still defined in system
		do
			Result := type.is_valid
			if Result and then has_arguments then
				Result := arguments.is_valid
			end
		end

	same_class_type (other: FEATURE_I): BOOLEAN
			-- Has `other' same resulting type than Current ?
		require
			good_argument: other /= Void
			same_names: other.feature_name_id = feature_name_id
		do
			Result := type.same_as (other.type)
		end

	same_interface (other: FEATURE_I): BOOLEAN
			-- Has `other' same interface than Current ?
			-- [Semantics for second pass is `old_feat.same_interface (new)']
		require
			good_argument: other /= Void
		do
			Result :=
					-- Still an attribute.
				is_attribute = other.is_attribute and then
					-- Same alias.
				same_aliases (other) and then
				has_convert_mark = other.has_convert_mark and then
					-- Same assigner procedure.
				assigner_name_id = other.assigner_name_id and then
					-- Same return type.
				type.same_as (other.type) and then
					-- Same arguments if any.
				argument_count = other.argument_count and then
				(argument_count /= 0 implies arguments.same_interface (other.arguments)) and then
					-- Still a once.
				is_once = other.is_once and then
					-- Still the same kind of once.
				is_process_or_thread_relative_once = other.is_process_or_thread_relative_once and then
				is_process_relative = other.is_process_relative and then
				is_object_relative_once = other.is_object_relative_once and then
					-- Of the same stability.
				is_stable = other.is_stable and then
					-- Of the same use of current object.
				is_class = other.is_class and then
					-- Of the same volatility.
				is_transient = other.is_transient and then
					-- Of the same ghost status.
				is_ghost = other.is_ghost
		end

feature -- creation of default rescue clause

	create_default_rescue (def_resc_name_id: INTEGER)
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
				if my_body /= Void then
					my_body.create_default_rescue (def_resc_name_id)
				end
			end
		end

feature -- Type id

	written_type (class_type: CLASS_TYPE): CLASS_TYPE
			-- Written type of feature in context of
			-- type `class_type'.
		require
			good_argument: class_type /= Void
			conformance: class_type.associated_class.conform_to (written_class)
		do
			Result := written_class.meta_type (class_type)
		end

feature -- Conveniences

	assert_id_set: ASSERT_ID_SET
			-- Assertions to which procedure belongs to
			-- (To be redefined in PROCEDURE_I).
		do
			-- Do nothing
		end

	is_obsolete: BOOLEAN
			-- Is Current feature obsolete?
		do
			Result := obsolete_message /= Void
		end

	has_arguments: BOOLEAN
			-- Has current feature some formal arguments ?
		do
			Result := arguments /= Void
		end

	has_separate_arguments: BOOLEAN
			-- Has current feature some arguments of separate type?
		do
			if attached arguments as a then
				Result := across a as c some c.item.is_separate end
			end
		end

	is_replicated: BOOLEAN
			-- Is Current feature conceptually replicated?
		do
			-- Do nothing
		end

	is_routine: BOOLEAN
			-- Is current feature a routine ?
		do
			-- Do nothing
		end

	is_function: BOOLEAN
			-- Is current feature a function ?
		do
			-- Do nothing
		end

	is_type_feature: BOOLEAN
			-- Is current an instance of TYPE_FEATURE_I?
		do
			-- Do nothing
		end

	is_attribute: BOOLEAN
			-- Is current feature an attribute ?
		do
			-- Do nothing
		end

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
			-- Is current feature a once per thread or per process feature?
		do
			Result := is_once and then not is_object_relative_once
		end

	is_thread_relative_once: BOOLEAN
			-- Is current feature a once per object feature?
		do
			Result := is_process_or_thread_relative_once and not is_process_relative
		end

	is_object_relative_once: BOOLEAN
			-- Is current feature a once per object feature?
		do
			-- Do nothing
		end

	is_do: BOOLEAN
			-- Is current feature a do one ?
		do
			-- Do nothing
		end

	is_deferred: BOOLEAN
			-- Is current feature a deferred one ?
		do
			-- Do nothing
		end

	is_unique: BOOLEAN
			-- Is current feature a unique constant ?
		do
			-- Do nothing
		end

	is_external: BOOLEAN
			-- Is current feature an external one ?
		do
			-- Do nothing
		end

	has_return_value: BOOLEAN
			-- Does current return a value?
		do
			Result := is_constant or is_attribute or is_function
		ensure
			validity: Result implies (is_constant or is_attribute or is_function)
		end

	has_code: BOOLEAN
			-- Does the feature has its own or inherited code (in the form of assertions or body)?
		do
				-- False by default.
		end

	frozen is_il_external: BOOLEAN
			-- Is current feature a C external one?
		do
			Result :=
				attached {IL_EXTENSION_I} extension or else
				attached {CONSTANT_I} Current as c and then c.written_class.is_external
		ensure
			not_is_c_external: Result implies not is_c_external
		end

	frozen is_c_external: BOOLEAN
			-- Is current feature a C external one?
		do
			Result := attached extension as e and then (not e.is_il and not e.is_built_in)
		ensure
			not_is_il_external: Result implies not is_il_external
		end

	is_process_relative: BOOLEAN
			-- Is feature process-wide (rather than thread-local)?
			-- (Usually applies to once routines.)
		do
			-- False by default
		end

	is_stable: BOOLEAN
			-- Is feature stable, i.e. cannot be a target of an assignment with void value?
			-- (Usually applies to queries.)
		do
			Result := feature_flags & is_stable_mask = is_stable_mask
		end

	is_hidden_in_debugger_call_stack: BOOLEAN
			-- Is feature hidden in debugger call stack tool?
		do
			if attached written_class as cl and then cl.is_hidden_in_debugger_call_stack then
				Result := True
			else
				Result := feature_flags & is_hidden_in_debugger_call_stack_mask = is_hidden_in_debugger_call_stack_mask
			end
		end

	is_transient: BOOLEAN
			-- Is feature transient, i.e. never stored in storables?
			-- (Usually applies to attributes.)
		do
			-- False by default
		end

	is_hidden: BOOLEAN
			-- Is attribute hidden for implementation purpose
			-- such as once per object's attributes.
			-- (Usually applies to attributes.)
		do
			-- False by default
		end

	has_non_object_call: BOOLEAN
			-- Is there a non-object call in the feature?
			-- See also: `has_immediate_non_object_call`, `has_immediate_non_object_call_in_assertion`.
		do
			Result :=
				has_immediate_non_object_call or else
				attached assert_id_set as a and then a.has_non_object_call
		end

	has_immediate_non_object_call: BOOLEAN
			-- Is there a non-object call in the feature without taking inherited assertions into account?
			-- See also: `set_immediate_has_non_object_call`, `has_immediate_non_object_call_in_assertion`.
		do
			Result := feature_flags & has_non_object_call_mask /= 0
		end

	has_immediate_non_object_call_in_assertion: BOOLEAN
			-- Is there a non-object call in the immediate routine precondition or postcondition?
			-- See also: `set_immediate_has_non_object_call_in_assertion`, `has_immediate_non_object_call`.
		do
			Result := feature_flags & has_non_object_call_in_assertion_mask /= 0
		end

	has_unqualified_call_in_assertion: BOOLEAN
			-- Is there an unqualified call in the feature assertion?
			-- See also: `has_immediate_unqualified_call_in_assertion`.
		do
			Result :=
				has_immediate_unqualified_call_in_assertion or else
				attached assert_id_set as a and then a.has_unqualified_call
		end

	has_immediate_unqualified_call_in_assertion: BOOLEAN
			-- Is there an unqualfiied object call in the immediate routine precondition or postcondition?
			-- See also: `set_has_immediate_unqualified_call_in_assertion`, `has_immediate_non_object_call_in_assertion`.
		do
			Result := feature_flags & has_unqualified_call_in_assertion_mask /= 0
		end

	has_immediate_class_postcondition: BOOLEAN
			-- Does feature have an immediate class postcondition?
			-- (There could also be inherited class postconditions not reported by this query.)
			-- See also: `set_has_immediate_class_postcondition`, `has_class_postcondition`.
		do
			Result := feature_flags & has_class_postcondition_mask /= 0
		end

	has_class_postcondition: BOOLEAN
			-- Does feature have a (immediate or inherited) class postcondition?
			-- See also: `has_immediate_class_postcondition`, `is_class`.
		do
			Result :=
				has_immediate_class_postcondition or else
				attached assert_id_set as a and then a.has_class_postcondition or else
				attached extension as e and then e.is_static and then not has_unqualified_call_in_assertion
		end

	frozen is_class: BOOLEAN
			-- Is feature declared as a class one?
			-- See also: `has_class_postcondition`, `is_target_free`.
		do
				-- A feature is a class one if it has a class postcondition.
			Result := has_class_postcondition
		ensure
			true_if_has_immediate_class_postcondition: has_immediate_class_postcondition implies Result
			true_if_has_inherited_class_postcondition: attached assert_id_set as a and then a.has_class_postcondition implies Result
			true_if_safe_constant: is_constant and then not has_unqualified_call_in_assertion implies Result
			true_if_safe_static_external: attached extension as e and then e.is_static and not has_unqualified_call_in_assertion implies Result
		end

	is_target_free: BOOLEAN
			-- Does the feature depend on the target type of the call?
			-- (It can be a class feature, but depend on the target type.)
			-- See also: `is_class`.
		do
				-- IL externals have no unqualified calls if they do not need current object.
			Result := attached extension as e and then e.is_static and then not has_unqualified_call_in_assertion
		ensure
			true_if_safe_constant: is_constant and then not has_unqualified_call_in_assertion implies Result
			true_if_safe_static_external: attached extension as e and then e.is_static and not has_unqualified_call_in_assertion implies Result
		end

	frozen has_precondition: BOOLEAN
			-- Is feature declaring some preconditions ?
		do
			Result := feature_flags & has_precondition_mask = has_precondition_mask
		end

	frozen has_postcondition: BOOLEAN
			-- Is feature declaring some postconditions ?
		do
			Result := feature_flags & has_postcondition_mask = has_postcondition_mask
		end

	frozen has_false_postcondition: BOOLEAN
			-- Does feature have a false postcondition?
		do
			Result := feature_flags & has_false_postcondition_mask = has_false_postcondition_mask
		end

	frozen is_failing: BOOLEAN
			-- Does feature fail?
			-- (This usually happens when the feature or its ancestor version has a postcondition "false".)
		do
			Result := has_false_postcondition or else
				(attached assert_id_set as a and then a.has_false_postcondition)
		end

	has_printable_assertion: BOOLEAN
			-- Is feature declaring some pre or post conditions that can be output?
		do
			Result := has_postcondition or else has_precondition or else has_immediate_class_postcondition
		end

	has_combined_assertion: BOOLEAN
			-- Does feature have combined precondition or combined postcondition?
		do
			Result :=has_precondition or else has_postcondition or else
				attached assert_id_set as a and then
					(a.has_precondition or else a.has_postcondition)
		end

	frozen is_require_else: BOOLEAN
			-- Is precondition block of feature a redefined one ?
		do
			Result := feature_flags & is_require_else_mask = is_require_else_mask
		end

	frozen is_ensure_then: BOOLEAN
			-- Is postcondition block of feature a redefined one ?
		do
			Result := feature_flags & is_ensure_then_mask = is_ensure_then_mask
		end

	frozen is_fake_inline_agent: BOOLEAN
			-- Is postcondition block of feature a redefined one ?
		do
			Result := feature_flags & is_fake_inline_agent_mask = is_fake_inline_agent_mask
		end

	frozen has_rescue_clause: BOOLEAN
			-- Has rescue clause ?
		do
			Result := feature_flags & has_rescue_clause_mask = has_rescue_clause_mask
		end

	is_invariant: BOOLEAN
			-- Is this feature the invariant feature of its eiffel class ?
		do
			Result := False
		end

	can_be_encapsulated: BOOLEAN
			-- Is current feature a feature that can be encapsulated?
			-- Eg: attribute or constant.
		do
		end

	redefinable: BOOLEAN
			-- Is feature redefinable ?
		do
			Result := not is_frozen
		end

	undefinable: BOOLEAN
			-- Is feature undefinable ?
		do
			Result := redefinable
		end

	has_property: BOOLEAN
			-- Does feature have an associated property?
		do
			Result := feature_flags & has_property_mask = has_property_mask
		end

	has_property_getter: BOOLEAN
			-- Does feature have an associated property getter?
		do
			Result := feature_flags & has_property_getter_mask = has_property_getter_mask
		end

	has_property_setter: BOOLEAN
			-- Does feature have an associated property setter?
		do
			Result := feature_flags & has_property_setter_mask = has_property_setter_mask
		end

	type: TYPE_A
			-- Result type of feature
		do
			Result := void_type
		ensure
			type_not_void: Result /= Void
		end

	set_type (t: like type; a: like assigner_name_id)
			-- Assign `t' to `type' and `a' to `assigner_name_id'.
		require
			t_not_void: t /= Void
			valid_a: a /= 0 implies names_heap.valid_index (a)
		do
			-- Do nothing
		ensure
			type_set: type ~ t
		end

	arguments: FEAT_ARG
			-- Argument types
		do
			-- No arguments
		end

	set_arguments (args: like arguments)
			-- Assign `args' to arguments.
		do

		end

	set_assert_id_set (set: like assert_id_set)
			-- Assign `set' to assert_id_set.
		do
			-- Do nothing	
		end

	argument_count: INTEGER
			-- Number of arguments of feature
		do
			if arguments /= Void then
				Result := arguments.count
			end
		end

	written_class: CLASS_C
			-- Class where feature is written in
		require
			good_written_in: written_in /= 0
		do
			Result := System.class_of_id (written_in)
		ensure
			written_class_not_void: Result /= Void
		end

	access_class: CLASS_C
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

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Conveniences

	property_name: STRING
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

	obsolete_message: STRING
			-- Obsolete message
			-- (Void if Current is not obsolete)
		do
			-- Do nothing
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

	is_exported_for (client: CLASS_C): BOOLEAN
			-- Is current feature exported to class `client' ?
		require
			good_argument: client /= Void
			has_export_status: export_status /= Void
		local
			l_ncp_classes: FIXED_LIST [CLASS_C]
		do
			Result := export_status.valid_for (client)
			if not Result then
					-- We need to check that `Current' is non-conformally inherited by `client'.
				l_ncp_classes := client.non_conforming_parents_classes
				if l_ncp_classes /= Void then
					from
						l_ncp_classes.start
					until
						Result or else l_ncp_classes.after
					loop
						Result := export_status.valid_for (l_ncp_classes.item)
						l_ncp_classes.forth
					end
				end
			end
		end

	record_suppliers (feat_depend: FEATURE_DEPENDANCE)
			-- Record suppliers ids in `feat_depend'
		require
			good_arg: feat_depend /= Void
		local
			type_a: TYPE_A
		do
				-- Create the supplier set for the feature.
			if attached type as t then
				if t.has_associated_class then
					feat_depend.add_supplier (t.base_class)
				end
				t.update_dependance (feat_depend)
			end
			if attached arguments as a then
				across
					a as argument
				loop
					type_a := argument.item
					if type_a.has_associated_class then
						feat_depend.add_supplier (type_a.base_class)
					end
				end
			end
		end

	suppliers: TWO_WAY_SORTED_SET [INTEGER]
			-- Class ids of all suppliers of feature
		local
			class_dependance: detachable CLASS_DEPENDANCE
		do
			class_dependance := depend_server.item (written_in)
			if class_dependance /= Void then
					-- We have a class dependence so we must have been successfully type checked
					-- from a previous compilation.
				Result := class_dependance.item (body_index).suppliers
			else
					-- We have not yet been typed checked so we return an empty set.
				create Result.make
			end
		end

feature -- Check

	real_body: BODY_AS
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

	body: FEATURE_AS
			-- Body of feature
		require
			not_is_inline_agent: not is_inline_agent
		local
			bid: INTEGER
		do
			bid := body_index
			if bid > 0 then
					-- We need to check this flag as it tells whether or not we really have replication.
					-- A typical case is {BILINEAR}.sequential_search does not get a new FEATURE_AS
					-- in BILINEAR and the its FEATURE_AS has to be found in LINEAR.
				if has_replicated_ast then
					Result := body_server.item (access_in, bid)
				else
					Result := body_server.item (written_in, bid)
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

feature -- IL code generation

	generate_il
			-- Generate IL code for current feature.
		local
			byte_code: BYTE_CODE
		do
			if not is_attribute and then not is_c_external and not is_il_external then
				byte_code := Byte_server.disk_item (body_index)
				byte_context.set_byte_code (byte_code)
				byte_context.set_current_feature (Current)
				byte_code.generate_il
				byte_context.clear_feature_data
			end
		end

	custom_attributes: BYTE_LIST [BYTE_NODE]
			-- Custom attributes of Current if any.
		do
			if
				not is_attribute and
				not is_c_external and
				not is_il_external and then
				Byte_server.has (body_index) and then
				attached Byte_server.item (body_index) as byte_code
			then
				Result := byte_code.custom_attributes
			end
		end

	class_custom_attributes: BYTE_LIST [BYTE_NODE]
			-- Class custom attributes of Current if any.
		do
			if
				not is_attribute and then
				not is_external and then
				not is_il_external and then
				Byte_server.has (body_index) and then
				attached Byte_server.item (body_index) as byte_code
			then
				Result := byte_code.class_custom_attributes
			end
		end

	interface_custom_attributes: BYTE_LIST [BYTE_NODE]
			-- Interface custom attributes of Current if any.
		do
			if
				not is_attribute and then
				not is_external and then
				not is_il_external and then
				Byte_server.has (body_index) and then
				attached Byte_server.item (body_index) as byte_code
			then
				Result := byte_code.interface_custom_attributes
			end
		end

	property_custom_attributes: BYTE_LIST [BYTE_NODE]
			-- Custom attributes of Current if any.
		do
			if Byte_server.has (body_index) then
				Result := Byte_server.item (body_index).property_custom_attributes
			end
		end

feature -- Byte code computation

	melt (a_class_type: CLASS_TYPE)
			-- Generate byte code for current feature
			-- [To be redefined in CONSTANT_I, ATTRIBUTE_I and in EXTERNAL_I].
		require
			class_type_not_void: a_class_type /= Void
		local
			byte_code: BYTE_CODE
			l_byte_context: like byte_context
			melted_feature: MELT_FEATURE
			l_real_body_index: INTEGER
		do
			byte_code := Byte_server.disk_item (body_index)

			prepare_object_relative_once (byte_code)

			l_byte_context := byte_context
			l_byte_context.set_byte_code (byte_code)
			l_byte_context.set_current_feature (Current)
			l_real_body_index := real_body_index (a_class_type)

			Byte_array.clear
			byte_code.set_real_body_id (l_real_body_index)
			byte_code.make_byte_code (Byte_array)
			byte_context.clear_feature_data

			melted_feature := Byte_array.melted_feature
			melted_feature.set_real_body_id (l_real_body_index)

			if not System.freeze then
				Tmp_m_feature_server.put (melted_feature)
			end

			Execution_table.mark_melted (body_index, a_class_type)
		end

feature -- Polymorphism

	new_poly_table (rout_id: INTEGER): POLY_TABLE [ENTRY]
 			-- New polymorphic table
 		require
			positive_rout_id: rout_id > 0
			valid_rout_id: rout_id_set.has (rout_id)
		local
			seed: FEATURE_I
 		do
 			if not is_attribute or else not Routine_id_counter.is_attribute (rout_id) then
 					-- This is a routine.
 					-- The seed is a routine as well.
 				create {ROUT_TABLE} Result.make (rout_id)
 			else
 				seed := system.seed_of_routine_id (rout_id)
	 			if seed.has_formal then
	 					-- This is an attribute with a seed of a formal generic type that may become expanded.
	 				create {GENERIC_ATTRIBUTE_TABLE} Result.make (rout_id, True)
	 			elseif not seed.type.actual_type.is_expanded then
	 					-- This is an attribute with a seed of a non-expanded type that may require initialization.
	 				create {GENERIC_ATTRIBUTE_TABLE} Result.make (rout_id, False)
	 			else
	 					-- This is an attribute with a seed that is not of a formal generic type.
	 				create {ATTR_TABLE [ATTR_ENTRY]} Result.make (rout_id)
	 			end
	 		end
 		end

 	new_entry (context_type: CLASS_TYPE; rout_id: INTEGER; is_class_deferred: BOOLEAN; class_id: like {CLASS_C}.class_id): ENTRY
 			-- New polymorphic unit for the version of routine ID `rout_id` in the context type `class_type` of the class of ID `class_id`
 			-- that is deferred or not according to `is_class_deferred`.
 		require
			rout_id_not_void: rout_id /= 0
			rout_id_valid: rout_id_set.has (rout_id)
		local
			r: like new_rout_entry
 		do
 			if not is_attribute or else not Routine_id_counter.is_attribute (rout_id) then
 				Result := new_rout_entry (context_type, is_class_deferred, class_id)
 			elseif byte_context.workbench_mode or else has_formal then
				r := new_rout_entry (context_type, is_class_deferred, class_id)
				r.set_is_attribute
				Result := r
			else
				Result := new_attr_entry (context_type, is_class_deferred, class_id)
 			end
 		end

	rout_entry_type: ROUT_ENTRY
			-- A type to be returned by `new_rout_entry`.
		require
			false
		do
			check from_precondition: false then end
		ensure
			class
			false
		end

 	new_rout_entry (t: CLASS_TYPE; d: BOOLEAN; c: like {CLASS_C}.class_id): like rout_entry_type
 			-- New routine unit for a target type `t` of the class of ID `c`
 			-- that is deferred according to `d`.
 		require
 			valid_class_id: system.has_existing_class_of_id (c)
 			known_class: attached system.class_of_id (c) as compiled_class
 			known_invariant: is_invariant implies compiled_class.invariant_feature.feature_id = feature_id
 			known_feature: not is_invariant implies attached compiled_class.feature_of_feature_id (feature_id)
 			consistent_target_type: t.associated_class.class_id = c
 			consistent_deferred_status: compiled_class.is_deferred = d
 		local
 			access_class_id: like access_in
 			access_type_id: INTEGER
 			written_type_id: INTEGER
 			entry_written_type: CLASS_TYPE
 		do
 			entry_written_type := written_class.meta_type (t)
			written_type_id := entry_written_type.type_id
 			if has_replicated_ast then
 					-- If AST has been replicated, then we must use `access_in'
 					-- as this is the new written in value.
 				access_class_id := access_in
				access_type_id := access_class.meta_type (t).type_id
 			else
 				access_class_id := written_in
				access_type_id := written_type_id
 			end
 			create Result.make
 				(result_type_in (t),
 				t.type_id,
 				feature_id,
 				is_deferred,
 				body_index,
 				pattern_table.c_pattern_id_in (pattern_id, entry_written_type),
 				access_type_id,
 				access_class_id,
 				written_in,
 				d,
 				c)
 		end

 	new_attr_entry (t: CLASS_TYPE; d: BOOLEAN; c: like {CLASS_C}.class_id): ATTR_ENTRY
 			-- New attribute unit for a target type `t` of the class of ID `c`
 			-- that is deferred according to `d`.
 		require
 			is_attribute: is_attribute
 			valid_class_id: system.has_existing_class_of_id (c)
 			known_class: attached system.class_of_id (c) as compiled_class
 			known_feature: attached compiled_class.feature_of_feature_id (feature_id)
 			consistent_target_type: t.associated_class.class_id = c
 			consistent_deferred_status: compiled_class.is_deferred = d
 		do
 			create Result.make (result_type_in (t), t.type_id, feature_id, d, c)
 		end

 	poly_equiv (other: FEATURE_I): BOOLEAN
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

	instantiated (parent_type: TYPE_A): FEATURE_I
			-- Instantiated signature in context of `parent_type'.
		require
			good_argument: parent_type /= Void
		local
			i, nb: INTEGER
			old_type, new_type: TYPE_A
			l_arguments: like arguments
		do
			Result := Current
				-- Instantiation of the type
			old_type := type
			new_type := old_type.instantiated_in (parent_type)
			if new_type /= old_type then
				Result := twin
				Result.set_type (new_type, assigner_name_id)
			end
				-- Use `Current' arguments.
			l_arguments := arguments
				-- Instantiation of the arguments
			from
				i := 1
				if l_arguments /= Void then
					nb := l_arguments.count
				end
			until
				i > nb
			loop
				old_type := l_arguments.i_th (i)
				new_type := old_type.instantiated_in (parent_type)
				if old_type /= new_type then
					if Result.arguments = arguments then
						if Result = Current then
							Result := twin
						end
						Result.set_arguments (arguments.twin)
						l_arguments := Result.arguments
					end
					l_arguments.put_i_th (new_type, i)
				end
				i := i + 1
			end
		end

	instantiation_in (descendant_type: TYPE_A): FEATURE_I
			-- Instantiated signature in context of `descendant_type'.
		require
			good_argument: descendant_type /= Void
		local
			i, nb: INTEGER
			old_type, new_type: TYPE_A
			l_arguments: like arguments
			l_written_in: like written_in
		do
			Result := Current
			l_written_in := written_in
				-- Instantiation of the type
			old_type := type
			new_type := old_type.instantiation_in (descendant_type, l_written_in)
			if new_type /= old_type then
				Result := twin
				Result.set_type (new_type, assigner_name_id)
			end
			l_arguments := arguments

				-- Instantiation of the arguments
			from
				i := 1
				if l_arguments /= Void then
					nb := l_arguments.count
				end
			until
				i > nb
			loop
				old_type := l_arguments.i_th (i)
				new_type := old_type.instantiation_in (descendant_type, l_written_in)
				if new_type /= old_type then
					if Result.arguments = arguments then
						if Result = Current then
							Result := twin
						end
						Result.set_arguments (arguments.twin)
						l_arguments := Result.arguments
					end
					l_arguments.put_i_th (new_type, i)
				end
				i := i + 1
			end
		end

	result_type_in (t: CLASS_TYPE): TYPE_A
			-- Result type adapted to the target type `t`.
		local
			base_type: CL_TYPE_A
		do
			Result := type
			if Result.is_like_current then
					-- We need to instantiate `like Current' in the context of `class_type'
					-- to fix eweasel test#exec035.
					-- Associated actual type is always attached.
					-- Use the basic version of the class type if available.
				base_type := t.basic_type
				if not attached base_type then
						-- Otherwise, use the regular version of the class type.
					base_type := t.type
				end
				Result := Result.instantiated_in (base_type.as_attached_in (t.associated_class))
			end
		end

feature -- Signature checking

	check_argument_names (feat_table: FEATURE_TABLE)
			-- Check argument names
		require
			argument_names_exists: arguments.argument_names /= Void
			written_in_class: written_in = feat_table.feat_tbl_id or else is_replicated_directly
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
						-- Two arguments with the same name.
					create vreg
					vreg.set_class (written_class)
					vreg.set_feature (Current)
					vreg.set_entity_name (Names_heap.item (arg_id))
					if attached argument_ast (args.argument_position_id (arg_id, i + 1)) as location then
						vreg.set_location (location)
					end
					Error_handler.insert_error (vreg)
				end
				if feat_table.has_id (arg_id) then
						-- An argument name is a feature name of the feature table.
					create vrfa
					vrfa.set_class (written_class)
					vrfa.set_feature (Current)
					vrfa.set_other_feature (feat_table.found_item)
					if attached argument_ast (i) as location then
						vrfa.set_location (location)
					end
					Error_handler.insert_error (vrfa)
				end
				if context.is_name_used (arg_id) then
						-- An argument name is an argument name of an enclosing feature.
					create vpir
					vpir.set_entity_name (arg_id)
					vpir.set_class (written_class)
					vpir.set_feature (Current)
					if attached argument_ast (i) as location then
						vpir.set_location (location)
					end
					Error_handler.insert_error (vpir)
				end

				i := i + 1
			end
		end

	delayed_check_types (t: FEATURE_TABLE)
			-- Same as `check_types' except that if one type of the feature signature cannot be evaluated rigth now,
			-- the corresponding action is recorded for future evaluation.
		require
			t_attached: attached t
			is_context_initialized_for_t: context.current_class = t.associated_class
		do
			do_check_types (t, True)
			if is_type_evaluation_delayed then
				tmp_feature_server.delay (Current)
				degree_4.put_action (
					agent
						require
							is_context_initialized: attached system.current_class as sc and then attached sc.feature_table as sft and then context.current_class = sft.associated_class
						do
							if attached system.current_class as c and then attached c.feature_table as ft then
								check_types (ft)
							end
						end
				)
			end
		end

	nested_check_types (c: CLASS_C)
			--
		local
			old_current_class: CLASS_C
		do
			if is_type_evaluation_delayed and then not type_a_checker.is_delayed then
					-- Evaluate types now to get correct actual type (see test#valid284).
				old_current_class := context.current_class
				system.set_current_class (c)
				context.initialize (c, c.actual_type)
					-- Update feature type.
				check_types (c.feature_table)
					-- Restore context state.
				context.initialize (old_current_class, old_current_class.actual_type)
				system.set_current_class (old_current_class)
			end
		end

	check_types (feat_table: FEATURE_TABLE)
			-- Check type and arguments types. The objective is
			-- to deal with anchored types and genericity. All anchored
			-- types are interpreted here and generic parameter
			-- instantiated if possible.
			-- Make sure that `context' is already initialized for `feat_table' before calling.
		require
			feat_table_attached: attached feat_table
			is_context_initialized_for_feat_table:
				context.current_class = feat_table.associated_class
		do
			do_check_types (feat_table, False)
		end

	check_type_validity (a_context_class: CLASS_C)
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
					Current, a_context_class.feature_table, error_handler)
				if not l_type.is_void then
					type_a_checker.check_type_validity (l_type, Void)
				end
				if arguments /= Void then
						-- Check types of arguments
					arguments.check_type_validity (a_context_class, Current, type_a_checker, False)
				end
					-- If an attribute is transient, then we cannot accept it if it is a formal type,
					-- a user defined expanded or an attached type. The first and last restrictions
					-- are definitely a language restriction, the other is a limitation in our
					-- implementation at the runtime level.
				if
					is_transient and then (l_type.is_formal or l_type.is_true_expanded or
					(not l_type.is_expanded and l_type.is_attached))
				then
					error_handler.insert_error (create {VRVA}.make_invalid_type (Current, a_context_class, written_class, l_type))
				end
			end

				-- For an inherited attributem we make sure that it is not inherited in a user defined
				-- expanded class as our runtime would not cope properly with that (i.e. it needs all
				-- attributes, not just a subset).
			if is_transient and then (a_context_class.is_expanded and not a_context_class.is_basic) then
				error_handler.insert_error (create {VRVA}.make_invalid_context (Current, a_context_class, written_class))
			end
		end

	check_expanded (class_c: CLASS_C)
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
				solved_type := type.actual_type
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

	delayed_check_signature (old_feature: FEATURE_I; tbl: FEATURE_TABLE)
			-- Possibly delayed call to `check_signature'.
		require
			old_feature_attached: attached old_feature
			tbl_attached: attached tbl
		do
			if is_type_evaluation_delayed or else old_feature.is_type_evaluation_delayed then
				degree_4.put_action (
					agent (o: FEATURE_I; t: FEATURE_TABLE)
						do
							check_signature (o, t)
						end
					(old_feature, tbl)
				)
			else
				check_signature (old_feature, tbl)
			end
		end

	check_signature (old_feature: FEATURE_I; tbl: FEATURE_TABLE)
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

			old_type := old_feature.type.actual_argument_type (special_arguments).actual_type
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
			elseif not new_type.conform_to (current_class, old_type) then
				create vdrd51
				vdrd51.init (old_feature, Current)
				Error_handler.insert_error (vdrd51)
			elseif is_attribute and then new_type.is_expanded /= old_type.is_expanded then
				create ve02
				ve02.init (old_feature, Current)
				Error_handler.insert_error (ve02)
			end

				-- Check the argument count
			if argument_count = old_feature.argument_count then
					-- Check the argument conformance
				from
					i := 1
					arg_count := argument_count
					old_arguments := old_feature.arguments
				until
					i > arg_count
				loop
					old_type := old_arguments.i_th (i)
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
					elseif not new_type.conform_to (current_class, old_type) then
						create vdrd53
						vdrd53.init (old_feature, Current)
						Error_handler.insert_error (vdrd53)
					end

					i := i + 1
				end
			else
				create vdrd52
				vdrd52.init (old_feature, Current)
				Error_handler.insert_error (vdrd52)
			end
				-- Check aliases.
			if not is_same_alias (old_feature) then
					-- Report that aliases are not the same.
				Error_handler.insert_error (create {VDRD7_NEW}.make (system.current_class, Current, old_feature))
			end
				-- Check assigner procedure.
			if not is_same_assigner (old_feature, tbl) then
					-- Report that assigner commands are not the same.
				Error_handler.insert_error (create {VDRD8_NEW}.make (system.current_class, Current, old_feature))
			end
				-- Check type.
			if
				((attached old_type.conformance_type.base_class as b and then b.is_once) or else
				(attached new_type.conformance_type.base_class as b and then b.is_once)) and then
				not new_type.same_as (old_type)
			then
					-- Report that feature types are not the same.
				Error_handler.insert_error (create {VDRD9_NEW}.make (system.current_class, Current, old_feature))
			end
		end

	delayed_check_same_signature (old_feature: FEATURE_I; t: FEATURE_TABLE)
			-- Check that the signature of the current feature is the same as the signature of `old_feature'
			-- using the feature table `t'.
		require
			old_feature_attached: attached old_feature
			t_attached: attached t
		do
			if is_type_evaluation_delayed or else old_feature.is_type_evaluation_delayed then
				degree_4.put_action (
					agent (f: FEATURE_I; ft: FEATURE_TABLE)
						do
								-- Evaluate signature of the old feature in the context of the new feature table.
							f.solve_types (ft)
								-- Check same signature for different features.
							check_same_signature (f)
						end
					(old_feature, t)
				)
			else
					-- Evaluate signature of the old feature in the context of the new feature table.
				old_feature.solve_types (t)
					-- Check same signature for different features.
				check_same_signature (old_feature)
			end
		end

	check_same_signature (old_feature: FEATURE_I)
			-- Check signature equality beetween Current
			-- and inherited feature in `inherit_info' from which Current
			-- is a join.
		require
			good_argument: old_feature /= Void
			is_deferred
			old_feature.is_deferred
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
				-- i.e the class relative to `access_in'.
			old_type := old_feature.type
				-- `new_type' is the actual type of the join already
				-- instantiated
			new_type := type
			if not new_type.is_safe_equivalent (old_type) then
				create vdjr1
				vdjr1.init (old_feature, Current)
				vdjr1.set_type (new_type)
				vdjr1.set_old_type (old_type)
				Error_handler.insert_error (vdjr1)
			end

				-- Check the argument count
			if argument_count = old_feature.argument_count then
					-- Check the argument equality
				from
					i := 1
					arg_count := argument_count
					old_arguments := old_feature.arguments
				until
					i > arg_count
				loop
					old_type := old_arguments.i_th (i)
					new_type := arguments.i_th (i)
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
			else
				create vdjr
				vdjr.init (old_feature, Current)
				Error_handler.insert_error (vdjr)
			end
				-- Check aliases
			if not is_same_alias (old_feature) then
					-- Report that aliases are not the same
				Error_handler.insert_error (create {VDJR2_NEW}.make (system.current_class, Current, old_feature))
			end
		end

	special_arguments: ARRAYED_LIST [TYPE_A]
		local
			i, nb: INTEGER
		do
			from
				fixme ("we should resolve argument types early on in `init_arg' from PROCEDURE_I")
				nb := argument_count
				create Result.make (nb)
				i := 1
				nb := nb + 1
			until
				i = nb
			loop
				Result.extend (arguments.i_th (i).actual_type)
				i := i + 1
			end
		end

	has_same_il_signature (a_parent_type, a_written_type: CL_TYPE_A; old_feature: FEATURE_I): BOOLEAN
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
			old_type := old_feature.type
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
				old_type := old_arguments.i_th (i)
				old_type := old_type.actual_argument_type (special_arguments).
					instantiation_in (a_written_type, a_written_type.class_id).actual_type

				new_type := arguments.i_th (i).actual_type
					-- Check exact match of signature for IL generation.
				Result := Result and then old_type.same_as (new_type)

				i := i + 1
			end
		end

	solve_types (feat_tbl: FEATURE_TABLE)
			-- Evaluates signature types in context of `feat_tbl'.
			-- | Take care of possible anchored types
		local
			l_solved_type: TYPE_A
			l_area: SPECIAL [TYPE_A]
			i, nb: INTEGER
		do
			type_a_checker.init_with_feature_table (Current, feat_tbl, error_handler)
			l_solved_type := type_a_checker.check_and_solved (type, Void)
			check l_solved_type_not_void: l_solved_type /= Void end
			set_type (l_solved_type, assigner_name_id)
			if attached arguments as a then
				from
					l_area := a.area
					nb := a.count
				until
					i = nb
				loop
					l_solved_type := type_a_checker.check_and_solved (l_area [i], Void)
					check l_solved_type_not_void: l_solved_type /= Void end
					l_area.put (l_solved_type, i)
					i := i + 1
				end
			end
		end

	same_signature (other: FEATURE_I): BOOLEAN
			-- Has `other' same signature than Current ?
		require
			good_argument: other /= Void
			same_feature_names: feature_name_id = other.feature_name_id
		local
			i, nb: INTEGER
		do
			if type.is_safe_equivalent (other.type) then
				from
					nb := argument_count
					Result := nb = other.argument_count
					i := 1
				until
					i > nb or else not Result
				loop
					Result := arguments.i_th (i).is_safe_equivalent (other.arguments.i_th (i))
					i := i + 1
				end
			end
		end

	argument_position (arg_id: INTEGER): INTEGER
			-- Position of argument `arg_id' in list of arguments
			-- of current feature. 0 if none or not found.
		require
			arg_id_not_void: arg_id >= 0
		do
			if arguments /= Void then
				Result := arguments.argument_position_id (arg_id, 1)
			end
		end

	has_argument_name (arg_id: INTEGER): BOOLEAN
			-- Has current feature an argument named `arg_id" ?
		require
			arg_id_positive: arg_id > 0
		do
			if arguments /= Void then
				Result := arguments.argument_position_id (arg_id, 1) /= 0
			end
		end

	property_setter_in (class_type: CLASS_TYPE): FEATURE_I
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

	ancestor_property_setter_in (c: CLASS_C): FEATURE_I
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

	delayed_check_assigner (feature_table: FEATURE_TABLE)
			-- Possibly delayed call to `check_assigner'.
		require
			feature_table_attached: attached feature_table
			has_assigner: assigner_name_id /= 0
		local
			assigner: FEATURE_I
		do
			if feature_table.feat_tbl_id = written_in then
				assigner := feature_table.item_id (assigner_name_id)
			elseif attached written_class.feature_of_name_id (assigner_name_id) as a then
				assigner := feature_table.feature_of_rout_id (a.rout_id_set.first)
			end
			if attached assigner and then (is_type_evaluation_delayed or else assigner.is_type_evaluation_delayed) then
				degree_4.put_action (agent check_assigner (feature_table))
			else
				check_assigner (feature_table)
			end
		end

	check_assigner (feature_table: FEATURE_TABLE)
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
			if feature_table.feat_tbl_id = written_in then
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
			elseif
					-- Types may be differ for stable queries in their attachment status, so that an argument type is assignable to a query type.
				(is_stable and then
				not (assigner.arguments.first.actual_type.as_attachment_mark_free.same_as
					(type.actual_type.as_attachment_mark_free) and then
					assigner.arguments.first.actual_type.conform_to (system.current_class, type.actual_type))) or else
					-- Types should be the same for non-stable queries.
				(not is_stable and then
				not assigner.arguments.first.actual_type.is_safe_equivalent (type.actual_type))
			then
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

feature {NONE} -- Signature checking

	do_check_types (feat_table: FEATURE_TABLE; is_delayed: BOOLEAN)
			-- Check type and arguments types. The objective is
			-- to deal with anchored types and genericity. All anchored
			-- types are interpreted here and generic parameter
			-- instantiated if possible. `is_delayed' tells if type
			-- checking may be delayed because not all feature tables
			-- are computed.
			-- Make sure that `context' is already initialized for `feat_table' before calling.
		require
			feat_table_attached: attached feat_table
			is_context_initialized_for_feat_table:
				context.current_class = feat_table.associated_class
		local
			vffd5: VFFD5
			vffd6: VFFD6
			vffd7: VFFD7
			l_class: CLASS_C
			l_error_level: NATURAL_32
			is_immediate: BOOLEAN
			l_area: SPECIAL [TYPE_A]
			nb, i: INTEGER
		do
			l_class := feat_table.associated_class
			context.set_current_feature (Current)
				-- Process an actual type for the feature interpret
				-- anchored types.
			type_a_checker.init_with_feature_table (Current, feat_table, error_handler)
			type_a_checker.set_is_delayed (is_delayed)
			set_is_type_evaluation_delayed (False)

			l_error_level := error_handler.error_level
			if attached type_a_checker.check_and_solved (type, Void) as solved_type then
				set_type (solved_type, assigner_name_id)
					-- Instantitate the feature type in the context of the
					-- actual type of the class associated to `feat_table'.

				if
					(is_once and then not is_object_relative_once and not is_constant) and then
					not solved_type.is_standalone
				then
						-- A (non-object-relative) once function cannot have a type with formal generics
						-- and/or (flexible) anchors.
					create vffd7
					vffd7.set_class (written_class)
					vffd7.set_feature_name (feature_name)
					Error_handler.insert_error (vffd7)
				end

				if is_once and then system.is_scoop and then is_process_relative and then not solved_type.is_void and then not solved_type.is_separate and then not solved_type.is_expanded then
					Error_handler.insert_error (create {VFFD8}.make (Current))
				end

				if
					is_infix and then
					((argument_count /= 1) or else (solved_type.is_void))
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
					((argument_count /= 0) or else (solved_type.is_void))
				then
						-- Prefixed features shouldn't have any argument
						-- and must have a return type.
					create vffd5
					vffd5.set_class (written_class)
					vffd5.set_feature_name (feature_name)
					Error_handler.insert_error (vffd5)
				end

				if l_class.class_id = written_in then
					is_immediate := True
					type_a_checker.check_type_validity (solved_type, Void)
					solved_type.check_for_obsolete_class (l_class, Current)
				end
			elseif is_delayed then
				set_is_type_evaluation_delayed (l_error_level = error_handler.error_level)
			end
			if attached arguments as a then
					-- Check types of arguments.
				from
					l_area := a.area
					nb := a.count
				until
					i = nb
				loop
						-- Process type of an argument.
					l_error_level := error_handler.error_level
					if attached type_a_checker.check_and_solved (l_area.item (i), Void) as t then
						l_area.put (t, i)
						if is_immediate then
							type_a_checker.check_type_validity (t, Void)
							t.check_for_obsolete_class (l_class, Current)
						end
					elseif is_delayed then
						set_is_type_evaluation_delayed (l_error_level = error_handler.error_level)
					end
					i := i + 1
				end
			end
		end

feature {NONE} -- AST evaluation

	argument_ast (n: INTEGER): detachable LEAF_AS
			-- AST node of an argument of number `n` if available, `Void` otherwise.
		do
			if
				attached match_list_server.item (written_in) as match_list and then
				attached real_body as body_ast and then
				attached body_ast.argument_index (n) as argument_index and then
				match_list.valid_index (argument_index)
			then
				Result := match_list [argument_index]
			end
		end

feature -- Undefinition

	new_deferred_anchor: DEF_PROC_I
			-- Type anchor for `new_deferred'.
		do
			check False then
			end
		ensure
			used: False -- This feature is used only as an anchor.
		end

	new_deferred: like new_deferred_anchor
			-- New deferred feature for undefinition.
		require
			not is_deferred
			redefinable
		do
			create Result
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
			Result.set_feature_name_id (feature_name_id, alias_name_ids)
			Result.set_feature_id (feature_id)
			Result.set_pattern_id (pattern_id)
			Result.set_is_require_else (is_require_else)
			Result.set_is_ensure_then (is_ensure_then)
			Result.set_export_status (export_status)
			Result.set_body_index (body_index)
			Result.set_has_precondition (has_precondition)
			Result.set_has_postcondition (has_postcondition)
			Result.set_has_immediate_class_postcondition (has_immediate_class_postcondition)
			Result.set_has_false_postcondition (has_false_postcondition)
			Result.set_has_immediate_non_object_call (has_immediate_non_object_call)
			Result.set_has_immediate_non_object_call_in_assertion (has_immediate_non_object_call_in_assertion)
			Result.set_has_immediate_unqualified_call_in_assertion (has_immediate_unqualified_call_in_assertion)
			Result.set_is_bracket (is_bracket)
			Result.set_is_parentheses (is_parentheses)
			Result.set_is_binary (is_binary)
			Result.set_is_unary (is_unary)
			Result.set_has_convert_mark (has_convert_mark)
			Result.set_has_rescue_clause (has_rescue_clause)
			Result.set_is_type_evaluation_delayed (is_type_evaluation_delayed)
			Result.set_has_replicated_ast (has_replicated_ast)
			Result.set_is_ghost (is_ghost)
		ensure
			Result_exists: Result /= Void
			Result_is_deferred: Result.is_deferred
		end

	new_rout_id: INTEGER
			-- New routine id
		do
			Result := Routine_id_counter.next_rout_id
		end

	Routine_id_counter: ROUTINE_COUNTER
			-- Routine id counter
		once
			Result := System.routine_id_counter
		end

feature -- Replication

	code_id: INTEGER
			-- Code id for inheritance analysis
		do
			Result := body_index
		end

	set_code_id (i: INTEGER)
			-- Assign `i' to code_id.
		do
			-- Do nothing
		end

	set_access_in (i: INTEGER_32)
			-- Assign `i' to access_in
		do
			-- Do nothing
		end

	access_in: INTEGER
			-- Id of class where current feature can be accessed
			-- through its routine id
			-- Useful for replication
		do
			Result := written_in
		end

	replicated (in: INTEGER): FEATURE_I
			-- Replicated feature
		require
			in_not_void: in /= 0
		deferred
		ensure
			Result_exists: Result /= Void
			access_in_set: Result.access_in = in
		end

	new_code_id: INTEGER
			-- New code id
		do
			Result := System.body_index_counter.next_id
		end

	selected: FEATURE_I
			-- Selected feature (used for duplicating inherited features by resetting replication and selection status
		require
			do_not_use_yet: False
		deferred
		ensure
			Result_exists: Result /= Void
			equivalent: Result.equiv (Current)
		end

	unselected (in: INTEGER): FEATURE_I
			-- Unselected feature
		require
			in_not_void: in /= 0
		deferred
		ensure
			Result_exists: Result /= Void
		end

	is_unselected: BOOLEAN
			-- Is current feature an unselected one ?
		do
			-- Do nothing
		end

	transfer_to (other: FEATURE_I)
			-- Transfer of datas from Current into `other'.
		require
			other_exists: other /= Void
		do
			other.set_export_status (export_status)
			other.set_feature_id (feature_id)
			other.set_feature_name_id (feature_name_id, alias_name_ids)
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
			other.set_is_parentheses (is_parentheses)
			other.set_is_binary (is_binary)
			other.set_is_unary (is_unary)
			other.set_has_convert_mark (has_convert_mark)
			other.set_has_replicated_ast (has_replicated_ast)
			other.set_is_stable (is_stable)
			other.set_has_immediate_class_postcondition (has_immediate_class_postcondition)
			other.set_has_immediate_non_object_call (has_immediate_non_object_call)
			other.set_has_immediate_non_object_call_in_assertion (has_immediate_non_object_call_in_assertion)
			other.set_has_immediate_unqualified_call_in_assertion (has_immediate_unqualified_call_in_assertion)
			other.set_is_hidden_in_debugger_call_stack (is_hidden_in_debugger_call_stack)
			other.set_body_index (body_index)
			other.set_is_type_evaluation_delayed (is_type_evaluation_delayed)
			other.set_is_ghost (is_ghost)
		end

	transfer_from (other: FEATURE_I)
			-- Transfer of datas from `other' into `Current'.
		require
			do_not_call: False
				-- Feature not ready yet.
			other_exists: other /= Void
		do
				-- `export_status' needs to be set via `set_export_status'
			set_export_status (other.export_status)

			--feature_id := other.feature_id
			feature_name_id := other.feature_name_id
			alias_name_ids := other.alias_name_ids
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

	delayed_update_instantiator2 (a_class: CLASS_C)
			-- Possibly delayed call to `update_instantiator2' depending on the feature signature.
		require
			good_argument: a_class /= Void
			good_context: a_class.changed
		do
			if is_type_evaluation_delayed then
				degree_4.put_action (agent update_instantiator2 (a_class))
			else
				update_instantiator2 (a_class)
			end
		end

	update_instantiator2 (a_class: CLASS_C)
			-- Look for generic/expanded types in result and arguments in order
			-- to update instantiator.
		require
			good_argument: a_class /= Void
			good_context: a_class.changed
		local
			i, arg_count: INTEGER
		do
			Instantiator.dispatch (type, a_class)
			from
				i := 1
				arg_count := argument_count
			until
				i > arg_count
			loop
				Instantiator.dispatch (arguments.i_th (i), a_class)
				i := i + 1
			end
		end

feature -- Pattern

	frozen pattern: PATTERN
			-- Feature pattern
		do
			if argument_count > 0 then
				create Result.make (type.meta_type, arguments.pattern_types)
			else
				create Result.make (type.meta_type, Void)
			end
		end

	delayed_process_pattern
			-- Process pattern of Current feature, possibly with a delay if its signature cannot be computed yet.
		do
			if is_type_evaluation_delayed then
				degree_4.put_action (agent process_pattern)
			else
				process_pattern
			end
		end

	process_pattern
			-- Process pattern of Current feature.
		local
			p: PATTERN_TABLE
		do
			p := Pattern_table
			p.insert_pattern_from_feature_i (Current)
			pattern_id := p.last_pattern_id
		end

feature -- Dead code removal

	used: BOOLEAN
			-- Is feature used ?
		do
				-- In final mode dead code removal process is on.
				-- In workbench mode all features are considered used.
			Result := byte_context.workbench_mode or else System.is_used (Current)
		end

feature -- Byte code access

	frozen access (access_type: TYPE_A; is_qualified: BOOLEAN; is_separate: BOOLEAN): ACCESS_B
			-- Byte code access for current feature
		require
			access_type_not_void: access_type /= Void
		do
			Result := access_for_feature (access_type, Void, is_qualified, is_separate, False)
		ensure
			Result_exists: Result /= Void
		end

	frozen access_for_multi_constraint (access_type: TYPE_A; a_static_type: TYPE_A; is_qualified: BOOLEAN; is_separate: BOOLEAN): ACCESS_B
			-- Creates a byte code access for a multi constraint target.
			-- `a_static_type' is the type where the feature is from.
			-- It is NOT a static call that will be generated, but a dynamic one. It is only needed for W_bench.
		require
			access_type_not_void: access_type /= Void
		do
			Result := access (access_type, is_qualified, is_separate)
			check Result /= Void end
			Result.set_multi_constraint_static (a_static_type)
		ensure
			Result_exists: Result /= Void
		end

	access_for_feature (access_type: TYPE_A; static_type: TYPE_A; is_qualified: BOOLEAN; is_separate: BOOLEAN; is_free: BOOLEAN): ACCESS_B
			-- Byte code access for current feature. Dynamic binding if
			-- `static_type' is Void, otherwise static binding on `static_type'.
			-- • `is_free` – Is it a non-object call?
		require
			access_type_not_void: access_type /= Void
			-- is_separate_meaningful: is_separate implies (is_qualified or is_creation) -- Creation calls are not marked as qualified.
			valid_is_instance_free_call: is_free implies (is_class or else system.absent_explicit_assertion)
		local
			is_in_op: BOOLEAN
			l_type: TYPE_A
		do
			if is_qualified then
					-- To fix eweasel test#term155 we remove all anchors from
					-- calls after the first dot in a call chain.
				l_type := access_type.context_free_type
			else
				l_type := access_type
			end
			is_in_op := written_in = System.function_class_id or else
						written_in = System.predicate_class_id or else
						written_in = System.procedure_class_id

			if is_in_op and then not is_separate then
				if feature_name_id = {PREDEFINED_NAMES}.call_name_id then
					create {AGENT_CALL_B} Result.make (Current, l_type, static_type, False)
				elseif feature_name_id = {PREDEFINED_NAMES}.item_name_id then
					create {AGENT_CALL_B} Result.make (Current, l_type, static_type, True)
				end
			end

			if Result = Void then
				if written_in = System.any_id then
						-- Feature written in ANY.
					create {ANY_FEATURE_B} Result.make (Current, l_type, static_type, is_free)
				else
					create {FEATURE_B} Result.make (Current, l_type, static_type, is_free)
				end
			end
		ensure
			Result_exists: Result /= Void
		end

	direct_access_for_feature (access_type: TYPE_A; static_type: TYPE_A; is_qualified: BOOLEAN; is_separate: BOOLEAN; is_free: BOOLEAN): ACCESS_B
			-- Byte code access for this feature that is known to be called without any wrappers.
			-- Dynamic binding if `static_type` is Void, otherwise static binding on `static_type`.
			-- • `is_free` – Is it a non-object call?
			-- See also: `access_for_feature`.
		do
			Result := access_for_feature (access_type, static_type, is_qualified, is_separate, is_free)
		end

feature {NONE} -- log file

	add_in_log (class_type: CLASS_TYPE; encoded_name: STRING)
		do
			System.used_features_log_file.add (class_type, feature_name, encoded_name)
		end

feature -- C code generation

	generate (class_type: CLASS_TYPE; buffer, header_buffer: GENERATION_BUFFER)
			-- Generate feature written in `class_type' in `buffer'.
		require
			valid_buffer: buffer /= Void
			header_buffer_attached: header_buffer /= Void
			written_in_type: class_type.associated_class.class_id = generation_class_id or is_replicated
			not_deferred: not is_deferred
		local
			l_byte_code: BYTE_CODE
			tmp_body_index: INTEGER
			l_byte_context: like byte_context
		do
			if used then
				tmp_body_index := body_index
				l_byte_code := tmp_opt_byte_server.disk_item (tmp_body_index)
				if l_byte_code = Void then
					l_byte_code := byte_server.disk_item (tmp_body_index)
				end

				prepare_object_relative_once (l_byte_code)

					-- `generate' from BYTE_CODE will log the feature name
					-- and encoded name in `used_features_log_file' from SYSTEM_I
				generate_header (class_type, buffer)


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
				l_byte_code.set_real_body_id (real_body_index (class_type))
				l_byte_code.generate
				l_byte_context.clear_feature_data
			else
				System.removed_log_file.add (class_type, feature_name)
			end
		end

	generate_header (a_type: CLASS_TYPE; buffer: GENERATION_BUFFER)
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

feature -- Object relative once

	prepare_object_relative_once (a_byte_code: BYTE_CODE)
			-- Prepare byte_code for object relative once if needed
		require
			a_byte_code_attached: a_byte_code /= Void
		do
		end

feature -- Debug purpose

	trace
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

	is_debuggable: BOOLEAN
		local
			wc: CLASS_C
		do
			if
				not is_external
				and then not is_attribute
				and then not is_constant
				and then not is_deferred
				and then not is_unique
			then
				wc := written_class
				Result := not wc.is_basic
					and then wc.has_types
			end
		end

	real_body_index (class_type: CLASS_TYPE): INTEGER
			-- Real body id at compilation time for `class_type'.
			-- This id might be obsolete after supermelting this feature.
			--| In latter case, new real body index is kept
			--| in DEBUGGABLE objects.
		do
			Result := execution_table.real_body_index (body_index, class_type)
		end

	real_pattern_id (class_type: CLASS_TYPE): INTEGER
			-- Real pattern id at compilation time for `class_type'.
			-- This id might be obsolete after supermelting this feature.
			--| In latter case, new real body id is kept
			--| in DEBUGGABLE objects.
		do
			Result := execution_table.real_pattern_id (body_index, class_type)
		end

feature -- Api creation

	e_feature: E_FEATURE
		do
			Result := api_feature (written_in)
		end

	api_feature (a_class_id: INTEGER): E_FEATURE
			-- API representation of Current
		require
			a_class_id_positive: a_class_id > 0
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
			Result.set_ghost (is_ghost)
			if is_inline_agent then
				if attached {E_ROUTINE} Result as r then
					r.set_enclosing_body_id (enclosing_body_id)
					r.set_inline_agent_nr (inline_agent_nr)
				else
					check
						correct_result: False
					end
				end
			end
		end

feature {FEATURE_I} -- Feature flags

	is_frozen_mask: NATURAL_64 =					0x0000_0001
	is_origin_mask: NATURAL_64 =					0x0000_0002
	is_empty_mask: NATURAL_64 =						0x0000_0004
	is_infix_mask: NATURAL_64 =						0x0000_0008
	is_prefix_mask: NATURAL_64 =					0x0000_0010
	is_require_else_mask: NATURAL_64 =				0x0000_0020
	is_ensure_then_mask: NATURAL_64 =				0x0000_0040
	has_precondition_mask: NATURAL_64 =				0x0000_0080
	has_postcondition_mask: NATURAL_64 =			0x0000_0100
	is_bracket_mask: NATURAL_64 =					0x0000_0200
	is_binary_mask: NATURAL_64 =					0x0000_0400
	is_unary_mask: NATURAL_64 =						0x0000_0800
	has_convert_mark_mask: NATURAL_64 =				0x0000_1000
	has_property_mask: NATURAL_64 =					0x0000_2000
	has_property_getter_mask: NATURAL_64 =			0x0000_4000
	has_property_setter_mask: NATURAL_64 =			0x0000_8000
	is_fake_inline_agent_mask: NATURAL_64 =			0x0001_0000
	has_rescue_clause_mask: NATURAL_64 =			0x0002_0000
	is_export_status_none_mask: NATURAL_64 =		0x0004_0000
	has_function_origin_mask: NATURAL_64 =			0x0008_0000 -- Used in ATTRIBUTE_I
	has_replicated_ast_mask: NATURAL_64 =			0x0010_0000
	has_body_mask: NATURAL_64 =						0x0020_0000 -- Used in ATTRIBUTE_I
	is_replicated_directly_mask: NATURAL_64 = 		0x0040_0000
	from_non_conforming_parent_mask: NATURAL_64 = 	0x0080_0000
	is_selected_mask: NATURAL_64 = 					0x0100_0000
	is_stable_mask: NATURAL_64 = 					0x0200_0000 -- Used in ATTRIBUTE_I
	is_transient_mask: NATURAL_64 = 				0x0400_0000 -- Used in ATTRIBUTE_I
	is_hidden_mask: NATURAL_64 = 					0x0800_0000 -- Used in ATTRIBUTE_I
	is_type_evaluation_delayed_mask: NATURAL_64 =	0x1000_0000
	has_false_postcondition_mask: NATURAL_64 =      0x2000_0000
	is_hidden_in_debugger_call_stack_mask: NATURAL_64 = 0x4000_0000
	is_parentheses_mask: NATURAL_64 =					0x8000_0000
	has_class_postcondition_mask: NATURAL_64 =				0x0001_0000_0000
	has_non_object_call_mask: NATURAL_64 =				0x0002_0000_0000
	has_non_object_call_in_assertion_mask: NATURAL_64 =				0x0004_0000_0000
	has_unqualified_call_in_assertion_mask: NATURAL_64 =				0x0008_0000_0000
	is_ghost_mask: NATURAL_64 =				0x0010_0000_0000
	is_immediate_export_status_none_mask: NATURAL_64 = 0x0020_0000_0000
	is_immediate_export_status_all_mask: NATURAL_64 = 0x0040_0000_0000
			-- Mask used for each feature property.

feature {FEATURE_I} -- Implementation

	feature_flags: NATURAL_64
			-- Property of Current feature, i.e. frozen,
			-- infix, origin, prefix, selected...

	new_api_feature: E_FEATURE
			-- API feature creation
		deferred
		ensure
			non_void_result: Result /= Void
		end

	internal_export_status: like export_status
			-- Internal export status object. When it is ANY or NONE
			-- it is Void to save some space, what help us distinguish
			-- is the `is_export_status_none_mask'.

	export_all_status: EXPORT_ALL_I
		once
			create Result
		ensure
			export_all_status_not_void: Result /= Void
		end

	export_none_status: EXPORT_NONE_I
		once
			create Result
		ensure
			export_none_status_not_void: Result /= Void
		end

feature {INHERIT_TABLE, FEATURE_I} -- Access

	private_external_name_id: INTEGER
			-- External name id of feature if any in IL generation.

	private_external_name: STRING
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

	debug_output: STRING
			-- Textual representation of current feature for debugging.
		do
			Result := feature_name
			if Result = Void then
				Result := "Name not yet assigned"
			end
		end

invariant
	valid_enclosing_feature: is_inline_agent implies enclosing_body_id > 0
	valid_inline_agent_nr: is_inline_agent implies inline_agent_nr > 0 or is_fake_inline_agent

note
	ca_ignore:
		"CA033", "CA033: very long class",
		"CA082", "CA082: missing redeclaration of `is_equal`"
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
