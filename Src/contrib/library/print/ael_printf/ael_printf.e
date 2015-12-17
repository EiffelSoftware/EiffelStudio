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
--| Primary interface into the ael_printf cluster
--|----------------------------------------------------------------------

class AEL_PRINTF

 --|========================================================================
feature -- Formatting
 --|========================================================================

	aprintf (fmt: STRING; args: detachable ANY): STRING
			-- A new string object formatted according to
			-- the given format 'fmt' and arguments 'args'
			-- 'args' can be a TUPLE, a data structure conforming to
			-- FINITE, or, if no arguments are needed, simply Void
		require
			format_string_exists: fmt /= Void
		do
			create Result.make (128)
			Result.append (printf_fmt_funcs.pf_formatted (fmt, args))
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	fprintf (f: FILE; fmt: STRING; args: detachable ANY)
			-- Write to the end of given open FILE a string formatted
			-- according to the given format 'fmt' and arguments 'args'
			-- 'args' can be a TUPLE, a data structure conforming to
			-- FINITE, or, if no arguments are needed, simply Void
		require
			exists: f /= Void
			file_exists: f.exists
			file_is_open: f.is_open_write or f.is_open_append
			format_string_exists: fmt /= Void
		do
			f.put_string (printf_fmt_funcs.pf_formatted (fmt, args))
		end

	--|--------------------------------------------------------------

	printf (fmt: STRING; args: detachable ANY)
			-- Write to the standard output a string formatted
			-- according to the given format 'fmt' and arguments 'args'
			-- 'args' can be a TUPLE, a data structure conforming to
			-- FINITE, or, if no arguments are needed, simply Void
		require
			format_string_exists: fmt /= Void
		do
			print (printf_fmt_funcs.pf_formatted (fmt, args))
		end

	--|--------------------------------------------------------------

	sprintf (buf, fmt: STRING; args: detachable ANY)
			-- Replace the given STRING 'buf''s contents
			-- with a string formatted according to
			-- the format 'fmt' and arguments 'args'
			-- 'args' can be a TUPLE, a data structure conforming to
			-- FINITE, or, if no arguments are needed, simply Void
		require
			buffer_exists: buf /= Void
			format_string_exists: fmt /= Void
		do
			buf.wipe_out
			buf.append (printf_fmt_funcs.pf_formatted (fmt, args))
		end

	--|--------------------------------------------------------------

	axdump (buf, opt: STRING; ss, es, sa, cs: INTEGER): STRING
			-- Hex dump of buffer 'buf' with options 'opt'
			--
			-- 'opt' can contain 0 or more characters denoting output 
			-- options
			--
			-- If included, 'A' denotes "DO NOT show ASCII chars at line 
			-- end"
			-- If included, 'a' denotes "show ASCII chars at line end"
			--   Default, included for completeness
			-- If included, 'd' denotes "show addresses as decimal"
			--   Default, included for completeness
			-- If included, 'w' denotes "wide format"
			--   64 byte sequences (default is 16)
			-- If included, 'x' denotes "show addresses as hexadecimal"
			--   Default is to show addressed in decimal
			--
			-- 'ss' and 'es' are start and end sequence numbers to 
			-- included in Result.  By default, output includes all 
			-- sequences in 'buffer'
			-- If 'ss' = 0, then the assumed start is '1'
			-- If 'es' = 0 then end is end of the buffer
			-- If 'es' is greater than the total number of sequence, 
			-- then end is the end of the bugger
			--
			-- 'sa' is the starting address to associate with position 0
			--
			-- If 'cs' is positive, then add a blank line every 
			-- 'cs' sequences (cs<=0 suppresses line insertion)
		require
			valid_buffer: buf /= Void and then not buf.is_empty
		local
			xd: AEL_PF_HEXDUMP
		do
			create xd.make_with_string (buf)
			Result := xd.to_string (ss, es, opt, sa, cs)
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	amemdump (p: POINTER; sz: INTEGER; opt: STRING; sa, cs: INTEGER): STRING
			-- Hex dump of memory locations starting at address 'p' and 
			-- continuing for 'sz' bytes
			--
			-- 'opt' conveys formatting options
			-- 'opt' can contain 0 or more characters
			--
			-- If included, 'A' denotes "DO NOT show ASCII chars at line 
			-- end"
			-- If included, 'a' denotes "show ASCII chars at line end"
			--   Default, included for completeness
			-- If included, 'd' denotes "show addresses as decimal"
			--   Default, included for completeness
			-- If included, 'w' denotes "wide format"
			--   64 byte sequences (default is 16)
			-- If included, 'x' denotes "show addresses as hexadecimal"
			--   Default is to show addressed in decimal
			--
			-- 'sa' is the starting address to associate with position 0
			--
			-- If 'cs' is positive, then add a blank line every 
			-- 'cs' sequences (cs<=0 suppresses line insertion)
		require
			valid_address: p /= Default_pointer
			valid_size: sz > 0
		local
			xd: AEL_PF_HEXDUMP
		do
			create xd.make_with_addr (p, sz)
			Result := xd.to_string (0, 0, opt, sa, cs)
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	lxdump (buf, opt: STRING; ss, es, sa: INTEGER): LINKED_LIST [ARRAY [STRING]]
			-- Hex dump of buffer 'buf' in the form of a list of rows of
			-- strings, each with 3 sections
			-- For use by list-oriented user interfaces
			--
			-- 'ss' and 'es' are start and end sequence numbers to 
			-- included in Result.  By default, output includes all 
			-- sequences in 'buf'
			-- If 'es' = 0 then end is last sequence in buffer
			--
			-- 'opt' can contain 0 or more characters denoting output 
			-- options
			--
			-- If included, 'd' denotes "show addresses as decimal"
			--   Default, included for completeness
			-- If included, 'w' denotes "wide format"
			--   64 byte sequences (default is 16)
			-- If included, 'x' denotes "show addresses as hexadecimal"
			--   Default is to show addressed in decimal
			-- 'sa' is the starting address to associate with position 0
			--
		require
			valid_buffer: buf /= Void and then not buf.is_empty
		local
			xd: AEL_PF_HEXDUMP
		do
			create xd.make_with_string (buf)
			Result := xd.to_list (ss, es, sa, opt)
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	lmemdump (p: POINTER; sz: INTEGER; opt: STRING; ss, es, sa: INTEGER)
						: LINKED_LIST [ARRAY [STRING]]
			-- Hex dump of memory locations starting at address 'p' and 
			-- continuing for 'sz' bytes, in the form of a list of rows 
			-- or strings, each with 3 sections (position, values, ascii 
			-- chars)
			--
			-- For use by list-oriented user interfaces
			--
			-- 'ss' and 'es' are start and end sequence numbers to 
			-- included in Result.  By default, output includes all 
			-- sequences in 'buf'
			-- If 'es' = 0 then end is last sequence in buffer
			--
			-- 'opt' conveys formatting options
			-- 'opt' can contain 0 or more characters
			--
			-- If included, 'A' denotes "DO NOT show ASCII chars at line 
			-- end"
			-- If included, 'a' denotes "show ASCII chars at line end"
			--   Default, included for completeness
			-- If included, 'd' denotes "show addresses as decimal"
			--   Default, included for completeness
			-- If included, 'w' denotes "wide format"
			--   64 byte sequences (default is 16)
			-- If included, 'x' denotes "show addresses as hexadecimal"
			--   Default is to show addressed in decimal
			-- 'sa' is the starting address to associate with position 0
			--
		require
			valid_address: p /= Default_pointer
			valid_size: sz > 0
		local
			xd: AEL_PF_HEXDUMP
		do
			create xd.make_with_addr (p, sz)
			Result := xd.to_list (ss, es, sa, opt)
		ensure
			exists: Result /= Void
		end

