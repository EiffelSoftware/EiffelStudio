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
			io.error.putstring ("%Tprecursor: ");
			io.error.putstring (precursor.feature_name);
			io.error.putstring (" written in ");
			io.error.putstring (precursor.written_class.class_name);
			io.error.putstring ("%N%Tredeclaration: ");
			io.error.putstring (redeclaration.feature_name);
			io.error.putstring (" written in ");
			io.error.putstring (redeclaration.written_class.class_name);
			io.error.new_line;
		end;

end
