indexing
	description: "Error for violation of the constrained genericity %
				%rule."
	date: "$Date$"
	revision: "$Revision$"

class
	VTCG7

inherit
	EIFFEL_ERROR
		redefine
			build_explain
		end

feature -- Properties

	parent_type: CL_TYPE_A
			-- Parent type involved in the error

	error_list: LINKED_LIST [CONSTRAINT_INFO]

	code: STRING is "VTCG"
			-- Error code

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			st.add_string ("In declaration: ")
			parent_type.append_to (st)
			st.add_new_line
			from
				error_list.start
			until
				error_list.after
			loop
				error_list.item.build_explain (st)
				error_list.forth
			end
		end

feature {COMPILER_EXPORTER} -- Setting

	set_error_list (list: LINKED_LIST [CONSTRAINT_INFO]) is
			-- Set `list' to `error_list'
		require
			list_exists: list /= Void
		do
			error_list := list
		ensure
			error_list: error_list = list
		end

	set_parent_type (p: CL_TYPE_A) is
			-- Assign `p' to `parent_type'.
		require
			p_not_void: p /= Void
		do
			parent_type := p
		ensure
			parent_type_set: parent_type = p
		end

end -- class VTCG7
