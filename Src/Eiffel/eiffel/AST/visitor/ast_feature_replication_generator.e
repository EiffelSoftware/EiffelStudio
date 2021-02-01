note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AST_FEATURE_REPLICATION_GENERATOR

inherit
	AST_ITERATOR
		redefine
			process_routine_as,
			process_access_id_as,
			process_access_assert_as,
			process_require_as,
			process_require_else_as,
			process_ensure_as,
			process_ensure_then_as,
			process_precursor_as
		end

	SHARED_SERVER

	SHARED_INHERITED
		undefine
			copy, is_equal
		end

	COMPILER_EXPORTER

	INTERNAL_COMPILER_STRING_EXPORTER

feature -- Processing

	process_replicated_feature (a_feature: FEATURE_I; a_parent_c: PARENT_C; a_selected: BOOLEAN; a_current_class: CLASS_C; old_t, new_t: FEATURE_TABLE)
			-- Perform processing on replicated feature `a_feature'.
			-- `a_parent_c' may be Void if a replicated feature is redefined.
		require
			a_feature_valid: a_feature /= Void
			a_feature_replicated: a_feature.is_replicated
			a_current_class_not_void: a_current_class /= Void
			a_feature_replicated_in_current_class: not system.has_old_feature_replication implies a_feature.access_in = a_current_class.class_id
		local
			l_feature_as: FEATURE_AS
			l_old_feature: FEATURE_I
			l_body_index: INTEGER
			l_body: FEATURE_AS
			l_feature_name_id: INTEGER
			l_compute_new_body_index: BOOLEAN
			l_old_feature_equivalent: BOOLEAN
		do
				-- Reset state flags
			needs_explicit_replication := False

			feature_i := a_feature
			parent_c := a_parent_c
				-- `parent_c' may be Void if `a_feature' is the result of a redefinition or undefinition.
				-- If this is the case then we don't need to perform any processing as the AST is already at the level of access_in.
				-- This means that the byte nodes get generated
			if a_parent_c /= Void then
					-- We need to perform a deep twin of the feature AST.
					-- so that there is no aliasing between AST nodes.
				l_feature_as := a_feature.body.deep_twin

					-- Process replicated AST body content to account for renames within the same inheritance branch.
					-- We can also check to see if explicit replication needs to be performed.
				safe_process (l_feature_as.body.content)

				if not (a_feature.is_once and then a_selected) then
						-- We do not want to regenerate a new body index for 'once' routines.
						-- unless there is explicit replication.
						-- Reuse previous feature information if available.
					l_feature_name_id := a_feature.feature_name_id
					if old_t /= Void then
						l_old_feature := old_t.item_id (l_feature_name_id)
					end

					if l_old_feature /= Void and then l_old_feature.is_replicated_directly then
							-- Reuse the previous id.
						l_body_index := l_old_feature.body_index
							-- Set ID of feature AS to be that of the previous feature.
						l_body := l_old_feature.body


						if l_body = Void then
							l_compute_new_body_index := True
						else
								-- Reuse old feature ID.
							l_feature_as.set_id (l_old_feature.id)

							l_old_feature_equivalent := l_body.is_equivalent (l_feature_as)
								-- If True then nothing has changed from the previous compilation
								-- so we can reuse old routine.
						end
					else
						l_compute_new_body_index := True
					end

					if not l_old_feature_equivalent then
						if l_compute_new_body_index then
								-- Create a new id for the feature body and index
							l_body_index := System.body_index_counter.next_id
							l_feature_as.set_id (System.feature_as_counter.next_id)
						end
							-- Mark feature as changed so that it gets melted.
						inherit_table.changed_features.extend (l_feature_name_id)
					else
							-- Reuse replicated feature body.
						l_feature_as := l_body
					end

						-- Make sure that replicated features always gets stored to disk even if no change has been made.
					tmp_ast_server.body_force (a_current_class.class_id, l_feature_as, l_body_index)

					a_feature.set_body_index (l_body_index)

						-- Body was replicated, we need to setup `access_in' properly.
					a_feature.set_access_in (a_current_class.class_id)

						-- We need to add the replicated feature as to the class as
						-- so that it may be stored to disk for incrementality
						--| FIXME IEK We need a better mechanism for doing this.
					a_current_class.ast.replicated_features.extend (l_feature_as)
					a_current_class.replicated_features_list.extend (a_feature.rout_id_set.first)

						-- Set replicated AST flag so that we know a new body and index has been created.
					a_feature.set_has_replicated_ast (True)

						-- Copy the routine id to avoid aliasing from other descendents of inherited routine.
					a_feature.set_rout_id_set (a_feature.rout_id_set.twin)
				end
					-- Set direct replication flag so that it is easy to determine
					-- whether the feature has been replicated in the current class
					-- Currently once a feature is marked as replicated (by its type) it
					-- is not unreplicated if then inherited by a descendent so we need
					-- a flag to distinguish the two types of replicated features.
				a_feature.set_is_replicated_directly (True)
			else
					-- This routine is either joined or redefined in `a_current_class', if redefined
					-- in current class then we need to set it as directly replicated so that
					-- VMCS errors are correctly detected.
				a_feature.set_is_replicated_directly (a_current_class.class_id = a_feature.written_in)
			end

				-- Reset values
			routine_as := Void
			feature_i := Void
			parent_c := Void
		end

