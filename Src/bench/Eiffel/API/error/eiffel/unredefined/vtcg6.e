indexing
	description: "Error for violation of the constrained genericity %
				%rule."
	date: "$Date$"
	revision: "$Revision$"

class
	VTCG6

inherit
	EIFFEL_ERROR
		redefine
			build_explain
		end

feature -- Properties

	feature_name: STRING

	constraint_class: CLASS_C

	code: STRING is "VTCG"
			-- Error code

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			st.add_string ("%NError: feature `")
			st.add_string (feature_name)
			st.add_string ("' does not exist in class ")
			constraint_class.append_signature (st)
			st.add_new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_feature_name (a_name: STRING) is
			-- Set missing `a_name' of `constraint_class' to `feature_name'.
		require
			feature_name_not_void: a_name /= Void
		do
				--| We don't need to clone the string since it
				--| is a temporary string.
			feature_name := a_name
		ensure
			feature_name_set: feature_name = a_name
		end

	set_constraint_class (c: CLASS_C) is
			-- Set `c' to `constraint_class' which does not
			-- contain `feature_name'
		require
			class_exists: c /= Void
		do
			constraint_class := c
		ensure
			constraint_class_set: constraint_class = c
		end

end -- class VTCG6
 

