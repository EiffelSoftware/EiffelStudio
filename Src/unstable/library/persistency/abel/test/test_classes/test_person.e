note
	description: "In-memory database sample class."
	author: "Marco Piccioni"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_PERSON

create
	make

feature {NONE} -- Initialization

	make (f_name, l_name: STRING; items: INTEGER)
			-- Initialization for `Current'.
		require
			f_name_exists: not f_name.is_empty
			l_name_exists: not l_name.is_empty
		do
			first_name := f_name
			last_name := l_name
			items_owned := items
		ensure
			f_name_set: f_name = first_name
			l_name_set: l_name = last_name
			items_owned_set: items_owned = items
		end

feature -- Access

	first_name: STRING
			-- The person's first name.

	last_name: STRING
			-- The person's last name.

	items_owned: INTEGER
			-- The number of items the person ownes.

--feature --Experiment: transient attributes

--	transient_integer: INTEGER
--	note option:transient attribute end

--	set_transient_integer(int: INTEGER) do transient_integer := int end

feature -- Basic operations

	add_item
		do
			items_owned := items_owned + 1
		end

feature {NONE} -- Implementation

invariant
	items_owned_negative: items_owned >= 0

end
