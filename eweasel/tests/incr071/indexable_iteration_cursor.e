note
	description: "Concrete version of an external iteration cursor for {INDEXABLE}."
	library: "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	INDEXABLE_ITERATION_CURSOR [G]

inherit
	ITERATION_CURSOR [G]
		redefine
			make,
			target,
			start,
			forth
		end

create
	make

feature {NONE} -- Initialization

	make (s: like target)
			-- <Precursor>
		do
			Precursor (s)
			step := 1
			is_reversed := False
		ensure then
			default_step: step = 1
			ascending_traversal: not is_reversed
		end

feature -- Status setting

	reverse
			-- Flip traversal order.
		require
			not_set: not is_set
		do
			is_reversed := not is_reversed
		ensure
			is_reversed: is_reversed = not old is_reversed
		end

	set_step (v: like step)
			-- Set increment step to `v'.
		require
			not_set: not is_set
			v_positive: v > 0
		do
			step := v
		ensure
			step_set: step = v
		end

feature -- Access

	item: G
			-- <Precursor>
		do
			Result := target.item (target_index)
		end

	target_index: INTEGER
			-- Index position of `target' for current iteration

	step: INTEGER
			-- Distance between successive iteration elements

	reversed alias "-": like Current
			-- Reversed copy of Current
		require
			not_set: not is_set
		do
			Result := twin
			Result.reverse
		ensure
			is_reversed: Result.is_reversed = not is_reversed
		end

	incremented alias "+" (n: like step): like Current
			-- Copy of Current with step increased by `n'
		require
			not_set: not is_set
			n_valid: step + n > 0
		do
			Result := twin
			Result.set_step (step + n)
		ensure
			is_incremented: Result.step = step + n
		end

	decremented alias "-" (n: like step): like Current
			-- Copy of Current with step decreased by `n'
		require
			not_set: not is_set
			n_valid: step > n
		do
			Result := twin
			Result.set_step (step - n)
		ensure
			is_incremented: Result.step = step - n
		end

	with_step (n: like step): like Current
			-- Copy of Current with step set to `n'
		require
			not_set: not is_set
			n_positive: n > 0
		do
			Result := twin
			Result.set_step (n)
		ensure
			step_set: Result.step = n
		end

feature -- Cursor movement

	start
			-- <Precursor>
		do
			Precursor
			if is_reversed then
				target_index := index_set.upper
			else
				target_index := index_set.lower
			end
		end

	forth
			-- <Precursor>
		do
			Precursor
			if is_reversed then
				target_index := target_index - step
			else
				target_index := target_index + step
			end
		end

feature -- Status report

	off: BOOLEAN
			-- <Precursor>
		do
			Result := not target.valid_index (target_index)
		end

	is_reversed: BOOLEAN
			-- Are we traversing `target' backwards?

feature {NONE} -- Implementation

	target: READABLE_INDEXABLE [G]
			-- <Precursor>

	index_set: INTEGER_INTERVAL
			-- Range of acceptable indexes for `target'
		do
			Result := target.index_set
		end

invariant
	step_positive: step > 0

end
