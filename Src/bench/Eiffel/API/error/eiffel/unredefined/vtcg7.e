indexing
	description: "Error for violation of the constrained genericity %
				%rule."
	date: "$Date$"
	revision: "$Revision$"

class
	VTCG7

inherit
	VTCG
		redefine
			build_explain
		end

feature -- Properties

	parent_type: TYPE_A
			-- Parent type involved in the error

	in_constraint: BOOLEAN
			-- Is checked done in constraint clause of a class?

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			if in_constraint then
				st.add_string ("In constraint genericity clause")
				st.add_new_line
			end
			st.add_string ("In declaration: ")
			parent_type.append_to (st)
			st.add_new_line
			Precursor {VTCG} (st)
		end

feature {COMPILER_EXPORTER} -- Setting

	set_parent_type (p: TYPE_A) is
			-- Assign `p' to `parent_type'.
		require
			p_not_void: p /= Void
		do
			parent_type := p
		ensure
			parent_type_set: parent_type = p
		end

	set_in_constraint (v: like in_constraint) is
			-- Assign `v' to `in_constraint'.
		do
			in_constraint := v
		ensure
			in_constraint_set: in_constraint = v
		end

end -- class VTCG7
