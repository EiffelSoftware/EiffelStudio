indexing
	description: "Cache for data";
	date: "$Date$";
	revision: "$Revision$"

deferred class CACHE [T -> IDABLE, H -> COMPILER_ID]

inherit
	TO_SPECIAL [ARRAY [T]]

	SHARED_CONFIGURE_RESOURCES
		undefine
			copy, is_equal, consistent, setup
		end

feature -- Initialization

	make is
			-- Creates a table of Cache_size hash_entry
		local
			i: INTEGER
			array: ARRAY [T]
		do
			Size := Cache_size
			Count := 0
			make_area (Cache_size)
			!! array_count.make (0, Cache_size - 1)
			from 
			until
				i = Cache_size
			loop
				!! array.make (1, 5)
				area.put (array, i)
				i := i + 1
			end
		end

	make_i (n : INTEGER)  is
			-- Creates a table of n hash_entry
		local
			i: INTEGER
			array: ARRAY [T]
		do
			Size := n
			Count := 0
			make_area (n)
			!! array_count.make (0, n - 1)
			from 
			until
				i = n
			loop
				!! array.make (1, 5)
				area.put (array, i)
				i := i + 1
			end
		end

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
		do
			Result :=  Configure_resources.get_integer (r_Cache_size, Default_size)
		end;

	Default_size: INTEGER is
			-- Default cache size
		deferred
		end;

	array_count: ARRAY [INTEGER]
			-- Number of element in each sub-array

feature -- Cache manipulations
							
	has_id (id: H): BOOLEAN is
			-- Is an item of id `i' in the cache ?
		require
			not_void: id /= Void
		local
			i, j, k: INTEGER			
			found: BOOLEAN
			l_array: ARRAY [T]
		do
			k := id.internal_id
			i := k \\ Size
			from
				l_array := area.item (i)
				j := array_count.item (i)
			until
				j = 0 or else found
			loop
				found := equal(l_array.item(j).id,id)
				j := j - 1
			end
			Result := found
debug ("CACHE")
	if Size < 500 then
		from 
			i :=  0
			j := Size
		until
			i = j
		loop
			print (array_count.item (i))
			if i /= 0 and then i \\ 80 = 0 then
				print (" \%N")
			else
				print ("-")
			end
			i := i + 1
		end
	end

	print ("%N")
	print (generator)
	print (" has a total of: ")
	print (Count)
	print ("%N")
	print ("Result of the has_id: ")
	print (found)
	print ("%N%N")
end
		end

	item_id (id: H): T is
			-- Item which id is `an_id'
			-- Void if not found
		require
			not_void: id /= Void
		local
			i, j, k: INTEGER			
			found: BOOLEAN
			l_array: ARRAY [T]
			tmp: T
		do
			k := id.internal_id
			i := k \\ Size
			from
				l_array := area.item (i)
				k := array_count.item (i)
				j := k
			until
				j = 0 or else found
			loop
				found := equal(l_array.item (j).id, id)
				j := j - 1
			end
			if found then
					-- We make the accessed item younger
				j := j + 1
				tmp := l_array.item (j)
				l_array.put (l_array.item (k), j)
				l_array.put (tmp, k)
				Result := tmp
				last_item_array := l_array
				last_item_pos := j
			end

debug ("CACHE")
	if Size < 500 then
		from 
			i :=  0
			j := Size
		until
			i = j
		loop
			print (array_count.item (i))
			if i /= 0 and then i \\ 80 = 0 then
				print (" \%N")
			else
				print("-")
			end
			i := i + 1
		end
	end

	print ("%N")
	print (generator)
	print (" has a total of: ")
	print (Count)
	print ("%NResult of the item_id:")
	print (found)
	print ("%N%N")
