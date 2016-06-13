note
	description: "[
			JSON Serialization context for JSON serializer and JSON deserializer.
			
			By default, it is using the reflection mechanism.
			But this should be applied only on recursively "expanded" object (i.e without any cycle).
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_SERIALIZATION_CONTEXT

inherit
	JSON_SERIALIZER_CONTEXT
		redefine
			default_create
		end

	JSON_DESERIALIZER_CONTEXT
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			Precursor {JSON_SERIALIZER_CONTEXT}
			Precursor {JSON_DESERIALIZER_CONTEXT}
			set_default (create {JSON_REFLECTOR_SERIALIZATION})
		end

feature -- Element change

	register (a_serialization: JSON_SERIALIZATION_I; a_type: TYPE [detachable ANY])
		do
			if attached {JSON_SERIALIZER} a_serialization as s then
				register_serializer (s, a_type)
			end
			if attached {JSON_DESERIALIZER} a_serialization as d then
				register_deserializer (d, a_type)
			end
		end

	set_default (a_serialization: detachable JSON_SERIALIZATION_I)
		do
			if a_serialization = Void then
				set_default_serializer (Void)
				set_default_deserializer (Void)
			else
				if attached {JSON_SERIALIZER} a_serialization as s then
					set_default_serializer (s)
				end
				if attached {JSON_DESERIALIZER} a_serialization as d then
					set_default_deserializer (d)
				end
			end
		end

note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
