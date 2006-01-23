indexing
	description: "[
			Objects that is a factory for scaled fonts.
			Reduces memory usage and speed up systems with only a few different fonts and a
			lot of EV_MODEL_TEXT objects which uses this fonts and get uniformly scaled.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCALED_FONT_FACTORY
	
inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create an EV_SCALED_FONT_FACTORY
		do
			create scaled_fonts.make (1, max_table_size)
			create orginal_fonts.make (1, max_table_size)
		end

feature -- Access

	registered_font (a_font: EV_FONT): EV_IDENTIFIED_FONT is
			-- Return new identified font for `a_font'
			-- or identified font for `a_font' if same object is registred.
		require
			a_font_not_Void: a_font /= Void
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > max_table_size or else 
				orginal_fonts.item (i) = Void or else
				orginal_fonts.item (i) = a_font
			loop
				i := i + 1
			end
			create Result.make_with_id (a_font, i)
		ensure
			result_not_Void: Result /= Void
		end
		
	scaled_font (an_id_font: EV_IDENTIFIED_FONT; should_height: INTEGER): EV_FONT is
			-- `an_id_font' scaled to `should_height'.
		require
			an_id_font_not_Void: an_id_font /= Void
			should_hight_positive: should_height > 0
		do
			if an_id_font.id > max_table_size then
				Result := scaled_font_internal (an_id_font.font, should_height)
			else
				check
					an_id_font_is_in_table: orginal_fonts.item (an_id_font.id) = an_id_font.font
				end
				Result := scaled_fonts.item (an_id_font.id)
				if Result = Void or else Result.height /= should_height then
					Result := scaled_font_internal (an_id_font.font, should_height)
					scaled_fonts.put (Result, an_id_font.id)
				end
			end
		end
	
feature -- Element change

	register_font (an_id_font: EV_IDENTIFIED_FONT) is
			-- Register `an_id_font' in the factory.
		require
			an_id_font_not_Void: an_id_font /= Void
		local
			i: INTEGER
		do
			i := an_id_font.id
			if i <= max_table_size and then orginal_fonts.item (i) /= an_id_font.font then
				orginal_fonts.put (an_id_font.font, i)
			end
		end
		
	unregister_font (an_id_font: EV_IDENTIFIED_FONT) is
			-- Unregister `an_id_font' if in factory.
		require
			an_id_font_not_Void: an_id_font /= Void
		local
			i: INTEGER
		do
			i := an_id_font.id
			if i <= max_table_size and then orginal_fonts.item (i) = an_id_font.font then
				orginal_fonts.put (Void, i)
				scaled_fonts.put (Void, i)
			end
		end

feature {NONE} -- Implementation

	scaled_fonts: ARRAY [EV_FONT]
			-- Table of scaled fonts.
	
	orginal_fonts: ARRAY [EV_FONT]
			-- Table of orginal fonts for `scaled_fonts'.
	
	max_table_size: INTEGER is 20
			-- Maxmimum size of `scaled_fonts' and `orginal_fonts'.
	
	scaled_font_internal (a_font: EV_FONT; a_height: INTEGER): EV_FONT is
			-- `a_font' scaled to `a_height'.
		require
			a_font_not_Void: a_font /= Void
			a_height_positive: a_height > 0
		do
			if a_font.height = a_height then
				Result := a_font
			else	
				create Result.make_with_values (a_font.family, a_font.weight, a_font.shape, a_height)
				Result.preferred_families.append (a_font.preferred_families)
			end
		ensure
			Result_not_Void: Result /= Void
		end

invariant
	scaled_fonts_not_Void: scaled_fonts /= Void
	orginal_fonts_not_Void: orginal_fonts /= Void

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




end -- class EV_SCALED_FONT_FACTORY

