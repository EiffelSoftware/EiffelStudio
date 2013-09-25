note
	description: "A simple class representing a person with (possibly) parents."
	author: "Marco Piccioni, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CHILD

create
	make

feature {NONE} -- Initialization

	make (first, last: STRING)
			-- Create a new child.
		require
			first_exists: not first.is_empty
			last_exists: not last.is_empty
		do
			first_name := first
			last_name := last
			age := 0
		ensure
			first_name_set: first_name = first
			last_name_set: last_name = last
			default_age: age = 0
		end

feature -- Access

	celebrate_birthday
			-- Increase age by 1.
		do
			age := age + 1
		ensure
			age_incremented_by_one: age = old age + 1
		end

feature -- Status report

	first_name: STRING
			-- The child's first name.

	last_name: STRING
			-- The child's last name.

	age: INTEGER
			-- The child's age.

feature -- Parents

	mother: detachable CHILD
			-- The child's mother.

	father: detachable CHILD
			-- The child's father.

	set_mother (a_mother: CHILD)
			-- Set a mother for the child.
		do
			mother := a_mother
		ensure
			mother_set: mother = a_mother
		end

	set_father (a_father: CHILD)
			-- Set a father for the child.
		do
			father := a_father
		ensure
			father_set: father = a_father
		end

invariant
	age_non_negative: age >= 0
	first_name_exists: not first_name.is_empty
	last_name_exists: not last_name.is_empty
end
