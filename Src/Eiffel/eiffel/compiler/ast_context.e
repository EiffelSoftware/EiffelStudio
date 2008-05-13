indexing
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

create
	make

feature {NONE} -- Initialization

	make is
			-- Create instance of AST_CONTEXT.	
		do
			create inline_agent_counter
			create_local_containers
		end

	create_local_containers
			-- Create containers to keep information about locals, scopes
			-- and other data within a feature.
		do
			create locals.make (10)
			create supplier_ids.make
			create {ARRAYED_STACK [INTEGER]} scopes.make (0)
			create object_test_locals.make (0)
			create used_object_test_local_names.make (0)
			if current_class /= Void then
				if current_class.lace_class.is_void_safe then
					create {AST_VOID_SAFE_VARIABLE_CONTEXT} variables
				else
					create {AST_VARIABLE_CONTEXT} variables
				end
			end
		end

feature -- Access

	current_class: CLASS_C
			-- Current analyzed class.

	current_class_type: LIKE_CURRENT
			-- Actual type of `current_class'

	current_feature_table: FEATURE_TABLE
			-- Current feature table

	written_class: CLASS_C
			-- Class where the code is originally written.
			-- (Used for checking inherited code in current context.)

	current_feature: FEATURE_I
			-- Current analyzed feature.

	locals: HASH_TABLE [LOCAL_INFO, INTEGER]
			-- Current local variables of the analyzed feature

	supplier_ids: FEATURE_DEPENDANCE
			-- Supplier units

	inline_agent_counter: COUNTER
			-- counter for managing the inline agents that are enclosed in the current feature

	current_inline_agent_body: BODY_AS
			-- Body of the current processec inline agent. Is only valid if the current feature is an inline agent

	old_inline_agents: HASH_TABLE [FEATURE_I, INTEGER]
			-- It the processed feature was allready presend, this table gives a mapping from
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

	used_object_test_local_names: SEARCH_TABLE [INTEGER_32]
			-- Names of object-test locals used by enclosing features

	set_used_argument_names (table: like used_argument_names) is
			-- Set the used argument names
		do
			used_argument_names := table
		end

	set_used_local_names (table: like used_local_names) is
			-- Set the used local names
		do
			used_local_names := table
		end

	is_name_used (id: INTEGER_32): BOOLEAN is
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

	is_object_test_local_used (id: INTEGER_32): BOOLEAN
			-- Is the name `id' already used in an object test of an enclosing feature?
		do
			Result := used_object_test_local_names.has (id)
		end

feature {NONE} -- Local scopes

	object_test_locals: HASH_TABLE [LOCAL_INFO, INTEGER_32]
			-- Types of object-test locals indexes by their name id

	result_id: INTEGER_32 = 0x7fffffff
			-- Name ID that is used for the special entity "Result"

feature {AST_FEATURE_CHECKER_GENERATOR, SHARED_AST_CONTEXT} -- Local scopes

	next_object_test_local_position: INTEGER
			-- Position of a next object test local
		do
			Result := object_test_locals.count + 1
		end

	add_object_test_local (l: LOCAL_INFO; id: INTEGER_32)
			-- Add a new object test local of type `t' with name `id'.
		require
			l_attached: l /= Void
		do
			object_test_locals.put (l, id)
			used_object_test_local_names.put (id)
		end

	object_test_local (id: INTEGER_32): LOCAL_INFO
			-- Information about object-test local of name `id' if such
			-- a local is currently in scope
		do
			if scopes.has (id) then
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
			Result := scope_keeper.is_local_attached (locals.item (id).position)
			if not Result then
				Result := scopes.has (id)
			end
		end

	is_result_attached: BOOLEAN
			-- Is special entity "Result" in the scope where it is considered attached?
		do
			Result := scope_keeper.is_result_attached
			if not Result then
				Result := scopes.has (result_id)
			end
		end

feature {AST_CONTEXT} -- Local scopes

	scopes: ARRAYED_LIST [INTEGER_32]
			-- Currently active scopes

	scope_count: INTEGER
			-- Number of active scopes
		do
			Result := scopes.count
		end

feature -- Scope state

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
				i := scope_count - s
			until
				i <= 0
			loop
				scopes.finish
				scopes.remove
				i := i - 1
			end
		ensure
			scope_set: scope = s
		end

	init_variable_scopes
			-- Prepare structures to track variable scopes.
		do
			scope_keeper := scope_keeper_factory.create_scope_keeper (locals.count)
		ensure
			scope_keeper_attached: scope_keeper /= Void
			scope_keeper_initialized: scope_keeper.local_count = locals.count
		end

	scope_keeper: AST_SCOPE_KEEPER
			-- Keeper of scopes of non-void variables

feature {NONE} -- Scope state

	scope_keeper_factory: AST_SCOPE_KEEPER_FACTORY
			-- Factory to create scope keepers
		once
			create Result
		end

feature {AST_SCOPE_MATCHER, AST_FEATURE_CHECKER_GENERATOR} -- Local scopes: modification

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
			scope_keeper.start_local_scope (locals.item (id).position)
		ensure
			is_local_attached: is_local_attached (id)
		end

	add_result_instruction_scope
			-- Add a scope for the special entity "Result".
		do
			scope_keeper.start_result_scope
		ensure
			is_result_attached: is_result_attached
		end

feature {AST_SCOPE_MATCHER, SHARED_AST_CONTEXT} -- Local scopes: modification

	add_object_test_expression_scope (id: INTEGER_32)
			-- Add a scope for an object-test local identified by `id'.
		do
			scopes.extend (id)
		ensure
			scope_count_inremented: scope_count = old scope_count +1
		end

	add_object_test_instruction_scope (id: INTEGER_32)
			-- Add a scope for an object-test local identified by `id'.
		do
			scopes.extend (id)
		ensure
			scope_count_inremented: scope_count = old scope_count +1
		end

feature {AST_FEATURE_CHECKER_GENERATOR, AST_CONTEXT} -- Local scopes: removal

	remove_local_scope (id: INTEGER_32)
			-- Mark that an attached scope of a local identified by `id' is terminated.
		do
			scope_keeper.stop_local_scope (locals.item (id).position)
		ensure
			local_scope_removed: not is_local_attached (id)
		end

	remove_result_scope
			-- Mark that an attached scope of the special entity "Result" is terminated.
		do
			scope_keeper.stop_result_scope
		ensure
			result_scope_removed: not is_result_attached
		end

