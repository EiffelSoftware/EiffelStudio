indexing

	description: "Classname finder skeletons"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class CLASSNAME_FINDER_SKELETON

inherit

	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton
		redefine
			fatal_error, reset
		end

	SHARED_PARSER_FILE_BUFFER
		export {NONE} all end

feature {NONE} -- Initialization

	make is
			-- Create a new classname finder.
		do
			make_with_buffer (Empty_buffer)
			!! verbatim_marker.make (Initial_verbatim_marker_size)
		end

feature -- Initialization

	reset is
			-- Reset scanner before scanning next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor {YY_COMPRESSED_SCANNER_SKELETON}
			verbatim_marker.clear_all
			input_buffer.wipe_out
		end
feature -- Access

	classname: STRING
			-- Last classname found

	verbatim_marker: STRING
			-- Sequence of characters between " and [
			-- in Verbatim_string_opener

feature -- Parsing

	parse (a_file: IO_MEDIUM) is
			-- Parse `a_file' and set `classname' if `a_file'
			-- contains an Eiffel class text. Void otherwise.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		do
			classname := Void
			File_buffer.set_file (a_file)
			input_buffer := File_buffer
			yy_load_input_buffer
			read_token
			reset
		rescue
			classname := Void
			reset
		end

feature -- Error handling

	fatal_error (a_message: STRING) is
			-- A fatal error occurred.
		do
		end

feature {NONE} -- Implementation

	is_verbatim_string_closer: BOOLEAN is
			-- Is `text' a valid Verbatim_string_closer?
		require
			-- valid_text: `text' matches regexp [ \t\r]*\][^%\n"]*\"
		local
			i, j, nb: INTEGER
			found: BOOLEAN
		do
				-- Look for first character ].
				-- (Note that `text' matches the following
				-- regexp:   [ \t\r]*\][^%\n"]*\"  .)
			from j := 1 until found loop
				if text_item (j) = ']' then
					found := True
				end
				j := j + 1
			end
			nb := verbatim_marker.count
			if nb = (text_count - j) then
				Result := True
				from i := 1 until i > nb loop
					if verbatim_marker.item (i) = text_item (j) then
						i := i + 1
						j := j + 1
					else
						Result := False
						i := nb + 1  -- Jump out of the loop.
					end
				end
			end
		end

	last_start_condition: INTEGER
			-- Start condition before entering
			-- verbatim string parsing

feature {NONE} -- Constants

	Initial_verbatim_marker_size: INTEGER is 3
			-- Initial size for `verbatim_marker'

	TE_ID: INTEGER is 300

invariant

	verbatim_marker_not_void: verbatim_marker /= Void

end -- class CLASSNAME_FINDER_SKELETON


--|----------------------------------------------------------------
--| Copyright (C) 1992-1999, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
