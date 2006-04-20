indexing
	description: "Implementation of `IEnumXXXX' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IENUM_STUB [G]

create 
	make
	
feature {NONE} -- Initialization

	make (enumeration: like implementation) is
			-- Initialization.
		require
			non_void_enumeration: enumeration /= Void
		do
			implementation := enumeration
		end
		
feature -- Access

	count: INTEGER is
			-- No description available.
		do
			Result := implementation.count
		end

feature -- Basic Operations

	next (rgelt: CELL [G]; pcelt_fetched: INTEGER_REF) is
			-- Retrieves the next item in 
			-- the enumeration sequence. 
			-- If there are no more elements left in the sequence,
			-- then `item' of `rgelt' is set to Void.
			-- The number of elements
			-- actually retrieved is returned through
			-- `pcelt_fetched'.
		do
			if not implementation.after then
				rgelt.put (implementation.item)
				if pcelt_fetched /= Void then
					pcelt_fetched.set_item (1)
				end
				implementation.forth
			else
				rgelt.put (Void)
				if pcelt_fetched /= Void then
					pcelt_fetched.set_item (0)
				end
			end
		end

	skip (celt: INTEGER) is
			-- Skips over the next specified number of 
			-- elements in the enumeration sequence.
			-- `celt' [in] Number of elements to be skipped.
		do
			implementation.move (celt)
		end

	reset is
			-- Resets the enumeration sequence to the beginning.
		do
			implementation.start
		end

	clone1 (ppenum: CELL [like Current]) is
			-- Creates another enumerator that contains the 
			-- same enumeration state as the current one. 
			-- Using this function, a client can record a 
			-- particular point in the enumeration sequence 
			-- and then return to that point at a later time. 
			-- The new enumerator supports the same interface 
			-- as the original one.
			-- `ppenum' [out].  
		local
			implementation_copy: like implementation
			cloned: like Current
		do
			implementation_copy := clone (implementation)
			create cloned.make (implementation_copy)
			ppenum.put (cloned)
		end

	ith_item (an_index: INTEGER; rgelt: CELL [G]) is
			-- No description available.
			-- `an_index' [in].  
			-- `rgelt' [out].  
		do
			rgelt.put (implementation.i_th (an_index))
		end

feature {NONE} -- Implementation

	implementation: ARRAYED_LIST [G]
			-- Implementation of enumeration.

	implementation_exists: BOOLEAN is
			-- Does `implementation' exist?
		do
			Result := implementation /= Void
		end
		
invariant
	implementation_exists: implementation_exists
	
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
end -- IENUM_STUB

