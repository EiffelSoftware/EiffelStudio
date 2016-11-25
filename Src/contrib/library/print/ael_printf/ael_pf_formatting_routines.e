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

class AEL_PF_FORMATTING_ROUTINES

inherit
	AEL_PF_FORMATTING_CONSTANTS
	AEL_PF_FORMAT_ERROR_SUPPORT
	AEL_PF_TYPE_ROUTINES
	AEL_PF_SCAN_ROUTINES

 --|========================================================================
feature -- Core formatter
 --|========================================================================

	pf_formatted (fmt: STRING; args: detachable ANY): STRING
			-- A string formatted according to the format 'fmt'
			-- and arguments 'args' given, in the manner of printf
			--
			-- 'args' can be:
			--   A TUPLE containing arguments
			--   A data structure conforming to FINITE (e.g. ARRAY or LIST)
			--   An individual object reference relating to a single
			--   format item
			--   Or, if no arguments are needed, simply Void
			--
			--   N.B.
			--   There is potential for confusion/ambiguity.  Per policy,
			--   when the outermost type of the arg list is an ARRAY,
			--   it is interpreted as an argument list and NOT as a
			--   single argument that happens to be an ARRAY.
			--
			-- A complete description is embedded within the help_message
			-- function elsewhere in this class.
		require
			format_string_exists: fmt /= Void
		local
			idx, fp_count: INTEGER
			fc: CELL [INTEGER]
			fp: detachable AEL_PF_FORMAT_PARAM
			tis: detachable INDEXABLE [detachable ANY,INTEGER]
			tic: detachable INDEXABLE[detachable CONTAINER[detachable ANY],INTEGER]
			ts: detachable STRING
			tok: AEL_PF_FORMAT_TOKEN
			tokens: LINKED_LIST [AEL_PF_FORMAT_TOKEN]
			arg_count: INTEGER
			arglist: detachable FINITE [detachable ANY]
			argtuple: detachable TUPLE
			arg: detachable ANY
			argarray: detachable ARRAY [detachable ANY]
		do
			create tokens.make
			if args /= Void then
				-- If args is an array, then interpret it as a list of
				-- args and not as a single arg that happens to be a list
				argarray := any_to_array (args)
				if argarray /= Void then
					arglist := argarray
					arg_count := argarray.count
				else
					arglist := any_to_finite (args)
					if arglist /= Void then
						ts := any_to_string (args)
						if ts /= Void then
							-- Strings are indexable, but we want the
							-- whole string, not each character
							arglist := << ts >>
						end
						arg_count := arglist.count
					else
						argtuple := any_to_tuple (args)
						if argtuple /= Void then
							arg_count := argtuple.count
						else
							arg_count := 1
							arglist := << args >>
						end
					end
				end
				last_printf_errors.wipe_out
				create fc.put (0)
				tokens := tokens_extracted (fmt, fc)
				fp_count := fc.item
			end -- if args /= Void
			if fp_count = 0 then
				-- No format, then args are irrelevant
				if args /= Void then
					add_arg_count_error (fmt, fmt.count, fp_count, arg_count)
				end
				Result := fmt
			else
				Result := ""
				if fp_count > 1 then
					-- Must have a container or tuple argument list
					if arglist = Void and argtuple = Void then
						add_arg_count_error (fmt, fmt.count, fp_count, arg_count)
						Result := fmt
					end
				end
			end
			--| RFO Is this too harsh?
			if fp_count > 0 and Result.is_empty then
				create Result.make (fmt.count)
				-- Walk the tokens and match up with arguments
				from
					tokens.start
					idx := 0
				until tokens.exhausted
				loop
					tok := tokens.item
					fp := tok.format
					if fp = Void then
						Result.append (tok.string_value)
					else
						if fp.has_format_error then
							-- A bad format specifier, or just text that
							-- looks like one, copy to output unchanged and
							-- assume there is not corresponding argument
							Result.append (fp.token)
						else
							--| Bump the argument index
							idx := idx + 1
							--| Check the argument index to make sure we didn't
							--| run out of arguments
							if idx > arg_count then
								-- Ran out of arguments
								add_arg_count_error (fmt, tok.position, idx, arg_count)
								Result.append (Ks_printf_missing_arg_stub)
							else
								--| Get the positional argument for the format
								arg := Void
								if 
									argtuple /= Void and then 
									attached {detachable ANY} argtuple.item (idx) as v
								then
										-- FIXME: issue with separate item (cf SCOOP concurrency).
									arg := v
								else
									-- To gain access to indexability of arglist
									tis := any_to_indexable (arglist)
									ts := any_to_string (arglist)
									tic := any_to_indexable_container (arglist)
									if tis /= Void then
										if ts /= Void then
											-- Strings are indexable, but we want the
											-- whole string, not the idxth character
											arg := ts
										else
											-- If arg is a container, then it
											-- must be interpreted as an arg
											-- list and not as a single
											-- container arg
											arg := tis.item (idx)
										end
									else -- not indexable
										Result.append (Ks_printf_missing_arg_stub)
										add_internal_error (
											fmt, tok.position,
											"Possible corrupted args list")
									end
								end
								fp.set_argument (arg)
								if arg_matches_type (arg, fp) then
									Result.append (fp.arg_out)
								else
									-- Not a match, consume the arg but
									-- show an error
									add_arg_type_error (
										fmt, tok.position,
										fp.expected_class_name,
										fp.argument_class_name)
									Result.append (Ks_printf_mismatch_type_stub)
								end
							end
						end
					end
					tokens.forth
				end
				--RFO should this be done before walking the arg list?
				if fp_count /= arg_count then
					-- Have too many args (too few already caught)
					add_arg_count_error (fmt, fmt.count, fp_count, arg_count)
				end
			end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	pf_extracted (buf, fmt: STRING): ARRAY [detachable ANY]
			-- Values extracted from 'buf', corresponding to the format
			-- specified in 'fmt'
			-- For each format specifier in 'fmt', Result will contain
			-- an object corresponding to specifier, in relative
			-- position.
			-- Tokens in 'fmt' that are not format specifiers do not
			-- appear in Result.
			--
			-- A complete description is embedded within the help_message
			-- function elsewhere in this class.
		require
			buffer_exists: buf /= Void
			valid_format_string: fmt /= Void and then not fmt.is_empty
		local
			ti, lim, idx, fp_count: INTEGER
			fc: CELL [INTEGER]
			tok: AEL_PF_FORMAT_TOKEN
			tokens: LINKED_LIST [AEL_PF_FORMAT_TOKEN]
			values: LINKED_LIST [detachable ANY]
			tval: detachable ANY
			--ok_to_advance: BOOLEAN
		do
			-- Capture tokens from 'fmt'
			create Result.make_empty
			create fc.put (0)
			tokens := tokens_extracted (fmt, fc)
			fp_count := fc.item
			if fp_count > 0 and Result.is_empty then
				create values.make
				-- Walk the tokens and match up with values from 'buf'
				lim := buf.count
				from
					tokens.start
					idx := 1
				until tokens.exhausted or idx > lim
				loop
					--ok_to_advance := True
					tok := tokens.item
					if not attached tok.format as fp then
						-- Literal, advance through it
						if substr_is_whitespace (tok.string_value, 1, -1, True) then
							-- Advance to next non-ws
							ti := index_of_next_non_whitespace (buf, idx, lim, True)
							if ti = 0 then
								idx := lim + 1
							else
								idx := ti
							end
						else
							ti := buf.substring_index (tok.string_value, idx)
							if ti = 0 then
								-- ERROR, keep looking with next token
							else
								-- advance to char after token
								idx := ti + tok.string_value.count
							end
						end
					else
						if fp.has_format_error then
							-- A bad format specifier, or just text that
							-- looks like one; advance through it
							idx := idx + tok.string_value.count - 1
						else
							--| Extract the value for the format
							-- get *, then add to Result
							create fc.put (idx)
							tval := fp.value_in (buf, idx, fc)
							values.extend (tval)
							if tval = Void or fc.item = 0 then
								-- Not a type match
								-- Could call it quits and fill Result with
								-- Voids, or can try to realign with next
								-- token
								-- Show an error in any case

								-- ERROR
							else
								idx := fc.item
							end
						end
						idx := idx + 1
					end
					tokens.forth
				end
				if not values.is_empty then
					create Result.make_filled (Void, 1, values.count)
					from
						values.start
						idx := 1
					until values.exhausted
					loop
						Result.put (values.item, idx)
						idx := idx + 1
						values.forth
					end
				end
			end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	tokens_extracted (
		fmt: STRING; fc: CELL [INTEGER]): LINKED_LIST [AEL_PF_FORMAT_TOKEN]
			-- List of tokens, including but not limited to format
			-- specifiers, extracted from 'fmt'
			-- Into 'fc', write the number of format specfiers found
		require
			valid: fmt /= Void and then not fmt.is_empty
			counter_exists: fc /= Void
		local
			pos, lim, fp_count, tok_width: INTEGER
			fp: detachable AEL_PF_FORMAT_PARAM
			c: CHARACTER
			tok: AEL_PF_FORMAT_TOKEN
		do
			create Result.make
			create tok.make (1)
			Result.extend (tok)
			lim := fmt.count
			from pos := 1
			until pos > lim
			loop
				c := fmt.item (pos)
				tok_width := 1
				if c /= '%%' then
					--| Not a format param
					--| Add char directly to Result
					tok.extend (c)
				elseif fmt.count <= pos then
					--| Not big enough to be a format param
					--| Add char directly to Result
					--| fmt.count is last fmt char, pos is current index
					--| if count = pos, then pct is last char and cannot
					--| be a format, but if count = pos + 1, it can be,
					--| but not much more
					tok.extend (c)
				else
					--| We have what we think is a format parameter
					--| Create a new format parameter
					create fp.make_from_string (fmt, pos)
					if (not tok.is_empty) or tok.is_format then
						-- In use
						create tok.make (pos)
						Result.extend (tok)
					end
					--| Reposition past the format parameter
					tok_width := fp.original_length
					if fp.is_typed then
						if not fp.has_format_error then
							fp_count := fp_count + 1
							tok.set_format (fp)
						else
							-- Need to handle an actual error,
							-- already recorded in param
						end
					else
						-- Not a format token, just a string
						tok.set_string_value (fp.token)
					end

					create tok.make (pos+tok_width)
					Result.extend (tok)
				end
				pos := pos + tok_width
			end -- end token extraction loop
			fc.put (fp_count)
		end

 --|========================================================================