--|========================================================================
feature -- Convenience function
--|========================================================================

	print_line, printline (some_text: detachable ANY)
			-- Print terse external representation of 'some_text'
			-- on standard output, followed by a newline character
		do
			if some_text /= Void then
				io.put_string (some_text.out)
			end
			io.new_line
		end

--|========================================================================
feature -- Debug assistance
--|========================================================================

	set_client_log_proc (v: PROCEDURE [STRING])
			-- Set the procedure to call to log a message for the client
			-- For debugging support only
		do
			pf_fmt_constants.client_log_proc_cell.put (v)
		end

 --|========================================================================
feature -- Error Status
 --|========================================================================

	last_printf_successful: BOOLEAN
			-- Was the most recent printf operation a success?
		do
			Result := last_printf_errors.is_empty
		ensure
			no_false_positive: Result implies last_printf_errors.is_empty
			no_misses: (not Result) implies not last_printf_errors.is_empty
			positive_inverse: (not last_printf_errors.is_empty) implies not Result
			negative_inverse: last_printf_errors.is_empty implies Result
		end

	--|--------------------------------------------------------------

	last_printf_error_out: STRING
			-- Description from most recent error (if any)
		local
			te: like last_printf_error
		do
			te := last_printf_error
			if te = Void then
				Result := ""
			else
				Result := te.description
			end
		ensure
			exists: Result /= Void
		end

	--|--------------------------------------------------------------

	last_printf_error: detachable AEL_PF_FORMAT_ERROR
			-- Most recent error, from most recent operation
			-- Void if no errors occurred
		do
			if not last_printf_errors.is_empty then
				Result := last_printf_errors.last
			end
		end

	last_printf_errors: LINKED_LIST [ AEL_PF_FORMAT_ERROR ]
		once
			Result := pf_fmt_constants.last_printf_errors
		end

