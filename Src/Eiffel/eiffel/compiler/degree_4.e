note

	description: "Degree 4 during Eiffel compilation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DEGREE_4

inherit

	DEGREE
		redefine
			make
		end

	COMPILER_EXPORTER

	SHARED_SERVER
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	SHARED_GENERIC_CONSTRAINT
		export
			{NONE} all
		end

	SHARED_DEGREES
		export
			{NONE} all
		end

	SHARED_INHERITED
		rename
			Inherit_table as analyzer
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

create

	make

feature {NONE} -- Initialization

	make
			-- Create a new Degree 4.
		do
			create changed_status.make
			create ignored_classes.make (0)
		end

feature -- Access

	Degree_number: INTEGER = 4
			-- Degree number

	changed_status: TWO_WAY_SORTED_SET [INTEGER]
			-- Sorted set of all the classes for which the expanded
			-- or deferred status has changed

	ignored_classes: SEARCH_TABLE [CLASS_C]
			-- List of classes that should not be processed at degree 4 due to an
			-- error in one of their ancestors.

feature -- Processing

	execute
			-- Inheritance analysis on the changed classes. Since the
			-- classes contained in `changed_classes' are sorted by class
			-- topological ids, it ensures that a class will be treated
			-- here once the treatment of its parents is completed. That's
			-- why we re-sort the list of classes after the topological
			-- sort in order to take advantage of it.
		local
			i, nb: INTEGER
			classes: ARRAY [CLASS_C]
			a_class: CLASS_C
			l_error_level: NATURAL
			l_system: like system
			l_degree_output: like degree_output
			l_error_handler: like error_handler
		do
			l_system := system
			l_degree_output := degree_output
			l_error_handler := error_handler
			l_degree_output.put_start_degree (Degree_number, count)
			classes := l_system.classes.sorted_classes
			ignored_classes.wipe_out

				-- We need to clean the cache of feature tables since we would not know how
				-- to distinguish the previous from the current computed feature tables.
			feature_table_cache.wipe_out

				-- Reset routine IDs for `ANY.default_create', `ANY.default_rescue' and `SPECIAL.make'
				-- as they might change if they go again through degree 4.
			l_system.reset_routine_ids

				-- Check that the constraint class is a valid class.
				-- I.e. we cannot have [G -> like t] or others.
			reset_constraint_error_list

			from i := 1 until nb = count loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_4_needed then
					if not a_class.degree_4_processed then
						if a_class.changed and then a_class.generics /= Void then
							l_system.set_current_class (a_class)
							a_class.check_constraint_genericity
							if constraint_error_list /= Void and then constraint_error_list.count > 0 then
								insert_class (a_class)
							end
						end
					end
					nb := nb + 1
				end
				i := i + 1
			end

				-- Cannot continue if there is an error in the
				-- constraint genericity clause of a class.
			if l_error_handler.has_error then
				l_error_handler.raise_error
			end

			nb := 0

			empty_temp_remaining_validity_checking_list

			from i := 1 until nb = count loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_4_needed then
					if not a_class.degree_4_processed and then (ignored_classes.count = 0 or else not ignored_classes.has (a_class)) then
						l_degree_output.put_degree_4 (a_class, count - nb)
						l_system.set_current_class (a_class)
							-- Adds future checks to the `remaining_validity_checking_list'
						l_error_level := l_error_handler.error_level
						process_class (a_class)
						if l_error_handler.error_level = l_error_level then
								-- We only merge the remaining checks if the class did not produce any other errors
							merge_remaining_validity_checks_into_global_list
							a_class.set_degree_4_processed
						else
								-- We cannot add the temporary added checks so we need to get rid of them
								-- we will process them at the next compilation when user will have fix the
								-- errors reported by the user.
							empty_temp_remaining_validity_checking_list
							ignored_classes.put (a_class)
							remove_descendant_classes_from_processing (a_class)
						end
					end
					nb := nb + 1
				end
				i := i + 1
			end

				-- No need to continue if we have found some errors.
			if l_error_handler.has_error then
				l_error_handler.raise_error
			end

				-- Check now the validity on creation constraint, i.e. that the
				-- specified creation procedures are indeed part of the constraint
				-- class. This needs to be done at the end of Degree 4 because
				-- we need some feature tables.
			nb := count
			from i := 1 until nb = 0 loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_4_needed then
					if a_class.changed and then a_class.generics /= Void then
						l_system.set_current_class (a_class)
						l_error_level := l_error_handler.error_level
						a_class.check_constraint_renaming
							-- We only check the creation constraints if the renaming was valid.
						if l_error_handler.error_level = l_error_level then
							a_class.check_creation_constraint_genericity
						end
					end
					nb := nb - 1
				end
				i := i + 1
			end

				-- We cannot go on here as the creation constraints are not guaranteed to be valid.
				-- The remaining_validity_check_list will be kept. All checks will be done once we have no mroe errors.
			if l_error_handler.has_error then
				l_error_handler.raise_error
			end

				-- Check now that all the instances of a generic class are
				-- valid for the creation constraint if there is one. The
				-- checks have been stored in `remaining_validity_checking_list'.
			check_creation_constraint_instances (l_error_handler.has_error)

			if l_system.has_expanded and then not is_empty then
				l_system.check_vtec
			end

			wipe_out
			changed_status.wipe_out
			l_system.set_current_class (Void)
			l_degree_output.put_end_degree
		end

feature -- Element change

	insert_class (a_class: CLASS_C)
			-- Add `a_class' to be processed.
		local
			l_ext: EXTERNAL_CLASS_C
		do
			l_ext ?= a_class
			if l_ext = Void or else not l_ext.is_built then
				if a_class.degree_4_needed then
					if a_class.degree_4_processed then
						a_class.remove_from_degree_4
						a_class.add_to_degree_4
					end
				else
					a_class.add_to_degree_4
					count := count + 1
				end
			end
		end

