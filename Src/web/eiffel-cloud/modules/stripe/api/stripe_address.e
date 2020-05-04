note
	description: "[
		Summary description for {STRIPE_ADDRESS}.

			See also: https://stripe.com/docs/api/customers/object
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_ADDRESS

inherit
	STRIPE_OBJECT
		redefine
			make_with_json
		end

create
	make_empty,
	make_with_json

feature {NONE} -- Initialization

	make_with_json (j: like json)
		do
			Precursor (j)

			if not j.is_empty then
				line1 := string_32_item (j, "line1")
				line2 := string_32_item (j, "line2")
				city := string_32_item (j, "city")
				postal_code := string_32_item (j, "postal_code")
				state := string_32_item (j, "state")
				country := string_32_item (j, "country")
			end
		end

feature -- Access

	line1: detachable READABLE_STRING_32
	line2: detachable READABLE_STRING_32
	city: detachable READABLE_STRING_32
	postal_code: detachable READABLE_STRING_32
	state: detachable READABLE_STRING_32
	country: detachable READABLE_STRING_32

feature -- Element change

	set_line1 (v: READABLE_STRING_GENERAL)
		do
			line1 := v.to_string_32
		end
	set_line2 (v: READABLE_STRING_GENERAL)
		do
			line2 := v.to_string_32
		end
	set_city (v: READABLE_STRING_GENERAL)
		do
			city := v.to_string_32
		end
	set_postal_code (v: READABLE_STRING_GENERAL)
		do
			postal_code := v.to_string_32
		end
	set_state (v: READABLE_STRING_GENERAL)
		do
			state := v.to_string_32
		end
	set_country (v: READABLE_STRING_GENERAL)
		do
			country := v.to_string_32
		end

end

