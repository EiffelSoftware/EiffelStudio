-- Name clash of features: there is one inherited feature and a feature
-- implemented in the class

class VMFN1 

inherit
	
	VMFN
		rename
			other_feature as inherited_feature,
			set_other_feature as set_inherited_feature
		redefine
			build_explain
		end

feature

	parent: CLASS_C;
			-- Parent class to which `inherited_feature' belongs

	set_parent (p: CLASS_C) is
		do
			parent := p;
		end;

	build_explain is
			-- Build specific explanation explain for current error
			-- in `error_window'.
		do
			put_string ("Feature: ");
			a_feature.append_clickable_signature (error_window, a_feature.written_class);
			put_string (" written in: ");
			a_feature.written_class.append_clickable_name (error_window);
			put_string ("%NFeature: ");
			inherited_feature.append_clickable_signature (error_window, inherited_feature.written_class);
			put_string (" inherited from: ");
			parent.append_clickable_name (error_window);
			put_string (" written in: ");
			a_feature.written_class.append_clickable_name (error_window);
			new_line;
		end;

end
