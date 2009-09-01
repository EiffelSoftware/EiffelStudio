note
	description: "[
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_SIMPLE_STREAM

inherit
	IO_MEDIUM

create
	make

feature -- Initialization

		make
			do
				buf := ""
				last_string := ""
			end

feature -- Access

		buf: STRING
				-- Internal buffer. Might be better to replace it with something faster

feature -- Basic Functionality

	get_text: STRING
			-- Returns the accumulated content
		do
			Result := buf
		end

	name: detachable STRING
			-- <Precursor>
		do
			Result := "XU_SIMPLE_STREAM"
		end

	retrieved: ANY
			-- <Precursor>
		do
			Result := False
		end

feature -- Element change

	basic_store (object: ANY)
			-- <Precursor>
		do
			-- Do nothing
		end

	general_store (object: ANY)
			-- <Precursor>
		do
			-- Do nothing
		end

	independent_store (object: ANY)
			-- <Precursor>
		do
			-- Do nothing
		end

feature -- Status report

	handle: INTEGER
			-- <Precursor>
		do
			Result := 0
		end

	handle_available: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

	exists: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	is_open_read: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	is_open_write: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	is_readable: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	is_executable: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

	is_writable: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	readable: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	extendible: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	is_closed: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

	support_storable: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

feature -- Status setting

	close
			-- <Precursor>
		do
			-- Do nothing
		end

feature -- Output

	put_new_line, new_line
			-- <Precursor>
		do
			buf.append_character ('%N')
		end

	put_string, putstring (s: STRING)
			-- <Precursor>
		do
			buf.append (s)
		end

	put_character, putchar (c: CHARACTER)
			-- <Precursor>
		do
			buf.append_character (c)
		end

	put_real, putreal (r: REAL)
			-- <Precursor>
		do
			buf.append_real (r)
		end

	put_integer, putint, put_integer_32 (i: INTEGER)
			-- <Precursor>
		do
			buf.append_integer (i)
		end

	put_integer_8 (i: INTEGER_8)
			-- <Precursor>
		do
			buf.append_integer_8 (i)
		end

	put_integer_16 (i: INTEGER_16)
			-- <Precursor>
		do
			buf.append_integer_16 (i)
		end

	put_integer_64 (i: INTEGER_64)
			-- <Precursor>
		do
			buf.append_integer_64 (i)
		end

	put_natural_8 (i: NATURAL_8)
			-- <Precursor>
		do
			buf.append_natural_8 (i)
		end

	put_natural_16 (i: NATURAL_16)
			-- <Precursor>
		do
			buf.append_natural_16 (i)
		end

	put_natural, put_natural_32 (i: NATURAL_32)
			-- <Precursor>
		do
			buf.append_natural_32 (i)
		end

	put_natural_64 (i: NATURAL_64)
			-- <Precursor>
		do
			buf.append_natural_64 (i)
		end

	put_boolean, putbool (b: BOOLEAN)
			-- <Precursor>
		do
			buf.append_boolean (b)
		end

	put_double, putdouble (d: DOUBLE)
			-- <Precursor>
		do
			buf.append_double (d)
		end

	put_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER)
			-- <Precursor>
		do
			-- Do nothing
		end

feature -- Input

	read_real, readreal
			-- <Precursor>
		do
			-- Do nothing
		end

	read_double, readdouble
			-- <Precursor>
		do
			-- Do nothing
		end

	read_character, readchar
			-- <Precursor>
		do
			-- Do nothing
		end

	read_integer, readint, read_integer_32
			-- <Precursor>
		do
			-- Do nothing
		end

	read_integer_8
			-- <Precursor>
		do
			-- Do nothing
		end

	read_integer_16
			-- <Precursor>
		do
			-- Do nothing
		end

	read_integer_64
			-- <Precursor>
		do
			-- Do nothing
		end

	read_natural_8
			-- <Precursor>
		do
			-- Do nothing
		end

	read_natural_16
			-- <Precursor>
		do
			-- Do nothing
		end

	read_natural, read_natural_32
			-- <Precursor>
		do
			-- Do nothing
		end

	read_natural_64
			-- <Precursor>
		do
			-- Do nothing
		end

	read_stream, readstream (nb_char: INTEGER)
			-- <Precursor>
		do
			-- Do nothing
		end

	read_line, readline
			-- <Precursor>
		do
			-- Do nothing
		end

	read_to_managed_pointer (p: MANAGED_POINTER; start_pos, nb_bytes: INTEGER)
			-- <Precursor>
		do
			-- Do nothing
		end


note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
