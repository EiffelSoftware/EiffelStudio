note
	description: "Condition for block to be displayed based on location."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_BLOCK_LOCATION_CONDITION

inherit
	CMS_BLOCK_CONDITION

create
	make_with_location

feature {NONE} -- Initialization

	make_with_location (a_location: READABLE_STRING_8)
		do
			location := a_location
		end

feature -- Access

	description: STRING_32
		do
			create Result.make_from_string_general ("Location: %"")
			Result.append_string_general (location)
			Result.append_character ('%"')
		end

	location: READABLE_STRING_8

feature -- Evaluation

	satisfied_for_response (res: CMS_RESPONSE): BOOLEAN
		do
			Result := res.location.same_string (location)
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
