note
	description: "Summary description for {JSON_CUSTOMER_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_CUSTOMER_CONVERTER

inherit
	JSON_SERIALIZER
	JSON_DESERIALIZER

feature -- Conversion

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			jo: JSON_OBJECT
		do
			if attached {CUSTOMER} obj as o then
				create jo.make
				jo.put_string (o.name, name_key)
				jo.put_string (o.email, email_key)
				Result := jo
			else
				create {JSON_NULL} Result
			end
		end

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable CUSTOMER
		do
			if attached {JSON_OBJECT} a_json as jo then
				if
					attached {JSON_STRING} jo.item (name_key) as l_name and
					attached {JSON_STRING} jo.item (email_key) as l_email
				then
					create Result.make (l_name.unescaped_string_32, l_email.unescaped_string_8)
				else
					check
						has_name: False
					end
					check
						has_email: False
					end
				end
			end
		end

feature {NONE} -- Implementation

	name_key: JSON_STRING
		once
			create Result.make_from_string ("name")
		end

	email_key: JSON_STRING
		once
			create Result.make_from_string ("email")
		end

end -- class JSON_CUSTOMER_CONVERTER
