-- Enlarged access to an Eiffel special feature:
-- item, @, put of ARRAY or descendant

class OPT_FEAT_B 

inherit

	FEATURE_B
		redefine
			enlarged, inlined_byte_code
		end

feature 

	enlarged: OPT_FEAT_BL is
		do
			create Result
			Result.fill_from (Current)
		end

	set_special_feature_type is
		do
			if parameters.count = 1 then
				is_item := True
			end;
		end

	set_array_target (t: like array_desc) is
		do
			array_desc := t
		end

	set_access_area (b: BOOLEAN) is
		do
			access_area := b;
		end;

feature {OPT_FEAT_B} -- Implementation

	array_desc: ACCESS_B;
			-- Integer describing the type of target:
			-- arg: >0; Result: 0; local: <0

	is_item: BOOLEAN;

	access_area: BOOLEAN;
			-- Has the access to the area been generated in OPT_LOOP_BL ?

feature -- Inlining

	inlined_byte_code: like Current is
		do
			Result := Current
			parameters := parameters.inlined_byte_code
		end

end
