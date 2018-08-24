note
	description: "Node in a circular doubly-linked list."

frozen class F_DLL_NODE

create
	make

feature {NONE} -- Initialization

	make
			-- Create a singleton node.
		note
			status: creator
		do
			left := Current
			right := Current
		ensure
			singleton: left = Current
		end

feature -- Access

	left: F_DLL_NODE
			-- Left neighbor.
		note
			guard: not_left
		attribute
		end

	right: F_DLL_NODE
			-- Right neighbor.			
		note
			guard: not_right
		attribute
		end

feature -- Modification

	insert_right (n: F_DLL_NODE)
			-- Insert node `n' to the right of the current node.
		note
			explicit: wrapping
		require
			n_singleton: n.left = n
			right_wrapped: right.is_wrapped
			modify (Current, right, n)
		local
			r: F_DLL_NODE
		do
			r := right
			unwrap_all ([Current, r, n])

			n.set_right (r)
			n.set_left (Current)

			r.set_left (n)
			set_right (n)

			n.set_subjects ([r, Current])
			n.set_observers ([r, Current])
			set_subjects ([left, n])
			set_observers ([left, n])
			r.set_subjects ([n, r.right])
			r.set_observers ([n, r.right])
			wrap_all ([Current, r, n])
		ensure
			n_left_set: right = n
			n_right_set: n.right = old right
		end

	remove
			-- Remove the current node from the list.
		note
			explicit: wrapping
		require
			left_wrapped: left.is_wrapped
			right_wrapped: right.is_wrapped
			modify (Current, left, right)
		local
			l, r: F_DLL_NODE
		do
			l := left
			r := right
			unwrap_all ([Current, l, r])

			set_left (Current)
			set_right (Current)

			l.set_right (r)
			r.set_left (l)

			set_subjects ([Current])
			set_observers ([Current])
			l.set_subjects ([l.left, r])
			l.set_observers ([l.left, r])
			r.set_subjects ([l, r.right])
			r.set_observers ([l, r.right])
			wrap_all ([Current, l, r])
		ensure
			singleton: right = Current
			old_left_wrapped: (old left).is_wrapped
			old_right_wrapped: (old right).is_wrapped
			neighbors_connected: (old left).right = old right
		end

feature {F_DLL_NODE} -- Implementation

	set_left (n: F_DLL_NODE)
			-- Set left neighbor to `n'.
		require
			open: is_open
			left_open: left.is_open
			modify_field ("left", Current)
		do
			left := n -- preserves `right'
		ensure
			left = n
		end

	set_right (n: F_DLL_NODE)
			-- Set right neighbor to `n'.
		require
			open: is_open
			right_open: right.is_open
			modify_field ("right", Current)
		do
			right := n -- preserves `left'
		ensure
			right = n
		end

feature -- Specification

	not_left (new_left: F_DLL_NODE; o: ANY): BOOLEAN
			-- Is `o' different from `left'?
		note
			status: functional
		do
			Result := o /= left
		end

	not_right (new_right: F_DLL_NODE; o: ANY): BOOLEAN
			-- Is `o' different from `right'?
		note
			status: functional
		do
			Result := o /= right
		end

invariant
	left_exists: left /= Void
	right_exists: right /= Void
	subjects_structure: subjects = [ left, right ]
	observers_structure: observers = [ left, right ]
	left_consistent: left.right = Current
	right_consistent: right.left = Current

end
