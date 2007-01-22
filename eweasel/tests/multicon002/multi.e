indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
		-- each class (A,B,C) has the features make, f and g
		-- A keeps nothing
		-- B keeps g and make
		-- C keeps f

		MULTI[G->{	A rename default_create as default_create_a, make as make_a end,
					B rename default_create as default_create_b end,
					C rename default_create as default_create_c, make as default_create end} create make_a, default_create, make end]

create
	make

feature -- Initialize

	make is
			-- Do the testing
		do
			create mc.make_a
			create mc.default_create
			create mc.make
		end

feature -- Access

	mc: G

end
