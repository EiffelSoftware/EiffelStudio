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

	parent_id: INTEGER;
			-- Id of the parent class to which `inherited_feature' belongs

	set_parent_id (i: INTEGER) is
			-- Assign `i' to `parent_id'.
		do
			parent_id := i;
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation explain for current error
            -- in `a_clickable'.
        do
            old_build_explain (a_clickable);
			a_clickable.put_string ("%Tfeature ");
			a_feature.append_clickable_signature (a_clickable);
			a_clickable.put_string ("%N%Tand feature ");
			inherited_feature.append_clickable_signature (a_clickable);
			a_clickable.put_string (" inherited from ");
			System.class_of_id (parent_id).append_clickable_name (a_clickable);
			a_clickable.new_line;
		end;

end