feature -- Access

	routine_as: ROUTINE_AS
		-- Routine AS that is currently being processed

	feature_i: FEATURE_I
		-- Feature that is currently being processed

	parent_c: PARENT_C
		-- Parent class used for detecting AST manipulation

feature {NONE} -- Implementation

	call_is_valid_for_processing (a_name_id: INTEGER): BOOLEAN
			-- Is call to `a_name_id' valid for replication processing.
		require
			values_set: feature_i /= Void and then routine_as /= Void
		do
			Result := feature_i.argument_position (a_name_id) = 0
					-- Call must not be an argument.
			if Result and then routine_as.locals /= Void then
					-- Call must not be a local.
				from
					routine_as.locals.start
				until
					not Result or else routine_as.locals.after
				loop
					Result := not routine_as.locals.item.id_list.has (a_name_id)
					routine_as.locals.forth
				end
			end
			if Result and then routine_as.object_test_locals /= Void then
					-- Call must not be an object test local.
				from
					routine_as.object_test_locals.start
				until
					not Result or else routine_as.object_test_locals.after
				loop
					Result := routine_as.object_test_locals.item.name.name_id /= a_name_id
					routine_as.object_test_locals.forth
				end
			end
		end

	process_renaming (a_access_inv_as: ACCESS_INV_AS)
			-- Process renaming for unqualified call.
		require
			access_inv_as_not_void: a_access_inv_as /= Void
		local
			l_renaming: RENAMING
			l_feature_name: ID_AS
			l_feature_name_id: INTEGER
			l_parent_feature_table: FEATURE_TABLE
			l_parent_feature, l_written_feature, l_new_feature: FEATURE_I
		do
			l_feature_name := a_access_inv_as.feature_name
			l_feature_name_id := l_feature_name.name_id
			if
				parent_c /= Void and then
				call_is_valid_for_processing (l_feature_name_id)
			then
				if parent_c.is_renaming (l_feature_name_id) then
						-- The unqualified routine call to `l_feature_name' is being renamed in the branch so
						-- therefore we need to perform the textual update.
					l_renaming := parent_c.renaming.item (l_feature_name_id)
					a_access_inv_as.set_class_id (System.current_class.class_id)
						-- Reset now invalid routine id.
					a_access_inv_as.wipe_out
					l_feature_name.set_name (l_renaming.names_heap.item (l_renaming.feature_name_id))
					needs_explicit_replication := needs_explicit_replication or else parent_c.is_redefining (l_feature_name.name_id)
				else
						-- Check if the routine has been renamed or redefined from the callee's class.
					l_written_feature := feature_i.written_class.feature_table.item_id (l_feature_name_id)
					if l_written_feature /= Void then
						l_parent_feature_table := parent_c.parent.feature_table
						l_parent_feature := l_parent_feature_table.item_id (l_feature_name_id)
						if (l_parent_feature = Void or else l_written_feature.body_index /= l_parent_feature.body_index) then
								-- Feature has been changed from its origin so we need to retrieve the new feature in immediate parent.
							l_new_feature := l_parent_feature_table.feature_of_rout_id_set (l_written_feature.rout_id_set)
							a_access_inv_as.set_class_id (System.current_class.class_id)
								-- Reset now invalid routine id.
							a_access_inv_as.wipe_out
							l_feature_name.set_name (l_new_feature.feature_name)
							needs_explicit_replication := True
						end
					end
				end
			end
		end

	process_routine_as (l_as: ROUTINE_AS)
			-- <Precursor>
		do
			routine_as := l_as
			Precursor (l_as)
		end

	process_precursor_as (l_as: PRECURSOR_AS)
			-- <Precursor>
		do
			Precursor (l_as)
		end

	process_access_id_as (l_as: ACCESS_ID_AS)
			-- <Precursor>
		do
			process_renaming (l_as)
			Precursor (l_as)
		end

	process_access_assert_as (l_as: ACCESS_ASSERT_AS)
			-- <Precursor>
		do
			process_renaming (l_as)
			Precursor (l_as)
		end

	process_require_as (l_as: REQUIRE_AS)
			-- <Precursor>
		do
			Precursor (l_as)
			safe_process (l_as.full_assertion_list)
		end

	process_require_else_as (l_as: REQUIRE_ELSE_AS)
			-- <Precursor>
		do
			Precursor (l_as)
			safe_process (l_as.full_assertion_list)
		end

	process_ensure_as (l_as: ENSURE_AS)
			-- <Precursor>
		do
			Precursor (l_as)
			safe_process (l_as.full_assertion_list)
		end

	process_ensure_then_as (l_as: ENSURE_THEN_AS)
			-- <Precursor>
		do
			Precursor (l_as)
			safe_process (l_as.full_assertion_list)
		end

	needs_explicit_replication: BOOLEAN
		-- Flags whether a routine needs to be explicitly replicated
		-- ie: An unqualified call to a renamed feature that has also been redefined in the branch.
		-- Used for detemining whether a once function needs a new body index.

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
