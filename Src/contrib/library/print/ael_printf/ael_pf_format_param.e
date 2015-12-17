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
--| Format string parsing and interpretation, argument coordination 
--| and output routines a single formatting error instance
--|----------------------------------------------------------------------

class AEL_PF_FORMAT_PARAM

inherit
	AEL_PF_FORMATTING_CONSTANTS
	AEL_PF_FORMAT_ERROR_SUPPORT
	AEL_PF_TYPE_ROUTINES

create
	make_from_string

 --|========================================================================
feature {NONE} -- Creation and Initialization
 --|========================================================================

	make_from_string (v: STRING; spos: INTEGER)
			-- Initialize this object from the given arguments
		require
			exists: v /= Void
			valid_position: (spos > 0) and (spos < v.count)
			long_enough: (v.count - spos) >= 1
			is_format: v.item(spos) = '%%'
		do
			core_make
			original_string := v
			original_position := spos
			extract_token
			-- init attachments
			argument := ""
		end

	--|--------------------------------------------------------------

	core_make
		do
			create token.make (4)
		end

 --|========================================================================
feature {NONE} -- Parsing and initialization
 --|========================================================================

	extract_token
			-- Extract the actual format parameter from the 
			-- original format string,
			-- beginning at the given position
		local
			i, lim: INTEGER
			iref: INTEGER_REF
			ts: like original_string
		do
			ts := original_string
			lim := ts.count

			i := original_position
			--| The character at spos is, per contract,
			--| the leading percent sign
			token.extend (ts.item (i))
			i := i + 1
			inspect ts.item (i)
			when '#', '~' then --| Decoration and Agent flags
				token.extend (ts.item (i))
				i := i + 1
			else
			end
			-- Capture alignment specifier, if any
			inspect ts.item (i)
			when '-', '=', '+' then
				token.extend (ts.item (i))
				set_alignment (ts.item (i))
				i := i + 1
			else
			end
			if ts.item (i).is_digit then --| Field width
				create iref
				iref.set_item (i)
				extract_field_width (iref)
				i := iref.item
			elseif ts.item (i) = '.' then
				-- Might be a floating point format missing an overall 
				-- field width, or might be a list or decimal separator
				if i < lim
					and then ts.item (i+1) = 'd'
						or ts.item (i+1) = 'L'
				 then
					 -- Leave stream intact, without advance.
					 --
					 -- extract_type_specifier will capture the separator
					 -- and advance as needed
				else
					field_width := 1
					create iref
					iref.set_item (i)
					extract_field_width (iref)
					i := iref.item
				end
			end
			--| Now get the type specifier
			extract_type_specifier (i)
			if is_typed and not has_format_error then
				if is_float or is_percent then
					if not has_fractional_field_width then
						fractional_field_width := K_printf_dflt_fp_fractional_width
					end
					if not has_field_width then
						field_width := K_printf_dflt_fp_whole_width
					end
				end
			end
		ensure
			string_unchanged: original_string.is_equal(old original_string)
		end

	--|--------------------------------------------------------------

	set_alignment (v: CHARACTER)
		do
			inspect v
			when '-' then
				is_left_aligned := True
			when '=' then
				is_center_aligned := True
			when '+' then
				is_right_aligned := True
			end
		end

	--|--------------------------------------------------------------

	extract_field_width (iref: INTEGER_REF)
			-- From the given string, beginning at the position
			-- indicated by iref, extract the overall and,
			-- for floating point values, fractional field widths
		require
			position_exists: iref /= Void
			position_large_enough: iref.item > 0
			position_small_enough: iref.item <= original_string.count
			char1_is_digit_or_dp: original_string.item (iref.item).is_digit or
				(original_string.item (iref.item) = '.' and field_width /= 0)
		local
			i, lim: INTEGER
		do
			lim := original_string.count
			i := iref.item
			if original_string.item(i) = '0' then
				private_pad_character := '0'
			end
			from
			until (i > lim) or not original_string.item (i).is_digit
			loop
				token.extend (original_string.item (i))
				field_width := (field_width * 10) + original_string.item (i).out.to_integer
				i := i + 1
			end
			has_field_width := field_width /= 0
			if original_string.item (i) = '.' then --| Floating point
				token.extend (original_string.item (i))
				from i := i + 1
				until i > lim or not original_string.item (i).is_digit
				loop
					has_fractional_field_width := True
					token.extend (original_string.item (i))
					fractional_field_width := (fractional_field_width * 10)
					+ original_string.item (i).out.to_integer
					i := i + 1
				end
			end
			iref.set_item (i)
		ensure
			field_flag_set:	has_field_width = True
			no_flag_no_frac: (not has_fractional_field_width)
				implies fractional_field_width = 0
		end

	--|--------------------------------------------------------------

	extract_type_specifier (pos: INTEGER)
		require
			valid_position: pos > 0 and pos <= original_string.count
		do
			type_specifier := original_string.item (pos)
			token.extend (type_specifier)

			inspect type_specifier
			when 'd' then
				format_type := K_printf_fmt_type_decimal
			when 's' then
				format_type := K_printf_fmt_type_string
			when 'f' then
				format_type := K_printf_fmt_type_float
			when 'x' then
				format_type := K_printf_fmt_type_hex
			when 'u' then
				format_type := K_printf_fmt_type_unsigned
			when 'o' then
				format_type := K_printf_fmt_type_octal
			when 'c' then
				format_type := K_printf_fmt_type_character
			when 'b' then
				format_type := K_printf_fmt_type_binary
			when 'A' then
				format_type := K_printf_fmt_type_agent
			when 'B' then
				format_type := K_printf_fmt_type_boolean
			when 'L' then
				format_type := K_printf_fmt_type_list
			when 'P' then
				format_type := K_printf_fmt_type_percent
			else
				if pos < original_string.count
					and then original_string.item (pos+1) = 'L'
				 then
					 -- List format can accept a single optional separator 
					 -- character using the form:  %%<sep>L
					 private_list_separator := type_specifier
					 type_specifier := original_string.item (pos+1)
					 token.extend (type_specifier)
					 format_type := K_printf_fmt_type_list
				elseif pos < original_string.count
					and then original_string.item (pos+1) = 'd'
				 then
					 -- Decimal format can accept a single optional separator 
					 -- character using the form:  %%<sep>d
					 private_thousands_separator := type_specifier
					 type_specifier := original_string.item (pos+1)
					 token.extend (type_specifier)
					 format_type := K_printf_fmt_type_decimal
				else
					-- Bad type value, invalid format
