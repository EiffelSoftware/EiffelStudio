indexing
	description: "Error for non signature-conformance for a redefinition."
	date: "$Date$"
	revision: "$Revision $"

class VDRD5 

inherit
	EIFFEL_ERROR
		redefine
			build_explain, is_defined
		end

	SHARED_WORKBENCH
		undefine
			is_equal
		end
	
feature -- Properties

	redeclaration: E_FEATURE
			-- Redeclared feature

	precursor_of_redeclaration: E_FEATURE
			-- Precursor of the redeclaration

	code: STRING is "VDRD"

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				redeclaration /= Void and then
				precursor_of_redeclaration /= Void
		ensure then
			valid_redeclaration: Result implies redeclaration /= Void
			valid_precursor: Result implies precursor_of_redeclaration /= Void	
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `st'.
		local
			r_class: CLASS_C
			p_class: CLASS_C
		do
			r_class := redeclaration.written_class
			p_class := precursor_of_redeclaration.written_class
			st.add_string ("Redefined feature: ")
			redeclaration.append_signature (st)
			st.add_string (" From: ")
			r_class.append_name (st)
			st.add_new_line
			st.add_string ("Precursor: ")
			precursor_of_redeclaration.append_signature (st)
			st.add_string (" From: ")
			p_class.append_name (st)
			st.add_new_line
		end

feature {COMPILER_EXPORTER}

	init (old_feature, new_feature: FEATURE_I) is
			-- Initialization
        require
            good_arguments: not (old_feature = Void or else 
					new_feature = Void)
		do
			class_c := System.current_class
			redeclaration := new_feature.api_feature (new_feature.written_in)
			precursor_of_redeclaration := old_feature.api_feature (old_feature.written_in)
		end

end -- class VDRD5
