indexing
	description: "This class is a MS_WINDOWS mouse button manager"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BUTTONS_MANAGER_WINDOWS

feature {NONE} -- Implementation

	left_button_down_implementation: BOOLEAN_REF is
			-- Implementation for left_button_down
		once
			create Result
		ensure
			result_exists: Result /= Void
		end

	left_button_down: BOOLEAN is
			-- Is the left button down?
		do
			Result := left_button_down_implementation.item
		end

	middle_button_down_implementation: BOOLEAN_REF is
			-- Implementation for the middle_button_down
		once
			create Result
		ensure
			result_exists: Result /= Void
		end

	middle_button_down: BOOLEAN is
			-- Is the middle button down?
		do
			Result := middle_button_down_implementation.item
		end

	right_button_down_implementation: BOOLEAN_REF is
			-- Implementation for right_button_down
		once
			create Result
		ensure
			result_exists: Result /= Void
		end

	right_button_down: BOOLEAN is
			-- Is the right button down?
		do
			Result := right_button_down_implementation.item
		end

	buttons_state, buttons: BUTTONS is
			-- State of the mouse buttons
		do
			create Result.make (5)
			Result.put (left_button_down, 1)
			Result.put (middle_button_down, 2)
			Result.put (right_button_down, 3)
			Result.put (False, 4)
			Result.put (False, 5)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class BUTTONS_MANAGER_WINDOWS

