-- Error for non signature-conformance for a redefinition

class VDRD5 

inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end
	
feature

	redeclaration: FEATURE_I;
			-- Redeclared feature

	precursor: FEATURE_I;
			-- Precursor of the redeclaration

	init (old_feature, new_feature: FEATURE_I) is
			-- Initialization
        require
            good_arguments: not (old_feature = Void or else 
					new_feature = Void);
		do
			redeclaration := new_feature;
			precursor := old_feature;
			class_c := System.current_class;
		end;

	code: STRING is
		do
			Result := "VDRD"
		end;

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation image for current error
			-- in `ow'.
		local
			r_class: CLASS_C;
			p_class: CLASS_C;
		do
			r_class := redeclaration.written_class;
			p_class := precursor.written_class;
			ow.put_string ("Redefined feature: ");
			redeclaration.append_signature (ow, r_class);
			ow.put_string (" From: ");
			r_class.append_name (ow);
			ow.put_string ("%NPrecursor: ");
			precursor.append_signature (ow, p_class);
			ow.put_string (" From: ");
			p_class.append_name (ow);
			ow.new_line;
		end;

end
