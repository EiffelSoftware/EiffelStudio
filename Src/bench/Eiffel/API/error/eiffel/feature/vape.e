
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

	build_explain is
		local
			e_class: CLASS_C
		do
			e_class := exported_feature.written_class;
			put_string ("Improperly exported feature: ");
			exported_feature.append_clickable_name (error_window, e_class);
			put_string (" written in: ");
			e_class.append_clickable_name (error_window);
			new_line;
		end;

end 
