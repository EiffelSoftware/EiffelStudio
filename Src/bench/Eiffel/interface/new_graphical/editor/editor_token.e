indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EDITOR_TOKEN

feature -- Access

	image: STRING

feature -- Miscellaneous

	display(d_x: INTEGER; d_y: INTEGER; dc: WEL_DC): INTEGER is
			-- returns the value of d_x incremented by the size of the
			-- displayed text.
		deferred
		end

end -- class EDITOR_TOKEN
