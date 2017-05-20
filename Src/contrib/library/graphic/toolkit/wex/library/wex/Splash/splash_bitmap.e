note
	description: "Splash screen containing a bitmap"
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_SPLASH_BITMAP_WINDOW

inherit

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

	WEX_SPLASH_WINDOW
		redefine
			valid,
			class_name,
			class_background,
			on_paint
		end

create
	make

feature -- Basic operations

	set_bitmap (file_path: PATH)
			-- Set splashscreen
		require
			file_path_not_void: file_path /= Void
			file_path_meaningfull: not file_path.is_empty
		local
			a_file: RAW_FILE
			a_dib: WEL_DIB
			client_dc: WEL_CLIENT_DC
			retried: BOOLEAN
		do
			if not retried then
				create a_file.make_with_path (file_path)
				a_file.open_read
				create a_dib.make_by_file (a_file)
				create client_dc.make (Current)
				client_dc.get
				client_dc.select_palette (a_dib.palette)
					client_dc.realize_palette
				create splash_bitmap.make_by_dib (client_dc, a_dib, Dib_rgb_colors)
				splash_palette := a_dib.palette
				client_dc.release
				resize_to_bitmap
				center_on_screen
			end
		ensure
			valid_implies_splash_bitmap_not_void: valid implies splash_bitmap /= Void
			valid_implies_splash_bitmap_exists: valid implies splash_bitmap.exists
			valid_implies_splash_palette_not_void_if_valid: valid implies splash_palette /= Void
			valid_implies_splash_palette_exists: valid implies splash_palette.exists
		rescue
			retried := True
			retry
		end

	resize_to_bitmap
		do
			resize (splash_bitmap.width, splash_bitmap.height)
		end

feature -- Status report

	valid: BOOLEAN
			-- Can the splash be popped up?
		do
			Result := splash_bitmap /= Void and then
				splash_palette /= Void and then
				splash_bitmap.exists and then
				splash_palette.exists
		end

	splash_bitmap: WEL_BITMAP
			-- Bitmap to splash on screen

	splash_palette: WEL_PALETTE
			-- Palette of bitmap.

feature {NONE} -- Implementation

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Wm_paint message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
			paint_dc.select_palette (splash_palette)
			paint_dc.realize_palette
			paint_dc.draw_bitmap (splash_bitmap, 0, 0, splash_bitmap.width, splash_bitmap.height)
		end

	class_background: WEL_NULL_BRUSH
			-- We paint the entire foreground,
			-- so windows need not to paint the background.
		once
			create Result.make
		end

	class_name: STRING_32
			-- Class name
		once
			Result := "SplashBitmapWindowWEX"
		end

end

--|-------------------------------------------------------------------------
--| WEX, Windows Eiffel library eXtension
--| Copyright (C) 1998  Robin van Ommeren, Andreas Leitner
--| Copyright (C) 2017  Eiffel Software, Alexander Kogtenkov
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Robin van Ommeren						Andreas Leitner
--| Eikenlaan 54M								Arndtgasse 1/3/5
--| 7151 WT Eibergen							8010 Graz
--| The Netherlands							Austria
--| email: robin.van.ommeren@wxs.nl		email: andreas.leitner@teleweb.at
--| web: http://home.wxs.nl/~rommeren	web: about:blank
--|-------------------------------------------------------------------------
