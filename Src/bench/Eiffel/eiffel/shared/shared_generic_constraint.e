indexing
	description: "Save state of checking constraint."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_GENERIC_CONSTRAINT

inherit
	SHARED_FUTURE_CHECKING

feature -- Error reporting

	constraint_error_list: LINKED_LIST [CONSTRAINT_INFO] is
			-- List of the possible errors in the declaration of an
			-- occurrence of a generic class.
		do
			Result := Constraint_error_list_cell.item
		end

	reset_constraint_error_list is
			-- Reset `constraint_error_list' with an empty list.
		do
			Constraint_error_list_cell.put (create {LINKED_LIST [CONSTRAINT_INFO]} .make)
		end

feature {NONE} -- Shared object implementation

	Constraint_error_list_cell: CELL [LINKED_LIST [CONSTRAINT_INFO]] is
			-- Shared object which contains the `constraint_error_list'.
		once
			create Result.put (Void)
		end

end
