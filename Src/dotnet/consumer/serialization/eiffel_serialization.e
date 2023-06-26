note
	description: "[
			Objects that centralize the Cache/consumer serialization access.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_SERIALIZATION

inherit
	EIFFEL_LAYOUT

feature -- Status report	

	use_json_storage: BOOLEAN
			-- Use JSON for metadata consumer cache storage?
		do
			if is_eiffel_layout_defined then
				Result := eiffel_layout.use_json_dotnet_md_cache
			else
				Result := settings.use_json
			end
			Result := settings.use_json
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

feature -- Serialization

	deserializer (il_runtime: STRING_32): EIFFEL_DESERIALIZER
			-- Eiffel md consumer deserializer.
		do
			if
				use_json_storage
				or (create {IL_NETCORE_DETECTOR}).is_il_netcore (il_runtime)
			then
				create {EIFFEL_JSON_DESERIALIZER} Result
			else
				create {EIFFEL_SED_DESERIALIZER} Result
			end
		ensure
			class
		end

	serializer: EIFFEL_SERIALIZER
			-- Eiffel md consumer serializer.	
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
			--
		do
			serializer.serialize (a, path, is_appending)
		ensure
			class
		end

feature -- Settings change

	set_use_json_storage (b: BOOLEAN)
			-- Set `use_json_storage` to `b`.
		do
			if is_eiffel_layout_defined then
				eiffel_layout.set_use_json_dotnet_md_cache (b, False)
			else
				settings.use_json := b
			end
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
			Result := [False, False]
			if is_eiffel_layout_defined then
				Result.use_json := eiffel_layout.use_json_dotnet_md_cache
			end
			if
				attached (create {EXECUTION_ENVIRONMENT}).item("ISE_EMDC_JSON") as v and then
						v.is_case_insensitive_equal ("long")
			then
				Result.use_long_names := True
			end
		ensure
			class
		end

end
