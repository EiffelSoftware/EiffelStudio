indexing
	description: "Object that represents an EQL result item for Eiffel system"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_SYSTEM

inherit
	EQL_SOFTWARE_SINGLE_SCOPE
		rename
			data as system_i
		redefine
			is_system_scope
		end

	EQL_SYSTEM_CELL
		undefine
			is_equal
		end

create
	make_with_system_i

feature -- Status reporting

	is_system_scope: BOOLEAN is True
			-- Does current single scope represent a system scope?

feature -- Context

	context: EQL_CONTEXT is
			-- Context containing information of current
		do
			create Result.make_with_system_i (system_i)
		end

invariant
	system_i_not_void: system_i /= Void

end