--|========================================================================
feature {NONE} -- Constants and shared resources
--|========================================================================

	pf_fmt_constants: AEL_PF_FORMATTING_CONSTANTS
		once
			create Result
		end

	printf_fmt_funcs: AEL_PF_FORMATTING_ROUTINES
		once
			Result := pf_fmt_constants.printf_fmt_funcs
		end

--|========================================================================
feature -- Global status setting
--|========================================================================

	set_default_printf_fill_char (v: CHARACTER)
			-- Change the fill character from blank to 
			-- the given new value for ALL subsequent 
			-- printf calls in this thread space
		do
			pf_fmt_constants.set_default_printf_fill_char (v)
		end

	reset_default_printf_fill_char
			-- Reset the default fill character to blank
		do
			pf_fmt_constants.reset_default_printf_fill_char
		end

	--|--------------------------------------------------------------

	set_default_printf_decimal_separator (v: CHARACTER)
			-- Change the character used to denote the decimal point
			-- to 'v' for ALL subsequent printf calls in this thread space
		do
			pf_fmt_constants.set_decimal_separator (v)
		end

	reset_default_printf_decimal_separator
			-- Reset the character used to denote the decimal point
		do
			pf_fmt_constants.reset_decimal_separator
		end

	--|--------------------------------------------------------------

	set_default_printf_list_delimiter (v: STRING)
			-- Change the default list delimiter string from a single
			-- blank character to the given string for ALL subsequent 
			-- printf calls in this thread space
		do
			pf_fmt_constants.set_default_printf_list_delimiter (v)
		end

	reset_default_printf_list_delimiter
			-- Reset the default list delimiter string
		do
			pf_fmt_constants.reset_default_printf_list_delimiter
		end

	--|--------------------------------------------------------------

	set_default_printf_thousands_delimiter (v: STRING)
			-- Change the default thousands delimiter string from an
			-- empty string to the given string for ALL subsequent 
			-- printf calls (in this thread space)
		do
			pf_fmt_constants.set_default_printf_thousands_delimiter (v)
		end

	reset_default_printf_thousands_delimiter
			-- Reset the default thousands delimiter string
		do
			pf_fmt_constants.reset_default_printf_thousands_delimiter
		end

	set_printf_client_error_agent (
		v: detachable PROCEDURE [AEL_PF_FORMAT_ERROR])
			-- Set the procedure to call upon encountering a format error
		do
			pf_fmt_constants.set_printf_client_error_agent (v)
		end

end -- class AEL_PRINTF

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
--| 008 14-Nov-2012
--|     Added axdump, amemdump, lxdump and lmemdump routines
--|     Compiled and tested with Eiffel Studio 7.1
--| 007 03-Apr-2011
--|     Added front-ends to the functions for setting global values 
--|     like delimiters, pad characters and error notification agent.
--| 006 25-Aug-2010
--|     Removed inherit of AEL_PF_FORMATTING_CONSTANTS and replaced 
--|     with local onces for funcs and errors
--| 005 28-Jul-2009
--|     Compiled and tested using Eiffel 6.2 and 6.4
--|----------------------------------------------------------------------
--| How-to
--|
--| Either inherit this class or create an instance of it w/ 
--| default_create
--| Use 'printf' to print formatted output to stdout
--| Use 'aprintf' to generate a formatted string
--| Use 'fprintf' to write formatted output to a file
--| Use 'sprintf' to write formatted output into a buffer
--|
--| Use 'print_line' to write a value to stdout, followed by a newline
--|
--| Refer the README.txt file and the AEL_Printf.pdf document that
--| accompany this class for details.
--|----------------------------------------------------------------------
