indexing

	description: "Bit sequences of length `count', with binary operations"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

--| Caution:
--| For implementation reasons, additional operations on BIT types can
--| only be introduced by ISE

class BIT_REF inherit

	ANY
		redefine
			out,
			is_equal
		end

create {BIT_REF}
	make, make_initialized

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Initialize space for `n' bits.
		require
			positive_n: n > 0
		local
			tmp_values: ARRAY [INTEGER]
		do
			create tmp_values.make (0, n |>> 5)
			values := tmp_values.area
			count := n
		end

	make_initialized (l_area: SPECIAL [INTEGER]; l_count: INTEGER) is
			-- Initialize `Current' with a count of `l_count' and values of `l_area'.
		require
			valid_args: l_area /= Void and l_count > 0 and then l_area.count >= (l_count |>> 5)
		do
			values := l_area
			count := l_count
		end

feature -- Access

	item, infix "@" (i: INTEGER): BOOLEAN is
			-- `i'-th bit
		require
			index_large_enough: i >= 1
			index_small_enough: i <= count
		do
			Result := (values.item (i |>> 5)).bit_test (i & 31)
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is other similar to `Current'?
		local
			i, n, tmp: INTEGER
		do
			n := count |>> 5
			Result := count = other.count
			from
				
			until
				i = n or not Result
			loop
				Result := (values @ i) = (other.values @ i)
				i := i + 1
			end
			if Result then
				i := count & 31
				if i = 0 then
					i := 32
				end
				i := (31 |<< i).bit_not
				tmp := other.values @ n
				tmp := tmp & i
				Result := tmp = ((values @ i) & i)
			end
		end

feature -- Measurement

	count: INTEGER
			-- Size of the current bit object

feature -- Element change

	put (value: BOOLEAN; i: INTEGER) is
			-- Set the `i'-th bit to 1 if `value' is True, 0 if False
		require
			index_large_enough: i >= 1
			index_small_enough: i <= count
		local
			index: INTEGER
		do
			index := i |>> 5
			if value then
				values.put ((values.item (i)) | (1 |<< (i & 31)), index)
			else
				values.put ((values.item (i)) & ((1 |<< (i & 31)).bit_not ), index)
			end
		ensure
			value_inserted: item (i) = value
		end

