note
	description: "Output stream filter that transparently indents lines."
	copyright: "Copyright (c) 2007, Andreas Leitner and others"
	revised_by: "Alexander Kogtenkov"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_INDENTING_SOURCE_WRITER

inherit

	KI_TEXT_OUTPUT_STREAM
		redefine
			is_closable,
			put_new_line,
			close
		end

	KL_SHARED_STREAMS
		export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make (a_output_stream: like output_stream)
			-- Create a new filter, using `a_output_stream' as output stream.
		require
			a_output_stream_not_void: a_output_stream /= Void
		do
			output_stream := a_output_stream
		ensure
			output_stream_set: output_stream = a_output_stream
			indent_level_initialized: indentation = 0
		end

feature -- Status report

	is_open_write: BOOLEAN
			-- Can items be written to output stream?
		do
			Result := output_stream.is_open_write
		end

	is_closable: BOOLEAN
			-- Can current output stream be closed?
		do
			Result := output_stream.is_closable
		end

feature -- Access

	output_stream: KI_TEXT_OUTPUT_STREAM
			-- Output output stream

	indentation: INTEGER
			-- Level by which lines should be currently indented

	eol: STRING
			-- Line separator
		do
			Result := output_stream.eol
		end

	name: STRING
			-- Name of output stream
		do
			Result := output_stream.name
		end

feature -- Level Change

	indent
			-- Increase level of indentation.
		do
			indentation := indentation + 1
		ensure
			indent_level_increased: indentation = old indentation + 1
		end

	dedent
			-- Decrease level of indentation.
		require
			indent_level_big_enough: indentation > 0
		do
			indentation := indentation - 1
		ensure
			indent_level_decreased: indentation = old indentation - 1
		end

feature -- Output

	put_character (v: CHARACTER)
			-- Write `v' to output stream.
		do
			if not indentation_printed then
				print_indentation
			end
			output_stream.put_character (v)
		end

	put_new_line
			-- Write a line separator to output stream.
		do
			Precursor
			indentation_printed := False
		end

	put_string (a_string: READABLE_STRING_8)
			-- Write `a_string' to output stream.
		do
			if not indentation_printed then
				print_indentation
			end
			output_stream.put_string (a_string)
		end

feature -- Basic operations

	flush
			-- Flush buffered data to disk.
		do
			output_stream.flush
		end

	close
			-- Try to close output stream if it is closable. Set
			-- `is_open_write' to false if operation was successful.
		do
			output_stream.close
		end

feature -- Setting

	set_output_stream (a_output_stream: like output_stream)
			-- Set `output_stream' to `a_output_stream'.
		require
			a_output_stream_not_void: a_output_stream /= Void
			a_output_stream_is_open_write: a_output_stream.is_open_write
		do
			output_stream := a_output_stream
		ensure
			output_stream_set: output_stream = a_output_stream
		end

	set_null_output_stream
			-- Set `output_stream' to `null_output_stream'.
		do
			output_stream := null_output_stream
		ensure
			output_stream_set: output_stream = null_output_stream
		end

feature {NONE} -- Implementation

	print_indentation
			-- Print currentl level of indentation to `output_stream'.
		require
			not_printed: not indentation_printed
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > indentation
			loop
				output_stream.put_character ('%T')
				i := i + 1
			end
			indentation_printed := True
		ensure
			printed: indentation_printed
		end

	indentation_printed: BOOLEAN
			-- Was indentation already printed for this line?

invariant

	indent_level_not_negative: indentation >= 0
	output_stream_not_void: output_stream /= Void

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
