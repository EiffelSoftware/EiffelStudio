class
	RING_BUFFER

create
	make

feature {NONE}

	make (n: INTEGER)
			-- Initialize with buffer of size `n'.
		note
			status: creator
		require
			n_positive: n > 0
		do
			create data.make (n)
			data_index := 1
		ensure
			is_empty: count = 0
			data_initialized: data.count = n
			data_index_initialized: data_index = 1
		end

feature -- Acces

	count: INTEGER
			-- Queue length.

	item: INTEGER
			-- Current item of queue.
		require
			not_empty: count > 0
		do
			Result := data[data_index]
		ensure
			definition: Result = data.sequence[data_index]
		end

	extend (v: INTEGER)
			-- Append `v' to end of queue.
		require
			not_full: count < data.sequence.count
		local
			l_index: INTEGER
		do
			data[((data_index + count - 1) \\ data.count) + 1] := v
			count := count + 1
		ensure
			count_increased: count = old count + 1
			data_index_unchanged: data_index = old data_index
			v_inserted: data.sequence = (old data.sequence).replaced_at (((data_index + (old count) - 1) \\ data.count) + 1, v)
		end

	remove
			-- Remove `item' from queue.
		require
			not_empty: count > 0
		do
			data_index := (data_index \\ data.count) + 1
			count := count - 1
		ensure
			count_decreased: count = old count - 1
			data_retained: data.sequence = old data.sequence
			data_index_increased: data_index = ((old data_index) \\ data.count) + 1
		end

feature -- Removal

	wipe_out
			-- Remove all elements from queue.
		do
			count := 0
		ensure
			count = 0
		end

feature -- Implementation

	data: SIMPLE_ARRAY [INTEGER]
			-- Buffer contents.

	data_index: INTEGER
			-- Queue head (if any).

invariant
	data_not_void: data /= Void
	owns_definition: owns = [data]
	data_not_empty: data.sequence.count > 0
	index_in_range: 1 <= data_index and data_index <= data.sequence.count

end
