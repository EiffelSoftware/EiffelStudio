note
	description: "Cells containing two items of different type."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	DOUBLE_CELL [G, H]

inherit

	ANY
		redefine
			default_create
		end

create
	default_create, make

feature {NONE} -- Initialization

	default_create
			-- Initialization for `Current'.
		do
			first := ({G}).default_detachable_value
			second := ({H}).default_detachable_value
		end

	make (a_first: like first; a_second: like second)
			-- Initialization for `Current'.
		do
			set_first (a_first)
			set_second (a_second)
		end

feature -- Access

	first: detachable G assign set_first
			-- First item in `Current'.

	second: detachable H assign set_second
			-- Second item in `Current'.

feature -- Element change

	set_first (a_first: like first)
			-- Assign `first' with `a_first'.
		do
			first := a_first
		ensure
			first_assigned: first = a_first
		end

	set_second (a_second: like second)
			-- Assign `second' with `a_second'.
		do
			second := a_second
		ensure
			second_assigned: second = a_second
		end

end
