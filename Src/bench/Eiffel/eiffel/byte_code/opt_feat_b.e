-- Enlarged access to an Eiffel special feature:
-- item, @, put of ARRAY or descendant

class OPT_FEAT_B 

inherit

	FEATURE_B
		redefine
			enlarged
		end

feature 

	enlarged: OPT_FEAT_BL is
		do
			!!Result
			Result.fill_from (Current)
		end

	set_special_feature_type is
		do
			if parameters.count = 1 then
				is_item := True
			end;
		end

	set_array_target (t: INTEGER) is
		do
			array_desc := t
		end

feature {OPT_FEAT_B} -- Implementation

	array_desc: INTEGER;
			-- Integer describing the type of target:
			-- arg: >0; Result: 0; local: <0

	is_item: BOOLEAN;

end
