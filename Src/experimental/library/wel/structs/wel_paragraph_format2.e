note
	description: "[
		Contains information about paragraph 2 formating
		attributes in a rich edit control. Corresponds to the
		PARAFORMAT2 structure. Note that the implementation is using
		WEL_PARAFORMAT2 due to bugs in Microsoft header files.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PARAGRAPH_FORMAT2

inherit
	WEL_PARAGRAPH_FORMAT
		redefine
			c_size_of_paraformat,
			structure_size
		end

create
	make,
	make_by_pointer

feature -- Access

	effects: INTEGER
			-- Effects applicable to `Current', corresponding to wEffects member.
		do
			Result := cwel_paraformat_get_weffects (item)
		end

	space_before: INTEGER
			-- Size of spacing before paragraph in twips. Corresponds to
			-- dySpaceBefore member.
		do
			Result := cwel_paraformat_get_dyspacebefore (item)
		end

	space_after: INTEGER
			-- Size of spacing after paragraph in twips. Corresponds to
			-- dySpaceAfter member.
		do
			Result := cwel_paraformat_get_dyspaceafter (item)
		end

	line_spacing: INTEGER
			-- Size of spacing between lines. Corresponds to
			-- dyLineSpacing member.
		do
			Result := cwel_paraformat_get_dylinespacing (item)
		end

	style: INTEGER
			-- Text style. Corresponds to sStyle member.
		do
			Result := cwel_paraformat_get_sstyle (item)
		end

	line_spacing_rule: INTEGER
			-- Type of line spacing. Corresponds to bLineSpacingRule member.
		do
			Result := cwel_paraformat_get_blinespacingrule (item)
		end

	shading_weight: INTEGER
			-- Percentage of foreground color used in shading.
			-- Corresponds to wShadingWeight member.
		do
			Result := cwel_paraformat_get_wshadingweight (item)
		end

	shading_style: INTEGER
			-- Style and colors used for background shading.
			-- Corresponds to wShadingStyle member.
		do
			Result := cwel_paraformat_get_wshadingstyle (item)
		end

	numbering_start: INTEGER
			-- Starting number for numbered paragraphs.
			-- Corresponds to wNumberingStart member
		do
			Result := cwel_paraformat_get_wnumberingstart (item)
		end

	numbering_style: INTEGER
			-- Numbering style used with numbered paragraphs.
			-- Corresponds to the wNumberingStyle member.
		do
			Result := cwel_paraformat_get_wnumberingstyle (item)
		end

	numbering_tab: INTEGER
			-- Minimum space between paragraph number and
			-- paragraph text. Corresponds to wNumberingTab mamber.
		do
			Result := cwel_paraformat_get_wnumberingtab (item)
		end

	border_space: INTEGER
			-- Space between border and paragraph text in twips.
			-- Corresponds to wBorderWidth
		do
			Result := cwel_paraformat_get_wborderspace (item)
		end

	border_width: INTEGER
			-- Border width in twips. Corresponds to wBorderWidth member.
		do
			Result := cwel_paraformat_get_wborderwidth (item)
		end

	borders: INTEGER
			-- Border location, style and color. Corresponds to
			-- wBorder member.
		do
			Result := cwel_paraformat_get_wborders (item)
		end

feature -- Element change

	set_effects (an_effects: INTEGER)
			-- Set `effects' to `an_effects'.
		do
			cwel_paraformat_set_weffects (item, an_effects)
		ensure
			effects_set: effects = an_effects
		end

	set_space_before (space: INTEGER)
			-- Set `space_before' to `space'.
		do
			add_mask (Pfm_spacebefore)
			cwel_paraformat_set_dyspacebefore (item, space)
		ensure
			space_set: space_before = space
		end

	set_space_after (space: INTEGER)
			-- Set `space_after' to `space'.
		do
			add_mask (Pfm_spaceafter)
			cwel_paraformat_set_dyspaceafter (item, space)
		ensure
			space_set: space_after = space
		end

	set_line_spacing (space: INTEGER)
			-- Set `line_spacing' to `space'.
		do
			add_mask (Pfm_linespacing)
			cwel_paraformat_set_dylinespacing (item, space)
		ensure
			space_set: line_spacing = space
		end

	set_style (a_style: INTEGER)
			-- Set `style' to `a_style'.
		do
			add_mask (Pfm_style)
			cwel_paraformat_set_sstyle (item, a_style)
		end

	set_line_spacing_rule (a_rule: INTEGER)
			-- Set `line_spacing_rule' to `a_rule'.
		do
			add_mask (pfm_spaceafter)
			cwel_paraformat_set_blinespacingrule (item, a_rule)
		end

	set_shading_weight (a_weight: INTEGER)
			-- Set `shading_widget' to `a_weight'.
		do
			add_mask (Pfm_shading)
			cwel_paraformat_set_wshadingweight (item, a_weight)
		end

	set_shading_style (a_style: INTEGER)
			-- Set `shading_style' to `a_style'.
		do
			add_mask (Pfm_shading)
			cwel_paraformat_set_wshadingstyle (item, a_style)
		end

	set_numbering_start (a_start: INTEGER)
			-- Set `numbering_start' to `a_start'.
		do
			add_mask (Pfm_numberingstart)
			cwel_paraformat_set_wnumberingstart (item, a_start)
		end

	set_numbering_style (a_style: INTEGER)
			-- Set `numbering_style' to `a_style'.
		do
			add_mask (Pfm_numberingstyle)
			cwel_paraformat_set_wnumberingstyle (item, a_style)
		end

	set_numbering_tab (a_tab: INTEGER)
			-- Set `numbering_tab' to `a_tab'.
		do
			add_mask (Pfm_numberingtab)
			cwel_paraformat_set_wnumberingtab (item, a_tab)
		end

	set_border_space (a_space: INTEGER)
			-- Set `border_space' to `a_space'.
		do
			add_mask (pfm_border)
			cwel_paraformat_set_wborderspace (item, a_space)
		end

	set_border_width (a_width: INTEGER)
			-- Set `border_width' to `a_width'.
		do
			add_mask (pfm_border)
			cwel_paraformat_set_wborderwidth (item, a_width)
		end

	set_borders (a_border: INTEGER)
			-- Set `borders' to `a_border'.
		do
			add_mask (pfm_border)
			cwel_paraformat_set_wborders (item, a_border)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_paraformat
		end

