note
	description: "Cursors storing a position in a linked container."
	author: "Nadia Polikarpova"
	model: box

deferred class
	V_CELL_CURSOR [G]

feature -- Access

	item: G
			-- Item at current position.
		require
			not_off: not off
		do
			Result := active.item
		ensure
			defintion: Result = box.any_item
		end

feature -- Status report

	off: BOOLEAN
			-- Is current position off scope?
		do
			Result := active = Void or not reachable
		ensure
			definition: Result = box.is_empty
		end

feature -- Replacement

	put (v: G)
			-- Replace item at current position with `v'.
		note
			modify: box
		require
			not_off: not off
		do
			active.put (v)
		ensure
			box_effect: box.any_item = v
		end

feature {V_CELL_CURSOR} -- Implementation

	active: V_CELL [G]
			-- Cell at current position.
		deferred
		end

	reachable: BOOLEAN
			-- Is `active' part of the target container?
		deferred
		end

feature -- Specification

	box: MML_SET [G]
			-- Element the cursor is pointing to.
		note
			status: specification
		do
			if off then
				create Result
			else
				create Result.singleton (item)
			end
		ensure
			exists: Result /= Void
		end

invariant
	box_count_constraint: box.count <= 1

end
