indexing

	description: "Fillable figure";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	EC_FILLABLE 

feature -- Access

	stipple: EV_PIXMAP;
			-- Stipple used to fill when `is_stippled_fill' or
			-- `is_opaque_stippled_fill'

	tile: EV_PIXMAP;
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

	set_stipple (a_pixmap: EV_PIXMAP) is
			-- Set `stipple' to `a_pixmap'.
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

	set_tile (a_pixmap: EV_PIXMAP) is
			-- Set `tile' to `a_pixmap'.
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

end -- class FILLABLE


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

