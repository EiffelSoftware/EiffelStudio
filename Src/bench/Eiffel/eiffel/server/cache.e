-- Cache for server: the keys are ids

deferred class CACHE [T -> IDABLE, H -> COMPILER_ID] 

inherit

	EXTEND_QUEUE [T]
		rename
			make as queue_make
		export
			{CACHE} out_index, in_index, lower, upper, area
		end;
	SHARED_CONFIGURE_RESOURCES

feature

	make is
			-- Creation
		do
debug ("CACHE_SERVER")
	io.new_line
	io.putstring (generator)
	io.putstring (" has a cache of ")
	io.putint (cache_size)
end
			queue_make (Cache_size);
			in_index := 0;
			out_index := 0;
		end;

	cache_size: INTEGER is
			-- Cache size
		local
			s: STRING
		do
			s := generator
			s.to_lower
			Result := Configure_resources.get_integer (s, default_value)

debug ("CACHE_SERVER")
	io.error.putstring ("Size of ")
	io.error.putstring (generator)
	io.error.putstring (" is ")
	io.error.putint (Result)
	io.error.new_line
end
		end;

	default_value: INTEGER is
			-- Default value of cache
		once
			Result :=  Configure_resources.get_integer (r_Cache_size, Default_size)
		end;

	Default_size: INTEGER is
			-- Default cache size
		deferred
		end;

feature -- Cache manipulations 

	remove_id (i: H) is
			-- Remove item of id `i' form cache.
		local
			nb, nb_iter: INTEGER;
			an_item: T;
		do
			from
				nb := count;
				nb_iter := 1;
			until
				nb_iter > nb
			loop
				an_item := item;
				remove;
				if not equal (an_item.id, i) then
					put (an_item);
				end;
				nb_iter := nb_iter + 1
			end;
		end;

	has_id (i: H): BOOLEAN is
			-- Is an item of id `i' in the cache ?
		do
			Result := index_of (i) /= in_index
		end;

	index_of (an_id: H): INTEGER is
			-- Index of object which id is `an_id'. If not found, return
			-- `capacity'.
		local
			i, j, size: INTEGER;
			stop: BOOLEAN;
			local_area: SPECIAL [T]
		do
			from
					-- Iteration on the id queue which is implemented as
					-- a circular list: `out_index' is the index of the 
					-- out_index id of the queue, `in_index' is the next index
					-- for insertion
				size := array_capacity
				i := out_index
				local_area := area
			until
				i = in_index or else stop
			loop
				j := i
				stop := equal (local_area.item (i).id, an_id)
				i := (i + 1) \\ size
			end;
			if stop then
				Result := j
			else
					-- `capacity' is not a valid index for elements in
					-- an instance of FIXED_QUEUE
				Result := in_index
			end
		end

	item_id (an_id: H): T is
			-- Item which id is `an_id'
		local
			pos, size, j, i, last_index: INTEGER;
			local_area: SPECIAL [T]
		do
			pos := index_of (an_id);
			if pos /= in_index then
					-- Successful search
				local_area := area
				Result := local_area.item (pos);
					-- Side effect: reorganization of queue; the founded
					-- id in put in front of the queue.
				from
					size := array_capacity
					i := pos
					last_index := (in_index - 1 + size) \\ size
				until
					i = last_index
				loop
					j := (i + 1) \\ size
					local_area.put (local_area.item (j),i)
					i := j
				end;
					-- The asked id is put at the end of the queue.
				local_area.put (Result, i)
			end;
		end;

end
