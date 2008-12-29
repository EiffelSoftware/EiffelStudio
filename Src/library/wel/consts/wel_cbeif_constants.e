note
	description	: "Combo-Box-Ex Item Flag (CBEIF) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_CBEIF_CONSTANTS

obsolete
	"Use WEL_COMBO_BOX_CONSTANTS instead."

feature -- Access

	Cbeif_text: INTEGER = 1
			-- The `text' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_TEXT

	Cbeif_image: INTEGER = 2
			-- The `image' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_IMAGE

	Cbeif_selectedimage: INTEGER = 4
			-- The `selected_image' member is valid or must be
			-- filled in.
			--
			-- Declared in Windows as CBEIF_SELECTEDIMAGE

	Cbeif_overlay: INTEGER = 8
			-- The `overlay' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_OVERLAY

	Cbeif_indent: INTEGER = 16
			-- The `indent' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_INDENT

	Cbeif_di_setitem: INTEGER = 268435456
			-- The control should store the item data and not ask
			-- for it again. This flag is used only with the
			-- CBEN_GETDISPINFO notification message.
			--
			-- Declared in Windows as CBEIF_DI_SETITEM

	Cbeif_lparam: INTEGER = 32;
			-- The `lparam' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_LPARAM

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




end -- class WEL_CBEIF_CONSTANTS

