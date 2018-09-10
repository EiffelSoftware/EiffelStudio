note
	description: "A collection implemented using an array-based list."
	explicit: "all"

frozen class F_I_COLLECTION_D

create
	make

feature {NONE} -- Initialization

	make (c: INTEGER)
			-- Create a collection with capacity `c'.
		note
			status: creator
		require
			capacity_non_negative: c >= 0
			modify (Current)
		do
			create elements.make (c)
			set_owns ([elements])
			wrap
		ensure
			capacity_set: capacity = c
			empty: count = 0
			no_observers: observers = []
			default: is_wrapped
		end

feature -- Access

	count: INTEGER
			-- Number of elements in the collection.

	capacity: INTEGER
			-- Maximum number of elements in the collection.
		note
			status: functional
		require
			closed: closed
			reads (ownership_domain)
		do
			Result := elements.count
		end

feature -- Element change		

	add (v: INTEGER)
			-- Add `v' to the collection.
		require
			wrapped: is_wrapped
			observers_wrapped: across observers as o all o.item.is_wrapped end
			not_full: count < capacity
			modify (Current)
			modify_field ("closed", observers)
		do
			unwrap
			unwrap_all (observers)
			set_observers ([])
			count := count + 1
			elements.put (v, count)
			wrap
		ensure
			count_increased: count = old count + 1
			no_observers: observers = []
			old_observers_open: across old observers as o all o.item.is_open end
			elements_unchanged: elements = old elements
			capacity_unchanged: capacity = old capacity
			wrapped: is_wrapped
		end

	remove_last
			-- Remove the last added elements from the collection.
		require
			wrapped: is_wrapped
			observers_wrapped: across observers as o all o.item.is_wrapped end
			not_empty: count > 0
			modify (Current)
			modify_field ("closed", observers)
		do
			unwrap
			unwrap_all (observers)
			set_observers ([])
			count := count - 1
			wrap
		ensure
			count_decreased: count = old count - 1
			no_observers: observers = []
			old_observers_open: across old observers as o all o.item.is_open end
			elements_unchanged: elements = old elements
			capacity_unchanged: capacity = old capacity
			wrapped: is_wrapped
		end

feature {F_I_ITERATOR_D} -- Implementation

	elements: F_I_ARRAY
			-- Element storage.

invariant
	elements /= Void
	owns = [elements]
	0 <= count and count <= elements.count
	across observers as o all attached o.item and o.item /= Current end
	default_subjects: subjects = []
end
