note
	description: "[
		Objects representing delayed calls to a function,
		with some arguments possibly still open.
		Notes: Features are the same as those of ROUTINE,
		with `apply' made effective, and the addition
		of `last_result' and `item'.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FUNCTION [OPEN_ARGS -> detachable TUPLE create default_create end, RESULT_TYPE]

inherit
	ROUTINE [OPEN_ARGS]
		redefine
			is_equal, copy
		end

create {NONE}
	set_rout_disp,
	set_rout_disp_final

feature -- Access

	last_result: detachable RESULT_TYPE
			-- Result of last call, if any.

	item alias "()" (args: detachable OPEN_ARGS): RESULT_TYPE
			-- Result of calling function with `args' as operands.
		require
			valid_operands: valid_operands (args)
			callable: callable
		do
			set_operands (args)
			clear_last_result
				-- If result is attached, it is of type {RESULT_TYPE}.
			if attached {RESULT_TYPE} rout_disp.invoke (target_object, internal_operands) as r then
				Result := r
			else
					-- Result is `Void'.
					-- The type {RESULT_TYPE} has to be detachable.
				check ({RESULT_TYPE}).has_default end
				Result := ({RESULT_TYPE}).default
			end
			if is_cleanup_needed then
				remove_gc_reference
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is associated function the same as the one
			-- associated with `other'?
		do
			Result := Precursor (other) and then
					 equal (last_result, other.last_result)
		end

feature -- Duplication

	copy (other: like Current)
			-- Use same function as `other'.
		do
			Precursor (other)
			last_result := other.last_result
		end

feature -- Basic operations

	apply
			-- Call function with `operands' as last set.
		do
			if attached {RESULT_TYPE} rout_disp.invoke (target_object, internal_operands) as r then
				last_result := r
			else
				clear_last_result
			end
		end

feature -- Obsolete

	eval (args: detachable OPEN_ARGS): RESULT_TYPE
			-- Result of evaluating function for `args'.
		obsolete
			"Please use `item' instead. [2017-05-31]"
		require
			valid_operands: valid_operands (args)
			callable: callable
		do
			Result := item (args)
		end

feature -- Removal

	clear_last_result
			-- Reset content of `last_result' to its default value
		local
			l_result: detachable RESULT_TYPE
		do
			last_result := l_result
		end

feature -- Extended operations

	flexible_item (a: detachable separate TUPLE): RESULT_TYPE
			-- Result of calling function with `a' as arguments.
			-- Compared to `item' the type of `a' may be different from `{OPEN_ARGS}'.
		require
			valid_operands: valid_operands (a)
		local
			default_arguments: detachable OPEN_ARGS
		do
			if not attached a then
				Result := item (default_arguments)
			else
				check
					from_precondition: attached {OPEN_ARGS} new_tuple_from_tuple (({OPEN_ARGS}).type_id, a) as x
				then
					Result := item (x)
				end
			end
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
