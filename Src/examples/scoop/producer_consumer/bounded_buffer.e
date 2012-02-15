note
	description	: "Objects that implement bounded buffers."
	author		: "Volkan Arslan, Yann Mueller, Piotr Nienaltowski."
	date		: "$Date: 18.05.2007$"
	revision	: "1.0.0"

class
	BOUNDED_BUFFER [G -> ANY create default_create end]

create
	make_with_capacity

feature -- Initialization

	make_with_capacity (a_capacity: INTEGER)
			-- Initialize with capacity of `a_capacity'.
		require
			valid_capacity: a_capacity > 0
		do
			create storage.make
			capacity := a_capacity
		ensure
			capacity_set: capacity = a_capacity
			empty: is_empty
		end

feature -- Access

	last_consumed_item: detachable G
			-- Last item removed by `consume'.
		note
			option: stable
		attribute
		end

feature -- Element change

	put (a_element: G)
			-- Store element.
		require
			not_full: not is_full
		do
			storage.extend (a_element)
			print ("%NBUFFER: added element " + a_element.out)
		ensure
			count_incremented: count = old count + 1
			not_empty: not is_empty
		end

	consume
			-- Consume an element.
		require
			not_empty: not is_empty
		do
			last_consumed_item := storage.first
			storage.start
			storage.remove
			print ("%NBUFFER: removing element " + last_consumed_item.out + ".")
		ensure
			count_decremented: count = old count - 1
			not_full: not is_full
		end

feature -- Status report

	is_full: BOOLEAN
			-- Is buffer full?
		do
			Result := (storage.count = capacity)
		ensure
			correct_result: Result = (storage.count = capacity)
		end

	is_empty: BOOLEAN
			-- Is buffer empty?
		do
			Result := storage.count = 0
		ensure
			correct_result: Result = (storage.count = 0)
		end

feature -- Measurement

	capacity: INTEGER
		-- Maximum number of elements.

	count: INTEGER
			-- The number of elements.
		do
			Result := storage.count
		ensure
			correct_result: Result = storage.count
		end

feature {NONE}-- Implementation

	storage: LINKED_LIST [G]
			-- Implementation.

invariant
	capacity_positive: capacity > 0
	correct_count: storage.count <= capacity

end -- class BOUNDED_BUFFER

