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

feature -- Conversion

	to_string: STRING_32
		do
			create Result.make (50)
			if attached line1 as l_line1 then
				Result.append (l_line1)
				Result.append_character ('%N')
			end
			if attached line2 as l_line2 then
				Result.append (l_line2)
				Result.append_character ('%N')
			end
			if attached postal_code as l_postal_code then
				Result.append (l_postal_code)
				Result.append_character (' ')
			end
			if attached city as l_city then
				Result.append (l_city)
			end
			Result.append_character ('%N')
			if attached state as l_state then
				Result.append_character ('(')
				Result.append (l_state)
				Result.append_character (')')
				Result.append_character (' ')
			end
			if attached country as l_country then
				Result.append (l_country)
			end

		end

end