end
		end
	
	remove_id (id: H) is
			-- Remove item of id `i' form cache.
			-- better use force instead
		require
			not_void: id /= Void
		local
			i, j, k: INTEGER			
			found: BOOLEAN
			l_array: ARRAY [T]
			tmp: T
		do
			k := id.internal_id
			i := k \\ Size
			from
				l_array := area.item (i)
				j := array_count.item (i)
			until
				j = 0 or else found
			loop
				found := equal (l_array.item (j).id, id)
				j := j - 1
			end
			if found then
				Count := Count - 1
				from 
					k := j
					j := array_count.item (i)
					array_count.put (j - 1, i)
				until
					k = j
				loop
					l_array.put (l_array.item (k+1), k)
					k := k + 1
				end
			end
		end	
	
	put (e: T) is
			-- Put a new element in the cache
		require
			not_void: e /= Void
		local
			i, t: INTEGER
			l_array: ARRAY [T]
		do
			if not is_full then
				i := e.id.internal_id \\ Size
				l_array := area.item (i)
				t := array_count.item (i)
				if t = l_array.count then	
					l_array.resize (1, 2 * t)
				end
				array_count.put (t + 1, i)
				l_array.put (e, t + 1)
				Count := Count + 1
			end
		end

	force (e: T) is
			-- Like put if full remove an element 
			-- to put our new one
		require
			not_void: e /= Void
		local
			i, t: INTEGER
			l_array: array [T]
		do	
			i := e.id.internal_id \\ Size
			l_array := area.item (i)
			if not is_full then
				t := array_count.item (i)
				if l_array.count = t then	
					l_array.grow (2 * t)
				end
				array_count.put (t + 1, i)
				l_array.put (e, t + 1)
				Count := Count + 1
				last_removed_item := Void	
			else
				t := array_count.item (i)
				if t = 0 then
					remove_first_found
					l_array.put (e, 1)
					array_count.put (1, i)
				elseif t = 1 then
					last_removed_item := l_array.item (1)
					l_array.put (e, 1)
				else
					last_removed_item := l_array.item (1)
					l_array.put (l_array.item (t), 1)
					l_array.put (e, t)
				end
			end
		end
		
	is_full: BOOLEAN is
			-- Is the cache full ?
		do
			Result := Count >= Size
		end				

	is_empty: BOOLEAN is
			-- Is the cache empty ?
		do
			Result := Count = 0
		end
		
	clear_all, wipe_out is
			-- Wipe all out
		local
			s: INTEGER
		do
			from 
				s := Size 
			until 	
				s = 0
			loop
				s := s - 1
				area.item(s).clear_all
			end
			array_count.clear_all
			Count := 0
			after := True
		end

	change_last_item (e: T) is
			-- Make e take the place of the last item consulted
		do
			last_item_array.put (e, last_item_pos)
		end

	Count: INTEGER
			-- Number of item currently in the cache

	Size: INTEGER
			-- Maximum number of items in the cache

	last_removed_item: T
			-- Last automaticly removed item by function force

feature -- Linear iteration

	start is
			-- Put item_for_iteration on the first element of the cache
		require
			not_empty: not is_empty
		local
			item_array: INTEGER
		do
			from
				item_array := 0
			until
				item_array = Size or else area.item (item_array).item (1) /= Void
			loop
				item_array := item_array + 1
			end

			if item_array = Size then
				after := True
			else
				after := False
				last_item_array := area.item (item_array)
				last_item_array_number := item_array
				last_item_pos := 1
			end
		end

	after: BOOLEAN
			-- Are we at the end of the CACHE?
		
	forth is
			-- Put item_for_iteration on the next element of the cache
		local
			item_array, item_number, limit: INTEGER
			array_current: ARRAY [T]
			found: BOOLEAN
		do
			from
				item_array := last_item_array_number			
				item_number := last_item_pos + 1
				array_current := last_item_array
				limit := array_count.item (item_array)
			until
				found or else item_array = Size
			loop
				from
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
			-- Current item used for the linear traversal.
		do
			Result := last_item_array.item (last_item_pos)
		end

feature {NONE}

	last_item_array: ARRAY [T]
			-- Array in which the last searched item 
			-- was found

	last_item_pos: INTEGER
			-- Position in which the last
			-- searched item was found

	last_item_array_number: INTEGER
			-- Number of last_item_array	
							
feature {NONE} -- to implement force

	remove_first_found is
			-- Need to remove an element whatever it is
			-- we know that the cache is not empty
			-- we want to make some room to put something else
			-- so we do not touch to Count
		require
			not_empty_cache: not is_empty
		local
			item_array, j, k: INTEGER
			l_array: ARRAY [T]
		do
			from
				item_array := 0
			until
				item_array = Size or else area.item (item_array).item (1) /= Void
			loop
				item_array := item_array + 1
			end
			from 
				l_array := area.item (item_array)
				last_removed_item := l_array.item (1)
				j := array_count.item (item_array)
				array_count.put (j - 1, item_array)
				k := 1
			until
				k = j
			loop
				l_array.put (l_array.item (k+1), k)
				k := k + 1
			end
			l_array.put (Void, j)
		end

end -- class CACHE
