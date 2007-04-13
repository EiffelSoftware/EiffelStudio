indexing

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

	make is
			-- Create a new Degree 4.
		do
			create changed_status.make
		end

feature -- Access

	Degree_number: INTEGER is 4
			-- Degree number

	changed_status: TWO_WAY_SORTED_SET [INTEGER]
			-- Sorted set of all the classes for which the expanded
			-- or deferred status has changed

feature -- Processing

	execute is
			-- Inheritance analysis on the changed classes. Since the
			-- classes contained in `changed_classes' are sorted by class
			-- topological ids, it ensures that a class will be treated
			-- here once the treatment of its parents is completed. That's
			-- why we re-sort the list of classes after the topological
			-- sort in order to take advantage of it.
		local
			i, nb, j: INTEGER
			classes: ARRAY [CLASS_C]
			a_class: CLASS_C
			l_error_count_before: INTEGER
			l_remaining_validity_checking_list_count: INTEGER
		do
			Degree_output.put_start_degree (Degree_number, count)
			classes := System.classes.sorted_classes

				-- Check that the constraint class is a valid class.
				-- I.e. we cannot have [G -> like t] or others.
			reset_constraint_error_list

			fixme ("MTNTODO: remove this line, it is used together with the check below to ensure that an assumption I have made is correct.")
			l_remaining_validity_checking_list_count := remaining_validity_checking_list.count

			from i := 1 until nb = count loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_4_needed then
					if not a_class.degree_4_processed then
						if a_class.changed and then a_class.generics /= Void then
							System.set_current_class (a_class)
							a_class.check_constraint_genericity
							if constraint_error_list /= Void and then not constraint_error_list.is_empty then
								insert_class (a_class)
							end
						end
					end
					nb := nb + 1
				end
				i := i + 1
			end

			check
				no_new_delayed_checks: l_remaining_validity_checking_list_count = remaining_validity_checking_list.count
			end

				-- Cannot continue if there is an error in the
				-- constraint genericity clause of a class.
			Error_handler.checksum

			nb := 0

			empty_temp_remaining_validity_checking_list

			from i := 1 until nb = count loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_4_needed then
					if not a_class.degree_4_processed then
						j := j + 1
						Degree_output.put_degree_4 (a_class, count - nb)
						System.set_current_class (a_class)
							-- Adds future checks to the `remaining_validity_checking_list'
						process_class (a_class)
						check
							No_error: not Error_handler.has_error
						end
							-- We only merge the remaining checks if the class did not produce any other errors
						merge_remaining_validity_checks_into_global_list
						a_class.set_degree_4_processed
					end
					nb := nb + 1
				end
				i := i + 1
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
						System.set_current_class (a_class)
						l_error_count_before := error_handler.nb_errors
						a_class.check_constraint_renaming
							-- We only check the creation constraitns if the renaming was valid.
						if error_handler.nb_errors = l_error_count_before then
							a_class.check_creation_constraint_genericity
						end

					end
					nb := nb - 1
				end
				i := i + 1
			end

				-- We cannot go on here as the creation constraints are not guaranteed to be valid.
				-- The remaining_validity_check_list will be kept. All checks will be done once we have no mroe errors.
			error_handler.checksum

				-- Check now that all the instances of a generic class are
				-- valid for the creation constraint if there is one. The
				-- checks have been stored in `remaining_validity_checking_list'.
			check_creation_constraint_instances (error_handler.has_error)

			if System.has_expanded and then not is_empty then
				System.check_vtec
			end

			wipe_out

			changed_status.wipe_out
			System.set_current_class (Void)
			Degree_output.put_end_degree
		end

feature -- Element change

	insert_class (a_class: CLASS_C) is
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

	remove_class (a_class: CLASS_C) is
			-- Remove `a_class'.
		do
			if a_class.degree_4_needed then
				a_class.remove_from_degree_4
				count := count - 1
			end
		end

	wipe_out is
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

	set_expanded_modified (a_class: CLASS_C) is
			-- The expanded status of `a_class' has been modified.
		require
			a_class_not_void: a_class /= Void
		do
			insert_class (a_class)
			a_class.set_expanded_modified
		end

	set_deferred_modified (a_class: CLASS_C) is
			-- The deferred status of `a_class' has been modified.
		require
			a_class_not_void: a_class /= Void
		do
			insert_class (a_class)
			a_class.set_deferred_modified
		end

	set_supplier_status_modified (a_class: CLASS_C) is
			-- The status of a supplier has changed.
		require
			a_class_not_void: a_class /= Void
		do
			insert_class (a_class)
			a_class.set_supplier_status_modified
		end

	set_assertion_prop_list (a_class: CLASS_C; l: LINKED_LIST [INTEGER]) is
			-- Dino stuff.
		require
			a_class_not_void: a_class /= Void
		do
			insert_class (a_class)
			a_class.set_assertion_prop_list (l)
		end

	add_changed_status (a_class: CLASS_C) is
			-- Record `a_class.class_id' in `changed_status'.
		require
			a_class_not_void: a_class /= Void
		do
			set_supplier_status_modified (a_class)
			changed_status.extend (a_class.class_id)
		end

feature {NONE} -- Processing

	process_class (a_class: CLASS_C) is
			-- Process Degree 4 on `a_class'.
		require
			a_class_not_void: a_class /= Void
		local
			do_pass2: BOOLEAN
			external_class: EXTERNAL_CLASS_C
		do
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

						-- No error happened: set the compilation
						-- status of `class_c'.
					check
						No_error: not Error_handler.has_error
					end

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
		ensure
			no_error: not Error_handler.has_error
		end

feature {INHERIT_TABLE} -- Propagation

	propagate (a_class: CLASS_C; resulting_table: FEATURE_TABLE;
		equivalent_table: BOOLEAN; pass2_control: PASS2_CONTROL;
		l: LINKED_LIST [INTEGER]) is
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
						if l /= Void then
							if l.is_empty then
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
				a_class.set_assertion_prop_list (l)
			elseif l /= Void then
				a_class.assert_prop_list.finish
				a_class.assert_prop_list.merge_right (l)
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

				a_class.set_skeleton (resulting_table.skeleton)
				if not System.freeze then
					degree_2.insert_class (a_class)
				end
			end
		end

feature {NONE} -- Propagation to Degree 4

	propagate_pass2 (a_class: CLASS_C; real_pass2: BOOLEAN) is
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
			desc := a_class.descendants
			a_class.set_changed2 (True)
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

feature {NONE} -- Propagation to Degree 3

	propagate_pass3 (a_class: CLASS_C; pass2_control: PASS2_CONTROL; status_modified: BOOLEAN) is
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

feature {NONE} -- Implementation

	force_type_checks (a_class: CLASS_C; pass2_control: PASS2_CONTROL) is
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
					Degree_3.insert_new_class (cdi)
					Degree_2.insert_new_class (cdi)
					cdc.forth
				end
			end
		end

feature {NONE} -- Generic checking

	check_creation_constraint_instances (a_error_occurred: BOOLEAN) is
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
			Error_handler.checksum
		end

invariant

	changed_status_not_void: changed_status /= Void

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

end -- class DEGREE_4


