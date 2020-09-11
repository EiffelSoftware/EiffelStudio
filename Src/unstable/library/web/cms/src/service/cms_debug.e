note
	description: "Collection of debugging purpose features."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_DEBUG

feature -- debugging purpose

	to_json (obj: detachable ANY): STRING
			-- Use with care, json representation of `obj`.
		local
			ser: JSON_REFLECTOR_SERIALIZER
			ctx: JSON_SERIALIZER_CONTEXT
		do
			create ser
			create ctx
			ctx.set_pretty_printing
			ctx.set_is_type_name_included (False)
			create Result.make_empty
			ser.append_to_json_string (obj, ctx, Result)
		ensure
			instance_free: class
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
