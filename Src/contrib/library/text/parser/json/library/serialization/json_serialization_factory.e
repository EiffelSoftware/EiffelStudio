note
	description: "Summary description for {JSON_SERIALIZATION_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	JSON_SERIALIZATION_FACTORY

feature -- Factory

	serialization: JSON_SERIALIZATION
			-- Simple empty serialization.
			-- It requires either custom (de)serializers or reflector based solution.	
		do
			create Result
		end

	reflector_serialization: JSON_SERIALIZATION
		do
			Result := serialization
			Result.register_default (create {JSON_REFLECTOR_SERIALIZATION})
		end

	smart_serialization: JSON_SERIALIZATION
			-- Serialization based on reflector, but with specific handling of ITERABLE, LIST and TABLE objects.
		do
			Result := reflector_serialization

				-- Serializers
			Result.register (create {TABLE_ITERABLE_JSON_SERIALIZER [detachable ANY, READABLE_STRING_GENERAL]}, {TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL]})
			Result.register (create {ITERABLE_JSON_SERIALIZER [detachable ANY]}, {ITERABLE [detachable ANY]})
				-- Deserializers
			Result.register (create {TABLE_JSON_DESERIALIZER [detachable ANY]}, {TABLE [detachable ANY, READABLE_STRING_GENERAL]})
			Result.register (create {LIST_JSON_DESERIALIZER [detachable ANY]}, {LIST [detachable ANY]})
		end

note
	copyright: "2010-2016, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
