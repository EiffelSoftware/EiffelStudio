-- Error for name clash on non-deferred inherited features

class VMFN2 

inherit

	EIFFEL_ERROR
		redefine
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

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation explain for current error
			-- in `ow'.
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
				parent := feature_info.parent.parent;

				ow.put_string ("Feature: ");
				feature_i.append_signature (ow, parent);
				ow.put_string (" inherited from: ");
				parent.append_name (ow);
				ow.put_string (" Version from: ");
				feature_i.written_class.append_name (ow);
				ow.new_line;
				features.forth;
			end;
		end;

end
