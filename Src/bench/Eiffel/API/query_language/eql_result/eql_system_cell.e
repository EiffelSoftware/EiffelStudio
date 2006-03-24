indexing
	description: "Object that represents an EQL result cell for an Eiffel system"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_SYSTEM_CELL

feature{NONE} -- Initialization

	make_with_system_i (a_system_i: like system_i) is
			-- Initialize `system_i' with `a_system_i'.
		do
			system_i := a_system_i
		ensure
			system_i_set: system_i = a_system_i
		end

feature -- Status reporting

	is_system_i_set: BOOLEAN is
			-- Is `system_i' set?
		do
			Result := system_i /= Void
		ensure
			good_result: Result implies system_i /= Void
		end

feature -- Access

	system_i: SYSTEM_I
			-- System in current context

feature -- Setting

	set_system_i (st: SYSTEM_I) is
			-- Assign `st' to `system_i'.
		do
			system_i := st
		end

end
