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
			io.error.putstring ("%Tfeature ");
			io.error.putstring (a_feature.feature_name);
			io.error.putstring ("%N%Tand feature ");
			io.error.putstring (inherited_feature.feature_name);
			io.error.putstring (" inherited from ");
			io.error.putstring (System.class_of_id (parent_id).class_name);
			io.error.new_line;
		end;

end
