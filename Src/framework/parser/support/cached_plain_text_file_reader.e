note
	description: "[
		Reads a plain text file and caches it contents.

		The contents are available on a line-by-line basis and provides optimizations for
		consecutive line reads or line reads whose indexes are greater than the previous
		read.

		The cached file contents is not live so any external changes will not be reflected.
		Set `is_contents_auto_refreshed' to automatically refresh the contents when the file is
        changed.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CACHED_PLAIN_TEXT_FILE_READER

create
	make

feature {NONE} -- Initialization

	make (a_file_name: like file_name)
			-- Initialize a cached error file using a file name.
			--
			-- `a_file_name': The full path of the file to cache.
		require
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			file_name := a_file_name
			last_string := ""
		ensure
			a_file_name_set: file_name ~ a_file_name
		end

feature -- Access

	file_name: like {EIFFEL_SCANNER_SKELETON}.filename
			-- Full path to the file.

	last_string: STRING
			-- Last read string from `read_line'.

feature -- Status report

	is_contents_auto_refreshed: BOOLEAN assign set_is_contents_auto_refreshed
			-- Indicates if the `contents' is automatically refreshed when the file changes

feature -- Status setting

	set_is_contents_auto_refreshed (a_refresh: BOOLEAN)
			-- Sets automatic refreshing of the cached file contents.
			--
			-- `a_refresh': True to automatically refresh the file contents when the file is changed;
			--              False otherwise.
		do
			is_contents_auto_refreshed := a_refresh
		ensure
			is_contents_auto_refreshed_set: is_contents_auto_refreshed = a_refresh
		end

feature -- Query

	read_line (a_line: INTEGER)
			-- Reads a line from the cached file.
			--
			-- `a_line': The line of the file to read, with affecting the current state.
		require
			a_line_positive: a_line > 0
		local
			l_contents: like contents
			l_current_line: INTEGER
			nb, l_start_pos, l_end_pos: INTEGER
			l_buffer: detachable STRING
		do
			l_contents := contents
			nb := l_contents.count
			if nb > 0 then
					-- Only do some processing if the file is not empty.
				if last_read_line = a_line then
						-- Nothing to do, client has requested the same line, so same answer.
					l_buffer := last_string
				else
					if last_read_line > a_line then
							-- Requested line is greater than what we last recorded,
							-- we have to start from the beginning.
						reset
					else
							-- We resume from where we left off.
					end
					l_current_line := last_read_line

						-- Read the file up to the requested line.
					l_start_pos := last_read_position
					if l_start_pos = nb then
							-- Nothing more to read here as `last_read_position' corresponds to
							-- the final %N of the file. We will return an empty string.
					else
							-- There is still something to read, we start from the last read position.
						check
							not_past_the_end: l_start_pos < nb
						end
						from
								-- We had done a read_line before, therefore the value of `l_start_pos' which
								-- is the `last_read_position' position of the %N for the end of the previous
								-- `last_read_line' line found. So we start our search by incrementing by one.
							l_start_pos := l_start_pos + 1
						until
							l_end_pos = nb or l_current_line = a_line
						loop
							l_current_line := l_current_line + 1
								-- Find next occurrence of '%N'
							l_end_pos := l_contents.index_of ('%N', l_start_pos)
								-- Because `contents' states that it is always terminated by a %N character.
							check always_found: l_end_pos > 0 end
							if l_current_line < a_line then
									-- We are still in need of reading more lines. So let's prepare ourselves
									-- by setting `l_start_pos' at the beginning of the next
									-- line.
								l_start_pos := l_end_pos + 1
							end
						end

						if l_current_line < a_line then
								-- We hit the end of the file without matching the requested `a_line'.
								-- We preserve the previous state and return an empty string.
						else
								-- Store our new state and return the corresponding line.
							last_read_line := l_current_line
							last_read_position := l_end_pos
								-- We do `l_end_pos - 1' to remove the %N of the end of the line.
							l_buffer := l_contents.substring (l_start_pos, l_end_pos - 1)
						end
					end
				end
			end
			if l_buffer = Void then
				create last_string.make_empty
			else
				last_string := l_buffer
			end
		ensure
			last_string_attached: last_string /= Void
		end

	peeked_read_line (a_line: INTEGER): detachable STRING
			-- Tries to read a line without affecting any cached state.
			--
			-- `a_line': The line of the file to read, with affecting the current state.
			-- `Result': A read line or Void if the line requested was greater than the
			--           number in the cached file.
		require
			a_line_positive: a_line > 0
		local
			l_pos: like last_read_position
			l_lines: like last_read_line
			l_string: like last_string
		do
			l_pos := last_read_position
			l_lines := last_read_line
			l_string := last_string

			read_line (a_line)
			Result := last_string

			last_read_position := l_pos
			last_read_line := l_lines
			last_string := l_string
		ensure
			last_read_position_unchanged: last_read_position = old last_read_position
			last_read_line_unchanged: last_read_line = old last_read_line
			last_string_unchanged: last_string = old last_string
		end

feature -- Basic operations

	reset
			-- Resets the cached reader to examine the cache contents from the beginning.
		do
			last_read_position := 0
			last_read_line := 0
			last_string.wipe_out
		ensure
			last_read_position_reset: last_read_position = 0
			last_read_line_reset: last_read_line = 0
			last_string_detached: last_string.is_empty
		end

feature {NONE} -- Measurement

	last_read_position: INTEGER
			-- Position of the %N character of the line `last_read_line' in Current.
			--| `0' means nothing has been read yet.

	last_read_line: INTEGER
			-- Last line number that was read so far.
			--| `0' means nothing has been read yet.

	time_stamp: INTEGER
			-- Last read time stamp.

feature {NONE} -- Implementation: Internal cache

	contents: STRING
			-- File full contents, which may differ when the file changes externally.
		local
			l_result: like internal_contents
			l_file: PLAIN_TEXT_FILE
			l_ts: like time_stamp
			l_refresh: BOOLEAN
			l_count: INTEGER
		do
			l_result := internal_contents
			l_refresh := is_contents_auto_refreshed or l_result = Void
			create l_file.make_with_name (file_name)
			if l_refresh and then l_file.exists and then l_file.is_readable then
				l_ts := time_stamp
				if l_file.date /= l_ts then
						-- File change changed and must be re-read.
					l_result := Void
				end

				if l_result = Void  then
					l_file.open_read
					l_count := l_file.count
					if l_file.count > 0 then
						l_file.read_stream (l_count)
						l_result := l_file.last_string
						if not l_result.is_empty and then l_result.item (l_result.count) /= '%N' then
								-- Always assume a final new line in a class text.
							l_result.append_character ('%N')
						end
					else
						l_result := ""
					end
					l_file.close
					internal_contents := l_result
					time_stamp := l_file.date
					reset
				end
			end

			if l_result /= Void then
				Result := l_result
			else
				create Result.make_empty
				internal_contents := Result
				time_stamp := 0
				reset
			end
		end

	internal_contents: detachable like contents
			-- Cached version of `contents'.
			-- Note: Do not use directly!

invariant
	last_read_line_non_negative: last_read_line >= 0
	last_read_position_non_negative: last_read_position >= 0
	contents_has_eol: attached internal_contents as l_contents implies l_contents.is_empty or else l_contents.item (l_contents.count) = '%N'

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

