indexing
	description: "Object that store all the needed information for the report of generic%N%
			%constraint validity errors when there are some. It also handles the checking%N%
			%that cannot be done before degree 3"
	author: "Emmanuel STAPF"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_GENERIC_CONSTRAINT

feature -- Delayed validity checking

	remaining_validity_checking_list: LINKED_LIST [CONSTRAINT_CHECKING_INFO] is
			-- List of the remaining checks that need to be done after
			-- the degree 4 of the compilation.
		do
			Result := remaining_validity_checking_list_cell.item
		end

	add_future_checking(
			gen_type_a: GEN_TYPE_A;
			formal_dec_as: FORMAL_DEC_AS
			constraint_type: TYPE_A;
			context_class: CLASS_C;
			to_check: TYPE_A;
			i: INTEGER;
			formal_type: FORMAL_A) is
				-- Gather all information which will enable to check that
				-- all the declaration of generic classes conforms to the
				-- generic creation constraint of the generic class.
		local
			t: CONSTRAINT_CHECKING_INFO
		do
			!! t.make (gen_type_a, formal_dec_as, constraint_type, context_class,
				to_check, i, formal_type)
			remaining_validity_checking_list.extend (t)
		end

	reset_remaining_validity_checking_list is
		do
			remaining_validity_checking_list_cell.put (create {LINKED_LIST [CONSTRAINT_CHECKING_INFO]} .make)
		end

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
			!! Result.put (Void)
		end

	Remaining_validity_checking_list_cell: CELL [LINKED_LIST [CONSTRAINT_CHECKING_INFO]] is
			-- Shared object which contains the `remaining_validity_checking_list'.
		local
			t: like remaining_validity_checking_list
		once
			!! t.make
			!! Result.put (t)
		end

end -- class SHARED_GENERIC_CONSTRAINT
