note

	description: "[
		Objects representing delayed calls to a procedure.
		with some operands possibly still open.
		Notes: Features are the same as those of ROUTINE,
		with `apply' made effective, and no further
		redefinition of `is_equal' and `copy'.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCEDURE [BASE_TYPE, OPEN_ARGS ->TUPLE create default_create end]

inherit
	ROUTINE [BASE_TYPE, OPEN_ARGS]

feature -- Calls

	apply
			-- Call procedure with `operands' as last set.
		local
			obj: ?SYSTEM_OBJECT
			l_rout_disp: like rout_disp
		do
			l_rout_disp := rout_disp
			check l_rout_disp_attached: l_rout_disp /= Void end
			obj := l_rout_disp.invoke (target_object, internal_operands)
		end

note
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



end -- class PROCEDURE