feature -- Conversion functions
 --|========================================================================

	natural_out (v: NATURAL_64; nb: INTEGER): STRING
			-- Decimal string representation of given unsigned integer,
			-- with no padding, and respectful of integer size (nb)
		do
			if v = 0 then
				Result := "0"
			else
				inspect nb
				when 1 then
					Result := v.to_natural_8.out
				when 2 then
					Result := v.to_natural_16.out
				when 4 then
					Result := v.to_natural_32.out
				else
					Result := v.out
				end
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------

	integer_to_hex (v: INTEGER_64; nb: INTEGER): STRING
			-- Hexadecimal string representation of given integer,
			-- with no padding.
			--
			-- Hex format uses 1 position (digit) for each nibble (4 bits)
			-- The idea is to capture the least significant nibble from
			-- the original value, convert that into a hex character,
			-- then shift the original value by	4 bits, repeating the
			-- process until all bits are exhausted
			-- From a print standpoint, it's exhausted when the value
			-- remaining is zero, regardless of the number of bits in a
			-- theoretical integer.
		do
			Result := natural_to_hex (v.to_natural_64, nb)
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------

	natural_to_hex (v: NATURAL_64; nb: INTEGER): STRING
			-- Hexadecimal string representation of given unsigned integer,
			-- with no padding.
			--
			-- Hex format uses 1 position (digit) for each nibble (4 bits)
			-- The idea is to capture the least significant nibble from
			-- the original value, convert that into a hex character,
			-- then shift the original value by	4 bits, repeating the
			-- process until all bits are exhausted
			-- From a print standpoint, it's exhausted when the value
			-- remaining is zero, regardless of the number of bits in a
			-- theoretical integer.
		local
			tmps: STRING
			tv, tm: NATURAL_64
		do
			if v = 0 then
				Result := "0"
			else
				tv := v
				--| Build the result string backwards, then flip it
				create tmps.make (8)
				from
				until tv = 0
				loop
					tm := tv \\ 16
					tmps.extend (Printf_hex_digits.item (tm.as_integer_32 + 1))
					tv := tv // 16
				end
				Result := tmps.mirrored
				Result.keep_tail (nb*2)
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------

	integer_to_octal (v: INTEGER_64; nb: INTEGER): STRING
			-- Octal string representation of given integer,
			-- with no padding
			--
			-- Octal format uses 1 position (digit) for each 3 bits
			-- The idea is to capture the least significant 3 bits from
			-- the original value, convert that into an octal character,
			-- then shift the original value by	3 bits, repeating the
			-- process until all bits are exhausted
			-- From a print standpoint, it's exhausted when the value
			-- remaining is zero, regardless of the number of bits in a
			-- theoretical integer
		local
			tmps: STRING
			tv, tm: NATURAL_64
		do
			if v = 0 then
				Result := "0"
			else
				inspect nb
				when 1 then
					Result := natural_8_to_octal (v.to_natural_8)
				when 2 then
					Result := natural_16_to_octal (v.to_natural_16)
				when 4 then
					Result := natural_32_to_octal (v.to_natural_32)
				else
					tv := v.to_natural_64
					--| Build the result string backwards, then flip it
					create tmps.make (10)
					from
					until tv = 0
					loop
						tm := tv \\ 8
						tmps.extend (Printf_octal_digits.item (tm.as_integer_32 + 1))
						tv := tv // 8
					end
					Result := tmps.mirrored
				end
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------

	natural_8_to_octal (v: NATURAL_8): STRING
			-- Octal string representation of given integer,
			-- with no padding
			--
			-- Octal format uses 1 position (digit) for each 3 bits
			-- The idea is to capture the least significant 3 bits from
			-- the original value, convert that into an octal character,
			-- then shift the original value by	3 bits, repeating the
			-- process until all bits are exhausted
			-- From a print standpoint, it's exhausted when the value
			-- remaining is zero, regardless of the number of bits in a
			-- theoretical integer
		local
			tmps: STRING
			tv, tm: NATURAL_8
		do
			if v = 0 then
				Result := "0"
			else
				tv := v
				--| Build the result string backwards, then flip it
				create tmps.make (10)
				from
				until tv = 0
				loop
					tm := tv \\ 8
					tmps.extend (Printf_octal_digits.item (tm.as_integer_32 + 1))
					tv := tv // 8
				end
				Result := tmps.mirrored
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------

	natural_16_to_octal (v: NATURAL_16): STRING
			-- Octal string representation of given integer,
			-- with no padding
			--
			-- Octal format uses 1 position (digit) for each 3 bits
			-- The idea is to capture the least significant 3 bits from
			-- the original value, convert that into an octal character,
			-- then shift the original value by	3 bits, repeating the
			-- process until all bits are exhausted
			-- From a print standpoint, it's exhausted when the value
			-- remaining is zero, regardless of the number of bits in a
			-- theoretical integer
		local
			tmps: STRING
			tv, tm: NATURAL_16
		do
			if v = 0 then
				Result := "0"
			else
				tv := v
				--| Build the result string backwards, then flip it
				create tmps.make (10)
				from
				until tv = 0
				loop
					tm := tv \\ 8
					tmps.extend (Printf_octal_digits.item (tm.as_integer_32 + 1))
					tv := tv // 8
				end
				Result := tmps.mirrored
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------

	natural_32_to_octal (v: NATURAL_32): STRING
			-- Octal string representation of given integer,
			-- with no padding
			--
			-- Octal format uses 1 position (digit) for each 3 bits
			-- The idea is to capture the least significant 3 bits from
			-- the original value, convert that into an octal character,
			-- then shift the original value by	3 bits, repeating the
			-- process until all bits are exhausted
			-- From a print standpoint, it's exhausted when the value
			-- remaining is zero, regardless of the number of bits in a
			-- theoretical integer
		local
			tmps: STRING
			tv, tm: NATURAL_32
		do
			if v = 0 then
				Result := "0"
			else
				tv := v
				--| Build the result string backwards, then flip it
				create tmps.make (10)
				from
				until tv = 0
				loop
					tm := tv \\ 8
					tmps.extend (Printf_octal_digits.item (tm.as_integer_32 + 1))
					tv := tv // 8
				end
				Result := tmps.mirrored
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------

	integer_to_binary (v: INTEGER_64): STRING
			-- Binary string representation of the given integer
			-- Integer argument can be of any size
			-- Representation presents smallest possible complete
			-- set of bit values (e.g. a value that fits into an
			-- INTEGER_16, but not into an INTEGER_8 shows as 16 bits)
		local
			i, first_bit: INTEGER
		do
			first_bit := 63
			if v < 0 then
				-- Negative value
				if v >= {INTEGER_8}.min_value then
					first_bit := 7
				elseif v >= {INTEGER_16}.min_value then
					first_bit := 15
				elseif v >= {INTEGER_32}.min_value then
					first_bit := 31
				end
			else
				if v <= {NATURAL_8}.max_value then
					first_bit := 7
				elseif v <= {NATURAL_16}.max_value then
					first_bit := 15
				elseif v <= {NATURAL_32}.max_value then
					first_bit := 31
				end
			end
			create Result.make (first_bit)
			from i := first_bit
			until i < 0
			loop
				if v.bit_test (i) then
					Result.extend ('1')
				else
					Result.extend ('0')
				end
				i := i - 1
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------

	double_parts_out (wp, fp: STRING; fpw: INTEGER): STRING
			-- Combined formatted whole and fractional parts
			-- with fract part padded or truncated to fractional
			-- field width
			-- No whole part padding
		local
			fps, rp: STRING
			v1, v2, v3: INTEGER
		do
			rp := ""
			if fp.count > fpw then
				-- Truncate, with rounding (TODO)
				-- RFO TODO rounding last digit on truncate
				v1 := fp.item (fpw).out.to_integer
				v2 := fp.item (fpw + 1).out.to_integer
				if fp.count > (fpw + 1) then
					v3 := fp.item (fpw + 2).out.to_integer
				end
				fps := fp.substring (1, fpw - 1)
				if v2 > 5 or ((v2 = 5) and ((v1 \\ 2 /= 0) or (v3 > 0))) then
					-- Round up
					v1 := v1 + 1
				end
				fps.append_integer (v1)
			elseif fp.count < fpw then
				-- Right pad with padding character
				create rp.make_filled ('0', fpw - fp.count)
				create fps.make (fp.count + rp.count)
				fps.append (fp)
			else
				fps := fp
			end
			Result := wp + decimal_separator.out + fps + rp
		end

	--|--------------------------------------------------------------

	double_parts (v: DOUBLE): LIST [STRING]
			-- DOUBLE value decomposed into whole and fractional parts
			-- as strings
		local
			ts: STRING
			pc: like decimal_separator
		do
			if v < v.zero then
				ts := (-v).out
			else
				ts := v.out
			end
			if is_exponential_notation (ts) then
				ts := scientific_to_decimal (ts)
				pc := decimal_separator
			else
				pc := '.'
			end

			-- At this point (so to speak), we have a string
			-- representation of the double value, according to the
			-- internal formatting mechanism.
			-- The next step is to apply the desired formatting to the
			-- value, but rather than work from the double value itself,
			-- we work with the already normalized string

			Result := ts.split (pc)
			if Result.count = 1 then
				-- Double had no fractional part
				Result.extend ("0")
			end
		ensure
			exists: Result /= Void
			valid: Result.count = 2 and then
				Result.first /= Void and Result.last /= Void
		end

	is_exponential_notation (v: STRING): BOOLEAN
			-- Is the given string in exponential/scientific notation?
			-- Example:  "1.234c012"
		require
			exists: v /= Void
		do
			if not v.is_empty then
				Result := v.item (1).is_digit and
					(v.occurrences ('.') = 1) and
					(v.as_lower.occurrences ('e') = 1)
			end
		end

	scientific_to_decimal (v: STRING): STRING
			-- Convert the given string, in scientific (exponential)
			-- notation to simple decimal notation
			-- Example:  1.00006e03 --> 1000.06
			-- Example:  1.00006e-03 --> 0.00100006
			-- Example:  123.00456e012 --> 123004560.0
			-- Example:  1.2e-15 --> 0.0000000000000012
		require
			exists: v /= Void and then not v.is_empty
			is_scientific: is_exponential_notation (v)
		local
			is_neg_exp: BOOLEAN
			vs, wps, fps: STRING
			dp, ei, exp: INTEGER
		do
			create Result.make (0)
			vs := v.as_lower
			ei := vs.index_of ('e', 1)
			exp := vs.substring (ei + 1, vs.count).to_integer
			-- 'vs' is now the value (non-exponent) field
			vs := vs.substring (1, ei - 1)

			if exp < 0 then
				is_neg_exp := True
				exp := -exp
			end

			dp := vs.index_of ('.', 1)
			if dp > 0 then
				fps := vs.substring (dp + 1, vs.count)
				wps := vs.substring (1, dp - 1)
			else
				fps := "0"
				wps := vs
			end

			create Result.make (exp+wps.count+fps.count+2)
			if is_neg_exp then
				-- Value part must be shifted right (zero left padded)
				-- to align decimal point properly
				-- Depending on size of wps relative to exp, wps might
				-- straddle the decimal point (i.e. is the negative
				-- exponent 'negative enough' to capture all digits?)
				if exp >= wps.count then
					-- Shift all digits to right of dp
					Result.extend ('0')
					Result.extend (decimal_separator)
					Result.append (create {STRING}.make_filled ('0',exp-1))
					Result.append (wps)
				else
					-- exp < wps.count; Split wps across dp
					Result.append (wps.substring (1, (wps.count - exp)))
					Result.extend (decimal_separator)
					Result.append (wps.substring ((wps.count - exp) + 1, wps.count))
				end
				Result.append (fps)
			else
				-- Value part must be shifted left (zero right padded)
				-- to align decimal point properly
				-- If exp is positive, then wps will always appear
				-- in result unchanged
				Result.append (wps)
				-- Depending on size of fps relative to exp, fps might
				-- straddle the decimal point
				if exp >= fps.count then
					Result.append (fps)
					Result.append (create {STRING}.make_filled ('0',exp-fps.count))
					Result.extend (decimal_separator)
					Result.extend ('0')
				else
					-- exp < fps.count; Split fps across dp
					Result.append (fps.substring (1, (fps.count - exp) - 2))
					Result.extend (decimal_separator)
					Result.append (fps.substring ((fps.count - exp) - 1, fps.count))
				end
			end
		ensure
			exists: Result /= Void
		end

