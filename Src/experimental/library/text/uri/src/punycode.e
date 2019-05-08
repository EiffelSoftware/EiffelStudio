note
	description: "[
			Punycode: A Bootstring encoding of Unicode
       		for Internationalized Domain Names in Applications (IDNA)
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=RFC3492 Punycode: A Bootstring encoding of Unicode for Internationalized Domain Names in Applications (IDNA)", "protocol=URI", "src=https://tools.ietf.org/html/rfc3492"

class
	PUNYCODE

feature -- Access

	decoded_string (s: READABLE_STRING_GENERAL): STRING_32
			-- String decoded from punycode `s`.
		local
			n: NATURAL_32
		do
			create Result.make (s.count)
			n := punycode_decode (s, Result)
		ensure
			instance_free: class
		end

	encoded_string (s: READABLE_STRING_GENERAL): STRING_8
			-- Encoded string `s` using punycode encoding.
		local
			n: NATURAL_32
		do
			create Result.make (s.count)
			n := punycode_encode (s, Result)
		ensure
			instance_free: class
		end

feature {NONE} -- Constants

	base: NATURAL_32 = 36
	tmin: NATURAL_32 = 1
	tmax: NATURAL_32 = 26
	skew: NATURAL_32 = 38
	damp: NATURAL_32 = 700
	initial_n: NATURAL_32 = 128 -- 0x80
	initial_bias: NATURAL_32 = 72
	delimiter: CHARACTER = '-'

