indexing
	description: "Iterator for pixel values of EV_PIXEL_BUFFER"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXEL_BUFFER_ITERATOR

inherit
	BILINEAR [EV_PIXEL_BUFFER_PIXEL]

create
	{EV_PIXEL_BUFFER_I}
		make_for_pixel_buffer

feature {NONE} -- Creation

	make_for_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Make iterator for pixel buffer `a_pixel_buffer'.
		do
			pixel_buffer := a_pixel_buffer.implementation

			create internal_item
			internal_item.set_pixel_buffer (pixel_buffer)
			max_row_value := a_pixel_buffer.height.to_natural_32 - 1
			max_column_value := a_pixel_buffer.width.to_natural_32 - 1
		end

feature

	start
			-- Move to first position if any.
		do
			max_row_value := pixel_buffer.height.to_natural_32 - 1
			max_column_value := pixel_buffer.width.to_natural_32 - 1
			column_value := 0
			row_value := 0
		end

	after: BOOLEAN
			-- Is there no valid position to the right of current one?
		do
			Result := row_value > max_row_value
		end

	finish
			-- Move to last position.
		do
			row_value := max_row_value
			column_value := max_column_value
		end

	forth
			-- Move to next position; if no next position,
			-- ensure that exhausted will be true.
		do
			if column_value = max_column_value then
				column_value := 0
				row_value := row_value + 1
			else
				column_value := column_value + 1
			end
		end

	before: BOOLEAN
			-- Is there no valid position to the left of current one?
		do
			Result := row_value < 0
		end

	back
			-- Move to previous position.
		do
			if column_value = 0 then
				column_value := max_column_value
				row_value := row_value - 1
			else
				column_value := column_value - 1
			end
		end

	is_empty: BOOLEAN
			-- Is there no element?
		do
			-- False as there are always elements to iterate.
		end

	set_column (a_column: NATURAL_32)
			-- Set iterator to column `a_column' of `pixel_buffer'.
		require
			a_column_valid: a_column >= 1 and then a_column <= max_column_value
		do
			column_value := a_column - 1
		end

	column: NATURAL_32
			-- Column index of `item'.
		assign
			set_column
		do
			Result := column_value + 1
		end

	set_row (a_row: NATURAL_32)
			-- Set iterator to row `a_row' of `pixel_buffer'.
		require
			a_row_valid: a_row >= 1 and then a_row <= max_row_value
		do
			row_value := a_row - 1
		end

	row: NATURAL_32
			-- Row index of `item'.
		assign
			set_row
		do
			Result := row_value + 1
		end

	item: EV_PIXEL_BUFFER_PIXEL
			-- Pixel at current iteration position.
			-- Object is reused for efficiency so retained references will be automatically updated.
			-- If pixel buffer is not locked then result is Void
		do
			if pixel_buffer.is_locked then
				Result := internal_item
					-- Update internal_item with `Current' pixel
				Result.sync_with_pixel_buffer_value (column_value, row_value)
			end
		end

	update_pixel (a_column, a_row: NATURAL_32; a_pixel: EV_PIXEL_BUFFER_PIXEL)
			-- Update pixel value at `a_column', `a_row' with pixel data contained in `a_pixel'.
		require
			a_column_valid: a_column >= 1 and then a_column <= max_column_value
			a_row_valid: a_row >= 1 and then a_row <= max_row_value
		do
			if pixel_buffer.is_locked then
				a_pixel.set_pixel_buffer (pixel_buffer)
				a_pixel.sync_with_pixel_buffer_value (a_column, a_row)
			end
		end

	index: INTEGER is
			-- Index of current position.
		do
			Result := (row_value * max_column_value + column_value).to_integer_32
		end

	max_column_value: NATURAL_32
		-- Total number of columns for iteration.

	max_row_value: NATURAL_32
		-- Total number of rows for iteration.

feature {NONE} -- Implementation

	internal_item: EV_PIXEL_BUFFER_PIXEL

	pixel_buffer: EV_PIXEL_BUFFER_I
		-- Pixel buffer for which `Current' is iterating.

	column_value: NATURAL_32
		-- Current column being iterated (zero based)

	row_value: NATURAL_32
		-- Current row being iterated (zero based)

end