end -- class AEL_PF_FORMATTING_ROUTINES

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
--| 010 23-Feb-2013
--|     Added support for percent, agent and list+agent formats.
--|     Agent format support required addition of the agent flag, '~'
--|     in place of the decoration flag ('#') (i.e. a single format
--|     token can have either a decoration flag or an agent flag but
--|     not both).  Alignment flags are unaffected.
--|     Tweaked arg parsing to interpret any single list arg as an arg
--|     list.  The alternative (the previous interpretation) would be
--|     to allow single-arg containers but fail to recognize
--|     containers for list format when they are alone in a an actual
--|     arg list like an array.
--| 009 18-May-2011
--|     Replaced integer_to_hex function with natural_to_hex.
--| 008 03-Apr-2011
--|     Updated integer_to_binary to use NATURALs instead of INTEGERs
--|     to avoid premature size promotion.
--| 007 06-Oct-2009
--|     Fixed issue with floats rendered without fractional parts
--| 006 17-Aug-2009
--|     Fixed problem with incorrect rendering of floats less than 1
--|     Improved rounding behavior to use round-half-to-even method
--| 005 28-Jul-2009
--|     Compiled and tested using Eiffel 6.2 and 6.4
--|----------------------------------------------------------------------
--| How-to
--|
--| This class is used by AEL_PRINTF and need not be addressed directly
--|----------------------------------------------------------------------
