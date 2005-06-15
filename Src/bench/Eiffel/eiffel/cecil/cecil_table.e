indexing
	description: "Hash table for cecil."
	date: "$Date$"
	revision: "$Revision$"

deferred class CECIL_TABLE [T] 

inherit
	ANY

	SHARED_WORKBENCH
		export
			{NONE} ALL
		end

	SHARED_GENERATION
		export
			{NONE} ALL
		end

	COMPILER_EXPORTER
		export
			{NONE} ALL
		end

	BASIC_ROUTINES
		export
			{NONE} ALL
		end

feature -- Initialization

	init (hash_size: INTEGER) is
			-- Table creation
		require
			hash_size_positive: hash_size > 0
		local
			i: INTEGER
		do
			i := primes.higher_prime (bottom_int_div (5 * hash_size, 4)) - 1
			create keys.make (0, i)
			create values.make (0, i)
		end

feature -- Status report

	capacity: INTEGER is
			-- Capacity of current
		do
			if values /= Void then
				Result := values.capacity
			end
		end

feature {NONE} -- Access

	values: ARRAY [T]
			-- Values of the hash table
			
	keys: ARRAY [STRING]
			-- Keys of the hash table

feature -- Removal

	wipe_out is
			-- Empty the table
		do
			keys := Void
			values := Void
		end

feature -- Element change

	put (f: T; s: STRING) is
			-- Insert `f' in the hash table
		require
			good_argument1: f /= Void
			good_argument2: s /= Void
		local
			increment, key, position, try, hash_size: INTEGER
			stop: BOOLEAN
			l_values: like values
			l_keys: like keys
		do
			from
				l_keys := keys
				l_values := values
				hash_size := capacity
				key := s.hash_code
				position := key \\ hash_size
				increment := 1 + (key \\ (hash_size - 1))
			until
				try >= hash_size or else stop
			loop
				if l_keys.item (position) = Void then
						-- Found a free location
					l_keys.put (s, position)
					l_values.put (f, position)
					stop := True
				end
				position := (position + increment) \\ hash_size
				try := try + 1
			end
		end

feature {NONE} -- Convenience

	primes: PRIMES is
			-- Prime number testor
		once
			create Result
		ensure
			primes_not_void: Result /= Void
		end

end
