note
	descrption: "Register server that distributes register numbers."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class REGISTER_SERVER

inherit
	ANY

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end;	-- DEBUG only

	SHARED_C_LEVEL
		export
			{NONE} all
		end

create {BYTE_CONTEXT}

	make

feature {NONE} -- Creation

	make (n: INTEGER)
			-- Create a new instance to manage `n' different register types.
		require
			n_positive: n > 0
		local
			i: INTEGER
		do
			create managers.make (1, n)
			from
				i := n
			until
				i <= 0
			loop
				managers.put (create {REGISTER_MANAGER}.make, i)
				i := i - 1
			end
		ensure
			count_set: count = n
		end

feature -- Status report

	count: INTEGER
			-- Number of register types
		do
			Result := managers.count
		end

	needed_registers_by_clevel (clevel: INTEGER): INTEGER
			-- Number of needed registers for C type level `clevel'
		require
			valid_clevel: 0 < clevel and clevel <= count
		do
			Result := managers.item (clevel).needed_registers
		end

feature -- Duplication

	duplicate: like Current
			-- Duplicate of the current instance
		local
			m: like managers
			i: INTEGER
		do
			Result := twin
			m := managers.twin
			Result.set_registers (m)
			from
				i := m.count
			until
				i <= 1
			loop
				i := i - 1
				m.put (m.item (i).duplicate, i)
			end
		end

feature -- Modification

	clear_all
			-- Clear current data structure
		local
			i: INTEGER
		do
			from
				i := count
			until
				i <= 0
			loop
				managers.item (i).clear_all
				i := i - 1
			end
		end

	get_register (ctype: INTEGER): INTEGER
			-- First free register of type `ctype'
		do
			Result := managers.item (ctype).get_register
		end

	free_register (ctype: INTEGER; n: INTEGER)
			-- Free register number `n' of type `ctype'
		do
			managers.item (ctype).free_register (n)
		end

feature {NONE} -- Implementation

	managers: ARRAY [REGISTER_MANAGER];
			-- The available registers (one entry per C type)

feature {REGISTER_SERVER} -- Modification

	set_registers (r: like managers)
			-- Assign `r' to `registers'.
		require
			r_attached: r /= Void
		do
			managers := r
		ensure
			managers_set: managers = r
		end

invariant
	managers_attached: managers /= Void

note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
