indexing

	description: 
		"Name clash of features: there is one inherited %
		%feature and a feature implemented in the class.";
	date: "$Date$";
	revision: "$Revision $"

class VMFN1 

inherit
	
	VMFN
		redefine
			build_explain, is_defined
		end

feature -- Property

	parent: CLASS_C;
			-- Parent class to which `inherited_feature' belongs

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				a_feature /= Void and then
				inherited_feature /= Void and then
				parent /= Void
		ensure then
			valid_parent: Result implies parent /= Void;
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
			st.add_string (" inherited from: ");
			parent.append_name (st);
			st.add_string (" Version from: ");
			inherited_feature.written_class.append_name (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_parent (p: CLASS_C) is
		require
			valid_p: p /= Void
		do
			parent := p
		end;

end -- class VMFN1
