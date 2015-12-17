note
	description: "Streams that provide values one by one."
	author: "Nadia Polikarpova"
	model: box

deferred class
	V_INPUT_STREAM [G]

feature -- Access

	item: G
			-- Item at current position.
		require
			not_off: not off
		deferred
		ensure
			definition: Result = box.any_item
		end

feature -- Status report

	off: BOOLEAN
			-- Is current position off scope?
		deferred
		ensure
			definition: Result = box.is_empty
		end

feature -- Cursor movement

	forth
			-- Move one position forward.
		note
			modify: box
		require
			not_off: not off
		deferred
		end

	search (v: G)
			-- Move to the first occurrence of `v' at or after current position.
			-- If `v' does not occur, move `after'.
			-- (Use reference equality.)
		note
			modify: box
		do
			from
			until
				off or else item = v
			loop
				forth
			end
		ensure
			box_effect: box.is_empty or else box.any_item = v
		end

	satisfy (pred: PREDICATE [detachable G])
			-- Move to the first position at or after current where `pred' holds.
			-- If `pred' never holds, move `after'.
		note
			modify: box
		require
			pred_has_one_arg: pred.open_count = 1
			--- pred_is_total: pred.precondition |=| True
		do
			from
			until
				off or else pred.item ([item])
			loop
				forth
			end
		ensure
			box_effect: box.is_empty or else pred.item ([box.any_item])
		end

feature -- Specification

	box: MML_SET [G]
			-- Current element in the stream.
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
