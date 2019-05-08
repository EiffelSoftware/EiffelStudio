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
	PROCEDURE [OPEN_ARGS -> detachable TUPLE create default_create end]

inherit
	ROUTINE [OPEN_ARGS]
		rename
			call as call alias "()"
		end

create {NONE}
	set_rout_disp,
	set_rout_disp_final

feature -- Calls

	apply
			-- Call procedure with `operands' as last set.
		local
			obj: detachable SYSTEM_OBJECT
		do
			obj := rout_disp.invoke (target_object, internal_operands)
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
