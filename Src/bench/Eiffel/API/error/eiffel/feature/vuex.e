-- Error for export validity violation

class VUEX 

inherit

	FEATURE_ERROR
		rename
			feature_name as other_feature_name,
			set_feature_name as set_other_feature_name
		redefine
			build_explain, subcode
		end
	
feature

	static_class: CLASS_C;
			-- Class form which the feature named `feature_name' is
			-- not exported to the class of id `class_id'

	feature_name: STRING;
			-- Feature name involved

	exported_feature: FEATURE_I;

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

	set_exported_feature (f: FEATURE_I) is
			-- Assign `s' to `feature_name'.
		do
			exported_feature := f;
		end;

	code: STRING is "VUEX";
			-- Error code

	subcode: INTEGEr is 2;

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation image for current error
			-- in `ow'.
		local
			w_class: CLASS_C
		do
			w_class := exported_feature.written_class;
			ow.put_string ("Feature: ");
			exported_feature.append_name (ow, w_class);
			ow.put_string (" Class: ");
			static_class.append_name (ow);
			ow.put_string (" Version from: ");
			w_class.append_name (ow);
			ow.new_line;
			ow.put_string ("Not exported to class ");
			class_c.append_name (ow);
			ow.new_line
		end

end
