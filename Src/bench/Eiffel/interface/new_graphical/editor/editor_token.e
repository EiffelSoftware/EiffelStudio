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

	width: INTEGER
		-- Width in pixel (computed at the last display).

feature -- Linkable functions

	previous: EDITOR_TOKEN
		-- Previous token in the line. Void if none

	next: EDITOR_TOKEN
		-- Next token in the line. Void if none.

feature -- Miscellaneous

	display(d_x: INTEGER; d_y: INTEGER; dc: WEL_DC): INTEGER is
			-- returns the value of d_x incremented by the size of the
			-- displayed text.
		deferred
		end

	get_substring_width(n: INTEGER) is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		do
			dc.select_font(font)
			Result := dc.string_width(image.substring(1,n))
			dc.unselect_font
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
