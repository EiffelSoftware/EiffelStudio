-- Optimized byte code for loops

class OPT_LOOP_B

inherit

	LOOP_B
		redefine
			enlarged
		end

feature

	enlarged: OPT_LOOP_BL is
		do
			!!Result;
			Result.fill_from (Current)
		end;

	add_array_to_generate (arr_desc: INTEGER) is
		do
			if array_desc = Void then
				!!array_desc.make;
			end;
			array_desc.extend (arr_desc)
		end;

	array_desc: TWO_WAY_SORTED_SET [INTEGER];

end
