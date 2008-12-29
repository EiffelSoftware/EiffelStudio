note
	description:
		"[
			Base class for simple scored line separator widgets.
			See EV_HORIZONTAL_SEPARATOR and EV_VERTICAL_SEPARATOR.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "separator, line, score"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SEPARATOR

inherit
	EV_PRIMITIVE
		redefine
			implementation,
			is_in_default_state_for_tabs
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_SEPARATOR_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Initialize

	is_in_default_state_for_tabs: BOOLEAN
		do
			Result := not is_tabable_from and not is_tabable_to
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_SEPARATOR

