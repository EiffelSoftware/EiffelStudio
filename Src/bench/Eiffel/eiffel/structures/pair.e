indexing
	description: "Objects that contain 2 objects"
	author: "Emmanuel Stapf"
	date: "$Date$"
	revision: "$Revision$"

class
	PAIR [G,H]

create
	default_create,
	make

feature {NONE} -- Initialization

	make (a_first: G; a_second: H) is
			-- New pair made of `a_first' and `a_second'.
		do
			first := a_first
			second := a_second
		ensure
			first_set: first = a_first
			second_set: second = a_second
		end

feature -- Access

	first: G
			-- First item of pair.

	second: H
			-- Second item of pair.

feature -- Settings

	set_first (v: G) is
			-- Set `first' with `v'.
		do
			first := v
		ensure
			first_set: first = v
		end

	set_second (v: H) is
			-- Set `second' with `v'.
		do
			second := v
		ensure
			second_set: second = v
		end

end -- class PAIR
