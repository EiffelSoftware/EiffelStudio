note

	description:

		"Deferred common base for classes that wrap functions or callbacks"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_CALLABLE_WRAPPER

inherit

	EWG_COMPOSITE_WRAPPER

create
	make

feature -- Access

	return_type: detachable EWG_MEMBER_WRAPPER
			-- Wrapper for return type of callable construct.
			-- If the callable construct to wrap has the "void" return
			-- type, then `return_type' will be `Void'

	has_return_type: BOOLEAN
			-- Does `Current' have a return type?
		do
			Result := return_type /= Void
		ensure
			has_return_type_equals_non_void_return_type: Result = (return_type /= Void)
		end

	set_return_type (a_return_type: EWG_MEMBER_WRAPPER)
			-- Make `a_return_type' the new `return_type' of `Current'.
		require
			a_return_type_not_void: a_return_type /= Void
		do
			return_type := a_return_type
			a_return_type.set_composite_wrapper (Current)
		ensure
			return_type_set: return_type = a_return_type
			return_type_has_current_as_composite_wrapper: attached return_type as l_return_type and then attached l_return_type.composite_wrapper as l_composity_wrapper and then l_composity_wrapper = Current
		end

invariant

	has_return_type_implies_return_type_has_current_as_composite_wrapper: attached return_type as l_return_type implies attached l_return_type.composite_wrapper as l_composite_wrapper and then l_composite_wrapper = Current

end
