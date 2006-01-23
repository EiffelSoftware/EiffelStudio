indexing
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PRIVATE_ATTRIBUTES_WINDOWS

feature -- Access
	
	x: INTEGER
			-- Private Horizontal position relative to parent
		
	y: INTEGER
			-- Private vertical position relative to parent

	width: INTEGER
			-- Private width of widget

	height: INTEGER
			-- Private height of widget

	insensitive: BOOLEAN 
			-- Private insensitive flag

feature -- Element change

	set_x (a_x: INTEGER) is
			-- Set x to a_x.
		do
			x := a_x
		ensure
			x_set: x = a_x
		end

	set_y (a_y: INTEGER) is
			-- Set y to a_y.
		do
			y := a_y
		ensure
			y_set: y = a_y
		end

	set_width (a_width: INTEGER) is
			-- Set width to a_width.
		do
			width := a_width
		ensure
			width_set: width = a_width
		end

	set_height (a_height: INTEGER) is
			-- Set height to a_height.
		do
			height := a_height
		ensure
			heiht_set: height = a_height
		end

	set_insensitive (a_flag: BOOLEAN) is
			-- Set insensitive to a_flag.
		do
			insensitive := a_flag
		ensure
			insensitive_set: insensitive = a_flag
		end

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




end -- class PRIVATE_ATTRIBUTES

