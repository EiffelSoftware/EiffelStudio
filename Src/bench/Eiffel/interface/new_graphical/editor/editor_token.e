indexing
	description	: "Objects that represent a general text token."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EDITOR_TOKEN

feature -- Access

	image: STRING
			-- String representation of the token

	length: INTEGER
			-- Number of characters represented by the token.

feature -- Linkable functions

	previous: EDITOR_TOKEN
			-- Previous token in the line. Void if none

	next: EDITOR_TOKEN
			-- Next token in the line. Void if none.

	set_next_token(next_token: EDITOR_TOKEN) is
			-- set `next' to `next_token'. `next' can
			-- be Void if there are no next token.
		do
			next := next_token
		end

	set_previous_token(previous_token: EDITOR_TOKEN) is
			-- set `next' to `next_token'. `next' can
			-- be Void if there are no next token.
		do
			previous := previous_token
		end

feature -- Miscellaneous

	display(d_x: INTEGER; d_y: INTEGER; dc: WEL_DC): INTEGER is
			-- returns the value of d_x incremented by the size of the
			-- displayed text.
		deferred
		end

	width: INTEGER is
		-- Width in pixel of the entire token.
		do
			dc.select_font(font)
			Result := dc.string_width(image)
			dc.unselect_font
		end

	get_substring_width(n: INTEGER) is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		do
			dc.select_font(font)
			Result := dc.string_width(image.substring(1,n))
			dc.unselect_font
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		local
			space_width: INTEGER
			current_position: INTEGER
			current_width: INTEGER
			next_width: INTEGER
		do
			dc.select_font(font)

				-- precompute an estimation of the current_position
			space_width := dc.string_width(" ")
			current_position := a_width // space_width

				-- We have now to check that our current position is the good one.
				-- If we are above, we decrease current_position, and the opposite.
			from
				current_width := dc.string_width(image.substring(1,current_position))
				next_width := dc.string_width(image.substring(1,current_position+1))
			until
				a_width >= current_width and then a_width < next_width
			loop
				if a_width < current_width then
					current_position := current_position - 1
					next_width := current_width
					current_width := dc.string_width(image.substring(1,current_position))
				else
					current_position := current_position + 1
					current_width := next_width
					next_width := dc.string_width(image.substring(1,current_position+1))
				end
			end
			dc.unselect_font

			Result := current_position
		end

feature {NONE} -- Properties used to display the token

	text_color: WEL_COLOR_REF is
		deferred
		end

	background_color: WEL_COLOR_REF is
		deferred
		end

	font: WEL_FONT is
		deferred
		end

	device_context: WEL_DC

invariant
	image_not_void: image /= Void
	length_positive: length > 0
	width_positive_or_null: width >= 0

end -- class EDITOR_TOKEN
