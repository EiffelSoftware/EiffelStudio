indexing

	description: 
		"Error for join rule when argument number is not the same.";
	date: "$Date$";
	revision: "$Revision $"

class VDJR 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, is_defined
		end;
	SHARED_WORKBENCH
		undefine
			is_equal
		end

feature -- Properties

	old_feature: E_FEATURE;
			-- Inherited feature

	new_feature: E_FEATURE;
			-- Joined feature

	code: STRING is "VDJR";
			-- Error code

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				old_feature /= Void and then
				new_feature /= Void
		ensure then
			valid_old_feature: Result implies old_feature /= Void;
			valid_new_feature: Result implies new_feature /= Void
		end

feature -- Output

	print_signatures (st: STRUCTURED_TEXT) is
		local
			oclass, nclass: CLASS_C
		do
			oclass := old_feature.written_class;
			nclass := new_feature.written_class;
			st.add_string ("First feature: ");
			old_feature.append_signature (st);
			st.add_new_line;
			st.add_string ("Version from: ");
			oclass.append_name (st);
			st.add_new_line;
			st.add_string ("Second feature: ");
			new_feature.append_signature (st);
			st.add_new_line;
			st.add_string ("Version from: ");
			nclass.append_name (st);
			st.add_new_line;
		end;

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Different numbers of arguments");
			st.add_new_line;
			print_signatures (st);
		end;

feature {COMPILER_EXPORTER}

	init (old_feat, new_feat: FEATURE_I) is
			-- Initialization
		require
			not (old_feat = Void or else new_feat = Void);
		do
			class_c := System.current_class;
			old_feature := old_feat.api_feature (old_feat.written_in);
			new_feature := new_feat.api_feature (new_feat.written_in);
		end;

end -- class VDJR
