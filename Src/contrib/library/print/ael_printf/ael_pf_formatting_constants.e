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
--| Constants used by the other members of the cluster.
--| Also offers is_valid_first_fmt_char() to its descendents.
--| Holds the shared error list (last_printf_errors) and provides
--| a shared instanace of AEL_PF_FORMATTING_ROUTINES for descendents.
--|----------------------------------------------------------------------

class AEL_PF_FORMATTING_CONSTANTS

 --|========================================================================
feature {NONE} -- Constants
 --|========================================================================

	Printf_hex_digits: STRING = "0123456789abcdef"
	Printf_octal_digits: STRING = "01234567"

	K_printf_dflt_fp_fractional_width: INTEGER = 6
	K_printf_dflt_fp_whole_width: INTEGER = 1

	Ks_printf_missing_arg_stub: STRING
		once

			Result := "Void"
		end

	Ks_printf_mismatch_type_stub: STRING
		once
			Result := "** Arg Type Mismatch **"
		end

	Ks_printf_type_specifiers: STRING = "dsfxuocBLb"
			-- String containing all legal format characters,
			-- sorted in expected order of frequency of use

 --|========================================================================
feature {NONE} -- Format type codes
 --|========================================================================

	-- N.B. these correspond to char positions in Ks_printf_type_specifiers
	-- Keep them in synch

	K_printf_fmt_type_decimal: INTEGER = 1
	K_printf_fmt_type_string: INTEGER = 2
	K_printf_fmt_type_float: INTEGER = 3
	K_printf_fmt_type_hex: INTEGER = 4
	K_printf_fmt_type_unsigned: INTEGER = 5
	K_printf_fmt_type_octal: INTEGER = 6
	K_printf_fmt_type_character: INTEGER = 7
	K_printf_fmt_type_binary: INTEGER = 8
	K_printf_fmt_type_list: INTEGER = 9
	K_printf_fmt_type_boolean: INTEGER = 10
	K_printf_fmt_type_agent: INTEGER = 11
	K_printf_fmt_type_percent: INTEGER = 12

 --|========================================================================
feature {NONE} -- Error codes
 --|========================================================================

	K_printf_fmt_err_arg_count: INTEGER = 1
	K_printf_fmt_err_arg_type: INTEGER = 2

	K_printf_fmt_err_no_type: INTEGER = 11
	K_printf_fmt_err_unknown_type: INTEGER = 12

	K_printf_fmt_err_pad_char: INTEGER = 21

	K_printf_fmt_err_field_width: INTEGER = 31

	K_printf_fmt_err_internal: INTEGER = 99

 --|========================================================================
feature {AEL_PRINTF} -- Shared routines
 --|========================================================================

	printf_fmt_funcs: AEL_PF_FORMATTING_ROUTINES
		once
			create Result
		end

	last_printf_errors: LINKED_LIST [ AEL_PF_FORMAT_ERROR ]
		-- List of errors from most recent operation
		once
			create Result.make
		end

	--|--------------------------------------------------------------

	log_to_client (v: STRING)
			-- If client log agent exists, call it with 'v'
		local
			p: like client_log_proc
		do
			p := client_log_proc
			if p /= Void then
				p.call ([v])
			end
			io.error.put_string (v)
		end

	client_log_proc: detachable PROCEDURE [STRING]
		do
			Result := client_log_proc_cell.item
		end

	client_log_proc_cell: CELL [detachable PROCEDURE [STRING]]
		once
			create Result.put (Void)
		end

	set_client_log_proc (v: like client_log_proc)
			-- Set the procedure to call to log a message for the client
			-- For debugging support only
		do
			client_log_proc_cell.put (v)
		end

	--|--------------------------------------------------------------

	printf_client_error_agent:
		detachable PROCEDURE [AEL_PF_FORMAT_ERROR]
		do
			Result := printf_client_error_agent_cell.item
		end

	printf_client_error_agent_cell:
		CELL [detachable PROCEDURE [AEL_PF_FORMAT_ERROR]]
		once
			create Result.put (Void)
		end

 --|========================================================================
