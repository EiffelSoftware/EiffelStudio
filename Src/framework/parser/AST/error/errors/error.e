note
	description: "Representation of a compiler error (either syntax or semantics)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ERROR

feature -- Access

	line: INTEGER
			-- Line number involved in error

	column: INTEGER
			-- Column number involved in error

	file_name: STRING
			-- Path to file involved in error.
			-- Could be Void if not a file specific error.
		require
			has_associated_file: has_associated_file
		deferred
		ensure
			file_name_not_void: Result /= Void
		end

	associated_class: ABSTRACT_CLASS_C
			-- Associate class, if any

	help_file_name: STRING
			-- Associated file name where error explanation is located.
		do
			Result := code
		ensure
			help_file_name_not_void: Result /= Void
		end

feature {NONE} -- Access: File source caching

	last_cached_file_name: CELL [detachable STRING]
			-- File name of last cached file text
		once
			create Result.put (Void)
		end

	frozen last_cached_file_contents: attached LIST [STRING]
			-- Contents of last loaded cached file.
		require
			has_associated_file: has_associated_file
		once
			create {ARRAYED_LIST [STRING]} Result.make (0)
		end

	frozen last_cached_file_timestamp: CELL [INTEGER]
			-- Time stamp of the last cached file.
		require
			has_associated_file: has_associated_file
		once
			create Result.put (0)
		end

feature -- Properties

	code: STRING
			-- Code error
		deferred
		ensure
			code_not_void: Result /= Void
		end

	subcode: INTEGER
			-- Subcode of error. `0' if none.
		do
		end

	Error_string: STRING
		do
			Result := "Error"
		ensure
			error_string_not_void: Result /= Void
		end

feature -- Status report

	has_associated_file: BOOLEAN
			-- Is current relative to a file?
		do
		end

	is_defined: BOOLEAN
			-- Is the error fully defined?
		do
			Result := True
		end

feature -- Setting

	set_location (a_location: LOCATION_AS)
			-- Initialize `line' and `column' from `a_location'
		require
			a_location_not_void: a_location /= Void
		do
			line := a_location.line
			column := a_location.column
		ensure
			line_set: line = a_location.line
			column_set: column = a_location.column
		end

	set_position (l, c: INTEGER)
			-- Set `line' and `column' with `l' and `c'.
		require
			l_non_negative: l >= 0
			c_non_negative: c >= 0
		do
			line := l
			column := c
		ensure
			line_set: line = l
			column_set: column = c
		end

	set_associated_class (a_class: like associated_class)
			-- Set `associated_class' with `a_class'
		do
			associated_class := a_class
		ensure
			associated_class_set: associated_class = a_class
		end

feature {ERROR_VISITOR} -- Compute surrounding text around error

	previous_line, current_line, next_line: STRING
			-- Surrounding lines where error occurs.

	has_source_text: BOOLEAN
			-- Did we get the source text?
		do
			Result := current_line /= Void
		end

	context_line: STRING
			-- Like current line but evaluates the surrounding context line if it hasn't
			-- been determined.
		local
			l_count, i: INTEGER
		do
			if not has_source_text and then file_name /= Void then
				initialize_output
			end
			Result := current_line
			if Result /= Void and then not Result.is_empty then
				from
					i := 1
					l_count := Result.count
				until
					i > l_count or not Result.item (i).is_space
				loop
					i := i + 1
				end

				if i > 1 then
					if i < l_count then
						Result := Result.substring (i, l_count)
					else
						create Result.make_empty
					end
				end
			end
		end

	frozen initialize_output
			-- Set `previous_line', `current_line' and `next_line' with their proper values
			-- taken from file `file_name'.
		require
			file_name_not_void: file_name /= Void
		local
			l_file: PLAIN_TEXT_FILE
			l_line: detachable STRING
			l_fn: like file_name
			l_contents: LIST [STRING]
			l_ts: INTEGER
			l_reload: BOOLEAN
		do
			l_fn := file_name
			previous_line := Void
			current_line := Void
			next_line := Void
			create l_file.make (l_fn)
			if l_file.exists then
				if last_cached_file_name.item ~ l_fn then
						-- The last access file source has already been cached.
					l_ts := l_file.change_date
					l_reload := l_ts /= last_cached_file_timestamp.item
					if not l_reload then
						l_contents := last_cached_file_contents
					end
				else
						-- There was not cached file or the cached file differs.
					l_reload := True
				end

				if l_reload then
						-- Need to reload the file
					l_file.open_read
					l_file.readstream (l_file.count)
					l_line := l_file.last_string
					if attached l_line then
						l_contents := l_file.last_string.split ('%N')
					else
						create {ARRAYED_LIST [STRING]} l_contents.make (0)
					end
						-- Set cached information.
					last_cached_file_name.put (l_fn)
					last_cached_file_timestamp.put (l_file.change_date)
					last_cached_file_contents.wipe_out
					last_cached_file_contents.append (l_contents)
					l_file.close
				end
				check l_contents_attached: attached l_contents end

				if l_contents.count >= line then
					if line > 1 then
						previous_line := l_contents.i_th (line - 1)
					end
					current_line := l_contents.i_th (line)
					if l_contents.count >= line + 1 then
						next_line := l_contents.i_th (line + 1)
					end
				else
					create current_line.make_empty
				end
				check current_line_not_void: attached current_line end
			end
		end

feature -- Visitor

	process (a_visitor: ERROR_VISITOR)
			-- Process Current using `a_visitor'.
		require
			a_visitor_not_void: a_visitor /= Void
		deferred
		end

invariant
	non_void_code: code /= Void
	non_void_error_message: error_string /= Void
	non_void_help_file_name: help_file_name /= Void

note
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
