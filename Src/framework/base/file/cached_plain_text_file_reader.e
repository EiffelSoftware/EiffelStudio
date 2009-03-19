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
		ensure
			a_file_name_set: file_name ~ a_file_name
		end

feature -- Access

	file_name: STRING
			-- Full path to the file.

	last_string: detachable STRING
			-- Last read string from `read_line'.

	contents: STRING
			-- File full contents, which may differ when the file changes externally.
		local
			l_result: like internal_contents
			l_file: PLAIN_TEXT_FILE
			l_ts: like time_stamp
			l_refresh: BOOLEAN
		do
			l_result := internal_contents
			l_refresh := is_contents_auto_refreshed or l_result = Void
			create l_file.make (file_name)
			if l_refresh and then l_file.exists and then l_file.is_readable then
				l_ts := time_stamp
				if l_file.date /= l_ts then
						-- File change changed and must be re-read.
					l_result := Void
				end

				if l_result = Void  then
					l_file.open_read
					l_file.read_stream (l_file.count)
					l_result := l_file.last_string
					l_file.close
						-- Per postcondition of `l_file.read_stream'
					check l_result_attached: l_result /= Void end
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

feature -- Measurement

	position: INTEGER
			-- Position read in file.

	read_lines: INTEGER
			-- Number of lines read up to `position'.

feature {NONE} -- Measurement

	time_stamp: INTEGER
			-- Last read time stamp.

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

	peek_read_line (a_line: INTEGER): detachable STRING
			-- Tries to read a line without affecting any cached state.
			--
			-- `a_line': The line of the file to read, with affecting the current state.
			-- `Result': A read line or Void if the line requested was greater than the
			--           number in the cached file.
		require
			a_line_positive: a_line > 0
		local
			l_pos: like position
			l_lines: like read_lines
			l_string: like last_string
			l_contents: like internal_contents
		do
			l_pos := position
			l_lines := read_lines
			l_string := last_string
			l_contents := internal_contents
			if l_contents = Void then
				l_contents := contents
			end

			read_line (a_line)
			Result := last_string

			position := l_pos
			read_lines := l_lines
			last_string := l_string
			internal_contents := l_contents
		ensure
			position_unchanged: position = old position
			read_lines_unchanged: read_lines = old read_lines
			last_string_unchanged: last_string ~ old last_string
			internal_contents_unchanged: (old internal_contents /= Void) implies internal_contents ~ old internal_contents
		end

feature -- Basic operations

	reset
			-- Resets the cached reader to examine the cache contents from the beginning.
		do
			position := 0
			read_lines := 0
			last_string := Void
		ensure
			position_reset: position = 0
			read_lines_reset: read_lines = 0
			last_string_detached: last_string = Void
		end

	read_line (a_line: INTEGER)
			-- Reads a line from the cached file.
			--
			-- `a_line': The line of the file to read, with affecting the current state.
		require
			a_line_positive: a_line > 0
		local
			l_contents: like contents
			l_lines: INTEGER
			l_read_lines: INTEGER
			l_start_pos: INTEGER
			l_buffer: detachable STRING
			l_count, i: INTEGER
			c: CHARACTER
		do
			l_contents := contents
			l_read_lines := read_lines
			if (l_read_lines = a_line and then last_string = Void) or else l_read_lines > a_line then
					-- Need to re-read because the last string is Void
				reset
				l_read_lines := 0
			end
			if a_line > read_lines then
					-- Read the file up to the requested line.
				l_count := l_contents.count
				if l_count > position then
					l_start_pos := 1
					from
						i := position + 1
						l_lines := l_read_lines.max (1)
					until
						i > l_count or l_lines = a_line + 1
					loop
						c := l_contents.item (i)
						if c = '%N' then
							l_lines := l_lines + 1
							if a_line > 1 then
									-- `l_start_pos' has already been set to '1' for requested line 1 so this code
									-- does not need to be executed for the first line.
								if l_lines = a_line then
										-- Set the start position.
									l_start_pos := i + 1
									i := i + 1
								elseif l_lines < a_line then
									i := i + 1
								end
							end
						else
							i := i + 1
						end
					end
					if i <= l_count then
						read_lines := l_lines - 1

						position := i - 1
						if l_start_pos <= i then
							i := i - 1
							if l_start_pos <= i then
								l_buffer := l_contents.substring (l_start_pos, i)
							else
									-- The line is empty
								create l_buffer.make_empty
							end
						end
					end
					last_string := l_buffer
				end
			else
					-- Do nothing because there is not enought lines
				check last_string_detached: last_string = Void end
			end
		ensure
			read_lines_increased: last_string /= Void implies read_lines >= a_line
		end

feature {NONE} -- Implementation: Internal cache

	internal_contents: detachable like contents
			-- Cached version of `contents'.
			-- Note: Do not use directly!

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

