indexing
	description: "Tree view item state (TVIS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVIS_CONSTANTS

feature -- Access

	Tvis_bold: INTEGER is 16
			-- The cChildren member is valid.
			--
			-- Declared in Windows as TVIS_BOLD

	Tvis_cut: INTEGER is 4
			-- The iImage member is valid.
			--
			-- Declared in Windows as TVIS_CUT

	Tvis_drophilited: INTEGER is 8
			-- The lParam member is valid.
			--
			-- Declared in Windows as TVIS_DROPHILITED

	Tvis_expanded: INTEGER is 32
			-- The iSelectedImage member is valid.
			--
			-- Declared in Windows as TVIS_EXPANDED

	Tvis_expandedonce: INTEGER is 64
			-- The state and stateMask members are valid.
			--
			-- Declared in Windows as TVIS_EXPANDEDONCE

	Tvis_overlaymask: INTEGER is 3840
			-- The pszText and cchTextMax members are valid.
			--
			-- Declared in Windows as TVIS_OVERLAYMASK

	Tvis_selected: INTEGER is 2
			-- Declared in Windows as TVIS_SELECTED

	Tvis_stateimagemask: INTEGER is 61440
			-- Declared in Windows as TVIS_STATEIMAGEMASK

	Tvis_usermask: INTEGER is 61440
			-- Declared in Windows as TVIS_USERMASK

feature -- Status report

	valid_tvis_constants (value: INTEGER): BOOLEAN is
			-- Is `value' a valid constant?
		do
			Result := value = Tvis_cut or else
					value = Tvis_drophilited or else
					value = Tvis_expanded or else
					value = Tvis_expandedonce or else
					value = Tvis_overlaymask or else
					value = Tvis_selected or else
					value = Tvis_stateimagemask or else
					value = Tvis_usermask
		end 

end -- class WEL_TVIS_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