feature -- Basic operations

	infix "^" (s: INTEGER): like Current is
			-- Result of shifting bit sequence by `s' positions
			-- (Positive `s' shifts right, negative `s' shifts left;
			-- bits falling off the sequence's bounds are lost.)
		local
			tmp_values: like values
			int_shift: INTEGER
			f_shift: INTEGER
			n, i, tmp, left: INTEGER
		do
			n := count |>> 5
			left := 31 - (count & 31)
			tmp_values := (create {ARRAY [INTEGER]}.make (0, n)).area
			if s > 0 then
					--| Make sure there are 0's in the undefined bits at the end.
				tmp := count & 31
				if tmp = 0 then
					tmp := 32
				end
				values.put ((values @ n) & (31 |<< tmp).bit_not, n)
				
				f_shift := s & 31
				int_shift := s |<< 5
				if f_shift = 0 then
						--| Slight optimization: we move integers instead of bits.
					from
						i := int_shift
					until
						i > n
					loop
						tmp_values.put (values @ i, i - int_shift)
						i := i + 1
					end
					from
						i := n - int_shift
					until
						i > n
					loop
						tmp_values.put (0, i)
						i := i + 1
					end
				else
						--| We have to move bits.
					tmp := (values @ int_shift) |>> f_shift
					tmp := tmp | ((values @ (int_shift + 1)) |<< (32 - f_shift))
					tmp_values.put (tmp, 0)
					from
						i := int_shift + 1
					until
						i = n
					loop
						tmp := (values @ i) |>> f_shift
						tmp := tmp | ((values @ (i + 1)) |<< (32 - f_shift))
						tmp_values.put (tmp, i - int_shift)
						i := i + 1
					end
					tmp := (values @ i) |>> f_shift
					tmp_values.put (tmp, n - int_shift)
					from
						i := n - int_shift + 1
					until
						i > n
					loop
						tmp_values.put (0, i)
						i := i + 1
					end
				end
			elseif s < 0 then
				f_shift := (-s) & 31
				int_shift := (-s) |<< 5
				if f_shift = 0 then
						--| Slight optimization: we move integers instead of bits.
					from
					until
						i = int_shift
					loop
						tmp_values.put (0, i)
						i := i + 1
					end
					from
					until
						i > n
					loop
						tmp_values.put (values @ (i - int_shift), i)
						i := i + 1
					end
				else
						--| We have to move bits.
					from
					until
						i = int_shift
					loop
						tmp_values.put (0, i)
						i := i + 1
					end
					tmp := (values @ 0) |<< f_shift
					tmp_values.put (tmp, int_shift)
					from
						i := int_shift + 1
					until
						i > n
					loop
						tmp := (values @ (i - int_shift)) |<< f_shift
						tmp := tmp | ((values @ (i - int_shift - 1)) |>> (32 - f_shift))
						tmp_values.put (tmp, i)
						i := i + 1
					end
				end
			end
			create Result.make_initialized (tmp_values, count)
		end

	infix "#" (s: INTEGER): like Current is
			-- Result of rotating bit sequence by `s' positions
			-- (Positive `s' rotates right, negative `s' rotates left.)
		local
			tmp_values: like values
			int_shift: INTEGER
			f_shift: INTEGER
			n, i, tmp, xb: INTEGER
		do
			n := count |>> 5
			tmp_values := (create {ARRAY [INTEGER]}.make (0, n)).area
			if s > 0 then
				f_shift := s & 31
				int_shift := s |<< 5
				from
					i := int_shift
				until
					i = n - 1
				loop
					tmp := (values @ i) |>> f_shift
					tmp := tmp | ((values @ (i + 1)) |<< (32 - f_shift))
					tmp_values.put (tmp, i - int_shift)
					i := i + 1
				end
				xb := count & 31
				if xb = 0 then
					xb := 32
				end
					--| Make sure there are 0's in the undefined bits at the end.
				values.put ((values @ n) & (31 |<< xb).bit_not, n)

				if xb < f_shift then
						--| i = n - 1.
					tmp := (values @ i) |>> f_shift
					tmp := tmp | ((values @ (i + 1)) |<< (32 - f_shift))
					f_shift := f_shift - xb
					tmp := tmp | ((values @ 0) |<< (32 - f_shift))
					tmp_values.put (tmp, i - int_shift)
				else
					tmp := (values @ i) |>> f_shift
					tmp := tmp | ((values @ (i + 1)) |<< (32 - f_shift))
					tmp_values.put (tmp, i - int_shift)
					i := i + 1
						--| i = n.
					tmp := (values @ i) |>> f_shift
					f_shift := f_shift + 32 - xb
					tmp := tmp | ((values @ 0) |<< (32 - f_shift))
					tmp_values.put (tmp, 0)
				end
					
				from
					i := 0
				until
					i = int_shift
				loop
					tmp := (values @ i) |>> f_shift
					tmp := tmp | ((values @ (i + 1)) |<< (32 - f_shift))
					tmp_values.put (tmp, n - int_shift + i)
					i := i + 1
				end
				create Result.make_initialized (tmp_values, count)
			else
				Result := Current # (count - s)
			end
		end

	infix "and" (other: BIT_REF): BIT_REF is
			-- Bit-by-bit boolean conjunction with `other'
		require
			other_exists: other /= Void
			conformance: other.count <= count
		local
			i, n, m, c, oc: INTEGER
			tmp_values: SPECIAL [INTEGER]
		do
			c := count |>> 5
			oc := other.count |>> 5
				--| n is the max, m is the min.
			if c > oc then
				n := c
				m := oc
			else
				n := oc
				m := c
			end
			tmp_values := (create {ARRAY [INTEGER]}.make (0, n)).area
			from
				
			until
				i > m 
			loop
				tmp_values.put ((values @ i) & (other.values @ i), i)
				i := i + 1
			end
			create Result.make_initialized (tmp_values, n)
		end

	infix "implies" (other: BIT_REF): BIT_REF is
			-- Bit-by-bit boolean implication of `other'
		require
			other_exists: other /= Void
			conformance: other.count <= count
		local
			i, n, m, c, oc: INTEGER
			tmp_values: SPECIAL [INTEGER]
		do
			c := count |>> 5
			oc := other.count |>> 5
				--| n is the max, m is the min.
			if c > oc then
				n := c
				m := oc
				tmp_values := clone (values)
			else
				n := oc
				m := c
				tmp_values := (create {ARRAY [INTEGER]}.make (0, n)).area
			end
			from
				
			until
				i > m 
			loop
				tmp_values.put ((values @ i).bit_not | (other.values @ i), i)
				i := i + 1
			end
			from
				
			until
				i > n
			loop
				tmp_values.put ((tmp_values @ i).bit_not, i)
				i := i + 1
			end
			create Result.make_initialized (tmp_values, n)
		end

	infix "or", infix "|" (other: BIT_REF): BIT_REF is
			-- Bit-by-bit boolean disjunction with `other'
		require
			other_exists: other /= Void
			conformance: other.count <= count
		local
			i, n, m, c, oc: INTEGER
			tmp_values: SPECIAL [INTEGER]
		do
			c := count |>> 5
			oc := other.count |>> 5
				--| n is the max, m is the min.
			if c > oc then
				n := c
				m := oc
				tmp_values := clone (values)
			else
				n := oc
				m := c
				tmp_values := clone (other.values)
			end
			from
				
			until
				i > m 
			loop
				tmp_values.put ((values @ i) | (other.values @ i), i)
				i := i + 1
			end
			create Result.make_initialized (tmp_values, n)
		end

	infix "xor" (other: BIT_REF): BIT_REF is
			-- Bit-by-bit exclusive or with `other'
		require
			other_exists: other /= Void
			conformance: other.count <= count
		local
			i, n, m, c, oc: INTEGER
			tmp_values: SPECIAL [INTEGER]
		do
			c := count |>> 5
			oc := other.count |>> 5
				--| n is the max, m is the min.
			if c > oc then
				n := c
				m := oc
				tmp_values := clone (values)
			else
				n := oc
				m := c
				tmp_values := clone (other.values)
			end
			from
				
			until
				i > m 
			loop
				tmp_values.put ((values @ i).bit_xor (other.values @ i), i)
				i := i + 1
			end
			create Result.make_initialized (tmp_values, n)
		end

	prefix "not": like Current is
			-- Bit-by-bit negation
		local
			i, n: INTEGER
			tmp_values: SPECIAL [INTEGER]
		do
			n := count |>> 5
			tmp_values := (create {ARRAY [INTEGER]}.make (0, n)).area
			from
				
			until
				i > n 
			loop
				tmp_values.put ((values @ i).bit_not, i)
				i := i + 1
			end
			create Result.make_initialized (tmp_values, n)
		end

feature -- Output

	out: STRING is
			-- Tagged printable representation.
		local
			i, n, ci, j: INTEGER
		do
			n := count |>> 5
			create Result.make (count)
			from
				
			until
				i = n
			loop
				from
					ci := values @ i
					j := 1
				until
					j > 32
				loop
					if (ci & 1) = 0 then
						Result.append_character ('0')
					else
						Result.append_character ('1')
					end
					ci := ci |>> 1
					j := j + 1
				end
			end
			from
				ci := values @ i
				j := 1
			until
				j > count & 31
			loop
				if (ci & 1) = 0 then
					Result.append_character ('0')
				else
					Result.append_character ('1')
				end
				ci := ci |>> 1
				j := j + 1
			end
		end

feature {BIT_REF} -- Implementation

	values: SPECIAL [INTEGER]
			-- Array where integers store `Current' in a compact way.

invariant
	valid_count: count > 0
	
indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class BIT_REF


