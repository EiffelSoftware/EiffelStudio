indexing
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
	FUNCTION [BASE_TYPE, OPEN_ARGS -> TUPLE create default_create end, RESULT_TYPE]

inherit
	ROUTINE [BASE_TYPE, OPEN_ARGS]
		redefine
			is_equal, copy
		end

feature -- Access
	
	last_result: RESULT_TYPE
			-- Result of last call, if any.

	item (args: OPEN_ARGS): RESULT_TYPE is
			-- Result of calling function with `args' as operands.
		require
			valid_operands: valid_operands (args)
			callable: callable
		do
			set_operands (args)
			clear_last_result
			Result ?= rout_disp.invoke (target_object, internal_operands)
			if is_cleanup_needed then
				remove_gc_reference
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is associated function the same as the one
			-- associated with `other'?
		do
			Result := Precursor (other) and then
					 equal (last_result, other.last_result)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Use same function as `other'.
		do
			Precursor (other)
			last_result := other.last_result
		end

feature -- Basic operations

	apply is
			-- Call function with `operands' as last set.
		do
			last_result ?= rout_disp.invoke (target_object, internal_operands)
		end

feature -- Obsolete

	eval (args: OPEN_ARGS): RESULT_TYPE is
			-- Result of evaluating function for `args'.
		obsolete
			"Please use `item' instead"
		require
			valid_operands: valid_operands (args)
			callable: callable
		do
			Result := item (args)
		end

feature -- Removal

	clear_last_result is
			-- Reset content of `last_result' to its default value
		local
			l_result: RESULT_TYPE
		do
			last_result := l_result
		end
		
indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class FUNCTION

