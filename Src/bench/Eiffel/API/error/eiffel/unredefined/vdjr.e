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

	print_signatures (ow: OUTPUT_WINDOW) is
		local
			oclass, nclass: E_CLASS
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

feature {COMPILER_EXPORTER}

	init (old_feat, new_feat: FEATURE_I) is
			-- Initialization
		require
			not (old_feat = Void or else new_feat = Void);
		do
			e_class := System.current_class.e_class
			old_feature := old_feat.api_feature (old_feat.written_in);
			new_feature := new_feat.api_feature (new_feat.written_in);
		end;

end -- class VDJR
