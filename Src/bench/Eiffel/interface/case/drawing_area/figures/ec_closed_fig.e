indexing

	description: 
		"Abstraction of closed figures (circles, polygons),%
		%filled with a fill pattern";
	date: "$Date$";
	revision: "$Revision $"

deferred class EC_CLOSED_FIG 

inherit

	EC_FIGURE

feature -- Properties

	interior : EC_INTERIOR;
			-- Type of the interior
			-- Void if the ec_figure should'nt be filled.

feature -- Setting

	set_interior(an_interior: like interior) is
			-- Set interior to 'an_interior'.
		do
			interior := an_interior
		ensure
			interior = an_interior
		end -- set_interior

end -- class EC_CLOSED_FIG
