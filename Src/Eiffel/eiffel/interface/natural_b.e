indexing
	description: "Internal representation of class NATURAL"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class NATURAL_B

inherit
	CLASS_B
		rename
			make as basic_make
		redefine
			actual_type
		end

create
	make

feature {NONE} -- Initialization

	make (l: like original_class; n: INTEGER) is
			-- Creation of basic class
		require
			good_argument: l /= Void
			valid_n: n = 8 or n = 16 or n =32 or n = 64
		do
			basic_make (l)
			size := n
		ensure
			size_set: size = n
		end

feature -- Property

	size: INTEGER
			-- `size' in bits of current representation of INTEGER.

feature -- Access

	actual_type: NATURAL_A is
			-- Actual integer type
		do
			inspect size
			when 8 then Result := natural_8_type
			when 16 then Result := natural_16_type
			when 32 then Result := natural_32_type
			when 64 then Result := natural_64_type
			end
		end;

invariant
	correct_size: size = 8 or size = 16 or size = 32 or size = 64

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
