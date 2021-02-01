note
	description: "Dead code removal."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class REMOVER

inherit
	FEAT_ITERATOR
		redefine
			make,
			mark_code_reachable
		end

	CLASS_RECORDER
		rename
			has as is_class_known,
			is_valid as is_valid_class_id
		end

	DEPENDENCE_RECORDER

	SHARED_EIFFEL_PROJECT
	SHARED_TABLE

create
	make

feature {NONE} -- Creation

	make
			-- Initialization.
		local
			i: like {FORMAL_A}.position
			r: like {ROUT_TABLE}.rout_id
		do
			Precursor
			create dependencies.make (1000)
			create array_optimizer.make
			create inliner.make
			create polymorphic_calls.make (1000)
			create dead_monomorphic_calls.make (1000)
			create instance_dependencies.make (100)
				-- Mark all classes as dead and unreachable.
				-- Take into account that indexes in `{SPECIAL}` do not start at `1`.
			create live_classes.make_filled (False, system.classes.upper + (1 - {like live_classes}.lower))
			create reachable_classes.make_filled (False, system.classes.upper + (1 - {like reachable_classes}.lower))
				-- Retrieve derived types for classes.
				-- Take into account that indexes in `{SPECIAL}` do not start at `1`.
			create actual_generics.make_filled (Void, system.class_counter.count + (1 - {like actual_generics}.lower))
				-- Register actual generics.
				-- Firstly, find out what generics have creation constraints, and allocate the corresponding structure.
			across
				system.classes as cs
			loop
				if
					attached cs.item as c and then
					c.is_valid and then
					attached c.generics as g
				then
					from
						i := g.count
					until
						i <= 0
					loop
							-- Take into account only types with creation constraint.
						if attached g [i].creation_feature_list then
							allocate_actuals (i, g.count, c.class_id)
						end
						i := i - 1
					end
				end
			end
				-- Secondly, register actual generics from standalone class types.
				-- Actual generics from filters are registered by `mark_class_reachable`.
			record_actual_generics (system.instantiator)
				-- Take into account only routines and attributes with bodies.
			from
				r := system.routine_id_counter.count
				create is_fresh.make_filled (False, r + (1 - {like is_fresh}.lower))
				create is_routine.make_filled (False, r + (1 - {like is_routine}.lower))
			until
				r <= 0
			loop
				if
					system.routine_id_counter.is_attribute (r) implies
					attached tmp_poly_server.item (r) as t and then t.is_routine_table
				then
					is_fresh [r] := True
					is_routine [r] := True
				end
				r := r - 1
			end
		end

