indexing
	description: "A picture color button without border.";
	date: "$Date$";
	revision: "$Revision$"

class
	NO_BORDER_PICT_COLOR_B_IMP

inherit
	PICT_COLOR_B_IMP
		redefine
			draw_all_selected,
			draw_all_unselected,
			set_default_size,
			set_pixmap,
			set_background_pixmap
		end

creation
	make

feature

	set_pixmap, set_background_pixmap (a_pixmap: PIXMAP) is
			-- Set the pixmap for the button
		do
			pixmap := a_pixmap
			set_default_size
			if exists then
				invalidate
			end
		end

	set_default_size is
			-- Set default of button
		do
			if pixmap /= Void then
				set_form_width (pixmap.width)
				set_form_height (pixmap.height)
				set_width (pixmap.width)
				set_height (pixmap.height)
			end
		end

	draw_all_selected (a_dc: WEL_DC) is
			-- Draw current button when selected.
			-- With the borders.
		require else
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			draw_pixmap (a_dc)
		end

	draw_all_unselected (a_dc: WEL_DC) is
			-- Draw current button when unselected.
			-- With the borders.
		require else
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			draw_pixmap (a_dc)
		end

	draw_pixmap (a_dc: WEL_DC) is
		local
			bitmap: WEL_BITMAP
			pixmap_w: PIXMAP_IMP
			dib: WEL_DIB
		do
			if pixmap /= Void then
				pixmap_w ?= pixmap.implementation
				dib := pixmap_w.dib
				check
					dib_exists: dib /= Void
				end
				!! bitmap.make_by_dib (a_dc, dib, dib_rgb_colors)
				a_dc.draw_bitmap (bitmap, 0, 0, pixmap.width, pixmap.height)
			end
		end

end -- class NO_BORDER_PICT_COLOR_B_IMP
