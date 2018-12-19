note
	description: "Cursors storing a position in a linked container."
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: box

deferred class
	V_CELL_CURSOR [G]

feature -- Access

	item: G
			-- Item at current position.
		require
			not_off: not off
		do
			check not_off: attached active as a then
				Result := a.item
			end
		ensure
			defintion: Result = box.any_item
		end

feature -- Status report

	off: BOOLEAN
			-- Is current position off scope?
		do
			Result := active = Void
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
			check not_off: attached active as a then
				a.put (v)
			end
		ensure
			box_effect: box.any_item = v
		end

feature {V_CELL_CURSOR} -- Implementation

	active: detachable V_CELL [G]
			-- Cell at current position.
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
		end

invariant
	box_count_constraint: box.count <= 1

end
