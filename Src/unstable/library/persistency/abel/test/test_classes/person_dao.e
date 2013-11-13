note
	description: "Data Access Object, specialized in queries on {PERSON} objects."
	author: "Marco Piccioni"
	date: "$Date$"
	revision: "$Revision$"

class
	PERSON_DAO

feature -- Routines for agent criteria.

	items_greater_than (p: TEST_PERSON; v: INTEGER): BOOLEAN
			-- Are items owned by `p' greater than `v'?
		do
			Result := p.items_owned > v
		end

	items_equal_to (p: TEST_PERSON; v: INTEGER): BOOLEAN
			-- Are items owned by `p' equal to `v'?
		do
			Result := p.items_owned = v
		end

	items_less_than (p: TEST_PERSON; v: INTEGER): BOOLEAN
			-- Are items owned by `p' less than `v'?
		do
			Result := p.items_owned < v
		end

	first_name_matches (p: TEST_PERSON; s: STRING): BOOLEAN
			-- Does `p''s first name match `s'?
		do
			Result := p.first_name.is_equal (s)
		end

	first_name_contains (p: TEST_PERSON; s: STRING): BOOLEAN
			-- Does `p''s first name contain `s'?
		do
			Result := p.first_name.has_substring (s)
		end

	last_name_matches (p: TEST_PERSON; s: STRING): BOOLEAN
			-- Does `p''s last name match `s'?
		do
			Result := p.last_name.is_equal (s)
		end

	last_name_contains (p: TEST_PERSON; s: STRING): BOOLEAN
			-- Does `p''s last name contain `s'?
		do
			Result := p.last_name.has_substring (s)
		end

end
