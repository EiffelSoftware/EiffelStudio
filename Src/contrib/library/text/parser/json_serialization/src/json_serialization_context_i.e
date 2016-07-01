note
	description: "Common ancestor for {JSON_SERIALIZER_CONTEXT and JSON_DESERIALIZER_CONTEXT}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JSON_SERIALIZATION_CONTEXT_I

feature -- Cleaning

	reset
			-- Clean any temporary data.
		deferred
		end

note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
