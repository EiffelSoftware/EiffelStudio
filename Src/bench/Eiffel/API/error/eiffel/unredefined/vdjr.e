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

	print_signatures (ow: OUTPUT_WINDOW) is
		local
			oclass, nclass: CLASS_C
		do
			oclass := old_feature.written_class;
			nclass := new_feature.written_class;
			ow.put_string ("First feature: ");
			old_feature.append_signature (ow, oclass);
			ow.put_string ("%NVersion from: ");
			oclass.append_name (ow);
			ow.put_string ("%NSecond feature: ");
			new_feature.append_signature (ow, nclass);
			ow.put_string ("%NVersion from: ");
			nclass.append_name (ow);
			ow.new_line;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Different numbers of arguments%N");
			print_signatures (ow);
		end;

end
