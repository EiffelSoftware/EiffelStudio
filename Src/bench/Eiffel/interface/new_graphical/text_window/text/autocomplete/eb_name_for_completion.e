indexing
	description: "Name of a feaure to be inserted by autocomplete"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_NAME_FOR_COMPLETION

inherit
	STRING
		rename
			make_from_string as make_with_name
		redefine
			make_with_name, 
			is_equal, infix "<"
		select
			infix "<", is_equal
		end

	STRING
		rename
			make_from_string as make_with_name,
			infix "<" as lower_than,
			is_equal as is_same_string
		redefine
			make_with_name
		end

create
	make_with_name

feature -- Initialization

	make_with_name (a_name: STRING) is
			-- create feature name with value `name'
		do
			Precursor {STRING} (a_name)
			has_dot := True
		end

feature -- Status Report

	has_dot: BOOLEAN

feature -- Status setting

	set_has_dot (hd: BOOLEAN) is
			-- assign `hd' to `has_dot'
		do
			has_dot := hd
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is name made of same character sequence as `other' (case has no importance)
		do
			Result := as_lower.is_same_string (other.as_lower)
		end

	infix "<" (other: like Current): BOOLEAN is
			-- Is name lexicographically lower than `other'?
		do
			Result := as_lower.lower_than (other.as_lower)
		end
		
	begins_with (s:STRING): BOOLEAN is
			-- Does this feature name begins with `s'?
		local
			lower_s: STRING
		do
			if count >= s.count then
				lower_s := s.as_lower
				Result := as_lower.substring_index_in_bounds (lower_s, 1, lower_s.count) = 1
			end
		end	

end -- class EB_NAME_FOR_COMPLETION
