indexing
	description: "Objects that test an EV_VIEWPORT by allowing%
		% you to adjust the offset."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VIEWPORT_ADVANCED_OFFSET_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			small_pixmap: EV_PIXMAP
			label: EV_LABEL
		do
			create vertical_box
			create viewport
			viewport.extend (pixmap_image)
			vertical_box.extend (viewport)
			viewport.set_minimum_size (image_width // 3, image_height // 3)
			create horizontal_box
			small_pixmap := clone (pixmap_image)
			small_pixmap.set_minimum_size (small_image_width, small_image_height)
			small_pixmap.stretch (small_image_width, small_image_height)
			small_pixmap.pointer_motion_actions.force_extend (agent modify_offset)
			horizontal_box.extend (small_pixmap)
			create label.make_with_text ("Set viewport position%NBy moving over small image.")
			horizontal_box.extend (label)
			horizontal_box.disable_item_expand (small_pixmap)
			vertical_box.extend (horizontal_box)
			vertical_box.disable_item_expand (horizontal_box)
			
			widget := vertical_box
		end
		
	modify_offset (x, y: INTEGER) is
			-- Assign an offset to `viewport' based on `x' and `y'/
		do
			viewport.set_offset ((x * 6 - small_image_width).max (0).min (image_width - 300),
				(y* 6 - small_image_height).max (0).min (image_height - 200))
		end
		
		
feature {NONE} -- Implementation

	viewport: EV_VIEWPORT
	
	image_width: INTEGER is 900
	image_height: INTEGER is 600
	
	half_image_width: INTEGER is
			-- Half `image_width'.		
		do
			Result := image_width // 2	
		end

	half_image_height: INTEGER is
			-- Half `image_height'.
		do
			Result := image_width // 2
		end
		
	small_image_width: INTEGER is
			-- Once sixth `image_width'.
		do
			Result := 900 // 6
		end
		
	small_image_height: INTEGER is
		-- Once sixth `image_height'.
		do
			Result := 600 // 6
		end
	
	pixmap_image: EV_PIXMAP is
			-- `Result' is image used for test. The way
			-- in which this is generated is not important,
			-- but the fact that it generates an intersting image is.
		local
			colors: LINKED_LIST [EV_COLOR]
			counter: INTEGER
			temp_int: INTEGER
		do
			create Result
			Result.set_minimum_size (900, 600)
			Result.set_size (900, 600)
			Result.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (120, 140, 200))
			Result.clear
			colors := (create {EV_STOCK_COLORS}).all_colors
				-- Draw dots on background.
			from
				counter := 0
				colors.start
			until
				counter > 80
			loop
				Result.set_foreground_color (colors.item)
				Result.fill_ellipse ((counter \\ 9) * 100, (counter // 9) * 100, 40, 40)
				counter := counter + 1
				colors.forth
				if colors.off then
					colors.start
				end
			end
				-- Draw larger circles.
			from
				counter := 46
			until
				counter = 1
			loop
				Result.set_foreground_color (colors.item)
				temp_int := counter * 10
				Result.fill_ellipse (temp_int, temp_int, temp_int, temp_int)
				colors.forth
				if colors.off then
					colors.start
				end
				counter := counter - 1
			end
		end

end -- class VIEWPORT_ADVANCED_OFFSET_TEST
