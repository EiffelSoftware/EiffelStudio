indexing
	description: "Routines to manipulate integer type masks."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class INTEGER_TYPE_MASKS

feature {NONE} -- Masks

	integer_8_mask:  INTEGER is 0x01
			-- Bit mask for INTEGER_8

	integer_16_mask: INTEGER is 0x02
			-- Bit mask for INTEGER_16

	integer_32_mask: INTEGER is 0x04
			-- Bit mask for INTEGER_32

	integer_64_mask: INTEGER is 0x08
			-- Bit mask for INTEGER_64

	natural_8_mask:  INTEGER is 0x10
			-- Bit mask for NATURAL_8

	natural_16_mask: INTEGER is 0x20
			-- Bit mask for NATURAL_16

	natural_32_mask: INTEGER is 0x40
			-- Bit mask for NATURAL_32

	natural_64_mask: INTEGER is 0x80
			-- Bit mask for NATURAL_64

feature {NONE} -- Status report

	is_one_mask (mask: INTEGER): BOOLEAN is
			-- Does `mask' represent one type mask?
		do
			if
				mask = integer_8_mask or mask = integer_16_mask or mask = integer_32_mask or mask = integer_64_mask or
				mask = natural_8_mask or mask = natural_16_mask or mask = natural_32_mask or mask = natural_64_mask
			then
				Result := true
			end
		ensure
			definition: Result =
				(mask = integer_8_mask or mask = integer_16_mask or mask = integer_32_mask or mask = integer_64_mask or
				mask = natural_8_mask or mask = natural_16_mask or mask = natural_32_mask or mask = natural_64_mask)
		end

feature {NONE} -- Evaluation

	integer_mask (s: INTEGER_8): INTEGER is
			-- Bit mask for integer type of size `s'
		require
			valid_size: s = 8 or s = 16 or s = 32 or s = 64
		do
			inspect s
			when 8 then Result := integer_8_mask
			when 16 then Result := integer_16_mask
			when 32 then Result := integer_32_mask
			when 64 then Result := integer_64_mask
			end
		ensure
			one_mask: is_one_mask (Result)
			definition:
				(s = 8 implies Result = integer_8_mask) and
				(s = 16 implies Result = integer_16_mask) and
				(s = 32 implies Result = integer_32_mask) and
				(s = 64 implies Result = integer_64_mask)
		end

	natural_mask (s: INTEGER_8): INTEGER is
			-- Bit mask for natural type of size `s'
		require
			valid_size: s = 8 or s = 16 or s = 32 or s = 64
		do
			inspect s
			when 8 then Result := natural_8_mask
			when 16 then Result := natural_16_mask
			when 32 then Result := natural_32_mask
			when 64 then Result := natural_64_mask
			end
		ensure
			one_mask: is_one_mask (Result)
			definition:
				(s = 8 implies Result = natural_8_mask) and
				(s = 16 implies Result = natural_16_mask) and
				(s = 32 implies Result = natural_32_mask) and
				(s = 64 implies Result = natural_64_mask)
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

end
