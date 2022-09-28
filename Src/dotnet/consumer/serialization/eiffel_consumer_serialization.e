note
	description: "Summary description for {EIFFEL_CONSUMER_SERIALIZATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_CONSUMER_SERIALIZATION

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
			Result := attached (create {EXECUTION_ENVIRONMENT}).item("ISE_EMDC_JSON") as var and then var.count > 0
		ensure
			class
		end

end
