note
	description: "List view item styles (LVIS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LVIS_CONSTANTS

obsolete
	"use WEL_LIST_VIEW_CONSTANTS instead"

feature -- Access

	Lvis_cut: INTEGER = 4
			-- The item is marked for a cut and paste operation.
			--
			-- Declared in Windows as LVIS_CUT

	Lvis_drophilited: INTEGER = 8
			-- The item is highlighted as a drag-and-dop target.
			--
			-- Declared in Windows as LVIS_DROPHILITED

	Lvis_focused: INTEGER = 1
			-- The item has the focus.
			--
			-- Declared in Windows as LVIS_FOCUSED

	Lvis_selected: INTEGER = 2
			-- The item is selected.
			--
			-- Declared in Windows as LVIS_SELECTED

feature -- Status report

	valid_lvis_constants (value: INTEGER): BOOLEAN
			-- Is `value' a valid constant?
		do
			Result := value = Lvis_cut or else
				value = Lvis_drophilited or else
				value = Lvis_focused or else
				value = Lvis_selected
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




end -- class WEL_LVIS_CONSTANTS