feature {NONE} -- Validation
 --|========================================================================

	is_valid_printf_first_fmt_char (c: CHARACTER): BOOLEAN
		do
			inspect c
			when '#', '-', '+', '=', '~' then
				--| Decoration and alignment flags
				Result := True
				-- '#' is the decoration flag
				-- '-', '+' and '=' are alignment flags
				-- '~' is the agent flag
			else
				if is_valid_printf_type_specifier (c) then
					Result := True
				else
					--| Field width
					Result := c.is_digit
				end
			end
		end

	--|--------------------------------------------------------------

	is_valid_printf_type_specifier (c: CHARACTER): BOOLEAN
		do
			Result := Ks_printf_type_specifiers.has (c)
		end

--|========================================================================
feature -- Default format options
--|========================================================================

	default_printf_fill_char: CHARACTER
			-- Usually blank unless numeric and zero,
			-- can be changed to any valid character
		do
			Result := dflt_printf_fillchar_ref.item
		end

	--|--------------------------------------------------------------

	default_printf_list_delimiter: STRING
			-- Default delimiter to use when representing List formats
		do
			Result := dflt_printf_list_delimiter
		end

	--|--------------------------------------------------------------

	decimal_separator: CHARACTER
			-- Separator to use to representing the decimal point
		do
			Result := dflt_decimal_separator_ref.item
		end

	--|--------------------------------------------------------------

	default_printf_thousands_delimiter: STRING
			-- Default delimiter to use between groups of 3 digits
			-- when representing decimal formats
		do
			Result := dflt_printf_thousands_delimiter
		end

--|========================================================================
feature -- Default format options setting
--|========================================================================

	set_default_printf_fill_char (v: CHARACTER)
			-- Change the fill character from blank to 
			-- the given new value for ALL subsequent 
			-- printf calls in this thread space
		do
			dflt_printf_fillchar_ref.put (v)
		end

	reset_default_printf_fill_char
			-- Reset the default fill character to blank
		do
			dflt_printf_fillchar_ref.put (' ')
		end

	--|--------------------------------------------------------------

	set_decimal_separator (v: CHARACTER)
			-- Change the character used to denote the decimal point
			-- to 'v' for ALL subsequent printf calls in this thread space
		do
			dflt_decimal_separator_ref.put (v)
		end

	reset_decimal_separator
			-- Reset the character used to denote the decimal point
		do
			dflt_decimal_separator_ref.put ('.')
		end

	--|--------------------------------------------------------------

	set_default_printf_list_delimiter (v: STRING)
			-- Change the default list delimiter string from a single
			-- blank character to the given string for ALL subsequent 
			-- printf calls in this thread space
		do
			dflt_printf_list_delimiter.wipe_out
			dflt_printf_list_delimiter.append (v)
		end

	reset_default_printf_list_delimiter
			-- Reset the default list delimiter string
		do
			dflt_printf_list_delimiter.wipe_out
			dflt_printf_list_delimiter.extend (' ')
		end

	--|--------------------------------------------------------------

	set_default_printf_thousands_delimiter (v: STRING)
			-- Change the default thousands delimiter string from an
			-- empty string to the given string for ALL subsequent 
			-- printf calls (in this thread space)
		do
			dflt_printf_thousands_delimiter.wipe_out
			dflt_printf_thousands_delimiter.append (v)
		end

	reset_default_printf_thousands_delimiter
			-- Reset the default thousands delimiter string
		do
			dflt_printf_thousands_delimiter.wipe_out
			dflt_printf_thousands_delimiter.extend (',')
		end

	set_printf_client_error_agent (v: like printf_client_error_agent)
			-- Set the procedure to call upon encountering a format error
		do
			printf_client_error_agent_cell.put (v)
		ensure
			is_set: printf_client_error_agent = v
		end

 --|========================================================================
feature {NONE} -- Alternate fill support
 --|========================================================================

	dflt_printf_fillchar_ref: CELL [CHARACTER]
			-- Usually blank unless numeric and zero,
			-- can be changed to any valid character
		once
			create Result.put (' ')
		end

	dflt_printf_list_delimiter: STRING
			-- Delimiter to use when representing List formats
		once
			create Result.make (1)
			Result.extend (' ')
		end

	dflt_printf_thousands_delimiter: STRING
			-- Thousands delimiter to use when representing decimal formats
		once
			create Result.make (1)
			Result.extend (',')
		end

	dflt_decimal_separator_ref: CELL [CHARACTER]
			-- Default separator to use to representing the decimal point
		once
			create Result.put ('.')
		end

 --|========================================================================
