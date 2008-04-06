indexing

	description: "Classname finder skeletons"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

feature {NONE} -- Initialization

	make is
			-- Create a new classname finder.
		do
			make_with_buffer (Empty_buffer)
			create verbatim_marker.make (Initial_verbatim_marker_size)
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

	is_partial_class: BOOLEAN
			-- Is this a partial class?

	classname: STRING
			-- Last classname found

	verbatim_marker: STRING
			-- Sequence of characters between " and [
			-- in Verbatim_string_opener

feature -- Parsing

	parse (a_file: KL_BINARY_INPUT_FILE) is
			-- Parse `a_file' and set `classname' if `a_file'
			-- contains an Eiffel class text. Void otherwise.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		local
			l_input_buffer: YY_FILE_BUFFER
		do
			classname := Void
			l_input_buffer := File_buffer
			l_input_buffer.set_file (a_file)
				-- Abstracted from 'yy_load_input_buffer' to reuse local.
			yy_set_content (l_input_buffer.content)
			yy_end := l_input_buffer.index
			yy_start := yy_end
			yy_line := l_input_buffer.line
			yy_column := l_input_buffer.column
			yy_position := l_input_buffer.position

			input_buffer := l_input_buffer
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

feature -- Update

	set_partial_class (b: BOOLEAN) is
			-- Set `is_partial_class' to `b'.
		do
			is_partial_class := b
		end

feature {NONE} -- Implementation

	File_buffer: YY_FILE_BUFFER is
			-- Parser input file buffer
		once
			create Result.make_with_size ((create {KL_STANDARD_FILES}).input, 500)
		ensure
			file_buffer_not_void: Result /= Void
		end

	is_verbatim_string_closer: BOOLEAN is
			-- Is `text' a valid Verbatim_string_closer?
		require
			-- valid_text: `text' matches regexp [ \t\r]*[\]\}][^\n"]*\"
		local
			i, j, nb: INTEGER
			found: BOOLEAN
		do
				-- Look for first character ].
				-- (Note that `text' matches the following
				-- regexp:   [ \t\r]*[\]\}][^\n"]*\"  .)
			from j := 0 until found loop
				j := j + 1
				inspect text_item (j)
				when ']', '}' then
					found := True
				else
				end
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CLASSNAME_FINDER_SKELETON

