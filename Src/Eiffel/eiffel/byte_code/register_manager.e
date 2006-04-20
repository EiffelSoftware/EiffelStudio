indexing
	description: "Manages register allocation for a given C type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class REGISTER_MANAGER

create
	make,
	make_from_existing

feature {NONE} -- Initialization

	make is
			-- Initialize array
		do
			create registers.make (1, 10)
		end

	make_from_existing (other: like Current) is
			-- Duplicate `other' in Current
		require
			other_not_void: other /= Void
		do
			registers := other.registers.twin
			needed_registers := other.needed_registers
		ensure
			registers_set: registers.is_equal (other.registers)
			needed_registers_set: needed_registers = other.needed_registers
		end
		
feature -- Access

	registers: ARRAY [BOOLEAN]
			-- Registers already used for a given C type (corresponding
			-- item is True if register is currently used, False otherwise).

	needed_registers: INTEGER
			-- Maximum register number used

	get_register: INTEGER is
			-- First available register number
		local
			count: INTEGER
		do
			from
				Result := 1
				count := registers.count
			until
				Result > count or not registers.item (Result)
			loop
				Result := Result + 1
			end
				-- May not have been found yet, hence the use of `force'
			registers.force (True, Result)
			if Result > needed_registers then
				needed_registers := Result
			end
		ensure
			register_used: registers.item (Result)
			max_updated: Result <= needed_registers
		end

feature -- Duplication

	duplicate: like Current is
			-- Duplicate of current instance
		do
			create Result.make_from_existing (Current)
		end

feature -- Element change

	clear_all is
			-- Reset data structure
		do
			registers.clear_all
			needed_registers := 0
		end

	free_register (n: INTEGER) is
			-- Free register number `n'
		require
			register_used: registers.item (n)
		do
			registers.put (False, n)
		end

invariant
	registers_not_void: registers /= Void

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
