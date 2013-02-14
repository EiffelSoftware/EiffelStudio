note
	legal: "See notice at end of class."
	status: "See notice at end of class."
deferred
class RQST_HANDLER_WITH_DATA

inherit

	RQST_HANDLER

	PLATFORM

	HEXADECIMAL_STRING_CONVERTER
		export
			{NONE} all
		end

	REFACTORING_HELPER

feature {NONE} -- parsing features

	position: INTEGER;
			-- Position in parsed string

	reset_parsing
		do
			position := 1
		end

	last_string: STRING
			-- Last parsed string token

	last_integer: INTEGER
			-- Last parsed integer token

	last_natural_16: NATURAL_16
			-- Last parser natural_16 token

--	last_integer_64: INTEGER_64
--			-- Last parsed integer token

	last_pointer: POINTER
			-- Last parsed integer token						

	tokens_count: INTEGER
		do
			Result := detail.occurrences ('%U') + 1
		end

	read_string
			-- Parse string token.
		require
			-- position < detail.count and
			-- detail.substring (position, count).has ('%U')	
		local
			i: INTEGER;
		do
			i := index_of ('%U', position);
			if i = 0 then i := detail.count + 1 end;
			if i <= position then
				last_string := ""
			else
				last_string := detail.substring (position, i - 1);
			end;
			position := i + 1;
		end

	index_of (c: CHARACTER; pos: INTEGER): INTEGER
			-- position of first occurrence of c
			-- after pos (included). 0 if none
			--| should be in string
		local
			i: INTEGER
		do
			from
				i := pos
			until
				i > detail.count or Result > 0
			loop
				if detail.item (i) = c then
					Result := i
				else
					i := i + 1
				end
			end
		end

	read_integer
			-- Parse integer token.
		do
			read_string
			last_integer := last_string.to_integer
		end

	read_natural_16
			-- Parse integer token.
		do
			read_string
			last_natural_16 := last_string.to_natural_16
		end

--	read_integer_64 is
--			-- Parse integer token.
--		do
--			read_string;
--			last_integer_64 := last_string.to_integer_64;
--		end

	read_pointer
			-- Parse integer token.
		do
			read_string
			last_pointer := hex_to_pointer (last_string)
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
