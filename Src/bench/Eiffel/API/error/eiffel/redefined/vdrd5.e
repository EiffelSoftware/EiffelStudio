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
		local
			r_class: CLASS_C;
			p_class: CLASS_C;
		do
			r_class := redeclaration.written_class;
			p_class := precursor.written_class;
			put_string ("Redefined feature: ");
			if r_class = class_c then
					-- The redeclaration is written in the current class
					-- The clickable information is NOT in the servers!!!
				put_string (redeclaration.signature);
			else
				redeclaration.append_clickable_signature (error_window, r_class);
			end;
			put_string (" From: ");
			r_class.append_clickable_name (error_window);
			put_string ("%NPrecursor: ");
			precursor.append_clickable_signature (error_window, p_class);
			put_string (" From: ");
			p_class.append_clickable_name (error_window);
			new_line;
		end;

end