--RFO					has_format_error := True
--RFO					add_unknown_type_error (original_string, pos, type_specifier)
				end
			end
		end

 --|========================================================================
feature {AEL_PF_FORMATTING_ROUTINES} -- Argument setting
 --|========================================================================

	set_argument (v: detachable ANY)
			-- Associate the given argument with this format parameter
		do
			argument := v
			argument_defined := True
		ensure
			was_set: argument = v
			flag_set: argument_defined
		rescue
			-- This should never happen as the body has only 2 
			-- assignments, but it has been observerd (and reported), so 
			-- until the issue is identified and fixed, there is an 
			-- optional call to a client to post/log/print the message
			if v = Void then
				log_to_client ("In failed printf set argument, v is Void")
			else
				log_to_client ("In failed printf set argument, v="+v.out)
			end
			-- Don't retry
		end

 --|========================================================================
feature {AEL_PF_FORMATTING_ROUTINES} -- Argument formatting
 --|========================================================================

	arg_out: STRING
			-- Formatted representation of the associated argument
		local
			tstr: STRING
			ta: like argument
		do
			create Result.make (8)
			tstr := ""
			if argument_defined then
				if argument = Void then
					tstr := "Void"
					add_arg_type_error (original_string, original_position,
					expected_class_name, "Void")
				elseif is_string then
					tstr := string_arg_out
				elseif is_boolean then
					tstr := bool_arg_out
				elseif is_float then
					tstr := float_arg_out
				elseif is_character then
					tstr := char_arg_out
				elseif is_integer then
					tstr := int_arg_out
				elseif is_list then
					tstr := list_arg_out
				elseif is_agent then
					tstr := agent_arg_out
				elseif is_percent then
					tstr := percent_arg_out
				else
					check 
						untyped: not is_typed
					end
					ta := argument
					if ta /= Void then
						tstr := ta.out
					else
						tstr := "Void"
					end
				end
			end
			if has_arg_type_error then
				add_arg_type_error (original_string, original_position,
				expected_class_name, argument_class_name)
			end
			--| After formatting by type and decoration,
			--| align/justify the string within the field
			Result.append (aligned (tstr))
		ensure
			exists:	Result /= Void
		end

 --|========================================================================
