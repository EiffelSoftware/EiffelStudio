note
	description: "An iterator to traverse collections."

class F_I_ITERATOR

create
	make

feature {NONE} -- Initialization

	make (t: F_I_COLLECTION)
			-- Create an iterator to traverse `t'.
		note
			status: creator
		require
			target_exists: t /= Void
			modify (Current)
			modify_field (["observers", "closed"], t)
		do
			target := t
			before := True
			t.unwrap
			t.set_observers (t.observers & Current)
			t.wrap
		ensure
			target_set: target = t
			before: before and not after
			observing_target: t.observers = old t.observers & Current
			capacity_unchanged: t.capacity = old t.capacity
		end

feature -- Access

	target: F_I_COLLECTION
			-- Collection to traverse.

	before: BOOLEAN
			-- Is the iterator before the first element?

	after: BOOLEAN
			-- Is the iterator after the last element?

	item: INTEGER
			-- Collection element at current position.
		require
			not_off: not (before or after)
			target_closed: target.closed
		do
			Result := target.elements [index]
		end

feature -- State change		

	forth
			-- Move to the next position.
		require
			not_after: not after
		do
			index := index + 1
			before := False
			if index > target.count then
				after := True
			end
		ensure
			not_before: not before
			target_unchanged: target = old target
		end

feature {NONE} -- Implementation

	index: INTEGER
		-- Iterator position.

invariant
	target_exists: target /= Void
	subjects_structure: subjects = [target]
	index_in_bounds: 0 <= index and index <= target.count + 1
	before_definition: before = (index < 1)
	after_definition: after = (index > target.count)

end
