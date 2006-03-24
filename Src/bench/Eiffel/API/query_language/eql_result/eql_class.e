indexing
	description: "Object that represents a class item from a resultset of a certain EQL query"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_CLASS

inherit

	EQL_SOFTWARE_SINGLE_SCOPE
		rename
			data as class_i
		redefine
			is_class_scope
		end

	EQL_CLASS_CELL
		undefine
			is_equal
		end

create
	make_with_class_i,
	make_with_class_c

feature -- Status reporting

	is_class_scope: BOOLEAN is True
			-- Does current single scope represent a class scope?

feature -- Context

	context: EQL_CONTEXT is
			-- Context containing information of current
		do
			create Result.make_with_class_i (class_i)
		end

invariant
	class_i_not_void: class_i /= Void

end
