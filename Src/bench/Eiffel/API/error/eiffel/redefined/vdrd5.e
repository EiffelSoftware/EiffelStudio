indexing

	description: 
		"Error for non signature-conformance for a redefinition.";
	date: "$Date$";
	revision: "$Revision $"

class VDRD5 

inherit

	SHARED_WORKBENCH;
	EIFFEL_ERROR
		redefine
			build_explain, is_defined
		end
	
feature -- Properties

	redeclaration: E_FEATURE;
			-- Redeclared feature

	precursor: E_FEATURE;
			-- Precursor of the redeclaration

	code: STRING is
		do
			Result := "VDRD"
		end;

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				redeclaration /= Void and then
				precursor /= Void
		ensure then
			valid_redeclaration: Result implies redeclaration /= Void;
			valid_precursor: Result implies precursor /= Void	
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `st'.
		local
			r_class: E_CLASS;
			p_class: E_CLASS;
		do
			r_class := redeclaration.written_class;
			p_class := precursor.written_class;
			st.add_string ("Redefined feature: ");
			redeclaration.append_signature (st);
			st.add_string (" From: ");
			r_class.append_name (st);
			st.add_new_line;
			st.add_string ("Precursor: ");
			precursor.append_signature (st);
			st.add_string (" From: ");
			p_class.append_name (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	init (old_feature, new_feature: FEATURE_I) is
			-- Initialization
        require
            good_arguments: not (old_feature = Void or else 
					new_feature = Void);
		do
			e_class := System.current_class
			redeclaration := new_feature.api_feature (new_feature.written_in);
			precursor := old_feature.api_feature (old_feature.written_in);
		end;

end -- class VDRD5
