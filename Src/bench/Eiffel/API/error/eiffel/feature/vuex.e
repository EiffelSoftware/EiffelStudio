-- Error for export validity violation

class VUEX 

inherit

	FEATURE_ERROR
		rename
			feature_name as other_feature_name,
			set_feature_name as set_other_feature_name,
			build_explain as old_build_explain
		end;

	FEATURE_ERROR
		rename
			feature_name as other_feature_name,
			set_feature_name as set_other_feature_name
		redefine
			build_explain
		select
			build_explain
		end
	
feature

	static_class: CLASS_C;
			-- Class form which the feature named `feature_name' is
			-- not exported to the class of id `class_id'

	feature_name: STRING;
			-- Feature name involved

	set_static_class (c: CLASS_C) is
			-- Assign `c' to `static_class'.
		do
			static_class := c;
		end;

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
		do
			feature_name := s;
		end;

	code: STRING is "VUEX";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation image for current error
            -- in `a_clickable'.
		local
			compiled_class: CLASS_C
        do
			old_build_explain (a_clickable);
			a_clickable.put_string ("%Tfeature ");
			a_clickable.put_clickable_string (
				static_class.feature_named (feature_name),
				feature_name);
			a_clickable.put_string (" from class ");
			a_clickable.put_clickable_string (static_class, static_class.signature);
			a_clickable.put_string (" is not exported to class ");
			compiled_class := System.class_of_id (class_id);
			a_clickable.put_clickable_string (compiled_class, compiled_class.signature);
			a_clickable.put_string ("%N")
		end

end
