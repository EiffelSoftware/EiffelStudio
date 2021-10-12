note
	description: "Context for third pass"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_CONTEXT

inherit
	ANY

	SHARED_SERVER
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create instance of AST_CONTEXT.	
		do
			create inline_agent_counter
			create hidden_local_counter
			create_local_containers
			create attributes.make (0)
		end

	create_local_containers
			-- Create containers to keep information about locals, scopes
			-- and other data within a feature.
		do
			create locals.make (10)
			create supplier_ids.make
			create scopes.make (0)
			create inline_scopes.make (0)
			create {HASH_TABLE_EX [LOCAL_INFO, ID_AS]} inline_locals.make_with_key_tester (0, create {REFERENCE_EQUALITY_TESTER [ID_AS]})
		end

feature -- Access

	current_class: CLASS_C
			-- Current analyzed class.

	current_class_type: LIKE_CURRENT
			-- Actual type of `current_class'.

	written_class: CLASS_C
			-- Class where the code is originally written.
			-- (Used for checking inherited code in current context.)

	iterable_class: CLASS_C
			-- Class ITERABLE used to process Loop Iteration part.

	iteration_cursor_class: CLASS_C
			-- Class ITERATION_CURSOR used to process Loop Iteration part.

	current_feature: FEATURE_I
			-- Current analyzed feature.

	locals: HASH_TABLE [LOCAL_INFO, INTEGER]
			-- Current local variables of the analyzed feature.

	supplier_ids: FEATURE_DEPENDANCE
			-- Supplier units.

	hidden_local_counter: COUNTER
			-- Counter for managing hidden locals needed for object test where user does not specify
			-- a local.

	inline_agents: ARRAY [TUPLE [f: FEATURE_I; ast: INLINE_AGENT_CREATION_AS]]
			-- Inline agents with their feature descriptors corresponding to their AST for the current FEATURE_AS.

	inline_agent (a: INLINE_AGENT_CREATION_AS): FEATURE_I
			-- Feature descriptor, associated with the given AST `a'.
		require
			a_attached: a /= Void
		local
			i: INTEGER
		do
			if inline_agents /= Void then
				from
					i := inline_agents.count
				until
					i <= 0 or else inline_agents [i].ast = a
				loop
					i := i - 1
				end
			end
			if i > 0 then
				Result := inline_agents [i].f
			end
		end

	inline_agent_counter: COUNTER
			-- Counter for managing the inline agents that are enclosed in the current feature.

	current_inline_agent_body: BODY_AS
			-- Body of the current processec inline agent. Is only valid if the current feature is an inline agent.

	old_inline_agents: HASH_TABLE [FEATURE_I, INTEGER]
			-- If the processed feature was already present, this table gives a mapping from
			-- original inline_agent_nr to its features.
		do
			if old_inline_agents_int = Void then
				create old_inline_agents_int.make (0)
			end
			Result := old_inline_agents_int
		ensure
			Result /= Void
		end

	used_argument_names: SEARCH_TABLE [INTEGER]
			-- Argument names that are already used by enclosing features.

	used_local_names: SEARCH_TABLE [INTEGER]
			-- Local names that are already used by enclosing features.

	set_used_argument_names (table: like used_argument_names)
			-- Set the used argument names.
		do
			used_argument_names := table
		end

	set_used_local_names (table: like used_local_names)
			-- Set the used local names.
		do
			used_local_names := table
		end

	is_name_used (id: INTEGER_32): BOOLEAN
			-- Is the name with id `id' already used in an enclosing feature?
		do
			if used_argument_names /= Void then
				Result := used_argument_names.has (id)
			end
			if not Result and then used_local_names /= Void then
				Result := used_local_names.has (id)
			end
			if not Result then
				Result := scopes.has (id)
			end
		end

feature -- Modification

	put_inline_agent (f: FEATURE_I; a: INLINE_AGENT_CREATION_AS)
			-- Store feature descriptor `f' for an inline agent `a'.
		require
			f_attached: f /= Void
			a_attached: a /= Void
		local
			i: INTEGER
		do
				-- Check that the given AST has no feature descriptor yet.
			if inline_agents /= Void then
				from
					i := inline_agents.count
				until
					i <= 0 or else inline_agents [i].ast = a
				loop
					i := i - 1
				end
			else
				create inline_agents.make_empty
			end

			if i = 0 then
					-- AST `a' is not yet registered.
					-- Register it now.
				inline_agents.force ([f, a], inline_agents.count + 1)
			end
		end

feature {NONE} -- Local scopes

	inline_locals: HASH_TABLE [LOCAL_INFO, ID_AS]
			-- Types of object-test locals indexes by their name id.

	result_id: INTEGER_32 = 0x7fffffff
			-- Name ID that is used for the special entity "Result".

feature {AST_FEATURE_CHECKER_GENERATOR, SHARED_AST_CONTEXT} -- Local scopes

	next_inline_local_position: INTEGER
			-- Position of a next inline local.
		do
			Result := inline_locals.count + 1
		end

	add_inline_local (l: LOCAL_INFO; id: ID_AS)
			-- Add a new inline local with type information `l` for a name `id`.
		require
			l_attached: l /= Void
			id_attached: id /= Void
		do
			inline_locals.force (l, id)
		end

	inline_local (id: INTEGER_32): detachable LOCAL_INFO
			-- Information about an inline (object-test, cursor, separate) local of name `id'
			-- if such a local is currently in scope or `Void' otherwise.
		local
			i: like inline_scopes_bound
			m: like inline_scopes_bound
		do
				-- Look for an entry with name ID `id` in currently valid `inline_locals`.
			from
				i := inline_scopes.count
				m := inline_scopes_bound
			until
				i <= m or else inline_scopes [i].name_id = id
			loop
				i := i - 1
			variant
				i
			end
				-- Test if the entry is found.
			if i > m then
					-- Retrieve information about found inline local.
				Result := inline_locals.item (inline_scopes [i])
			end
		end

	unchecked_inline_local (id: ID_AS): detachable LOCAL_INFO
			-- Information about inline local of name `id' (if any) regardless of current scope.
		require
			id_attached: id /= Void
		do
			Result := inline_locals.item (id)
		end

