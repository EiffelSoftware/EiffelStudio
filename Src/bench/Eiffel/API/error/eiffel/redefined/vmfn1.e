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

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation explain for current error
			-- in `ow'.
		do
			ow.put_string ("Feature: ");
			a_feature.append_signature (ow, a_feature.written_class);
			ow.put_string (" Version from: ");
			a_feature.written_class.append_name (ow);
			ow.put_string ("%NFeature: ");
			inherited_feature.append_signature (ow, inherited_feature.written_class);
			ow.put_string (" inherited from: ");
			parent.append_name (ow);
			ow.put_string (" Version from: ");
			inherited_feature.written_class.append_name (ow);
			ow.new_line;
		end;

end
