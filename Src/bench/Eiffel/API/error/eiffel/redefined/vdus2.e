-- Error when undefinition of an attribute, a once, a constant or a frozen
-- feature

class VDUS2 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode
		end;
	
feature

	a_feature: FEATURE_I;
			-- Undefined feature

	parent: CLASS_C;
			-- Parent from which `a_feature' is inherited

	set_a_feature (f: FEATURE_I) is
			-- Assign `f' to `a_feature'.
		do
			a_feature := f;
		end;

	set_parent (c: CLASS_C) is
			-- Assign `c' to `parent'.
		do
			parent := c;
		end;

	code: STRING is "VDUS";
			-- Error code

	subcode: INTEGER is
		do
			Result := 2;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation image for current error
			-- in `ow'.
		do
			ow.put_string ("Feature: ");
			a_feature.append_signature (ow, a_feature.written_class);
			ow.put_string ("%NIn Undefine clause for parent: ");
			parent.append_name (ow);
			ow.new_line
		end

end
