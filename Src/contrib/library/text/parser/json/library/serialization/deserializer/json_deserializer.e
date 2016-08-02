note
	description: "JSON deserializer."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JSON_DESERIALIZER

inherit
	JSON_SERIALIZATION_I

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable ANY
			-- Eiffel value deserialized from `a_json' value, in the eventual context `ctx'.
		deferred
		end

	from_json_string (a_json_string: READABLE_STRING_8; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable ANY
			-- Eiffel value deserialized from `a_json' content string, in the eventual context `ctx'.	
		local
			p: JSON_PARSER
		do
			create p.make_with_string (a_json_string)
			p.parse_content
			if
				p.is_parsed and then p.is_valid
			then
				Result := from_json (p.parsed_json_value, ctx, a_type)
			end
		end

note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
