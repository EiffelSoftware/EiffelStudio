-- Error for export validity violation

class VUEX 

inherit

	FEATURE_ERROR
		rename
			feature_name as other_feature_name,
			set_feature_name as set_other_feature_name
		redefine
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

	build_explain is
			-- Build specific explanation image for current error
			-- in `error_window'.
		do
			put_string ("%Tfeature ");
-- FIXME
--			put_clickable_string (
--				static_class.feature_named (feature_name),
--				feature_name);
			put_string (feature_name);
			put_string (" from class ");
			static_class.append_clickable_signature (error_window);
			put_string (" is not exported to class ");
			class_c.append_clickable_name (error_window);
			new_line
		end

end
