note
	description: "A simple class representing a person"
	author: "Roman Schmocker, Marco Piccioni"
	date: "$Date$"
	revision: "$Revision$"

class PERSON

create
	make

feature {NONE} -- Initialization

	make (first, last: STRING)
			-- Create a newborn person.
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

feature -- Basic operations

	celebrate_birthday
			-- Increase age by 1
		do
			age := age + 1
		ensure
			age_incremented_by_one: age = old age + 1
		end

feature -- Access

	first_name: STRING
		-- The person's first name.

	last_name: STRING
		-- The person's last name.

	age: INTEGER
		-- The person's age.

invariant
	age_non_negative: age >= 0
	first_name_exists: not first_name.is_empty
	last_name_exists: not last_name.is_empty
end