feature {NONE} -- Externals

	c_size_of_paraformat: INTEGER
		external
			"C [macro %"redit.h%"]"
		alias
			"sizeof (WEL_PARAFORMAT2)"
		end

	cwel_paraformat_set_weffects (ptr: POINTER; value: INTEGER)
			--
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2, UINT)"
		alias
			"wEffects"
		end

	cwel_paraformat_set_dyspacebefore (ptr: POINTER; value: INTEGER)
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2, UINT)"
		alias
			"dySpaceBefore"
		end

	cwel_paraformat_set_dyspaceafter (ptr: POINTER; value: INTEGER)
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2, UINT)"
		alias
			"dySpaceAfter"
		end

	cwel_paraformat_set_dylinespacing (ptr: POINTER; value: INTEGER)
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2, UINT)"
		alias
			"dyLineSpacing"
		end

	cwel_paraformat_set_sstyle (ptr: POINTER; value: INTEGER)
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2, UINT)"
		alias
			"sStyle"
		end

	cwel_paraformat_set_blinespacingrule (ptr: POINTER; value: INTEGER)
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2, BYTE)"
		alias
			"bLineSpacingRule"
		end

	cwel_paraformat_set_wshadingweight (ptr: POINTER; value: INTEGER)
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2, WORD)"
		alias
			"wShadingWeight"
		end

	cwel_paraformat_set_wshadingstyle (ptr: POINTER; value: INTEGER)
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2, WORD)"
		alias
			"wShadingStyle"
		end

	cwel_paraformat_set_wnumberingstart (ptr: POINTER; value: INTEGER)
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2, WORD)"
		alias
			"wNumberingStart"
		end

	cwel_paraformat_set_wnumberingstyle (ptr: POINTER; value: INTEGER)
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2, WORD)"
		alias
			"wNumberingStyle"
		end

	cwel_paraformat_set_wnumberingtab (ptr: POINTER; value: INTEGER)
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2, WORD)"
		alias
			"wNumberingTab"
		end

	cwel_paraformat_set_wborderspace (ptr: POINTER; value: INTEGER)
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2, WORD)"
		alias
			"wBorderSpace"
		end

	cwel_paraformat_set_wborderwidth (ptr: POINTER; value: INTEGER)
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2, WORD)"
		alias
			"wBorderWidth"
		end

	cwel_paraformat_set_wborders (ptr: POINTER; value: INTEGER)
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2, WORD)"
		alias
			"wBorders"
		end

	cwel_paraformat_get_wborders (ptr: POINTER): INTEGER
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2): WORD"
		alias
			"wBorders"
		end

	cwel_paraformat_get_wborderwidth (ptr: POINTER): INTEGER
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2): WORD"
		alias
			"wBorderWidth"
		end

	cwel_paraformat_get_wborderspace (ptr: POINTER): INTEGER
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2): WORD"
		alias
			"wBorderSpace"
		end

	cwel_paraformat_get_wnumberingtab (ptr: POINTER): INTEGER
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2): WORD"
		alias
			"wNumberingTab"
		end

	cwel_paraformat_get_wnumberingstyle (ptr: POINTER): INTEGER
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2): WORD"
		alias
			"wNumberingStyle"
		end

	cwel_paraformat_get_wnumberingstart (ptr: POINTER): INTEGER
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2): WORD"
		alias
			"wNumberingStart"
		end

	cwel_paraformat_get_wshadingstyle (ptr: POINTER): INTEGER
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2): WORD"
		alias
			"wShadingStyle"
		end

	cwel_paraformat_get_wshadingweight (ptr: POINTER): INTEGER
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2): WORD"
		alias
			"wShadingWeight"
		end

	cwel_paraformat_get_blinespacingrule (ptr: POINTER): INTEGER
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2): BYTE"
		alias
			"bLineSpacingRule"
		end

	cwel_paraformat_get_sstyle (ptr: POINTER): INTEGER
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2): EIF_INTEGER"
		alias
			"sStyle"
		end

	cwel_paraformat_get_dylinespacing (ptr: POINTER): INTEGER
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2): EIF_INTEGER"
		alias
			"dyLineSpacing"
		end

	cwel_paraformat_get_dyspaceafter (ptr: POINTER): INTEGER
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2): EIF_INTEGER"
		alias
			"dySpaceAfter"
		end

	cwel_paraformat_get_dyspacebefore (ptr: POINTER): INTEGER
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2): EIF_INTEGER"
		alias
			"dySpaceBefore"
		end

	cwel_paraformat_get_weffects (ptr: POINTER): INTEGER
		external
			"C [struct %"redit.h%"] (WEL_PARAFORMAT2): EIF_INTEGER"
		alias
			"wEffects"
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

end
