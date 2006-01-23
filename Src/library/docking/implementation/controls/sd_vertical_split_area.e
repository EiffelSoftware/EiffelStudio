indexing
	description: "[
			Same as EV_VERTICAL_SPLIT_AREA, except that when double click it'll set it's proportion to 50%.
			A decorator.
																										]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_VERTICAL_SPLIT_AREA

inherit
	EV_VERTICAL_SPLIT_AREA
		redefine
			initialize
		end

feature {NONE} -- Redefine

	initialize is
			-- Redefine
		do
			Precursor {EV_VERTICAL_SPLIT_AREA}
			pointer_double_press_actions.force_extend (agent set_proportion (0.5))
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




end
