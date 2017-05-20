note
	description: "Summary description for {JSON_CUSTOMER_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_CUSTOMER_CONVERTER

inherit

	JSON_CONVERTER

create
	make

feature {NONE} -- Initialization

	make
		do

			create object.make ({STRING_32} "", {STRING_32} "")
		end

feature -- Access

	object: CUSTOMER

feature -- Conversion

	from_json (j: like to_json): detachable like object
		do
			if
				attached {STRING_32} json.object (j.item (name_key), Void) as l_name and
				attached {STRING_32} json.object (j.item (email_key), Void) as l_email
			then
				create Result.make (l_name, l_email)
			else
				check
					has_name: False
				end
				check
					has_email: False
				end
			end
		end

	to_json (o: like object): JSON_OBJECT
		do
			create Result.make
			Result.put (json.value (o.name), name_key)
			Result.put (json.value (o.email), email_key)
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
