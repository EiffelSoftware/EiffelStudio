note
	description: "[
			JSON serializer and JSON deserializer implementation for APP_PERSON objects.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	PERSON_JSON_SERIALIZATION

inherit
	PERSON_JSON_SERIALIZER
		redefine
			reset
		end

	PERSON_JSON_DESERIALIZER
		redefine
			reset
		end

feature -- Cleaning

	reset
			-- <Precursor>
		do
			Precursor {PERSON_JSON_SERIALIZER}
			Precursor {PERSON_JSON_DESERIALIZER}
		end



end
