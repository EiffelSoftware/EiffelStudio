-- Name clash of features: there is one inherited feature and a feature
-- implemented in the class

class VMFN1 

inherit
	
	VMFN
		rename
			other_feature as inherited_feature,
			set_other_feature as set_inherited_feature
		redefine
			build_explain, subcode
		end

feature

	parent_id: INTEGER;
			-- Id of the parent class to which `inherited_feature' belongs

	set_parent_id (i: INTEGER) is
			-- Assign `i' to `parent_id'.
		do
			parent_id := i;
		end;

	subcode: INTEGER is 1;

	build_explain is
			-- Build specific explanation explain for current error
			-- in `error_window'.
		do
			put_string ("%Tfeature ");
			a_feature.append_clickable_signature (error_window);
			put_string ("%N%Tand feature ");
			inherited_feature.append_clickable_signature (error_window);
			put_string (" inherited from ");
			System.class_of_id (parent_id).append_clickable_name (error_window);
			new_line;
		end;

end
