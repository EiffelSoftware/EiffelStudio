-- Error for join rule when argument number is not the same

class VDJR 

inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end;

feature

	old_feature: FEATURE_I;
			-- Inherited feature

	new_feature: FEATURE_I;
			-- Joined feature

	code: STRING is "VDJR";
			-- Error code

	init (old_feat, new_feat: FEATURE_I) is
			-- Initialization
		require
			not (old_feat = Void or else new_feat = Void);
		do
			old_feature := old_feat;
			new_feature := new_feat;
			class_c := System.current_class;
		end;

	print_signatures is
		local
			oclass, nclass: CLASS_C
		do
			oclass := old_feature.written_class;
			nclass := new_feature.written_class;
			put_string ("First feature: ");
			old_feature.append_clickable_signature (error_window, oclass);
			put_string ("%NVersion from: ");
			oclass.append_clickable_name (error_window);
			put_string ("%NSecond feature: ");
			new_feature.append_clickable_signature (error_window, nclass);
			put_string ("%NVersion from: ");
			nclass.append_clickable_name (error_window);
			new_line;
		end;

	build_explain is
		do
			put_string ("Different numbers of arguments%N");
			print_signatures;
		end;

end
