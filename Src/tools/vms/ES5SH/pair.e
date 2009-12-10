indexing
   description : "simple implementation of an ordered pair of items"
   author : "Mark Howard"
   keywords : "pair,ordered"

class PAIR[G,H]

create
	make, default_create

feature --Initialization

	make, set (a_first : G; a_second : H) is
			-- Creation procedure.
		do
			first := a_first
			second := a_second
		end

feature --Access

	first: G		-- First
	second: H		-- Second

feature -- Basic operations

	set_first (a_value: like first) is
			-- Set 'first'.
		do
			first := a_value
		end

	set_second (a_value: like second) is
			-- Set 'second'.
		do
			second := a_value
		end

end
