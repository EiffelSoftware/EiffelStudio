-- Error when undefinition of an attribute, a once, a constant or a frozen
-- feature

class VDUS2 

inherit

	EIFFEL_ERROR
		rename
			build_explain as old_build_explain
		end;
	EIFFEL_ERROR
		redefine
			build_explain
		select
			build_explain
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

	build_explain (a_clickable: CLICK_WINDOW) is
			-- Build specific explanation image for current error
			-- in `a_clickable'.
		do
			old_build_explain (a_clickable);
			a_clickable.put_string ("%Tfeature ");
			a_feature.append_clickable_signature (a_clickable);
			a_clickable.new_line
		end

end
