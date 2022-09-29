note
	description: "[
			Objects that centralize the Cache/consumer serialization access.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_SERIALIZATION

feature -- Settings

	use_long_json_names: BOOLEAN
			-- Use long JSON names in JSON content.
			-- See {CONSUMED_OBJECT_JSON_*_NAMES}
		once
			Result := attached (create {EXECUTION_ENVIRONMENT}).item("ISE_EMDC_JSON") as var and then var.is_case_insensitive_equal ("long")
		ensure
			class
		end

	is_json_storage: BOOLEAN
			-- Use JSON for metadata consumer cache storage?
		once
			Result := attached (create {EXECUTION_ENVIRONMENT}).item("ISE_EMDC_JSON") as var and then
					var.count > 0 and then
					not var.is_case_insensitive_equal ("false")
		ensure
			class
		end

feature -- Serialization

	deserializer: EIFFEL_DESERIALIZER
		do
			if is_json_storage then
				create {EIFFEL_JSON_DESERIALIZER} Result
			else
				create {EIFFEL_SED_DESERIALIZER} Result
			end
		ensure
			class
		end

	serializer: EIFFEL_SERIALIZER
		do
			if is_json_storage then
				create {EIFFEL_JSON_SERIALIZER} Result
			else
				create {EIFFEL_SED_SERIALIZER} Result
			end
		ensure
			class
		end

	serialize (a: ANY; path: READABLE_STRING_GENERAL; is_appending: BOOLEAN)
		do
			serializer.serialize (a, path, is_appending)
		ensure
			class
		end

end
