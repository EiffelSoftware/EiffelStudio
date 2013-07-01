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
			create object_test_scopes.make (0)
			create {HASH_TABLE_EX [LOCAL_INFO, ID_AS]} object_test_locals.make_with_key_tester (0, create {REFERENCE_EQUALITY_TESTER [ID_AS]})
		end

feature -- Access

	current_class: CLASS_C
			-- Current analyzed class.

	current_class_type: LIKE_CURRENT
			-- Actual type of `current_class'

	written_class: CLASS_C
			-- Class where the code is originally written.
			-- (Used for checking inherited code in current context.)

	iterable_class: CLASS_C
			-- Class ITERABLE used to process Loop Iteration part

	iteration_cursor_class: CLASS_C
			-- Class ITERATION_CURSOR used to process Loop Iteration part

	current_feature: FEATURE_I
			-- Current analyzed feature.

	locals: HASH_TABLE [LOCAL_INFO, INTEGER]
			-- Current local variables of the analyzed feature

	supplier_ids: FEATURE_DEPENDANCE
			-- Supplier units

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
			-- counter for managing the inline agents that are enclosed in the current feature

	current_inline_agent_body: BODY_AS
			-- Body of the current processec inline agent. Is only valid if the current feature is an inline agent

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
			-- Argument names that are already used by enclosing features

	used_local_names: SEARCH_TABLE [INTEGER]
			-- Local names that are already used by enclosing features

	set_used_argument_names (table: like used_argument_names)
			-- Set the used argument names
		do
			used_argument_names := table
		end

	set_used_local_names (table: like used_local_names)
			-- Set the used local names
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

	object_test_locals: HASH_TABLE [LOCAL_INFO, ID_AS]
			-- Types of object-test locals indexes by their name id

	result_id: INTEGER_32 = 0x7fffffff
			-- Name ID that is used for the special entity "Result"

	old_id: INTEGER_32 = 0x7ffffffe
			-- Name ID that is used to mark the scope of an old expression

feature {AST_FEATURE_CHECKER_GENERATOR, SHARED_AST_CONTEXT} -- Local scopes

	next_object_test_local_position: INTEGER
			-- Position of a next object test local
		do
			Result := object_test_locals.count + 1
		end

	add_object_test_local (l: LOCAL_INFO; id: ID_AS)
			-- Add a new object test local of type `t' with name `id' specified in the object test.
		require
			l_attached: l /= Void
			id_attached: id /= Void
		do
			object_test_locals.force (l, id)
		end

	object_test_local (id: INTEGER_32): detachable LOCAL_INFO
			-- Information about object-test local of name `id' if such
			-- a local is currently in scope or `Void' otherwise
		local
			i: INTEGER
			l: INTEGER
			n: ID_AS
		do
			from
				i := scopes.count
			until
				i <= 0
			loop
				l := scopes [i]
				if l = id then
						-- The current evaluation position is in the scope of the name `id'.
						-- Find the associated object test local information (if any).
					from
						i := object_test_scopes.count
					until
						i <= 0
					loop
						n := object_test_scopes [i]
						if n.name_id = id and then object_test_locals.has (n) then
							Result := object_test_locals.item (n)
						end
						i := i - 1
					end
				elseif l = old_id then
						-- Object test local declared outside an old expression cannot be used inside it.
					i := 0
				else
					i := i - 1
				end
			variant
				i
			end
		end

	unchecked_object_test_local (id: ID_AS): detachable LOCAL_INFO
			-- Information about object-test local of name `id' (if any) regardless of current scope
		require
			id_attached: id /= Void
		do
			if object_test_locals.has (id) then
				Result := object_test_locals.item (id)
			end
		end

