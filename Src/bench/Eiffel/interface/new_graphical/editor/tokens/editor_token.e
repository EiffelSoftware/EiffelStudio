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

	position: INTEGER
			-- position in pixels of the first character of
			-- this token

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
			update_position
		end

	update_position is
			-- Update the value of `position' to
			-- its correct value
		do
				-- Update current position
			if previous /= Void then
				position := previous.position + previous.width
			else
				position := 0
			end

				-- Update position of linked tokens
			if next /= Void then
				next.update_position
			end
		end

feature -- Miscellaneous

	width: INTEGER is
			-- Width in pixel of the entire.
		deferred
		end
	
	display(d_y: INTEGER; dc: WEL_DC) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y')
		deferred
		end

	get_substring_width(n: INTEGER): INTEGER is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		require
			n_valid: n >= 0
		deferred
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		require
			a_width_valid: a_width >= 0
		deferred
		ensure
			Result_positive: Result > 0
			Result_small_enough: Result <= length
		end

invariant
	image_not_void: image /= Void
	length_positive: length > 0
	width_positive_or_null: width >= 0
	previous = Void implies position = 0

end -- class EDITOR_TOKEN
