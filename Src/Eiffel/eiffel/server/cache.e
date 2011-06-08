note
	description: "Cache for data, the index is an integer number"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class CACHE [T -> IDABLE]

inherit
	TO_SPECIAL [detachable SPECIAL [H_CELL [T]]]
		export
			{NONE} all
		end

	SHARED_CONFIGURE_RESOURCES

create
	make

feature -- Initialisation

	make
			-- Creates a table of Cache_size hash_entry
		local
			s, i: INTEGER
			l_special: like last_item_special
		do
			s := Cache_size
			count := 0
			size := s
			make_filled_area (Void, s)
			create history.make (s)
			create index.make_filled (0, s)
			create free_h_cells.make_empty (1)
			from
			until
				i = s
			loop
					-- Hard coded size for initial setup.
				create l_special.make_empty (5)
				area.put (l_special, i)
				i := i + 1
			end
		end

feature -- Cache manipulations

	has_id (id: INTEGER): BOOLEAN
			-- Is an item of id `i' in the cache ?
		require
			not_void: id /= 0
		local
			i, j: INTEGER
			l_special: like last_item_special
		do
			i := id \\ Size
			from
				l_special := area.item (i)
				j := l_special.count
			until
				j = 0 or else Result
			loop
				j := j - 1
				Result := l_special.item (j).item.id = id
			end

			debug ("CACHE")
				if Size < 500 then
					from
						i :=  0
						j := Size
					until
						i = j
					loop
						io.put_integer (area.item (i).count)
						if i /= 0 and then i \\ 80 = 0 then
							io.put_string (" \%N")
						else
							io.put_string ("-")
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
				io.put_boolean (Result)
				io.put_string ("%N%N")
			end

			debug ("CACHE_STAT")
				nb_has_id := nb_has_id + 1
				if Result then
					nb_has_id_succeded := nb_has_id_succeded + 1
				end
				success_has_id := (nb_has_id_succeded / nb_has_id).truncated_to_real
				success := ((nb_has_id_succeded + nb_item_id_succeded) / (nb_has_id + nb_item_id)).truncated_to_real
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

	item_id (id: INTEGER): T
			-- Item which id is `an_id'
			-- Void if not found
		require
			not_void: id /= 0
		local
			i, j: INTEGER
			l_special: like last_item_special
			tmp: H_CELL [T]
			found: BOOLEAN
		do
			i := id \\ Size
			from
				l_special := area.item (i)
				j := l_special.count
			until
				j = 0 or else found
			loop
				j := j - 1
				found := l_special.item (j).item.id = id
			end
			if found then
					-- we make the accessed item younger
				tmp := l_special.item (j)
				Result := tmp.item
				history.make_younger (tmp.index)
				tmp.set_index (history.younger)
				last_item_special := l_special
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
						io.put_integer (area.item (i).count)
						if i /= 0 and then i \\ 80 = 0 then
							io.put_string (" \%N")
						else
							io.put_string ("-")
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
				success_item_id := (nb_item_id_succeded / nb_item_id).truncated_to_real
				success := ((nb_has_id_succeded + nb_item_id_succeded) / (nb_has_id + nb_item_id)).truncated_to_real
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

	remove_id (id: INTEGER)
			-- Remove item of id `i' form cache.
			-- better use force instead
		require
			not_void: id /= 0
		local
			i, j, nb: INTEGER
			found: BOOLEAN
			l_special: like last_item_special
			tmp: H_CELL [T]
		do
			i := id \\ Size
			from
				l_special := area.item (i)
				nb := l_special.count
				j := nb
			until
				j = 0 or else found
			loop
				j := j - 1
				found := l_special.item (j).item.id = id
			end
			debug ("CACHE_RESEARCH")
				if not found then
					io.put_string ("Be carefull: object not found%N")
				end
			end
			if found then
				count := count - 1
				tmp := l_special.item (j)
				last_removed_item := tmp.item
				history.remove (tmp.index)
				if j < nb - 1 then
					l_special.overlapping_move (j + 1, j, nb - j - 1)
				end
				if free_h_cells.count = free_h_cells.capacity then
					free_h_cells := free_h_cells.aliased_resized_area (free_h_cells.count * 2)
				end
				free_h_cells.extend (tmp)
				l_special.remove_tail (1)
			end
		end

	force (e: T)
			-- like put if full remove an element
			-- to put our new one
		require
			not_void: e /= Void
			not_has_id: not has_id (e.id)
		local
			i, t: INTEGER
			l_special: like last_item_special
			h_cell: H_CELL [T]
			to_remove: T
			l_default: T
		do
			i := e.id \\ Size
			l_special := area.item (i)
			history.add (e)
			to_remove := history.to_remove
			if to_remove /= Void then
				internal_remove (to_remove)
			else
				last_removed_item := l_default
				count := count + 1
			end
			if free_h_cells.count >= 1 then
				h_cell := free_h_cells.item (free_h_cells.count - 1)
				free_h_cells.remove_tail (1)
				h_cell.make (e, history.younger)
			else
				create h_cell.make (e, history.younger)
			end
			t := l_special.capacity
			if l_special.count = t then
				l_special := l_special.aliased_resized_area (2 * t)
				area.put (l_special, i)
			end
			l_special.extend (h_cell)
		end

	is_full: BOOLEAN
			-- is the cache full ?
		do
			Result := count >= size
		end

	is_empty: BOOLEAN
			-- is the cache empty ?
		do
			Result := count = 0
		end

	wipe_out
			-- wipe all out
		local
			s: INTEGER
			l_area: like area
		do
			from
				s := Size
				l_area := area
			until
				s = 0
			loop
				s := s - 1
				l_area.item (s).wipe_out
			end
			history.wipe_out
			count := 0
			after := True
			free_h_cells.wipe_out
			free_h_cells := free_h_cells.aliased_resized_area (5)
		end

	change_last_item (e: T)
			-- make e take the place of the last item consulted
		local
			tmp: H_CELL [T]
		do
			tmp := last_item_special.item (last_item_pos)
			tmp.set_item (e)
			history.set_item (e,tmp.index)
		end

	history: CACHE_HISTORY [T]
			-- history of the arrivals in the cache

	index: SPECIAL [INTEGER]
			-- index of each item in the history

	count: INTEGER
			-- number of item currently in the cache

	size: INTEGER
			-- maximum number of items in the cache

	last_removed_item: T
			-- last automaticly removed item by function force

feature -- linear iteration

	start
			-- put item_for_iteration on the first element of the cache
		do
			if is_empty then
				after := True
			else
				last_item_array_number := 0
				last_item_pos := -1
				after := False
				forth
			end
		end

	after: BOOLEAN

	forth
			-- put item_for_iteration on the next element of the cache
		local
			item_array, item_number: INTEGER
			l_special: like last_item_special
			l_area: like area
			found: BOOLEAN
		do
			from
				l_area := area
				item_array := last_item_array_number
				item_number := last_item_pos + 1
			until
				found or else item_array = size
			loop
				l_special:= l_area.item (item_array)
				found := item_number < l_special.count
				if not found then
					item_array := item_array + 1
					item_number := 0
				end
			end
			if not found then
				after := True
			else
				last_item_special := l_special
				last_item_array_number := item_array
				last_item_pos := item_number
			end
		end

	item_for_iteration: T
			-- give the item in a linear ?????
		do
			Result := last_item_special.item (last_item_pos).item
		end

feature {NONE} -- Implementation

	cache_size: INTEGER
			-- Cache size
		local
			s: STRING
			l_int: INTERNAL
		do
			create l_int
			if l_int.generic_count (Current) > 0 then
				s := l_int.class_name_of_type (l_int.generic_dynamic_type (Current, 1))
			else
				s := generator
			end
			s.to_lower
			Result := Configure_resources.get_integer (s, default_value)

			debug ("CACHE_SERVER")
				io.error.put_string ("Size of ")
				io.error.put_string (generator)
				io.error.put_string (" is ")
				io.error.put_integer (Result)
				io.error.put_new_line
			end
		end;

	default_value: INTEGER
			-- Default value of cache
		do
			Result :=  Configure_resources.get_integer (r_cache_size, 20)
		end;

	last_item_special: SPECIAL [detachable H_CELL [T]]
		-- the array in which the last searched item
		-- was found

	last_item_pos: INTEGER
		-- the position in which the last
		-- searched item was found

	last_item_array_number: INTEGER
		-- the number of last_item_special	

feature {NONE} -- to implement force

	internal_remove (e: T)
			-- Remove item of id `i' from cache.
			-- but do not touch the history nor count
		require
			not_void: e /= Void
		local
			i, j, nb: INTEGER
			found: BOOLEAN
			id: INTEGER
			l_special: like last_item_special
			tmp: H_CELL [T]
		do
			id := e.id
			i := id \\ Size
			from
				l_special := area.item (i)
				nb := l_special.count
				j := nb
			until
				j = 0 or else found
			loop
				j := j - 1
				found := l_special.item (j).item.id = id
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
				tmp := l_special.item (j)
				last_removed_item := tmp.item
				if j < nb - 1 then
						-- Shift right elements to the left only if they are right elements
					l_special.overlapping_move (j + 1, j, nb - j - 1)
				end
				if free_h_cells.count = free_h_cells.capacity then
					free_h_cells := free_h_cells.aliased_resized_area (free_h_cells.count * 2)
				end
				free_h_cells.extend (tmp)
				l_special.remove_tail (1)
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

	free_h_cells: SPECIAL [H_CELL [T]];
			-- Buffer for unused H_CELL instances.

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class CACHE
