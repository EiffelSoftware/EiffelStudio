note
	description: "JSON serializer."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JSON_SERIALIZER

inherit
	JSON_SERIALIZATION_I

feature -- Conversion

	append_to_json_string (obj: detachable ANY; ctx: detachable JSON_SERIALIZER_CONTEXT; a_json_string: STRING_GENERAL)
			-- Append JSON serialization of Eiffel value `obj' into `a_json_string', in the eventual context `ctx'.
		local
			vis: JSON_VISITOR
			j_value: like to_json
		do
			j_value := to_json (obj, ctx)
			if ctx = Void or else not ctx.is_pretty_printing then
				create {JSON_SERIALIZATION_VISITOR} vis.make (a_json_string)
			else
				create {JSON_PRETTY_STRING_VISITOR} vis.make (a_json_string)
			end
			j_value.accept (vis)
		end

	to_json_string (obj: detachable ANY; ctx: detachable JSON_SERIALIZER_CONTEXT): STRING
			-- JSON serialization of Eiffel value `obj' as json string, in the eventual context `ctx'.
		do
			create Result.make (0)
			append_to_json_string (obj, ctx, Result)
		end

	to_json (obj: detachable ANY; ctx: detachable JSON_SERIALIZER_CONTEXT): JSON_VALUE
			-- JSON value representing the JSON serialization of Eiffel value `obj', in the eventual context `ctx'.	
		deferred
		end

note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end
