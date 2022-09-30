note
	description: "[
			Objects that centralize the Cache/consumer serialization access.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_SERIALIZATION

feature -- Settings change

	set_use_json_storage (b: BOOLEAN)
			-- Set `use_json_storage` to `b`.
		do
			settings.use_json := b
			if b then
				settings.use_long_names := attached (create {EXECUTION_ENVIRONMENT}).item("ISE_EMDC_JSON") as v and then
						v.is_case_insensitive_equal ("long")
			end
		ensure
			class
		end

feature -- Settings

	settings: TUPLE [use_json, use_long_names: BOOLEAN]
		once
			if attached (create {EXECUTION_ENVIRONMENT}).item("ISE_EMDC_JSON") as var and then
					var.count > 0 and then
					not var.is_case_insensitive_equal ("false")
			then
				Result := [
					True, -- Use JSON storage
					attached (create {EXECUTION_ENVIRONMENT}).item("ISE_EMDC_JSON") as v and then
							v.is_case_insensitive_equal ("long")
				]
			else
				Result := [False, False]
			end
		ensure
			class
		end

	use_long_json_names: BOOLEAN
			-- Use long JSON names in JSON content.
			-- See {CONSUMED_OBJECT_JSON_*_NAMES}
		do
			Result := settings.use_long_names
		ensure
			class
		end

	use_json_storage: BOOLEAN
			-- Use JSON for metadata consumer cache storage?
		once
			Result := settings.use_json
		ensure
			class
		end

feature -- Serialization

	deserializer: EIFFEL_DESERIALIZER
		do
			if use_json_storage then
				create {EIFFEL_JSON_DESERIALIZER} Result
			else
				create {EIFFEL_SED_DESERIALIZER} Result
			end
		ensure
			class
		end

	serializer: EIFFEL_SERIALIZER
		do
			if use_json_storage then
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