feature {AST_FEATURE_CHECKER_GENERATOR, AST_CONTEXT} -- Local scopes: status report

	is_readonly_attached (id: INTEGER_32): BOOLEAN
			-- Is a read-only entity `id` in the scope where it is considered attached?
		do
			Result := scopes.has (id)
		end

	is_local_attached (id: INTEGER_32): BOOLEAN
			-- Is local `id' in the scope where it is considered attached?
		do
			Result :=
				local_scope.is_local_attached (locals.item (id).position) or else
				scopes.has (id)
		end

	is_result_attached: BOOLEAN
			-- Is special entity "Result" in the scope where it is considered attached?
		do
			Result :=
				local_scope.is_result_attached or else
				scopes.has (result_id)
		end

	is_attribute_attached (id: INTEGER_32): BOOLEAN
			-- Is attribute `id' in the scope where it is considered attached?
		local
			p: INTEGER_32
		do
			Result := scopes.has (id)
			if not Result then
				if attached current_class.feature_of_name_id (id) as f then
					p := attributes.item (f.feature_id)
					if p > 0 then
						Result := attribute_initialization.is_attribute_set (p)
					end
				end
			end
		end

feature {AST_CONTEXT} -- Local scopes

	scopes: ARRAYED_LIST [INTEGER_32]
			-- Currently active scopes identified by entity name ID.
			-- If an entity is registered, it is known to be attached.
			-- The scopes do not reflect the validity of the entity, only its attachment status.
			-- See also: `inline_scopes`.

	scope_count: INTEGER
			-- Number of active `scopes`.
		do
			Result := scopes.count
		end

	inline_scopes: ARRAYED_LIST [ID_AS]
			-- Current potentially valid scopes of inline locals.
			-- The valid entries have indexes in the set (`inline_scopes_bound` .. `inline_scopes.upper`],
			-- i.e. `inline_scopes_bound` is excluded.

	inline_scopes_bound: like inline_scopes.lower
			-- The index above which elements of `inline_scopes` are considered valid.

