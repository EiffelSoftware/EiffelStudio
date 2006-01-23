indexing
	description: "[
			Objects that is a factory for scaled pixmaps.
			Reduces memory usage and speed up systems with only a few diffrend pixmaps and a
			lot of EV_MODEL_PICTURE objects which uses this pixmaps and get uniformly scaled.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCALED_PIXMAP_FACTORY
	
inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create an EV_SCALED_PIXMAP_FACTORY
		do
			create scaled_pixmaps.make (1, max_table_size)
			create orginal_pixmaps.make (1, max_table_size)
		end

feature -- Access

	registered_pixmap (a_pixmap: EV_PIXMAP): EV_IDENTIFIED_PIXMAP is
			-- Return new identified font for `a_pixmap'.
		require
			a_pixmap_not_Void: a_pixmap /= Void
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > max_table_size or else 
				orginal_pixmaps.item (i) = Void or else
				orginal_pixmaps.item (i) = a_pixmap
			loop
				i := i + 1
			end
			create Result.make_with_id (a_pixmap, i)
		ensure
			result_not_Void: Result /= Void
		end
		
	scaled_pixmap (an_id_pixmap: EV_IDENTIFIED_PIXMAP; a_width, a_height: INTEGER): EV_PIXMAP is
			-- `an_id_pixmap' scaled to `a_height' and `a_width'.
		require
			an_id_pixmap_not_Void: an_id_pixmap /= Void
			a_hight_positive: a_height > 0
			a_width_positive: a_width > 0
		do
			if an_id_pixmap.id > max_table_size then
				Result := scaled_pixmap_internal (an_id_pixmap.pixmap, a_width, a_height)
			else
				check
					an_id_pixmap_is_in_table: orginal_pixmaps.item (an_id_pixmap.id) = an_id_pixmap.pixmap
				end
				Result := scaled_pixmaps.item (an_id_pixmap.id)
				if Result = Void or else Result.height /= a_height or else Result.width /= a_width then
					Result := scaled_pixmap_internal (an_id_pixmap.pixmap, a_width, a_height)
					scaled_pixmaps.put (Result, an_id_pixmap.id)
				end
			end
		end

feature -- Element change

	register_pixmap (an_id_pixmap: EV_IDENTIFIED_PIXMAP) is
			-- Register `an_id_pixmap' in the factory.
		local
			i: INTEGER
		do
			i := an_id_pixmap.id
			if i <= max_table_size and then orginal_pixmaps.item (i) /= an_id_pixmap.pixmap then
				orginal_pixmaps.put (an_id_pixmap.pixmap, i)
			end
		end

feature {NONE} -- Implementation

	scaled_pixmaps: ARRAY [EV_PIXMAP]
			-- Table of scaled pixmaps.
	
	orginal_pixmaps: ARRAY [EV_PIXMAP]
			-- Table of orginal pixmaps for `scaled_pixmaps'.
	
	max_table_size: INTEGER is 20
			-- Maxmimum size of `scaled_pixmaps' and `orginal_pixmaps'.
	
	scaled_pixmap_internal (a_pixmap: EV_PIXMAP; a_width, a_height: INTEGER): EV_PIXMAP is
			-- `a_font' scaled to `a_height'.
		require
			a_pixmap_not_Void: a_pixmap /= Void
			a_height_positive: a_height > 0
			a_width_positive: a_width > 0
		do
			if a_pixmap.height = a_height and then a_pixmap.width = a_width then
				Result := a_pixmap
			else
				Result := a_pixmap.twin
				Result.stretch (a_width, a_height)
			end
		ensure
			Result_not_Void: Result /= Void
		end

invariant
	scaled_pixmaps_not_Void: scaled_pixmaps /= Void
	orginal_pixmaps_not_Void: orginal_pixmaps /= Void

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




end -- class EV_SCALED_PIXMAP_FACTORY

