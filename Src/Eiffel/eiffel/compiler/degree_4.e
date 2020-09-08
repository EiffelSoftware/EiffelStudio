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

	SHARED_AST_CONTEXT
		export
			{NONE} all
		end

	SHARED_INSTANTIATOR
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
			create delayed_classes.make (0)
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
			create actions.make (2)
			initialize_qualified_suppliers
			l_system := system
			l_degree_output := degree_output
			l_error_handler := error_handler
			l_degree_output.put_start_degree (Degree_number, count)
			classes := l_system.classes.sorted_classes
			ignored_classes.wipe_out
			delayed_classes.wipe_out

				-- We need to clean the cache of feature tables since we would not know how
				-- to distinguish the previous from the current computed feature tables.
			feature_table_cache.wipe_out

				-- Reset routine IDs for `ANY.default_create', `ANY.default_rescue' and `SPECIAL.make'
				-- as they might change if they go again through degree 4.
			l_system.reset_routine_ids

			reset_constraint_error_list

				-- Check that the constraint class is a valid class.
				-- I.e. we cannot have [G -> like t] or a constraint
				-- with the wrong number of actual generic parameters.
			from
				nb := 0
				i := 1
			until
				nb = count
			loop
				a_class := classes.item (i)
				if attached a_class and then a_class.degree_4_needed then
					if
						not a_class.degree_4_processed and then
						a_class.changed and then
						attached a_class.generics
					then
						l_system.set_current_class (a_class)
						a_class.check_types_in_constraints
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

				-- Now check that for each constraint, they are themselves ok,
				-- e.g. class A [G -> LIST [INTEGER]], we need to ensure that `INTEGER'
				-- conforms to the constraints of the corresponding formal in LIST.
			from
				nb := 0
				i := 1
			until
				nb = count
			loop
				a_class := classes.item (i)
				if attached a_class and then a_class.degree_4_needed then
					if
						not a_class.degree_4_processed and then
						a_class.changed and then
						attached a_class.generics
					then
						l_system.set_current_class (a_class)
						a_class.check_constraint_genericity
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

				-- We need to clean `instantiator' of all the types that do not make sense
				-- anymore (see eweasel test#incr282). It used to be done before calling
				-- `execute' but this would trigger some assertion violations if some of the
				-- constraints in the new system are not valid. See eweasel test#incr386.
			if instantiator.is_clean_up_requested then
				instantiator.clean_all
			end

				-- Unmark classes as processed to take into account the case when
				-- they have been marked as processed but then an error has been raised.
				-- (This fixes several incrementality bugs, including test#inct417, test#incr418, test#incr419.)
			from
				nb := 0
				i := 1
			until
				nb = count
			loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_4_needed then
					a_class.unset_degree_4_processed
					nb := nb + 1
				end
				i := i + 1
			end

			empty_temp_remaining_validity_checking_list

				-- Process classes until there are no more.
				-- Since number of classes can be changed, `count' is not cached.
			from
				nb := 0
			until
				nb = count
			loop
					-- Run over all classes in the system.
					-- If new classes are added for recompilation,
					-- they will be processed at the next iteration.
				from
					i := 1
				until
					i > classes.upper
				loop
					a_class := classes.item (i)
					if
						attached a_class and then
						a_class.degree_4_needed and then
						not a_class.degree_4_processed and then
						(ignored_classes.count = 0 or else not ignored_classes.has (a_class))
					then
						l_degree_output.put_degree_4 (a_class, count - nb)
							-- Set current class now.
						l_system.set_current_class (a_class)
						put_action_class
							-- If class has creation constraints they are checked later
							-- but before feature type checks since constraints can have
							-- renamings that are taken into account when checking
							-- qualified anchored types.
						if
							attached a_class.generics as g and then
							g.there_exists (agent {FORMAL_DEC_AS}.has_constraint)
						then
								-- Add action to check constraints.
							put_action (agent
								local
									e: like error_handler.error_level
								do
									check
										current_class_set: attached system.current_class as c
									then
										e := error_handler.error_level
										c.check_constraint_renaming
											-- We only check the creation constraints if the renaming was valid.
										if error_handler.error_level = e then
											c.check_creation_constraint_genericity
										end
									end
								end
							)
						end
							-- Adds future checks to the `remaining_validity_checking_list'
						l_error_level := l_error_handler.error_level
						process_class (a_class)
						if l_error_handler.error_level = l_error_level then
								-- We only merge the remaining checks if the class did not produce any other errors
							merge_remaining_validity_checks_into_global_list
						else
								-- We cannot add the temporary added checks so we need to get rid of them
								-- we will process them at the next compilation when user will have fix the
								-- errors reported by the user.
							empty_temp_remaining_validity_checking_list
							ignored_classes.put (a_class)
							remove_descendant_classes_from_processing (a_class)
						end
						nb := nb + 1
					end
					i := i + 1
				end
				from
					delayed_classes.start
				until
					delayed_classes.after
				loop
					if attached delayed_classes.item_for_iteration as d and then not d.degree_4_needed then
							-- Mark class for processing.
						d.set_changed2 (True)
						insert_new_class (d)
							-- See eweasel test#incr353, we need to ensure that code generation is properly done
							-- on the client class as well. This is a workaround, because ideally, when
							-- we do a degree 4 pass on `d' we should detect that the signature has changed.
						if not d.lace_class.changed then
							d.lace_class.set_changed (True)
						end
						degree_3.insert_new_class (d)
						degree_2.insert_new_class (d)
							-- Actions should not be applied to the classes that are descendants of the affected ones.
							-- These descendants will be processed again after processing their ancestors.
						remove_descendant_classes_from_processing (d)
					end
					delayed_classes.forth
				end
					-- Run delayed actions.
				from
					actions.start
				until
					actions.after
				loop
					a_class := system.class_of_id (actions.item.class_id)
					if not ignored_classes.has (a_class) then
						system.set_current_class (a_class)
						context.initialize (a_class, a_class.actual_type)
						across
							actions.item.actions as a
						from
								-- Stop processing of the current class as soon as there is an error.
							l_error_level := l_error_handler.error_level
						until
							l_error_level /= l_error_handler.error_level
						loop
							a.item.call (Void)
						end
						if l_error_handler.error_level = l_error_level then
								-- Mark the class as processed.
							a_class.set_degree_4_processed
							if attached qualified_suppliers as q then
									-- Record new qualified suppliers if any.
								a_class.set_qualified_suppliers (qualified_suppliers.item (a_class.class_id))
							else
									-- Record that there are no qualified suppliers in class `a_class'.
								a_class.set_qualified_suppliers (Void)
							end
						else
								-- The class has errors, avoid marking it and its descendants as processed.
							ignored_classes.put (a_class)
							remove_descendant_classes_from_processing (a_class)
						end
					end
					actions.forth
				end
					-- If there are any other actions on a new iteration, they'll be registered again.
				actions.wipe_out
					-- No need to continue if we have found some errors.
				if l_error_handler.has_error then
					l_error_handler.raise_error
				end
					-- Remove all ignored classes as they may need to be processed again
					-- if there were no errors.
				ignored_classes.wipe_out
					-- Recompute the number of classes that need processing.
					-- Take the total number of classes that need degree 4 and deduct the number of classes that were not processed yet.
				nb := count
				across
					classes as each
				loop
					if attached each.item as c and then c.degree_4_needed and then not c.degree_4_processed then
						nb := nb - 1
					end
				end
			end

				-- Flush features that are computed with a delay.
			tmp_feature_server.flush_delayed

				-- Check now that all the instances of a generic class are
				-- valid for the creation constraint if there is one. The
				-- checks have been stored in `remaining_validity_checking_list'.
			check_creation_constraint_instances (l_error_handler.has_error)

			if l_system.has_expanded and then not is_empty then
				l_system.check_vtec
			end

				-- Reset all inheritance helper structures.
			analyzer.wipe_out
			analyzer.origin_table.wipe_out
			analyzer.selection_list_cache.reset_all
			analyzer.inherit_feat_cache.reset_all
			analyzer.inherit_info_cache.reset_all

				-- Wipe out feature table cache.
			feature_table_cache.wipe_out
			wipe_out

			changed_status.wipe_out
			l_system.set_current_class (Void)
			l_degree_output.put_end_degree
			actions := Void
			clear_qualified_suppliers
		end

feature -- Element change

	insert_class (a_class: CLASS_C)
			-- Add `a_class' to be processed.
		do
			if not attached {EXTERNAL_CLASS_C} a_class as l_ext or else not l_ext.is_built then
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
			delayed_classes.wipe_out
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

	set_once_modified (a_class: CLASS_C)
			-- The once status of `a_class` has been modified.
		require
			a_class_not_void: a_class /= Void
		do
			insert_class (a_class)
			a_class.set_once_modified
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

feature -- Actions to be done at the end of degree

	is_action_class_set: BOOLEAN
			-- Is class to add actions set?
		do
			Result :=
				attached actions as a and then
				not a.is_empty and then
				a.last.class_id = system.current_class.class_id
		end

	put_action_class
			-- Record the class to add actions using `put_action'.
		require
			not is_action_class_set
			current_class_attached: attached system.current_class
		do
			if attached actions as a then
				a.extend ([create {ARRAYED_LIST [PROCEDURE]}.make (1), system.current_class.class_id])
			end
		ensure
			is_action_class_set: is_action_class_set
		end

	put_action (a: PROCEDURE)
			-- Record action `a' to be executed at the end of degree.
		require
			a_attached: attached a
			is_action_class_set: is_action_class_set
		do
			if attached actions as l then
				l.last.actions.extend (a)
			end
		ensure
			a_added_as_last: attached actions as l implies l.last.actions.last = a
		end

feature {NONE} -- Actions to be done at the end of degree

	delayed_classes: SEARCH_TABLE [CLASS_C]
			-- Classes marked for recompilation during this degree

	actions: ARRAYED_LIST [TUPLE [actions: ARRAYED_LIST [PROCEDURE]; class_id: INTEGER_32]]
			-- Actions to be done at the end of degree for the class identified by class ID

feature {NONE} -- Processing

	process_class (a_class: CLASS_C)
			-- Process Degree 4 on `a_class'.
		require
			a_class_not_void: a_class /= Void
		local
			do_pass2: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				if attached {EXTERNAL_CLASS_C} a_class as external_class then
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
			is_skeleton_required: BOOLEAN
		do
			debug ("ACTIVITY")
				io.error.put_string ("=============== DEGREE_4.propagate ===============%N")
				io.error.put_string ("Equivalent tables: ")
				io.error.put_boolean (equivalent_table)
				io.error.put_string ("%Nexpanded_modified: ")
				io.error.put_boolean (a_class.expanded_modified)
				io.error.put_string ("%Ndeferred_modified: ")
				io.error.put_boolean (a_class.deferred_modified)
				io.error.put_string ("%Nonce_modified: ")
				io.error.put_boolean (a_class.once_modified)
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
					-- Make sure that all descendents with replicated features get fully recompiled and stored.
				a_class.recompile_descendants_with_replication (True)
			end

				-- Incremetality test: asked the compiler to apply at
				-- least Degree 4 to the direct descendants of `a_class'.

			real_pass2 := (not equivalent_table) or else
					a_class.expanded_modified or else
					a_class.deferred_modified or else
					a_class.once_modified

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
					propagate_pass3 (a_class, pass2_control,
						a_class.expanded_modified or
						a_class.deferred_modified or
						a_class.once_modified)
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
				is_skeleton_required := True
					-- Instantiate generic parameter in context of current class.
				a_class.update_generic_features
			end
			if is_skeleton_required or else not attached a_class.skeleton then
					-- New skeleton is set when
					-- a) the old one is changed
					-- b) the new one is not generated yet
				degree_4.put_action (
					agent (c: CLASS_C; t: FEATURE_TABLE)
						do
							c.set_skeleton (t.skeleton)
						end
					(a_class, resulting_table)
				)
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
					if a_class.once_modified then
						degree_4.set_once_modified (descendant)
					end
					if attached a_class.assert_prop_list as assert_prop_list then
						Degree_4.set_assertion_prop_list
							(descendant, create {LINKED_LIST [INTEGER]}.make_from_iterable (assert_prop_list))
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

feature {NONE} -- Qualified suppliers: access

	qualified_suppliers: HASH_TABLE [LIST [QUALIFIED_SUPPLIER], INTEGER]
			-- Qualified suppliers collected during this degree indexed by client class ID

	qualified_clients: HASH_TABLE [ARRAYED_SET [INTEGER], QUALIFIED_SUPPLIER]
			-- Clients of qualified suppliers

feature {NONE} -- Qualified suppliers: removal

	clear_qualified_suppliers
			-- Remove all qualified suppliers.
		do
			qualified_suppliers := Void
			qualified_clients := Void
			qualified_supplier := Void
		ensure
			removed_qualified_suppliers: qualified_suppliers = Void
			removed_qualified_clients: qualified_clients = Void
		end

feature -- Qualified suppliers: initialization

	initialize_qualified_suppliers
			-- Initialize data to recompile clients of qualified suppliers.
		local
			t: detachable like qualified_clients
			l: detachable ARRAYED_SET [INTEGER]
		do
				-- Process all classes that have qualified suppliers.
			across
				system.classes as c
			loop
				if
					system.classes.has (c.target_index) and then
					attached c.item.qualified_suppliers as q
				then
						-- Record all clients of the given qualified supplier.
					across
						q as s
					loop
						t := qualified_clients
						if attached t then
							l := t.item (s.item)
						else
							create t.make (1)
							qualified_clients := t
						end
						if not attached l then
							create {ARRAYED_SET [INTEGER]} l.make (1)
							t.force (l, s.item)
						end
						l.extend (c.item.class_id)
					end
				end
			end
		end

feature -- Qualified suppliers: modification

	add_qualified_supplier (f: FEATURE_I; s: CLASS_C; c: CLASS_C)
			-- Register a qualified supplier `[f, s]' of class `c'.
		require
			f_attached: f /= Void
			s_attached: s /= Void
			valid_f: attached s.feature_of_name_id (f.feature_name_id)
			c_attached: c /= Void
		local
			t: like qualified_suppliers
			q: LIST [QUALIFIED_SUPPLIER]
		do
			t := qualified_suppliers
			if not attached t then
				create t.make (1)
				qualified_suppliers := t
			else
				q := t.item (c.class_id)
			end
			if not attached q then
				create {ARRAYED_LIST [QUALIFIED_SUPPLIER]} q.make (1)
				t.force (q, c.class_id)
			end
			q.extend (create {QUALIFIED_SUPPLIER}.make (f, s))
		end

feature {NONE} -- Qualified suppliers: optimization

	qualified_supplier: detachable QUALIFIED_SUPPLIER
			-- Temporary cell to optimize `touch_feature_type'

feature -- Qualified suppliers: recompilation

	touch_feature_type (f: FEATURE_I; c: CLASS_C)
			-- Register that the type of feature `f' from class `c' is changed
			-- or the feature is completely removed.
		require
			f_attached: attached f
			c_attached: attached c
		local
			q: like qualified_supplier
		do
			if attached qualified_clients as t then
					-- Check if a temporary cell is already allocated.
				q := qualified_supplier
				if not attached q then
					create q.make (f, c)
						-- Record allocated object for reuse.
					qualified_supplier := q
				else
					q.set (f, c)
				end
				if attached t.item (q) as clients then
						-- Recompile clients.
					across
						clients as i
					loop
						if attached system.class_of_id (i.item) as d then
							delayed_classes.put (d)
						end
					end
				end
			end
		end

invariant
	changed_status_not_void: changed_status /= Void
	ignored_classes_not_void: ignored_classes /= Void
	delayed_classes_attached: attached delayed_classes

note
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

end -- class DEGREE_4