feature {NONE} -- Initialization

	allocate_actuals (p: like {FORMAL_A}.position; n: like {FORMAL_A}.position; c: like {CLASS_C}.class_id)
			-- Allocate storage to store actuals for a class of ID `c` with `n` formal generics
			-- where `p` is a position of a creation-involved one.
		local
			actuals: like actual_generics.item
			actual: like actual_generics.item.item
		do
			actuals := actual_generics [c]
			if not attached actuals then
				create actuals.make_filled (Void, n)
				actual_generics [c] := actuals
			end
			actual := actuals [p - 1]
			if not attached actual then
				create actual.make (1)
				actuals [p - 1] := actual
			end
		end

	record_actual_generics (fs: FILTER_LIST)
			-- Record actual generics of class types found in `fs` in `actual_generics`
			-- if the corresponding formal generic has a creation constraint.
		local
			i: like {FORMAL_A}.position
			t: CL_TYPE_A
		do
			across
				fs as f
			loop
				t := f.item
					-- Take into account only types with creation constraint.
				if
					attached actual_generics [t.class_id] as actuals and then
					attached t.generics as g
				then
						-- Some actual generics are involved in creation, record them.
					from
						i := g.count
					until
						i <= 0
					loop
						if
							attached actuals [i - 1] and then
							attached g [i].base_class as b and then
							not b.is_deferred
						then
							record_and_propagate_actual_generic (b, i, t.base_class)
						end
						i := i - 1
					end
				end
			end
		end

	record_and_propagate_actual_generic (a: CLASS_C; p: like {FORMAL_A}.position; c: CLASS_C)
			-- Record that a formal of a class `c` at position `p` is used with an actual value `a`
			-- and propagate it (recursively) to derivations, instantiated by `c`.
		require
			not a.is_deferred
			attached c.generics as g
			g.valid_index (p)
		local
			j: like {FORMAL_A}.position
			f: CL_TYPE_A
			n: like actual_generics.item.item.count
		do
			n := actual_generics [c.class_id] [p - 1].count
			actual_generics [c.class_id] [p - 1].extend (a.class_id)
				-- Avoid recursion by testing that the new element has been added.
			if actual_generics [c.class_id] [p - 1].count /= n then
				across
					c.filters as fs
				loop
					f := fs.item
						-- Take into account only types with creation-involved generics.
					if
						attached actual_generics [f.class_id] as actuals and then
						attached f.generics as g
					then
						from
							j := g.count
						until
							j <= 0
						loop
								-- Take into account only creation-involved generics.
							if
								attached actuals [j - 1] and then
								attached {FORMAL_A} g [j] as h and then
								h.position = p
							then
								record_and_propagate_actual_generic (a, j, f.base_class)
							end
							j := j - 1
						end
					end
				end
			end
		ensure
			actual_generics [c.class_id] [p - 1].has (a.class_id)
		end

feature -- Status report

	is_valid_class_id (class_id: like {CLASS_C}.class_id): BOOLEAN
			-- <Precursor>
		do
			Result := system.has_class_of_id (class_id) and then system.has_existing_class_of_id (class_id)
		end

	is_valid_as_alive (class_id: like {CLASS_C}.class_id): BOOLEAN
			-- <Precursor>
		do
			Result :=
				attached system.class_of_id (class_id) as c and then
				not c.is_deferred
		end

	is_class_alive (class_id: like {CLASS_C}.class_id): BOOLEAN
			-- Is class of ID `class_id` used to create an object?
		do
			check
				valid_index: live_classes.valid_index (class_id)
			end
			Result := live_classes [class_id]
		end

	is_class_reachable (class_id: like {CLASS_C}.class_id): BOOLEAN
			-- Is class of ID `class_id` reachable during execution?
			-- E.g., are there live descendants of the class class with ID `class_id` or is the class used in a non-object call?
		do
			check
				valid_index: reachable_classes.valid_index (class_id)
			end
			Result := reachable_classes [class_id]
		end

	is_class_known (class_id: like {CLASS_C}.class_id): BOOLEAN
			-- <Precursor>
			-- Is class of ID `class_id` alive or reachable?
		do
			Result := live_classes [class_id] or else reachable_classes [class_id]
		end

	is_valid_generic (position: like {FORMAL_A}.position; class_id: like {CLASS_C}.class_id): BOOLEAN
			-- <Precursor>
		do
			Result :=
				attached system.class_of_id (class_id) as c and then
				attached c.generics as g and then
				g.valid_index (position)
		end

feature {NONE} -- Status report

	is_fresh: SPECIAL [BOOLEAN]
			-- Flags telling if features with the routine ID corresponding to the index still have to be processed.
			-- The flags are indexed by routine IDs.

	is_routine: SPECIAL [BOOLEAN]
			-- Flags telling if features with the routine ID corresponding to the index are routines or attributes with bodies.
			-- The flags are indexed by routine IDs.

feature -- Access

	parameter_instances (position: like {FORMAL_A}.position; class_id: like {CLASS_C}.class_id): ARRAYED_LIST [like {CLASS_C}.class_id]
			-- <Precursor>
		do
			if attached actual_generics [class_id] as actuals then
				Result := actuals [position - 1]
			end
		end