feature {AST_FEATURE_CHECKER_GENERATOR, AST_CONTEXT} -- Local scopes: status report

	is_argument_attached (id: INTEGER_32): BOOLEAN
			-- Is argument `id' in the scope where it is considered attached?
		do
			Result := scopes.has (id)
		end

	is_local_attached (id: INTEGER_32): BOOLEAN
			-- Is local `id' in the scope where it is considered attached?
		do
			Result := local_scope.is_local_attached (locals.item (id).position)
			if not Result then
				Result := scopes.has (id)
			end
		end

	is_result_attached: BOOLEAN
			-- Is special entity "Result" in the scope where it is considered attached?
		do
			Result := local_scope.is_result_attached
			if not Result then
				Result := scopes.has (result_id)
			end
		end

	is_attribute_attached (id: INTEGER_32): BOOLEAN
			-- Is attribute `id' in the scope where it is considered attached?
		local
			f: FEATURE_I
			p: INTEGER_32
		do
			Result := scopes.has (id)
			if not Result then
				f := current_class.feature_of_name_id (id)
				if f /= Void then
					p := attributes.item (f.feature_id)
					if p > 0 then
						Result := attribute_initialization.is_attribute_set (p)
					end
				end
			end
		end

feature {AST_CONTEXT} -- Local scopes

	scopes: ARRAYED_LIST [INTEGER_32]
			-- Currently active scopes identified by entity name ID

	scope_count: INTEGER
			-- Number of active scopes
		do
			Result := scopes.count
		end

	object_test_scopes: ARRAYED_LIST [ID_AS]
			-- Currently active scopes of object test locals

feature {AST_CREATION_PROCEDURE_CHECKER, AST_FEATURE_CHECKER_GENERATOR, AST_CONTEXT, AST_SCOPE_COMBINED_PRECONDITION} -- Attribute positions

	attributes: HASH_TABLE [INTEGER_32, INTEGER_32]
			-- Attribute indecies indexed by their feature ID

	attribute_initialization: AST_ATTRIBUTE_INITIALIZATION_TRACKER
			-- Tracker of initialized stable attributes

feature {AST_FEATURE_CHECKER_GENERATOR, AST_CONTEXT} -- Scope state

	scope: INTEGER
			-- Current scope ID
		do
				-- For simplicity the current number of local scopes is used.
			Result := scope_count
		end

	set_scope (s: like scope)
			-- Reset `scope' to the previously recorded scope ID `s'.
		require
			valid_s: s <= scope
		local
			i: like scope_count
		do
			from
				object_test_scopes.finish
				i := scope_count - s
			until
				i <= 0
			loop
				scopes.finish
				if not object_test_scopes.before and then object_test_scopes.item_for_iteration.name_id = scopes.item_for_iteration then
						-- Remove object test scope.
					object_test_scopes.remove
					object_test_scopes.finish
				end
				scopes.remove
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
			-- Tracker of initialized locals

	local_scope: AST_LOCAL_SCOPE_TRACKER
			-- Tracker of scopes of non-void locals

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

	add_old_expression_scope
			-- Add a scope of an old expression
		do
			scopes.extend (old_id)
		end

	add_argument_expression_scope (id: INTEGER_32)
			-- Add a scope for an argument identified by `id'.
		do
			scopes.extend (id)
		ensure
			scope_count_inremented: scope_count = old scope_count + 1
			is_argument_attached: is_argument_attached (id)
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

	add_argument_instruction_scope (id: INTEGER_32)
			-- Add a scope for an argument identified by `id'.
		do
			scopes.extend (id)
		ensure
			is_argument_attached: is_argument_attached (id)
		end

	add_local_instruction_scope (id: INTEGER_32)
			-- Add a scope for a local identified by `id'.
		do
			local_scope.start_local_scope (locals.item (id).position)
		ensure
			is_local_attached: is_local_attached (id)
		end

	add_result_instruction_scope
			-- Add a scope for the special entity "Result".
		do
			local_scope.start_result_scope
		ensure
			is_result_attached: is_result_attached
		end

	add_attribute_instruction_scope (id: INTEGER_32)
			-- Add a scope for a local identified by `id'.
		local
			f: FEATURE_I
			p: INTEGER_32
		do
			f := current_class.feature_of_name_id (id)
			if f /= Void then
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