feature {NONE} -- Implementation

	adapt_bias (delta: NATURAL_32; n_points: NATURAL_32; is_first: BOOLEAN): NATURAL_32
			-- Bias adaptation function.
		local
  			k: NATURAL_32
  			d: REAL_64
  		do
  			d := delta
  			if is_first then
  				d := d / damp
  			else
  				d := d / 2
  			end
			d := d + d / n_points
			d := d.truncated_to_integer_64

			-- while delta > 455: delta /= 35
			from
				k := 0
			until
				d <= 455 -- 455 = ((base - tmin) * tmax) / 2
			loop
				d := d / 35 -- 35 = base - tmin
				d := d.truncated_to_integer_64
				k := k + base
			end

			Result := k + (((base - tmin + 1) * d) / (d + skew)).truncated_to_integer_64.to_natural_32
		ensure
			instance_free: class
		end

	encoded_digit (c: NATURAL_32): CHARACTER_8
			-- Encoded character from code `c`.
		require
			c >= 0 and c <= base - tmin
		local
			n: NATURAL_32
		do
			if c > 25 then
			    n := c + 22 -- /* '0'..'9' */
			else
				n := c + ('a').natural_32_code -- /* 'a'..'z' */
			end
			Result := n.to_character_8
		ensure
			instance_free: class
		end

	encode_var_int (bias: NATURAL_32; delta: NATURAL_32; dst: STRING): NATURAL_32
			-- Encode as a generalized variable-length integer. Returns number of bytes written.
		local
  			i, k, q, t: NATURAL_32
  			done: BOOLEAN
  		do
			from
				q := delta
				k := base
				i := 0
			until
				done
			loop
				if k <= bias then
					t := tmin
				elseif k >= bias + tmax then
					t := tmax
				else
					t := k - bias
				end
				if q < t then
					done := True
				else
					dst.append_character (encoded_digit (t + (q - t) \\ (base - t)))
					i := i + 1

					q := ((q - t ) / (base - t)).truncated_to_integer_64.to_natural_32
					k := k + base
				end

			end
			dst.append_character (encoded_digit (q))
			i := i + 1
			Result := i
		ensure
			instance_free: class
		end

	punycode_encode (src: READABLE_STRING_GENERAL; dst: STRING_8): NATURAL_32
			-- Encode `src` into `dst` using PUNYCODE encoding, and return the number of written ASCII characters.
		local
			srclen: NATURAL_32
			b,h: NATURAL_32
			delta, bias: NATURAL_32
			m,n: NATURAL_32
			si, di: NATURAL_32
			c: NATURAL_32
			err: BOOLEAN
		do
			srclen := src.count.to_natural_32
			from
				si := 0
				di := 0
			until
				si + 1 > srclen
			loop
				c := src.code (si.to_integer_32 + 1)
				if c < 128 then
					dst.append_code (c)
					di := di + 1
				end
				si := si + 1
			end

			h := di
			b := h

				--  Write out delimiter if any basic code points were processed.
			if di > 0 then
				dst.append_character (delimiter)
				di := di + 1
			end


			from
				n := initial_n
				bias := initial_bias
				delta := 0
			until
				h + 1 > srclen or err
			loop
					-- Find next smallest non-basic code point.
					--   m = the minimum {non-basic} code point >= n in the input
				from
					m := size_max
					si := 0
				until
					si + 1 > srclen
				loop
					c := src.code (si.to_integer_32 + 1)
					if c >= n and c < m then
						m := c
					end
					si := si + 1
				end
			    if (m - n) > ((size_max - delta) / (h + 1)) then
     					-- OVERFLOW
     				check overflow: False end
     				err := True
     			else
	     			delta := delta + (m - n) * (h + 1)
	     			n := m
	     			from
	     				si := 0
	     			until
	     				si + 1 > srclen or err
	     			loop
	     				c := src.code (si.to_integer_32 + 1)
	     				if c < n then
		     				delta := delta + 1
		     				if delta = 0 then
		     					check overflow: False end
		     					err := True
		     				end
	     				elseif c = n then
	     					di := di + encode_var_int (bias, delta, dst)
	     					bias := adapt_bias (delta, h + 1, h = b)
	     					delta := 0
	     					h := h + 1
	     				end
	     				if not err then
		     				si := si + 1
	     				end
	     			end
				end
				if not err then
					n := n + 1
					delta := delta + 1
				end
			end

			if err then
				-- Tell the caller how many bytes were written to the output buffer.
				-- see `dst.count`
			end
				-- Return how many Unicode code points were converted.
			Result := si
		ensure
			instance_free: class
		end

	decoded_digit (v: NATURAL_32): NATURAL_32
			-- Decoded character code from digit `v`.
		local
			c: CHARACTER_32
		do
			c := v.to_character_32
			if c.is_digit then
				Result := v - 22 --22 + (v - ('0').natural_32_code)
			elseif c.is_lower then
				Result := v - ('a').natural_32_code
			elseif c.is_upper then
				Result := v - ('A').natural_32_code
			else
				Result := base
			end
		ensure
			instance_free: class
		end

	punycode_decode (src: READABLE_STRING_GENERAL; dst: STRING_32): NATURAL_32
			-- Decode `src` into `dst` using PUNYCODE encoding, and return the number of written bytes.	
		local
  			b, n, t: NATURAL_32
  			i, k, w: NATURAL_32
  			idx: INTEGER
  			si, di: NATURAL_32
  			digit: NATURAL_32
  			org_i: NATURAL_32
			bias: NATURAL_32
			c: NATURAL_32
			err: BOOLEAN
			brk: BOOLEAN
			srclen: NATURAL_32
		do
			srclen := src.count.to_natural_32
				 -- Ensure that the input contains only ASCII characters.
  			from
  			until
  				si + 1 > srclen or err
  			loop
  				if src.code (si.to_integer_32 + 1) > 128 then
  					err := True
  				end
  				si := si + 1
  			end
  			if err then
  				Result := 0
  			else
					-- Reverse-search for delimiter in input.
				idx := src.last_index_of ('-', srclen.to_integer_32)
				if idx > 0 then
					b := (idx - 1).to_natural_32
				else
					b := 0
				end
				 	-- Copy basic code points to output.
				di := b
				if di > 0 then
					dst.append_string_general (src.head (di.to_integer_32)) -- di + 1 - 1
				end

				i := 0
				n := initial_n
				bias := initial_bias
				from
					if b > 0 then
						si := b + 1
					else
						si := 0
					end
				until
					si + 1 > srclen or err
				loop
					from
						org_i := i
						w := 1
						k := base
						brk := False
					until
						err or brk
					loop
						c := src.code (si.to_integer_32 + 1)
						si := si + 1
						digit := decoded_digit (c)
						if digit = size_max then
							err := True
						elseif digit > (size_max - i) / w then
								-- Overflow!
							err := True
						else
							i := i + digit * w
							if k <= bias then
								t := tmin
							elseif k >= bias + tmax then
								t := tmax
							else
								t := k - bias
							end
							if digit < t then
									-- break
								brk := True
							else
								if w > size_max / (base - t) then
										-- Overflow
										err := True
								else
									w := w * (base - t)
									k := k + base
								end
							end
						end
					end
					bias := adapt_bias (i - org_i, di + 1, org_i = 0)
					if i / (di + 1) > size_max - n then
							-- Overflow
						err := True
					else
						n := n + (i / (di + 1)).truncated_to_integer_64.to_natural_32
						i := i \\ (di + 1)
						dst.insert_character (n.to_character_32, i.to_integer_32 + 1)
						i := i + 1
					end
					di := di + 1
				end
			end
			if err then
				Result := si
			end
		ensure
			instance_free: class
		end

feature {NONE} -- Implementation

	size_max: NATURAL_32
		do
			Result := {NATURAL_32}.max_value
		ensure
			instance_free: class
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
