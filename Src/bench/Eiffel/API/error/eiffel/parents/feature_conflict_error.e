indexing

	description: "[
		Error for features that conflict for some reason
		(e.g., have the same name but different alias names).
	]";
	date: "$Date$";
	revision: "$Revision$"

deferred class FEATURE_CONFLICT_ERROR

inherit
	
	EIFFEL_ERROR
		redefine
			build_explain, is_defined
		end

feature {NONE} -- Creation

	make (c: CLASS_C; f1, f2: FEATURE_I) is
		require
			c_not_void: c /= Void
			f1_not_void: f1 /= Void
			f2_not_void: f2 /= Void
		local
			class_id: INTEGER
		do
			set_class (c)
				-- Create a E_FEATURE object taken from current class so
				-- that we get correct translation of any generic parameter:
				-- Eg: in parent A [G] you have f (a: G)
				-- in descendant B [G, H] inherit A [H], the signature of
				-- `f' becomes f (a: H) and if you display the feature information
				-- using parent class it will crash when trying to display the second
				-- generic parameter which does not exist in B, only in A.
			class_id := c.class_id
			feature_1 := f1.api_feature (class_id)
			feature_2 := f2.api_feature (class_id)
		ensure
			class_c_set: class_c = c
			feature_1_set: feature_1 /= Void
			feature_2_set: feature_2 /= Void
		end

feature -- Status report

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := Precursor and then
				feature_1 /= Void and then
				feature_2 /= Void
		ensure then
			valid_feature_1: Result implies feature_1 /= Void
			valid_feature_2: Result implies feature_2 /= Void
		end

feature {NONE} -- Implmentation

	feature_1: E_FEATURE
			-- One feature

	feature_2: E_FEATURE
			-- Another feature

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			st.add_string ("Feature: ")
			feature_1.append_signature (st)
			st.add_string (" Version from: ")
			feature_1.written_class.append_name (st)
			st.add_new_line
			st.add_string ("Feature: ")
			feature_2.append_signature (st)
			st.add_string (" Version from: ")
			feature_2.written_class.append_name (st)
			st.add_new_line
		end

end
