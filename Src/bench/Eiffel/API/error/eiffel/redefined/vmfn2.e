indexing

	description: 
		"Error for name clash on non-deferred inherited features.";
	date: "$Date$";
	revision: "$Revision$"

class VMFN2 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, is_defined
		end
	
feature -- Properties

	features: LINKED_LIST [CELL2 [E_FEATURE, CLASS_C]];
			-- Features inherited defined in a eiffel class which are neither 
			-- the same (from the repeated inheritance point of view) or all redefined
			-- by their parent

	code: STRING is "VMFN";
			-- Error code

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				features /= Void
		ensure then
			valid_features: Result implies features /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		local
			feature_info: CELL2 [E_FEATURE, CLASS_C];
			feat: E_FEATURE;
			parent: CLASS_C;
		do
			from
				features.start;
			until
				features.after
			loop
				feature_info := features.item;
				feat := feature_info.item1;
				parent := feature_info.item2;

				st.add_string ("Feature: ");
				feat.append_signature (st);
				st.add_string (" inherited from: ");
				parent.append_name (st);
				st.add_string (" Version from: ");
				feat.written_class.append_name (st);
				st.add_new_line;
				features.forth;
			end;
		end;

feature {COMPILER_EXPORTER}

	set_features (fs: LINKED_LIST [INHERIT_INFO]) is
			-- Assign `fs' to `features'.
		require
			valid_fs: fs /= Void
			class_c_set: class_c /= Void
		local
			cell2: CELL2 [E_FEATURE, CLASS_C];
			inh_info: INHERIT_INFO;
			e_feature: E_FEATURE;
			parent: CLASS_C
			features_list: like features
		do
			from
				!! features_list.make;
				fs.start
			until
				fs.after
			loop
				inh_info := fs.item;
				parent := inh_info.parent.parent;
					-- Create a E_FEATURE object taken from current class so
					-- that we get correct translation of any generic parameter:
					-- Eg: in parent A [G] you have f (a: G)
					-- in descendant B [G, H] inherit A [H], the signature of
					-- `f' becomes f (a: H) and if you display the feature information
					-- using parent class it will crash when trying to display the second
					-- generic parameter which does not exist in B, only in A.
				e_feature := inh_info.a_feature.api_feature (class_c.class_id);
				!! cell2.make (e_feature, parent);
				features_list.extend (cell2);
				features_list.forth
				fs.forth
			end
			features := features_list
		end;

end -- class VMFN2
