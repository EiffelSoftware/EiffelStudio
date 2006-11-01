indexing
	description: "Constants used by the miner"
	author: "Jocelyn FIAT"
	version: "1.2"
	date: "$Date$"
	revision: "$Revision$"

class
	MINER_CONSTANTS

feature -- Level

	Level_default: INTEGER is 4
	Level_min: INTEGER is 2
	Level_max: INTEGER is 6

feature -- rows and columns

	X_max: INTEGER is 40
	Y_max: INTEGER is 40

feature -- pixmap size

	X_size: INTEGER is 13
	Y_size: INTEGER is 13

	restart_x_size: INTEGER is 36
	restart_y_size: INTEGER is 36

feature -- colors

	transparent: BOOLEAN
			-- Does the pixmap have transparent background ?
	
	set_transparent (val: like transparent) is
		do
			transparent := val
		end

	colors: EV_STOCK_COLORS is
		once
			create Result
		end

	bg_color: EV_COLOR is
		once
			Result := colors.black
		end
	fg_color: EV_COLOR is
		once
			Result := colors.yellow
		end
	fg_time_color: EV_COLOR is
		once
			Result := colors.green
		end

	fg_button_color: EV_COLOR is
		once
			create Result
			Result.set_rgb_with_8_bit (0,0,160)
		end
	bg_button_color: EV_COLOR is
		once
			create Result
			Result.set_rgb_with_8_bit (255,255,255)
		end

	fg_restart_button_color: EV_COLOR is
		once
			create Result
			Result.set_rgb_with_8_bit (255,255,255)
		end
	bg_restart_button_color: EV_COLOR is
		once
			create Result
			Result.set_rgb_with_8_bit (128,0,0)
		end
	fg_level_button: EV_COLOR is
		once
			create Result
			Result.set_rgb_with_8_bit (255,255,0)
		end
	bg_level_button: EV_COLOR is
		once
			create Result
			Result.set_rgb_with_8_bit (0,0,0)
		end
	fg_boum_button_color: EV_COLOR is
		once
			create Result
			Result.set_rgb_with_8_bit (255,0,0)
		end
	bg_boum_button_color: EV_COLOR is
		once
			create Result
			Result.set_rgb_with_8_bit (0,0,0)
		end
	fg_mark_nok_button: EV_COLOR is
		once
			create Result
			Result.set_rgb_with_8_bit (255,255,0)
		end
	fg_mark_button_color: EV_COLOR is
		once
			create Result
			Result.set_rgb_with_8_bit (255,255,255)
		end
	bg_mark_button_color: EV_COLOR is
		once
			create Result
			Result.set_rgb_with_8_bit (0,0,0)
		end
	fg_first_button_color: EV_COLOR is
		once
			create Result
			Result.set_rgb_with_8_bit (0,128,205)
		end
	bg_first_button_color: EV_COLOR is
		once
			create Result
			Result.set_rgb_with_8_bit (0,64,128)
		end