feature {NONE} -- Access

	actual_generics: SPECIAL [detachable SPECIAL [detachable ARRAYED_SET [like {CLASS_C}.class_id]]]
			-- IDs of classes of class types used as actual generics in derivations indexed by class ID.
			-- For example, if a class "X" has generic derivations "X [A, B]" and "X [A, C]" with generics used in creation,
			-- the item of `actual_generics` at ID of class "X" is "[[A], [B, C]]".

feature -- Modification

	mark_class_alive (class_id: like {CLASS_C}.class_id)
			-- Mark class of ID `class_id` as live, i.e. an instance of this class can be created by a running system.
		local
			i: like dead_monomorphic_calls.item.item
			b: like monomorphic_item_body_index
		do
			check
				valid_index: live_classes.valid_index (class_id)
			end
			if not live_classes [class_id] then
					-- Mark the class itself as alive.
				live_classes [class_id] := True
				live_classes_count := live_classes_count + 1
					-- Mark the parents as reachable.
				mark_class_reachable (class_id)
					-- Mark expanded suppliers of attribute types as alive.
				if
					attached system.class_of_id (class_id) as c and then
					attached c.skeleton as s
				then
					across
						s as a
					loop
						if
							attached c.feature_of_feature_id (a.item.feature_id) as f and then
							attached f.type as t and then
							(t.is_basic implies not {SYSTEM_I}.is_basic_class_alive) and then
							t.is_expanded_creation_possible
						then
							dependence_generator.generate (t, {INSTANCE_DEPENDENCE_GENERATOR}.expanded_creation_kind, c)
							if attached dependence_generator.dependence as d then
								d.record_new_dependence (Current, Current)
							end
						end
					end
				end
				if attached dead_monomorphic_calls [class_id] as ms then
						-- There are previously dead feature calls on this class.
						-- They should be revived now.
					dead_monomorphic_calls.remove (class_id)
					across
						ms as m
					loop
						i := m.item
						b := monomorphic_item_body_index (i)
							-- It is possible that some calls for this class were registered as non-object ones or calls to precursors.
							-- Therefore, the test is required.
						if not reachable_code.item (b) then
							register_monomorphic_call (b, monomorphic_item_written_class_id (i), class_id)
						end
					end
				end
			end
		end

	mark_class_reachable (class_id: like {CLASS_C}.class_id)
			-- Mark class of ID `class_id` as reachable, i.e. having live descendants or used in non-object calls.
		local
			c: CLASS_C
		do
			if not reachable_classes [class_id] then
				reachable_classes [class_id] := True
				c := system.class_of_id (class_id)
				if attached c.parents as ps then
					across
						ps as p
					loop
						mark_class_reachable (p.item.class_id)
					end
				end
					-- Add actual generics from the filters.
				if attached c.filters as fs then
					record_actual_generics (fs)
				end
			end
		ensure then
			is_marked: is_class_reachable (class_id)
			is_parent_marked: attached system.class_of_id (class_id).parents as ps implies across ps as p all reachable_classes [p.item.class_id] end
		end

	register_polymorphic (f: FEATURE_I; target_class_id: like {CLASS_C}.class_id)
			-- Register a polymorphic call to the feature `f` on the target of a type with a class with ID `target_class_id`.
		do
			dependencies.extend (create {DEPEND_UNIT}.make (target_class_id, f))
			discharge_dependencies
		ensure
			dependencies.is_empty
		end

	register_monomorphic (f: FEATURE_I; target_class_id: like {CLASS_C}.class_id)
			-- Register a non-polymorphic call to the feature `f`
			-- on the target of a class with ID `target_class_id`.
		do
			dependencies.extend (create {DEPEND_UNIT}.make_with_level (target_class_id, f, {DEPEND_UNIT}.is_uniform_flag))
			discharge_dependencies
		ensure
			dependencies.is_empty
		end

	mark_code_reachable (body_index: INTEGER)
			-- Mark feature body index `body_index` as potentially reachable during execution.
		do
			reachable_code [body_index] := True
			features := features + 1
			if features = features_per_message then
				update_progress
			end
		end

	request_alive_clases (d: INSTANCE_DEPENDENCE)
			-- <Precursor>
		do
			instance_dependencies.put (d)
		end

	analyze
			-- Run the analysis after all feature calls were registered using
			-- `register_polymorphic` and `register_monomorphic`.
		local
			n: like live_classes_count
			m: like live_classes_count
			i: like instance_dependencies
		do
				-- Re-evaluate polymorhic calls until there are no new classes and no new instance dependencies.
			from
				i := instance_dependencies
				m := live_classes_count + i.count.as_natural_32
			until
				n = m
			loop
				n := m
					-- Re-evaluate instance dependencies that rely on live classes.
				across
					i as d
				loop
					d.item.record (Current)
				end
				discharge_dependencies
				m := live_classes_count + i.count.as_natural_32
			end
		ensure
			dependencies.is_empty
		end

