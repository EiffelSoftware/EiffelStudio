indexing
	description: "Cache for data, the index is an integer number";
	date: "$Date$";
	revision: "$Revision$"

deferred class CACHE [T -> IDABLE]

inherit
	SHARED_CONFIGURE_RESOURCES

feature -- Initialisation

	make is
			-- Creates a table of Cache_size hash_entry
		local
			i, n: INTEGER
			l_array: SPECIAL [H_CELL[T]]
		do
			n := cache_size
			size := n
			count := 0
			create area.make (n)
			create array_count.make (n)
			create history.make (n)
			create index.make (n)
			from 
			until
				i = n
			loop
				create l_array.make (5)
				area.put (l_array, i)
				i := i + 1
			end
		end

	cache_size: INTEGER is
			-- Cache size
		do
			Result := Configure_resources.get_integer (generator.as_lower, default_value)

			debug ("CACHE_SERVER")
				io.error.put_string ("Size of ")
				io.error.put_string (generator)
				io.error.put_string (" is ")
				io.error.put_integer (Result)
				io.error.put_new_line
			end
		end;

	default_value: INTEGER is
			-- Default value of cache
		do
			Result :=  Configure_resources.get_integer (r_Cache_size, Default_size)
		end;

	Default_size: INTEGER is
			-- Default cache size
		deferred
		end;

	array_count: SPECIAL [INTEGER]
		-- number of element in each sub-array

