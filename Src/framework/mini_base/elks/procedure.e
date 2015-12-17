note
	description: "[
		Objects representing delayed calls to a procedure.
		with some operands possibly still open.
		
		Note: Features are the same as those of ROUTINE,
			with `apply' made effective, and no further
			redefinition of `is_equal' and `copy'.
		]"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCEDURE [OPEN_ARGS -> detachable TUPLE create default_create end]

inherit
	ROUTINE [OPEN_ARGS]

feature

	call alias "()" (args: detachable separate OPEN_ARGS)
		do
			if attached {detachable separate OPEN_ARGS} default then
				
			end
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
