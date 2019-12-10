note
	description: "Summary description for {BILLING_DETAILS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BILLING_DETAILS

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

			email := string_8_item (j, "email")
			name := string_32_item (j, "name")
		end

feature -- Access

	email: detachable READABLE_STRING_8

	name: detachable READABLE_STRING_32


end
