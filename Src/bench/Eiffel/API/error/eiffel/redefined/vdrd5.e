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
			good_arguments: not (old_feature = Void or else new_feature = Void);
		do
			redeclaration := new_feature;
			precursor := old_feature;
			class_c := System.current_class;
		end;

	code: STRING is
		do
			Result := "VDRD"
		end;

	build_explain is
			-- Build specific explanation image for current error
			-- in `error_window'.
		do
			put_string ("%Tprecursor: ");
			precursor.append_clickable_signature (error_window);
			put_string (" written in ");
			precursor.written_class.append_clickable_name (error_window);
			put_string ("%N%Tredeclaration: ");
			redeclaration.append_clickable_signature (error_window);
			put_string (" written in ");
			redeclaration.written_class.append_clickable_name (error_window);
			new_line;
		end;

end
