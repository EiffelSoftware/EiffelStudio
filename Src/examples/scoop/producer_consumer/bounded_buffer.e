indexing
	description	: "Objects that implement bounded buffers."
	author		: "Volkan Arslan, Yann Mueller, Piotr Nienaltowski."
	date		: "$Date: 18.05.2007$"
	revision	: "1.0.0"

class
	BOUNDED_BUFFER [G]

create
	make_with_capacity

feature -- Initialization
	make_with_capacity (a_capacity: INTEGER)
			-- Creation procedure.
		require
			a_capacity > 0
		do
			create storage.make
			capacity := a_capacity
		ensure
			is_empty
		end

feature -- Basic operations

	put (an_element: G)
			-- Store element.
		require
			not is_full
		do
			storage.extend (an_element)
			io.put_string ("%NBUFFER: added element " + an_element.out)
			-- scoop_sleep (500)
		ensure
			count = old count + 1
			not is_empty
		end

	get: G
			-- Consume element.
		require
			not is_empty
		do
			Result := storage.first
			storage.start
			storage.remove
			io.put_string  ("%NBUFFER: removed element " + Result.out)
			-- scoop_sleep (500)
		ensure
			count = old count - 1
			not is_full
		end

feature -- Access

	is_full: BOOLEAN
			-- Is buffer full?
		do
			Result := (storage.count = capacity)
		ensure
			Result = (storage.count = capacity)
		end

	is_empty: BOOLEAN
			-- Is buffer empty?
		do
			Result := storage.count = 0
		ensure
			Result = storage.count = 0
		end

	capacity: INTEGER
		-- Maximum number of elements.

	count: INTEGER
			-- The number of elements.
		do
			Result := storage.count
		ensure
			Result = storage.count
		end

feature {NONE}-- Implementation
	storage: LINKED_LIST [G]

invariant
	capacity_positive: capacity > 0
	correct_count: storage.count <= capacity

end -- class BOUNDED_BUFFER
