-- A loop variant

class VARIANT_B 

inherit

	ASSERT_B
		redefine
			enlarged, byte_for_end
		end

feature 

	enlarged: VARIANT_BL is
			-- Enlarge current node
		do
			!!Result;
			Result.fill_from (Current);
		end;

	byte_for_end: CHARACTER is
            -- Byte mark for end of assertion
        do
            Result := Bc_end_variant;
        end;

end
