indexing
	description: "Cache for data";
	date: "$Date$";
	revision: "$Revision$"

deferred class CACHE [T -> IDABLE, H -> COMPILER_ID]

inherit
	TO_SPECIAL [T]

	SHARED_CONFIGURE_RESOURCES
		undefine
			copy, is_equal, consistent, setup
		end

feature -- Initialization

	make is
			-- Creates a table of Cache_size hash_entry
		do
			size := Cache_size
			make_area (size)
		end

	make_sized (n : INTEGER)  is
			-- Creates a table of n hash_entry
		do
			size := n
			make_area (n)
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
	io.error.putstring ("size of ")
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

feature -- Cache manipulations
							
	has_id (id: H): BOOLEAN is
			-- Is an item of id `i' in the cache ?
		require
			not_void: id /= Void
		local
			i: INTEGER
			t: T
		do
			i := id.internal_id \\ size
			t := area.item (i)
			if t /= Void then
				Result := equal (t.id, id)
			end
		end

	item_id (id: H): T is
			-- Item which id is `an_id'
			-- Void if not found
		require
			not_void: id /= Void
		local
			i: INTEGER			
		do
			i := id.internal_id \\ size
			Result := area.item (i)	
			if Result /= Void and then not equal (Result.id, id) then
				Result := Void	
			end
		end
	
	remove_id (id: H) is
			-- Remove item of id `i' form cache.
			-- better use force instead
		require
			not_void: id /= Void
		local
			i: INTEGER
			t: T
		do
			i := id.internal_id \\ size
			t := area.item (i)
			if t /= Void and then equal (t.id, id) then
				area.put (Void, i)
				last_removed_item := t
			end
		end	
	
	change_last_item (v: T) is
			-- Put a new element in the cache
		require
			not_void: v /= Void
		do
			area.put (v, v.id.internal_id \\ size)
		end

	force (v: T) is
			-- Put a new element in the cache, if there already was
			-- an item, save it in `last_removed_item'
		require
			not_void: v /= Void
		local
			i: INTEGER
		do
			i := v.id.internal_id \\ size
			last_removed_item := area.item (i)
			area.put (v, i)
		end

	clear_all, wipe_out is
			-- Wipe all out
		local
			s: INTEGER
		do
			area.clear_all
			after := True
		end

	size: INTEGER
			-- Maximum number of items in the cache

	last_removed_item: T
			-- Last automaticly removed item by function force

feature -- Linear iteration

	start is
			-- Put `item_for_iteration' on the first element of the cache
		do
			position := -1
			after := false
			forth 
		end

	after: BOOLEAN
			-- Are we at the end of the CACHE?
		
	forth is
			-- Put `item_for_iteration' on the next element of the cache
		local
			found: BOOLEAN
			pos: INTEGER
		do
			from
				pos := position
			until
				found or else pos >= size
			loop
				pos := pos + 1
				found := area.item (pos) /= Void
			end

			if not found or else pos >= size then
				after := True
			else
				position := pos
			end
		end					

	item_for_iteration: T is
			-- Current item used for the linear traversal.
		do
			Result := area.item (position)
		end

feature {NONE} -- Implementation

	position: INTEGER
			-- Position in which the last
			-- searched item was found

end -- class CACHE
