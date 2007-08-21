indexing
	description: "Used for describing 32-bit RGBA component values of EV_PIXEL_BUFFER"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXEL_BUFFER_PIXEL

inherit
	ANY
		redefine
			default_create
		end

feature -- Initialization

	default_create is
			-- Initialize pixel.
		do
			if (create {PLATFORM}).is_windows then
				red_shift := 16
				green_shift := 8
				blue_shift := 0
				alpha_shift := 24
			else
				red_shift := 24
				green_shift := 16
				blue_shift := 8
				alpha_shift := 0
			end
		end

feature -- Access

	red: NATURAL_8
			-- Red component value of pixel.
		assign
			set_red
		do
			Result := ((internal_color_value |>> red_shift)).to_natural_8
		end

	green: NATURAL_8
			-- Green component value of pixel.
		assign
			set_green
		do
			Result := ((internal_color_value |>> green_shift)).to_natural_8
		end

	blue: NATURAL_8
			-- Blue component value of pixel.
		assign
			set_blue
		do
			Result := ((internal_color_value |>> blue_shift)).to_natural_8
		end

	alpha: NATURAL_8
			-- Alpha component value of pixel.
		assign
			set_alpha
		do
			Result := ((internal_color_value |>> alpha_shift)).to_natural_8
		end

	rgba_value: NATURAL_32
			-- RGBA value of pixel.
		assign
			set_rgba_value
		local
			l_color_value, l_alpha_value: NATURAL_32
		do
			Result := internal_color_value
			if {PLATFORM}.is_windows then
					-- Convert from ARGB to 'RGB'0
				l_color_value := Result |<< 8
					-- Convert to 000'A'
				l_alpha_value := Result |>> 24
				Result := l_color_value | l_alpha_value
			end
		end

feature -- Element Change

	set_red (a_red: NATURAL_8)
			-- Set red component of pixel to `a_red'.
		do
			set_component_value (a_red, red_shift)
		ensure
			red_set: red = a_red
		end

	set_green (a_green: NATURAL_8)
			-- Set green component of pixel to `a_green'.
		do
			set_component_value (a_green, green_shift)
		ensure
			green_set: green = a_green
		end

	set_blue (a_blue: NATURAL_8)
			-- Set blue component of pixel to `a_blue'.
		do
			set_component_value (a_blue, blue_shift)
		ensure
			blue_set: blue = a_blue
		end

	set_alpha (a_alpha: NATURAL_8)
			-- Set alpha component of pixel to `a_alpha'.
		do
			set_component_value (a_alpha, alpha_shift)
		ensure
			alpha_set: alpha = a_alpha
		end

	set_values (a_red, a_green, a_blue, a_alpha: NATURAL_8)
			-- Set RGBA values to `a_red', `a_green', `a_blue' and `a_alpha' respectively.
		do
			set_red (a_red)
			set_green (a_green)
			set_blue (a_blue)
			set_alpha (a_alpha)
		end

    set_rgba_value (a_rgba_value: NATURAL_32)
            -- Set RGBA value to `a_rgba_value'.
        local
            l_color_value, l_alpha: NATURAL_32
            l_internal_pixel_buffer: like internal_pixel_buffer
        do
            if {PLATFORM}.is_windows then
                    -- We need to perform a circular shift from RGBA to ARGB
                l_color_value := a_rgba_value |>> 8
                    -- This creates 0'RGB'
                l_alpha := a_rgba_value |<< 24
                    -- This create 'A'000
                l_color_value := l_color_value | l_alpha
                    -- This creates ARGB
            else
                l_color_value := a_rgba_value
                    -- No need for shifting
            end
            l_internal_pixel_buffer := internal_pixel_buffer
            if l_internal_pixel_buffer /= Void and then l_internal_pixel_buffer.is_locked then
                l_internal_pixel_buffer.set_pixel (current_column_value, current_row_value, l_color_value)
            end
            internal_color_value := a_rgba_value
        ensure
            rgba_value_set: internal_pixel_buffer /= Void and then internal_pixel_buffer.is_locked implies internal_pixel_buffer.get_pixel (current_column_value, current_row_value) = a_rgba_value
        end

feature {EV_PIXEL_BUFFER_ITERATOR} -- Implementation

	set_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER_I) is
			-- Make `Current' for pixel buffer `a_pixel_buffer'.
		require
			a_pixel_buffer_not_void: a_pixel_buffer /= Void
		do
			internal_pixel_buffer := a_pixel_buffer
		end

	sync_with_pixel_buffer_value (a_column, a_row: NATURAL_32) is
			-- Update `Current' to reflect pixel value (a_column, a_row) or `internal_pixel_buffer'.
		do
			current_column_value := a_column
			current_row_value := a_row
			internal_color_value := internal_pixel_buffer.get_pixel (a_column, a_row)
		end

feature {NONE} -- Implementation

	red_shift: NATURAL_8
	green_shift: NATURAL_8
	blue_shift: NATURAL_8
	alpha_shift: NATURAL_8
		-- Bit shift values to access color components.

	set_component_value (a_color, a_shift: NATURAL_8) is
			-- Set color component to `a_color' for color requiring `a_shift' bit-shifts.
		local
			l_mask: NATURAL_32
			l_value: NATURAL_32
		do
			inspect
				a_shift
			when 24 then
				l_mask := 0x00FFFFFF
			when 16 then
				l_mask := 0xFF00FFFF
			when 8 then
				l_mask := 0xFFFF00FF
			else
				l_mask := 0xFFFFFF00
			end
				-- Mask out existing component value
			internal_color_value := internal_color_value & l_mask
			l_value := a_color
			l_value := l_value |<< a_shift
			internal_color_value := internal_color_value | l_value

			if internal_pixel_buffer /= Void and then internal_pixel_buffer.is_locked then
				internal_pixel_buffer.set_pixel (current_column_value, current_row_value, internal_color_value)
			end
		ensure
			pixel_set: internal_pixel_buffer /= Void and then internal_pixel_buffer.is_locked implies internal_color_value = internal_pixel_buffer.get_pixel (current_column_value, current_row_value)
		end

	current_column_value, current_row_value: NATURAL_32
		-- Current row and column that `Current' reflects.

	internal_color_value: NATURAL_32
		-- Packed color value which is updated by `update'.

	internal_pixel_buffer: EV_PIXEL_BUFFER_I
		-- Pixel buffer for which `Current' change values of.

end
