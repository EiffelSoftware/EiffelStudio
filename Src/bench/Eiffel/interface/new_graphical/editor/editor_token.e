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
		-- Position in the line of the first character of
		-- this token. The position is counted in characters.

feature -- Element Change

	set_position(new_position: INTEGER) is
		require
			position_positive: position > 0
		do
			position := new_position
		ensure
			position_set: position = new_position
		end

feature -- Miscellaneous

	display(d_x: INTEGER; d_y: INTEGER; dc: WEL_DC): INTEGER is
			-- returns the value of d_x incremented by the size of the
			-- displayed text.
		deferred
		end

invariant
	image_not_void: image /= Void
	length_positive: length > 0

end -- class EDITOR_TOKEN
