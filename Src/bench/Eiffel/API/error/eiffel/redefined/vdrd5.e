-- Error for non signature-conformance for a redefinition

deferred class VDRD5 

inherit

	EIFFEL_ERROR
		rename
			build_explain as eiffel_error_build_explain
		end;

	EIFFEL_ERROR
		redefine
			build_explain
		select
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
			class_id := System.current_class.id;
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
			-- Build specific explanation image for current error
			-- in `a_clickable'.
		do
			eiffel_error_build_explain (a_clickable);
			a_clickable.put_string ("%Tprecursor: ");
			precursor.append_clickable_signature (a_clickable);
			a_clickable.put_string (" written in ");
			precursor.written_class.append_clickable_name (a_clickable);
			a_clickable.put_string ("%N%Tredeclaration: ");
			redeclaration.append_clickable_signature (a_clickable);
			a_clickable.put_string (" written in ");
			redeclaration.written_class.append_clickable_name (a_clickable);
			a_clickable.new_line;
		end;

end
