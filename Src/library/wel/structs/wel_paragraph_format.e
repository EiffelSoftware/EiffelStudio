indexing
	description: "Contains information about paragraph formating %
		%attributes in a rich edit control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PARAGRAPH_FORMAT

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

	WEL_PFM_CONSTANTS
		export
			{NONE} all
		end

	WEL_PFA_CONSTANTS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

creation
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make is
			-- Make a paragraph format structure.
		do
			structure_make
			cwel_paraformat_set_cbsize (item, structure_size)
		end

feature -- Access

	mask: INTEGER is
			-- Valid information or attributes to set.
			-- See class WEL_PFM_CONSTANTS for values.
			-- This attribut is automatically set by the
			-- features set_*.
		do
			Result := cwel_paraformat_get_dwmask (item)
		end

	numbering: INTEGER is
			-- Numbering type
		do
			Result := cwel_paraformat_get_wnumbering (item)
		end

	alignment: INTEGER is
			-- Alignment type.
			-- See class WEL_PFA_CONSTANTS for values.
		do
			Result := cwel_paraformat_get_walignment (item)
		end

	right_indent: INTEGER is
			-- Size of the right indentation, relative to the right
			-- margin
		do
			Result := cwel_paraformat_get_dxrightindent (item)
		end

	start_indent: INTEGER is
			-- Indentation of the first line in the paragraph
		do
			Result := cwel_paraformat_get_dxstartindent (item)
		end

	offset: INTEGER is
			-- Indentation of the second line and subsequent
			-- lines, relative to the starting indentation. The
			-- first line is indented if this member is negative,
			-- or outdented is this member is positive.
		do
			Result := cwel_paraformat_get_dxoffset (item)
		end

	tabulations: ARRAY [INTEGER] is
			-- Contains tab stops
		local
			i: INTEGER
		do
			from
				create Result.make (0,
					cwel_paraformat_get_ctabcount (item) - 1)
				i := Result.lower
			until
				i = Result.count
			loop
				Result.put (cwel_paraformat_get_rgxtabs (item, i), i)
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	no_numbering is
			-- Remove any numbering.
		do
			add_mask (Pfm_numbering)
			cwel_paraformat_set_wnumbering (item, 0)
		ensure
			no_numbering: numbering = 0
		end

	bullet_numbering is
			-- Add bullets.
		do
			add_mask (Pfm_numbering)
			cwel_paraformat_set_wnumbering (item, Pfn_bullet)
		ensure
			bullet_numbering: numbering = Pfn_bullet
		end

	set_start_indent (a_start_indent: INTEGER) is
			-- Set `start_indent' with `a_start_indent'.
		do
			add_mask (Pfm_startindent)
			cwel_paraformat_set_dxstartindent (item, a_start_indent)
		ensure
			start_indent_set: start_indent = a_start_indent
		end

	set_right_indent (a_right_indent: INTEGER) is
			-- Set `right_indent' with `a_right_indent'.
		do
			add_mask (Pfm_rightindent)
			cwel_paraformat_set_dxrightindent (item, a_right_indent)
		ensure
			right_indent_set: right_indent = a_right_indent
		end

	set_offset (an_offset: INTEGER) is
			-- Set `offset' with `an_offset'.
		do
			add_mask (Pfm_offset)
			cwel_paraformat_set_dxoffset (item, an_offset)
		ensure
			offset_set: offset = an_offset
		end

	set_alignment (an_alignment: INTEGER) is
			-- Set `alignment' with `an_alignment'.
			-- See class WEL_PFA_CONSTANTS for values.
		do
			add_mask (Pfm_alignment)
			cwel_paraformat_set_walignment (item, an_alignment)
		ensure
			alignment_set: alignment = an_alignment
		end

	set_left_alignment is
			-- Paragraphs are aligned with the left margin.
		do
			set_alignment (Pfa_left)
		ensure
			alignment_set: alignment = Pfa_left
		end

	set_right_alignment is
			-- Paragraphs are aligned with the right margin.
		do
			set_alignment (Pfa_right)
		ensure
			alignment_set: alignment = Pfa_right
		end

	set_center_alignment is
			-- Paragraphs are centered.
		do
			set_alignment (Pfa_center)
		ensure
			alignment_set: alignment = Pfa_center
		end

	set_tabulations (tabs: ARRAY [INTEGER]) is
			-- Set tabulation stops using the values of `tabs'.
		require
			tabs_not_void: tabs /= Void
			tabs_count: tabs.count <= Max_tab_stops
		local
			i, j: INTEGER
		do
			from
				add_mask (Pfm_tabstops)
				cwel_paraformat_set_ctabcount (item, tabs.count)
				i := tabs.lower
			until
				i > tabs.upper
			loop
				cwel_paraformat_set_rgxtabs (item,
					tabs.item (i), j)
				i := i + 1
				j := j + 1
			end
		ensure
			tabulations_set: tabulations.is_equal (tabs)
		end

	set_tabulation (tab: INTEGER) is
			-- Set a tab stop at every `tab'.
		local
			a: ARRAY [INTEGER]
			i: INTEGER
		do
			from
				create a.make (0, Max_tab_stops - 1)
				i := a.lower
			until
				i = a.count
			loop
				a.put (i * tab, i)
				i := i + 1
			end
			set_tabulations (a)
		end

	set_default_tabulation is
			-- Set the default tabulation.
		do
			set_tabulations (<<Default_tab_value>>)
		end

	set_mask (a_mask: INTEGER) is
			-- Set `mask' with `a_mask'.
			-- See class WEL_PFM_CONSTANTS for `a_mask' values.
		do
			cwel_paraformat_set_dwmask (item, a_mask)
		ensure
			mask_set: mask = a_mask
		end

	add_mask (a_mask: INTEGER) is
			-- Add `a_mask' to `mask'.
			-- See class WEL_PFM_CONSTANTS for `a_mask' values.
		do
			set_mask (set_flag (mask, a_mask))
		ensure
			has_mask: has_mask (a_mask)
		end

	remove_mask (a_mask: INTEGER) is
			-- Remove `a_mask' from `mask'.
			-- See class WEL_PFM_CONSTANTS for `a_mask' values.
		do
			set_mask (clear_flag (mask, a_mask))
		ensure
			has_not_mask: not has_mask (a_mask)
		end

feature -- Status report

	has_mask (a_mask: INTEGER): BOOLEAN is
			-- Is `a_mask' set in `mask'?
			-- See class WEL_PFM_CONSTANTS for `a_mask' values.
		do
			Result := flag_set (mask, a_mask)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_paraformat
		end

	Max_tab_stops: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"MAX_TAB_STOPS"
		end

feature {NONE} -- Externals

	c_size_of_paraformat: INTEGER is
		external
			"C [macro <parafmt.h>]"
		alias
			"sizeof (PARAFORMAT)"
		end

	cwel_paraformat_set_cbsize (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <parafmt.h>]"
		end

	cwel_paraformat_set_dwmask (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <parafmt.h>]"
		end

	cwel_paraformat_set_wnumbering (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <parafmt.h>]"
		end

	cwel_paraformat_set_dxstartindent (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <parafmt.h>]"
		end

	cwel_paraformat_set_dxrightindent (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <parafmt.h>]"
		end

	cwel_paraformat_set_dxoffset (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <parafmt.h>]"
		end

	cwel_paraformat_set_walignment (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <parafmt.h>]"
		end

	cwel_paraformat_set_ctabcount (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <parafmt.h>]"
		end

	cwel_paraformat_set_rgxtabs (ptr: POINTER; value: INTEGER; index: INTEGER) is
		external
			"C [macro <parafmt.h>]"
		end

	cwel_paraformat_get_dwmask (ptr: POINTER): INTEGER is
		external
			"C [macro <parafmt.h>]"
		end

	cwel_paraformat_get_wnumbering (ptr: POINTER): INTEGER is
		external
			"C [macro <parafmt.h>]"
		end

	cwel_paraformat_get_dxstartindent (ptr: POINTER): INTEGER is
		external
			"C [macro <parafmt.h>]"
		end

	cwel_paraformat_get_dxrightindent (ptr: POINTER): INTEGER is
		external
			"C [macro <parafmt.h>]"
		end

	cwel_paraformat_get_dxoffset (ptr: POINTER): INTEGER is
		external
			"C [macro <parafmt.h>]"
		end

	cwel_paraformat_get_walignment (ptr: POINTER): INTEGER is
		external
			"C [macro <parafmt.h>]"
		end

	cwel_paraformat_get_ctabcount (ptr: POINTER): INTEGER is
		external
			"C [macro <parafmt.h>]"
		end

	cwel_paraformat_get_rgxtabs (ptr: POINTER; index: INTEGER): INTEGER is
		external
			"C [macro <parafmt.h>]"
		end

	Pfn_bullet: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"PFN_BULLET"
		end

	Default_tab_value: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"lDefaultTab"
		end

end -- class WEL_PARAGRAPH_FORMAT


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

