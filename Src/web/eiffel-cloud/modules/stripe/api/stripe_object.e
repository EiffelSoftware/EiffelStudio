note
	description: "Summary description for {STRIPE_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	STRIPE_OBJECT

feature {NONE} -- Initialization

	make_empty
		do
			make_with_json (create {JSON_OBJECT}.make_empty)
		end

	make_with_json (j: like json)
		do
			json := j
		end

feature {NONE} -- Implementation

	string_8_item (j: JSON_OBJECT; k: READABLE_STRING_GENERAL): detachable STRING_8
		do
			if attached {JSON_STRING} (j @ k) as js then
				Result := js.unescaped_string_8
			end
		end

	string_32_item (j: JSON_OBJECT; k: READABLE_STRING_GENERAL): detachable STRING_32
		do
			if attached {JSON_STRING} (j @ k) as js then
				Result := js.unescaped_string_32
			end
		end

	safe_string_8_item (j: JSON_OBJECT; k: READABLE_STRING_GENERAL; dft: STRING_8): STRING_8
		do
			if attached {JSON_STRING} (j @ k) as js then
				Result := js.unescaped_string_8
			else
				Result := dft
			end
		end

	safe_string_32_item (j: JSON_OBJECT; k: READABLE_STRING_GENERAL; dft: STRING_32): STRING_32
		do
			if attached {JSON_STRING} (j @ k) as js then
				Result := js.unescaped_string_32
			else
				Result := dft
			end
		end

	json: JSON_OBJECT

	put_string (v: READABLE_STRING_GENERAL; k: READABLE_STRING_GENERAL)
		do
			json.put_string (v, k)
		end

feature -- Conversion

	to_string: STRING
		local
			jp: JSON_PRETTY_STRING_VISITOR
		do
			create Result.make (1_000)
			create jp.make (Result)
			jp.visit_json_object (json)
		end

end