feature -- Removal

	remove_class (a_class: CLASS_C)
			-- Remove `a_class'.
		do
			if a_class.degree_4_needed then
				a_class.remove_from_degree_4
				count := count - 1
			end
		end

	wipe_out
			-- Remove all classes.
		local
			i, nb: INTEGER
			classes: ARRAY [CLASS_C]
			a_class: CLASS_C
		do
			from
				i := 1
				nb := count
				classes := System.classes.sorted_classes
			until
				nb = 0
			loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_4_needed then
					a_class.remove_from_degree_4
					nb := nb - 1
				end
				i := i + 1
			end
			count := 0
		end

feature -- Setting

	set_expanded_modified (a_class: CLASS_C)
			-- The expanded status of `a_class' has been modified.
		require
			a_class_not_void: a_class /= Void
		do
			insert_class (a_class)
			a_class.set_expanded_modified
		end

	set_deferred_modified (a_class: CLASS_C)
			-- The deferred status of `a_class' has been modified.
		require
			a_class_not_void: a_class /= Void
		do
			insert_class (a_class)
			a_class.set_deferred_modified
		end

	set_supplier_status_modified (a_class: CLASS_C)
			-- The status of a supplier has changed.
		require
			a_class_not_void: a_class /= Void
		do
			insert_class (a_class)
			a_class.set_supplier_status_modified
		end

	set_assertion_prop_list (a_class: CLASS_C; l: LINKED_LIST [INTEGER])
			-- Dino stuff.
		require
			a_class_not_void: a_class /= Void
		do
			insert_class (a_class)
			a_class.set_assertion_prop_list (l)
		end

	add_changed_status (a_class: CLASS_C)
			-- Record `a_class.class_id' in `changed_status'.
		require
			a_class_not_void: a_class /= Void
		do
			set_supplier_status_modified (a_class)
			changed_status.extend (a_class.class_id)
		end

	remove_descendant_classes_from_processing (a_class: CLASS_C)
			-- Add all descendants of `a_class' to `ignored_classes'.
		require
			a_class_not_void: a_class /= Void
		local
			l_descendants: ARRAYED_LIST [CLASS_C]
		do
			from
				l_descendants := a_class.direct_descendants
				l_descendants.start
			until
				l_descendants.after
			loop
				ignored_classes.put (l_descendants.item)
				remove_descendant_classes_from_processing (l_descendants.item)
				l_descendants.forth
			end
		end