feature -- pixmap

	pix_about: EV_PIXMAP is
		local
			pix: EV_PIXMAP
		once
			create pix.make_with_size ((2+X_size) * 2, (1+Y_size) * 10)
			pix.set_background_color (colors.black)
			pix.clear

			pix.draw_pixmap (1,1+ 0 * (1+Y_size) , pix_levelup)
			pix.draw_pixmap (2+X_size,1+ 0 * (1+Y_size) , pix_levelup)
			pix.draw_pixmap (1,1 * (1+Y_size) , pix_first)
			pix.draw_pixmap (1,2 * (1+Y_size) , pix_but @ 0)
			pix.draw_pixmap (2+X_size,1 * (1+Y_size) , pix_but @ 0)
			pix.draw_pixmap (2+X_size,2 * (1+Y_size) , pix_first)

			pix.draw_pixmap (1,3 * (1+Y_size) , pix_but @ 1)
			pix.draw_pixmap (1,4 * (1+Y_size) , pix_but @ 3)
			pix.draw_pixmap (1,5 * (1+Y_size) , pix_but @ 5)
			pix.draw_pixmap (1,6 * (1+Y_size) , pix_but @ 7)

			pix.draw_pixmap (2+X_size,3 * (1+Y_size) , pix_but @ 2)
			pix.draw_pixmap (2+X_size,4 * (1+Y_size) , pix_but @ 4)
			pix.draw_pixmap (2+X_size,5 * (1+Y_size) , pix_but @ 6)
			pix.draw_pixmap (2+X_size,6 * (1+Y_size) , pix_but @ 8)

			pix.draw_pixmap (1,7 * (1+Y_size) , pix_mark)
			pix.draw_pixmap (1,8 * (1+Y_size) , pix_boum)
			pix.draw_pixmap (2+X_size,7 * (1+Y_size) , pix_boum)
			pix.draw_pixmap (2+X_size,8 * (1+Y_size) , pix_mark)

			pix.draw_pixmap (1,9 * (1+Y_size) , pix_leveldown)
			pix.draw_pixmap (2+X_size,9 * (1+Y_size) , pix_leveldown)
			Result := pix
		end

	pix_restart: EV_PIXMAP is
		local
			coord1: EV_COORDINATE
			coord2: EV_COORDINATE
			coord3: EV_COORDINATE
			coord4: EV_COORDINATE
		once
			create Result.make_with_size (restart_x_size,restart_y_size)
  			Result.set_background_color (bg_restart_button_color)
  			Result.set_foreground_color (fg_restart_button_color)
			Result.clear

			create coord1.set (0,0)
			create coord2.set (0,restart_y_size -1)
			create coord3.set (restart_x_size -1,restart_y_size -1)
			create coord4.set (restart_x_size -1,0)
			Result.draw_polyline (<<coord1,coord2,coord3,coord4>>, True)

  			Result.set_foreground_color (fg_restart_button_color)
			Result.set_line_width (3)
 			create coord1.set (3 * restart_x_size // 7, 2 * restart_y_size // 7)
 			create coord2.set (5 * restart_x_size // 7, 2 * restart_y_size // 7)
 			create coord3.set (5 * restart_x_size // 7, 4 * restart_y_size // 7)
			Result.draw_polyline (<<coord1,coord2,coord3>>, False)

 			create coord1.set (2 * restart_x_size // 7, 3 * restart_y_size // 7)
 			create coord2.set (2 * restart_x_size // 7, 5 * restart_y_size // 7)
 			create coord3.set (4 * restart_x_size // 7, 5 * restart_y_size // 7)
			Result.draw_polyline (<<coord1,coord2,coord3>>, False)

			--| Arrows...
 			create coord1.set (+2 + 3 * restart_x_size // 7, -4 + 2 * restart_y_size // 7)
 			create coord2.set (-2 + 3 * restart_x_size // 7, 2 * restart_y_size // 7)
 			create coord3.set (+2 + 3 * restart_x_size // 7,  4 + 2 * restart_y_size // 7)
			Result.draw_polyline (<<coord1,coord2,coord3>>, False)

 			create coord1.set (-2 + 4 * restart_x_size // 7, -4 + 5 * restart_y_size // 7)
 			create coord2.set (+2 + 4 * restart_x_size // 7, 5 * restart_y_size // 7)
 			create coord3.set (-2 + 4 * restart_x_size // 7,  4 + 5 * restart_y_size // 7)
			Result.draw_polyline (<<coord1,coord2,coord3>>, False)


		end

	pix_levelup: EV_PIXMAP is
		local
			coord1: EV_COORDINATE
			coord2: EV_COORDINATE
			coord3: EV_COORDINATE
		once
			create Result.make_with_size (X_size,Y_size)
   			Result.set_foreground_color (fg_level_button)
			Result.set_background_color (bg_level_button)
			Result.clear

 			create coord1.set (6,5)
 			create coord2.set (3,8)
 			create coord3.set (9,8)
			Result.fill_polygon (<<coord1,coord2,coord3>>)
		end
	pix_leveldown: EV_PIXMAP is
		local
			coord1: EV_COORDINATE
			coord2: EV_COORDINATE
			coord3: EV_COORDINATE
		once
			create Result.make_with_size (X_size,Y_size)
  			Result.set_foreground_color (fg_level_button)
			Result.set_background_color (bg_level_button)
			Result.clear

 			create coord1.set (6,8)
 			create coord2.set (3,5)
 			create coord3.set (9,5)
			Result.fill_polygon (<<coord1,coord2,coord3>>)
		end
	pix_boum: EV_PIXMAP is
		once
			create Result.make_with_size (X_size,Y_size)
  			Result.set_foreground_color (fg_boum_button_color)
			Result.set_line_width (3)
			if not transparent then
				Result.set_background_color (bg_boum_button_color)
				Result.clear
			end

 			Result.draw_segment (2,2, 9,10)

 			Result.draw_segment (9,2, 2,10)
		end

	pix_mark_nok: EV_PIXMAP is
		once
			create Result.make_with_size (X_size,Y_size)
  			Result.set_foreground_color (fg_mark_nok_button)
			Result.set_line_width (3)
			if not transparent then
				Result.set_background_color (bg_mark_button_color)
				Result.clear
			end

 			Result.draw_segment (6,3, 6,9)

 			Result.draw_segment (3,6, 9,6)
		end
	pix_mark: EV_PIXMAP is
		once
			create Result.make_with_size (X_size,Y_size)
  			Result.set_foreground_color (fg_mark_button_color)
			Result.set_line_width (3)
			if not transparent then
				Result.set_background_color (bg_mark_button_color)
				Result.clear
			end

 			Result.draw_segment (6,3, 6,9)

 			Result.draw_segment (3,6, 9,6)
		end

	pix_first: EV_PIXMAP is
		once
			create Result.make_with_size (X_size,Y_size)
  			Result.set_foreground_color (fg_first_button_color)
			if not transparent then
				Result.set_background_color (bg_first_button_color)
				Result.clear
			end
			Result.draw_ellipse (2,8, 3,3)
			Result.draw_ellipse (10,2, 5,4)
			Result.draw_ellipse (10,10, 2,2)
		end

	pix_b (s: STRING): EV_PIXMAP is
		do
			create Result.make_with_size (X_size,Y_size)
  			Result.set_foreground_color (fg_button_color)
			if not transparent then
				Result.set_background_color (bg_button_color)
				Result.clear
			end
			Result.draw_text (X_size // 2 - 1 ,Y_size - 2 , s)
		end

	pix_but: ARRAY [EV_PIXMAP] is
			-- Table of button pixmap from 0 to 8
		local
			i: INTEGER
		once
			create Result.make (0, 8)
			from
				i := 0
			until
				i > 8
			loop
				Result.put (pix_b (i.out), i)
				i := i + 1
			end
		end

end -- class GAME_CONSTANTS

--|-------------------------------------------------------------------------
--| Eiffel Mine Sweeper -- ZaDoR (c) -- 
--| version 1.2 (July 2001)
--|
--| by Jocelyn FIAT
--| email: jocelyn.fiat@ifrance.com
--| 
--| freely distributable
--|-------------------------------------------------------------------------