feature {NONE} -- Measurement

	live_classes_count: NATURAL_32
			-- Number of alive classes.

feature {NONE} -- Calls history

	polymorphic_key (routine_id: like {ROUT_TABLE}.rout_id; target_class_id: like {CLASS_C}.class_id): NATURAL_64
			-- A key to lookup in `polymorphic_calls` for a feature of routine ID `routine_id`
			-- called on a target class of ID `target_class_id`.
		do
			Result := (routine_id.as_natural_64 |<< 32) | target_class_id.as_natural_64
		end

	polymorphic_calls: SEARCH_TABLE [NATURAL_64]
			-- A set of registered polymorphic calls.

	polymorphic_key_routine_id (key: like polymorphic_key): like {ROUT_TABLE}.rout_id
			-- A routine ID corresponding to the polymorphic call key `key`.
		do
			Result := (key |>> 32).as_integer_32
		end

	polymorphic_key_target_class_id (key: like polymorphic_key): like {CLASS_C}.class_id
			-- A target class ID corresponding to the polymorphic call key `key`.
		do
			Result := key.as_integer_32
		end

	dead_monomorphic_calls: HASH_TABLE [ARRAYED_SET [like monomorphic_item], like {CLASS_C}.class_id]
			-- Non-polymorphic calls that become reachanbe as soon as the corresponding class becomes alive.

	monomorphic_item (body_index: like {FEATURE_I}.body_index; written_class_id: like {CLASS_C}.class_id): NATURAL_64
			-- An item to store in `monomorphic_calls` for a feature with body index `body_index`
			-- written in a class of ID `written_class_id`.
		do
			Result := (body_index.as_natural_64 |<< 32) | written_class_id.as_natural_64
		end

	monomorphic_item_body_index (item: like monomorphic_item): like {FEATURE_I}.body_index
			-- A body index corresponding to the monomorphic call item `item`.
		do
			Result := (item |>> 32).as_integer_32
		end

	monomorphic_item_written_class_id (item: like monomorphic_item): like {CLASS_C}.class_id
			-- A written class ID corresponding to the monomorphic call item `item`.
		do
			Result := item.as_integer_32
		end

