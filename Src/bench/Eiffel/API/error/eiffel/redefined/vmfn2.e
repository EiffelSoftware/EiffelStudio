-- Error for name clash on non-deferred inherited features

class VMFN2 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode
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

	subcode: INTEGER is 2;

	build_explain is
            -- Build specific explanation explain for current error
			-- in `error_window'.
		local
			feature_info: INHERIT_INFO;
			feature_i: FEATURE_I;
			parent: CLASS_C;
		do
			from
				features.start;
			until
				features.after
			loop
				feature_info := features.item;
				feature_i := feature_info.a_feature;
				put_string ("%Tfeature ");
				parent := System.class_of_id (feature_info.parent.parent_id);
				feature_i.append_clickable_signature (error_window, parent);
				put_string (" inherited from ");
				parent.append_clickable_name (error_window);
				put_string (" written in ");
				feature_i.written_class.append_clickable_name (error_window);
				new_line;
				features.forth;
			end;
		end;

end
