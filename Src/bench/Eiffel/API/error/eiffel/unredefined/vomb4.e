-- Error when there is two unique with the same name involved in a
-- inspect instruction

class VOMB4 

inherit

	VOMB
		redefine
			subcode, build_explain
		end

feature

	subcode: INTEGER is 4;

feature

	unique_feature: FEATURE_I;
			-- Unique feature name

	set_unique_feature (f: FEATURE_I) is
			-- Assign `s' to `unique_name'.
		do
			unique_feature := f;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Duplicate name: ");
			unique_feature.append_name (ow, unique_feature.written_class);
			ow.new_line;
		end;

end
