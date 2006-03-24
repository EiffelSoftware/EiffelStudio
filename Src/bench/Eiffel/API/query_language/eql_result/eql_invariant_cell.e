indexing
	description: "Object that represents an invariant ast node used in EQL"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_INVARIANT_CELL

inherit
	SHARED_EIFFEL_PROJECT

feature{NONE} -- Initialization

	make_with_invariant (a_invariant: like invariant_part) is
			-- Initialize `invariant_part' with `a_invariant'.
		require
			a_invariant_not_void: a_invariant /= Void
		do
			set_invariant_part (a_invariant)
		end

feature -- Status reporting

	is_invariant_part_set: BOOLEAN is
			-- Is `invariant_part' set?
		do
			Result := invariant_part /= Void
		end

feature -- Access

	invariant_part: INVARIANT_AS
			-- Invariant ast

	associated_class: CLASS_C is
			-- Class associated with `invariant_part'
		require
			invariant_part_not_void: invariant_part /= Void
		do
			Result := eiffel_system.class_of_id (invariant_part.class_id)
		ensure
			result_not_void: result /= Void
		end

feature -- Setting

	set_invariant_part (a_ast: like invariant_part) is
			-- Set `invariant_part' with `a_ast'.
		do
			invariant_part := a_ast
		ensure
			invariant_part_set: invariant_part = a_ast
		end

end
