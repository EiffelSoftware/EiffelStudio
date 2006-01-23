indexing
	description: "[
		Contains information about charformat 2 formating
		attributes in a rich edit control. Corresponds to the
		CHARFORMAT2 structure. Some of the reserved attributes or those only
		 used with TOM interfaces are not yet available.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CHARACTER_FORMAT2

inherit
	WEL_CHARACTER_FORMAT
		redefine
			c_size_of_charformat,
			structure_size
		end
		
create
	make,
	make_by_pointer

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_charformat
		end

feature -- Status report

	weight: INTEGER is
			-- Weight, corresponding to the wWeight member.
		do
			Result := cwel_charformat_get_wweight (item)	
		end
	
	spacing: INTEGER is
			-- Spacing, corresponding to the sSpacing member.
		do
			Result := cwel_charformat_get_sspacing (item)
		end
	
	background_color: WEL_COLOR_REF is
			-- Background color, corresponding to the crBackColor member.
		do
			create Result.make_by_color (
				cwel_charformat_get_crbackcolor (item))
		ensure
			result_not_void: Result /= Void
		end
		
	underline_type: INTEGER is
			-- Type of underline, corresponding to the bUnderlineType member.
		do
			Result := cwel_charformat_get_bunderlinetype (item)
		end

	revision_author: INTEGER is
			-- Index used to identify author making a revision, corresponding to the
			-- bRevAuthor member.
		do
			Result := cwel_charformat_get_brevauthor (item)
		end

feature -- Status setting

	set_background_color (color_ref: WEL_COLOR_REF) is
			-- Assign `color_ref' to `background_color'.
		do
			add_mask (cfm_backcolor)
			cwel_charformat_set_crbackcolor (item, color_ref.item)
		end
		
	set_weight (a_weight: INTEGER) is
			-- Assign `a_weight' to `weight'.
		do
			add_mask (cfm_weight)
			cwel_charformat_set_wweight (item, a_weight)
		end
		
	set_spacing (a_spacing: INTEGER) is
			-- Assign `a_spacing' to `spacing'.
		do
			add_mask (cfm_spacing)
			cwel_charformat_set_sspacing (item, a_spacing)
		end
		
	set_underline_type (a_type: INTEGER) is
			-- Assign `a_type' to `underline_type'.
		do
			add_mask (cfm_underlinetype)
			cwel_charformat_set_bunderlinetype (item, a_type)
		end
		
	set_revision_author (an_author: INTEGER) is
			-- Assign `an_author' to `revision_author'.
		do
			add_mask (cfm_revauthor)
			cwel_charformat_set_brevauthor (item, an_author)
		end

feature {NONE} -- Externals

	c_size_of_charformat: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"sizeof (CHARFORMAT2)"
		end
		
	cwel_charformat_get_crbackcolor (ptr: POINTER): INTEGER is
		external
			"C [struct %"redit.h%"] (CHARFORMAT2): EIF_INTEGER"
		alias
			"crBackColor"
		end
		
	cwel_charformat_set_crbackcolor (ptr: POINTER; value: INTEGER) is
		external
			"C [struct %"redit.h%"] (CHARFORMAT2, EIF_INTEGER)"
		alias
			"crBackColor"
		end
		
	cwel_charformat_get_wweight (ptr: POINTER): INTEGER is
		external
			"C [struct %"redit.h%"] (CHARFORMAT2): EIF_INTEGER"
		alias
			"wWeight"
		end
		
	cwel_charformat_set_wweight (ptr: POINTER; value: INTEGER) is
		external
			"C [struct %"redit.h%"] (CHARFORMAT2, EIF_INTEGER)"
		alias
			"wWeight"
		end
		
	cwel_charformat_get_sspacing (ptr: POINTER): INTEGER is
		external
			"C [struct %"redit.h%"] (CHARFORMAT2): EIF_INTEGER"
		alias
			"sSpacing"
		end
		
	cwel_charformat_set_sspacing (ptr: POINTER; value: INTEGER) is
		external
			"C [struct %"redit.h%"] (CHARFORMAT2, EIF_INTEGER)"
		alias
			"sSpacing"
		end
		
	cwel_charformat_get_bunderlinetype (ptr: POINTER): INTEGER is
		external
			"C [struct %"redit.h%"] (CHARFORMAT2): EIF_INTEGER"
		alias
			"bUnderlineType"
		end
		
	cwel_charformat_set_bunderlinetype (ptr: POINTER; value: INTEGER) is
		external
			"C [struct %"redit.h%"] (CHARFORMAT2, EIF_INTEGER)"
		alias
			"bUnderlineType"
		end
		
	cwel_charformat_get_brevauthor (ptr: POINTER): INTEGER is
		external
			"C [struct %"redit.h%"] (CHARFORMAT2): EIF_INTEGER"
		alias
			"bRevAuthor"
		end
		
	cwel_charformat_set_brevauthor (ptr: POINTER; value: INTEGER) is
		external
			"C [struct %"redit.h%"] (CHARFORMAT2, EIF_INTEGER)"
		alias
			"bRevAuthor"
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




end -- class WEL_CHARACTER_FORMAT2