feature {NONE} -- Dependency propagation

	discharge_dependencies
			-- Process all dependencies registered in `control` until none left.
		local
			d: DEPEND_UNIT
			r: like {DEPEND_UNIT}.rout_id
			i: like {CLASS_C}.class_id
			b: like {FEATURE_I}.body_index
		do
			from
			until
				dependencies.is_empty
			loop
				d := dependencies.item
				dependencies.remove
					-- Check if the dependency is a routine.
				i := d.class_id
				if d.is_polymorphic then
					r := d.rout_id
					if not polymorphic_calls.has (polymorphic_key (r, i)) then
						register_polymorphic_call (r, i)
					end
				else
					b := d.body_index
					if not reachable_code [b] then
						register_monomorphic_call (b, d.written_in, i)
					end
				end
			end
		ensure
			dependencies.is_empty
		end

	register_monomorphic_call (body_index: like {FEATURE_I}.body_index; written_class_id, target_class_id: like {CLASS_C}.class_id)
			-- Register a non-polymorphic call to a feature with body index `body_index` written in a class with ID `written_class_id`
			-- on a target of a class with ID `target_class_id`.
		require
			not is_code_reachable (body_index)
		local
			d: DEPEND_UNIT
			r: like {ROUT_TABLE}.rout_id
		do
			mark_code_reachable (body_index)
				-- Process dependencies of the feature.
			if attached depend_server.item (written_class_id).item (body_index) as dependence then
					-- Register dependencies specified in `dependence`.
				if attached dependence.instance_suppliers as s then
						-- Mark classes that are used for creation or non-object calls.
					across
						s as i
					loop
						i.item.record_new_dependence (Current, Current)
					end
				end
				across
					dependence as f
				loop
					d := f.item
					if d.is_needed_for_dead_code_removal then
						r := d.rout_id
						if
							is_routine [r] and then
							if d.is_polymorphic then
								is_fresh [r] and then not polymorphic_calls.has (polymorphic_key (r, d.class_id))
							else
								not reachable_code [d.body_index]
							end
						then
							dependencies.extend (d)
						end
					end
				end
					-- Array optimization
				array_optimizer.process (system.class_of_id (written_class_id), body_index, dependence)
			end
		ensure
			is_code_reachable (body_index)
		end

	register_polymorphic_call (routine_id: like {DEPEND_UNIT}.rout_id; target_class_id: like {CLASS_C}.class_id)
			-- Register a polymorphic call to a feature with routine ID `routine_id`
			-- on a target of a class with ID `target_class_id`.
		require
			is_new: not polymorphic_calls.has (polymorphic_key (routine_id, target_class_id))
		local
			e: ROUT_ENTRY
			c: CLASS_C
			i: like {CLASS_C}.class_id
			m: like dead_monomorphic_calls.item
			k: like polymorphic_key
			b: like {FEATURE_I}.body_index
		do
				-- Iterate through all live entries of the corresponding routine table.
			if attached {ROUT_TABLE} tmp_poly_server.item (routine_id) as t then
				b := t.body_index
				if b = {ROUT_TABLE}.body_index_various then
					c := system.class_of_id (target_class_id)
					if system.rout_info_table [routine_id].origin = target_class_id then
							-- All entries are going to be registered, so the routine ID can be marked as processed.
						is_fresh [routine_id] := False
					end
					from
						t.start
					until
						t.after
					loop
						e := t.item
						i := e.class_id
						k := polymorphic_key (routine_id, i)
						if
							not polymorphic_calls.has (k) and then
							attached system.class_of_id (i) as d and then
							d.inherits_from (c)
						then
								-- Mark all calls on descendant targets as processed.
							polymorphic_calls.put (k)
							b := e.body_index
							if not reachable_code.item (b) then
								if live_classes [i] then
										-- The class is alive and the call has not been registered yet, do it now.
									register_monomorphic_call (b, e.written_in, i)
								else
										-- Remember that there is a call that is currently dead because the class is dead.
										-- It will be processed as soon as the class becomes alive. See `mark_class_alive`.
									m := dead_monomorphic_calls [i]
									if not attached m then
										create m.make (1)
										dead_monomorphic_calls [i] := m
									end
									m.extend (monomorphic_item (b, e.written_in))
								end
							end
						end
						t.forth
					end
				elseif
					b = {ROUT_TABLE}.body_index_unknown or else
					reachable_code [b]
				then
						-- There are no entries with an effective body, or
						-- the body has been taken into account.
						-- Mark the routine as processed.
					is_fresh [routine_id] := False
					polymorphic_calls.put (polymorphic_key (routine_id, target_class_id))
				else
						-- The routine has only one body that can be executed and it has not been reached yet.
						-- Record classes that can make this routine reachable.
					c := system.class_of_id (target_class_id)
					from
						t.start
					until
						t.after
					loop
						e := t.item
						i := e.class_id
						k := polymorphic_key (routine_id, i)
						if
							not polymorphic_calls.has (k) and then
							attached system.class_of_id (i) as d and then
							d.inherits_from (c)
						then
								-- Mark all calls on descendant targets as processed.
							polymorphic_calls.put (k)
							if live_classes [i] then
									-- The routine is going to be processed now, mark the routine ID as processed.
								is_fresh [routine_id] := False
									-- The class is alive and the call has not been registered yet, do it now.
								register_monomorphic_call (b, e.written_in, i)
									-- Stop traversal because there are no other routine bodies.
								t.finish
							else
									-- Remember that there is a call that is currently dead because the class is dead.
									-- It will be processed as soon as the class becomes alive. See `mark_class_alive`.
								m := dead_monomorphic_calls [i]
								if not attached m then
									create m.make (1)
									dead_monomorphic_calls [i] := m
								end
								m.extend (monomorphic_item (b, e.written_in))
							end
						end
						t.forth
					end
				end
			elseif
				attached system.class_of_id (target_class_id) as t and then
				attached t.feature_of_rout_id (routine_id) as f
			then
					-- It must be an inline agent.
					-- There could be other ways to handle it, here it is assumed, the agent is always called.
				is_fresh [routine_id] := False
				polymorphic_calls.put (polymorphic_key (routine_id, target_class_id))
				if not reachable_code.item (f.body_index) then
 					register_monomorphic_call (f.body_index, f.written_in, target_class_id)
				end
			end
		ensure
			is_registered: polymorphic_calls.has (polymorphic_key (routine_id, target_class_id))
		end

	Dependence_generator: INSTANCE_DEPENDENCE_GENERATOR
			-- A generator to compute instance dependencies for given creation or non-object call types.
			-- (export status {NONE})
		once
			create Result
		end