feature {AST_CREATION_PROCEDURE_CHECKER, AST_FEATURE_CHECKER_GENERATOR, AST_CONTEXT, AST_SCOPE_COMBINED_PRECONDITION} -- Attribute positions

	attributes: HASH_TABLE [INTEGER_32, INTEGER_32]
			-- Attribute indecies indexed by their feature ID.

	attribute_initialization: AST_ATTRIBUTE_INITIALIZATION_TRACKER
			-- Tracker of initialized stable attributes.

feature {NONE} -- Scope components

	object_test_count_shift: INTEGER_32 = 32
			-- Number of bits to shift `inline_scopes.count` in `scope`.

	scope_count_mask: NATURAL_64 = 0xFFFF_FFFF
			-- Mask for `scope_count` in `scope`.

feature {AST_FEATURE_CHECKER_GENERATOR, AST_CONTEXT} -- Scope state

	scope: NATURAL_64
			-- Current scope ID.
		do
				-- For simplicity the current number of local scopes and object test scopes is used.
			Result := scope_count.as_natural_64 ⦶ (inline_scopes.count.as_natural_64 ⧀ object_test_count_shift)
		end

	set_scope (s: like scope)
			-- Reset `scope` to the previously recorded scope ID `s`.
		require
			valid_s: s <= scope
		local
			i: like scope_count
		do
			from
				i := scopes.count - (s ⊗ scope_count_mask).as_integer_32
				scopes.finish
			until
				i <= 0
			loop
				scopes.remove
				scopes.back
				i := i - 1
			end
			from
				i := inline_scopes.count - (s ⧁ object_test_count_shift).as_integer_32
				inline_scopes.finish
			until
				i <= 0
			loop
				inline_scopes.remove
				inline_scopes.back
				i := i - 1
			end
		ensure
			scope_set: scope = s
		end

	init_local_scopes
			-- Prepare structures to track local scopes.
		require
			locals_attached: locals /= Void
		do
			create local_initialization.make (locals.count)
			create local_scope.make (locals.count)
		ensure
			local_initialization_attached: local_initialization /= Void
			local_initialization_initialized: local_initialization.local_count = locals.count
			local_scope_attached: local_scope /= Void
			local_scope_initialized: local_scope.local_count = locals.count
		end

	init_attribute_scopes
			-- Prepare structures to track attribute scopes.
		require
			attributes_attached: attributes /= Void
		do
			create attribute_initialization.make (attributes.count)
		ensure
			attribute_initialization_attached: attribute_initialization /= Void
			attribute_initialization_initialized: attribute_initialization.attribute_count = attributes.count
		end

	local_initialization: AST_LOCAL_INITIALIZATION_TRACKER
			-- Tracker of initialized locals.

	local_scope: AST_LOCAL_SCOPE_TRACKER
			-- Tracker of scopes of non-void locals.

	local_scopes: TUPLE [local_initialization: like local_initialization; local_scope: like local_scope]
			-- Scopes that can be saved before calling `init_local_scopes' and restored by calling `set_local_scopes'.
		do
			Result := [local_initialization, local_scope]
		end

	set_local_scopes (v: like local_scopes)
			-- Set scopes to the previously saved value `v'.
		do
			local_initialization := v.local_initialization
			local_scope := v.local_scope
		end

	is_sibling_dominating: BOOLEAN
			-- Does variable information of a sibling dominate the previous one (if any)?
		do
				-- At the moment only local variables are tracked to become (potentially) detached.
			Result := local_scope.keeper.is_sibling_dominating
		end

feature {AST_SCOPE_MATCHER, AST_FEATURE_CHECKER_GENERATOR} -- Local scopes: modification

	enter_old_expression
			-- Enter a scope of an old expression.
			-- It should be paired with `leave_old_expression`.
		do
			inline_scopes_bound := inline_scopes.upper
		ensure
			inline_scopes_bound = inline_scopes.upper
		end

	leave_old_expression
			-- Leave a scope of an old expression previously entered by `enter_old_expression`.
		do
			inline_scopes_bound := 0
		ensure
			inline_scopes_bound = 0
		end

	add_readonly_expression_scope (id: INTEGER_32)
			-- Add a scope for an argument identified by `id'.
		do
			scopes.extend (id)
		ensure
			scope_count_inremented: scope_count = old scope_count + 1
			is_readonly_attached (id)
		end

	add_local_expression_scope (id: INTEGER_32)
			-- Add a scope for a local identified by `id'.
		do
			scopes.extend (id)
		ensure
			scope_count_inremented: scope_count = old scope_count + 1
			is_local_attached: is_local_attached (id)
		end

	add_result_expression_scope
			-- Add a scope for the special entity "Result".
		do
			scopes.extend (result_id)
		ensure
			scope_count_inremented: scope_count = old scope_count + 1
			is_result_attached: is_result_attached
		end

	add_attribute_expression_scope (id: INTEGER_32)
			-- Add a scope for an attribute identified by `id'.
		do
			scopes.extend (id)
		ensure
			scope_count_inremented: scope_count = old scope_count + 1
			is_attribute_attached: is_attribute_attached (id)
		end

	add_readonly_instruction_scope (id: INTEGER_32)
			-- Add a scope for an argument identified by `id'.
		do
			scopes.extend (id)
		ensure
			is_readonly_attached (id)
		end

	add_local_instruction_scope (id: INTEGER_32)
			-- Add a scope for a local identified by `id'.
		local
			l: INTEGER
		do
			l := locals.item (id).position
			local_scope.start_local_scope (l)
			local_initialization.set_local (l)
		ensure
			is_local_attached: is_local_attached (id)
			is_local_set: local_initialization.is_local_set (locals.item (id).position)
		end

	add_result_instruction_scope
			-- Add a scope for the special entity "Result".
		do
			local_scope.start_result_scope
			local_initialization.set_result
		ensure
			is_result_attached: is_result_attached
			is_result_set: local_initialization.is_result_set
		end

	add_attribute_instruction_scope (id: INTEGER_32)
			-- Add a scope for a local identified by `id'.
		local
			p: INTEGER_32
		do
			if attached current_class.feature_of_name_id (id) as f then
				p := attributes.item (f.feature_id)
				if p > 0 then
					attribute_initialization.set_attribute (p)
				end
			end
		end

	set_local (id: INTEGER_32)
			-- Mark that a local identified by `id' is set.
		do
			local_initialization.set_local (locals.item (id).position)
		end

	set_result
			-- Mark that "Result" is set.
		do
			local_initialization.set_result
		end

	set_all
			-- Mark that all variables as initialized.
		do
			local_initialization.set_all
			attribute_initialization.set_all
		end

	unset_local (id: INTEGER_32)
			-- Mark that a local identified by `id' is unset.
		do
			local_initialization.unset_local (locals.item (id).position)
		end

	unset_result
			-- Mark that "Result" is unset.
		do
			local_initialization.unset_result
		end

feature {AST_SCOPE_MATCHER, SHARED_AST_CONTEXT, AST_FEATURE_CHECKER_GENERATOR} -- Local scopes: modification

	add_object_test_expression_scope (id: ID_AS)
			-- Add a scope for an object-test local identified by `id'.
		require
			id_attached: id /= Void
		do
			scopes.extend (id.name_id)
			inline_scopes.extend (id)
		ensure
			scope_count_inremented: scope_count = old scope_count +1
			object_test_scopes_count_incremented: inline_scopes.count = old inline_scopes.count + 1
		end

	add_object_test_instruction_scope (id: ID_AS)
			-- Add a scope for an object-test local identified by `id'.
		require
			id_attached: id /= Void
		do
			add_object_test_expression_scope (id)
		ensure
			scope_count_inremented: scope_count = old scope_count +1
			object_test_scopes_count_incremented: inline_scopes.count = old inline_scopes.count + 1
		end

feature {AST_FEATURE_CHECKER_GENERATOR, AST_CONTEXT} -- Local scopes: removal

	remove_object_test_scopes (s: like scope)
			-- Remove scopes of any known inner locals registered after scope identified by `s'.
		local
			i: INTEGER
			j: INTEGER
			scope_limit: INTEGER
			object_test_limit: INTEGER
			name_id: like inline_scopes.item.name_id
		do
			scope_limit := (s ⊗ scope_count_mask).as_integer_32
			object_test_limit := (s ⧁ object_test_count_shift).as_integer_32
			from
				j := inline_scopes.count
			until
				j ≤ object_test_limit
			loop
					-- Pick the inline local name.
				name_id := inline_scopes [j].name_id
				from
					i := scopes.count
				until
					i ≤ scope_limit
				loop
					if scopes [i] = name_id then
							-- Remove the `i`-th item corresponding to the inline local.
						scopes.remove_i_th (i)
					end
					i := i - 1
				variant
					i
				end
				inline_scopes.remove_i_th (j)
				j := j - 1
			variant
				j
			end
		end

	remove_local_scope (id: INTEGER_32)
			-- Mark that an attached scope of a local identified by `id' is terminated.
		do
			local_scope.stop_local_scope (locals.item (id).position)
		end

	remove_result_scope
			-- Mark that an attached scope of the special entity "Result" is terminated.
		do
			local_scope.stop_result_scope
		end

feature -- Local initialization and scopes: nesting

	enter_realm
			-- Enter a new complex instruction with inner compound parts.
		do
			local_initialization.keeper.enter_realm
			local_scope.keeper.enter_realm
			attribute_initialization.keeper.enter_realm
		end

	update_realm
			-- Update realm variable information from the current state.
		do
			local_initialization.keeper.update_realm
			local_scope.keeper.update_realm
			attribute_initialization.keeper.update_realm
		end

	save_sibling
			-- Save scope information of a sibling in a complex instrution and restart recording using the outer scope.
			-- For example, Then_part of Elseif condition.
		do
			local_initialization.keeper.save_sibling
			local_scope.keeper.save_sibling
			attribute_initialization.keeper.save_sibling
		end

	update_sibling
			-- Update scope information of a sibling in a complex instrution and reuse it for the current scope.
			-- For example, Loop body.
		do
			local_initialization.keeper.update_sibling
			local_scope.keeper.update_sibling
			attribute_initialization.keeper.update_sibling
		end

	leave_realm
			-- Leave a complex instruction and promote variable information to the outer compound.
		do
			local_initialization.keeper.leave_realm
			local_scope.keeper.leave_realm
			attribute_initialization.keeper.leave_realm
		end

	leave_optional_realm
			-- Leave a complex instruction and discard its variable information.
			-- For example, Debug instruction.
		do
			local_initialization.keeper.leave_optional_realm
			local_scope.keeper.leave_optional_realm
			attribute_initialization.keeper.leave_optional_realm
		end

feature -- Status report

	is_ignoring_export: BOOLEAN
			-- Do we ignore export validity for feature access ?
			-- Useful for expression evaluation.

	last_conversion_info: CONVERSION_INFO
			-- Information about last conversion.

feature -- Setting

	initialize (a_class: like current_class; a_type: CL_TYPE_A)
			-- Initialize current context for class analyzis.
		require
			a_class_not_void: a_class /= Void
			a_type_not_void: a_type /= Void
		local
			s: GENERIC_SKELETON
			i: INTEGER
			a: ATTR_DESC
		do
			current_class := a_class
			is_void_safe_call := a_class.lace_class.is_void_safe_call
			is_void_safe_conformance := a_class.lace_class.is_void_safe_conformance
			is_void_safe_initialization := a_class.lace_class.is_void_safe_initialization
			is_void_safe_construct := a_class.lace_class.is_void_safe_construct
			is_void_unsafe := a_class.lace_class.is_void_unsafe

			create current_class_type.make (a_type)
				-- Current is always attached.
			if is_void_safe_conformance then
				current_class_type.set_attached_mark
			end
				-- Current is always frozen.
			if current_class.lace_class.is_catcall_conformance then
				current_class_type.set_frozen_mark
			end
			set_written_class (Void)
				-- TODO: Instead of making the following check, it is better to split `{AST_CONTEXT}` into 2 classes: one for degree 4 and one for degree 3.
			if a_class.degree_4_needed implies a_class.degree_4_processed then
				from
					s := a_class.skeleton
					if s /= Void then
						i := s.count
					end
					create attributes.make (i)
					has_stable_attributes := False
				until
					i <= 0
				loop
					a := s [i]
					attributes.put (i, a.feature_id)
					if not a.type_i.is_attached and then a_class.feature_of_feature_id (a.feature_id).is_stable then
						has_stable_attributes := True
					end
					i := i - 1
				end
			end
		ensure
			current_class_set: current_class = a_class
			current_class_type_set: current_class_type /= Void
			current_class_type_valid: -- current_class_type.conformance_type.same_type_with_any_annotations (a_type)
		end

	set_current_feature (f: FEATURE_I)
			-- Assign `f' to `current_feature'.
		require
			f_not_void: f /= Void
		do
			current_feature := f
		ensure
			current_feature_set: current_feature = f
		end

	set_written_class (c: like written_class)
			-- Set `written_class' to `c'.
		do
			written_class := c
			iterable_class := Void
			iteration_cursor_class := Void
		ensure
			written_class_set: written_class = c
		end

	set_is_ignoring_export (b: BOOLEAN)
			-- Assign `b' to `is_ignoring_export'.
		do
			is_ignoring_export := b
		ensure
			is_ignoring_export_set: is_ignoring_export = b
		end

	set_locals (l: like locals)
			-- Assign `l' to `locals'.
		do
			locals := l;
		end;

	set_last_conversion_info (l: like last_conversion_info)
			-- Assign `l' to `last_conversion_info'.
		do
			last_conversion_info := l
		ensure
			last_conversion_info_set: last_conversion_info = l
		end

	init_error (e: FEATURE_ERROR)
			-- Initialize `e'.
		require
			e_attached: attached e
		do
			e.set_class (current_class)
			e.set_written_class (written_class)
			if current_feature /= Void then
				e.set_feature (current_feature)
			end
		end

	init_byte_code (byte_code: BYTE_CODE)
			-- Initialiaze `byte_code'.
		require
			byte_code_attached: byte_code /= Void
			current_feature_attached: current_feature /= Void
		local
			local_dec: ARRAY [TYPE_A]
			local_info: LOCAL_INFO
			total_count: INTEGER
			local_count: INTEGER
			test_count: INTEGER
			i: INTEGER
			arguments: FEAT_ARG
		do
				-- Name
			byte_code.set_feature_name_id (current_feature.feature_name_id)
				-- Feature id
			byte_code.set_body_index (current_feature.body_index)
				-- Result type if any
			byte_code.set_result_type (current_feature.type)
				-- Routine id
			byte_code.set_rout_id (current_feature.rout_id_set.first)
				-- Written_id
			byte_code.set_written_class_id (current_class.class_id)
				-- Pattern id
			byte_code.set_pattern_id (current_feature.pattern_id)
				-- Local variable declarations.
			local_dec := Void
			local_count := locals.count
			test_count := inline_locals.count
			total_count := local_count + test_count
			if local_count > 0 then
				across
					locals as l
				from
						-- Local variables are treated as detachable.
					create local_dec.make_filled (l.item.type.as_detachable_type, 1, total_count)
				loop
					local_info := l.item
						-- Local variables are treated as detachable.
					local_dec [local_info.position] := local_info.type.as_detachable_type
				end
			end
			if test_count > 0 then
				across
					inline_locals as o
				from
					if not attached local_dec then
						create local_dec.make_filled (o.item.type, 1, total_count)
					end
				loop
					local_info := o.item
					local_dec [local_count + local_info.position] := local_info.type
				end
			end
			byte_code.set_locals (local_dec, local_count)
				-- Arguments declarations.
			arguments := current_feature.arguments
			if attached arguments then
				total_count := arguments.count
				if total_count > 0 then
					from
						i := 2
						create local_dec.make_filled (arguments [1], 1, total_count)
					until
						i > total_count
					loop
						local_dec [i] := arguments [i]
						i := i + 1
					end
					byte_code.set_arguments (local_dec)
				end
			end
		end

	init_assertion_byte_code (b: ASSERTION_BYTE_CODE; first_object_test_local_position: INTEGER)
			-- Initialize assertion byte code `b' given the first used
			-- object test local position `first_object_test_local_position'.
		require
			b_attached: b /= Void
		local
			i: LOCAL_INFO
			l: ARRAY [TYPE_A]
		do
			if not inline_locals.is_empty then
				across
					inline_locals as o
				loop
					i := o.item
					if i.position >= first_object_test_local_position then
							-- An object test local is declared inside this assertion.
							-- It should be recorded to allow code generation when
							-- assertion is inherited.
						if attached l then
							l.force (i.type, i.position)
						else
							create l.make_filled (i.type, first_object_test_local_position, i.position)
						end
					end
				end
				b.set_object_test_locals (l)
			end
		end

	init_invariant_byte_code (b: INVARIANT_B)
			-- Initialize class invariant byte code `b'.
		local
			i: LOCAL_INFO
			l: ARRAY [TYPE_A]
		do
			if not inline_locals.is_empty then
				across
					inline_locals as o
				from
					create l.make_filled (o.item.type, 1, inline_locals.count)
				loop
					i := o.item
					l.force (i.type, i.position)
				end
				b.set_object_test_locals (l)
			end
		end

	set_current_inline_agent_body (body: like current_inline_agent_body)
			-- Set current inline agent body to `body`.
		do
			current_inline_agent_body := body
		end

feature -- Settings: void safety

	is_void_unsafe: BOOLEAN
			-- Is context  class compiled without any void-safety mechanism enabled?

	is_void_safe_conformance: BOOLEAN
			-- Should attachment status be taken into account when checking conformance?

	is_void_safe_initialization: BOOLEAN
			-- Should attached entities be property set before use?

	is_void_safe_call: BOOLEAN
			-- Should feature call target be attached?

	is_void_safe_construct: BOOLEAN
			-- Should only mode-independent void-safety constructs be taken into account?

	has_stable_attributes: BOOLEAN
			-- Does current class have stable attributes?

feature -- Iteration classes

	find_iteration_classes (c: CLASS_C)
			-- Look for iteration classes for class `c' and initialize `iterable_class' and `iteration_cursor'
			-- if possible or report error otherwise.
		do
			if iterable_class = Void and then iteration_cursor_class = Void then
				if
					attached universe.class_named ("ITERABLE", c.group) as i and then
					i.is_compiled and then
					attached i.compiled_class as x and then
					attached x.generics as g and then
					g.count = 1
				then
					iterable_class := x
				end
				if
					attached universe.class_named ("ITERATION_CURSOR", c.group) as i and then
					i.is_compiled and then
					attached i.compiled_class as x and then
					attached x.generics as g and then
					g.count = 1
				then
					iteration_cursor_class := x
				end
			end
		end

feature -- Managing the type stack

	clear_all
			-- Clear the structure: to use while changing of analyzed
			-- current_class.
		do
			current_class := Void
			current_class_type := Void
			attributes.wipe_out
			has_stable_attributes := False
			clear_feature_context
		end

	clear_feature_context
			-- Clear `current_feature' context: to use while changing of current
			-- analyzed feature.
		do
			current_feature := Void
			last_conversion_info := Void
			supplier_ids.wipe_out
			set_written_class (Void)
			inline_agent_counter.reset
			hidden_local_counter.reset
			inline_agents := Void
			clear_local_context
		end

	clear_inline_locals
			-- Clear context specific to inline local declarations.
		do
			inline_locals.wipe_out
			inline_scopes.wipe_out
			inline_scopes_bound := 0
		end

	clear_local_context
			-- Clear context specific to local declarations such as locals.
		do
			locals.wipe_out
			scopes.wipe_out
			clear_inline_locals
		end

feature	-- Saving contexts

	save: AST_CONTEXT
			-- Make a copy of the current context and return it.
		require
			current_class_attached: current_class /= Void
		do
			Result := twin
			create_local_containers
			used_argument_names := Void
			used_local_names := Void
			scopes.copy (Result.scopes)
			inline_scopes.copy (Result.inline_scopes)
			local_scope := Void
			local_initialization := Void
			attribute_initialization := Void
		end

	restore (context: AST_CONTEXT)
			-- Restore a given context.
		do
			copy (context)
		end

feature {NONE} -- Internals

	old_inline_agents_int:  HASH_TABLE [FEATURE_I, INTEGER]
			-- Storage for `old_inline_agents`.

invariant
	locals_attached: locals /= Void
	object_test_locals_attached: inline_locals /= Void

note
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
