indexing

	description: 
		"Error for name clash on non-deferred inherited features.";
	date: "$Date$";
	revision: "$Revision $"

class VMFN2 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, is_defined
		end
	
feature -- Properties

	features: LINKED_LIST [CELL2 [E_FEATURE, E_CLASS]];
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
			feature_info: CELL2 [E_FEATURE, E_CLASS];
			feat: E_FEATURE;
			parent: E_CLASS;
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
				feat.append_signature (st, parent);
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
		local
			cell2: CELL2 [E_FEATURE, E_CLASS];
			inh_info: INHERIT_INFO;
			e_feature: E_FEATURE;
			parent: E_CLASS
		do
			from
				!! features.make;
				fs.start
			until
				fs.after
			loop
				inh_info := fs.item;
				parent := inh_info.parent.parent.e_class;
				e_feature := inh_info.a_feature.api_feature (parent.id);
				!! cell2.make (e_feature, parent);
				features.extend (cell2);
				fs.forth
			end
		end;

end -- class VMFN2
