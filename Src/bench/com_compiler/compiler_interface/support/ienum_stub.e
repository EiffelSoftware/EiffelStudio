indexing
	description: "Implementation of `IEnumXXXX' Interface."
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
	
end -- IENUM_STUB

