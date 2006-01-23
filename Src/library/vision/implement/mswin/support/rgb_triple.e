indexing 
	status: "See notice at end of class."; 
	date: "$Date$"; 
	revision: "$Revision$" 

class
	RGB_TRIPLE 

create
	make

feature -- Initialisation
	
	make (r, g, b: INTEGER) is
		do
			red := r
			blue := b
			green := g
		end 

feature {COLOR_IMP, COLOR_LOOKUP, PS_HEADER} -- Access

	blue: INTEGER

	green: INTEGER

	red: INTEGER;

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




end -- class RGB_TRIPLE

