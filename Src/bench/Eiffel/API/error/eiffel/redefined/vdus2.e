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

	build_explain is
			-- Build specific explanation image for current error
			-- in `error_window'.
		do
			put_string ("%Tfeature ");
			a_feature.append_clickable_signature (error_window);
			new_line
		end

end
