-- Optimized byte code for loops

class OPT_LOOP_B

inherit

	LOOP_B
		redefine
			enlarged, size,
			pre_inlined_code
		end

feature

	enlarged: OPT_LOOP_BL is
		do
			!!Result;
			Result.fill_from (Current)
			Result.set_line_number (line_number)
		end;

	add_array_to_generate (arr_desc: INTEGER) is
		do
			if array_desc = Void then
				!!array_desc.make;
			end;
			array_desc.extend (arr_desc)
		end;

	array_desc: TWO_WAY_SORTED_SET [INTEGER];

	add_offset_to_generate (arr_desc: INTEGER) is
		do	
			if generated_offsets = Void then
				!!generated_offsets.make
			end
			generated_offsets.extend (arr_desc)
		end;

	generated_offsets: TWO_WAY_SORTED_SET [INTEGER];

	add_offset_already_generated (arr_desc: INTEGER) is
		do
			if already_generated_offsets = Void then
				!!already_generated_offsets.make
			end
			already_generated_offsets.extend (arr_desc)
		end;

	already_generated_offsets: TWO_WAY_SORTED_SET [INTEGER];

feature -- Inlining

	size: INTEGER is
		do
				-- Inlining will not be done if the feature
				-- optimizes array access
			Result := 100 + 1	-- Maximum size of inlining + 1 (Found in FREE_OPTION_SD)
		end

	pre_inlined_code: like Current is
			-- This should NEVER be called!!!
			-- (size is bigger than maximum)
		do
		end

end
