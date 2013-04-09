note
	description: "Objects that traverse object graphs starting at the root object."
	library: "Free implementation of ELKS library"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Stephanie Balzer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OBJECT_GRAPH_TRAVERSABLE

feature -- Access

	root_object: detachable ANY
			-- Starting point of graph traversing

	object_action: detachable PROCEDURE [ANY, TUPLE [separate ANY]]
			-- Action called on every object in object graph

	visited_objects: detachable ARRAYED_LIST [separate ANY]
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

	is_skip_transient: BOOLEAN
			-- Do we skip transient attribute during traversal?
			--| Default: False, i.e. transient attributes will be processed.

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

	set_is_skip_transient (v: like is_skip_transient)
			-- Set `is_skip_transient' with `v'.
		do
			is_skip_transient := v
		ensure
			is_skip_transient_set: is_skip_transient = v
		end

feature -- Basic operations

	frozen traverse
			-- Traverse object structure starting at 'root_object' and call object_action
			-- on every object in the graph.
			--| Redefine `internal_traverse' if you need to change the implementation.
		require
			root_object_available: is_root_object_set
		local
			l_marker: detachable OBJECT_GRAPH_MARKER
			retried, l_has_lock: BOOLEAN
		do
			if not retried and attached root_object as l_root then
				create l_marker
				l_marker.lock_marking
				l_has_lock := True
				internal_traverse (l_root)
				l_marker.unlock_marking
			else
				if l_has_lock and then l_marker /= Void then
					l_marker.unlock_marking
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

	new_dispenser: DISPENSER [separate ANY]
			-- New dispenser to use for storing visited objects.
		deferred
		ensure
			new_dispenser_not_void: Result /= Void
		end

	default_size: INTEGER = 200
			-- Default size for containers used during object traversal

	internal_traverse (a_root_object: ANY)
			-- Traverse object structure starting at 'root_object' and call object_action
			-- on every object in the graph.
		local
			i, nb: INTEGER
			l_object: separate ANY
			l_field: like {TUPLE}.reference_item
			l_marker: OBJECT_GRAPH_MARKER
			l_objects_to_visit: like new_dispenser
			l_visited: like visited_objects
			l_action: like object_action
			l_spec: like visited_objects.area
			l_reflected_reference_object: REFLECTED_REFERENCE_OBJECT
			l_reflected_object: REFLECTED_OBJECT
		do
			from
				create l_marker
				create l_reflected_reference_object.make (a_root_object)
				l_reflected_object := l_reflected_reference_object
				l_marker.mark (a_root_object)
				create l_visited.make (default_size)
				l_objects_to_visit := new_dispenser
				l_objects_to_visit.put (a_root_object)
				l_action := object_action
			until
				l_objects_to_visit.is_empty
			loop
				l_object := l_objects_to_visit.item
				l_objects_to_visit.remove

					-- Add `l_object' to processed objects.
				l_visited.extend (l_object)

					-- Call action.
				if l_action /= Void then
					l_action.call ([l_object])
				end

					-- Iterate through fields of `l_object'.
					-- There are three major types of object:
					-- 1 - Objects representing
					-- 2 - SPECIAL [ANY]
					-- 3 - TUPLE containing references
					-- 4 - Normal objects
				if attached {REFLECTED_COPY_SEMANTICS_OBJECT} l_object as l_exp_as_ref then
					l_reflected_object := l_exp_as_ref
				else
					l_reflected_reference_object.set_object (l_object)
					l_reflected_object := l_reflected_reference_object
				end

				if l_reflected_object.is_special then
					if
						l_reflected_object.is_special_of_reference and then
						attached {SPECIAL [detachable ANY]} l_object as l_sp
					then
						from
							i := 0
							nb := l_sp.count
						until
							i = nb
						loop
							l_field := l_sp.item (i)
							if l_field /= Void and then not l_marker.is_marked (l_field) then
								l_marker.mark (l_field)
								l_objects_to_visit.put (l_field)
							end
							i := i + 1
						end
					end
				elseif l_reflected_object.is_tuple then
					if attached {TUPLE} l_object as l_tuple_obj then
						from
							i := 1
							nb := l_tuple_obj.count + 1
						until
							i = nb
						loop
							if l_tuple_obj.is_reference_item (i) then
								l_field := l_tuple_obj.reference_item (i)
								if l_field /= Void and then not l_marker.is_marked (l_field) then
									l_marker.mark (l_field)
									l_objects_to_visit.put (l_field)
								end
							end
							i := i + 1
						end
					end
				else
					from
						i := 1
						nb := l_reflected_object.field_count + 1
					until
						i = nb
					loop
						if l_reflected_object.field_type (i) = {REFLECTOR_CONSTANTS}.reference_type then
							if not is_skip_transient or else not l_reflected_object.is_field_transient (i) then
								if l_reflected_object.is_copy_semantics_field (i) then
									l_field := l_reflected_object.copy_semantics_field (i)
									l_objects_to_visit.put (l_field)
										-- There is no need for marking since, no one can have a reference
										-- to that object, so we are sure to never hit it again.
								else
									l_field := l_reflected_object.reference_field (i)
									if l_field /= Void and then not l_marker.is_marked (l_field) then
										l_marker.mark (l_field)
										l_objects_to_visit.put (l_field)
									end
								end
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
				l_spec := l_visited.area
			until
				i = nb
			loop
				if l_marker.is_marked (l_spec.item (i)) then
					l_marker.unmark (l_spec.item (i))
				else
					check attached {REFLECTED_COPY_SEMANTICS_OBJECT} l_spec.item (i) end
				end
				i := i + 1
			end

				-- Set `visited_objects'.
			visited_objects := l_visited
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
