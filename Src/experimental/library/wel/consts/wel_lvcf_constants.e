note
	description: "List view column flag (LVCF) constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LVCF_CONSTANTS

obsolete
	"use WEL_LIST_VIEW_CONSTANTS instead"

feature -- Column Flags (General)

	Lvcf_fmt: INTEGER = 1
			-- The fmt member is valid.
			--
			-- Declared in Windows as LVCF_FMT

	Lvcf_subitem: INTEGER = 8
			-- The iSubItem member is valid.
			--
			-- Declared in Windows as LVCF_SUBITEM

	Lvcf_text: INTEGER = 4
			-- The pszText member is valid.
			--
			-- Declared in Windows as LVCF_TEXT

	Lvcf_width: INTEGER = 2
			-- The cx member is valid.
			--
			-- Declared in Windows as LVCF_WIDTH

	Lvcf_image: INTEGER = 16
			-- The ilmage member is valid
			--
			-- Declared in Windows as LVCF_IMAGE

feature -- Column Flags (Format)

	Lvcfmt_right: INTEGER = 1
			-- alignment of the column : right.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
			--
			-- Declared in Windows as LVCFMT_RIGHT

	Lvcfmt_center: INTEGER = 2
			-- alignment of the column : center.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
			--
			-- Declared in Windows as LVCFMT_CENTER

	Lvcfmt_left: INTEGER = 0
			-- alignment of the column : left.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
			--
			-- Declared in Windows as LVCFMT_LEFT

	Lvcfmt_justifymask: INTEGER = 3
			-- alignment of the column : justify.
			-- Do not use for the first column of the list view
			-- that must always be left-aligned.
			--
			-- Declared in Windows as LVCFMT_JUSTIFYMASK

feature -- Validation

	valid_lvcfmt_constant (value: INTEGER): BOOLEAN
			-- Is `value' a valid lvcfmt constant?
		do
			Result := value = Lvcfmt_left or else
				value = Lvcfmt_center or else
				value = Lvcfmt_right or else
				value = Lvcfmt_justifymask
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




end -- class WEL_LVCF_CONSTANTS