feature {AEL_PF_FORMATTING_ROUTINES} -- Value scanning
 --|========================================================================

	value_in (buf: STRING; spos: INTEGER; ec: CELL [INTEGER]): detachable ANY
			-- Value, if any, from 'buf' at position 'spos' 
			-- corresponding to Current
		require
			exists: buf /= Void
			valid_start: spos > 0 and spos <= buf.count
			end_cell_exists: ec /= Void
		do
			if is_string then
				Result := pfsr.string_at (buf, spos, ec, field_width)
			elseif is_boolean then
				Result := pfsr.boolean_at (buf, spos, ec, field_width, is_decorated)
			elseif is_float then
				Result := pfsr.double_at (
					buf, spos, ec, field_width, fractional_field_width, is_decorated)
			elseif is_character then
				Result := buf.item (spos)
				ec.put (spos + 1)
			elseif is_decimal then
				Result := pfsr.decimal_at (
					buf, spos, ec, field_width, is_decorated, thousands_separator)
			elseif is_hex then
				Result := pfsr.hexadecimal_at (
					buf, spos, ec, field_width, is_decorated)
			elseif is_octal then
				Result := pfsr.octal_at (buf, spos, ec, field_width, is_decorated)
			elseif is_binary then
				Result := pfsr.binary_at (buf, spos, ec, field_width, is_decorated)
			elseif is_unsigned then
				Result := pfsr.natural_at (
					buf, spos, ec, field_width, is_decorated, thousands_separator)
			elseif is_list then
				Result := pfsr.list_at (buf, spos, ec, field_width, list_separator)
			elseif is_agent then
				-- RFO TODO.  Make this less horrific
				check
					agent_scan_unsupported: False
				end
			elseif is_percent then
				-- RFO TODO.  This is simply float.  Need to be 
				-- implemented properly for percent, checking for 
				-- trailing percent symbol and dividing value by 100
				Result := pfsr.double_at (
					buf, spos, ec, field_width, fractional_field_width, is_decorated)
			else
				check 
					untyped: not is_typed
				end
			end
		end

 --|========================================================================
feature -- Context queries
 --|========================================================================

	original_length: INTEGER
			-- Length of original token
		do
			Result := token.count
		ensure
			non_negative: Result >= 0
		end

	--|--------------------------------------------------------------

	original_string: STRING
			-- Reference to the whole original format string given

	original_position: INTEGER
			-- Original starting position in the format string

	token: STRING
			-- Original format token, captured from input
	
	has_format_error: BOOLEAN
			-- Has a format error been encountered?

	has_arg_type_error: BOOLEAN
			-- Has an argument type mismatch been encountered?

 --|========================================================================
feature {AEL_PF_SCAN_ROUTINES} -- Private context queries
 --|========================================================================

	type_specifier: CHARACTER
			-- Character in format string denoting type

	argument: detachable ANY
			-- Argument associated with this format

	argument_defined: BOOLEAN
			-- Has the argument value been defined yet?

	--|--------------------------------------------------------------

	is_decorated: BOOLEAN
			-- Was a decoration specifier found?
		do
			Result := (token.count > 1) and then (token.item (2) = '#')
		end

	--|--------------------------------------------------------------

	is_aligned: BOOLEAN
			-- Does the format call for special aligment?
			-- By default, all formats are left-aligned
		do
			Result := is_right_aligned or is_center_aligned
		end

	--|--------------------------------------------------------------

	is_left_aligned: BOOLEAN
			-- Should formatted arg begin at left edge of field?

	is_right_aligned: BOOLEAN
			-- Should formatted arg end at right edge of field?

	is_center_aligned: BOOLEAN
			-- Should formatted arg be centered in field?

	--|--------------------------------------------------------------

	is_zero_padded (fw, aw: INTEGER): BOOLEAN
			-- Does the format result in leading zero padding?
		do
			Result := (is_right_aligned or is_center_aligned or not is_aligned)
				and (fw > aw) and (pad_character = '0')
		end

	--|--------------------------------------------------------------

	pad_character: CHARACTER
			-- Character used to align and justify in field
		do
