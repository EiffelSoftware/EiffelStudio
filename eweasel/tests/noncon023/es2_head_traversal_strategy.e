note
	description: "Summary description for {ES2_HEAD_TRAVERSAL_STRATEGY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES2_HEAD_TRAVERSAL_STRATEGY

inherit
	ES2_HEAP_TRAVERSAL
		redefine
			make
		end

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			dispenser := new_dispenser
			Precursor
		end

feature {NONE} -- Access

	object: ANY
			-- <Precursor>
		do
			check attached current_object as l_result then
				Result := l_result
			end
		end

	current_object: detachable ANY
			-- Internal storage for `object'.

	dispenser: like new_dispenser
			-- Dispenser containing object to be traversed.

feature {NONE} -- Status report

	is_traversing: BOOLEAN
			-- <Precursor>
		do
			Result := current_object /= Void
		ensure then
			result_implies_current_object_attached: Result implies current_object /= Void
		end

feature {NONE} -- Status setting

	forth
			-- <Precursor>
		do
			if dispenser.is_empty then
				current_object := Void
			else
				current_object := dispenser.item
				dispenser.remove
			end
		end

feature {NONE} -- Basic operations

	traverse (an_object: ANY)
			-- Traverse graph accessible through `an_object'
		require
			not_traversing: not is_traversing
		do
			prepare (an_object)
			traverse_recursive
			cleanup
		ensure
			not_traversing: not is_traversing
		end

feature {NONE} -- Element change

	put (an_object: ANY)
			-- <Precursor>
		do
			dispenser.put (an_object)
		end

feature {NONE} -- Factory

	new_dispenser: DISPENSER [ANY]
		deferred
		end

feature {NONE} -- Implementation

	prepare (a_root: ANY)
		require
			not_traversing: not is_traversing
		do
			lock_marking
			mark (a_root)
			current_object := a_root
		end

	traverse_recursive
		do
			from until
				not is_traversing
			loop
				traverse_object (object)
				forth
			end
		ensure
			not_traversing: not is_traversing
		end

	cleanup
		local
			l_visited: like visited_objects
		do
			l_visited := visited_objects
			from
				l_visited.start
			until
				l_visited.after
			loop
				unmark (l_visited.item_for_iteration)
				l_visited.forth
			end
			unlock_marking
		ensure
			visited_objects_empty: visited_objects.is_empty
		end

feature {NONE} -- Constants

	default_dispenser_size: INTEGER = 20


end
