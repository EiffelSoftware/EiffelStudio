
class VAPE 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end;

feature 

	code: STRING is "VAPE";
			-- Error code

	exported_feature: FEATURE_I;

	set_exported_feature (f: FEATURE_I) is
		do
			exported_feature := f;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		local
			e_class: CLASS_C
		do
			e_class := exported_feature.written_class;
			ow.put_string ("Insufficiently exported feature: ");
			exported_feature.append_name (ow, e_class);
			ow.put_string (" from ");
			e_class.append_name (ow);
			ow.new_line;
		end;

end 
