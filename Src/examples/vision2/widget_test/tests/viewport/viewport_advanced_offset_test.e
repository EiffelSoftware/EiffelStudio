indexing
	description: "Objects that test an EV_VIEWPORT by allowing%
		% you to adjust the offset."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VIEWPORT_ADVANCED_OFFSET_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
		do
			build_images
			create vertical_box
			create viewport
			viewport.extend (large_image)
			vertical_box.extend (viewport)
			viewport.set_minimum_size (image_width // 3, image_height // 3)
			create horizontal_box
			small_image.pointer_motion_actions.force_extend (agent modify_offset)
			horizontal_box.extend (small_image)
			create label.make_with_text ("Set viewport position%NBy moving over small image.")
			horizontal_box.extend (label)
			horizontal_box.disable_item_expand (small_image)
			vertical_box.extend (horizontal_box)
			vertical_box.disable_item_expand (horizontal_box)
			
			widget := vertical_box
		end
		
	modify_offset (x, y: INTEGER) is
			-- Assign an offset to `viewport' based on `x' and `y'.
		do
			viewport.set_offset ((x * 6 - small_image_width).max (0).min (image_width - 300),
				(y* 6 - small_image_height).max (0).min (image_height - 200))
		end
		
		
feature {NONE} -- Implementation

	viewport: EV_VIEWPORT
		-- Widget that test is to be performed on.
	
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
	
	build_images is
			-- `Result' is image used for test. The way
			-- in which this is generated is not important, but the
			-- fact that it generates an interesting image is.
		local
			colors: LINKED_LIST [EV_COLOR]
			counter: INTEGER
			temp_int: INTEGER
		do
			create large_image
			create small_image
			large_image.set_minimum_size (image_width, image_height)
			large_image.set_size (image_width, image_height)
			small_image.set_minimum_size (small_image_width, small_image_height)
			small_image.set_size (small_image_width, small_image_height)
			large_image.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (120, 140, 200))
			small_image.set_background_color (large_image.background_color)
			large_image.clear
			small_image.clear
			colors := (create {EV_STOCK_COLORS}).all_colors
				-- Draw dots on background.
			from
				counter := 0
				colors.start
			until
				counter > 80
			loop
				large_image.set_foreground_color (colors.item)
				small_image.set_foreground_color (colors.item)
				large_image.fill_ellipse ((counter \\ 9) * 100, (counter // 9) * 100, 40, 40)
				small_image.fill_ellipse ((counter \\ 9) * 17, (counter // 9) * 17, 6, 6)
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
				large_image.set_foreground_color (colors.item)
				small_image.set_foreground_color (colors.item)
				temp_int := counter * 10
				large_image.fill_ellipse (temp_int, temp_int, temp_int, temp_int)
				small_image.fill_ellipse (temp_int // 6, temp_int // 6, temp_int // 6, temp_int // 6)
				colors.forth
				if colors.off then
					colors.start
				end
				counter := counter - 1
			end
		end
		
	small_image, large_image: EV_PIXMAP;
		-- Images for test.

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


end -- class VIEWPORT_ADVANCED_OFFSET_TEST
