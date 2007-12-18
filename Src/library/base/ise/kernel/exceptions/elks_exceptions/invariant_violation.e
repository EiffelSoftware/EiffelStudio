indexing
	description: "[
		Exception representing an invariant violation
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	INVARIANT_VIOLATION

inherit
	ASSERTION_VIOLATION

feature -- Access

	frozen code: INTEGER is
			-- Exception code
		once
			Result := {EXCEP_CONST}.class_invariant
		end

feature {EXCEPTION_MANAGER} -- Element change

	frozen set_is_entry (a_is_entry: BOOLEAN) is
			-- Set `is_entry' with `a_is_entry'.
		do
			is_entry := a_is_entry
		ensure
			is_entry_set: is_entry = a_is_entry
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING is "Class invariant violated."

feature -- Status report

	frozen is_entry: BOOLEAN
			-- Is current invariant entry violation? Otherwise, invariant exit violation.

end
