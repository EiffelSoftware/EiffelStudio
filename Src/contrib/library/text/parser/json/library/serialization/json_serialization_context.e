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
	ANY
		redefine
			default_create
		end

create
	default_create,
	make_with_context

feature {NONE} -- Initialization

	default_create
		do
			make_with_context (create {like serializer_context}, create {like deserializer_context})
		end

	make_with_context (a_serializer_context: like serializer_context; a_deserializer_context: like deserializer_context)
		do
			serializer_context := a_serializer_context
			deserializer_context := a_deserializer_context
		end

feature -- Settings

	is_pretty_printing: BOOLEAN
		do
			Result := serializer_context.is_pretty_printing
		end

feature -- Settings change

	set_pretty_printing
		do
			serializer_context.set_pretty_printing
		end

	set_compact_printing
		do
			serializer_context.set_compact_printing
		end

feature -- Access

	serializer_context: JSON_SERIALIZER_CONTEXT
			-- Context for serialization.

	deserializer_context: JSON_DESERIALIZER_CONTEXT
			-- Context for deserialization.

feature -- Serialization

	to_json (obj: ANY; a_caller_serializer: detachable JSON_SERIALIZER): detachable JSON_VALUE
		do
			Result := serializer_context.to_json (obj, a_caller_serializer)
		end

feature -- Deserialization		

	value_from_json	(a_json: detachable JSON_VALUE; a_type: detachable TYPE [detachable ANY]): detachable ANY
		do
			Result := deserializer_context.value_from_json (a_json, a_type)
		end

	has_deserialization_error: BOOLEAN
			-- Error occurred during deserialization?
		do
			Result := deserializer_context.has_error
		end

	deserialization_error: detachable JSON_DESERIALIZER_ERROR
			-- Error related to deserialization, if any.
		do
			Result := deserializer_context.error
		ensure
			Result /= Void implies has_deserialization_error
		end

feature -- Element change

	register_serializer (conv: JSON_SERIALIZER; a_type: TYPE [detachable ANY])
		do
			serializer_context.register_serializer (conv, a_type)
		end

	set_default_serializer (conv: detachable JSON_SERIALIZER)
		do
			serializer_context.set_default_serializer (conv)
		end

	register_deserializer (conv: JSON_DESERIALIZER; a_type: TYPE [detachable ANY])
		do
			deserializer_context.register_deserializer (conv, a_type)
		end

	set_default_deserializer (conv: detachable JSON_DESERIALIZER)
		do
			deserializer_context.set_default_deserializer (conv)
		end

feature -- Cleaning

	reset
			-- Clean temporary data if relevant.
		do
			serializer_context.reset
			deserializer_context.reset
		end

feature -- Element change

	register (a_serialization: JSON_SERIALIZATION_I; a_type: TYPE [detachable ANY])
		do
			if attached {JSON_SERIALIZER} a_serialization as s then
				serializer_context.register_serializer (s, a_type)
			end
			if attached {JSON_DESERIALIZER} a_serialization as d then
				deserializer_context.register_deserializer (d, a_type)
			end
		end

	set_default (a_serialization: detachable JSON_SERIALIZATION_I)
		do
			if a_serialization = Void then
				serializer_context.set_default_serializer (Void)
				deserializer_context.set_default_deserializer (Void)
			else
				if attached {JSON_SERIALIZER} a_serialization as s then
					serializer_context.set_default_serializer (s)
				end
				if attached {JSON_DESERIALIZER} a_serialization as d then
					deserializer_context.set_default_deserializer (d)
				end
			end
		end

note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