feature -- Variable context

	variables: AST_VARIABLE_CONTEXT
			-- Context for tracking variable usage.

feature -- Status report

	is_ignoring_export: BOOLEAN
			-- Do we ignore export validity for feature access ?
			-- Useful for expression evaluation

	last_conversion_info: CONVERSION_INFO
			-- Information about last conversion

feature -- Setting

	initialize (a_class: like current_class; a_type: CL_TYPE_A; a_feat_tbl: like current_feature_table) is
			-- Initialize current context for class analyzis.
		require
			a_class_not_void: a_class /= Void
			a_feat_tbl_not_void: a_feat_tbl /= Void
			a_type_not_void: a_type /= Void
		do
			current_class := a_class
			create current_class_type
			current_class_type.set_actual_type (a_type)
			if current_class.lace_class.is_void_safe then
				if not current_class_type.is_attached then
						-- Current is always attached
					current_class_type.set_attached_mark
				end
				create {AST_VOID_SAFE_VARIABLE_CONTEXT} variables
			else
				if not current_class_type.is_attached and then
					not current_class_type.is_implicitly_attached
				then
						-- Current is always attached
					current_class_type.set_is_implicitly_attached
				end
				create {AST_VARIABLE_CONTEXT} variables
			end
			current_feature_table := a_feat_tbl
			written_class := Void
		ensure
			current_class_set: current_class = a_class
			current_class_type_set: current_class_type.conformance_type = a_type
				or else current_class_type.conformance_type.same_as (a_type.as_attached)
				or else current_class_type.conformance_type.same_as (a_type.as_implicitly_attached)
			current_feature_table_set: current_feature_table = a_feat_tbl
		end

	set_current_feature (f: FEATURE_I) is
			-- Assign `f' to `current_feature'.
		require
			f_not_void: f /= Void
		do
			current_feature := f
		ensure
			current_feature_set: current_feature = f
		end

	set_written_class (c: like written_class) is
			-- Set `written_class' to `c'.
		do
			written_class := c
		ensure
			written_class_set: written_class = c
		end

	set_is_ignoring_export (b: BOOLEAN) is
			-- Assign `b' to `is_ignoring_export'.
		do
			is_ignoring_export := b
		ensure
			is_ignoring_export_set: is_ignoring_export = b
		end

	set_locals (l: like locals) is
			-- Assign `l' to `locals'.
		do
			locals := l;
		end;

	set_last_conversion_info (l: like last_conversion_info) is
			-- Assign `l' to `last_conversion_info'.
		do
			last_conversion_info := l
		ensure
			last_conversion_info_set: last_conversion_info = l
		end

	init_error (e: FEATURE_ERROR) is
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

	init_byte_code (byte_code: BYTE_CODE) is
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

	set_current_inline_agent_body (body: like current_inline_agent_body) is
			-- Sets the current inline agent body
		do
			current_inline_agent_body := body
		end

feature -- Managing the type stack

	clear_all is
			-- Clear the structure: to use while changing of analyzed
			-- current_class.
		do
			current_class := Void
			current_class_type := Void
			current_feature_table := Void
			variables := Void
			clear_feature_context
		end

	clear_feature_context is
			-- Clear `current_feature' context: to use while changing of current
			-- analyzed feature.
		do
			current_feature := Void
			last_conversion_info := Void
			supplier_ids.wipe_out
			written_class := Void
			clear_local_context
		end

	clear_local_context
			-- Clear context specific to local declarations
			-- such as object test locals
		do
			locals.clear_all
			object_test_locals.wipe_out
			used_object_test_local_names.wipe_out
			scopes.wipe_out
			if variables /= Void then
				variables.wipe_out
			end
		end

feature	-- Saving contexts

	save: AST_CONTEXT is
			-- Returns a saved context
		do
			Result := twin
			create_local_containers
			used_argument_names := Void
			used_local_names := Void
			scopes.copy (Result.scopes)
			scope_keeper := Void
		end

	restore (context: AST_CONTEXT) is
			-- Restores a given context
		do
			copy (context)
		end

feature {NONE} --Internals
	old_inline_agents_int:  HASH_TABLE [FEATURE_I, INTEGER]

invariant
	locals_attached: locals /= Void
	object_test_locals_attached: object_test_locals /= Void


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

end
