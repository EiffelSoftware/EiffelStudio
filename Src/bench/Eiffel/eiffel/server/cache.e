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

debug ("SERVER")
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
		do
			from
					-- Iteration on the id queue which is implemented as
					-- a circular list: `out_index' is the index of the 
					-- out_index id of the queue, `in_index' is the next index
					-- for insertion
				size := capacity+1;
				i := out_index;
			until
				i = in_index or else stop
			loop
				j := i;
				stop := equal (i_th (i).id, an_id);
				i := (i + 1) \\ size
			end;
			if stop then
				Result := j;
			else
					-- `capacity' is not a valid index for elements in
					-- an instance of FIXED_QUEUE
				Result := in_index;
			end;
		end;

	item_id (an_id: H): T is
			-- Item which id is `an_id'
		local
			position, size, j, i, last_index: INTEGER;
		do
			position := index_of (an_id);
			if position /= in_index then
					-- Successful search
				Result := i_th (position);
					-- Side effect: reorganization of queue; the founded
					-- id in put in front of the queue.
				from
					size := capacity + 1;
					i := position;
					last_index := (in_index - 1 + size) \\ size;
				until
					i = last_index
				loop
					j := (i + 1) \\ size;
					put_i_th (i_th (j),i);
					i := j;
				end;
					-- The asked id is put at the end of the queue.
				put_i_th (Result, i);
			end;
		end;

end
