indexing

	description: 
		"Name clash of features.";
	date: "$Date$";
	revision: "$Revision $"

class VMFN 

inherit
	
	EIFFEL_ERROR
		redefine
			build_explain, is_defined
		end

feature -- Properties

	a_feature: E_FEATURE;
			-- Feature implemented in the class of id `class_id'
			-- responsible for the name clash

	inherited_feature: E_FEATURE;
			-- Inherited feature


	code: STRING is "VMFN";
			-- Error code
feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				a_feature /= Void and then
				inherited_feature /= Void
		ensure then
			valid_a_feature: Result implies a_feature /= Void;
			valid_other_feature: Result implies inherited_feature /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			st.add_string ("Feature: ");
			a_feature.append_signature (st);
			st.add_string (" Version from: ");
			a_feature.written_class.append_name (st);
			st.add_new_line;
			st.add_string ("Feature: ");
			inherited_feature.append_signature (st);
			st.add_string (" Version from: ");
			inherited_feature.written_class.append_name (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_a_feature (f: FEATURE_I) is
			-- Assign `f' to `a_feature'.
		require
			valid_f: f /= Void
		do
			a_feature := f.api_feature (f.written_in);
		end;

	set_inherited_feature (f: FEATURE_I) is
			-- Assign `f' to `inherited_feature'.
		require
			valid_f: f /= Void
		do
				-- Create a E_FEATURE object taken from current class so
				-- that we get correct translation of any generic parameter:
				-- Eg: in parent A [G] you have f (a: G)
				-- in descendant B [G, H] inherit A [H], the signature of
				-- `f' becomes f (a: H) and if you display the feature information
				-- using parent class it will crash when trying to display the second
				-- generic parameter which does not exist in B, only in A.
			inherited_feature := f.api_feature (class_c.class_id);
		end;

end -- class VMFN
