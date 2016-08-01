note
	description: "[
			JSON Serialization context for JSON serializer and JSON deserializer.
			
			By default, it is using the reflection mechanism.
			But this should be applied only on recursively "expanded" object (i.e without any cycle).
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_SERIALIZATION_CONTEXT_WITH_REFERENCE

inherit
	JSON_SERIALIZATION_CONTEXT
		redefine
			serializer_context,
			deserializer_context
		end

create
	default_create

feature -- Access

	serializer_context: JSON_SERIALIZER_CONTEXT_WITH_REFERENCE

	deserializer_context: JSON_DESERIALIZER_CONTEXT_WITH_REFERENCE

invariant

note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
