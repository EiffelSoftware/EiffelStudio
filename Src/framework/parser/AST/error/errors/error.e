note
	description: "Representation of a compiler error (either syntax or semantics)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ERROR

inherit
	ANY

	SHARED_ENCODING_CONVERTER
		export
			{NONE} all
		end

	SYSTEM_ENCODINGS
		export
			{NONE} all
		end

feature -- Access

	line: INTEGER
			-- Line number involved in error

	column: INTEGER
			-- Column number involved in error

	file_name: like {EIFFEL_SCANNER_SKELETON}.filename
			-- Path to file involved in error.
			-- Could be Void if not a file specific error.
		require
			has_associated_file: has_associated_file
		deferred
		ensure
			file_name_not_void: Result /= Void
		end

	associated_class: like associated_class_type
			-- Associate class, if any

	help_file_name: STRING
			-- Associated file name where error explanation is located.
		do
			Result := code
		ensure
			help_file_name_not_void: Result /= Void
		end

	help_uuid: detachable READABLE_STRING_32
			-- UUID of the page with explanations of the error/warning.
		do
		ensure
			is_uuid: attached Result implies {UUID}.is_valid_uuid (Result)
		end

feature {NONE} -- Typing

	associated_class_type: detachable ABSTRACT_CLASS_C
			-- An anchor to be used for `associated_class`.
		require
			callable: False
		do
		ensure
			not_called: False
		end

feature {NONE} -- Access: File source caching

	cached_file: attached CELL [detachable CACHED_PLAIN_TEXT_FILE_READER]
			-- Cached file
		require
			has_associated_file
		once
			create Result.put (Void)
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

	has_source_text: BOOLEAN
			-- Did we get the source text?
		do
			Result := current_line /= Void
		end

	frozen initialize_output
			-- Set `previous_line', `current_line' and `next_line' with their proper values
			-- taken from file `file_name'.
		require
			file_name_not_void: file_name /= Void
		local
			l_line: INTEGER
			l_fn: like file_name
			l_file: detachable CACHED_PLAIN_TEXT_FILE_READER
			l_encoding: ENCODING
		do
			l_fn := file_name
			l_file := cached_file.item
			if not attached l_file or else not l_fn.same_string (l_file.file_name) then
					-- No file, or it has changed.
				create l_file.make (l_fn)
				l_file.set_is_contents_auto_refreshed (True)
				cached_file.put (l_file)
			end
			l_line := line
			if l_line > 1 then
				l_file.read_line (l_line - 1)
				previous_line := l_file.last_string
				current_line := l_file.peeked_read_line (l_line)
			else
				previous_line := Void
				l_file.read_line (l_line)
				current_line := l_file.last_string
			end
			next_line := l_file.peeked_read_line (l_line + 1)

				-- Convert lines read from source encoding to UTF-8
			if attached associated_class as l_class then
				l_encoding := l_class.encoding
				if not attached l_encoding then
					l_encoding := encoding_converter.default_encoding
				end
				if attached previous_line as l_pre then
					l_encoding.convert_to (utf8, l_pre)
					if l_encoding.last_conversion_successful then
						previous_line := l_encoding.last_converted_string_8
					end
				end
				if attached current_line as l_cur then
					l_encoding.convert_to (utf8, l_cur)
					if l_encoding.last_conversion_successful then
						current_line := l_encoding.last_converted_string_8
					end
				end
				if attached next_line as l_nex then
					l_encoding.convert_to (utf8, l_nex)
					if l_encoding.last_conversion_successful then
						next_line := l_encoding.last_converted_string_8
					end
				end
			end
		end

	previous_line_32: detachable STRING_32
			-- Previous line where error occurs.
		do
			if attached previous_line as l_line then
				Result := encoding_converter.utf8_to_utf32 (l_line)
			end
		end

	current_line_32: detachable STRING_32
			-- Current line where error occurs.
		do
			if attached current_line as l_line then
				Result := encoding_converter.utf8_to_utf32 (l_line)
			end
		end

	next_line_32: detachable STRING_32
			-- Next line where error occurs.
		do
			if attached next_line as l_line then
				Result := encoding_converter.utf8_to_utf32 (l_line)
			end
		end

	context_line_32: detachable STRING_32
			-- Like current line but evaluates the surrounding context line if it hasn't
			-- been determined.
		do
			if attached context_line as l_line then
				Result := encoding_converter.utf8_to_utf32 (l_line)
			end
		end

feature {NONE} -- Compute surrounding text around error

	previous_line, current_line, next_line: detachable STRING
			-- Surrounding lines where error occurs.

	context_line: detachable STRING
			-- Like `current_line' but evaluates the surrounding context line
			-- if it hasn't been determined.
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
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
