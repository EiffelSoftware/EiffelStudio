indexing
	description: "Objects that contain 2 objects"
	author: "Emmanuel Stapf"
	date: "$Date$"
	revision: "$Revision$"

class
	PAIR [G,H]

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
