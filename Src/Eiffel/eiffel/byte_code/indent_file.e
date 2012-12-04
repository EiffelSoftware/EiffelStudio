note
	description: "A file with primitives for indenting."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INDENT_FILE

create
	make_open_write, make_c_code_file

feature {NONE} -- Initialization

	make_open_write, make_c_code_file (fn: PATH)
			-- Create file object with `fn' as file name
			-- and open file for writing.
			-- Create it if it does not exist.
		require
			string_exists: fn /= Void
			string_not_empty: not fn.is_empty
		do
			create file.make_with_path (fn)
			file.open_write
		end

feature -- Termination

	close
			-- Close file.
		do
			file.close
		end

feature -- Status report

	exists: BOOLEAN
			-- Does file exist?
		do
			Result := file.exists
		end

	is_open_write: BOOLEAN
			-- Is file open for writing?
		do
			Result := file.is_open_write
		end

feature {NONE} -- Status report

	tabs: INTEGER
			-- Value of indentation, in tabs

	old_tabs: INTEGER
			-- Saved indentation value

	emitted: BOOLEAN
			-- Have leading tabs already been emitted ?

feature {NONE} -- Indentation

	indent
			-- Indent next output line by one tab.
		do
			tabs := tabs + 1
		end

	exdent
			-- Remove one leading tab for next line.
		require
			valid_tabs: tabs > 0
		do
			tabs := tabs - 1
		end

	left_margin
			-- Temporary reset to left margin
		do
			old_tabs := tabs
			tabs := 0
		end

	restore_margin
			-- Restore margin value as of the one which was in
			-- use when a `left_margin' call was issued.
		do
			tabs := old_tabs
		end

	emit_tabs
			-- Emit the `tabs' leading tabs
		local
			i: INTEGER
		do
			if not emitted then
				from
					i := 1
				until
					i > tabs
				loop
					file.putchar ('%T')
					i := i + 1
				end
				emitted := true
			end
			debug ("FLUSH_FILE")
				file.flush
			end
		end

feature -- Output

	put_new_line
			-- Write new line.
		do
			file.put_new_line
		end

	new_line
			-- Write a '\n'.
		do
			file.new_line
			emitted := false
			debug ("FLUSH_FILE")
				file.flush
			end
		end

	put_character (c: CHARACTER)
			-- Write character `c'.
		do
			file.put_character (c)
		end

	putchar (c: CHARACTER)
			-- Write char `c'.
		do
			emit_tabs
			file.putchar (c)
			debug ("FLUSH_FILE")
				file.flush
			end
		end

	put_string (s: STRING)
			-- Write string `s'.
		do
			file.put_string (s)
		end

	putstring (s: STRING)
			-- Write string `s' with indentation if erquired.
		do
			emit_tabs
			file.putstring (s)
			debug ("FLUSH_FILE")
				file.flush
			end
		end

	put_integer (i: INTEGER)
			-- Write integer `i'.
		do
			file.put_integer (i)
		end

feature {NONE} -- Output

	putint (i: INTEGER)
			-- Write int `i'.
		do
			emit_tabs
			file.putint (i)
			debug ("FLUSH_FILE")
				file.flush
			end
		end

	putreal (r: REAL)
			-- Write real `r'.
		do
			emit_tabs
			file.putreal (r)
			debug ("FLUSH_FILE")
				file.flush
			end
		end

	putdouble (d: DOUBLE)
			-- Write real `d'.
		do
			emit_tabs
			file.putdouble (d)
			debug ("FLUSH_FILE")
				file.flush
			end
		end

	putoctal (i: INTEGER)
			-- Print octal representation of `i'
			--| always generate 3 digits
		local
			val, remain: INTEGER
			s, t: STRING
		do
			if i = 0 then
				file.putstring ("000")
			elseif i < 8 then
				file.putstring ("00")
				file.putint (i)
			else
				if i < 64 then
					file.putstring ("0")
				end
				create s.make (3)
				from
					val := i
				until
					val = 0
				loop
					remain := val \\ 8
					val := val // 8
					t := remain.out
					s.prepend (t)
				variant
					val + 1
				end
				file.putstring (s)
			end
			debug ("FLUSH_FILE")
				file.flush
			end
		end

	escape_char (c: CHARACTER)
			-- Write char `c' with C escape sequences
		do
				-- Assume ASCII set, sorry--RAM.
			if c < ' ' or c > '%/127/' then
				file.putstring ("\")
				putoctal (c.code)
			elseif c = '\' then
				file.putstring ("\\")
			elseif c = '%'' then
				file.putstring ("\'")
			else
				file.putchar (c)
			end
			debug ("FLUSH_FILE")
				file.flush
			end
		end

	escape_string (s: STRING)
			-- Write string `s' with escape quotes
		require
			good_argument: s /= Void
		local
			i, nb: INTEGER
			c: CHARACTER
		do
			from
				i := 1
				nb := s.count
			until
				i > nb
			loop
				c := s.item (i)
				if c = '"' then
					file.putstring ("\%"")
				elseif c = '\' then
					file.putstring ("\\")
				elseif c < ' ' or c > '%/127/' then
						-- Assume ASCII set, sorry--RAM.
					file.putstring ("\")
					putoctal (c.code)
				else
					file.putchar (c)
				end
				i := i + 1
			end
			debug ("FLUSH_FILE")
				file.flush
			end
		end

feature {NONE} -- Access

	file: PLAIN_TEXT_FILE
			-- File on which all operations are performed.

invariant
	file_attached: attached file

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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

end -- class INDENT_FILE