--			if (is_float or (is_integer and not is_binary)) then
			if is_float or is_percent or is_integer then
				Result := private_pad_character
				if is_binary and Result = '0' then
					-- If zero-padded binary,
					-- negative values should actually be 1-padded
					Result := '1'
				end
			end
			if Result = '%U' then
				Result := ' '
			end
		end

	--|--------------------------------------------------------------

	list_separator: STRING
			-- STRING used to separate list elements
		do
			if private_list_separator /= '%U' then
				Result := private_list_separator.out
			else
				if is_decorated then
					Result := ""
				else
					Result := dflt_printf_list_delimiter
				end
			end
		end

	--|--------------------------------------------------------------

	thousands_separator: STRING
			-- STRING used to separate thousands in decimal integers
		do
			if private_thousands_separator /= '%U' then
				Result := private_thousands_separator.out
			elseif is_decorated then
				Result := default_printf_thousands_delimiter
			else
				Result := ""
			end
		end

	--|--------------------------------------------------------------

	has_field_width: BOOLEAN
	has_fractional_field_width: BOOLEAN

	field_width: INTEGER
			-- Overall field width for non-floating point values
			-- For floating point values, the whole part field width

	fractional_field_width: INTEGER
			-- For floating point values, the width of the
			-- fractional part (right of decimal point)

	--|--------------------------------------------------------------

	decoration: STRING
			-- String to apply as context-specific decoration
		do
			Result := ""
			if is_decorated then
				if is_hex then
					Result := "0x"
				elseif is_octal then
					Result := "0"
				end
			end
		ensure
			exists: Result /= Void
		end

 --|========================================================================
feature {AEL_PF_TYPE_ROUTINES} -- Type queries
 --|========================================================================

	is_character: BOOLEAN
			-- Does format expect a character argument?
		do
			Result := is_char
		end

	--|--------------------------------------------------------------

	is_integer: BOOLEAN
			-- Does format expect an integer argument?
		do
			Result := is_decimal or is_hex or is_octal or is_binary or is_unsigned
		end

	--|--------------------------------------------------------------

	is_boolean: BOOLEAN
			-- Does format expects a boolean argument?
		do
			Result := format_type = K_printf_fmt_type_boolean
		end

	is_binary: BOOLEAN
			-- Does format expect an integer argument?
			-- Shows in binary format
		do
			Result := format_type = K_printf_fmt_type_binary
		end

	is_char: BOOLEAN
			-- Does format expect a character argument?
		do
			Result := format_type = K_printf_fmt_type_character
		end

	is_decimal: BOOLEAN
			-- Does format expect an integer argument?
			-- Shows in decimal format
		do
			Result := format_type = K_printf_fmt_type_decimal
		end

	is_float: BOOLEAN
			-- Does format expect a floating point argument?
			-- (REAL OR DOUBLE)
		do
			Result := format_type = K_printf_fmt_type_float
		end

	is_octal: BOOLEAN
			-- Does format expect an integer argument?
			-- Shows in octal format
		do
			Result := format_type = K_printf_fmt_type_octal
		end

	is_string: BOOLEAN
			-- Does format expect a string argument?
		do
			Result := format_type = K_printf_fmt_type_string
		end

	is_unsigned: BOOLEAN
			-- Does format expect an integer argument?
			-- Shows in unsigned decimal format
		do
			Result := format_type = K_printf_fmt_type_unsigned
		end

	is_hex: BOOLEAN
			-- Does format expect an integer argument?
			-- Shows in hexadecimal format
		do
			Result := format_type = K_printf_fmt_type_hex
		end

	is_list: BOOLEAN
			-- Does format expect a list or container argument?
			-- Shows in delimited format
		do
			Result := format_type = K_printf_fmt_type_list
		end

	is_agent: BOOLEAN
			-- Does format expect a TUPLE [ANY, FUNCTION] argument?
		do
			Result := format_type = K_printf_fmt_type_agent
		end

	is_percent: BOOLEAN
			-- Does format expect a float arg (to be interpreted as percent)?
		do
			Result := format_type = K_printf_fmt_type_percent
		end

