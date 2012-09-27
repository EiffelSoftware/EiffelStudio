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

	set_client_log_proc (v: PROCEDURE [ANY, TUPLE [STRING]])
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

	pf_fmt_constants: AEL_PF_FORMATTING_CONSTANTS
		once
			create Result
		end

	last_printf_errors: LINKED_LIST [ AEL_PF_FORMAT_ERROR ]
		once
			Result := pf_fmt_constants.last_printf_errors
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
		v: detachable PROCEDURE [ANY, TUPLE [AEL_PF_FORMAT_ERROR]])
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
--| Use 'scanf' to read objects from stdin
--| Use 'fscanf' to read objects from a text file
--| Use 'sscanf' to read objects from a buffer
--|
--| Refer the README.txt file and the AEL_Printf.pdf document that
--| accompanies this class for details.
--|----------------------------------------------------------------------
