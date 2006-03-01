indexing
	description: "History used for cache remembering system, so that element%
				%accessed more often are kept as much as possible."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_HISTORY [G]

inherit
		ARRAY[G]
			rename
				count as count_array,
				make as make_array,
				wipe_out as array_wipe_out,
				clear_all as array_clear_all
			end

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Create an history of size n
		local
			i: INTEGER
			int_array: ARRAY[INTEGER]
		do
			make_array (0,n - 1)
			create next.make (0, n - 1)
			create previous.make (0, n - 1)
			create free_cells.make (0, n - 1)
			from
				int_array := free_cells
			until
				i = n
			loop
				int_array.put (i, i)
				i := i + 1
			end
			size := n
			younger := -1
			older := -1
		end

feature

	next: ARRAY[INTEGER]
		-- Position of the next element in the history
		-- Understand next arrived

	previous: ARRAY[INTEGER]
		-- Position of the previous element in the history
		-- Understand previously arrived

	free_cells: ARRAY[INTEGER]
		-- Record of the cells still free in the history

	size: INTEGER
		-- Size of the history

	count: INTEGER
		-- Number of elements in the history

	older: INTEGER
		-- Index of the older element in the history

	younger: INTEGER
		-- Index of the younger element in the history

	to_remove: G
		-- Last element removed from the history
		--  by the force function

	add (e: G) is
			-- Add a new element in the history
		require
			non_void_arguement:	e /= Void
		local
			new_one: INTEGER
			l_default: G
		do
			if count < size then
				new_one := free_cells.item (count)
				count := count + 1
				if younger /= -1 then
					next.put(new_one, younger)
				else
					check went_from_empty_to_one: count = 1 end
					older := new_one
				end
				next.put(-1, new_one)
				previous.put(younger, new_one)
				younger := new_one
				put (e, new_one)
				to_remove := l_default
			else
				-- we are full: the older must leave
				new_one := older
				older := next.item(new_one)
				previous.put (-1, older)
				previous.put (younger, new_one)
				next.put (new_one, younger)
				next.put (-1, new_one)
				younger := new_one
				to_remove := item (new_one)
				put (e, new_one)
			end
		end

	make_younger (i: INTEGER) is
			-- Make the element of index i younger
			-- as it is accessed in the cache
		require
			out_of_bound: i <= capacity
		local
			next_i, previous_i: INTEGER
		do
			if younger /= i then
				previous_i := previous.item (i)
				next_i := next.item (i)
				if i = older then
					older := next_i
					previous.put (-1, next_i)
				else
					next.put (next_i, previous_i)
					previous.put (previous_i, next_i)
				end
				previous.put (younger, i)
				next.put (-1, i)
				next.put (i, younger)
				younger := i
			end
		end

	remove (i: INTEGER) is
			-- Remove the item of index i from the
			-- history
			-- Do not check if i is really a used cell
		require
			out_of_bound: i <= capacity
		local
			previous_i, next_i: INTEGER
			l_default: G
		do
			put (l_default, i)
			if count > 1 then
				previous_i := previous.item (i)
				next_i := next.item (i)
				if i = older then
					older := next_i
					previous.put (-1, next_i)
				elseif i = younger then
					younger := previous_i
					next.put (-1, previous_i)
				else
					next.put (next_i, previous_i)
					previous.put (previous_i, next_i)
				end
				count := count - 1
				free_cells.put (i, count)
			else
				older := -1
				younger := -1
				count := 0
				free_cells.put (i, 0)
			end
		end

	wipe_out, clear_all is
		local
			int_array: ARRAY [INTEGER]
			i: INTEGER
			l_default: G
		do
			count := 0
			younger := -1
			older := -1
			from
				int_array := free_cells
			until
				i = size
			loop
				int_array.put (i, i)
				i := i + 1
			end
			to_remove := l_default
			next.clear_all
			previous.clear_all
		end

	set_item (e: G; i: INTEGER) is
		-- change the item at the index i
		do
			put (e, i)
		end

	valid_content: BOOLEAN is
			-- Is content valid?
		local
			l_free_positions: SEARCH_TABLE [INTEGER]
			i, nb, l_found: INTEGER
		do
			create l_free_positions.make (capacity - count)
			from
				i := count
				Result := True
			until
				i = capacity or not Result
			loop
					-- add + 1 because 0 can not be hashed with the old HASH_TABLE.
				if l_free_positions.has (free_cells.item (i) + 1) then
					Result := False
				else
					l_free_positions.put (free_cells.item (i) + 1)
				end
				i := i + 1
			end

			if Result then
				from
					i := previous.lower
					nb := previous.upper
					l_found := 0
				until
					i > nb
				loop
					if not l_free_positions.has (i + 1) then
						if previous.item (i) = -1 then
							l_found := l_found + 1
						end
					end
					i := i + 1
				end

				Result := l_found <= 1

				if Result then
					from
						i := next.lower
						nb := next.upper
						l_found := 0
					until
						i > nb
					loop
						if not l_free_positions.has (i + 1) then
							if next.item (i) = -1 then
								l_found := l_found + 1
							end
						end
						i := i + 1
					end
					Result := l_found <= 1
				end
			end
		end

invariant
	older_good: older >= -1 and older <= size
	younger_good: younger >= -1 and younger <= size
	count_good: count >= 0 and count <= size
	valid_content: valid_content

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end


