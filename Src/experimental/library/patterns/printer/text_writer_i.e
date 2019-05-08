note
	description: "[
		A writer interface for outputing information to a UI.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	TEXT_WRITER_I

feature -- Output

	put_boolean (a_value: BOOLEAN)
			-- Writes a Boolean.
			--
			-- `a_value': A Boolean value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
		deferred
		end

	put_integer (a_value: INTEGER_64)
			-- Writes an integer.
			--
			-- `a_value': An integer value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
		do
			if a_value <= {INTEGER_8}.max_value then
				put_integer_8 (a_value.as_integer_8)
			elseif a_value <= {INTEGER_16}.max_value then
				put_integer_16 (a_value.as_integer_16)
			elseif a_value <= {INTEGER_32}.max_value then
				put_integer_32 (a_value.as_integer_32)
			else
				put_integer_64 (a_value)
			end
		end

	put_integer_8 (a_value: INTEGER_8)
			-- Writes a 8-bit integer.
			--
			-- `a_value': A 8-bit integer value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
		deferred
		end

	put_integer_16 (a_value: INTEGER_16)
			-- Writes a 16-bit integer.
			--
			-- `a_value': A 16-bit integer value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
		deferred
		end

	put_integer_32 (a_value: INTEGER)
			-- Writes a 32-bit integer.
			--
			-- `a_value': A 32-bit integer value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
		deferred
		end

	put_integer_64 (a_value: INTEGER_64)
			-- Writes a 64-bit integer.
			--
			-- `a_value': A 64-bit integer value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
		deferred
		end

	put_natural (a_value: NATURAL_64)
			-- Writes a natural.
			--
			-- `a_value': A natural value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
		do
			if a_value <= {NATURAL_8}.max_value then
				put_natural_8 (a_value.as_natural_8)
			elseif a_value <= {NATURAL_16}.max_value then
				put_natural_16 (a_value.as_natural_16)
			elseif a_value <= {NATURAL_32}.max_value then
				put_natural_32 (a_value.as_natural_32)
			else
				put_natural_64 (a_value)
			end
		end

	put_natural_8 (a_value: NATURAL_8)
			-- Writes a 8-bit natural.
			--
			-- `a_value': A 8-bit natural value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
		deferred
		end

	put_natural_16 (a_value: NATURAL_16)
			-- Writes a 16-bit natural.
			--
			-- `a_value': A 16-bit natural value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
		deferred
		end

	put_natural_32 (a_value: NATURAL_32)
			-- Writes a 32-bit natural.
			--
			-- `a_value': A 32-bit natural value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
		deferred
		end

	put_natural_64 (a_value: NATURAL_64)
			-- Writes a 64-bit natural.
			--
			-- `a_value': A 64-bit natural value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
		deferred
		end

	put_real_32 (a_value: REAL_32)
			-- Writes a 32-bit real.
			--
			-- `a_value': A 32-bit real value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
		deferred
		end

	put_real_64 (a_value: REAL_64)
			-- Writes a 64-bit real.
			--
			-- `a_value': A 64-bit real value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
		deferred
		end

	put_character (a_value: CHARACTER_32)
			-- Writes a character.
			--
			-- `a_value': A character value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
		do
			if a_value.is_character_8 then
				put_character_8 (a_value.to_character_8)
			else
				put_character_32 (a_value)
			end
		end

	put_character_8 (a_value: CHARACTER_8)
			-- Writes a 8-bit character.
			--
			-- `a_value': A 8-bit character value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
			a_value_printable: a_value.is_printable
		deferred
		end

	put_character_32 (a_value: CHARACTER_32)
			-- Writes a 32-bit character.
			--
			-- `a_value': A 32-bit character value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
		deferred
		end

	put_string (a_value: READABLE_STRING_GENERAL)
			-- Writes a string.
			--
			-- `a_value': A string value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
			a_value_attached: a_value /= Void
		do
			if attached {READABLE_STRING_32} a_value as l_str then
				put_string_32 (l_str)
			elseif attached {READABLE_STRING_8} a_value as l_str then
				put_string_8 (l_str)
			else
				put_string_32 (a_value.to_string_32)
			end
		end

	put_string_8 (a_value: READABLE_STRING_8)
			-- Writes a 8-bit string.
			--
			-- `a_value': A 8-bit string value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
			a_value_attached: a_value /= Void
		deferred
		end

	put_string_32 (a_value: READABLE_STRING_32)
			-- Writes a 32-bit string.
			--
			-- `a_value': A 32-bit string value to write.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
			a_value_attached: a_value /= Void
		deferred
		end

	new_line
			-- Writes a new line.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
		deferred
		end

feature -- Basic operations

	flush
			-- Flushes any buffered content.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			is_writable: is_writable
		deferred
		end

feature -- Status report

	is_writable: BOOLEAN
			-- Determines if writer can be written to.
		deferred
		end

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

end -- class {TEXT_PRINTER}
