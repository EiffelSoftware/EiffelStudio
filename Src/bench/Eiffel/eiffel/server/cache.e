indexing
	description: "Cache for data";
	date: "$Date$";
	revision: "$Revision$"

deferred class CACHE [T -> IDABLE, H -> COMPILER_ID]

inherit
	TO_SPECIAL [TWO_ITEMS [T]]

	SHARED_CONFIGURE_RESOURCES
		undefine
			copy, is_equal, consistent, setup
		end

feature -- Initialization

	make is
			-- Creates a table of Cache_size hash_entry
		local
			i: INTEGER
			t: TWO_ITEMS [T]
		do
			size := Cache_size
			count := 0
			from
				make_area (size)
			until
				i = size
			loop
				!! t
				area.put (t, i)
				i := i + 1
			end
		end

	make_sized (n : INTEGER)  is
			-- Creates a table of n hash_entry
		local
			i: INTEGER
			t: TWO_ITEMS [T]
		do
			size := n
			count := 0
			make_area (n)
			from
				make_area (size)
			until
				i = size
			loop
				!! t
				area.put (t, i)
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
			t: TWO_ITEMS [T]
		do
			i := id.internal_id \\ size
			t := area.item (i)
			Result := (t.first /= Void) and then (equal(t.first.id, id)
					or else (t.second /= Void and then equal(t.second.id, id)))
		end

	item_id (id: H): T is
			-- Item which id is `an_id'
			-- Void if not found
		require
			not_void: id /= Void
		local
			i: INTEGER			
			t: TWO_ITEMS [T]
		do
			i := id.internal_id \\ size
			t := area.item (i)
			position := i
			Result := t.first
			if Result /= Void and then not equal (Result.id, id) then
				Result := t.second
				first := False
				if Result /= Void and then not equal (Result.id, id) then
					Result := Void
				end
			else
				first := True
			end
		end
	
	remove_id (id: H) is
			-- Remove item of id `i' form cache.
			-- better use force instead
		require
			not_void: id /= Void
		local
			i: INTEGER
			t: TWO_ITEMS [T]
			it: T
		do
			i := id.internal_id \\ size
			t := area.item (i)
			it := t.first
			last_removed_item := Void
			if it /= Void then 
				if equal (it.id, id) then
					t.set_first (t.second)
					last_removed_item := it
					count := count - 1
				else
					it := t.second
					if it /= Void and then equal (it.id, id) then
						t.set_second (Void)
						last_removed_item := it
						count := count - 1
					end
				end
			end
		end	
	
	change_last_item (v: T) is
			-- Put v instead of the last item found by item_id
		require
			not_void: v /= Void
		do
			if first then
				area.item (position).set_first (v)
			else
				area.item (position).set_second (v)
			end
		end

	force (v: T) is
			-- Put a new element in the cache, if it was full 
			-- remove an element and remind it in last_removed_item	
		require
			not_void: v /= Void
		local
			i: INTEGER
			t: TWO_ITEMS [T]
			lfirst, lsecond: T
		do
			i := v.id.internal_id \\ size
			t := area.item (i)
			lfirst := t.first
			lsecond := t.second
			if lfirst /= Void then
				last_removed_item := lsecond
				if lsecond = Void then
					if count < size then
						count := count + 1
					else
						remove_first_found
					end
				end
				t.set_second (lfirst)
				t.set_first (v)
			else	
				last_removed_item := Void
				if count < size then
					count := count + 1
				else
					remove_first_found
				end
				t.set_first (v)
			end
		end

	clear_all, wipe_out is
			-- Wipe all out
		local
			s, i: INTEGER
		do
			from
				s := size
			until
				i = s
			loop
				area.item (i).wipe_out
				i := i + 1
			end
			count := 0
		end

	size: INTEGER
			-- Maximum number of items in the cache

	count: INTEGER
			-- Number of element in the cache

	last_removed_item: T
			-- Last automaticly removed item by function force

feature -- Linear iteration

	start is
			-- Put `item_for_iteration' on the first element of the cache
		local
			i: INTEGER
		do
			if count = 0 then
				after := True
			else
					-- There IS an element in the cache
					-- it MUST be a first in a TWO_ITEMS
				from 
				until
					area.item (i).first /= Void
				loop
					i := i + 1
				end
				position := i
				first := True
				item_for_iteration := area.item (i).first
				after := false
			end
		end

	after: BOOLEAN
			-- Are we at the end of the CACHE?		

	forth is
			-- Put `item_for_iteration' on the next element of the cache		
		local
			pos: INTEGER
			lfirst: BOOLEAN
			item: T
		do
			from 
				lfirst := first
				if lfirst then				
					pos := position
					lfirst := False
					item := area.item (pos).second
				else
					lfirst := True
					pos := position
					if pos < size - 1 then
						pos := pos + 1
						item := area.item (pos).first
					else
						after := True
					end
				end
			until
				item /= Void or else after
			loop
				if lfirst then
					lfirst := False
					item := area.item (pos).second
				else
					lfirst := True
					if pos < size - 1 then
						pos := pos + 1
						item := area.item (pos).first
					else
						after := True
					end
				end
			end				
			position := pos
			first := lfirst
			item_for_iteration := item
		end
	
	item_for_iteration: T 
			-- Current item used for the linear traversal.

feature {NONE} -- Implementation

	position: INTEGER
			-- Position in which the last
			-- searched item was found

	first: BOOLEAN
			-- Position of the last searched item
			-- in TWO_ITEMS

	remove_first_found is
			-- Remove the first element found in the cache.
			-- Force needs to put a new element in a full cache,
			-- so we don't touch to count.
		local
			t: TWO_ITEMS [T]
		do
			start
			t := area.item (position)
				-- The first element found will be first in the TWO_ITEMS
			if t.second /= Void then
				last_removed_item := t.second
				t.set_second (Void)
			else
				last_removed_item := t.first
				t.set_first (Void)
			end
		end


end -- class CACHE
