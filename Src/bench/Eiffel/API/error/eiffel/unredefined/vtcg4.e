indexing
	description: "Error for violation of the constrained genericity %
				%rule by a parent type."
	date: "$Date$"
	revision: "$Revision $"

class
	VTCG4 

inherit
	EIFFEL_ERROR
		redefine
			build_explain
		end

feature -- Properties

	parent_type: CL_TYPE_A
			-- Parent type involved in the error

	error_list: LINKED_LIST [CONSTRAINT_INFO]
			-- Error description list

	code: STRING is "VTCG"
			-- Error code

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			st.add_string ("In parent clause: ")
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

	set_error_list (e: like error_list) is
			-- Assign `e' to `error_list'.
		do
			error_list := e
		end

	set_parent_type (p: CL_TYPE_A) is
			-- Assign `p' to `parent_type'.
		do
			parent_type := p
		end

end -- class VTCG4
