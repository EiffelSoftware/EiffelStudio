note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	DEMO_3D

inherit
	WEL_FRAME_WINDOW
		redefine
			on_show
		end

	WEL_STANDARD_PENS
		export
			{NONE} all
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	DOUBLE_MATH
		export
			{NONE} all
		end

	WEL_PS_CONSTANTS
		export
			{NONE} all
		end

	WEL_RASTER_OPERATIONS_CONSTANTS
		export
			{NONE} all
		end

	WEL_PC_CONSTANTS
		export
			{NONE} all
		end
create
	make

feature {NONE} -- Initialization

	make
		do
			create virtual_dcs.make_filled (({WEL_MEMORY_DC}).default, 1, virtual_dcs_count)
			create virtual_bitmaps.make_filled (({WEL_BITMAP}).default, 1, virtual_dcs_count)
			create brushes.make_filled (({WEL_BRUSH}).default,1, max_color)
			create pens.make_filled (({WEL_PEN}).default, 1, max_color)
			make_top ("3D Demo")
			resize (400, 300)
			show
		end

feature -- Access

	ready: BOOLEAN
			-- Is the demo ready?

feature -- Basic operations

	go
		local
			win_dc: WEL_CLIENT_DC
		do
			create win_dc.make (Current)
			win_dc.get
			if dec > virtual_dcs_count then
				dec := 1
			end
			win_dc.bit_blt (0, 0, width, height, virtual_dcs @ dec,
					0, 0, Srccopy)
			dec := dec + 1
			win_dc.release
		end

	on_show
		do
			run_demo
		end

