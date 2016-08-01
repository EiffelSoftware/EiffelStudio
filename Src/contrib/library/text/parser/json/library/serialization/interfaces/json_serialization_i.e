note
	description: "Common ancestor for {JSON_SERIALIZER and JSON_DESERIALIZER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JSON_SERIALIZATION_I

feature -- Cleaning

	reset
			-- Clean any temporary data.
			--| Redefine in descendants.
		do
		end

note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
