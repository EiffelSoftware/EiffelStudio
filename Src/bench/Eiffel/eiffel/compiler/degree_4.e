indexing

	description: "Degree 4 during Eiffel compilation"
	status: "See notice at end of class"
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
	SHARED_ERROR_HANDLER
	SHARED_GENERIC_CONSTRAINT
	SHARED_DEGREES
	SHARED_INHERITED
		rename
			Inherit_table as analyzer
		end

creation

	make

feature {NONE} -- Initialization

	make is
			-- Create a new Degree 4.
		do
			!! changed_status.make
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
			mem: MEMORY
		do
			Degree_output.put_start_degree (Degree_number, count)
			classes := System.classes.sorted_classes

				-- Check that the constraint class is a valid class.
				-- I.e. we cannot have [G -> like t] or others.
			from i := 1 until nb = count loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_4_needed then
					if not a_class.degree_4_processed then
						if a_class.changed and then a_class.generics /= Void then
							System.set_current_class (a_class)
							a_class.check_constraint_genericity
						end
					end
					nb := nb + 1
				end
				i := i + 1
			end

				-- Cannot continue if there is an error in the
				-- constraint genericity clause of a class.
			Error_handler.checksum

			nb := 0
			create mem
			from i := 1 until nb = count loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_4_needed then
					if not a_class.degree_4_processed then
						System.set_current_class (a_class)

						if (j \\ 1000) = 0 then
							mem.full_collect
							mem.full_coalesce
						end
						j := j + 1

						Degree_output.put_degree_4 (a_class, count - nb)
						process_class (a_class)
						a_class.set_degree_4_processed
					end
					nb := nb + 1
				end
				i := i + 1
			end

				-- Check now the validity on creation constraint, i.e. that the
				-- specified creation procedures are indeed part of the constraint
				-- class. This need to be done at the end of Degree 4 because
				-- we need some feature tables.
			nb := count
			from i := 1 until nb = 0 loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_4_needed then
					if a_class.changed and then a_class.generics /= Void then
						System.set_current_class (a_class)
						a_class.check_creation_constraint_genericity
					end
					nb := nb - 1
				end
				i := i + 1
			end

				-- Cannot continue if there is an error in the declaration
				-- of creation constraint genericity clause of a class.
			Error_handler.checksum

				-- Check now that all the instances of a generic class are
				-- valid for the creation constraint if there is one. The
				-- checks have been stored in `remaining_validity_checking_list'.
			check_creation_constraint_instances

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
		do
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

feature -- Removal

	remove_class (a_class: CLASS_C) is
			-- Remove `a_class'.
		local
			generic_creation_list: LINKED_LIST [CONSTRAINT_CHECKING_INFO]
			constraint_info: CONSTRAINT_CHECKING_INFO
		do
			if a_class.degree_4_needed then
				a_class.remove_from_degree_4
				count := count - 1
			end

				-- Remove class from remaining_validity_checking_list
			generic_creation_list := remaining_validity_checking_list
			from
				generic_creation_list.start
			until
				generic_creation_list.after
			loop
				constraint_info := generic_creation_list.item
				if
					constraint_info.to_check.associated_class = Void or else
					constraint_info.to_check.associated_class = a_class
				then
					generic_creation_list.remove
				else
					generic_creation_list.forth
				end
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

	set_separate_modified (a_class: CLASS_C) is
			-- The separate status of `a_class' has been modified.
		require
			a_class_not_void: a_class /= Void
		do
			insert_class (a_class)
			a_class.set_separate_modified
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
		do
			a_class.set_reverse_engineered (False)
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
						io.error.put_string ("%Nseparate_modified: ")
						io.error.put_boolean (a_class.separate_modified)
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
					or else a_class.deferred_modified or else a_class.separate_modified

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
					propagate_pass3 (a_class, pass2_control, a_class.expanded_modified or a_class.deferred_modified or a_class.separate_modified)
				end
				if chg3a then
						-- Propagation to Degree 3 in order to type check
						-- classes which depend on the conformance of `a_class'.
					force_type_checks (a_class, pass2_control)
				end

				a_class.set_skeleton (resulting_table.skeleton)
				if not System.freeze then
					resulting_table.melt
				end
			end
		end

feature {NONE} -- Propagation to Degree 4
	
	propagate_pass2 (a_class: CLASS_C; real_pass2: BOOLEAN) is
			-- Ask the compiler to recalculate the feature table for
			-- the direct descendants. The feature table of `a_class'
			-- has varied between two compilations, the feature tables
			-- of the direct descendants must be recalculated.
		require
			a_class_not_void: a_class /= Void
		local
			descendant: CLASS_C
			desc: LINKED_LIST [CLASS_C]
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
			clients: LINKED_LIST [CLASS_C]
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

	check_creation_constraint_instances is
			-- Check that all the generic declarations where the generic
			-- class defines a creation constraint clause are system valid.
		local
			generic_creation_list: LINKED_LIST [CONSTRAINT_CHECKING_INFO]
			constraint_info: CONSTRAINT_CHECKING_INFO
			vtcg7: VTCG7
		do
			generic_creation_list := remaining_validity_checking_list
			from
				generic_creation_list.start
			until
				generic_creation_list.after
			loop
				reset_constraint_error_list
				constraint_info := generic_creation_list.item
					-- Check that class has not been removed from system
					-- after an error during compilation.
				if constraint_info.gen_type_a.associated_class /= Void then
					constraint_info.gen_type_a.creation_constraint_check(
						constraint_info.formal_dec_as,
						constraint_info.constraint_type,
						constraint_info.context_class,
						constraint_info.to_check,
						constraint_info.i,
						constraint_info.formal_type)
					if not constraint_error_list.is_empty then
							-- The feature listed in the creation constraint have
							-- not been declared in the constraint class.
						!! vtcg7
						vtcg7.set_class (constraint_info.context_class)
						vtcg7.set_error_list (constraint_error_list)
						vtcg7.set_parent_type (constraint_info.gen_type_a)
						Error_handler.insert_error (vtcg7)

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

end -- class DEGREE_4


--|----------------------------------------------------------------
--| Copyright (C) 1992-2000, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
