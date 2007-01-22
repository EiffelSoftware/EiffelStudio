indexing
	description: "Multi constraint test"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
		ABC
inherit
		A
		rename
			make as make_a,
			default_create as default_create_a
		end
		B
		rename
			default_create as default_create_b,
			f as f_b,
			g as g_b
		end
		C
		rename
			default_create as default_create_cc,
			make as default_create,
			f as f_cc,
			g as g_cc
		select
			default_create_cc
		end

create
	make

feature -- Used in this test to test contracts

	set_count (a_i: INTEGER) is
			-- Sets `count' to `a_i'
		do
			count := a_i
		end

	same_as_count: INTEGER is
			-- Returns `count'
		do
			Result := count
		end

	increase_count is
			-- Increase count by one.
		do
			count := count + 1
		end


end

