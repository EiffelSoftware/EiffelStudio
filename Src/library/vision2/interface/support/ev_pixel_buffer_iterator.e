note
	description: "Iterator for pixel values of EV_PIXEL_BUFFER"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXEL_BUFFER_ITERATOR

inherit
	BILINEAR [EV_PIXEL_BUFFER_PIXEL]
	ITERATION_CURSOR [EV_PIXEL_BUFFER_PIXEL]

create {EV_PIXEL_BUFFER_I}
		make_for_pixel_buffer

create {EV_PIXEL_BUFFER_ITERATOR}
		make_for_pixel_buffer_i

feature {NONE} -- Creation

	make_for_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Make iterator for pixel buffer `a_pixel_buffer'.
		do
			make_for_pixel_buffer_i (a_pixel_buffer.implementation)
		end

	make_for_pixel_buffer_i (p: like pixel_buffer)
			-- Make iterator for pixel buffer `p'.
		do
			pixel_buffer := p
			create internal_item
			internal_item.set_pixel_buffer (pixel_buffer)
			max_row_value := p.height.to_natural_32
			max_column_value := p.width.to_natural_32
		end

feature -- Iteration

	start
			-- Move to first position if any.
		do
			column := 1
			row := 1
		end

	after: BOOLEAN
			-- Is there no valid position to the right of current one?
		do
			Result := row > max_row_value
		end

	finish
			-- Move to last position.
		do
			row := max_row_value
			column := max_column_value
		end

	forth
			-- Move to next position; if no next position,
			-- ensure that exhausted will be true.
		do
			if column = max_column_value then
				column := 1
				row := row + 1
			else
				column := column + 1
			end
		end

	before: BOOLEAN
			-- Is there no valid position to the left of current one?
		do
			Result := row = 0
		end

	back
			-- Move to previous position.
		do
			if column = 1 then
				column := max_column_value
				row := row - 1
			else
				column := column - 1
			end
		end

	item: EV_PIXEL_BUFFER_PIXEL
			-- Pixel at current iteration position.
			-- Object is reused for efficiency so retained references will be automatically updated.
			-- If not locked then a default pixel is returned.
		do
			if pixel_buffer.is_locked then
				Result := internal_item
					-- Update internal_item with `Current' pixel
				Result.sync_with_pixel_buffer_value (column - 1, row - 1)
			else
				create Result
			end
		end

	index: INTEGER
			-- Index of current position.
		do
			Result := ((row - 1) * max_column_value + column).to_integer_32
		end

	column: NATURAL_32
			-- Column index of `item'.

	row: NATURAL_32
			-- Row index of `item'.

	new_cursor: EV_PIXEL_BUFFER_ITERATOR
			-- <Precursor>
		do
			create Result.make_for_pixel_buffer_i (pixel_buffer)
			Result.start
		end

feature -- Measurement

	max_column_value: NATURAL_32
		-- Total number of columns for iteration.

	max_row_value: NATURAL_32
		-- Total number of rows for iteration.

feature -- Status report

	is_empty: BOOLEAN
			-- Is there no element?
		do
			-- False as there are always elements to iterate.
		end

feature -- Modification

	set_column (a_column: NATURAL_32)
			-- Set iterator to column `a_column' of `pixel_buffer'.
		require
			a_column_valid: a_column >= 1 and then a_column <= max_column_value
		do
			column := a_column
		end

	set_row (a_row: NATURAL_32)
			-- Set iterator to row `a_row' of `pixel_buffer'.
		require
			a_row_valid: a_row >= 1 and then a_row <= max_row_value
		do
			row := a_row
		end

	update_pixel (a_column, a_row: NATURAL_32; a_pixel: EV_PIXEL_BUFFER_PIXEL)
			-- Update `a_pixel' with pixel value at `a_column', `a_row' of `Current'.
			-- If not locked nothing is done.
		require
			a_column_valid: a_column >= 1 and then a_column <= max_column_value
			a_row_valid: a_row >= 1 and then a_row <= max_row_value
		do
			if pixel_buffer.is_locked then
				a_pixel.set_pixel_buffer (pixel_buffer)
				a_pixel.sync_with_pixel_buffer_value (a_column - 1, a_row - 1)
			end
		end

feature {NONE} -- Implementation

	internal_item: EV_PIXEL_BUFFER_PIXEL

	pixel_buffer: EV_PIXEL_BUFFER_I
		-- Pixel buffer for which `Current' is iterating.

;note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
