-- Error for name clash on non-deferred inherited features

class VMFN2 

inherit

	EIFFEL_ERROR
		rename
			build_explain as old_build_explain
		end;

	EIFFEL_ERROR
		redefine
			build_explain
		select
			build_explain
		end
	
feature

	features: LINKED_LIST [INHERIT_INFO];
			-- Features inherited which are neither the same (from the
			-- repeated inheritance point of view) or all redefined
			-- by their parent

	set_features (fs: like features) is
			-- Assign `fs' to `features'.
		do
			features := fs;
		end;

	code: STRING is "VMFN";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation explain for current error
			-- in `a_clickable'.
		local
			feature_info: INHERIT_INFO;
			feature_i: FEATURE_I;
			parent: CLASS_C;
		do
            old_build_explain (a_clickable);
			from
				features.start;
			until
				features.offright
			loop
				feature_info := features.item;
				feature_i := feature_info.a_feature;
				a_clickable.put_string ("%Tfeature ");
				feature_i.append_clickable_signature (a_clickable);
				a_clickable.put_string (" inherited from ");
				parent := System.class_of_id (feature_info.parent.parent_id);
				parent.append_clickable_name (a_clickable);
				a_clickable.put_string (" written in ");
				feature_i.written_class.append_clickable_name (a_clickable);
				a_clickable.new_line;
				features.forth;
			end;
		end;

end
