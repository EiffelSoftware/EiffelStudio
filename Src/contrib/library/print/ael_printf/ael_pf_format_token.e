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
--| Token within a format string
--|----------------------------------------------------------------------

class AEL_PF_FORMAT_TOKEN

create
	make, make_from_string

--|========================================================================
feature {NONE} -- Creation
--|========================================================================

	make (p: INTEGER)
		do
			create string_value.make (16)
			core_make (p)
		end

	make_from_string (v: STRING; p: INTEGER; tf: BOOLEAN)
		do
			string_value := v
			core_make (p)
		end

	core_make (p: INTEGER)
		do
			position := p
		end

 --|========================================================================
feature
 --|========================================================================

	string_value: STRING
			-- Whole original token string

	position: INTEGER
			-- Position in stream where token starts

	format: detachable AEL_PF_FORMAT_PARAM

	is_format: BOOLEAN
			-- Is the token a format specifier?
		do
			Result := format /= Void
		end

	is_empty: BOOLEAN
		do
			Result := string_value.is_empty
		end

	has_format_error: BOOLEAN
		local
			tf: like format
		do
			tf := format
			Result := tf /= Void and then tf.has_format_error
		end

--|========================================================================
feature -- Value setting
--|========================================================================

	set_format (v: like format)
		do
			format := v
		end

	set_string_value (v: STRING)
		do
			string_value := v
		end

	set_position (v: INTEGER)
		do
			position := v
		end

	extend (v: CHARACTER)
		do
			string_value.extend (v)
		end

end -- class AEL_PF_FORMAT_TOKEN

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