feature -- Cache manipulations
							
	has_id (id: INTEGER): BOOLEAN is
			-- Is an item of id `i' in the cache ?
		require
			not_void: id /= 0
		local
			i, j: INTEGER			
			found: BOOLEAN
			l_array: SPECIAL [H_CELL[T]]
		do
			i := id \\ size
			from
				l_array := area.item (i)
				j := array_count.item (i)
			until
				j = 0 or else found
			loop
				found := l_array.item(j).item.id = id
				j := j - 1
			end
			Result := found

			debug ("CACHE")
				if size < 500 then
					from 
						i :=  0
						j := size
					until
						i = j
					loop
						io.put_integer (array_count.item (i))
						if i /= 0 and then i \\ 80 = 0 then
							io.put_string (" \%N")
						else
							io.put_string("-")
						end
						i := i + 1
					end
				end
			
				io.put_string ("%N")
				io.put_string (generator)
				io.put_string (" has a total of: ")
				io.put_integer (Count)
				io.put_string ("%N")
				io.put_string ("Result of the has_id: ")
				io.put_boolean (found)
				io.put_string ("%N%N")
			end

			debug ("CACHE_STAT")
				nb_has_id := nb_has_id + 1
				if found then
					nb_has_id_succeded := nb_has_id_succeded + 1
				end
				success_has_id := nb_has_id_succeded / nb_has_id
				success := (nb_has_id_succeded + nb_item_id_succeded) / (nb_has_id + nb_item_id)
				io.put_string (generator)
				io.put_string ("%NNumber of has_id: ")
				io.put_integer (nb_has_id)
				io.put_string ("%NProportion of has_id succeded: ")
				io.put_real (success_has_id)
				io.put_string ("%NProportion of access succeded: ")
				io.put_real (success)
				io.put_string ("%N%N")
			end
		end

	item_id (id: INTEGER): T is
			-- Item which id is `an_id'
			-- Void if not found
		require
			not_void: id /= 0
		local
			i, j: INTEGER			
			found: BOOLEAN
			l_array: SPECIAL [H_CELL[T]]
			tmp: H_CELL[T]
		do
			i := id \\ size
			from
				l_array := area.item (i)
				j := array_count.item (i)
			until
				j = 0 or else found
			loop
				found := l_array.item (j).item.id = id
				j := j - 1
			end
			if found then
					-- we make the accessed item younger
				j := j + 1
				tmp := l_array.item (j)
				Result := tmp.item
				history.make_younger (tmp.index)
				tmp.set_index (history.younger)
				last_item_array := l_array
				last_item_pos := j
			end

			debug ("CACHE")
				if size < 500 then
					from 
						i :=  0
						j := size
					until
						i = j
					loop
						io.put_integer (array_count.item (i))
						if i /= 0 and then i \\ 80 = 0 then
							io.put_string (" \%N")
						else
							io.put_string("-")
						end
						i := i + 1
					end
				end
				io.put_string ("%N")
				io.put_string (generator)
				io.put_string (" has a total of: ")
				io.put_integer (Count)
				io.put_string ("%NResult of the item_id:")
				io.put_boolean (found)
				io.put_string ("%N%N")
			end

			debug ("CACHE_STAT")
				nb_item_id := nb_item_id + 1
				if found then
					nb_item_id_succeded := nb_item_id_succeded + 1
				end
				success_item_id := nb_item_id_succeded / nb_item_id
				success := (nb_has_id_succeded + nb_item_id_succeded) / (nb_has_id + nb_item_id)
				io.put_string (generator)
				io.put_string ("%NNumber of item_id: ")
				io.put_integer (nb_item_id)
				io.put_string ("%NProportion of item_id succeded: ")
				io.put_real (success_item_id)
				io.put_string ("%NProportion of access succeded: ")
				io.put_real (success)
				io.put_string ("%N%N")
			end
		end
	
	remove_id (id: INTEGER) is
			-- Remove item of id `i' form cache.
			-- better use force instead
		require
			not_void: id /= 0
		local
			i, j, k: INTEGER			
			found: BOOLEAN
			l_array: SPECIAL [H_CELL[T]]
			tmp: H_CELL[T]
		do
			i := id \\ size
			from
				l_array := area.item (i)
				j := array_count.item (i)
			until
				j = 0 or else found
			loop
				found := l_array.item (j).item.id = id
				j := j - 1
			end
			if found then
				count := count - 1
				j := j + 1
				tmp := l_array.item (j)
				history.remove (tmp.index)
				from 
					k := j
					last_removed_item := tmp.item
					j := array_count.item (i)
					array_count.put (j - 1, i)
				until
					k = j
				loop
					l_array.put (l_array.item (k+1), k)
					k := k + 1
				end
				l_array.put (Void, j)
			end
		end	

	force (e: T) is
			-- like put if full remove an element 
			-- to put our new one
		require
			not_void: e /= Void
		local
			i, t: INTEGER
			l_array: SPECIAL [H_CELL[T]]
			h_cell: H_CELL[T]
			to_remove: T
		do	
			i := e.id \\ size
			l_array := area.item (i)
			history.add (e)
			create h_cell.make (e, history.younger)
			to_remove := history.to_remove
			if to_remove /= Void then
				internal_remove (to_remove)
			else
				last_removed_item := Void
				count := count + 1
			end
			t := array_count.item (i) + 1
			array_count.put (t, i)
			if l_array.capacity = t then	
				l_array := l_array.resized_area (2 * t)
				area.put (l_array, i)
			end
			l_array.put (h_cell, t)
		end
		
	is_full: BOOLEAN is
			-- is the cache full ?
		do
			Result := count >= size
		end				

	is_empty: BOOLEAN is
			-- is the cache empty ?
		do
			Result := count = 0
		end
		
	clear_all, wipe_out is
			-- wipe all out
		local
			s: INTEGER
		do
			from 
				s := size 
			until 	
				s = 0
			loop
				s := s - 1
				area.item(s).clear_all
			end
			history.wipe_out
			array_count.clear_all
			count := 0
			after := True
		end

	change_last_item (e: T) is
			-- make e take the place of the last item consulted
		local
			tmp: H_CELL[T]
		do
			tmp := last_item_array.item (last_item_pos)
			tmp.set_item (e)
			history.set_item (e,tmp.index) 
		end

	history: CACHE_HISTORY[T]
			-- history of the arrivals in the cache

	index: SPECIAL[INTEGER]
			-- index of each item in the history

	count: INTEGER
			-- number of item currently in the cache

	size: INTEGER
			-- maximum number of items in the cache

	last_removed_item: T
			-- last automaticly removed item by function force

feature -- linear iteration

	start is
			-- put item_for_iteration on the first element of the cache
		local
			item_array: INTEGER
		do
			if is_empty then
				after := True
			else
				from
					item_array := 0
				until
					item_array = size or else area.item (item_array).item (1) /= Void
				loop
					item_array := item_array + 1
				end
				if item_array = size then
					after := True
				else
					after := False
					last_item_array := area.item (item_array)
					last_item_array_number := item_array
					last_item_pos := 1
				end
			end
		end

	after: BOOLEAN
		
	forth is
			-- put item_for_iteration on the next element of the cache
		local
			item_array, item_number, limit: INTEGER
			array_current: SPECIAL [H_CELL[T]]
			found: BOOLEAN
		do
			from
				item_array := last_item_array_number			
				item_number := last_item_pos + 1
				array_current := last_item_array
			until
				found or else item_array = size
			loop
				from
					limit := array_count.item (item_array)
					array_current:= area.item (item_array)
				until
					found or else item_number > limit
				loop
					found := array_current.item (item_number) /= Void
					if not found then
						item_number := item_number + 1
					end
				end
				if not found then
					item_array := item_array + 1
					item_number := 1
				end
			end
			if not found then
				after := True
			else
				last_item_array := area.item (item_array)
				last_item_array_number := item_array
				last_item_pos := item_number
			end
		end					

	item_for_iteration: T is
			-- give the item in a linear ?????
		do
			Result := last_item_array.item (last_item_pos).item
		end

feature {NONE}

	last_item_array: SPECIAL [H_CELL[T]]
			-- the array in which the last searched item 
			-- was found

	last_item_pos: INTEGER
			-- the position in which the last
			-- searched item was found

	last_item_array_number: INTEGER
			-- the number of last_item_array	
							
	area: SPECIAL [SPECIAL [H_CELL[T]]]
			-- Storage

feature {NONE} -- to implement force

	internal_remove (e: T) is
			-- Remove item of id `i' from cache.
			-- but do not touch to history nor count
		require
			not_void: e /= Void
		local
			i, j, k: INTEGER			
			found: BOOLEAN
			id: INTEGER
			l_array: SPECIAL [H_CELL[T]]
		do
			id := e.id
			i := id \\ size
			from
				l_array := area.item (i)
				j := array_count.item (i)
			until
				j = 0 or else found
			loop
				found := l_array.item (j).item.id = id
				j := j - 1
			end
			debug ("CACHE_RESEARCH")
				if not found then
					io.put_string ("Be carefull: object not found%N")
				end
			end
			if found then
				-- found IS true
				-- the if is to avoid a bug I didn't find (yet)
				-- in the cache history
				j := j + 1
				from 
					k := j
					last_removed_item := l_array.item (j).item
					j := array_count.item (i)
					array_count.put (j - 1, i)
				until
					k = j
				loop
					l_array.put (l_array.item (k+1), k)
					k := k + 1
				end
				l_array.put (Void, j)
			end
		end	

feature {NONE} -- statistics

	nb_has_id: INTEGER
		-- number of call to has_id

	nb_item_id: INTEGER
		-- number of call to item_id

	nb_has_id_succeded: INTEGER
		-- number of succeded call to has_id

	nb_item_id_succeded: INTEGER
		-- number of succeded call to item_id

	success_has_id: REAL
		-- proportion of successful calls to has_id
	
	success_item_id: REAL
		-- proportion of successful calls to item_id

	success: REAL
		-- proportion of successful researchs in the cache

end -- class CACHE
