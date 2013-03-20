note
	description: "Objects that traverse object graphs starting at the root object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Stephanie Balzer"
	date: "$Date$"
	revision: "$Revision$"

--********************************************************************************--
--	Open questions:
--
--	feature 'traverse', outer loop: variant (termination?) and invariant
--	inner loop: invariant
--********************************************************************************--

deferred class
	OBJECT_GRAPH_TRAVERSABLE

feature -- Access

	root_object: detachable ANY
			-- Starting point of graph traversing

	object_action: detachable PROCEDURE [ANY, TUPLE [ANY]]
			-- Action called on every object in object graph

	visited_objects: detachable ARRAYED_LIST [ANY]
			-- List referencing objects of object graph that have been visited in `traverse'.

feature -- Status report

	is_root_object_set: BOOLEAN
			-- Is starting point of graph traversing set?
		do
			Result := root_object /= Void
		end

	is_object_action_set: BOOLEAN
			-- Is procedure to call on every object set?
		do
			Result := object_action /= Void
		end

feature -- Element change

	set_root_object (an_object: like root_object)
			-- Set `root_object' with 'an_object'.
		require
			an_object_not_void: an_object /= Void
		do
			root_object := an_object
		ensure
			root_object_set: root_object = an_object and is_root_object_set
		end

	set_object_action (an_object_action: like object_action)
			-- Set `object_action' with `an_object_action'.
		require
			an_object_action_not_void: an_object_action /= Void
		do
			object_action := an_object_action
		ensure
			an_object_action_set: object_action = an_object_action and is_object_action_set
		end

feature -- Basic operations

	frozen traverse
			-- Traverse object structure starting at 'root_object' and call object_action
			-- on every object in the graph.
			--| Redefine `internal_traverse' if you need to change the implementation.
		require
			root_object_available: is_root_object_set
		local
			l_int: detachable INTERNAL
			retried, l_has_lock: BOOLEAN
		do
			if not retried then
				create l_int
				l_int.lock_marking
				l_has_lock := True
				internal_traverse
				l_int.unlock_marking
			else
				if l_has_lock and then l_int /= Void then
					l_int.unlock_marking
				end
			end
		rescue
			retried := True
			retry
		end

	wipe_out
			-- Clear current to default values
		do
			visited_objects := Void
			object_action := Void
			root_object := Void
		ensure
			visited_objects_reset: visited_objects = Void
			object_action_not_set: not is_object_action_set
			root_object_not_set: not is_root_object_set
		end

feature {NONE} -- Implementation

	new_dispenser: DISPENSER [ANY]
			-- New dispenser to use for storing visited objects.
		deferred
		ensure
			new_dispenser_not_void: Result /= Void
		end

	default_size: INTEGER = 200
			-- Default size for containers used during object traversal

	internal_traverse
			-- Traverse object structure starting at 'root_object' and call object_action
			-- on every object in the graph.
		require
			root_object_available: is_root_object_set
		local
			i, nb: INTEGER
			l_object: ANY
			l_field: detachable ANY
			l_int: INTERNAL
			l_objects_to_visit: like new_dispenser
			l_visited: like visited_objects
			l_action: like object_action
			l_tuple: TUPLE [ANY]
			l_dtype: INTEGER
			l_spec: SPECIAL [ANY]
			l_arr: detachable ARRAY [ANY]
			r: like root_object
		do
			from
				create l_int
				create l_visited.make (default_size)
				l_objects_to_visit := new_dispenser
				r := root_object
				if r /= Void then
					l_objects_to_visit.put (r)
					l_int.mark (r)
				end
				l_action := object_action
				create l_tuple
			until
				l_objects_to_visit.is_empty
			loop
				l_object := l_objects_to_visit.item
				l_objects_to_visit.remove

					-- Add `l_object' to processed objects.
				l_visited.extend (l_object)

					-- Call action.
				if l_action /= Void then
					l_tuple.put_reference (l_object, 1)
					l_action.call (l_tuple)
				end

					-- Iterate through fields of `l_object'.
					-- There are three major types of object:
					-- 1 - SPECIAL [ANY]
					-- 2 - TUPLE containing references
					-- 3 - Normal objects
				l_dtype := l_int.dynamic_type (l_object)
				if l_int.is_special_type (l_dtype) then
					if l_int.is_special_any_type (l_dtype) then
						if attached {SPECIAL [ANY]} l_object as l_sp then
							from
								i := 0
								nb := l_sp.count
							until
								i = nb
							loop
								l_field := l_sp.item (i)
								if l_field /= Void and then not l_int.is_marked (l_field) then
									l_int.mark (l_field)
									l_objects_to_visit.put (l_field)
								end
								i := i + 1
							end
						end
					end
				elseif l_int.is_tuple (l_object) then
					if attached {TUPLE} l_object as l_tuple_obj then
						from
							i := 1
							nb := l_tuple_obj.count + 1
						until
							i = nb
						loop
							if l_tuple_obj.is_reference_item (i) then
								l_field := l_tuple_obj.reference_item (i)
								if l_field /= Void and then not l_int.is_marked (l_field) then
									l_int.mark (l_field)
									l_objects_to_visit.put (l_field)
								end
							end
							i := i + 1
						end
					end
				else
					from
						i := 1
						nb := l_int.field_count_of_type (l_dtype) + 1
					until
						i = nb
					loop
						if l_int.field_type_of_type (i, l_dtype) = {INTERNAL}.reference_type then
							l_field := l_int.field (i, l_object)
							if l_field /= Void and then not l_int.is_marked (l_field) then
								l_int.mark (l_field)
								l_objects_to_visit.put (l_field)
							end
						end
						i := i + 1
					variant
						nb - i
					end
				end
			end

				-- Unmark all objects.
			from
				i := 0
				nb := l_visited.count
				l_arr := l_visited
				l_spec := l_arr.area
				l_arr := Void
			until
				i = nb
			loop
				l_int.unmark (l_spec.item (i))
				i := i + 1
			end

				-- Set `visited_objects'.
			visited_objects := l_visited
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
