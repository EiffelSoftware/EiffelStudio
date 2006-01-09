indexing
	description: "Specialized EIFFEL_LIST for a list of TYPE_AS, mostly used for the actual generics and %
		%find the location of `[' and `]'."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_LIST_AS

inherit
	EIFFEL_LIST [TYPE_AS]
		redefine
			complete_start_location, complete_end_location
		end

create
	make, make_filled

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void and then opening_bracket_location /= Void then
				Result := opening_bracket_location
			else
				Result := Precursor {EIFFEL_LIST} (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void and then closing_bracket_location /= Void then
				Result := closing_bracket_location
			else
				Result := Precursor {EIFFEL_LIST} (a_list)
			end
		end

feature -- Setting

	set_positions (a_opener, a_closer: LOCATION_AS) is
			-- Set `start_location' and `end_location' with `a_opener' and `a_closer'
			-- if not Void, nothing otherwise
		do
			opening_bracket_location := a_opener
			closing_bracket_location := a_closer
		ensure
			opening_bracket_location_set: opening_bracket_location = a_opener
			closing_bracket_location_set: closing_bracket_location = a_closer
		end

feature {NONE} -- Implementation: Access

	opening_bracket_location: LOCATION_AS
			-- Location of `[' if present.

	closing_bracket_location: LOCATION_AS
			-- Location of `]' if present.

end
