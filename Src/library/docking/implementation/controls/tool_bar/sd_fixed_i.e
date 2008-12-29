note
	description: "Fixed container implementation interface which used by Smart Docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_FIXED_I

inherit
	EV_FIXED_I

feature -- Contract support

	line_width: INTEGER
			-- We need this feature to make sure contract not borken with invariant.
			-- See bug#13387.
		do
		end

	drawing_mode: INTEGER
			-- We need this feature to make sure contract not borken with invariant.
			-- See bug#13387.
		do
		end
		
note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
