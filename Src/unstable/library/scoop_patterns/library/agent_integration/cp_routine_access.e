note
	description: "Privileged access to a separate ROUTINE object."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_ROUTINE_ACCESS

inherit
	PROCEDURE
		export {ROUTINE}
			all
		end

feature -- Access

	get_closed_operands (a_routine: separate ROUTINE): detachable separate TUPLE
			-- Get the closed operands of `a_routine'.
		do
			Result := a_routine.closed_operands
		end

end