feature {AST_SCOPE_MATCHER, SHARED_AST_CONTEXT, AST_FEATURE_CHECKER_GENERATOR} -- Local scopes: modification

	add_object_test_expression_scope (id: ID_AS)
			-- Add a scope for an object-test local identified by `id'.
		require
			id_attached: id /= Void
		do
			if scopes.has (id.name_id) then
				error_handler.insert_error (create {VUOT1}.make (Current, id))
			end
			scopes.extend (id.name_id)
			object_test_scopes.extend (id)
		ensure
			scope_count_inremented: scope_count = old scope_count +1
			object_test_scopes_count_incremented: object_test_scopes.count = old object_test_scopes.count + 1
		end

	add_object_test_instruction_scope (id: ID_AS)
			-- Add a scope for an object-test local identified by `id'.
		require
			id_attached: id /= Void
		do
			add_object_test_expression_scope (id)
		ensure
			scope_count_inremented: scope_count = old scope_count +1
			object_test_scopes_count_incremented: object_test_scopes.count = old object_test_scopes.count + 1
		end

feature {AST_FEATURE_CHECKER_GENERATOR, AST_CONTEXT} -- Local scopes: removal

	remove_object_test_scopes (s: like scope)
			-- Remove scopes of any known inner locals registered after scope identified by `s'.
		local
			i: INTEGER
			j: INTEGER
		do
			from
				i := scopes.count
				j := object_test_scopes.count
			until
				i <= s or else j <= 0
			loop
				if scopes [i] = object_test_scopes [j].name_id then
						-- The `i'-th item corresponds to an object test local, let's remove it.
					scopes.go_i_th (i)
					scopes.remove
					object_test_scopes.go_i_th (j)
					object_test_scopes.remove
					j := j - 1
				end
				i := i - 1
			variant
				i
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
			-- Useful for expression evaluation

	last_conversion_info: CONVERSION_INFO
			-- Information about last conversion