feature {NONE} -- Processing

	process_class (a_class: CLASS_C)
			-- Process Degree 4 on `a_class'.
		require
			a_class_not_void: a_class /= Void
		local
			do_pass2: BOOLEAN
			external_class: EXTERNAL_CLASS_C
			retried: BOOLEAN
		do
			if not retried then
				external_class ?= a_class
				if external_class /= Void then
					external_class.process_degree_4
				else
					if a_class.changed then
						do_pass2 := True
							-- Incrementality: Degree 3 can be done successfully
							-- on a class marked changed and then the class is
							-- reinserted in Degree 4.
						Degree_3.insert_new_class (a_class)
						Degree_2.insert_new_class (a_class)
					else
						do_pass2 := a_class.changed2
					end
					if do_pass2 then
							-- Analysis of inheritance for a class.
						analyzer.pass2 (a_class, a_class.supplier_status_modified)

							-- Update the freeze list for changed hash tables.
						Degree_1.insert_class (a_class)
					elseif a_class.assert_prop_list /= Void then
							-- Propagation of assertion modifications only.
										debug ("ACTIVITY")
											io.error.put_string ("Propagation of assertions only%N")
										end
						propagate_pass2 (a_class, False)
					end
				end
			end
		rescue
			if error_handler.rescue_status.is_error_exception  then
					-- When an error is triggered we do as if no error had occurred.
				retried := True
				retry
			end
		end

feature {INHERIT_TABLE} -- Propagation

	process_and_propagate (a_class: CLASS_C; resulting_table: FEATURE_TABLE;
		equivalent_table: BOOLEAN; pass2_control: PASS2_CONTROL;
		a_assert_prop_list: LINKED_LIST [INTEGER]; a_changed_features: ARRAYED_LIST [INTEGER])
			-- Propagate to Degree 4 and Degree 3 according to
			-- `resulting_table' and `pass2_control'.
		require
			a_class_not_void: a_class /= Void
			resulting_table_not_void: resulting_table /= Void
			pass2_control_not_void: pass2_control /= Void
		local
			real_pass2, do_pass2: BOOLEAN
			do_pass3: BOOLEAN
			chg3a: BOOLEAN
			l_descendents_with_replicated_features: LINKED_LIST [CLASS_C]
			l_desc_class: CLASS_C
		do
					debug ("ACTIVITY")
						io.error.put_string ("=============== DEGREE_4.propagate ===============%N")
						io.error.put_string ("Equivalent tables: ")
						io.error.put_boolean (equivalent_table)
						io.error.put_string ("%Nexpanded_modified: ")
						io.error.put_boolean (a_class.expanded_modified)
						io.error.put_string ("%Ndeferred_modified: ")
						io.error.put_boolean (a_class.deferred_modified)
						if a_class.assert_prop_list /= Void then
							if a_class.assert_prop_list.is_empty then
								io.error.put_string ("%Nassert_prop_list: empty")
							else
								io.error.put_string ("%Nassert_prop_list: not empty")
							end
						else
							io.error.put_string ("%Nassert_prop_list: Void")
						end
						if a_assert_prop_list /= Void then
							if a_assert_prop_list.is_empty then
								io.error.put_string ("%Nl: empty")
							else
								io.error.put_string ("%Nl: not empty")
							end
						else
							io.error.put_string ("%Nl: Void")
						end
						io.error.put_string ("%Npass2_control.propagate_pass3: ")
						io.error.put_boolean (pass2_control.propagate_pass3)
						io.error.put_string ("%Npass2_control: ")
						pass2_control.trace
						io.error.put_new_line
					end
				-- Propagation of the assertions.
			if a_class.assert_prop_list = Void then
				a_class.set_assertion_prop_list (a_assert_prop_list)
			elseif a_assert_prop_list /= Void then
				a_class.assert_prop_list.finish
				a_class.assert_prop_list.merge_right (a_assert_prop_list)
			end


				-- If any routines are changed then check for any descendents that are replicating features.
				-- If found then these routines must be fully recompiled
				--| FIXME IEK We could optimize to check if the access_in values relate to the current class
			if not System.compilation_straight and then a_changed_features /= Void and then a_changed_features.count > 0 then
					-- We need to check if any descendents are replicating features of `a_class' during an incremental compilation.
				l_descendents_with_replicated_features := a_class.descendents_with_changed_replicated_features (a_class)
				if l_descendents_with_replicated_features /= Void and then not l_descendents_with_replicated_features.is_empty then
					from
							-- Make sure that all descendents with replicated features get fully recompiled and stored.
						l_descendents_with_replicated_features.start
					until
						l_descendents_with_replicated_features.after
					loop
						l_desc_class := l_descendents_with_replicated_features.item
						if not l_desc_class.lace_class.changed then
							l_desc_class.lace_class.set_changed (True)
						end
						degree_4.insert_new_class (l_desc_class)
						degree_3.insert_new_class (l_desc_class)
						degree_2.insert_new_class (l_desc_class)
							-- Make sure that the class ast gets correctly saved so that any newly replicated
							-- features get correctly stored in the compiler servers.
						tmp_ast_server.put (l_desc_class.ast)
						l_descendents_with_replicated_features.forth
					end
				end
			end

				-- Incremetality test: asked the compiler to apply at
				-- least Degree 4 to the direct descendants of `a_class'.

			real_pass2 := (not equivalent_table) or else a_class.expanded_modified
					or else a_class.deferred_modified

				-- If the set of ancestors has changed (changed3a)
				-- we must propagate.
			chg3a := a_class.changed3a

				-- If the propagation is the result of assertion
				-- modifications, only a `light' pass2 must be done.
			do_pass2 := real_pass2 or else a_class.assert_prop_list /= Void

			if pass2_control.propagate_pass3 then
				do_pass2 := True
				do_pass3 := True
			end

			if do_pass2 or else chg3a then
					-- Propagation to Degree 4 in order to update
					-- feature table of direct descendants.
				propagate_pass2 (a_class, real_pass2)
				if do_pass3 then
						-- Propagation to Degree 3 in order to
						-- type check clients of `a_class'.
					propagate_pass3 (a_class, pass2_control, a_class.expanded_modified or a_class.deferred_modified)
				end
				if chg3a then
						-- Propagation to Degree 3 in order to type check
						-- classes which depend on the conformance of `a_class'.
					force_type_checks (a_class, pass2_control)
				end

				if not System.freeze then
					degree_2.insert_class (a_class)
				end

					-- Generate skeleton and update seeds of generic attributes

					-- Set the attribute skeleton of `a_class'
				a_class.set_skeleton (resulting_table.skeleton)

					-- Instantiate generic parameter in context of current class.
				a_class.update_generic_features
			end
		end