feature {NONE} -- Implementation

	max_color: INTEGER = 200

	virtual_dcs_count: INTEGER = 20

	palette: detachable WEL_PALETTE

	virtual_dcs: ARRAY [WEL_MEMORY_DC]

	virtual_bitmaps: ARRAY [WEL_BITMAP]

	dec: INTEGER

	phase: DOUBLE

	max_x, max_y: INTEGER

	brushes: ARRAY [WEL_BRUSH]

	pens: ARRAY [WEL_PEN]

	run_demo
		local
			x_min, x_max, y_min, y_max, z_min, z_max: REAL_64
			ang, rap: REAL_64
			nx, ny: INTEGER
			number_bitmap: INTEGER
			virtual_dc: WEL_MEMORY_DC
			message: STRING
			win_dc: WEL_CLIENT_DC
			l_palette: like palette
		do
			create win_dc.make (Current)
			win_dc.get
			max_x := client_rect.width
			max_y := client_rect.height
			x_min := -25
			x_max := 25
			y_min := -25
			y_max := 25
			z_min := -6
			z_max := 6
			ang := 3.1415 / 4
			rap := max_y / max_x
			nx := 50
			ny := 50
			initialize_demo (win_dc)
			l_palette := palette
				-- Per postcondition of `initialize_demo'.
			check l_palette_attached: l_palette /= Void end
			win_dc.select_palette (l_palette)
			win_dc.realize_palette
			win_dc.select_brush (White_brush)
			win_dc.rectangle (0, 0, max_x, max_y)
			number_bitmap := Virtual_dcs_count
			message := "Computing "
			message.append (number_bitmap.out)
			message.append (" bitmaps for animation.")
			win_dc.text_out (10, 15, message)
			from
				dec := 1
			until
				dec > Virtual_dcs_count
			loop
				phase := ((dec - 1) * 6.28 / virtual_dcs_count)
				virtual_dc := (virtual_dcs @ dec)
				virtual_dc.select_palette (l_palette)
				virtual_dc.realize_palette
				message := "Now computing bitmap #"
				message.append (dec.out)
				message.extend ('.')
				win_dc.text_out (10, 40, message)
				surface (nx, ny, x_min, x_max, y_min, y_max,
						z_min, z_max, ang, rap)
				dec := dec + 1
			end
			win_dc.release
			ready := True
		end

	initialize_demo (a_dc: WEL_DC)
		local
			log_pal: WEL_LOG_PALETTE
			pal_entry: WEL_PALETTE_ENTRY
			brush: WEL_BRUSH
			color: WEL_COLOR_REF
                        pen: WEL_PEN
			ind: INTEGER
			colors: ARRAY [WEL_COLOR_REF]
			virtual_dc: WEL_MEMORY_DC
			virtual_bitmap: WEL_BITMAP
			l_palette: like palette
		do
			create log_pal.make (768, max_color)
			from
				ind := 0
			until
				ind = max_color
			loop
				create pal_entry.make (12+ 3 * ind // 17,
						  20 + 3 * ind // 13,
						  48 + 3 * ind // 5,
						  Pc_reserved)
				log_pal.set_pal_entry (ind, pal_entry)
				ind := ind + 1
			end
			create l_palette.make (log_pal)
			palette := l_palette
			create colors.make_filled (({WEL_COLOR_REF}).default, 1, max_color)
			from
				ind := 1
			until
				ind > max_color
			loop
				color := l_palette.palette_index (ind - 1)
				colors.force (color,ind)
				create brush.make_solid (color)
				brushes.force (brush, ind)
				create pen.make (Ps_solid, 1, color)
				pens.force (pen, ind)
				ind := ind + 1
			end
			from
				dec := 1
			until
				dec > virtual_dcs_count
			loop
				create virtual_dc.make_by_dc (a_dc)
				create virtual_bitmap.make_compatible (a_dc,
					width, height)
				virtual_dc.select_bitmap (virtual_bitmap)
				virtual_dc.select_brush (white_brush)
				virtual_dc.pat_blt (0,0,width, height, patcopy)
				virtual_dcs.force (virtual_dc, dec)
				virtual_bitmaps.force (virtual_bitmap, dec)
				dec := dec + 1
			end
		ensure
			palette_attached: palette /= Void
		end

	surface (nx, ny: INTEGER; x_min, x_max, y_min, y_max,
			z_min, z_max, ang, rap: REAL_64)
			-- Draw the surface on the compatible dc
		local
			coord: ARRAY [PROJECTION]
			x1, y1, color1, color2, xp, yp, ix, iy: INTEGER
			zmax, zmin, xre, yre, zre, angle: REAL_64
			c1, l1, h1, dx, dy, dz: REAL_64
			p1, q1, s1, p2, r2, s2, xx, yy, z: REAL_64
			x_screen, y_screen: INTEGER
			ind: INTEGER
			poly_coord: ARRAY [INTEGER]
			projected_point: PROJECTION
		do
			create coord.make_filled (({PROJECTION}).default, 1, 1)
			create poly_coord.make_filled (({INTEGER}).default, 1, 6)
			from
				ind := 1
			until
				ind > nx
			loop
				create projected_point
				coord.force (projected_point, ind)
				ind := ind + 1
			variant
				1 + nx - ind
			end
			dx := x_max - x_min
			dy := y_max - y_min
			dz := z_max - z_min
			c1 := max_x / (1 + Rap * Cosine (Ang) * dx / dy)
			l1 := c1 * Rap * dx / dy
			h1 := max_y - l1 * Sine (Ang)
			p1 := - l1 * Cosine (Ang) / dx
			q1 := c1 / dy
			s1 := l1 * Cosine (Ang) - y_min * c1 / dy + x_min * l1 * Cosine (Ang) / dx
			p2 := l1 * Sine (Ang) / dx
			r2 := - h1 / dz
			s2 := max_y - p2 * x_max - r2 * z_min
			xx := x_min
			yy := y_max
			z := evaluate (xx, yy);
			x_screen := (p1 * xx + q1 * yy + s1 ).truncated_to_integer
			y_screen := (p2 * xx + r2 * z + s2 ).truncated_to_integer
			coord.item (ny).set_x (x_screen)
			coord.item (ny).set_y (y_screen)
			coord.item (ny).set_xr (xx)
			coord.item (ny).set_yr (yy)
			coord.item (ny).set_zr (z)
			xp := x_screen
			yp := y_screen
			from
				iy := ny - 1
			until
				iy = 0
			loop
				yy := y_min + iy * dy / ny
				z := evaluate (xx, yy)
				x_screen := (p1 * xx + q1 * yy + s1 ).truncated_to_integer
				y_screen := (p2 * xx + r2 * z + s2 ).truncated_to_integer
				xp := x_screen
				yp := y_screen
				coord.item (iy).set_x (x_screen)
				coord.item (iy).set_y (y_screen)
				coord.item (iy).set_xr (xx)
				coord.item (iy).set_yr (yy)
				coord.item (iy).set_zr (z)
				iy := iy - 1
			end
			from
				ix := nx - 1
			until
				ix = 0
			loop
				xx := x_max - ix * dx / nx
				yy := y_max
				z := evaluate (xx,yy)
				x_screen := (p1 * xx + q1 * yy + s1).truncated_to_integer
				y_screen := (p2 * xx + r2 * z + s2).truncated_to_integer
				zmax := z
				zmin := z
				x1 := coord.item (ny).x
				y1 := coord.item (ny).y
				xre := coord.item (ny).xr
				yre := coord.item (ny).yr
				zre := coord.item (ny).zr
				coord.item (ny).set_x (x_screen)
				coord.item (ny).set_y (y_screen)
				coord.item (ny).set_xr (xx)
				coord.item (ny).set_yr (yy)
				coord.item (ny).set_zr (z)
				xp := x_screen
				yp := y_screen
				from
					iy := ny - 1
				until
					iy = 0
				loop
					yy := y_min + iy * dy / ny
					z := evaluate (xx, yy)
					x_screen := (p1 * xx + q1 * yy + s1 ).truncated_to_integer
					y_screen := (p2 * xx + r2 * z + s2 ).truncated_to_integer
					poly_coord.put (x_screen, 1)
					poly_coord.put (y_screen, 2)
					poly_coord.put (coord.item (iy).x, 3)
					poly_coord.put (coord.item (iy).y, 4)
					poly_coord.put (x1, 5)
					poly_coord.put (y1, 6)
					angle := 1  + compute_angle (xx, yy, z,
						coord.item (iy).xr,
						coord.item (iy).yr,
						coord.item (iy).zr,
						xre, yre, zre)
					color1 := (127 * angle / 255 * 200).truncated_to_integer
					color2 := color1
					fill (poly_coord, color1)
					poly_coord.put (x_screen, 1)
					poly_coord.put (y_screen, 2)
					poly_coord.put (xp, 3)
					poly_coord.put (yp, 4)
					poly_coord.put (x1, 5)
					poly_coord.put (y1, 6)
					fill (poly_coord, color2)
					zmax := z.max( zmax)
					zmin := z.min( zmin)
					x1 := coord.item (iy).x
					y1 := coord.item (iy).y
					xre := coord.item (iy).xr
					yre := coord.item (iy).yr
					zre := coord.item (iy).zr
					coord.item (iy).set_x ( x_screen)
					coord.item (iy).set_y (y_screen)
					coord.item (iy).set_xr (xx)
					coord.item (iy).set_yr (yy)
					coord.item (iy).set_zr (z)
					xp := x_screen
					yp := y_screen
					iy := iy - 1
				end
				ix := ix - 1
			end
		end

	compute_angle (x1, y1, z1, x2, y2, z2, x3, y3, z3: REAL_64): REAL_64
			-- Compute the angle between the surface and the light
		local
			loc_p1, loc_p2, loc_p3, loc_q1, loc_q2, loc_q3: REAL_64
			norm1, norm2, norm3: DOUBLE
			divisor: DOUBLE
		do
			loc_p1 := x2 - x1
			loc_p2 := y2 - y1
			loc_p3 := z2 - z1
			loc_q1 := x3 - x1
			loc_q2 := y3 - y1
			loc_q3 := z3 - z1
			norm1 := loc_p2 * loc_q3 - loc_q2 * loc_p3
			norm2 := loc_p3 * loc_q1 - loc_q3 * loc_p1
			norm3 := loc_p1 * loc_q2 - loc_q1 * loc_p2
			divisor := norm1 * norm1 + norm2 * norm2 + norm3 * norm3
			divisor := sqrt(divisor)
			if divisor /= 0.0 then
				Result := (- 200 * norm2) / (200 * divisor)
			else
				Result := (- 200 * norm2) / 1.0e-20
			end
		end

	evaluate (a_x, a_y: REAL_64): REAL_64
			-- Evaluate the function at `a_x', `a_y' point
		do
			Result :=  sine (sqrt (a_x * a_x + a_y * a_y) - phase )
		end

	fill (a_poly_coord: ARRAY [INTEGER]; color: INTEGER)
			-- Fill the polygon defined by `a_poly_coord'
			-- using `color'
		require
			a_poly_coord_not_void: a_poly_coord /= Void
		do
			(virtual_dcs @ dec).select_pen (pens.item (color))
			(virtual_dcs @ dec).select_brush (brushes.item (color))
			(virtual_dcs @ dec).polygon (a_poly_coord)
		end

	White_brush : WEL_WHITE_BRUSH
		once
			create Result.make
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


end -- class DEMO_3D