feature -- Array optimization

	record_array_descendants
		do
			array_optimizer.record_array_descendants
		end

	array_optimizer: ARRAY_OPTIMIZER

feature {NONE} -- Access: classes

	live_classes: SPECIAL [BOOLEAN]
			-- Flags indicating whether a class is alive after dead code removal.

	reachable_classes: SPECIAL [BOOLEAN]
			-- Flags indicating whether a class or any of its descendants is alive after dead code removal.

feature -- Inlining

	inliner: INLINER

feature {NONE} -- Traversal

	dependencies: ARRAYED_QUEUE [DEPEND_UNIT]
			-- Dependencies to process.

	instance_dependencies: SEARCH_TABLE [INSTANCE_DEPENDENCE]
			-- Dependencies to be re-evaluated when a set of live classes changes.

feature {NONE} -- Output

	features: INTEGER
		-- Number of features for the current dot

	features_per_message: INTEGER = 500

	update_progress
			-- Update the message about dead code removal progress.
		do
			Degree_output.put_dead_code_removal_message (features, dependencies.count)
			features := 0
		end

feature -- Debugging

	dump_alive
		local
			i, j: INTEGER
		do
			io.put_string ("Used Table:%N")
			from
				i := 1
			until
				i = reachable_code.count
			loop
				io.put_integer (i)
				io.put_string (" : ")
				io.put_boolean (reachable_code.item (i))
				if reachable_code.item (i) then
					j := j + 1
				end
				io.put_string ("%N")
				i := i + 1
			end
			io.put_string ("END OF USED TABLE%N")
			io.put_string ("nb of body_index alive: ")
			io.put_integer (j)
			io.put_string ("%N")
		end

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
