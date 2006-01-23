indexing

	description: "Fillable figure"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	FILLABLE 

feature -- Access

	stipple: PIXMAP;
			-- Stipple used to fill when `is_stippled_fill' or
			-- `is_opaque_stippled_fill'

	tile: PIXMAP;
			-- Tile used to fill when `is_tiled_fill'

feature -- Element change

	set_even_odd_rule is
			-- Specifies that areas are not filled if they overlap an odd
			-- number of times.
		do
			is_even_odd_rule := true;
		end;

	set_opaque_stippled_fill is
			-- Specifies that graphics sould be drawn using stipple, using
			-- the foreground pixel value for set bits in stipple and the
			-- background pixel value for unset bits in stipple.
		do
			fill_style := FillOpaqueStippled;
		end;

	set_solid_fill is
			-- Specifies that graphics should be drawn using the foreground
			-- pixel value.
		do
			fill_style := FillSolid;
		end;

	set_stipple (a_pixmap: PIXMAP) is
			-- Set `stipple' to `a_pixmap'.
		require
			a_pixmap_valid: (a_pixmap /= Void) implies a_pixmap.is_valid
		do
			stipple := a_pixmap;
		ensure
			stipple = a_pixmap
		end;

	set_stippled_fill is
			-- Specifies that graphics sould be drawn using the foreground
			-- pixel value masked by stipple. In otherwords, bits set in
			-- the source and stipple are drawn in the foreground pixel
			-- value.
		do
			fill_style := FillStippled;
		end;

	set_tile (a_pixmap: PIXMAP) is
			-- Set `tile' to `a_pixmap'.
		require
			a_pixmap_valid: (a_pixmap /= Void) implies a_pixmap.is_valid
		do
			tile := a_pixmap;
		ensure
			tile = a_pixmap
		end;

	set_tiled_fill is
			-- Specifies that graphics sould be drawn using the tile pixmap.
		do
			fill_style := FillTiled;
		end;

	set_winding_rule is
			-- Specifies that overlapping areas are always filled.
		do
			is_even_odd_rule := false;
		end;

feature -- Status report 

	is_even_odd_rule: BOOLEAN;
			-- Are areas filled if they overlap an odd number of times ?

	is_opaque_stippled_fill: BOOLEAN is
			-- Is graphics drawn using stipple, using the foreground pixel
			-- value for set bits in stipple and the background pixel value
			-- for unset bits in stipple ?
		do
			Result := fill_style = FillOpaqueStippled
		end;

	is_solid_fill: BOOLEAN is
			-- Is graphics drawn using the foreground pixel value ?
		do
			Result := fill_style = FillSolid
		end;

	is_stippled_fill: BOOLEAN is
			-- Is graphics drawn using the foreground pixel value masked by
			-- stipple. In otherwords, bits set in the source and stipple are
			-- drawn in the foreground pixel value ?
		do
			Result := fill_style = FillStippled
		end;

	is_tiled_fill: BOOLEAN is
			-- Is graphics drawn using the tile pixmap ?
		do
			Result := fill_style = FillTiled
		end;

feature {NONE} -- Access

	fill_style: INTEGER;
			-- Style of fill of the graphic

	FillOpaqueStippled: INTEGER is 3;
			-- Code to define opaque stippled fill style

	FillSolid: INTEGER is 0;
			-- Code to define solid fill style

	FillStippled: INTEGER is 2;
			-- Code to define stippled fill style

	FillTiled: INTEGER is 1;
			-- Code to define tiled fill style

invariant

	valid_stipple: (stipple /= Void) implies stipple.is_valid;
	valid_tile: (tile /= Void) implies tile.is_valid

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




end -- class FILLABLE