--|========================================================================
feature {AEL_PF_TYPE_ROUTINES} -- Visible type queries
--|========================================================================

	is_typed: BOOLEAN
			-- Was a valid type specifier found?
		do
			Result := format_type > 0
--RFO			Result := is_integer or is_string or is_float
--RFO				or is_boolean or is_character or is_list
		end

	--|--------------------------------------------------------------

	format_type: INTEGER
			-- Defined format type (if any, else 0)

	--|--------------------------------------------------------------

	minus_is_withheld: BOOLEAN
			-- Is the minus sign being withheld until
			-- after alignment for a negative decimal
			-- integer argument value?

 --|========================================================================
feature {NONE} -- Output Implementation
 --|========================================================================

	string_arg_out: STRING
			-- Formatted string argument
		local
			tsa: detachable STRING
			ta: detachable ANY
		do
			tsa := any_to_string (argument)
			if tsa /= Void then
				Result := tsa
			else
				--| Argument doesn't match
				has_arg_type_error := True
				ta := argument
				if ta /= Void then
					Result := ta.out
				else
					Result := "Void"
				end
			end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	bool_arg_out: STRING
			-- Formatted boolean argument
		local
			tba: detachable BOOLEAN_REF
			ta: detachable ANY
		do
			tba := any_to_boolean_ref (argument)
			if tba /= Void then
				if tba.item then
					Result := "True"
				else
					Result := "False"
				end
			else
				--| Argument doesn't match
				has_arg_type_error := True
				ta := argument
				if ta /= Void then
					Result := ta.out
				else
					Result := "Void"
				end
			end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	float_arg_out: STRING
			-- Formatted floating point argument
		do
			Result := real_arg_out (False)
		end

	real_arg_out (pf: BOOLEAN): STRING
			-- Formatted floating point argument
			-- If 'pf' format as a percentage by multiplying the value by 
			-- 100 and appending a percent symbol after the number
		local
			ta: detachable ANY
			tda: detachable REAL_64_REF
			tra: detachable REAL_32_REF
			tia: detachable INTEGER_64_REF
			whole_out, fract_out: STRING
			parts: LIST [STRING]
		do
			-- Set default value
			Result := "Void"
			ta := argument
			if ta /= Void then
				Result := ta.out
				tda := any_to_real_64_ref (ta)
				if tda = Void then
					tra := any_to_real_32_ref (ta)
					if tra = Void then
						tia := any_to_integer_64_ref (ta)
						if tia = Void then --| Argument doesn't match
							has_arg_type_error := True
						else
							tda := tia.to_double
						end
					else
						tda := tra.to_double
					end
				end
				if tda = Void then
					--| Argument type mismatch
					has_arg_type_error := True
				else
					if pf then
						-- Percent format; multiply value by 100
						tda := tda * 100.0
					end
					parts := printf_fmt_funcs.double_parts (tda)
					whole_out := parts.first
					fract_out := parts.last
					if fract_out.count < fractional_field_width then
						fract_out.append (
							create {STRING}.make_filled (
								'0', fractional_field_width - fract_out.count))
					end
					if tda < tda.zero and
						is_zero_padded (field_width, whole_out.count)
					 then
						 minus_is_withheld := True
					end
					if fractional_field_width = 0 then
						-- RFO, might want to investigate rounding here
						Result := whole_out
					else
						Result := printf_fmt_funcs.double_parts_out (
							whole_out, fract_out, fractional_field_width)
					end
					if pf then
						Result.extend ('%%')
					end
				end
			end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	char_arg_out: STRING
			-- Formatted character argument
		local
			tc8: detachable CHARACTER_8_REF
			tc32: detachable CHARACTER_32_REF
		do
			Result := ""
			tc8 := any_to_character_8_ref (argument)
			tc32 := any_to_character_32_ref (argument)
			if tc8 /= Void then
				Result := tc8.out
			elseif tc32 /= Void then
				--RFO need MUCH better Ucode support than this!!!!!!!!!
				if tc32.is_character_8 then
					Result := tc32.to_character_8.out
				else
					Result := tc32.out
				end
			else
				--| Argument doesn't match
				has_arg_type_error := True
				Result := ""
			end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	int_arg_out: STRING
			-- Formatted integer argument
		local
			tia8: detachable INTEGER_8_REF
			tia16: detachable INTEGER_16_REF
			tia32: detachable INTEGER_32_REF
			tia64: detachable INTEGER_64_REF
			tian8: detachable NATURAL_8_REF
			tian16: detachable NATURAL_16_REF
			tian32: detachable NATURAL_32_REF
			tian64: detachable NATURAL_64_REF
			ti: INTEGER_64
			tn: NATURAL_64
			nb: INTEGER
			ts: STRING
		do
			create Result.make (8)
			tia8 := any_to_integer_8_ref (argument)
			tia16 := any_to_integer_16_ref (argument)
			tia32 := any_to_integer_32_ref (argument)
			tia64 := any_to_integer_64_ref (argument)
			if tia8 /= Void then
				nb := 1
				if is_unsigned then
					tian32 := tia8.as_natural_32
					tian64 := tian32.as_natural_64
				else
					tia64 := tia8.as_integer_64
				end
			elseif tia16 /= Void then
				nb := 2
				if is_unsigned then
					tian32 := tia16.as_natural_32
					tian64 := tian32.as_natural_64
				else
					tia64 := tia16.as_integer_64
				end
			elseif tia32 /= Void then
				nb := 4
				if is_unsigned then
					tian32 := tia32.as_natural_32
					tian64 := tian32.as_natural_64
				else
					tia64 := tia32.as_integer_64
				end
			elseif tia64 /= Void then
				nb := 8
				if is_unsigned then
					tian64 := tia64.as_natural_64
				end
			else
				tian8 := any_to_natural_8_ref (argument)
				tian16 := any_to_natural_16_ref (argument)
				tian32 := any_to_natural_32_ref (argument)
				tian64 := any_to_natural_64_ref (argument)
				if tian8 /= Void then
					nb := 1
					tian64 := tian8.as_natural_64
					if format_type = K_printf_fmt_type_decimal then
						format_type := K_printf_fmt_type_unsigned
					end
				elseif tian16 /= Void then
					nb := 2
					tian64 := tian16.as_natural_64
					if format_type = K_printf_fmt_type_decimal then
						format_type := K_printf_fmt_type_unsigned
					end
				elseif tian32 /= Void then
					nb := 4
					tian64 := tian32.as_natural_64
					if format_type = K_printf_fmt_type_decimal then
						format_type := K_printf_fmt_type_unsigned
					end
				elseif tian64 /= Void then
					nb := 8
					if format_type = K_printf_fmt_type_decimal then
						format_type := K_printf_fmt_type_unsigned
					end
				else
					has_arg_type_error := True
				end
			end
			if not has_arg_type_error then
				check
					unsigned_natural: is_unsigned implies tian64 /= Void
				end
				if tia64 /= Void then
					ti := tia64
					tn := ti.as_natural_64
				end
				if tian64 /= Void then
					tn := tian64
				end
				if is_hex then
					--Result := printf_fmt_funcs.integer_to_hex (ti, nb)
					Result := printf_fmt_funcs.natural_to_hex (tn, nb)
				elseif is_octal then
					Result := printf_fmt_funcs.integer_to_octal (ti, nb)
				elseif is_binary then
					Result := printf_fmt_funcs.integer_to_binary (ti)
					if is_decorated then
						Result.extend ('b')
					end
					if field_width /= 0 and field_width < Result.count then
						prune_leading_zeroes (Result, field_width)
					end
				elseif is_unsigned then
					Result := printf_fmt_funcs.natural_out (tn, nb)
				else -- Decimal
					ts := decimal_out (ti)
					if ((ti < ti.zero) and
						is_zero_padded (field_width, ts.count)) then
							minus_is_withheld := True
							Result := (-ti).out
					else
						Result := ts
					end
				end
			end
		ensure
			exists:	Result /= Void
		end

	--|--------------------------------------------------------------

	decimal_out (v: INTEGER_64): STRING
			-- String form of decimal value 'v', possible decorated
		local
			ts: STRING
			i, j, lim: INTEGER
		do
			ts := v.out
			lim := ts.count
			if (lim <= 3) or
				((not is_decorated) and thousands_separator.is_empty)
			 then
				 Result := ts
			else
				create Result.make (lim + lim // 3)
				from i := lim
				until i <= 0
				loop
					from j := 1
					until j > 3 or i <= 0
					loop
						Result.extend (ts.item (i))
						i := i - 1
						j := j + 1
					end
					if i > 0 then
						Result.append (thousands_separator)
					end
				end
				Result.mirror
			end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	list_arg_out: STRING
			-- Formatted container argument
		local
			tca: detachable CONTAINER [detachable ANY]
			tla: LINEAR [detachable ANY]
			ta: detachable ANY
			sep: STRING
			tt: detachable TUPLE
			tfunc: detachable FUNCTION [STRING]
			lin_first, lin_last: BOOLEAN
		do
			-- Arg must be a list unless the agent flag was provided, in 
			-- which case the arg must be a tuple, the first item of 
			-- which is a list
			Result := ""
			sep := list_separator
			tt := any_to_tuple (argument)
			if tt /= Void then
				--| Arg must be a TUPLE [LIST, FUNCTION]
				if tt.count /= 2 then
					add_arg_type_error (
						original_string, original_position,
						expected_class_name, argument_class_name)
				else
					tca := any_to_container (tt.reference_item (1))
					if 
						attached {FUNCTION [STRING]}
						tt.reference_item (2) as ltf
					 then
						 tfunc := ltf
					end
				end
			else
				tca := any_to_container (argument)
			end
			if tca = Void then
				--| Argument doesn't match
				has_arg_type_error := True
				ta := argument
				if ta /= Void then
					Result := ta.out
				else
					Result := "Void"
				end
			else
				tla := tca.linear_representation
				lin_first := True
				from tla.start
				until tla.exhausted
				loop
					ta := tla.item
					if tfunc /= Void then
						tla.forth
						lin_last := tla.exhausted
						Result.append (tfunc.item ([ta, lin_first, lin_last]))
						lin_first := False
					elseif ta /= Void then
						Result.append (ta.out)
					else
						Result.append ("Void")
					end
					if tfunc = Void then
						tla.forth --| already advanced for agent case
						if  not tla.exhausted then
							Result.append (sep)
						end
					end
				end
			end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	agent_arg_out: STRING
			-- Agent-formatted argument
		do
			Result := ""
			if
				attached
				{TUPLE [ANY, FUNCTION [detachable ANY, STRING]]}
				argument as targ
			 then
				 if
					 attached {FUNCTION [detachable ANY, STRING]}
					 targ.item (2) as tfunc
				  then
					  Result := tfunc.item ([targ.item (1)])
				 else
					 Result := "Void"
				 end
			 else
				 Result := "Void"
			 end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	percent_arg_out: STRING
			-- Floating point argument, formatted as a percentage
			-- Value provided is multiplied by 100 and a percent sign appended
		do
			Result := real_arg_out (True)
		ensure
			exists: Result /= Void
		end

--|========================================================================
feature {NONE} -- Output Support
--|========================================================================

	aligned (tstr: STRING): STRING
			-- Copy of given string aligned into field width
			-- per current parameters
		require
			str_exists: tstr /= Void
		local
			pad_len, minus_pad_len: INTEGER
			pre_str, post_str: STRING
		do
			create Result.make (field_width.max (tstr.count))
			pre_str := ""
			post_str := ""
			if tstr.count < field_width then
				if minus_is_withheld then
					minus_pad_len := 1
				end
				pad_len := (field_width - tstr.count 
				- minus_pad_len - decoration.count).max (0)
				if is_center_aligned then
					create pre_str.make_filled (pad_character, pad_len // 2)
					create post_str.make_filled (' ', pad_len - pre_str.count)
				else
					if is_left_aligned then
						create post_str.make_filled (' ', pad_len)
					else
						create pre_str.make_filled (pad_character, pad_len)
					end
				end
			end
			if minus_is_withheld then
				Result.extend ('-')
			end
			if is_zero_padded (field_width, tstr.count) then
				Result.append (decoration)
			end
			Result.append (pre_str)
			if not is_zero_padded (field_width, tstr.count) then
				Result.append (decoration)
			end
			Result.append (tstr)
			Result.append (post_str)
		ensure
			exists: Result /= Void
			big_enough: Result.count >= field_width
		end

	--|--------------------------------------------------------------

	prune_leading_zeroes (ts: STRING; fw: INTEGER)
			-- Prune leading zeroes in 'ts', to no less than length fw
		local
			i, lim, nz: INTEGER
		do
			lim := ts.count - fw
			from i := 1
			until i > lim
			loop
				if ts.item (i) = '0' then
					nz := nz + 1
					i := i + 1
				else
					i := lim + 1
				end
			end
			ts.keep_tail (ts.count - nz)
		end

	--|--------------------------------------------------------------

	private_pad_character: CHARACTER
			-- Padding character to use instead of default

	private_list_separator: CHARACTER
			-- Separator character to use instead of default

	private_thousands_separator: CHARACTER
			-- Thousands separator character to use instead of default

	pfsr: AEL_PF_SCAN_ROUTINES
		once
			create Result
		end

 --|========================================================================
feature {AEL_PF_FORMATTING_ROUTINES} -- Type representation
 --|========================================================================

	argument_class_name: STRING
			-- The name of the class to which argument belongs
		local
			ta: detachable like argument
		do
			if argument_defined then
				ta := argument
				if ta /= Void then
					Result := (create {INTERNAL}).class_name (ta)
				else
					Result := "** Argument is Void **"
				end
			else
				Result := "** Not Yet Defined **"
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------

	expected_class_name: STRING
			-- The name of the class expected by the type parameter
		local
			tc: CHARACTER
			ts: STRING
			ti: INTEGER
		do
			if is_character then
--				Result := "CHARACTER"
				Result := (create {INTERNAL}).class_name (tc)
			elseif is_boolean then
				Result := "BOOLEAN"
			elseif is_integer then
--				Result := "INTEGER"
				Result := (create {INTERNAL}).class_name (ti)
			elseif is_float or is_percent then
				Result := "DOUBLE/REAL"
			elseif is_string then
--				Result := "STRING"
				ts := ""
				Result := (create {INTERNAL}).class_name (ts)
			else
				Result := "** Undefined **"
			end
		ensure
			exists: Result /= Void and then not Result.is_empty
		end

	--|--------------------------------------------------------------
invariant
	token_exists: token /= Void
	format_string_exists: original_string /= Void
	position_is_valid: original_position > 0 and
	original_position <= original_string.count

end -- class AEL_PF_FORMAT_PARAM

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
--| 008 18-May-2011
--|     Fixed ham-fisted bug with hex formats of NATURALs in int_arg_out.
--| 007 03-Apr-2011
--|     Added support for non-default separators when grouping 
--|     decimals using %<c>d notation.
--|     Enhanced binary support to fix field width issue.
--|     Tweaked extract_token to permit '.' as a delimiter for List 
--|     and Decimal formats.
--|     Broke out decimal_out to enable custom thousands delimeter 
--|     when not decorated.
--| 006 17-Feb-2010
--|     Compiled and tested using Eiffel 6.5 w/ standard syntx
--|     Updated extract_token and extract_field_width to support float
--|     formats missing overall width values (e.g. %%.2f)
--| 005 28-Jul-2009
--|     Compiled and tested using Eiffel 6.2 and 6.4
--|----------------------------------------------------------------------
--| How-to
--|
--| This class is used by AEL_PRINTF and need not be addressed directly
--|----------------------------------------------------------------------
