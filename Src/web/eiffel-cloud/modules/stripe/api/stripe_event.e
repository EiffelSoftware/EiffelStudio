note
	description: "Summary description for {STRIPE_EVENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_EVENT

inherit
	STRIPE_OBJECT
		redefine
			make_with_json
		end

create
	make_with_json

feature {NONE} -- Initialization

	make_with_json (j: like json)
		do
			type := "undefined-type"
			Precursor (j)

			if not j.is_empty then
				id := safe_string_8_item (j, "id", id)
				type := safe_string_8_item (j, "type", type)

				check attached string_8_item (j, "object") as obj and then obj.is_case_insensitive_equal ("event") end

				data := j.item ("data")

				api_version := string_8_item (j, "api_version")

				creation_timestamp := integer_32_item (j, "created")

			end
		end

feature -- Access

	type: READABLE_STRING_8

	api_version: detachable READABLE_STRING_8

	creation_timestamp: INTEGER_32

	data: detachable JSON_VALUE
			-- Data as JSON content

end
