--|----------------------------------------------------------------------
--| Copyright (c) 1995-2009, All rights reserved by
--| Amalasoft Corporation
--| 273 Harwood Avenue
--| Littleton, MA 01460 USA 
--|
--| See additional information at bottom of file
--|----------------------------------------------------------------------
--| Description
--|
--| A class containing routines to interface with the shared error list
--|----------------------------------------------------------------------

class AEL_PF_FORMAT_ERROR_SUPPORT

inherit
	AEL_PF_FORMATTING_CONSTANTS

 --|========================================================================
feature -- Error setting
 --|========================================================================

	add_arg_count_error (
		fmt: STRING; pos: INTEGER; num_params, num_args: INTEGER)
			-- Create a new format error with the given
			-- values and add it to the last_errors list
		require
			format_exists: fmt /= Void
			valid_position: pos > 0 and pos <= fmt.count
			valid_counts: num_params >= 0 and num_args >= 0
		do
			add_error (fmt, pos)
			last_printf_errors.last.set_arg_count_error (num_params, num_args)
		end

	--|--------------------------------------------------------------

	add_unknown_type_error (fmt: STRING; pos: INTEGER; tc: CHARACTER)
			-- Create a new format error with the given
			-- values and add it to the last_printf_errors list
		require
			format_exists: fmt /= Void
			valid_position: pos > 0 and pos <= fmt.count
		do
			add_error (fmt, pos)
			last_printf_errors.last.set_unknown_type_error (tc)
		end

	--|--------------------------------------------------------------

	add_arg_type_error (fmt: STRING; pos: INTEGER; exp, act: STRING)
			-- Create a new format error with the given
			-- values and add it to the last_printf_errors list
		require
			format_exists: fmt /= Void
			valid_position: pos > 0 and pos <= fmt.count
			expected_exists: exp /= Void
			actual_exists: act /= Void
		do
			add_error (fmt, pos)
			last_printf_errors.last.set_arg_type_error (exp, act)
		end

	--|--------------------------------------------------------------

	add_internal_error (fmt: STRING; pos: INTEGER; msg: STRING)
			-- Create a new format internal error with the given
			-- values and add it to the last_printf_errors list
		require
			format_exists: fmt /= Void
			valid_position: pos > 0 and pos <= fmt.count
		do
			add_error (fmt, pos)
			if msg /= Void then
				last_printf_errors.last.set_internal_error (msg)
			end
		end

 --|========================================================================
feature {NONE} -- Implementation
 --|========================================================================

	add_error (fmt: STRING; pos: INTEGER)
			-- Create a new format error with the given
			-- values and add it to the last_printf_errors list
		require
			format_exists: fmt /= Void
			valid_position: pos > 0 and pos <= fmt.count
		do
			last_printf_errors.extend (create {AEL_PF_FORMAT_ERROR}.make(fmt,pos))
			if attached printf_client_error_agent as pca then
				pca.call ([last_printf_errors.last])
			end
		ensure
			added: last_printf_errors.count = old last_printf_errors.count + 1
		end

end -- class AEL_PF_FORMAT_ERROR_SUPPORT

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
--| 005 28-Jul-2009
--|     Compiled and tested using Eiffel 6.2 and 6.4
--|----------------------------------------------------------------------
--| How-to
--|
--| This class is used by AEL_PRINTF and need not be addressed directly
--|----------------------------------------------------------------------
