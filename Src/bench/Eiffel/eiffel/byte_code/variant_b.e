indexing
	description	: "Byte code for instruction inside a loop variant"
	date		: "$Date$"
	revision	: "$Revision$"

class VARIANT_B 

inherit
	ASSERT_B
		redefine
			enlarged, byte_for_end
		end

feature -- Access

	enlarged: VARIANT_BL is
			-- Enlarge current node
		do
			create Result
			Result.fill_from (Current)
		end

	byte_for_end: CHARACTER is
            -- Byte mark for end of assertion
        do
            Result := Bc_end_variant
        end

end
