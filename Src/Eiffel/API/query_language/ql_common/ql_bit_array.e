note
	description: "Object that represents a bit array"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_BIT_ARRAY

inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature{NONE} -- Initialization

	make (a_bit_count: INTEGER)
			-- Initialize Current with `a_bit_count' of bits.
		require
			a_bit_count_positive: a_bit_count > 0
		local
			l_count: INTEGER
			i: INTEGER
		do
			count := a_bit_count
			if count \\ 32 = 0 then
				create storage.make_filled (0, count // 32)
			else
				create storage.make_filled (0, count // 32 + 1)
			end
			from
				i := 0
				l_count := storage.count
			until
				i = l_count
			loop
				storage.put (0, i)
				i := i + 1
			end
		ensure
			count_set: count = a_bit_count
		end

feature -- Setting

	set_bit (a_index: INTEGER)
			-- Set `a_index'-th bit to 1.
		require
			a_index_valid: is_index_valid (a_index)
		do
			set_bit_with_value (a_index, 1)
		ensure
			bit_set: bit_at (a_index) = 1
		end

	unset_bit (a_index: INTEGER)
			-- Unset `a_index'-th bit to 0.
		require
			a_index_valid: is_index_valid (a_index)
		do
			set_bit_with_value (a_index, 0)
		ensure
			bit_unset: bit_at (a_index) = 0
		end

	set_bit_with_value (a_index: INTEGER; a_value: INTEGER)
			-- Set `a_index'-th bit to `a_value'.
		require
			a_index_valid: is_index_valid (a_index)
			a_value_valie: a_value = 0 or a_value = 1
		local
			l_div: INTEGER
			l_mod: INTEGER
			l_value: NATURAL_32
			l_storage: like storage
		do
			l_div := a_index // 32
			l_mod := a_index \\ 32
			l_storage := storage
			l_value := l_storage.item (l_div)
			if a_value = 1 then
				l_value := l_value.bit_or (bit_map.item (l_mod))
			else
				l_value := l_value.bit_and (reversed_bit_map.item (l_mod))
			end
			l_storage.put (l_value, l_div)
		ensure
			bit_set: bit_at (a_index) = a_value
		end

feature -- Access

	count: INTEGER
			-- Number of bits

	is_index_valid (a_index: INTEGER): BOOLEAN
			-- Is `a_index' valid?
		do
			Result := a_index >= 0 and then a_index < count
		end

	bit_at (a_index: INTEGER): INTEGER
			-- Bit at position `a_index'
			-- Result is 0 or 1.
		require
			a_index_valid: is_index_valid (a_index)
		local
			l_div: INTEGER
			l_mod: INTEGER
		do
			l_div := a_index // 32
			l_mod := a_index \\ 32
			if storage.item (l_div).bit_and (bit_map.item (l_mod)) > 0 then
				Result := 1
			else
				Result := 0
			end
		end

	is_bit_set (a_index: INTEGER): BOOLEAN
			-- Is bit at position `a_index' set?
		require
			a_index_valid: is_index_valid (a_index)
		local
			l_div: INTEGER
			l_mod: INTEGER
		do
			l_div := a_index // 32
			l_mod := a_index \\ 32
			Result := storage.item (l_div).bit_and (bit_map.item (l_mod)) > 0
		end

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		local
			i: INTEGER
			l_count: INTEGER
			l_storage, l_other_storage: like storage
		do
			l_count := count
			if other.count = l_count then
				from
					Result := True
					l_storage := storage
					l_other_storage := l_other_storage
					i := 0
				until
					i = l_count or not Result
				loop
					Result := l_storage.item (i) = l_other_storage.item (i)
					i := i + 1
				end
			end
		end

	count_of_set_bits: INTEGER
			-- Number of bits whose value is 1
		local
			i: INTEGER
			l_count: INTEGER
		do
			from
				i := 0
				l_count := count
			until
				i = l_count
			loop
				if is_bit_set (i) then
					Result := Result + 1
				end
				i := i + 1
			end
		end

	count_of_unset_bits: INTEGER
			-- Number of bits whose value is 0
		do
			Result := count - count_of_set_bits
		ensure
			good_result: Result = count - count_of_set_bits
		end

	list_of_bit_index (a_set: BOOLEAN): LIST [INTEGER]
			-- List of indexes of set bits if `a_set' is True,
			-- otherwise unset bits
		local
			i: INTEGER
			l_count: INTEGER
		do
			create {LINKED_LIST [INTEGER]} Result.make
			from
				i := 0
				l_count := count
			until
				i = l_count
			loop
				if a_set then
					if is_bit_set (i) then
						Result.extend (i)
					end
				else
					if not is_bit_set (i) then
						Result.extend (i)
					end
				end
				i := i + 1
			end
		ensure
			result_attached: Result /= Void
		end

feature{QL_BIT_ARRAY} -- Implementation

	storage: SPECIAL [NATURAL_32]
			-- Array to store bits		

feature{NONE} -- Implementation

	bit_map: SPECIAL [NATURAL_32]
			-- Map for bits
		local
			l_map: NATURAL_32
			i: INTEGER
		once
			create Result.make_filled (0, 32)
			from
				l_map := 1
				i := 0
			until
				i = 32
			loop
				Result.put (l_map, i)
				l_map := l_map |<< 1
				i := i + 1
			end
		ensure
			result_attached: Result /= Void
		end

	reversed_bit_map: SPECIAL [NATURAL_32]
			-- Reversed map for bits
		local
			l_map: NATURAL_32
			l_max: NATURAL_32
			i: INTEGER
		once
			create Result.make_filled (0, 32)
			from
				l_max := {NATURAL_32}.max_value
				l_map := 1
				i := 0
			until
				i = 32
			loop
				Result.put (l_max.bit_xor (l_map), i)
				l_map := l_map |<< 1
				i := i + 1
			end
		ensure
			result_attached: Result /= Void
		end

invariant
	storage_attached: storage /= Void
	bit_map_attached: bit_map /= Void
	reversed_bit_map_attached: reversed_bit_map /= Void

note
        copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end
