indexing
	description: "[
				`Active' data structures, which at every stage have
				a possibly undefined `current item'.
				Basic access and modification operations apply to the current item.
			 ]"
	class_type: Interface
	external_name: "ISE.Base.Active"

deferred class
	ACTIVE [G]

inherit
	BAG [G]

feature -- Access

	item: G is
		indexing
			description: "Current item"
		require
			readable: readable
		deferred
		end

feature -- Status report

	readable: BOOLEAN is
		indexing
			description: "Is there a current item that may be read?"
		deferred
		end

	writable: BOOLEAN is
		indexing
			description: "Is there a current item that may be modified?"
		deferred
		end

feature -- Element change

	replace (v: G) is
		indexing
			description: "Replace current item by `v'."
		require
			writable: writable
		deferred
		ensure
			item_replaced: item = v
		end

feature -- Removal

	remove is
		indexing
			description: "Remove current item."
		require
			prunable: prunable
			writable: writable
		deferred
		end

--invariant

--	writable_constraint: writable implies readable
--	empty_constraint: is_empty implies (not readable) and (not writable)

end -- class ACTIVE



