indexing
	description: "Implementation of `IEnumXXXX' Interface."
	date: "$Date$"
	revision: "$Revision$"

class
	IENUM_IMPL [G]

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
		
feature -- Basic Operations

	next (celt: INTEGER; rgelt: ARRAY [G]; pcelt_fetched: INTEGER_REF) is
			-- Retrieves the next `celt' items in 
			-- the enumeration sequence. 
			-- If there are fewer than the requested number 
			-- of elements left in the sequence, it retrieves
			-- the remaining elements. The number of elements
			-- actually retrieved is returned through
			-- `pcelt_fetched' (unless the caller passed in 
			-- Void for that parameter).
			-- 
			-- `celt' [in] Number of elements being requested.  
			-- `rgelt' [out] Array of size `celt' (or larger) 
			-- of the elements of interest. The type of this
			-- parameter depends on the item being enumerated. 
			-- Array index starts from 1.
			-- `pcelt_fetched' [out] Reference to the number of
			-- elements actually supplied in `rgelt'. Caller can
			-- pass in Void if celt is one.  
		local
			duplicate: like implementation
			i: INTEGER
		do
			duplicate := implementation.duplicate (celt)
			from
				duplicate.start
				i := 1
			until
				duplicate.after
			loop
				rgelt.put (duplicate.item, i)
				duplicate.forth
				i := i + 1
			end
			pcelt_fetched.set_item (duplicate.count)
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

feature {NONE} -- Implementation

	implementation: LIST [G]
			-- Implementation of enumeration.

	implementation_exists: BOOLEAN is
			-- Does `implementation' exist?
		do
			Result := implementation /= Void
		end
		
invariant
	implementation_exists: implementation_exists
	
end -- IENUM_IMPL

