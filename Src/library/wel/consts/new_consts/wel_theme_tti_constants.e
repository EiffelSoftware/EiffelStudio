indexing
	description: "[
					TTI constants  (TTIS_XXX, TTIBES_XXX, TTILES_XXX, TTIRES_XXX)
						 which are used by theme manager.
					Values from MSDN "Parts and States"
						 															]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_THEME_TTI_CONSTANTS

feature -- TAB TOPTABITEM states

	ttis_normal: INTEGER is 1
			-- TTIS_NORMAL

	ttis_hot: INTEGER is 2
			-- TTIS_HOT			

	ttis_selected: INTEGER is 3
			-- TTIS_SELECTED

	ttis_disabled: INTEGER is 4
			-- TTIS_DISABLED

	ttis_focused: INTEGER is 5
			-- TTIS_FOCUSED

feature -- TAB TOPTABITEMBOTHEDGES states

	ttibes_normal: INTEGER is 1
			-- TTIBES_NORMAL

	ttibes_hot: INTEGER is 2
			-- TTIBES_HOT

	ttibes_selected: INTEGER is 3
			-- TTIBES_SELECTED

	ttibes_disabled: INTEGER is 4
			-- TTIBES_DISABLED

	ttibes_focused: INTEGER is 5
			-- TTIBES_FOCUSED

feature -- TAB TOPTABITEMLEFTEDGE states

	ttiles_normal: INTEGER is 1
			-- TTILES_NORMAL

	ttiles_hot: INTEGER is 2
			-- TTILES_HOT

	ttiles_selected: INTEGER is 3
			-- TTILES_SELECTED

	ttiles_disabled: INTEGER is 4
			-- TTILES_DISABLED

	ttiles_focused: INTEGER is 5
			-- TTILES_FOCUSED

feature -- TAB TOPTABITEMRIGHTEDGE states

	ttires_normal: INTEGER is 1
			-- TTIRES_NORMAL

	ttires_hot: INTEGER is 2
			-- TTIRES_HOT

	ttires_selected: INTEGER is 3
			-- TTIRES_SELECTED

	ttires_disabled: INTEGER is 4
			-- TTIRES_DISABLED

	ttires_focused: INTEGER is 5;
			-- TTIRES_FOCUSED

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