feature -- Help
 --|========================================================================

	printf_help_message: STRING
		do
			create Result.make (3072)
			Result.append ("{
 The various string formatting routines provide a means by which to
 format strings for output or other purposes in a manner reminiscent of
 the traditional printf functions in C and similar languages.

  Format string construction (in order):

    %
    [<decoration_flag>]
    [<agent_flag>]
    [<alignment_flag>]
    [<fill_specifier>]
    [<field_width>]
    <field_type>

  Where:

    <decoration_flag> ::=  '#'
      Decoration consumes part of the field width
      Decoration is applied as follows:
        "0x" preceding hexadecimal values
        "0" preceding octal values
        "b" following binary values
        Decimal values show delimiters at thousands (commas by default)

    <agent_flag> ::=  '~'
      Valid for List formats only.  Cannot be combined with decoration flag

    <alignment_flag> ::=  '-' |   '+'  |  '='
                         (left   right  centered)

    <fill_specifier> ::=  <character>
      Fills remainder of field width
      with given character (default is blank)

    <field_width> ::=  <simple_width> | <complex_width>

    <field_type> ::=  <character>

      Field type can be at least on of the following:
        'A' denotes an Agent expression.  Argument must be a function
            that accepts an argument of type ANY and returns a STRING.
        'B' denotes a BOOLEAN expression
            This shows as "True" or "False"
        'b' denotes a BINARY INTEGER expression
            This shows as ones and zeroes
        'c' denotes a single CHARACTER
        'd' denotes a DECIMAL INTEGER expression
            Type specifier can be preceded by a delimiter character
            with which to separate groups of 3 adjacent digits (thousands).
            Alignment characters cannot be uses a delimiters.
        'f' denotes a REAL or DOUBLE expression
            Field width for floating point values
            are given in the form:
             <overall_width>"."<right_width>
             Where overall_width is the minimum
             width of the entire representation,
             and <right_width> is the width for
             the fractional part (a.k.a. precision)
             A precision of 0 results in a whole number
             representation, without decimal point
             (effectively rounded to integer)
        'L' denotes a list (or any container)
            Type specifier can be preceded by a delimiter character
            with which to separate list items (default is blank).
            Alignment characters cannot be used a delimiters.
            In place of a delimiter, the agent flag ('~') can be used.
            In that case, the argument must be a TUPLE [CONTAINER,FUNCTION]
            instead of a container alone.
        'o' denotes an OCTAL INTEGER expression
        'P' denotes a PERCENT expression (float value multiplied by 100
            and followed by a percent symbol in the output
        's' denotes character STRING
        'u' denotes an UNSIGNED DECIMAL INTEGER expression
        'x' denotes a HEXADECIMAL INTEGER expression
        
 In use, a class calls one of the printf routines with at least
 a format string and an argument list.

 The argument list contains the arguments that align (positionally) with
 the format specifiers in the format string.
 The argument list, when indeed it holds multiple arguments, can be either a
 TUPLE or a proper descendent of FINITE.

 Clients wishing access to the printf functions should inherit
 the AEL_PRINTF class.  It is also possible to instantiate the
 AEL_PF_FORMATTING_ROUTINES class for use as a supplier.
	}")
   end

end -- class AEL_PF_FORMATTING_CONSTANTS

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
--| 008 23-Feb-2013
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
--| 007 03-Apr-2011
--|     Added default_printf_thousands_delimiter and related routines 
--|     to support non-default separators when grouping decimals.
--| 006 25-Aug-2010
--|     Change export of funcs and errors to AEL_PRINTF (see ael_printf.e)
--| 005 28-Jul-2009
--|     Compiled and tested using Eiffel 6.2 and 6.4
--|----------------------------------------------------------------------
--| How-to
--|
--| This class is used by AEL_PRINTF and need not be addressed directly
--|----------------------------------------------------------------------
