--|----------------------------------------------------------------------
--| Copyright (c) 1995-2011, All rights reserved by
--| Amalasoft Corporation
--| 273 Harwood Avenue
--| Littleton, MA 01460 USA
--|
--| See additional information at bottom of file
--|----------------------------------------------------------------------
--| Description
--|
--| Core formatting routines of the ael_printf cluster
--|----------------------------------------------------------------------

class AEL_PF_SCAN_ROUTINES

inherit
	AEL_PF_FORMATTING_CONSTANTS

--|========================================================================
feature {AEL_PF_FORMAT_PARAM, AEL_PRINTF} -- Scanning support
--|========================================================================

	string_at (
		str: STRING; spos: INTEGER; ec: CELL [INTEGER]; fw: INTEGER
				  ): detachable STRING
			-- String extracted from 'str' at position 'spos'
			-- Convey the end position in 'ec'
			--
			-- If field with is 0 (ie no width specified), then Result 
			-- is remainder of 'str' from 'spos' to 'str.count'
			--
			-- ALL characters except whitespace conform to the string
			-- ('%s') format.

			-- The field width 'fw' controls the _maximum_ number of
			-- characters to be read for the current field.
			-- No more than 'fw' characters are converted, but fewer
			-- than 'fw' characters may be read if a whitespace character
			-- or non-conforming character occurs before 'fw' is reached.
			-- If 'fw' is 0 (no field width specified), then scan can 
			-- continue until 'str' is exhausted.  
			-- ALL characters conform to the '%s' (string) and '%c'
			-- (character) formats.
		require
			string_exists: str /= Void
			valid_startpos: spos > 0 and spos <= str.count
			counter_exists: ec /= Void
		local
			sp, ep: INTEGER
		do
			ec.put (0)
			sp := index_of_next_non_whitespace (str, spos, 0, True)
			if sp = 0 then
				-- Nothing but whitespace from here to end; no value
			else
				ep := index_of_next_whitespace (str, sp, fw, True)
				if ep = 0 then
					-- No more whitespace, and reached end of 'str'
					if fw /= 0 then
						ep := sp + fw - 1
						Result := str.substring (sp, ep)
						ec.put (sp + str.count - 1)
					else
						Result := str.substring (sp, str.count)
						ec.put (sp + str.count - 1)
					end
				else
					Result := str.substring (sp, ep - 1)
					ec.put (ep - 1)
				end
			end
		end

	--|--------------------------------------------------------------

	character_at (
		str: STRING; spos: INTEGER; ec: CELL [INTEGER]; fw: INTEGER
				  ): CHARACTER
			-- Character extracted from 'str' at position 'spos'
			-- Convey the end position in 'ec'
		require
			string_exists: str /= Void
			valid_startpos: spos > 0 and spos <= str.count
			counter_exists: ec /= Void
		local
			sp, ep: INTEGER
		do
			Result := '%U'
			ec.put (0)
			sp := index_of_next_non_whitespace (str, spos, 0, True)
			if sp = 0 then
				-- Nothing but whitespace from here to end; no value
			else
				ep := index_of_next_whitespace (str, sp, fw, True)
				if ep = 0 then
					-- No more whitespace, and reached end of 'str'
					Result := str.item (sp)
					ec.put (sp)
				end
			end
		end

	--|--------------------------------------------------------------

	decimal_at (
		str: STRING; spos: INTEGER; ec: CELL [INTEGER];
		fw: INTEGER;
		df: BOOLEAN;
		tss: STRING
				  ): INTEGER_64
			-- Decimal integer extracted from 'str' at position 'spos'
			-- If string at position is not a decimal integer, then 0
			-- Convey the end position (last decimal digit) in 'ec'
		require
			string_exists: str /= Void
			valid_startpos: spos > 0 and spos <= str.count
			counter_exists: ec /= Void
			tsep_exists: tss /= Void
		local
			i, sp, ep: INTEGER
			ti: INTEGER_64
			is_int, is_neg: BOOLEAN
			pc, c, tsep: CHARACTER
		do
			ec.put (0)

			sp := index_of_next_non_whitespace (str, spos, 0, True)
			if sp = 0 then
				-- Nothing but whitespace from here to end; no value
			else
				ep := index_of_next_whitespace (str, sp, fw, True)
				if ep = 0 then
					-- No more whitespace, and reached end of 'str' before 
					-- exhausting field width (if defined)
					if fw = 0 then
						ep := str.count
					else
						ep := str.count.min (sp + fw - 1)
					end
				end
				-- Must start with a decimal digit or sign
				if str.item (sp) = '-' then
					is_neg := True
					sp := sp + 1
				elseif str.item (sp) = '+' then
					sp := sp + 1
				end
				if not str.item (sp).is_digit then
					-- Not an integer
					-- Consume nothing, return 0
				else
					is_int := True
					-- Check for thousands separator
					if not tss.is_empty then
						tsep := tss.item (1)
					end
					ec.put (sp)
					from
						i := sp
						ec.put (i)
					until not is_int or i > ep
					loop
						c := str.item (i)
						if not c.is_digit and c /= tsep then
							is_int := False
						else
							if c = tsep then
								-- Skip unless follows last digit
							else
								ti := dchar_to_int (c).to_integer_64
								if Result = K_i64_ntl_max and ti /= 0 or
									Result > K_i64_ntl_max
								 then
									 -- Overflow, do not add value
								else
									Result := (Result * 10) + ti
								end
							end
							ec.put (i)
							i := i + 1
						end
						if is_int then
							pc := c
						end
					end
					if not tss.is_empty and then pc = tsep and ec.item /= 0 then
						ec.put (ec.item - 1)
					end
				end
			end
			if Result /= 0 and is_neg then
				Result := 0 - Result
			end
		end

	--|--------------------------------------------------------------

	natural_at (
		str: STRING; spos: INTEGER; ec: CELL [INTEGER];
		fw: INTEGER;
		df: BOOLEAN;
		tss: STRING
				  ): NATURAL_64
				  -- Decimal unsigned integer (natural) extracted from 'str'
				  -- at position 'spos'
				  -- If string at position is not a decimal integer, then 0
				  -- Convey the end position (last decimal digit) in 'ec'
		require
			string_exists: str /= Void
			valid_startpos: spos > 0 and spos <= str.count
			counter_exists: ec /= Void
			tsep_exists: tss /= Void
		local
			i, sp, ep: INTEGER
			ti: NATURAL_64
			is_int: BOOLEAN
			pc, c, tsep: CHARACTER
		do
			ec.put (0)

			sp := index_of_next_non_whitespace (str, spos, 0, True)
			if sp = 0 then
				-- Nothing but whitespace from here to end; no value
			else
				ep := index_of_next_whitespace (str, sp, fw, True)
				if ep = 0 then
					-- No more whitespace, and reached end of 'str' before 
					-- exhausting field width (if defined)
					if fw = 0 then
						ep := str.count
					else
						ep := str.count.min (sp + fw - 1)
					end
				end
				-- Must start with a decimal digit
				if not str.item (sp).is_digit then
					-- Not an integer
					-- Consume nothing, return 0
				else
					is_int := True
					-- Check for thousands separator
					if not tss.is_empty then
						tsep := tss.item (1)
					end
					ec.put (sp)
					from
						i := sp
						ec.put (i)
					until not is_int or i > ep
					loop
						c := str.item (i)
						if not c.is_digit and c /= tsep then
							is_int := False
						else
							if c = tsep then
								-- Skip
							else
								ti := dchar_to_int (c).to_natural_64
								if Result = K_n64_ntl_max and ti /= 0 or
									Result > K_n64_ntl_max
								 then
									 -- Overflow, do not add value
								else
									Result := (Result * 10) + ti
								end
							end
							ec.put (i)
							i := i + 1
						end
						pc := c
					end
					if pc = tsep and ec.item /= 0 then
						ec.put (ec.item - 1)
					end
				end
			end
		end

	--|--------------------------------------------------------------

	hexadecimal_at (
		str: STRING; spos: INTEGER; ec: CELL [INTEGER];
		fw: INTEGER;
		df: BOOLEAN
				  ): NATURAL_64
				  -- Hexdecimal unsigned integer (natural) extracted from 
				  -- 'str' at position 'spos'
				  -- If string at position is not a hex integer, then 0
				  -- Convey the end position (last hex digit) in 'ec'
				  --
				  -- If format includes decoration, then value (after 
				  -- blank padding if any) must begin with "0x".
				  -- If 0-padded, then decoration precedes padding.
		require
			string_exists: str /= Void
			valid_startpos: spos > 0 and spos <= str.count
			counter_exists: ec /= Void
		local
			i, sp, ep: INTEGER
			ti: NATURAL_64
			is_int: BOOLEAN
			c: CHARACTER
		do
			ec.put (0)

			sp := index_of_next_non_whitespace (str, spos, 0, True)
			if sp = 0 then
				-- Nothing but whitespace from here to end; no value
			else
				ep := index_of_next_whitespace (str, sp, fw, True)
				if ep = 0 then
					-- No more whitespace, and reached end of 'str' before 
					-- exhausting field width (if defined)
					if fw = 0 then
						ep := str.count
					else
						ep := str.count.min (sp + fw - 1)
					end
				end
				-- Must start with a hex digit or hex decoration
				if not df then
					is_int := True
				elseif ep > sp then
					if not (str[sp] = '0' and str[sp+1].as_lower = 'x') then
						is_int := True
						sp := sp + 2
					end
				end
				if not is_int or not str.item (sp).is_digit then
					-- Not a hex integer
					-- Consume nothing, return 0
				else
					is_int := True
					ec.put (sp)
					from
						i := sp
						ec.put (i)
					until not is_int or i > ep
					loop
						c := str.item (i)
						if not c.is_hexa_digit then
							is_int := False
						else
							ti := xchar_to_int (c).to_natural_64
							if Result = K_n64_ntl_max and ti /= 0 or
								Result > K_n64_ntl_max
							 then
								 -- Overflow, do not add value
							else
								Result := (Result * 16) + ti
							end
						end
						ec.put (i)
						i := i + 1
					end
				end
			end
		end

	--|--------------------------------------------------------------

	octal_at (
		str: STRING; spos: INTEGER; ec: CELL [INTEGER];
		fw: INTEGER;
		df: BOOLEAN
				  ): NATURAL_64
				  -- Octal unsigned integer (natural) extracted from 
				  -- 'str' at position 'spos'
				  -- If string at position is not an octal integer, then 0
				  -- Convey the end position (last octal digit) in 'ec'
				  --
				  -- Because octal format decoration is a leading zero,
				  -- no special fast-forwarding is needed unless the pad 
				  -- character is blank (and there is a field width)
		require
			string_exists: str /= Void
			valid_startpos: spos > 0 and spos <= str.count
			counter_exists: ec /= Void
		local
			i, sp, ep: INTEGER
			ti: NATURAL_64
			is_int: BOOLEAN
			c: CHARACTER
		do
			ec.put (0)

			sp := index_of_next_non_whitespace (str, spos, 0, True)
			if sp = 0 then
				-- Nothing but whitespace from here to end; no value
			else
				ep := index_of_next_whitespace (str, sp, fw, True)
				if ep = 0 then
					-- No more whitespace, and reached end of 'str' before 
					-- exhausting field width (if defined)
					if fw = 0 then
						ep := str.count
					else
						ep := str.count.min (sp + fw - 1)
					end
				end
				-- Must start with an octal digit
				if not is_octal_digit (str[sp]) then
					-- not an octal integer
					-- consume nothing; return 0
				else
					is_int := True
					ec.put (sp)
					from
						i := sp
						ec.put (i)
					until not is_int or i > ep
					loop
						c := str.item (i)
						if not is_octal_digit (c) then
							is_int := False
						else
							ti := ochar_to_int (c).to_natural_64
							if Result = K_n64_ntl_max and ti /= 0 or
								Result > K_n64_ntl_max
							 then
								 -- Overflow, do not add value
							else
								Result := (Result * 8) + ti
							end
						end
						ec.put (i)
						i := i + 1
					end
				end
			end
		end

	--|--------------------------------------------------------------

	double_at (
		str: STRING; spos: INTEGER; ec: CELL [INTEGER];
		fw, ffw: INTEGER;
		df: BOOLEAN
				  ): REAL_64
			-- Double precision floating point value extracted from 'str'
			-- at position 'spos'
			-- If string at position is not a double, then 0
			-- Convey the end position (last fp digit) in 'ec'
		require
			string_exists: str /= Void
			valid_startpos: spos > 0 and spos <= str.count
			counter_exists: ec /= Void
		local
			i, sp, ep: INTEGER
			ti, divisor: INTEGER_64
			is_int, is_neg: BOOLEAN
			c: CHARACTER
			tpart, whole_part: INTEGER_64
			frac_part: DOUBLE
		do
			ec.put (0)

			sp := index_of_next_non_whitespace (str, spos, 0, True)
			if sp = 0 then
				-- Nothing but whitespace from here to end; no value
			else
				ep := index_of_next_whitespace (str, sp, fw, True)
				if ep = 0 then
					-- No more whitespace, and reached end of 'str' before 
					-- exhausting field width (if defined)
					if fw = 0 then
						ep := str.count
					else
						ep := str.count.min (sp + fw - 1)
					end
				end
				-- Must start with a decimal digit or sign for whole part
				if str.item (sp) = '-' then
					is_neg := True
					sp := sp + 1
				elseif str.item (sp) = '+' then
					sp := sp + 1
				end
				if not str.item (sp).is_digit then
					-- Not an integer
					-- Consume nothing, return 0
				else
					is_int := True
					ec.put (sp)
					from
						i := sp
						ec.put (i)
					until
						i > ep or else
						(not is_int) or str.item (i) = decimal_separator
					loop
						c := str.item (i)
						if not c.is_digit then
							-- radix point was caught at top of loop,
							-- so must be whitespace or nonforming; Stop
							is_int := False
						else
							ti := dchar_to_int (c).to_integer_64
							if tpart = K_i64_ntl_max and ti /= 0 or
								tpart > K_i64_ntl_max
							 then
								 -- Overflow, do not add value
								 is_int := False
							else
								ec.put (i)
								tpart := (tpart * 10) + ti
							end
						end
						i := i + 1
					end
					if is_int then
						whole_part := tpart
						Result := whole_part.to_double
						if str[i] = decimal_separator then
							i := i + 1
							-- Capture fractional part
							from divisor := 10
							until i > ep or else not is_int
							loop
								c := str.item (i)
								if c.is_digit then
									ti := dchar_to_int (c).to_integer_64
									ec.put (i)
									frac_part := frac_part + (ti / divisor)
									divisor := divisor + 10
								else
									-- done
									is_int := False
								end
								i := i + 1
							end
						end
						Result := Result + frac_part
					end
				end
			end
			if Result /= 0 and is_neg then
				Result := 0 - Result
			end
		end

	--|--------------------------------------------------------------

	binary_at (
		str: STRING; spos: INTEGER; ec: CELL [INTEGER];
		fw: INTEGER;
		df: BOOLEAN
				  ): NATURAL_64
				  -- Binary (unsigned) integer extracted from 
				  -- 'str' at position 'spos'
				  -- If string at position is not a binary integer, then 0
				  -- Convey the end position (last binary digit) in 'ec'
		require
			string_exists: str /= Void
			valid_startpos: spos > 0 and spos <= str.count
			counter_exists: ec /= Void
		local
			i, lim, sp, ep, nbits: INTEGER
			ti: NATURAL_64
			is_int: BOOLEAN
			c: CHARACTER
		do
			ec.put (0)

			sp := index_of_next_non_whitespace (str, spos, 0, True)
			if sp = 0 then
				-- Nothing but whitespace from here to end; no value
			else
				ep := index_of_next_whitespace (str, sp, fw, True)
				if ep = 0 then
					-- No more whitespace, and reached end of 'str' before 
					-- exhausting field width (if defined)
					if fw = 0 then
						ep := str.count
					else
						ep := str.count.min (sp + fw - 1)
					end
				end
				-- Must start with '0' or '1'
				if str[sp] = '0' or str[sp] = '1' then
					is_int := True
					ep := lim
					ec.put (sp)
					from
						i := sp
						ec.put (i)
					until not is_int or i > ep
					loop
						c := str.item (i)
						if c /= '0' and c /= '1' then
							is_int := False
						elseif nbits >= 64 then
							-- Would overflow; do not add value
							is_int := False
						else
							if c = '1' then
								ti := 1
							else
								ti := 0
							end
							Result := (Result * 2) + ti
							nbits := nbits + 1
						end
						ec.put (i)
						i := i + 1
					end
				end
			end
		end

	--|--------------------------------------------------------------

	boolean_at (
		str: STRING; spos: INTEGER; ec: CELL [INTEGER];
		fw: INTEGER;
		df: BOOLEAN
				  ): BOOLEAN
				  -- Boolean value extracted from 'str' at position 'spos'
				  -- If string at position is not a boolean constant,
				  -- then False
				  -- Convey the end position in 'ec'
		require
			string_exists: str /= Void
			valid_startpos: spos > 0 and spos <= str.count
			counter_exists: ec /= Void
		local
			lim, sp: INTEGER
		do
			ec.put (0)
			lim := str.count
			sp := index_of_next_non_whitespace (str, spos, 0, True)
			if sp = 0 then
				-- Nothing but whitespace from here to end; no value
			elseif str[sp].as_lower = 't' then
				ec.put (sp)
				if (sp + 4) > lim then
					ec.put (0)
				elseif not (str[sp+1].as_lower = 'r' and
					str[sp+2].as_lower = 'u' and
					str[sp+3].as_lower = 'e')
				 then
					 ec.put (0)
				else
					ec.put (sp + 3)
					Result := True
				end
			elseif str[sp].as_lower = 'f' then
				ec.put (sp)
				if (sp + 5) > lim then
					ec.put (0)
				elseif not (str[sp+1].as_lower = 'a' and
					str[sp+2].as_lower = 'l' and
					str[sp+3].as_lower = 's' and
					str[sp+4].as_lower = 'e')
				 then
					 ec.put (0)
				else
					ec.put (sp + 3)
				end
			end
		end

	--|--------------------------------------------------------------

	list_at (
		str: STRING; spos: INTEGER; ec: CELL [INTEGER];
		fw: INTEGER;
		sep: STRING
				  ): LINKED_LIST [STRING]
				  -- 'sep'-separated list extracted from 'str' at position
				  -- 'spos'
				  -- Convey the end position in 'ec'
		require
			string_exists: str /= Void
			valid_startpos: spos > 0 and spos <= str.count
			counter_exists: ec /= Void
			valid_separator: sep /= Void and then not sep.is_empty
		local
			sp, ep, wp: INTEGER
			done: BOOLEAN
		do
			create Result.make
			ec.put (0)

			sp := index_of_next_non_whitespace (str, spos, 0, True)
			if sp = 0 then
				-- Nothing but whitespace from here to end; no value
			else
				-- 'sp' is index of non-whitespace, but is it a list item?
				-- If 'sep' itself is a whitespace, then 
				ep := index_of_next_substring (str, sep, sp, str.count)
				if ep = 0 then
					-- No separator, no list
				else
					wp := index_of_next_whitespace (str, sp, ep - sp, True)
					if wp = 0 then
						-- No ws found between start and first separator
						from
						until done
						loop
							if str[sp].is_space then
								done := True
							else
								ep := index_of_next_substring (str, sep, sp, str.count)
								wp := index_of_next_whitespace (str, sp, ep-sp, True)
								if ep = 0 then
									-- Separator not found
									done := True
									if wp /= 0 then
										Result.extend (str.substring (sp, wp - 1))
										ec.put (wp - 1)
									elseif sp <= str.count then
										Result.extend (str.substring (sp, str.count))
										ec.put (str.count)
									end
								else
									if wp /= 0 and wp < ep then
										Result.extend (str.substring (sp, wp - 1))
										ec.put (wp - 1)
									else
										Result.extend (str.substring (sp, ep - 1))
										ec.put (ep - 1)
										sp := ep + sep.count
									end
								end
							end
						end
					end
				end
			end
		end

	--|--------------------------------------------------------------

	index_of_next_non_whitespace (str: STRING; spos, mfw: INTEGER;
	                              nl_is_ws: BOOLEAN): INTEGER
			-- Index, within string 'str' of first non-whitespace character
			-- at or AFTER position 'spos' (searching forward from spos).
			-- If nl_is_ws, treat newlines as whitespace.
			-- If no whitespace is found, then Result is 0
		require
			string_exists: str /= Void
			valid_startpos: spos > 0 and spos <= str.count
		do
			Result := index_of_next_space_yn (str, spos, mfw, nl_is_ws, False)
		end

	--|--------------------------------------------------------------

	index_of_next_whitespace (str: STRING; spos, mfw: INTEGER;
	                          nl_is_ws: BOOLEAN): INTEGER
			-- Index, within string 'str' of next whitespace character
			-- at or AFTER position 'spos' (searching forward from spos).
			-- If ns_is_ws, treat newlines as whitespace.
			-- If no whitespace is found, then Result is 0
		require
			string_exists: str /= Void
			valid_start: spos > 0 and spos <= str.count
		do
			if mfw > 0 then
				Result := index_of_next_space_yn (
					str, spos, str.count.min (spos + mfw - 1), nl_is_ws, True)
			else
				Result := index_of_next_space_yn (
					str, spos, str.count, nl_is_ws, True)
			end
		end

	--|--------------------------------------------------------------

	index_of_next_space_yn (
		str: STRING; spos, epos: INTEGER; nlf, is_ws: BOOLEAN): INTEGER
			-- Index, within string 'str' of next (non)whitespace character
			-- at or AFTER position 'spos' (searching forward from spos).
			-- If nlf, treat newlines as whitespace.
			-- If no (non)whitespace is found, then Result is 0
		require
			string_exists: str /= Void
			valid_start: spos > 0 and spos <= str.count
		local
			idx: INTEGER
			c: CHARACTER
		do
			from idx := spos
			until Result > 0 or idx > epos
			loop
				c := str.item (idx)
				if is_ws and character_is_whitespace (c, nlf) then
					Result := idx
				elseif (not is_ws) and not character_is_whitespace (c, nlf) then
					Result := idx
				else
					idx := idx + 1
				end
			end
		end

	--|--------------------------------------------------------------

	index_of_next_substring (str, ss: STRING; spos, epos: INTEGER): INTEGER
			-- Index, within string 'str' of next substring 'ss'
			-- between positions 'spos' and 'epos'
		require
			string_exists: str /= Void
			valid_start: spos > 0 and spos <= str.count
			valid_end: epos >= spos and epos <= str.count
			valid_substring: ss /= Void and then not ss.is_empty
		local
			i: INTEGER
			c1: CHARACTER
		do
			c1 := ss.item (1)
			from i := spos
			until Result > 0 or i > epos
			loop
				if c1 = str.item (i) then
					if substring_matches (str, ss, i) then
						Result := i
					end
				end
				if Result = 0 then
					i := i + 1
				end
			end
		end

	--|--------------------------------------------------------------

	substring_matches (str, ss: STRING; spos: INTEGER): BOOLEAN
			-- Does string 'str' have substring 'ss' starting at 
			-- position 'spos'?
		require
			exists: str /= Void and then not str.is_empty
			valid_substring: ss /= Void and then not ss.is_empty
			valid_start: spos > 0 and spos <= str.count
		local
			i, j, len, lim: INTEGER
											 do
			len := ss.count
			lim := spos + len - 1
			if str.count >= lim then
				if str.item (spos) = ss[1] and str.item (lim) = ss[len] then
					Result := True
					from
						i := spos + 1
						j := 2
					until Result or i > lim
					loop
						if str.item (i) /=  ss.item (j) then
							Result := False
						else
							i := i + 1
						end
					end
				end
			end
		end

	--|--------------------------------------------------------------

	substr_is_whitespace (v: STRING; sp, ep: INTEGER; nf: BOOLEAN): BOOLEAN
			-- Is substring in 'v' between 'sp' and 'ep' composed
			-- of only whitespace characters?
		require
			exists: v /= Void
			valid_start: (not v.is_empty) implies sp > 0 and sp <= v.count
			valid_end: (not v.is_empty) implies
				ep = -1 or (ep >= sp and ep <= v.count)
		local
			i, lim: INTEGER
		do
			if not v.is_empty then
				if ep = -1 then
					lim := v.count
				else
					lim := ep
				end
				if v.item (sp).is_space then
					Result := True
					from i := sp + 1
					until i > lim or not Result
					loop
						Result := not character_is_whitespace (v.item (i), nf)
						i := i + 1
					end
				end
			end
		end

	character_is_whitespace (c: CHARACTER; nl_ok: BOOLEAN): BOOLEAN
		do
			inspect c
			when '%T', ' ' then
				Result := True
			when '%N', '%R' then
				Result := nl_ok
			else
			end
		end

	dchar_to_int (v: CHARACTER): INTEGER
			-- Integer value of decimal digit character 'v'
		require
			is_digit: v.is_digit
		do
			Result := v.code - K_ccode_0
		end

	xchar_to_int (v: CHARACTER): INTEGER
			-- Integer value of hexdecimal digit character 'v'
		require
			is_digit: v.is_hexa_digit
		do
			if v.is_digit then
				Result := v.code - K_ccode_0
			else
				Result := 10 + ((v.as_lower).code - K_ccode_a)
			end
		end

	ochar_to_int (v: CHARACTER): INTEGER
			-- Integer value of octal digit character 'v'
		require
			is_digit: is_octal_digit (v)
		do
			Result := v.code - K_ccode_0
		end

	is_octal_digit (v: CHARACTER): BOOLEAN
			-- Is 'v' an octal digit? (0-7)
		local
			tc: INTEGER
		do
			tc := v.code - K_ccode_0
			Result := tc >= 0 and tc <= 7
		end

	--|--------------------------------------------------------------

	K_max_scanf_strlen: INTEGER = 2048
			-- Maximum length of a scanf string parameter without an
			-- explicitly defined field width parameter

	K_ccode_0: INTEGER
			-- ASCII character code for '0'
		once
			Result := ('0').code
		end

	K_ccode_a: INTEGER
			-- ASCII character code for 'a'
		once
			Result := ('a').code
		end

	K_i64_ntl_max: INTEGER_64
			-- Max value for next most significant digit (and others to 
			-- right) of a positive 64 bit signed integer
		local
			ti: INTEGER_64
		once
			Result := ti.max_value // 10
		end

	K_i64_ntl_min: INTEGER_64
			-- Min value for next most significant digit (and others to 
			-- right) of a negative 64 bit signed integer
		local
			ti: INTEGER_64
		once
			Result := ti.min_value // 10
		end

	K_n64_ntl_max: NATURAL_64
			-- Max value for next most significant digit (and others to 
			-- right) of a 64 bit unsigned integer (aka natural)
		local
			ti: NATURAL_64
		once
			Result := ti.max_value // 10
		end

	signed_64_maxlen: INTEGER = 19
			-- Maximum string length depicting an integer 64, including 
			-- sign

	signed_d_64_maxlen: INTEGER = 25
			-- Maximum string length depicting an integer 64, including 
			-- sign and optional thousands separators

	unsigned_64_maxlen: INTEGER = 19
			-- Maximum string length depicting a natural 64

	unsigned_d_64_maxlen: INTEGER = 25
			-- Maximum string length depicting a natural 64, including 
			-- optional thousands separators

end -- class AEL_PF_SCAN_ROUTINES

--|----------------------------------------------------------------------
--| License
--|
--| This software is furnished under the Eiffel Forum License, version 2,
--| and may be used and copied only in accordance with the terms of that
--| license and with the inclusion of the above copyright notice.
--|
--| Refer to the Eiffel Forum License, version 2 text for specifics.
--|
--| The information in this software is subject to change without notice
--| and should not be construed as a commitment by Amalasoft.
--|
--| Amalasoft assumes no responsibility for the use or reliability of this
--| software.
--|
--|----------------------------------------------------------------------
--| History
--|
--| 008 04-Apr-2011
--|     Original version with content from AEL_SPRT_STRING_ROUTINES
--|     (to avoid cluster dependency; to be addressed)
--|----------------------------------------------------------------------
--| How-to
--|
--| This class is used by AEL_PRINTF and need not be addressed directly
--|----------------------------------------------------------------------
