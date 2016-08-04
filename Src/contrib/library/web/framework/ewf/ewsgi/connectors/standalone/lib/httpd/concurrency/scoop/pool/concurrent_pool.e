note
	description: "Concurrent pool for SCOOP concurrency mode."
	date: "$Date$"
	revision: "$Revision$"

class
	CONCURRENT_POOL [G -> CONCURRENT_POOL_ITEM]

inherit
	HTTPD_DEBUG_FACILITIES

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER)
		do
			capacity := n
			create items.make_empty (n)
			create busy_items.make_empty (n)
		end

feature -- Access

	count: INTEGER
			-- Number of concurrent items managed by Current pool.

	capacity: INTEGER
			-- Maximum number of concurrent items managed by Current pool.

feature -- Status report

	is_full: BOOLEAN
			-- Pool is full?
		do
			Result := count >= capacity
		end

	is_empty: BOOLEAN
			-- No concurrent item waiting in current pool.
		do
			Result := count = 0
		end

	stop_requested: BOOLEAN
			-- Current pool received a request to terminate.

feature -- Access

	separate_item (a_factory: separate CONCURRENT_POOL_FACTORY [G]): detachable separate G
			-- Reused, or new separate item of type {G} created by `a_factory'.
		require
			is_not_full: not is_full
		local
			i,n,pos: INTEGER
			lst: like busy_items
			l_item: detachable separate G
		do
			if not stop_requested then
				from
					lst := busy_items
					pos := -1
					i := 0
					n := lst.count - 1
				until
					i > n or l_item /= Void or pos >= 0
				loop
					if not lst [i] then -- is free (i.e not busy)
						pos := i

						if items.valid_index (pos) then
							l_item := items [pos]
							if l_item /= Void then
								busy_items [pos] := True
							end
						end
						if l_item = Void then
								-- Empty, then let's create one.
							l_item := a_factory.new_separate_item
							register_item (l_item)
							items [pos] := l_item
						end
					end
					i := i + 1
				end
				if l_item = Void then
						-- Pool is FULL ...
					check overcapacity: False end
				else
					debug ("pool", "dbglog")
						dbglog ("Lock pool item #" + pos.out + " (free:"+ (capacity - count).out +"))")
					end
					count := count + 1
					busy_items [pos] := True
					Result := l_item
					a_factory.update_item (l_item)
				end
			end
		end

feature -- Basic operation

	gracefull_stop
			-- Request the Current pool to terminate.
		do
			stop_requested := True
		end

feature {NONE} -- Internal

	items: SPECIAL [detachable separate G]
			-- List of concurrent items.

	busy_items: SPECIAL [BOOLEAN]
			-- Map of items being proceed.

feature {CONCURRENT_POOL_ITEM} -- Change

	release_item (a_item: separate G)
			-- Unregister `a_item' from Current pool.
		require
			count > 0
		local
			i,n,pos: INTEGER
			lst: like items
		do
				-- release handler for reuse
			from
				lst := items
				i := 0
				n := lst.count - 1
			until
				i > n or lst [i] = a_item
			loop
				i := i + 1
			end
			if i <= n then
				pos := i
				busy_items [pos] := False
				count := count - 1
--reuse				items [pos] := Void
				debug ("pool", "dbglog")
					dbglog ("Released pool item #" + i.out + " (free:"+ (capacity - count).out +"))")
				end
			else
				check known_item: False end
			end
		end

feature -- Change

	set_count (n: INTEGER)
			-- Set capacity of Current pool to `n'.
		local
			g: detachable separate G
		do
			capacity := n
			items.fill_with (g, 0, n - 1)
			busy_items.fill_with (False, 0, n - 1)
		end

	terminate
			-- Terminate current pool.
		local
			l_items: like items
		do
			l_items := items
			l_items.wipe_out
		end

feature {NONE} -- Implementation

	register_item (a_item: separate G)
			-- Adopt `a_item' in current pool.
		do
			a_item.set_pool (Current)
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
