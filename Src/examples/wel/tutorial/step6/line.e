indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	LINE

inherit
	LINKED_LIST [POINT]

create
	make

feature -- Access

	width: INTEGER
			-- Width of the line

feature -- Element change

	set_width (a_width: INTEGER) is
			-- Set `width' with `a_width'.
		require
			positive_width: a_width >= 0
		do
			width := a_width
		ensure
			width_set: width = a_width
		end

	add (x, y: INTEGER) is
			-- Add a point specified by `x' and `y'.
		local
			p: POINT
		do
			create p.make (x, y)
			extend (p)
		end

invariant
	positive_width: width >= 0

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


end -- class LINE

