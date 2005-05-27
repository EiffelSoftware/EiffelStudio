indexing

	description: "Error for inherited feature with semistrict operator alias.";
	date: "$Date$";
	revision: "$Revision$"

class VE07
	obsolete "Not defined in the standard"

inherit
	
	EIFFEL_ERROR
		redefine
			build_explain, help_file_name, is_defined
		end

create
	make

feature {NONE} -- Creation

	make (c: CLASS_C; f: FEATURE_I; p: CLASS_C) is
		require
			c_not_void: c /= Void
			f_not_void: f /= Void
			p_not_void: p /= Void
		do
			set_class (c)
				-- Create a E_FEATURE object taken from current class so
				-- that we get correct translation of any generic parameter:
				-- Eg: in parent A [G] you have f (a: G)
				-- in descendant B [G, H] inherit A [H], the signature of
				-- `f' becomes f (a: H) and if you display the feature information
				-- using parent class it will crash when trying to display the second
				-- generic parameter which does not exist in B, only in A.
			inherited_feature := f.api_feature (c.class_id)
			parent_class := p
		ensure
			class_c_set: class_c = c
			inherited_feature_set: inherited_feature /= Void
			parent_class_set: parent_class = p
		end

feature -- Access

	code: STRING is "VE07"
			-- Error code

	help_file_name: STRING is "VFAV4"
			-- Associated file name where error explanation is located

feature -- Status report

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := Precursor and then
				inherited_feature /= Void and then
				parent_class /= Void
		ensure then
			valid_inherited_feature: Result implies inherited_feature /= Void
			valid_parent_class: Result implies parent_class /= Void
		end

feature {NONE} -- Implmentation

	inherited_feature: E_FEATURE
			-- Inherited feature

	parent_class: CLASS_C
			-- Class from which the feature is inherited

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			st.add_string ("Feature: ")
			inherited_feature.append_signature (st)
			st.add_string (" Version from: ")
			inherited_feature.written_class.append_name (st)
			st.add_new_line
			st.add_string ("Parent class: ")
			parent_class.append_signature (st, False)
			st.add_new_line
		end

end
