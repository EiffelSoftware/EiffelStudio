note
	description: "Maps UTF-8 byte position to UTF-32 character position."
	date: "$Date$"
	revision: "$Revision$"

class
	UNICODE_POSITION_MAPPER

create
	make

feature {NONE} -- Init

	make (a_utf8_text: like text)
			-- Init with UTF-8 text.
		require
			a_utf8_text_not_void: a_utf8_text /= Void
		do
			text := a_utf8_text
			create cached_mappings.make (cache_size)
			create sorted_known_byte_pos.make (cache_size)
		ensure
			text_set: text = a_utf8_text
		end

feature -- Mapper

	utf32_pos_from_utf8_pos (a_utf8_pos: INTEGER): INTEGER
			-- UTF-32 character position from UTF-8 byte position.
		require
			a_utf8_pos: a_utf8_pos > 0
		do
			clean_up_cache
			Result := utf32_pos_from_utf8_pos_from_cache (a_utf8_pos, 0, 0)

				-- Remember the first mapping.
			cached_mappings.force (Result, a_utf8_pos)
			sorted_known_byte_pos.extend (a_utf8_pos)
			last_byte_position := a_utf8_pos
			last_character_position := Result
		end

	next_utf32_pos_from_utf8_pos (a_utf8_pos: INTEGER): INTEGER
			-- UTF-32 character position from UTF-8 byte position.
			-- `a_utf8_pos' must not be smaller than `last_byte_position'
			-- Even faster than `fast_utf32_pos_from_utf8_pos', as `a_utf8_pos' is incremental.
		require
			valid_pos: a_utf8_pos >= last_byte_position
		local
			l_closest: like closest_known_byte_position
		do
			l_closest := closest_known_byte_position (a_utf8_pos)
			Result := utf32_pos_from_utf8_pos_from_cache (a_utf8_pos, l_closest.byte, l_closest.char)

				-- Remember the mapping.
			if not cached_mappings.has (a_utf8_pos) then
				sorted_known_byte_pos.extend (a_utf8_pos)
			end
			cached_mappings.force (Result, a_utf8_pos)
			last_byte_position := a_utf8_pos
			last_character_position := Result
		end

	fast_utf32_pos_from_utf8_pos (a_utf8_pos: INTEGER): INTEGER
			-- UTF-32 character position from UTF-8 byte position.
			-- `a_utf8_pos', try to find the closest cache, but not cache found value if it is not increamental one.
		local
			l_closest: like closest_known_byte_position
		do
			l_closest := closest_known_byte_position (a_utf8_pos)
			Result := utf32_pos_from_utf8_pos_from_cache (a_utf8_pos, l_closest.byte, l_closest.char)

				-- Remember the mapping.
			if a_utf8_pos > last_byte_position then
				if not cached_mappings.has (a_utf8_pos) then
					sorted_known_byte_pos.extend (a_utf8_pos)
				end
				cached_mappings.force (Result, a_utf8_pos)
				last_byte_position := a_utf8_pos
				last_character_position := Result
			end
		end

feature -- Access

	last_byte_position: INTEGER

	last_character_position: INTEGER

feature {NONE} -- Access

	text: STRING;
			-- Original text in UTF-8 encoding

feature {NONE} -- Implementation

	utf32_pos_from_utf8_pos_from_cache (a_utf8_pos: INTEGER; a_last_byte_pos, a_last_char_pos: INTEGER): INTEGER
			-- UTF-32 character position from UTF-8 byte position. Start computing from `a_last_byte_pos'.
		local
			l_nat8: NATURAL_8
			i, nb, cnt: INTEGER
			l_text: like text
		do
			from
				i := a_last_byte_pos + 1
				cnt := a_last_char_pos
				l_text := text
				nb := l_text.count
			until
				i > nb or i > a_utf8_pos
			loop
				l_nat8 := l_text.code (i).to_natural_8
				cnt := cnt + 1
				if l_nat8 <= 127 then
						-- Form 0xxxxxxx.
				elseif (l_nat8 & 0xE0) = 0xC0 then
						-- Form 110xxxxx 10xxxxxx.
					i := i + 1
				elseif (l_nat8 & 0xF0) = 0xE0 then
						-- Form 1110xxxx 10xxxxxx 10xxxxxx.
					i := i + 2
				elseif (l_nat8 & 0xF8) = 0xF0 then
						-- Form 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx.
					i := i + 3
				elseif (l_nat8 & 0xFC) = 0xF8 then
					-- Starts with 111110xx
					-- This seems to be a 5 bytes character,
					-- but UTF-8 is restricted to 4, then substitute with a space
					i := i + 4
				else
					-- Starts with 1111110x
					-- This seems to be a 6 bytes character,
					-- but UTF-8 is restricted to 4, then substitute with a space
					i := i + 5
				end
				i := i + 1
			end
			Result := cnt
		end

feature {NONE} -- Cache

	cache_size: INTEGER = 50

	cached_mappings: HASH_TABLE [INTEGER, INTEGER]
			-- Cached position mappings.
			-- [char_pos, byte_pos]

	sorted_known_byte_pos: ARRAYED_LIST [INTEGER]
			-- Sorted known position list

	clean_up_cache
			-- Clean up cache
		do
			cached_mappings.wipe_out
			sorted_known_byte_pos.wipe_out
		end

	closest_known_byte_position (a_utf8_pos: INTEGER): TUPLE [byte: INTEGER; char: INTEGER]
			-- Find the largest known position smaller than `a_utf8_pos'.
		local
			l_count: INTEGER
			l_known: like sorted_known_byte_pos
			i, j, t: INTEGER
		do
			l_known := sorted_known_byte_pos
			l_count := l_known.count
			if l_count > 0 then
				if a_utf8_pos > l_known [l_count] then
					Result := [l_known [l_count], cached_mappings.item (l_known [l_count])]
				else
						-- Find the largest known position smaller than `a_utf8_pos'.
					from
						i := 1
						j := l_count
					until
						l_known [i] = a_utf8_pos or else l_known [j] = a_utf8_pos or else j - i <= 1
					loop
						t := (i + j) // 2
						if a_utf8_pos > l_known [t] then
							i := t
						else
							j := t
						end
					end
					Result := [l_known [i], cached_mappings.item (l_known [i])]
				end
			else
				Result := [0, 0]
			end
		end

invariant
	cache_valid: cached_mappings.count = sorted_known_byte_pos.count

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
