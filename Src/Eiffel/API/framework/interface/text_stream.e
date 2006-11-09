indexing
	description: "[
		Interface for sending output to a writeable stream.
		
		Note: {TEXT_STREAM}s are instatiate or retrieved using the {TEXT_STREAM_PROVIDER}. {COMPILER} provides
		access to a {TEXT_STREAM_PROVIDER} via its `text_stream_provider' access call. Alternatively query for
		the {{TEXT_STREAM_PROVIDER} service from an accessible service provider.
		
		Descendent are free to add additional output feature that may be used in external tools.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	TEXT_STREAM

inherit
	TEXT_STREAM_ACCESS
		export
			{NONE} all
		end

feature -- Output

	put_integer_8 (i: INTEGER_8) is
			-- Writes integer `i' to stream
		require
			is_writable_stream: is_stream_writable
		deferred
		end

	put_integer_16 (i: INTEGER_16) is
			-- Writes integer `i' to stream
		require
			is_writable_stream: is_stream_writable
		deferred
		end

	put_integer_32 (i: INTEGER_32) is
			-- Writes integer `i' to stream
		require
			is_writable_stream: is_stream_writable
		deferred
		end

	put_integer_64 (i: INTEGER_64) is
			-- Writes integer `i' to stream
		require
			is_writable_stream: is_stream_writable
		deferred
		end

	put_natural_8 (n: NATURAL_8) is
			-- Writes natural `n' to stream
		require
			is_writable_stream: is_stream_writable
		deferred
		end

	put_natural_16 (n: NATURAL_16) is
			-- Writes natural `n' to stream
		require
			is_writable_stream: is_stream_writable
		deferred
		end

	put_natural_32 (n: NATURAL_32) is
			-- Writes natural `n' to stream
		require
			is_writable_stream: is_stream_writable
		deferred
		end

	put_natural_64 (n: NATURAL_64) is
			-- Writes natural `n' to stream
		require
			is_writable_stream: is_stream_writable
		deferred
		end

	put_character_8 (c: CHARACTER_8) is
			-- Writes a character `c' to stream
		require
			c_is_printable: c.is_printable
			is_writable_stream: is_stream_writable
		deferred
		end

	put_character_32 (c: CHARACTER_32) is
			-- Writes a character `c' to stream
		require
--			c_is_printable: c.is_printable
			is_writable_stream: is_stream_writable
		deferred
		end

	put_string_8 (a_str: STRING_8) is
			-- Writes a string `a_str' to stream
		require
			a_str_attached: a_str /= Void
			is_writable_stream: is_stream_writable
		deferred
		end

	put_string_32 (a_str: STRING_32) is
			-- Writes a string `a_str' to stream
		require
			a_str_attached: a_str /= Void
			is_writable_stream: is_stream_writable
		deferred
		end

	new_line is
			-- Writes a new line to stream
		require
			is_writable_stream: is_stream_writable
		deferred
		end

feature -- Output

	frozen put_integer (i: INTEGER) is
			-- Writes integer `i' to stream
		require
			is_writable_stream: is_stream_writable
		do
			put_integer_32 (i)
		end

	frozen put_natural (n: NATURAL) is
			-- Writes natural `n' to stream
		require
			is_writable_stream: is_stream_writable
		do
			put_natural_32 (n)
		end

	frozen put_character (c: CHARACTER) is
			-- Writes a character `c' to stream
		require
			c_is_printable: c.is_printable
			is_writable_stream: is_stream_writable
		do
			put_character_8 (c)
		end

	frozen put_string (a_str: STRING) is
			-- Writes a string `a_str' to stream
		require
			a_str_attached: a_str /= Void
			is_writable_stream: is_stream_writable
		do
			put_string_8 (a_str)
		end

feature -- Status report

	is_stream_writable: BOOLEAN is
			-- Indiciates if stream is currently writable
		once
			Result := True
		end

feature -- Basic operations

	flush is
			-- Flushes any cached content to stream
		do
			--| Does nothing by default
		end

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

end -- class {TEXT_STREAM}