feature {NONE} -- Propagation to Degree 4

	propagate_pass2 (a_class: CLASS_C; real_pass2: BOOLEAN)
			-- Ask the compiler to recalculate the feature table for
			-- the direct descendants. The feature table of `a_class'
			-- has varied between two compilations, the feature tables
			-- of the direct descendants must be recalculated.
			--
			-- `a_class': Feature table of its direct descendants will be rebuild
			-- `real_pass2' states whether a descendants `changed2' flag will be set or not
		require
			a_class_not_void: a_class /= Void
		local
			descendant: CLASS_C
			desc: ARRAYED_LIST [CLASS_C]
			chg3a: BOOLEAN
			assert_prop_list: LINKED_LIST [INTEGER]
		do
							debug ("ACTIVITY")
								io.error.put_string ("Propagate_pass2. real_pass2: ")
								io.error.put_boolean (real_pass2)
								io.error.put_new_line
							end

			a_class.set_changed2 (True)
			if not System.compilation_straight then
					-- We do not need to propagate to descendents if this is the very first compilation
				desc := a_class.direct_descendants
				chg3a := a_class.changed3a
				from desc.start until desc.after loop
					descendant := desc.item
						-- Insert the descendant in the changed classes
						-- list of the system if not present.
									debug ("ACTIVITY")
										io.error.put_string ("Propagating pass2 to: ")
										io.error.put_string (descendant.name)
										io.error.put_new_line
									end
					if chg3a then
						descendant.set_changed3a (True)
					end

					Degree_4.insert_new_class (descendant)
					if real_pass2 then
							-- Mark the descendant so if it is not syntactically
							-- `changed', its feature table will be at least
							-- recalculated.
						descendant.set_changed2 (True)
					end
					if a_class.expanded_modified then
						Degree_4.set_expanded_modified (descendant)
					end
					assert_prop_list := a_class.assert_prop_list
					if assert_prop_list /= Void then
						assert_prop_list.start
						Degree_4.set_assertion_prop_list
							(descendant, assert_prop_list.duplicate (assert_prop_list.count))
					end

	-- FIXME
	-- The next line should NOT be here
	-- Check the histroy in integrator. Xavier

	-- Insertion in Degree_2 is needed

					Degree_3.insert_new_class (descendant)
						-- Insert in Degree 2 so that the skeletons
						-- of all the descendants are updated.
					Degree_2.insert_new_class (descendant)
					desc.forth
				end
			end


		end

feature {NONE} -- Propagation to Degree 3

	propagate_pass3 (a_class: CLASS_C; pass2_control: PASS2_CONTROL; status_modified: BOOLEAN)
			-- Ask the compiler to execute Degree 3 on
			-- all clients of `a_class'.
		require
			a_class_not_void: a_class /= Void
			pass2_control_not_void: pass2_control /= Void
			pass2_control_valid: pass2_control.propagate_pass3
		local
			client: CLASS_C
			clients: ARRAYED_LIST [CLASS_C]
		do
							debug ("ACTIVITY")
								io.error.put_string ("Propagate pass3%N")
							end
			if not System.compilation_straight then
				clients := a_class.clients
				from clients.start until clients.after loop
					client := clients.item
						-- Remember the cause for type checking `client'.
								debug ("ACTIVITY")
									io.error.put_string ("Propagating pass3 to: ")
									io.error.put_string (client.name)
									io.error.put_new_line
								end
					client.propagators.update (pass2_control)
					if status_modified then
						client.propagators.add_changed_status (a_class.class_id)
					end
						-- Insert the client in the changed classes
						-- list of the system if not present.
					Degree_3.insert_new_class (client)
					Degree_2.insert_new_class (client)

					clients.forth
				end
			end
		end

feature {NONE} -- Implementation

	force_type_checks (a_class: CLASS_C; pass2_control: PASS2_CONTROL)
			-- Force type checks on conformance dependent classes.
		require
			a_class_not_void: a_class /= Void
			pass2_control_not_void: pass2_control /= Void
		local
			cdc: LINKED_LIST [CLASS_C]
			cdi: CLASS_C
		do
			cdc := a_class.conf_dep_classes
			if cdc /= Void then
				from cdc.start until cdc.after loop
					cdi := cdc.item
					cdi.propagators.update (pass2_control)
						-- Losing an ancestor is considered to
						-- be a status change.
					cdi.propagators.add_changed_status (a_class.class_id)

						-- Force a type check on the class.
					cdi.set_need_type_check (True)

					Degree_3.insert_new_class (cdi)
					Degree_2.insert_new_class (cdi)
					cdc.forth
				end
			end
		end

feature {NONE} -- Generic checking

	check_creation_constraint_instances (a_error_occurred: BOOLEAN)
			-- If not `a_error_occurred' check that all the generic
			-- declarations where the generic class defines a creation
			-- constraint clause are system valid.
		local
			generic_creation_list: LINKED_LIST [FUTURE_CHECKING_INFO]
			constraint_info: FUTURE_CHECKING_INFO
		do
			generic_creation_list := remaining_validity_checking_list
			from
				generic_creation_list.start
			until
				generic_creation_list.after
			loop
				constraint_info := generic_creation_list.item
				if a_error_occurred then
						-- We cannot do the type checking yet, so we have to fill
						-- `changed_classes' to memorize classes that need a recompilation.
					insert_class (constraint_info.context_class)
				else
					system.set_current_class (constraint_info.context_class)
					constraint_info.action.call (Void)
					if not constraint_error_list.is_empty then
							-- Fill `changed_classes' to memorize the
							-- classes that need a recompilation.
						insert_class (constraint_info.context_class)
					end
				end
				generic_creation_list.forth
			end

				-- We clear the list of classes that need to be checked at the end
				-- of degree 4 since we checked everything. If there was some errors, they
				-- are stored and they will be re-checked at the next compilation.
			reset_remaining_validity_checking_list

				-- Cannot continue if there is an error in the
				-- creation constraint genericity clause of a class.
			if error_handler.has_error then
				error_handler.raise_error
			end
		end

invariant
	changed_status_not_void: changed_status /= Void
	ignored_classes_not_void: ignored_classes /= Void

note
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

end -- class DEGREE_4