feature -- Setting

	initialize (a_class: like current_class; a_type: CL_TYPE_A)
			-- Initialize current context for class analyzis.
		require
			a_class_not_void: a_class /= Void
			a_type_not_void: a_type /= Void
		local
			s: GENERIC_SKELETON
			i: INTEGER
		do
			current_class := a_class
			create current_class_type
			current_class_type.set_actual_type (a_type)
				-- Current is always attached.
			current_class_type := current_class_type.as_attached_in (current_class)
			set_written_class (Void)
			from
				s := a_class.skeleton
				if s /= Void then
					i := s.count
				end
				create attributes.make (i)
			until
				i <= 0
			loop
				attributes.put (i, s [i].feature_id)
				i := i - 1
			end
		ensure
			current_class_set: current_class = a_class
			current_class_type_set: current_class_type.conformance_type = a_type
				or else current_class_type.conformance_type.same_as (a_type.as_attached_type)
				or else current_class_type.conformance_type.same_as (a_type.as_implicitly_attached)
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
			good_argument: not (e = Void)
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
			local_count: INTEGER
			argument_count: INTEGER
			i: INTEGER
			arguments: FEAT_ARG
			rout_id: INTEGER
		do
				-- Name
			byte_code.set_feature_name_id (current_feature.feature_name_id)
				-- Feature id
			byte_code.set_body_index (current_feature.body_index)
				-- Result type if any
			byte_code.set_result_type (current_feature.type)
				-- Routine id
			rout_id := current_feature.rout_id_set.first
			byte_code.set_rout_id (rout_id)
				-- Written_id
			byte_code.set_written_class_id (current_class.class_id)
				-- Pattern id
			byte_code.set_pattern_id (current_feature.pattern_id)
				-- Local variable declarations
			local_count := locals.count + object_test_locals.count
			if local_count > 0 then
				create local_dec.make (1, local_count)
				from
					locals.start
				until
					locals.after
				loop
					local_info := locals.item_for_iteration
					local_dec.put (local_info.type, local_info.position)
					locals.forth
				end
				from
					object_test_locals.start
				until
					object_test_locals.after
				loop
					local_info := object_test_locals.item_for_iteration
					local_dec.put (local_info.type, locals.count + local_info.position)
					object_test_locals.forth
				end
				byte_code.set_locals (local_dec, locals.count)
			end
				-- Arguments declarations
			argument_count := current_feature.argument_count
			if argument_count > 0 then
				from
					arguments := current_feature.arguments
					i := 1
					create local_dec.make (1, argument_count)
				until
					i > argument_count
				loop
					local_dec.put (arguments.i_th (i), i)
					i := i + 1
				end
				byte_code.set_arguments (local_dec)
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
			if not object_test_locals.is_empty then
				from
					object_test_locals.start
				until
					object_test_locals.after
				loop
					i := object_test_locals.item_for_iteration
					if i.position >= first_object_test_local_position then
							-- An object test local is declared inside this assertion.
							-- It should be recorded to allow code generation when
							-- assertion is inherited.
						if l = Void then
							create l.make (first_object_test_local_position, i.position)
						end
						l.force (i.type, i.position)
					end
					object_test_locals.forth
				end
				b.set_object_test_locals (l)
			end
		end

	init_invariant_byte_code (b: INVARIANT_B)
			-- Initialize class invariant byte code `b'
		local
			i: LOCAL_INFO
			l: ARRAY [TYPE_A]
		do
			if not object_test_locals.is_empty then
				create l.make (1, object_test_locals.count)
				from
					object_test_locals.start
				until
					object_test_locals.after
				loop
					i := object_test_locals.item_for_iteration
					l.force (i.type, i.position)
					object_test_locals.forth
				end
				b.set_object_test_locals (l)
			end
		end

	set_current_inline_agent_body (body: like current_inline_agent_body)
			-- Sets the current inline agent body
		do
			current_inline_agent_body := body
		end

feature -- Iteration classes

	find_iteration_classes
			-- Look for iteration classes and initialize `iterable_class' and `iteration_cursor'
			-- if possible or report error otherwise.
		do
			if iterable_class = Void and then iteration_cursor_class = Void then
				if
					attached universe.class_named ("ITERABLE", current_class.group) as i and then
					i.is_compiled and then
					attached i.compiled_class as c and then
					attached c.generics as g and then
					g.count = 1
				then
					iterable_class := c
				end
				if
					attached universe.class_named ("ITERATION_CURSOR", current_class.group) as i and then
					i.is_compiled and then
					attached i.compiled_class as c and then
					attached c.generics as g and then
					g.count = 1
				then
					iteration_cursor_class := c
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

	clear_local_context
			-- Clear context specific to local declarations
			-- such as object test locals
		do
			locals.wipe_out
			object_test_locals.wipe_out
			scopes.wipe_out
			object_test_scopes.wipe_out
		end

feature	-- Saving contexts

	save: AST_CONTEXT
			-- Returns a saved context
		require
			current_class_attached: current_class /= Void
		do
			Result := twin
			create_local_containers
			used_argument_names := Void
			used_local_names := Void
			scopes.copy (Result.scopes)
			object_test_scopes.copy (Result.object_test_scopes)
			local_scope := Void
			local_initialization := Void
			attribute_initialization := Void
		end

	restore (context: AST_CONTEXT)
			-- Restores a given context
		do
			copy (context)
		end

feature {NONE} --Internals
	old_inline_agents_int:  HASH_TABLE [FEATURE_I, INTEGER]

invariant
	locals_attached: locals /= Void
	object_test_locals_attached: object_test_locals /= Void

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
