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
			build_explain,
			is_defined
		end

feature -- Properties

	feature_name: STRING

	constraint_class: CLASS_C

	constraint_type: TYPE_AS
			-- Constraint type

	code: STRING is "VTCG"
			-- Error code

feature -- Status report

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := Precursor and then feature_name /= Void and then
				(constraint_class /= Void or else constraint_type /= Void)
		end

feature -- Output


	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			st.add_new_line
			st.add_string ("Error: feature ")
			if constraint_class /= Void then
				st.add_feature_name (feature_name, constraint_class)
			else
				st.add_char ('`')
				st.add_string (feature_name)
				st.add_char ('%'')
			end
			st.add_string (" from ")
			if constraint_class /= Void then
				constraint_class.append_signature (st, False)
			else
				check
					constraint_type_not_void: constraint_type /= Void
				end
				constraint_type.append_to (st)
			end
			st.add_string (" cannot be used for creation.")
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

	set_constraint_type (t: TYPE_AS) is
			-- Set `t' to `constraint_type' which does not
			-- contain `feature_name'.
		require
			t_not_void: t /= Void
		do
			constraint_type := t
		ensure
			constraint_type_set: constraint_type = t
		end

end
