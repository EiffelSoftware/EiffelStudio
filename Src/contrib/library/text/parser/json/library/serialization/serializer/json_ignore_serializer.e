note
	description: "[
			Serializer to ignore a specific type of object.
			
			Register it using the {TYPE_NAME} you want to ignore.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_IGNORE_SERIALIZER [G]

inherit
	JSON_SERIALIZER
		redefine
			to_json
		end

feature -- Conversion

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		do
			create {JSON_NULL} Result
		end

note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
